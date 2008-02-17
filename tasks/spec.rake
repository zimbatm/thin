CLEAN.include %w(coverage tmp log)

if RUBY_1_9
  task :spec do
    warn 'RSpec not yet supporting Ruby 1.9, so cannot run the specs :('
  end
else
  # RSpec not yet working w/ Ruby 1.9
  require 'spec/rake/spectask'
  
  desc "Run all examples"
  Spec::Rake::SpecTask.new('spec') do |t|
    t.spec_files = FileList['spec/**/*_spec.rb']
    if WIN
      t.spec_files -= [
          'spec/connectors/unix_server_spec.rb',
          'spec/controllers/service_spec.rb',
          'spec/daemonizing_spec.rb',
          'spec/server/unix_socket_spec.rb',
          'spec/server/swiftiply_spec.rb'
          ]
    end
  end
  
  task :check_spec_gems do
    begin
      require 'spec'
      require 'benchmark_unit'
    rescue LoadError
      abort "To run specs, install rspec and benchmark_unit gems"
    end
  end
  
  task :spec => [:check_spec_gems, :compile]
end