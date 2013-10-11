require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

require 'typhoeus'
require 'json'

db = SQLite3::Database.new('books.sqlite3')

get '/' do
  # redirect to form to get movie
  sql = "select * from books where id > (select max(id) from books) - 4;"
  @results = db.execute(sql)

  erb :form
end

post '/write' do
  @title = params[:title]
  @author = params[:author]
  @review = params[:review]

  sql = "insert into books( title, author, review) values ('#{@title.gsub("'","''")}', '#{@author.gsub("'","''")}', '#{@review.gsub("'","''")}')"
  db.execute(sql)

  redirect '/'
end