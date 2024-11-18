---SQL Retail Sales Analysis - P1---

-- Craeting Table ---
drop table if exists retail_sales;
create table retail_sales 
(
				transactions_id	int primary key,
				sale_date date,
				sale_time time,
				customer_id int,
				gender varchar(15),
				age int,
				category varchar(15),	
				quantiy int,
				price_per_unit float,	
				cogs float,
				total_sale float
);
select * from retail_sales
limit 100;
--Data Cleaning ----check for null value--
select * from retail_sales
where 
	transactions_id is null
	or 
	sale_date is null
	or 
	sale_time is null
	or
	customer_id is null
	or
	gender is null
	or
	age is null
	or
	category is null
	or
	quantiy is null
	or
	price_per_unit is null
	or
	cogs is null
	or 
	total_sale is null;

delete from retail_sales
where 
	transactions_id is null
	or 
	sale_date is null
	or 
	sale_time is null
	or
	customer_id is null
	or
	gender is null
	or
	age is null
	or
	category is null
	or
	quantiy is null
	or
	price_per_unit is null
	or
	cogs is null
	or 
	total_sale is null;

-- Data Exploration
-- How many sales  we have?
select count(*) as totalsales from retail_sales

--How many unique customers we have

select count(distinct customer_id) from retail_sales

--How many category we have
select * from retail_sales

Select distinct(category) as categories from retail_sales

-- Data Analysis & Business Key Problems & Answers
-- Q1. Write a SQL query to retrieve all columns for sales made on '2022-11-05'
-- Q2. Write a SQL query to retrieve all transactions where the category is 'clothing' & the quantity sold is more than 10 in the month of nov -2022?
-- Q3. Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q5. Write a SQL query to find all transactions where the total_sale is grater than 1000.
-- Q6. Write a SQL query to find the total number of transaction (transaction_id) made by each gender in each category.
-- Q7. Write a SQL query to calculate the average sale for each month. find out best selling month in each year.
-- Q8. Write a SQL query to find the top 5 customers based on the highest total sales.
-- Q9. Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q10. Write a SQL query to create each shift & number of orders (Example Morning <=12, Afternoon Between 12&17, Evening >17)

-- Ans 1 --
select * from retail_sales
where sale_date = '2022-11-05';

-- Q2. Write a SQL query to retrieve all transactions where the category is 'clothing' & the quantity sold is more than 4 in the month of nov -2022?--
select * from retail_sales
where category = 'Clothing'
		and sale_date between '2022-11-01' and '2022-11-30'
		and quantiy >=4
-- Q3. Write a SQL query to calculate the total sales (total_sale) for each category.
select  category, 
		sum(total_sale) as Sales,
		count(*) as Total_orders
		from retail_sales
group by category;

-- Q4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select 
	round(avg(age),2) as Average_age 
	from retail_sales
where category = 'Beauty'

-- Q5. Write a SQL query to find all transactions where the total_sale is grater than 1000.
select * from retail_sales
where total_sale > 1000

-- Q6. Write a SQL query to find the total number of transaction (transaction_id) made by each gender in each category.
select 
	category,
	gender, 
	count (distinct transactions_id) 
from retail_sales
group by 
	category, 
	gender;

-- Q7. Write a SQL query to calculate the average sale for each month. find out best selling month in each year.
select 
	year,
	month,
	average
from 
(
	select 
		extract (year from sale_date) as year,
		extract (month from sale_date) as month,
		avg(total_sale) as Average,
		RANK() over(partition by extract (year from sale_date) order by avg(total_sale) desc) AS rank
	from retail_sales
	group by 
		year,
		month
) as t1
where rank=1 

-- Q8. Write a SQL query to find the top 5 customers based on the highest total sales.

select 
	customer_id, 
	sum(total_sale) as highest_sale 
from retail_sales
group by customer_id
order by highest_sale desc limit 5;

-- Q9. Write a SQL query to find the number of unique customers who purchased items from each category.
select * from retail_sales

select 
		category,
		count (distinct customer_id  ) as Distinct_Customers
from retail_sales
Group by category

-- Q10. Write a SQL query to create each shift & number of orders (Example Morning <=12, Afternoon Between 12&17, Evening >17)

select count (*) as Orders,
case 
	when extract (hour from sale_time) < 12 then 'Morning'
	when extract (hour from sale_time) between 12 and 17 then 'Afternoon'
	else 'Evening'
end as shift
from retail_sales
group by shift
	
-- End of Project
-- PRINCE	



