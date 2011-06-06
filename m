From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCHv3 4/5] gitweb: Starting work on a man page for /etc/gitweb.conf (WIP)
Date: Mon,  6 Jun 2011 19:44:30 +0200
Message-ID: <1307382271-7677-5-git-send-email-jnareb@gmail.com>
References: <1307382271-7677-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>,
	Drew Northup <drew.northup@maine.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 20:01:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTe7T-0001Uw-NP
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 20:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756084Ab1FFSBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 14:01:37 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41397 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289Ab1FFSBg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 14:01:36 -0400
Received: by wwa36 with SMTP id 36so4080014wwa.1
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 11:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=BNghikj0kzbe8NZqUUXrEYHRiKGXb2ZdQvF1IHAJ0cU=;
        b=tAVd+xCFtVEYwIQrXaR/pFf3WEfkEvmN3u5iZpXF3Jfb6vr8E/R5zXH4o8/MaWyVhb
         T8zqHa2F8jAKdgnJyKHN3xMB9ar0A55T+myCxkoGFIh5Otrpg6+5bJb5WgUZvcmhIEQX
         VH/tOQCDdsyx/+6oDV1R5KKIwGwV5IT2Prtso=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=T3m0MFQyZTM9FfQ+YVISnU9cSgM7jhFoABgF3NTJJQhcxUE+jd0hdZqXC5qF7jQW5g
         8jtfXLp4EwluODBOVaFzipkn+QFMicIENI1Sfm8BqlJoMUTfdrKbll/pA31mUe538d8+
         7J5uJuaK7RneTOHYJKa8PBC8FTQnMPZyFjqbU=
Received: by 10.216.233.224 with SMTP id p74mr5354811weq.4.1307383294441;
        Mon, 06 Jun 2011 11:01:34 -0700 (PDT)
Received: from localhost.localdomain (abwr100.neoplus.adsl.tpnet.pl [83.8.241.100])
        by mx.google.com with ESMTPS id t79sm2440982weq.5.2011.06.06.11.01.31
        (version=SSLv3 cipher=OTHER);
        Mon, 06 Jun 2011 11:01:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1307382271-7677-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175145>

From: Drew Northup <drew.northup@maine.edu>

This is a work in progress. Much of what is in it has been pulled
directly from the README and INSTALL files of gitweb. Some effort has
been made to de-duplicate any of this.

To build gitweb documentation you can use

  make -C gitweb doc

or

  cd gitweb; make doc

TODO:
  * Clean up README and INSTALL files
  * Remove or rephrase redundant portions of original documentation
  * A lot more...

Signed-off-by: Drew Northup <drew.northup@maine.edu>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Differences from previous version (v2):

* Much simpler "doc" target in gitweb/Makefile.  Now instead of
  duplicating internal knowledge how Documentation/Makefile works we
  simply delegate task to "gitweb-doc" target (a la "full-svn-test"
  in t/Makefile) in Documentation/Makefile.

  The "gitweb-doc" target is implemented in 2 lines, compared to
  previous version which needed 7 lines in gitweb's Makefile.

  Thanks Junio for this bit of sanity.

* Added documentation: $project_maxdepth, %highlight_ext etc., new
  after rebase $project_list_group_categories etc.

* New chapter "Configuring gitweb features" about %feature hash. 

* Link to non-existent yet linkgit:gitweb[1] (introduced in next commit).

* Removed duplicated contents from gitweb/README

- By accident moved change to git.spec.in to next commit.  But perhaps
  it is better here, or even better in a separate commit on top of
  series.

 Documentation/Makefile        |    7 +-
 Documentation/gitweb.conf.txt |  716 +++++++++++++++++++++++++++++++++++++++++
 gitweb/Makefile               |    7 +-
 gitweb/README                 |  133 +--------
 4 files changed, 728 insertions(+), 135 deletions(-)
 create mode 100644 Documentation/gitweb.conf.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 36989b7..68d0ebb 100644
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
@@ -170,6 +170,9 @@ info: git.info gitman.info
 
 pdf: user-manual.pdf
 
+GITWEB_DOC = $(filter gitweb.%,$(DOC_HTML) $(DOC_MAN1) $(DOC_MAN5) $(DOC_MAN7))
+gitweb-doc: $(GITWEB_DOC)
+
 install: install-man
 
 install-man: man
@@ -334,4 +337,4 @@ quick-install-man:
 quick-install-html:
 	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(HTML_REF) $(DESTDIR)$(htmldir)
 
-.PHONY: FORCE
+.PHONY: FORCE gitweb-doc
diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
new file mode 100644
index 0000000..2bfe2e5
--- /dev/null
+++ b/Documentation/gitweb.conf.txt
@@ -0,0 +1,716 @@
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
+    our $site_name = 'Example.org >> Repos';
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
+System-wide configuration file is a fallback for when per-instance
+configuration file does not exist.
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
+all_!!!
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
+the configurable `%features` variable (see also "Configuring gitweb
+features" section below).
+
+
+CONFIGURATION VARIABLES
+-----------------------
+Some of configuration variables have their default values (embedded in CGI
+file) set during building gitweb -- if that is the case, it is put in their
+description.  See gitweb's 'INSTALL' file for instructions on building and
+installing gitweb.
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
+$project_maxdepth::
+	Filesystem traversing depth limit for recursively scanning for git
+	repositories, used if `$projects_list` (below) is unset.  The default
+	value of this variable is determined by build-time configuration
+	variable `GITWEB_PROJECT_MAXDEPTH`, which defaults to 2007.
+
+$projects_list::
+	Plain text file listing projects or name of directory
+	to be scanned for projects.
+
+	Project list files should list one project per line, with each line
+	having the following format
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
+though the above might be done by using `$export_ok` instead
+----------------------------------------------------------------------------
+our $export_ok = "git-daemon-export-ok";
+----------------------------------------------------------------------------
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
+	Useful if 'highlight' is not installed on your webserver's PATH.
+
+	*Note* that if you want to add support for new syntax (supported by
+	"highlight" but not used by gitweb), you need to modify `%highlight_ext`
+	or `%highlight_basename`, depending on whether you detect type of file
+	based on extension (for example "*.sh") or on its basename (for example
+	"Makefile").  Keys of those hashes are extension or basename,
+	respectively, and value for given key is name of syntax to be passed via
+	`--syntax <syntax>` to highlighter.
+
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
+*Note*: there is also legacy `$stylesheet` configuration variable, which was
+used by older gitweb.
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
+$logo_url::
+$logo_label::
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
+building by using `GITWEB_BASE_URL` built-time configuration variable.
+[No default]
+
+$projects_list_group_categories::
+	Enables the grouping of projects by category on the project list page.
+	The category of a project is determined by the `$GIT_DIR/category` file
+	or the `gitweb.category` variable in its repository configuration.
+	[Disabled by default].
+$project_list_default_category::
+	Default category for projects for which none is specified.  If set to
+	the empty string, such projects will remain uncategorized and listed at
+	the top, above categorized projects.  Used only if project cateories are
+	enabled, which means if `$projects_list_group_categories` is true.
+	[Default: "" (empty string)]
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
+$my_url::
+$my_uri::
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
+CONFIGURING GITWEB FEATURES
+---------------------------
+Many gitweb features can be enabled (or disabled) and configured using the
+`%feature` hash.  Names of gitweb features are keys of this hash.
+
+Each `%feature` hash element is a hash reference and has the following
+structure:
+----------------------------------------------------------------------
+"<feature_name>" => {
+	"sub" => <feature-sub (subroutine)>,
+	"override" => <allow-override (boolean)>,
+	"default" => [ <options>... ]
+},
+----------------------------------------------------------------------
+Some of features does not support project specific override.  For those
+features the structure of appropriate `%feature` hash element has a simpler
+form:
+----------------------------------------------------------------------
+"<feature_name>" => {
+	"override" => 0,
+	"default" => [ <options>... ]
+},
+----------------------------------------------------------------------
+As one can see it lacks \'sub' element.
+
+The meaning of respective parts of feature configuration are described
+below:
+
+default::
+	List (array reference) of feature parameters (if there are any),
+	used also to toggle (enable or disable) given feature.
+
+	Note that it is currently *always* an array reference, even if
+	feature doesn't accept any configuration parameters, and \'default'
+	is used only to turn it on or off.  In such case you turn feature on
+	by setting this element to `[1]`, and torn it off by setting it to
+	`[0]`.  See also part about "blame" feature in the "Examples"
+	section.
+
+	To disable feature that accepts parameters (is configurable), you
+	need to set this element to empty list i.e. `[]`.
+
+override::
+	If it has a true value then given feature is overridable, which
+	means that it can be configured (or enabled/disabled) on
+	per-repository basis.
+
+	Usually given "<feature>" is configurable via `gitweb.<feature>`
+	config variable in per-repository git configuration file.
+
+	*Note* that no feature is overridable by default.
+
+sub::
+	Subroutine that will be called with default options as parameters to
+	examine per-repository configuration, but only if feature is
+	overridable (\'override' is set to true).  If not present then
+	per-repository override for given feature is not supported.
+
+	You wouldn't need to ever change it in gitweb config file.
+
+Features in `%feature`
+~~~~~~~~~~~~~~~~~~~~~~
+Below there are described gitweb features that are configurable via
+`%feature` hash.  For a complete list please consult gitweb sources.
+
+blame::
+	Enable the "blame" and "blame_incremental" blob views, showing for
+	each line the last commit that modified it; see linkgit:git-blame[1].
+	This can be very CPU-intensive and is therefore disabled by default.
+
+	This feature can be configured on a per-repository basis via
+	repository's `gitweb.blame` configuration variable (boolean).
+
+snapshot::
+	Enable and configure "snapshot" action, providing a compressed
+	archive of any tree or commit; see also linkgit:git-archive[1].
+	This can potentally generate high traffic if you have large project.
+
+	The value (of \'default') is a list of names of snapshot formats
+	defined in `%known_snapshot_formats` hash, that you wish to offer.
+	Among supported formats are "tgz", "tbz2", "txz" (gzip/bzip2/xz
+	compressed tar archive) and "zip"; please consult gitweb sources for
+	a definitive list.  By default only "tgz" is offered.
+
+	This feature can be configured on a per-repository basis via
+	repository's `gitweb.blame` configuration variable, which contains
+	a comma separated list of formats, or "none" to disable snapshots.
+	Unknown values will be ignored.
+
+grep::
+	Enable grep search, which will list the files in currently selected
+	tree (directory) containing the given string; see linkgit:git-rep[1].
+	This can be potentially CPU-intensive, of course.  Enabled by default.
+
+	This feature can be configured on a per-repository basis via
+	repository's `gitweb.grep` configuration variable (boolean).
+
+pickaxe::
+	Enable the so called pickaxe search, which will list the commits
+	that modified a given string in a file.  This can be practical and
+	quite faster alternative to "blame" action, but still potentially
+	CPU-intensive.  Enabled by default.
+
+	The pickaxe search is described in linkgit:git-log[1] (the
+	description of `-S<string>` option, which refers to pickaxe entry in
+	linkgit:gitdiffcore[7] for more details).
+
+	This feature can be configured on a per-repository basis via
+	repository's `gitweb.pickaxe` configuration variable (boolean).
+
+show-sizes::
+	Enable showing size of blobs (ordinary files) in a "tree" view, in a
+	separate column, similar to what `ls -l` does; see description of
+	`-l` option in linkgit:git-ls-tree[1] manpage.  This cost a bit of
+	I/O.  Enabled by default.
+
+	This feature can be configured on a per-repository basis via
+	repository's `gitweb.showsizes` configuration variable (boolean).
+
+patches::
+	Configure "patches" view, which displays list of commits in email
+	(plain text) output format; see also linkgit:git-format-patch[1].
+	The value is the maximum number of patches in a patchset generated
+	in "patches" view.  Set this to 0 or undef to disable patch view, or
+	to a negative number to remove any limit.  Default value is 16.
+
+	This feature can be configured on a per-repository basis via
+	repository's `gitweb.patches` configuration variable (integer).
+
+avatar::
+	Avatar support.  When this feature is enabled, views such as
+	"shortlog" or "commit" will display an avatar associated with
+	the email of the committer(s) and/or author(s).
+
+	Currently available providers are *"gravatar"* and *"picon"*.
+	If an unknown provider is specified, the feature is disabled.
+	*Note* that some provides might require extra Perl packages to be
+	installed; see 'gitweb/INSTALL' for more details.
+
+	This feature can be configured on a per-repository basis via
+	repository's `gitweb.avatar` configuration variable.
+
+	See also `%avatar_size` with pixel sizes for icons and avatars
+	("default" is used for one-line like "log" and "shortlog", "double"
+	is used for two-line like "commit", "commitdiff" or "tag").  If the
+	default font sizes or lineheights are changed (e.g. via adding extra
+	CSS stylesheet in `@stylesheets`), it may be appropriate to change
+	these values.
+
+highlight::
+	Server-side syntax hightlight support in "blob" view.  It requires
+	`$highlight_bin` program available (see description of this variable
+	in "Configuration variables" section above), and therefore is
+	disabled by default.
+
+	This feature can be configured on a per-repository basis via
+	repository's `gitweb.highlight` configuration variable (boolean).
+
+remote_heads::
+	Enable displaying remote heads (remote-tracking branches) in the "heads"
+	list.  In most cases it is unnecessary internal private detail, and it
+	is therefore disabled by default.  linkgit:git-instaweb[1], which is
+	usually used to browse local repositories, enables and uses this
+	feature.
+
+	This feature can be configured on a per-repository basis via
+	repository's `gitweb.remote_heads` configuration variable (boolean).
+
+
+The list below presents features that do not allow project specific
+overrides.
+
+search::
+	Enable text search, which will list the commits which match author,
+	committer or commit text to a given string; see description of
+	`--author`, `--committer` and `--grep` options in linkgit:git-log[1]
+	manpage.  Enabled by default.
+
+	Project specific override is not supported.
+
+forks::
+	Make gitweb consider projects in subdirectories of project root
+	(basename) to be forks of existing projects.  Given project
+	`$projname.git`, projects matching `$projname/*.git` will not be
+	shown in the main projects list, instead a \'+' mark will be added
+	to `$projname` there and a "forks" view will be enabled for the
+	project, listing all the forks.  If project list is taken from a
+	file, forks have to be listed after the main project.
+
+	Project specific override is not supported.
+
+actions::
+	Insert custom links to the action bar of all project pages.  This
+	enables you to link to third-party scripts integrating into gitweb.
+
+	The "default" value consists of a list of triplets in the form
+	`("<label>", "<link>", "<position>")` where "position" is the label
+	after which to insert the link, "link" is a format string where `%n`
+	expands to the project name, `%f` to the project path within the
+	filesystem, `%h` to the current hash (\'h' gitweb parameter) and
+	`%b` to the current hash base (\'hb' gitweb parameter); `%%` expands
+	to \'%'.
+
+	For example http://repo.or.cz git hosting site sets it to the
+	following to enable graphical log (via third party tool
+	*git-browser*):
+----------------------------------------------------------------------
+$feature{'actions'}{'default'} =
+	[ ('graphiclog', '/git-browser/by-commit.html?r=%n', 'summary')];
+----------------------------------------------------------------------
+This adds link titled "graphiclog" after "summary" link, leading to
+`git-browser` script, passing `r=<project>` as a query parameter.
+
+Project specific override is not supported.
+
+timed::
+	Enable displaying how much time and how many git commands it took to
+	generate and display page in the page footer (at the bottom of
+	page).  For example it might be: "This page took 6.53325 seconds and
+	13 git commands to generate."  Disabled by default.
+
+	Project specific override is not supported.
+
+javascript-timezone::
+
+	Enable and configure ability to change common timezone for dates in
+	gitweb output via JavaScript.  Dates in gitweb output include
+	authordate and comitterdate in "commit", "commitdiff" and "log"
+	views, and taggerdate in "tag" view.  Enabled by default.
+
+	Value is list of three values: default timezone (if client didn't
+	select other timezone and saved it in a cookie), name of cookie
+	where to store selected timezone, and CSS class used to mark up
+	dates for manipulation.  If you want to turn it off, set "default"
+	to empty list: `[]`.
+
+	In most case you would want to change only default timezone:
+---------------------------------------------------------------------------
+$feature{'javascript-timezone'}{'default'}[0] = "utc";
+---------------------------------------------------------------------------
+Timezone value can be "local" (for local timezone that browser uses), "utc"
+(what gitweb uses when JavaScript or this feature is disabled), or numerical
+timezone in the form of "+/-HHMM" for example "+0200".  This way is
+guaranteed to be backward compatibile.
+
+Project specific override is not supported.
+
+
+EXAMPLES
+--------
+
+To enable blame, pickaxe search, and snapshot support (allowing "tar.gz" and
+"zip" snapshots), while allowing individual projects to turn them off, put
+the following in your GITWEB_CONFIG file:
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
+linkgit:gitweb[1], linkgit:git-instaweb[1]
+
+'gitweb/README', 'gitweb/INSTALL'
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/gitweb/Makefile b/gitweb/Makefile
index 5d20515..dfdefef 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -172,6 +172,11 @@ test-installed:
 	GITWEB_TEST_INSTALLED='$(DESTDIR_SQ)$(gitwebdir_SQ)' \
 		$(MAKE) -C ../t gitweb-test
 
+### Documentation
+
+doc:
+	$(MAKE) -C ../Documentation gitweb-doc
+
 ### Installation rules
 
 install: all
@@ -185,5 +190,5 @@ install: all
 clean:
 	$(RM) gitweb.cgi static/gitweb.min.js static/gitweb.min.css GITWEB-BUILD-OPTIONS
 
-.PHONY: all clean install test test-installed .FORCE-GIT-VERSION-FILE FORCE
+.PHONY: all clean install test test-installed doc .FORCE-GIT-VERSION-FILE FORCE
 
diff --git a/gitweb/README b/gitweb/README
index a4cfcb4..1e6cf27 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -20,139 +20,8 @@ Ultimate description on how to reconfigure the default features setting
 in your `GITWEB_CONFIG` or per-project in `project.git/config` can be found
 as comments inside 'gitweb.cgi'.
 
-See also the "Gitweb config file" (with an example of config file), and
-the "Gitweb repositories" sections in INSTALL file for gitweb.
-
-
-The gitweb config file is a fragment of perl code. You can set variables
-using "our $variable = value"; text from "#" character until the end
-of a line is ignored. See perlsyn(1) man page for details.
-
-Below is the list of variables which you might want to set in gitweb config.
-See the top of 'gitweb.cgi' for the full list of variables and their
-descriptions.
-
-Gitweb config file variables
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-You can set, among others, the following variables in gitweb config files
-(with the exception of $projectroot and $projects_list this list does
-not include variables usually directly set during build):
- * $GIT
-   Core git executable to use.  By default set to "$GIT_BINDIR/git", which
-   in turn is by default set to "$(bindir)/git".  If you use git from binary
-   package, set this to "/usr/bin/git".  This can just be "git" if your
-   webserver has a sensible PATH.  If you have multiple git versions
-   installed it can be used to choose which one to use.
- * $version
-   Gitweb version, set automatically when creating gitweb.cgi from
-   gitweb.perl. You might want to modify it if you are running modified
-   gitweb.
- * $projectroot
-   Absolute filesystem path which will be prepended to project path;
-   the path to repository is $projectroot/$project.  Set to
-   $GITWEB_PROJECTROOT during installation.  This variable have to be
-   set correctly for gitweb to find repositories.
- * $projects_list
-   Source of projects list, either directory to scan, or text file
-   with list of repositories (in the "<URI-encoded repository path> SP
-   <URI-encoded repository owner>" line format; actually there can be
-   any sequence of whitespace in place of space (SP)).  Set to
-   $GITWEB_LIST during installation.  If empty, $projectroot is used
-   to scan for repositories.
- * $my_url, $my_uri
-   Full URL and absolute URL of gitweb script;
-   in earlier versions of gitweb you might have need to set those
-   variables, now there should be no need to do it.  See
-   $per_request_config if you need to set them still.
- * $base_url
-   Base URL for relative URLs in pages generated by gitweb,
-   (e.g. $logo, $favicon, @stylesheets if they are relative URLs),
-   needed and used only for URLs with nonempty PATH_INFO via
-   <base href="$base_url">.  Usually gitweb sets its value correctly,
-   and there is no need to set this variable, e.g. to $my_uri or "/".
-   See $per_request_config if you need to set it anyway.
- * $home_link
-   Target of the home link on top of all pages (the first part of view
-   "breadcrumbs").  By default set to absolute URI of a page ($my_uri).
- * @stylesheets
-   List of URIs of stylesheets (relative to base URI of a page). You
-   might specify more than one stylesheet, for example use gitweb.css
-   as base, with site specific modifications in separate stylesheet
-   to make it easier to upgrade gitweb. You can add 'site' stylesheet
-   for example by using
-      push @stylesheets, "gitweb-site.css";
-   in the gitweb config file.
- * $logo_url, $logo_label
-   URI and label (title) of GIT logo link (or your site logo, if you choose
-   to use different logo image). By default they point to git homepage;
-   in the past they pointed to git documentation at www.kernel.org.
- * $projects_list_description_width
-   The width (in characters) of the projects list "Description" column.
-   Longer descriptions will be cut (trying to cut at word boundary);
-   full description is available as 'title' attribute (usually shown on
-   mouseover).  By default set to 25, which might be too small if you
-   use long project descriptions.
- * $projects_list_group_categories
-   Enables the grouping of projects by category on the project list page.
-   The category of a project is determined by the $GIT_DIR/category
-   file or the 'gitweb.category' variable in its repository configuration.
-   Disabled by default.
- * $project_list_default_category
-   Default category for projects for which none is specified.  If set
-   to the empty string, such projects will remain uncategorized and
-   listed at the top, above categorized projects.
- * @git_base_url_list
-   List of git base URLs used for URL to where fetch project from, shown
-   in project summary page.  Full URL is "$git_base_url/$project".
-   You can setup multiple base URLs (for example one for  git:// protocol
-   access, and one for http:// "dumb" protocol access).  Note that per
-   repository configuration in 'cloneurl' file, or as values of gitweb.url
-   project config.
- * $default_blob_plain_mimetype
-   Default mimetype for blob_plain (raw) view, if mimetype checking
-   doesn't result in some other type; by default 'text/plain'.
- * $default_text_plain_charset
-   Default charset for text files. If not set, web server configuration
-   would be used.
- * $mimetypes_file
-   File to use for (filename extension based) guessing of MIME types before
-   trying /etc/mime.types. Path, if relative, is taken currently as
-   relative to the current git repository.
- * $fallback_encoding
-   Gitweb assumes this charset if line contains non-UTF-8 characters.
-   Fallback decoding is used without error checking, so it can be even
-   'utf-8'. Value must be valid encoding; see Encoding::Supported(3pm) man
-   page for a list.   By default 'latin1', aka. 'iso-8859-1'.
- * @diff_opts
-   Rename detection options for git-diff and git-diff-tree. By default
-   ('-M'); set it to ('-C') or ('-C', '-C') to also detect copies, or
-   set it to () if you don't want to have renames detection.
- * $prevent_xss
-   If true, some gitweb features are disabled to prevent content in
-   repositories from launching cross-site scripting (XSS) attacks.  Set this
-   to true if you don't trust the content of your repositories. The default
-   is false.
- * $maxload
-   Used to set the maximum load that we will still respond to gitweb queries.
-   If server load exceed this value then return "503 Service Unavailable" error.
-   Server load is taken to be 0 if gitweb cannot determine its value.  Set it to
-   undefined value to turn it off.  The default is 300.
- * $highlight_bin
-   Path to the highlight executable to use (must be the one from
-   http://www.andre-simon.de due to assumptions about parameters and output).
-   Useful if highlight is not installed on your webserver's PATH.
-   [Default: highlight]
- * $per_request_config
-   If set to code reference, it would be run once per each request.  You can
-   set parts of configuration that change per session, e.g. by setting it to
-     sub { $ENV{GL_USER} = $cgi->remote_user || "gitweb"; }
-   Otherwise it is treated as boolean value: if true gitweb would process
-   config file once per request, if false it would process config file only
-   once.  Note: $my_url, $my_uri, and $base_url are overwritten with
-   their default values before every request, so if you want to change
-   them, be sure to set this variable to true or a code reference effecting
-   the desired changes.  The default is true.
+See also gitweb.conf(5) manpage.
+
 
 Projects list file format
 ~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
1.7.5
