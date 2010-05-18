From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH GSoC 2/3] git-instaweb: Configure it to work with a global server root and projects list
Date: Tue, 18 May 2010 06:33:00 -0700 (PDT)
Message-ID: <m3ljbhcp46.fsf@localhost.localdomain>
References: <1273953520-25990-1-git-send-email-pavan.sss1991@gmail.com>
	<1273953520-25990-2-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 18 15:33:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEMv4-0001ZQ-GO
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 15:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757483Ab0ERNdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 09:33:08 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:45290 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756706Ab0ERNdF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 May 2010 09:33:05 -0400
Received: by fg-out-1718.google.com with SMTP id d23so3248237fga.1
        for <git@vger.kernel.org>; Tue, 18 May 2010 06:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=WIhjnXxA7MLliDVYOPaJhmluSifOgbMScv14fDAWD+w=;
        b=XB/DZaqO8twOlF1JoludVJj6jOXtqvFy+7Elv0gBib51FdNPZKlHBLs5rnqKhYN+be
         /dZ4u2kK+SaKo/oc8l6ckqvaqxT7u5nO3Z6HuhCM3p9X30fFQfgJ9ECQs56CWAx/+EGR
         tQaF9YU3nDTtUZ/TQggtsrfNmMJh2AeXKMwPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=TItKV5iDVjPe6bWudsqHVbnubmTsbgolkgNfZwge0RRk4etQPAGQLTVqQz55FWsG2M
         eZ9u8cAFFqp+XJd1T/zGsEYvD7lVJVgnnOQHnukeNrk8tTYH/Fi3//bZke+oKfk8p/H4
         PtdxBgVbTnakva7g9oYNyVoTKhm6JqHKBU2Vc=
Received: by 10.86.126.33 with SMTP id y33mr10847817fgc.51.1274189583162;
        Tue, 18 May 2010 06:33:03 -0700 (PDT)
Received: from localhost.localdomain (abvv101.neoplus.adsl.tpnet.pl [83.8.219.101])
        by mx.google.com with ESMTPS id d8sm15609154fga.11.2010.05.18.06.32.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 May 2010 06:33:00 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o4IDWRhD022010;
	Tue, 18 May 2010 15:32:37 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o4IDWALS022006;
	Tue, 18 May 2010 15:32:10 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1273953520-25990-2-git-send-email-pavan.sss1991@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147281>

Cc-ed to Eric Wond, main author and maintainer of git-instaweb.

Pavan Kumar Sunkara <pavan.sss1991@gmail.com> writes:

> git-instaweb in its current form (re)creates gitweb.cgi and
> (some of) required static files in $GIT_DIR/gitweb/ directory for
> each repository it is ran. Splitting gitweb would make it difficult
> for git-instaweb to continue with this method.

I agree with that.

(By the way, I really like this paragraph of commit mesage, which is
introduction to a commit, describing current situation and problems
with it.)

> 
> Use the instaweb.root config variable to point git-instaweb script
> to a global directory which contains gitweb files as server root

A nitpick about style of grammar of this commit message: there should
be fullstop here, ending sentence.

While I can agree with `instaweb.root' config variable to *override*
the default, it should have sane default, and setting it should be not
required to be able to run git-instaweb.  Therefore the 'install'
target of main Makefile should either:
a.) install gitweb into gitdir=$(sharedir)/gitweb, and make 
    instaweb.root be $(sharedir)/gitweb by default
b.) install gitweb into $(gitwebdir), which only have $(sharedir)/gitweb
    as default, and embed $(gitwebdir) in git-instaweb script when 
    building, so that it would be default value of instaweb.root

This would probably mean replacing either @@sharedir@@ or @@gitwebdir@@
placeholders in git-instaweb.sh when building git-instaweb.

> and the httpd.conf along with server logs and pid go into
> '$(HOME)/.gitweb' directory.
> 
> As there is no need to call git-instaweb in every git repository,
> configure gitweb to get $projects_list from file '$(HOME)/.gitweb/list'
> and $projectroot is ''
> 
> Example of ~/.gitweb/list:
> home%2Fpavan%2Fgit%2F.git Linus+Torvalds
> home%2Fpavan%2Fgsoc%2F.git Pavan+Kumar+Sunkara

This is quite a large change on how git-instaweb works.

First, I think such change should be better left for a separate
commit, splitting this one in two: one making git-instaweb use
installed gitweb files, and installing gitweb files somewhere when
installing git, and second changing how git-instaweb behave.
"Do one thing, and do it well."  It would make easier to check
if there are errors in the commit.

Second, in my opinion it is not a good change at all.  Currently you
can run "git instaweb" when inside git repository, and get a web
browser (or a new tab in existing session of a running web browser)
with current repository in it, to browse its history.  It is similar
to running gitk (or other graphical history browser, like qgit, tig,
etc.), or running "git log", but with web interface.

Now, current git-instaweb behavior has its quirks, but having
git-instaweb show _current_ repository is a very important feature,
and I'd rather we didn't lose it in transition.

So in my opinion it would be better to just update git-instaweb and
generating git-instaweb to make use of installed gitweb and installed
gitweb files, but do not change organization of generated files; just
instead of gitweb.cgi there should be gitweb_config.perl with
appropriate configuration to show current repository.  And of course
there would be no gitweb files in $GIT_DIR/gitweb (in .git/gitweb)
directory.

> 
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
> ---
>  Makefile        |    9 +----
>  git-instaweb.sh |  100 ++++++++++++++++++-------------------------------------
>  2 files changed, 34 insertions(+), 75 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index caf2f64..1e9fb77 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1592,15 +1592,7 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/static/gitweb.css gitweb/
>  	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
>  	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
>  	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
> -	    -e '/@@GITWEB_CGI@@/r gitweb/gitweb.cgi' \
> -	    -e '/@@GITWEB_CGI@@/d' \
> -	    -e '/@@GITWEB_CSS@@/r $(GITWEB_CSS)' \
> -	    -e '/@@GITWEB_CSS@@/d' \
> -	    -e '/@@GITWEB_JS@@/r $(GITWEB_JS)' \
> -	    -e '/@@GITWEB_JS@@/d' \
>  	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \

Good to leave this change.

> -            -e 's|@@GITWEB_CSS_NAME@@|$(GITWEB_CSS)|' \
> -            -e 's|@@GITWEB_JS_NAME@@|$(GITWEB_JS)|' \

Hmmm... I winder why we had there indenting using spaces only, instead
of initial tab here...  Doesn't matter for this commit, though.

>  	    $@.sh > $@+ && \
>  	chmod +x $@+ && \
>  	mv $@+ $@
> @@ -1972,6 +1964,7 @@ install: all
>  	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
>  ifndef NO_PERL
>  	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
> +	$(MAKE) -C gitweb gitwebdir=$(gitwebdir) GITWEB_LIST=$(HOME)/.gitweb/list GITWEB_PROJECTROOT='' install

There is no need to pass "gitwebdir=$(gitwebdir)" to submakefile, I
think, but you should check that.  Anyway, it should be

  +	$(MAKE) -C gitweb gitwebdir=$(gitwebdir_SQ) ...


See also my comments about why change in git-instaweb behavior is not
good idea, especially not in this commit.  _Perhaps_ it should be
instead somthing like this:

  +	$(MAKE) -C gitweb gitwebdir=$(gitwebdir_SQ) \
  +		GITWEB_CONFIG='$ENV{GIT_DIR}/gitweb/gitweb_config.perl' install

Or something like that (not tested!)

> diff --git a/git-instaweb.sh b/git-instaweb.sh
> index f608014..4aaacbb 100755
> --- a/git-instaweb.sh
> +++ b/git-instaweb.sh
> @@ -19,21 +19,30 @@ start          start the web server
>  restart        restart the web server
>  "
>  
> +# This must be capable of running outside of git directory, so
> +# the vanilla git-sh-setup should not be used.
> +NONGIT_OK=Yes

This is related to the change in git-instaweb behavior.  IMVHO 
"git instaweb" should work just like "git log" or gitk, so requiring
to be run from git repository is not a bad requirement.

>  . git-sh-setup
>  
> -fqgitdir="$GIT_DIR"
> +fqgitdir="$HOME/.gitweb"

This is related to the change in git-instaweb behavior.  Anyway, the
'fqgitdir' name for this variable doesn't make much sense after this
change, isn't it?

>  local="$(git config --bool --get instaweb.local)"
>  httpd="$(git config --get instaweb.httpd)"
> +root="$(git config --get instaweb.root)" 

Trailing space.

I'm not entirely happy with the name of this config variable.  Perhaps
instaweb.gitwebdir would be better?  Also, we have to make sure that
git-instaweb would work even if this config variable is unset; perhaps
you do this later.

>  port=$(git config --get instaweb.port)
>  module_path="$(git config --get instaweb.modulepath)"
>  
> -conf="$GIT_DIR/gitweb/httpd.conf"
> +mkdir -p "$fqgitdir/tmp"
> +test ! -w "$fqgitdir/list" && touch "$fqgitdir/list"
> +conf="$fqgitdir/httpd.conf"

First, a functional change.

Second, "mkdir -p" is not portable, although I am not sure if it is a
problem in practice (i.e. if it is a problem on any platform that
gi-instaweb works now).

But I see that git-instaweb used "mkdir -p" before...

>  # Defaults:
>  
>  # if installed, it doesn't need further configuration (module_path)
>  test -z "$httpd" && httpd='lighttpd -f'
>  
> +# Default is /usr/share/gitweb
> +test -z "$root" && root='/usr/share/gitweb'
> +

It should be either

  +test -z "$root" && root='@@gitwebdir@@'

or

  +test -z "$root" && root='@@sharedir@@/gitweb'

(with placeholders replaced by "make git-instaweb").

> @@ -56,8 +65,8 @@ resolve_full_httpd () {
>  		# many httpds are installed in /usr/sbin or /usr/local/sbin
>  		# these days and those are not in most users $PATHs
>  		# in addition, we may have generated a server script
> -		# in $fqgitdir/gitweb.
> -		for i in /usr/local/sbin /usr/sbin "$fqgitdir/gitweb"
> +		# in $fqgitdir.
> +		for i in /usr/local/sbin /usr/sbin "$fqgitdir"

I think we should *add* "$root" here, but not remove the feature that
server script might be generated in "$GIT_DIR/gitweb", i.e. in
"$fqgitdir".  So the last line would be:

  +		for i in /usr/local/sbin /usr/sbin "$root" "$fqgitdir/gitweb"

>  		do
>  			if test -x "$i/$httpd_only"
>  			then
> @@ -85,7 +94,7 @@ start_httpd () {
>  	case "$httpd" in
>  	*mongoose*)
>  		#The mongoose server doesn't have a daemon mode so we'll have to fork it
> -		$full_httpd "$fqgitdir/gitweb/httpd.conf" &
> +		$full_httpd "$conf" &
>  		#Save the pid before doing anything else (we'll print it later)
>  		pid=$!
>  

This is change in how git-instaweb works.  Mind you, perhaps *this*
part of change is good... but not in this commit.

We might want to introduce $fqconf variable in preparatory commit...

> @@ -99,7 +108,7 @@ $pid
>  EOF
>  		;;
>  	*)
> -		$full_httpd "$fqgitdir/gitweb/httpd.conf"
> +		$full_httpd "$conf"
>  		if test $? != 0; then
>  			echo "Could not execute http daemon $httpd."
>  			exit 1

Same as above.

> @@ -156,15 +165,9 @@ do
>  	shift
>  done
>  
> -mkdir -p "$GIT_DIR/gitweb/tmp"

Ah, I see that git-instaweb used "mkdir -p" before...

>  	cat >"$conf" <<EOF
>  :Port: $port
> -:DocumentRoot: "$fqgitdir/gitweb"
> +:DocumentRoot: "$root"

> -server.document-root = "$fqgitdir/gitweb"
> +server.document-root = "$root"

> -ServerRoot "$fqgitdir/gitweb"
> -DocumentRoot "$fqgitdir/gitweb"
> +ServerRoot "$root"
> +DocumentRoot "$root"

> -root		$fqgitdir/gitweb
> +root		$root

Good.

Ah, I see, that is why instaweb.root name for config variable, and
$root name for variable in git-instaweb script... but 'root' meaning
'DocumentRoot' makes sense *only* in context.  That is why
instaweb.root is not IMHO a good name.

I am not against $root as name of variable, because it is hidden, and
is invariably in the context ;-)

> -server.errorlog = "$fqgitdir/gitweb/error.log"
> +server.errorlog = "$fqgitdir/error.log"
>  
>  # to enable, add "mod_access", "mod_accesslog" to server.modules
>  # variable above and uncomment this
> -#accesslog.filename = "$fqgitdir/gitweb/access.log"
> +#accesslog.filename = "$fqgitdir/access.log"

Without change in how git-instaweb work, i.e. with separate server
invoked for each repository (it might be a thing that we want to
change, but again: not in this commit), it makes sense to also have
error log and access log separate for each repository.

We could have used $fqgitwebdir variable here, or something like that.

>  apache2_conf () {
>  	test -z "$module_path" && module_path=/usr/lib/apache2/modules
> -	mkdir -p "$GIT_DIR/gitweb/logs"
>  	bind=
>  	test x"$local" = xtrue && bind='127.0.0.1:'
>  	echo 'text/css css' > "$fqgitdir/mime.types"
>  	cat > "$conf" <<EOF
>  ServerName "git-instaweb"
> +ErrorLog "$fqgitdir/error.log"
> +CustomLog "$fqgitdir/access.log" combined
>  PidFile "$fqgitdir/pid"
>  Listen $bind$port
>  EOF

Is this something new?  Did apache2 produced error log and access log
before this?

If it is something new, it should be put in separate (probably
preparatory) commit.

> @@ -303,13 +307,11 @@ EOF
>  	# check to see if Dennis Stosberg's mod_perl compatibility patch
>  	# (<20060621130708.Gcbc6e5c@leonov.stosberg.net>) has been applied
>  	if test -f "$module_path/mod_perl.so" &&
> -	   sane_grep 'MOD_PERL' "$GIT_DIR/gitweb/gitweb.cgi" >/dev/null
> +	   sane_grep 'MOD_PERL' "$root/gitweb.cgi" >/dev/null

Sidenote: I gues that this check could be removed now, but this is an
independent change.

>  	then
>  		# favor mod_perl if available
>  		cat >> "$conf" <<EOF
>  LoadModule perl_module $module_path/mod_perl.so
> -PerlPassEnv GIT_DIR
> -PerlPassEnv GIT_EXEC_DIR

In a minimal patch, the one that doesn't change git-instaweb
behaviour, and simply creates gitweb_config.perl in $GIT_DIR/gitweb in
place of gitweb.cgi and gitweb files, we would not want to remove
those two lines, but add instead

  +PerlPassEnv GITWEB_CONFIG

>  #cgi setup
> -cgi_env		PATH=$PATH,GIT_DIR=$GIT_DIR,GIT_EXEC_PATH=$GIT_EXEC_PATH
> +cgi_env		PATH=$PATH
>  cgi_interp	$PERL
>  cgi_ext		cgi,pl

Similarly, append ',GITWEB_CONFIG=$GITWEB_CONFIG' here.

> -script='
> -s#^(my|our) \$projectroot =.*#$1 \$projectroot = "'$(dirname "$fqgitdir")'";#;
> -s#(my|our) \$gitbin =.*#$1 \$gitbin = "'$GIT_EXEC_PATH'";#;
> -s#(my|our) \$projects_list =.*#$1 \$projects_list = \$projectroot;#;
> -s#(my|our) \$git_temp =.*#$1 \$git_temp = "'$fqgitdir/gitweb/tmp'";#;'
> -
> -gitweb_cgi () {
[...]
> -gitweb_cgi "$GIT_DIR/gitweb/gitweb.cgi"
> -gitweb_css "$GIT_DIR/@@GITWEB_CSS_NAME@@"
> -gitweb_js  "$GIT_DIR/@@GITWEB_JS_NAME@@"

This should be in my opinion replaced by generating proper
gitweb_config.perl file in $GIT_DIR/gitweb, and setting GITWEB_CONFIG
variable before running web server.


P.S. As the main goal of your GSoC project is create web interface
equivalent of git-gui (like gitweb is web interface equivalent of
gitk), with a secondary goal of splitting gitweb to make it easy to
add such new functionality without losing maintability, I think you
should not concentrate on this part.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
