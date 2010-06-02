From: Jakub Narebski <jnareb@gmail.com>
Subject: About [PATCH] gitweb: Create a perl module to store gitweb configuration
Date: Wed, 2 Jun 2010 22:29:30 +0200
Message-ID: <201006022229.31593.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 22:29:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJuZQ-0006jS-TN
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 22:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932776Ab0FBU3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 16:29:43 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47926 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758591Ab0FBU3m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 16:29:42 -0400
Received: by bwz11 with SMTP id 11so474227bwz.19
        for <git@vger.kernel.org>; Wed, 02 Jun 2010 13:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=rj3ivm8qqtgSvvb/Mu9qAZlEQeUJPJm7b0ZGyvWDzN4=;
        b=kajLWgEAG1oqulWDaR0PCcr2H/rR71+jQxRbUw2I1A9stJ0mTxl9nLDKSpyKOJJuQN
         dc85YCRnp8NhOPsp6yEihCvEWp7CCBAP2AFyLtP1TGY3rBmVMbNUpirus8FOeyZ9bJoS
         7wQWZ4CSE5+hEZOtPZ5cWPw7vTsLuCZAitmEg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=jB5p7CWuPTxBI4Lpj+RJ+650xh78mqqL+tBGybsoK6t41ynFBZ/rOsNLHE+A+oCtNC
         4ITsFvFP6XY94yCl3pJTvRyzq2AeljDwDxi08uebib2npRx1GYKCiSKtO/eyKeNDbkpf
         RrG44iglcYRwMVkHxCWJDp3cqzkT1iq18B5PY=
Received: by 10.204.83.2 with SMTP id d2mr2139878bkl.110.1275510578872;
        Wed, 02 Jun 2010 13:29:38 -0700 (PDT)
Received: from [192.168.1.15] (abuz37.neoplus.adsl.tpnet.pl [83.8.197.37])
        by mx.google.com with ESMTPS id z7sm9698080bkx.23.2010.06.02.13.29.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Jun 2010 13:29:37 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148271>

This comment is about commit 9526ab8 (gitweb: Create a perl module to
store gitweb configuration, 2010-06-01) on 'master' branch of
repository shown at http://repo.or.cz/w/git/gsoc2010-gitweb.git

> From 9526ab8a12c8d4d875d08a6201c7eca963c7d9aa Mon Sep 17 00:00:00 2001
> From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
> Date: Tue, 1 Jun 2010 02:36:48 +0530
> Subject: [PATCH] gitweb: Create a perl module to store gitweb configuration

I would probably say

  Subject: [PATCH] gitweb: Create Gitweb::Config module to store gitweb configuration

or even

  Subject: [PATCH] gitweb: Create Gitweb::Config module

so that _name_ of this module is in commit subject (summary).

> 
> Create a perl module in path gitweb/lib/Gitweb/Config.pm
> to store all the configuration variables of the gitweb.perl
> script and change the scope of those variables in main script.

A bit overlong sentence, isn't it?  Perhaps

  Create a Gitweb::Config module in 'gitweb/lib/Gitweb/Config.pm'
  to store all the configuration variables of the gitweb.perl
  script.

(Assuming that I can convince you to avoid fully qualified names).

> 
> Move subroutine evaluate_gitweb_config() into the same module
> so that the statement 'do GITWEB_CONFIG' or 'do GITWEB_CONFIG_SYSTEM'
> works similiar to the working before the split.

s/similiar/similar/

I agree that you should list which subroutines you do move to
Gitweb::Config package, though this list would be probably longer that
the evaluate_gitweb_config() alone... or perhaps not.

But I do not understand the statement about "do $GITWEB_CONFIG"
etc. here.  Did you wanted to say that setting $GITWEB_CONFIG etc. was
moved out of evaluate_gitweb_config(), and is left in gitweb.perl?

> 
> Change Makefile accordingly to install the Perl Module.

I would say:

  Update gitweb/Makefile to install gitweb modules alongside gitweb.

Or something like that.

> 
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
> ---

When sending this patch to git mailing list you should mention that it
is based on
  gitweb: Put all per-connection code in run() subroutine
and perhaps also on
  gitweb: Add support for FastCGI, using CGI::Fast
unless those two commits made it into 'master' till then.

>  gitweb/Makefile             |    6 +
>  gitweb/gitweb.perl          |  692 ++++++++++---------------------------------
>  gitweb/lib/Gitweb/Config.pm |  389 ++++++++++++++++++++++++
>  3 files changed, 558 insertions(+), 529 deletions(-)
>  create mode 100644 gitweb/lib/Gitweb/Config.pm
> 
> diff --git a/gitweb/Makefile b/gitweb/Makefile
> index d2584fe..45e176e 100644
> --- a/gitweb/Makefile
> +++ b/gitweb/Makefile
> @@ -55,6 +55,7 @@ PERL_PATH  ?= /usr/bin/perl
>  bindir_SQ = $(subst ','\'',$(bindir))#'
>  gitwebdir_SQ = $(subst ','\'',$(gitwebdir))#'
>  gitwebstaticdir_SQ = $(subst ','\'',$(gitwebdir)/static)#'
> +gitweblibdir_SQ = $(subst ','\'',$(gitwebdir)/lib)#'

I think it would be good idea to have 'gitweblibdir' as a separate
variable, alongside 'gitwebdir', and which would default to

   gitweblibdir = $(gitwebdir)/lib

to make it possible to install gitweb modules not alongside gitweb,
but somewhere else, for example together with other Perl modules.

Then you would have:

  +gitweblibdir_SQ = $(subst ','\'',$(gitweblibdir))#'

But I think this change can be left for a separate commit.  It is not
something terribly important, something blocking accepting the patch.


BTW. did you start working on the 'write' part yet, at least on the
conceptual (specification / architecture) level?

>  SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))#'
>  PERL_PATH_SQ  = $(subst ','\'',$(PERL_PATH))#'
>  DESTDIR_SQ    = $(subst ','\'',$(DESTDIR))#'
> @@ -110,6 +111,9 @@ endif
>  
>  GITWEB_FILES += static/git-logo.png static/git-favicon.png
>  
> +# Files: gitweb/lib/Gitweb
> +GITWEB_LIB_GITWEB += lib/Gitweb/Config.pm
> +
>  GITWEB_REPLACE = \
>  	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
>  	-e 's|++GIT_BINDIR++|$(bindir)|g' \
> @@ -150,6 +154,8 @@ install: all
>  	$(INSTALL) -m 755 $(GITWEB_PROGRAMS) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
>  	$(INSTALL) -m 644 $(GITWEB_FILES) '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
> +	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitweblibdir_SQ)/Gitweb'
> +	$(INSTALL) -m 644 $(GITWEB_LIB_GITWEB) '$(DESTDIR_SQ)$(gitweblibdir_SQ)/Gitweb'

Uhhh... this would probably get more complicated *if* there would be
more complicated hierarchy, e.g. if there would be Gitweb module in
lib/Gitweb.pm.  I guess that is the reason behind $(GITWEB_LIB_GITWEB)
name, isn't it?

>  
>  ### Cleaning rules
>  
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 673e7a3..98a85f4 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -16,19 +16,22 @@ use Encode;
>  use Fcntl ':mode';
>  use File::Find qw();
>  use File::Basename qw(basename);
> +use File::Spec;
>  binmode STDOUT, ':utf8';
> 

The fragment below was slightly edited to make it more clear.

> -our $t0;
> -if (eval { require Time::HiRes; 1; }) {
> -	$t0 = [Time::HiRes::gettimeofday()];
> -}
> -our $number_of_git_cmds = 0;

Theoretically neither $t0 nor $number_of_git_cmds belong to
Gitweb::Config, as those are about runtime timing, not about gitweb
configuration.

But perhaps for the time being you can put it in Gitweb::Config.

> +# __DIR__ is taken from Dir::Self __DIR__ fragment
> +sub __DIR__ () {
> +	File::Spec->rel2abs(join '', (File::Spec->splitpath(__FILE__))[0, 1]);
> +}
> +use lib __DIR__ . "/lib";
> +
> +use Gitweb::Config;

O.K.

It's a pity that Dir::Self is not a core Perl module since Perl 5.8,
and that FindBin which is in core since 5.4 has its quirks and
nowadays is not recommended to use...

>  
>  BEGIN {
>  	CGI->compile() if $ENV{'MOD_PERL'};
>  }
>  
> -our $version = "++GIT_VERSION++";
> +$Gitweb::Config::version = "++GIT_VERSION++";

If '$version' was exported by Gitweb::Config this change would be not
necessary.

I would remove all such changes from discussion of this patch.

> -# URI and label (title) of GIT logo link
> -#our $logo_url = "http://www.kernel.org/pub/software/scm/git/docs/";
> -#our $logo_label = "git documentation";
> -our $logo_url = "http://git-scm.com/";
> -our $logo_label = "git homepage";

All right, those variables that do not need initialization using
build-time substitutions are put together with their description in
Gitweb::Config.

I would remove all such changes from discussion of this patch.

>  sub gitweb_get_feature {
>  	my ($name) = @_;
[...]

I wonder if this subroutine, and its companion 'gitweb_check_feature'
should be not moved to Gitweb::Config module.

> -our ($GITWEB_CONFIG, $GITWEB_CONFIG_SYSTEM);
> +our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
> +our $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITWEB_CONFIG_SYSTEM++";

This would probably look like this, because $GITWEB_CONFIG must be set
in gitweb.perl -> gitweb.cgi, and not in Gitweb::Config, where
evaluate_gitweb_config() would be.

> -sub evaluate_gitweb_config {
> -	our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
> -	our $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITWEB_CONFIG_SYSTEM++";
> -	# die if there are errors parsing config file
> -	if (-e $GITWEB_CONFIG) {
> -		do $GITWEB_CONFIG;
> -		die $@ if $@;
> -	} elsif (-e $GITWEB_CONFIG_SYSTEM) {
> -		do $GITWEB_CONFIG_SYSTEM;
> -		die $@ if $@;
> -	}
> -}

Right, this got moved to Gitweb::Config.

> -our ($action, $project, $file_name, $file_parent, $hash, $hash_parent, $hash_base,
> -     $hash_parent_base, @extra_options, $page, $searchtype, $search_use_regexp,
> -     $searchtext, $search_regexp);
>  sub evaluate_and_validate_params {
>  	our $action = $input_params{'action'};
>  	if (defined $action) {

Hmmm... it looks like those got also moved to Gitweb::Config, even if
those variables have nothing to do with gitweb configuration, but are
about request, and therefore belong to Gitweb::Request.  Thus this
commit should probably not touch this.

> @@ -963,10 +602,8 @@ sub evaluate_and_validate_params {
>  	}
>  }
>  
> -# path to the current git repository
> -our $git_dir;
>  sub evaluate_git_dir {
>  	our $git_dir = "$projectroot/$project" if $project;
>  }

Same with $git_dir -- it is request dependent, not configuration
dependent.

[very large cut, not necessary with exporting variables]

> diff --git a/gitweb/lib/Gitweb/Config.pm b/gitweb/lib/Gitweb/Config.pm
> new file mode 100644
> index 0000000..e1bd06f
> --- /dev/null
> +++ b/gitweb/lib/Gitweb/Config.pm
> @@ -0,0 +1,389 @@
> +#!/usr/bin/perl
> +#
> +# Gitweb::Config -- gitweb configuration package
> +#
> +# This program is licensed under the GPLv2
> +
> +package Gitweb::Config;
> +
> +use strict;
> +
> +BEGIN {
> +	use Exporter();
> +
> +	@Gitweb::Config::ISA = qw(Exporter);	
                                            ^^^^

Trailing whitespace.  Didn't git warn you about this?

> +	@Gitweb::Config::EXPORT = qw();
> +}

Why BEGIN block?  Why 'use Exporter();' and not 'use Exporter;'?

Why not

   use Exporter;
   use base 'Exporter';

or even

   use Exporter qw(import);

(we can use the last version, because gitweb requires high enough Perl
version itself, so that this form can be used).

> +
> +our $t0;
> +if (eval { require Time::HiRes; 1; }) {
> +	$t0 = [Time::HiRes::gettimeofday()];
> +}
> +our $number_of_git_cmds = 0;

This does not strictly speaking belong in Gitweb::Config, and probably
neither in Gitweb::Request, but Gitweb::request is a better place for
it.

Never-mind, we can move it later.

> +

Here it would be good place for comment that those are variables that
are affected by build-time configuration, and therefore their
initialization is put in gitweb.perl (together with comments with
their description).

> +our ($GIT, $version, $git_version);
> +our ($projectroot, $project_maxdepth, $projects_list, @git_base_url_list);
> +our ($export_ok, $strict_export);
> +our ($home_link_str, $site_name, $site_header, $site_footer, $home_text);
> +our (@stylesheets, $stylesheet, $logo, $favicon, $javascript);
> +our ($GITWEB_CONFIG, $GITWEB_CONFIG_SYSTEM);
> +
> +# URI and label (title) of GIT logo link
> +#our $logo_url = "http://www.kernel.org/pub/software/scm/git/docs/";
> +#our $logo_label = "git documentation";
> +our $logo_url = "http://git-scm.com/";
> +our $logo_label = "git homepage";

[cut]

Nothing especially interesting here.  'git blame -C -C' should detect
code movement.

> +
> +sub evaluate_gitweb_config {
> +	# die if there are errors parsing config file
> +	if (-e $GITWEB_CONFIG) {
> +		do $GITWEB_CONFIG;
> +		die $@ if $@;
> +	} elsif (-e $GITWEB_CONFIG_SYSTEM) {
> +		do $GITWEB_CONFIG_SYSTEM;
> +		die $@ if $@;
> +	}
> +}

Here the question is if this would affect interpretation of
$GITWEB_CONFIG etc. if it is a relative path.  Perhaps nothing will
change, because paths are relative to the directory the script is run,
not relative to where module resides.

Not that is matter much either way, as at most it would require
stating in gitweb/README that one should use absolute pathnames.

Note that tests use absolute pathname, so passing test does not answer
this.

> +
> +1;

O.K.

Good work!
-- 
Jakub Narebski
Poland
