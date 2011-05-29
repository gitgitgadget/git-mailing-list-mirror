From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCHv2 1/2] Starting work on a man page for /etc/gitweb.conf (WIP)
Date: Sun, 29 May 2011 21:50:25 +0200
Message-ID: <1306698626-32402-2-git-send-email-jnareb@gmail.com>
References: <1306698626-32402-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>,
	Drew Northup <drew.northup@maine.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 21:51:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQm1L-0000K4-Bm
	for gcvg-git-2@lo.gmane.org; Sun, 29 May 2011 21:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756286Ab1E2TvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2011 15:51:13 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42161 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754385Ab1E2TvL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2011 15:51:11 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so3320083wwa.1
        for <git@vger.kernel.org>; Sun, 29 May 2011 12:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=52WC0nfinGWphPIWkVUhH3P8DCdp7R2AbnT0jJY+Zhs=;
        b=K7hIiVLEeQVlxEbje9WMYfZiFAAzoE+V0U4R6G4bDbpk/kIw/Q1zt9ZghzWvJYpcuO
         rx/J4XGN0A7hIQnPizMtcSDpJ9RSzOW4HeyfSUmtO+23n8rpMDC9Le//ZAdTZUG4X0Cg
         EOUP69WbU3B109yaS+6oB4OrDnyZBnjmzIu9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YiO8QUVZWaOWwXkmqjParz6H5KtV91k7G0v/WwUEWQXZKRBTJG7CH2ewzZ8aOI+gKh
         pyTCZMsUvYwAw8oLvL33V2EF4dbSQbkB+WSxS1J6FKI+3HjHFUOO1UADjV/0TObdsq0r
         HXpO++kazSgbwbKiwP0qBfYV8lhbmpEuh/xB0=
Received: by 10.216.229.229 with SMTP id h79mr3913295weq.74.1306698669927;
        Sun, 29 May 2011 12:51:09 -0700 (PDT)
Received: from localhost.localdomain (abvt40.neoplus.adsl.tpnet.pl [83.8.217.40])
        by mx.google.com with ESMTPS id d7sm2111077wek.21.2011.05.29.12.51.07
        (version=SSLv3 cipher=OTHER);
        Sun, 29 May 2011 12:51:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1306698626-32402-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174701>

From: Drew Northup <drew.northup@maine.edu>

This is a work in progress. Much of what is in it has been pulled
directly from the README and INSTALL files of gitweb. No effort has yet
been made to de-duplicate any of this.

TODO:
  * Clean up README and INSTALL files
  * Move most of gitweb's README and INSTALL into gitweb.txt and
    gitweb.conf.txt, so that gitweb documentation can be easily viewed.
  * Remove or rephrase redundant portions of original documentation
  * A lot more...

Signed-off-by: Drew Northup <drew.northup@maine.edu>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Documentation/Makefile        |    2 +-
 Documentation/gitweb.conf.txt |  436 +++++++++++++++++++++++++++++++++++++++++
 git.spec.in                   |    3 +
 gitweb/Makefile               |   13 ++
 4 files changed, 453 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/gitweb.conf.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 36989b7..74ed959 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -3,7 +3,7 @@ MAN1_TXT= \
 		$(wildcard git-*.txt)) \
 	gitk.txt git.txt
 MAN5_TXT=gitattributes.txt gitignore.txt gitmodules.txt githooks.txt \
-	gitrepository-layout.txt
+	gitrepository-layout.txt gitweb.conf.txt
 MAN7_TXT=gitcli.txt gittutorial.txt gittutorial-2.txt \
 	gitcvs-migration.txt gitcore-tutorial.txt gitglossary.txt \
 	gitdiffcore.txt gitrevisions.txt gitworkflows.txt
diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
new file mode 100644
index 0000000..34f65fa
--- /dev/null
+++ b/Documentation/gitweb.conf.txt
@@ -0,0 +1,436 @@
+gitweb.conf(5)
+==============
+
+NAME
+----
+gitweb.conf - Gitweb configuration file
+
+SYNOPSIS
+--------
+[verse]
+'/etc/gitweb.conf'
+'$GITWEBDIR/gitweb_config.perl'
+
+DESCRIPTION
+-----------
+The gitweb CGI script for viewing Git repositories over the web uses a
+perl script fragment as its configuration file.  You can set variables
+using "`our $variable = value`"; text from a "#" character until the
+end of a line is ignored.  See *perlsyn*(1) for details.
+
+An example:
+
+    # gitweb configuration file for http://git.example.org
+    #
+    our $projectroot = "/srv/git"; # FHS recommendation
+    our $site_name = 'My Gitweb';  # or 'localhost'
+
+
+The configuration file is used to override the default settings that
+were built into gitweb at the time 'gitweb.cgi' script was generated.
+
+While one could just alter the configuration settings in the gitweb
+CGI itself, those changes would be lost upon upgrade.  Configuration
+settings might also be placed into a file in the same directory as the
+CGI script with the default name 'gitweb_config.perl' -- allowing
+one to have multiple gitweb instances with different configurations by
+the use of symlinks.
+
+
+DISCUSSION
+----------
+The location of system-wide gitweb configuration file is defined at compile
+time using the configuration value `GITWEB_CONFIG_SYSTEM` and defaults to
+'/etc/gitweb.conf'.  The name of the per-instance configuration file is
+defined in gitweb by `GITWEB_CONFIG`, and defaults to 'gitweb_config.perl'
+(relative path means located in the same directory gitweb is installed).
+
+You can override location of both system-wide and per-instance configuration
+file by setting respectively environmental variables `GITWEB_CONFIG_SYSTEM`
+and `GITWEB_CONFIG` to non-empty value.
+
+Values defined in configuration files override built-in values found in the
+gitweb CGI.
+
+*NOTE:* If per-instance configuration file ('gitweb_config.perl') exists,
+then system-wide configuration file ('/etc/gitweb.conf') is _not used at
+all_ !!!
+
+The syntax of the configuration files is that of Perl, as these files are
+indeed handled as fragments of Perl code (the language that gitweb itself is
+written in). Variables may be set using "`our $variable = value`"; text from
+"#" character until the end of a line is ignored. See the *perlsyn*(1) man
+page for more information.
+
+Actually using `our` qualifier in `our $variable = <value>;` is a safety
+check: if newer gitweb does no longer use given variable, by using `our` we
+won't get syntax errors.
+
+The default configuration with no configuration file at all may work
+perfectly well for some installations.  Still, a configuration file is
+useful for customizing or tweaking the behavior of gitweb in many ways, and
+some optional features will not be present unless explicitly enabled using
+the configurable `%features` variable.
+
+
+CONFIGURATION VARIABLES
+-----------------------
+Some of configuration variables have their default values (embedded in CGI
+file) set during building gitweb -- if that is the case, it is put in their
+description.  See gitweb's 'INSTALL' file for instructions on building and
+installing gitwen.
+
+Location of repositories
+~~~~~~~~~~~~~~~~~~~~~~~~
+Configuration variables described below control finding git repositories by
+gitweb, and control display and access to repositories.
+
+$projectroot::
+	Absolute filesystem path which will be prepended to project path;
+	the path to repository is `$projectroot/$project`.  Set to
+	`$GITWEB_PROJECTROOT` during installation.  This variable has to be
+	set correctly for gitweb to find repositories.
++
+For example if `$projectroot` is set to "/srv/git" by putting the following
+in gitweb config file:
+----------------------------------------------------------------------------
+our $projectroot = "/srv/git";
+----------------------------------------------------------------------------
+then
+------------------------------------------------
+http://git.example.com/gitweb.cgi?p=foo/bar.git
+------------------------------------------------
+or its path_info based equivalent
+------------------------------------------------
+http://git.example.com/gitweb.cgi/foo/bar.git
+------------------------------------------------
+will map to path '/srv/git/foo/bar.git' on filesystem.
+
+$projects_list::
+	Plain text file listing projects or name of directory
+        to be scanned for projects.
+
+	Project list files should list one project per line, with each line
+        having the following format
+-----------------------------------------------------------------------------
+<URI-encoded filesystem path to repository> SP <URI-encoded repository owner>
+-----------------------------------------------------------------------------
+
+The default value of this variable is determined by the `GITWEB_LIST`
+makefile variable at installation time.  If this variable is empty, gitweb
+will fall back to scanning the `$projectroot` directory for repositories.
+
+$export_ok::
+	Show repository only if this file exists (in repository).  Only
+	effective if this variable evaluates to true.  Can be set during
+	building gitweb via `GITWEB_EXPORT_OK`.  [No default / Not set]
+$export_auth_hook::
+	Show repository only if this subroutine returns true, when given as
+	the only parameter the full path to the project.  Example:
+----------------------------------------------------------------------------
+our $export_auth_hook = sub { return -e "$_[0]/git-daemon-export-ok"; };
+----------------------------------------------------------------------------
+(though the above might be done by using 
+----------------------------------------------------------------------------
+our $export_ok = "git-daemon-export-ok";
+----------------------------------------------------------------------------
+instead).
+
+$strict_export::
+	Only allow viewing of repositories also shown on the overview page.
+	This for example makes `$gitweb_export_ok` file decide if repository is
+	available and not only if it is shown.  If `$gitweb_list` points to
+	file with list of project, only those repositories listed would be
+	available for gitweb.  Can be set during building gitweb via
+	`GITWEB_STRICT_EXPORT`.  [No default / Not set]
+
+Finding files
+~~~~~~~~~~~~~
+Those configuration variables tell gitweb where to find files.  Values of
+those variables are paths on filesystem.  Of those only `$GIT` is required
+to be (correctly) set for gitweb to be able to work; all the rest are
+required only for extra configuration or extra features.
+
+$GIT::
+	Core git executable to use.  By default set to `$GIT_BINDIR/git`, which
+	in turn is by default set to `$(bindir)/git`.  If you use git from binary
+	package, set this to "/usr/bin/git".  This can just be "git" if your
+	webserver has a sensible PATH.  If you have multiple git versions installed
+	it can be used to choose which one to use.
+$mimetypes_file::
+	File to use for (filename extension based) guessing of MIME types before
+	trying '/etc/mime.types'.  Path, if relative, is taken currently as
+	relative to the current git repository.  [Unset by default]
+$highlight_bin::
+	Path to the highlight executable to use (must be the one from
+	http://www.andre-simon.de due to assumptions about parameters and output).
+	Useful if highlight is not installed on your webserver's PATH.
++
+	[Default: 'highlight']
+
+Links and their targets
+~~~~~~~~~~~~~~~~~~~~~~~
+Configuration variables described below configure some of gitweb links:
+their target and their look (text or image), and where to find page
+prerequisites (stylesheet, favicon, images, scripts).  Usually they are left
+at their default values, with the possible exception of `@stylesheets`
+variable.
+
+@stylesheets::
+	List of URIs of stylesheets (relative to base URI of a page). You
+	might specify more than one stylesheet, for example use gitweb.css
+	as base, with site specific modifications in separate stylesheet
+	to make it easier to upgrade gitweb. You can add a `site` stylesheet
+	for example by putting
+----------------------------------------------------------------------------
+push @stylesheets, "gitweb-site.css";
+----------------------------------------------------------------------------
+in the gitweb config file.  Those values that are relative paths, are
+relative to base URI of gitweb.
+
+This list should contain URI of gitweb's stylesheet.  The URI of gitweb
+stylesheet is set during build time via `GITWEB_CSS` variable.  It's default
+value is 'static/gitweb.css' (or 'static/gitweb.min.css' if the `CSSMIN`
+variable is defined, i.e. if CSS minifier is used during build.
+
+$logo::
+	Points to the location where you put 'git-logo.png' on your web
+	server, or to be more generic URI of logo, 72x27 size).  This image
+	is displayed in top right corner of each gitweb page, and used as
+	logo for Atom feed.  Relative to base URI of gitweb (as a path).
+	Can be adjusted during building gitweb using `GITWEB_LOGO` variable
++
+	[Default: 'static/git-logo.png']
+
+$favicon::
+	Points to the location where you put 'git-favicon.png' on your web
+	server, or to be more generic URI of favicon, assumed to be
+	"image/png" type; web browsers that support favicons (website icons)
+	may display them in the browser's URL bar and next to site name in
+	bookmarks.  Relative to base URI of gitweb.  Can be adjusted during
+	build time using `GITWEB_FAVICON` variable.
++
+	[Default: 'static/git-favicon.png']
+
+$javascript::
+	Points to the location where you put 'gitweb.js' on your web server,
+	or to be more generic URI of JavaScript code used by gitweb.
+	Relative to base URI of gitweb.  Set during build time using
+	`GITWEB_JS` build-time configuration variable.
++
+Default value is either 'static/gitweb.js', or 'static/gitweb.min.js' if
+`JSMIN` build variable is defined, i.e. if JavaScript minifier is used
+during build.  *Note* that this single file is build (composed) of
+individual JavaScript "modules".
+
+$home_link::
+	Target of the home link on top of all pages (the first part of view
+	"breadcrumbs").  By default set to absolute URI of a page ($my_uri).
+$home_link_str::
+	Description of the home link on top of all pages, leading to $home_link
+	(usually main gitweb page, which means projects list).  Used as first
+	part of gitweb view "breadcrumb trail": `<home> / <project> / <view>`.
+	Can be set during build time using `GITWEB_HOME_LINK_STR` variable.
+	[Default: "projects"]
+$logo_url, $logo_label::
+	URI and label (title) of GIT logo link (or your site logo, if you choose
+	to use different logo image). By default they point to git homepage;
+	in the past they pointed to git documentation at www.kernel.org.
+
+Changing gitweb look
+~~~~~~~~~~~~~~~~~~~~
+You can adjust how pages generated by gitweb look using variables described
+below.  You can change site name, add common headers and footers for all
+pages, and add description of gitweb installation on its main page (which is
+projects list page), etc.
+
+$site_name::
+	Name of your site or organization to appear in page titles.  Set it
+	to something descriptive for clearer bookmarks etc.  If not set (if
+	empty) then gitweb uses value of `SERVER_NAME` CGI environment
+	variable setting prefix of each page title to "$SERVER_NAME Git", or
+	"Untitled Git" if this variable is not set (e.g. if running gitweb
+	as standalone script).
++
+Can be set using `GITWEB_SITENAME` during building.  [No default]
+
+$site_header::
+	Filename of html text to include at top of each page.  Relative to
+	'gitweb.cgi' script.  Can be set using `GITWEB_SITE_HEADER` during
+	building.  [No default]
+$site_footer::
+	Filename of html text to include at bottom of each page.  Relative to
+	gitweb.cgi script.  Can be set using `GITWEB_SITE_FOOTER` during
+	building.  [No default]
+$home_text::
+	Points to an HTML file which, if it exists, is included on the
+	gitweb projects overview page ("projects_list" view).  Relative to
+	gitweb.cgi script.  Default value can be adjusted using during build
+	via `GITWEB_HOMETEXT` variable.
++
+	[Default: 'indextext.html']
+
+$projects_list_description_width::
+	The width (in characters) of the projects list "Description" column.
+	Longer descriptions will be cut (trying to cut at word boundary);
+	full description is available as 'title' attribute (usually shown on
+	mouseover).  By default set to 25, which might be too small if you
+	use long project descriptions.
+$default_projects_order::
+	Default value of ordering of projects on projects list page.  Valid
+	values are "none" (unsorted), "project" (by project name, i.e. path
+	to repository relative to `$projectroot`), "descr" (project
+	description), "owner", and "age" (by date of most current commit).
+
+	Default value is "project".  Unknown value means unsorted.
+
+Changing gitweb behavior
+~~~~~~~~~~~~~~~~~~~~~~~~
+Those configuration variables control _internal_ gitweb behavior.
+
+$default_blob_plain_mimetype::
+	Default mimetype for blob_plain (raw) view, if mimetype checking
+	doesn't result in some other type; by default "text/plain".
+$default_text_plain_charset::
+	Default charset for text files. If not set, web server configuration
+	would be used.
+$fallback_encoding::
+	Gitweb assumes this charset if line contains non-UTF-8 characters.
+	Fallback decoding is used without error checking, so it can be even
+	"utf-8". Value must be valid encoding; see *Encoding::Supported*(3pm)
+	man page for a list.  By default "latin1", aka. "iso-8859-1".
+@diff_opts::
+	Rename detection options for git-diff and git-diff-tree. By default
+	(\'-M'); set it to (\'-C') or (\'-C', \'-C') to also detect copies,
+	or set it to () i.e. empty list if you don't want to have renames
+	detection.
+
+Extra features, administrative
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Most of features are configured via `%feature` hash; however some of extra
+gitweb features can be turned on and configured using variables described
+below.  This list beside configuration variables that control how gitweb
+looks does contain variables configuring administrative side of gitweb
+(e.g. cross-site scripting prevention; admittedly this as side effect
+affects how "summary" pages look like, or load limiting).
+
+@git_base_url_list::
+	List of git base URLs used for URL to where fetch project from, shown
+	in project summary page.  Full URL is "`$git_base_url/$project`".  You
+	can setup multiple base URLs (for example one for `git://` protocol
+	access, and one for `http://` "dumb" protocol access).  Note that per
+	repository configuration can be set in '$GIT_DIR/cloneurl' file, or as
+	values of multi-value `gitweb.url` configuration variable in project
+	config.
++
+You can setup one single value (single entry/item in this list) during
+building by using `GITWEB_BASE_URL` built-time configuration variable.  [No
+default]
+
+$prevent_xss::
+	If true, some gitweb features are disabled to prevent content in
+	repositories from launching cross-site scripting (XSS) attacks.  Set this
+	to true if you don't trust the content of your repositories.
+	[Default: false].
+$maxload::
+	Used to set the maximum load that we will still respond to gitweb queries.
+	If server load exceed this value then return "503 Service Unavailable"
+	error. Server load is taken to be 0 if gitweb cannot determine its value.
+	Set it to undefined value to turn it off. [Default: 300]
+$per_request_config::
+	If set to code reference, it would be run once per each request.  You can
+	set parts of configuration that change per session, e.g. by adding
+	the following code to gitweb configuration file
+--------------------------------------------------------------------------------
+our $per_request_config = sub {
+	$ENV{GL_USER} = $cgi->remote_user || "gitweb";
+};
+--------------------------------------------------------------------------------
+Otherwise it is treated as boolean value: if true gitweb would process
+config file once per request, if false it would process config file only
+once.  
+
+*Note*: $my_url, $my_uri, and $base_url are overwritten with their default
+values before every request, so if you want to change them, be sure to set
+this variable to true or a code reference effecting the desired changes.
+
+[Default: true]
+
+Other variables
+~~~~~~~~~~~~~~~
+Usually you should not need to change (adjust) any of configuration
+variables described below; they should be automatically set by gitweb to
+correct value.
+
+$version::
+	Gitweb version, set automatically when creating gitweb.cgi from
+	gitweb.perl. You might want to modify it if you are running modified
+	gitweb, for example `our $version .= " with caching";`.
+$my_url, $my_uri::
+	Full URL and absolute URL of gitweb script;
+	in earlier versions of gitweb you might have need to set those
+	variables, now there should be no need to do it.  See
+	`$per_request_config` if you need to set them still.
+$base_url::
+	Base URL for relative URLs in pages generated by gitweb,
+	(e.g. `$logo`, `$favicon`, `@stylesheets` if they are relative URLs),
+	needed and used only for URLs with nonempty PATH_INFO via
+	'<base href="$base_url">'.  Usually gitweb sets its value correctly,
+	and there is no need to set this variable, e.g. to $my_uri or "/".
+	See `$per_request_config` if you need to set it anyway.
+
+
+EXAMPLES
+--------
+
+To enable blame, pickaxe search, and snapshot support, while allowing
+individual projects to turn them off, put the following in your
+GITWEB_CONFIG file:
+
+        $feature{'blame'}{'default'} = [1];
+        $feature{'blame'}{'override'} = 1;
+
+        $feature{'pickaxe'}{'default'} = [1];
+        $feature{'pickaxe'}{'override'} = 1;
+
+        $feature{'snapshot'}{'default'} = ['zip', 'tgz'];
+        $feature{'snapshot'}{'override'} = 1;
+
+If you allow overriding for the snapshot feature, you can specify which
+snapshot formats are globally disabled. You can also add any command line
+options you want (such as setting the compression level). For instance, you
+can disable Zip compressed snapshots and set *gzip*(1) to run at level 6 by
+adding the following lines to your gitweb configuration file:
+
+        $known_snapshot_formats{'zip'}{'disabled'} = 1;
+        $known_snapshot_formats{'tgz'}{'compressor'} = ['gzip','-6'];
+
+ENVIRONMENT
+-----------
+The location of per-instance and system-wide configuration files can be set
+using the following environment variables:
+
+GITWEB_CONFIG::
+	Sets location of per-instance configuration file.
+GITWEB_CONFIG_SYSTEM::
+	Sets location of system-wide configuration file.  This file is read
+	only if per-instance one does not exist.
+
+FILES
+-----
+gitweb_config.perl::
+	This is default value for per-instance configuration file.  The
+	format of this file is described above.
+/etc/gitweb.conf::
+	This is default value for system-wide configuration file.  This file
+	is used only if per-instance configuration variable is not found.
+
+SEE ALSO
+--------
+linkgit:git-instaweb[1]
+
+'gitweb/README', 'gitweb/INSTALL'
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/git.spec.in b/git.spec.in
index 91c8462..06b27eb 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -200,6 +200,9 @@ rm -rf $RPM_BUILD_ROOT
 %files -n gitweb
 %defattr(-,root,root)
 %{_datadir}/gitweb
+%{!?_without_docs: %{_mandir}/man1/*gitweb*.1*}
+%{!?_without_docs: %{_mandir}/man5/*gitweb*.5*}
+%{!?_without_docs: %doc Documentation/*gitweb*.html }
 
 %files -n perl-Git -f perl-files
 %defattr(-,root,root)
diff --git a/gitweb/Makefile b/gitweb/Makefile
index 0a6ac00..582e1b0 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -112,6 +112,14 @@ endif
 
 GITWEB_FILES += static/git-logo.png static/git-favicon.png
 
+GITWEB_MAN5_TXT = gitweb.conf.txt
+GITWEB_MAN_TXT = $(GITWEB_MAN1_TXT) $(GITWEB_MAN5_TXT) $(GITWEB_MAN7_TXT)
+GITWEB_MAN = $(patsubst %.txt,%.1,$(GITWEB_MAN1_TXT)) \
+             $(patsubst %.txt,%.5,$(GITWEB_MAN5_TXT)) \
+             $(patsubst %.txt,%.7,$(GITWEB_MAN7_TXT))
+GITWEB_HTML= $(patsubst %.txt,%.html,$(GITWEB_MAN_TXT))
+GITWEB_DOC = $(GITWEB_MAN) $(GITWEB_HTML)
+
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
 	-e 's|++GIT_BINDIR++|$(bindir)|g' \
@@ -155,6 +163,11 @@ test-installed:
 	GITWEB_TEST_INSTALLED='$(DESTDIR_SQ)$(gitwebdir_SQ)' \
 		$(MAKE) -C ../t gitweb-test
 
+### Documentation
+
+doc:
+	$(MAKE) -C ../Documentation $(GITWEB_DOC)
+
 ### Installation rules
 
 install: all
-- 
1.7.5
