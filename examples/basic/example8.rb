  
require 'ruby_sandbox'

module SandboxModule
end

class X
  def foo
    print "X#foo\n"
  end
end

RubySandbox::Sandbox.new.run("
  class ::X
  	def foo
  		print \"foo defined inside the sandbox\\n\"
  	end
  end
  ", RubySandbox::Whitelist.allow_method(:print), base_namespace: SandboxModule)

x = X.new # X class is not affected by the sandbox (The X Class defined in the sandbox is SandboxModule::X)
x.foo

x = SandboxModule::X.new
x.foo
