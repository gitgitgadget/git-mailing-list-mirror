From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCHv3 5/5] gitweb: Starting work on a man page for gitweb (WIP)
Date: Mon,  6 Jun 2011 19:44:31 +0200
Message-ID: <1307382271-7677-6-git-send-email-jnareb@gmail.com>
References: <1307382271-7677-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>,
	Drew Northup <drew.northup@maine.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 20:03:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTe8w-0002EJ-MY
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 20:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757064Ab1FFSDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 14:03:07 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42149 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289Ab1FFSDE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 14:03:04 -0400
Received: by wya21 with SMTP id 21so2989155wya.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 11:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=PW9CL6okO9b8wUI0N45fW4oJroWJZ4xm0S/hsLknS4c=;
        b=sNe2L5lEil/KR4P16hykWapIrEm75wGmyuXXa6Uga+Qa2rCR8kcVifcsaKTa9DWvOS
         tZx4Glyizvfqr0XeuDd1Tkp9R3HXCv9oIk1kxgP2JwcJMfhNgoUYlbZOk+lmszO4qBfV
         JvrReCNa6DCOrjhSUbH/GhP7tLpcZUnvAdo1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=g9ranE557c5nz1AjGMHOcCZdQ928NxigZTDUFtYWC6SraV907qOjHCGvKiEN18UoM8
         zKaBkRm1bh+mJEcajFI4ezQdPaE3+zHnGEoxjDmdjNfBysRl1kCiEtic2aknv5kVoNLp
         VIZpSqZUTMoNoeX2qq60z5G0VzK5MGvmbBgVc=
Received: by 10.216.27.67 with SMTP id d45mr3267588wea.21.1307383382098;
        Mon, 06 Jun 2011 11:03:02 -0700 (PDT)
Received: from localhost.localdomain (abwr100.neoplus.adsl.tpnet.pl [83.8.241.100])
        by mx.google.com with ESMTPS id t79sm2440982weq.5.2011.06.06.11.02.58
        (version=SSLv3 cipher=OTHER);
        Mon, 06 Jun 2011 11:03:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1307382271-7677-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175146>

Gitweb documentation currently consist of gitweb/README, gitweb/INSTALL
and comments in gitweb source code.  This is harder to find, use and
browse that manpages ("man gitweb" or "git help gitweb") and HTML
documentation ("git help --web gitweb").

The goal is to move documentation out of gitweb/README to gitweb.txt and
gitweb.conf.txt manpages, reducing its size 10x from around 500 to
around 50 lines (two pages), and move information not related drectly to
building and installing gitweb out of gitweb/INSTALL there.

To build gitweb documentation you can use

  make -C gitweb doc

or

  cd gitweb; make doc


This is a work in progress.  Much of what is in it has been pulled
directly from the README and INSTALL files of gitweb.  Some effort
has been made to de-duplicate any of this, i.e. to remove contents
from gitweb/README and gitweb/INSTALL.  The AsciiDoc might (and
probably does) contain formatting errors.

Inspired and somewhat modelled by SVN::Web manpage.

Inspired-by: Drew Northup <drew.northup@maine.edu>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
As you can see it is now much longer (702 lines versus 334 in previous
"skeleton" version).

Differences from previous version:

* Duplicated contents removed from gitweb/INSTALL and gitweb/README,
  but leaving simplest cases to make them a bit more self-contained.

* Added some references from gitweb.conf.txt to gitweb.txt

* Added "Generating projects list using gitweb", "Controlling access
  to git repositories", "Per-repository gitweb configuration"
  sections, and "Advanced web server setup" chapter.

 Documentation/Makefile        |    2 +-
 Documentation/gitweb.conf.txt |    8 +
 Documentation/gitweb.txt      |  702 +++++++++++++++++++++++++++++++++++++++++
 gitweb/INSTALL                |   96 +-----
 gitweb/README                 |  278 ++---------------
 5 files changed, 740 insertions(+), 346 deletions(-)
 create mode 100644 Documentation/gitweb.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 68d0ebb..2fcbeac 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,7 +1,7 @@
 MAN1_TXT= \
 	$(filter-out $(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
 		$(wildcard git-*.txt)) \
-	gitk.txt git.txt
+	gitk.txt gitweb.txt git.txt
 MAN5_TXT=gitattributes.txt gitignore.txt gitmodules.txt githooks.txt \
 	gitrepository-layout.txt gitweb.conf.txt
 MAN7_TXT=gitcli.txt gittutorial.txt gittutorial-2.txt \
diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index 2bfe2e5..8dece6a 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -36,6 +36,10 @@ CGI script with the default name 'gitweb_config.perl' -- allowing
 one to have multiple gitweb instances with different configurations by
 the use of symlinks.
 
+Note that some configuration can be controlled on per-repository rather than
+gitweb-wide basis: see "Per-repository gitweb configuration" subsection on
+linkgit:gitweb[1] manpage.
+
 
 DISCUSSION
 ----------
@@ -88,6 +92,8 @@ Location of repositories
 Configuration variables described below control finding git repositories by
 gitweb, and control display and access to repositories.
 
+See also "Repositories" and later subsections in linkgit:gitweb[1] manpage.
+
 $projectroot::
 	Absolute filesystem path which will be prepended to project path;
 	the path to repository is `$projectroot/$project`.  Set to
@@ -143,6 +149,8 @@ though the above might be done by using `$export_ok` instead
 ----------------------------------------------------------------------------
 our $export_ok = "git-daemon-export-ok";
 ----------------------------------------------------------------------------
+See also more involved example in "Controlling access to git repositories"
+subsection on linkgit:gitweb[1] manpage.
 
 $strict_export::
 	Only allow viewing of repositories also shown on the overview page.
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
new file mode 100644
index 0000000..53af722
--- /dev/null
+++ b/Documentation/gitweb.txt
@@ -0,0 +1,702 @@
+gitweb(1)
+=========
+
+NAME
+----
+gitweb - Git web interface (web frontend to Git repositories)
+
+SYNOPSIS
+--------
+To get started with gitweb, run linkgit:git-instaweb[1] from a git repository.
+This would configure and start your web server and run web browser pointing to
+gitweb page.
+
+See http://git.kernel.org/?p=git/git.git;a=tree;f=gitweb or
+http://repo.or.cz/w/git.git/tree/HEAD:/gitweb/ for gitweb source code, browsed
+using gitweb.
+
+
+DESCRIPTION
+-----------
+Gitweb provides a web interface to git repositories.  It's features include:
+
+* Viewing multiple Git repositories with common root.
+* Browsing every revision of the repository.
+* Viewing the contents of files in the repository at any revision.
+* Viewing the revision log of branches, history of files and directories,
+  see what was changed when, by who.
+* Viewing the blame/annotation details of any file (if enabled).
+* Generating RSS and Atom feeds of commits, for any branch.
+  The feeds are auto-discoverable in modern web browsers.
+* Viewing everything that was changed in a revision, and step through
+  revisions one at a time, viewing the history of the repository.
+* Finding commits which commit messages matches given search term.
+
+CONFIGURATION
+-------------
+Various aspects of gitweb's behavior can be controlled through the configuration
+file 'gitweb_conf.perl' or '/etc/gitweb.conf'.  See the linkgit:gitweb.conf[5]
+for details.
+
+Repositories
+~~~~~~~~~~~~
+Gitweb can show information from one or more Git repositories.  These
+repositories have to be all on local filesystem, and have to share common
+repository root, i.e. be all under a single parent repository (but see also
+"Advanced web server setup" section, "Webserver configuration with multiple
+projects' root" subsection).
+
+-----------------------------------------------------------------------
+our $projectroot = '/path/to/parent/directory';
+-----------------------------------------------------------------------
+
+The default value for `$projectroot` is '/pub/git'.  You can change it during
+building gitweb via `GITWEB_PROJECTROOT` build configuration variable.
+
+By default all git repositories under `$projectroot` are visible and available
+to gitweb.  The list of projects is generated by default by scanning the
+`$projectroot` directory for git repositories (for object databases to be
+more exact; gitweb is not interested in a working area, and is best suited
+to showing "bare" repositories).
+
+The name of repository in gitweb is path to it's `$GIT_DIR` (it's object
+database) relative to `$projectroot`.  Therefore the repository $repo can be
+found at "$projectroot/$repo".
+
+
+Projects list file format
+~~~~~~~~~~~~~~~~~~~~~~~~~
+Instead of having gitweb find repositories by scanning filesystem starting from
+$projectroot, you can provide a pre-generated list of [visible] projects by
+setting `$projects_list` to a plain text file with a list of projects (with some
+additional info).
+
+This file uses the following format:
+
+* One record (for project / repository) per line; does not support line
+continuation (newline escaping).
+
+* Leading and trailing whitespace are ignored.
+
+* Whitespace separated fields; any run of whitespace can be used as field
+separator (rules for Perl's "`split(" ", $line)`").
+
+* Fields use modified URI encoding, defined in RFC 3986, section 2.1
+(Percent-Encoding), or rather "Query string encoding" (see
+link:http://en.wikipedia.org/wiki/Query_string#URL_encoding[]), the difference
+being that SP (" ") can be encoded as "{plus}" (and therefore "{plus}" has to be
+also percent-encoded).
++
+Reserved characters are: "%" (used for encoding), "{plus}" (can be used to
+encode SPACE), all whitespace characters as defined in Perl, including SP,
+TAB and LF, (used to separate fields in a record).
+
+* Currently recognized fields are:
+<repository path>::
+	path to repository GIT_DIR, relative to `$projectroot`
+<repository owner>::
+	displayed as repository owner, preferably full name, or email,
+	or both
+
+You can generate the projects list index file using the project_index action
+(the 'TXT' link on projects list page) directly from gitweb; see also
+"Generating projects list using gitweb" section below.
+
+Example contents:
+-----------------------------------------------------------------------
+foo.git       Joe+R+Hacker+<joe@example.com>
+foo/bar.git   O+W+Ner+<owner@example.org>
+-----------------------------------------------------------------------
+
+
+By default this file controls only which projects are *visible* on projects
+list page (note that entries that do not point to correctly recognized git
+repositories won't be displayed by gitweb).  Even if a project is not
+visible on projects list page, you can view it nevertheless by hand-crafting
+a gitweb URL.  By setting `$strict_export` configuration variable (see
+linkgit:gitweb.conf[5]) to true value you can allow viewing only of
+repositories also shown on the overview page (i.e. only projects explicitely
+listed in projects list file will be accessible).
+
+
+Generating projects list using gitweb
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+We assume that GITWEB_CONFIG has its default Makefile value, namely
+'gitweb_config.perl'. Put the following in 'gitweb_make_index.perl' file:
+----------------------------------------------------------------------------
+read_config_file("gitweb_config.perl");
+
+$projects_list = $projectroot; # with gitweb_make_index.perl scan for repos
+----------------------------------------------------------------------------
+
+Then create the following script to get list of project in the format
+suitable for GITWEB_LIST build configuration variable (or
+`$projects_list` variable in gitweb config):
+
+----------------------------------------------------------------------------
+#!/bin/sh
+
+export GITWEB_CONFIG="gitweb_make_index.perl"
+export GATEWAY_INTERFACE="CGI/1.1"
+export HTTP_ACCEPT="*/*"
+export REQUEST_METHOD="GET"
+export QUERY_STRING="a=project_index"
+
+perl -- /var/www/cgi-bin/gitweb.cgi
+----------------------------------------------------------------------------
+
+Run this script and save its output to a file.  This file could then be used
+as projects list file, which means that you can set `$projects_list` to its
+filename.
+
+
+Controlling access to git repositories
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+By default all git repositories under `$projectroot` are visible and
+available to gitweb.  You can however configure how gitweb controls access
+to repositories.
+
+* As described in "Projects list file format" section, you can control which
+projects are *visible* by selectively including repositories in projects
+list file, and setting `$projects_list` gitweb configuration variable to
+point to it.  With `$strict_export` set, projects list file can be used to
+control which repositories are *available* as well.
+
+* You can configure gitweb to only list and allow viewing of the explicitly
+exported repositories, via `$export_ok` variable in gitweb config file; see
+linkgit:gitweb.conf[5] manpage.  If it evaluates to true, gitweb shows
+repositories only if this file named by `$export_ok` exists in its object
+database (if directory has the magic file named `$export_ok`).
++
+For example linkgit:git-daemon[1] by default (unless `--export-all` option
+is used) allows pulling only for those repositories that have
+'git-daemon-export-ok' file.  Adding
++
+--------------------------------------------------------------------------
+our $export_ok = "git-daemon-export-ok";
+--------------------------------------------------------------------------
++
+makes gitweb show and allow access only to those repositories that can be
+fetched from via `git://` protocol.
+
+* Finally, it is possible to specify an arbitrary perl subroutine that will
+be called for each repository to determine if it can be exported.  The
+subroutine receives an absolute path to the project (repository) as its only
+parameter (i.e. "$projectroot/$project").
++
+For example, if you use mod_perl to run the script, and have dumb
+http protocol authentication configured for your repositories, you
+can use the following hook to allow access only if the user is
+authorized to read the files:
++
+--------------------------------------------------------------------------
+$export_auth_hook = sub {
+	use Apache2::SubRequest ();
+	use Apache2::Const -compile => qw(HTTP_OK);
+	my $path = "$_[0]/HEAD";
+	my $r    = Apache2::RequestUtil->request;
+	my $sub  = $r->lookup_file($path);
+	return $sub->filename eq $path
+	    && $sub->status == Apache2::Const::HTTP_OK;
+};
+--------------------------------------------------------------------------
+
+
+Per-repository gitweb configuration
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+You can configure individual repositories shown in gitweb by creating file
+in the 'GIT_DIR' of git repository, or by setting some repo configuration
+variable (in 'GIT_DIR/config', see linkgit:git-config[1]).
+
+You can use the following files in repository:
+
+README.html::
+	A html file (HTML fragment) which is included on the gitweb project
+	"summary" page inside `<div>` block element. You can use it for longer
+	description of a project, to provide links (for example to project's
+	homepage), etc. This is recognized only if XSS prevention is off
+	(`$prevent_xss` is false, see linkgit:gitweb.conf[5]); a way to include
+	a README safely when XSS prevention is on may be worked out in the
+	future.
+
+description (or `gitweb.description`)::
+	Short (shortened to `$projects_list_description_width` in the projects
+	list page, which is 25 characters by default; see
+	linkgit:gitweb.conf[5]) single line description of a project (of a
+	repository).  Plain text file; HTML will be escaped.  By default set to
+-------------------------------------------------------------------------------
+Unnamed repository; edit this file to name it for gitweb.
+-------------------------------------------------------------------------------
+from the template during repository creation, usually installed in
+'/usr/share/git-core/templates/'.  You can use the `gitweb.description` repo
+configuration variable, but the file takes precedence.
+
+category (or `gitweb.category`)::
+	Singe line category of a project, used to group projects if
+	`$projects_list_group_categories` is enabled.  By default (file and
+	configuration variable absent), uncategorized projects are put in the
+	`$project_list_default_category` category.  You can use the
+	`gitweb.category` repo configuration variable, but the file takes
+	precedence.
+
+	The configuration variables `$projects_list_group_categories` and
+	`$project_list_default_category` are described in linkgit:gitweb.conf[5]
+
+cloneurl (or multiple-valued `gitweb.url`)::
+	File with repository URL (used for clone and fetch), one per line.
+	Displayed in the project summary page. You can use multiple-valued
+	`gitweb.url` repository configuration variable for that, but the file
+	takes precedence.
+
+	This is per-repository enhancement / version of global prefix-based
+	`@git_base_url_list` gitweb configuration variable (see
+	linkgit:gitweb.conf[5]).
+
+gitweb.owner::
+	You can use the `gitweb.owner` repository configuration variable to set
+	repository's owner.  It is displayed in the project list and summary
+	page.
+
+	If it's not set, filesystem directory's owner is used (via GECOS field,
+	i.e. real name field from *getpwuid*(3)) if `$projects_list` is unset
+	(gitweb scans `$projectroot` for repositories); if `$projects_list`
+	points to file with list of repositories, then project owner defaults to
+	value from this file for given repository.
+
+various `gitweb.*` config variables (in config)::
+	Read description of `%feature` hash for detailed list, and descriptions.
+	See also "Configuring gitweb features" section in linkgit:gitweb.conf[5]
+
+
+ACTIONS, AND URLS
+-----------------
+Gitweb can use path_info (component) based URLs, or it can pass all necessary
+information via query parameters.  The typical gitweb URLs are broken down in to
+five components:
+
+-----------------------------------------------------------------------
+.../gitweb.cgi/<repo>/<action>/<revision>:/<path>?<arguments>
+-----------------------------------------------------------------------
+
+repo::
+	The repository the action will be performed on.
++
+	All actions except for those that list all available projects,
+	in whatever form, require this parameter.
+
+action::
+	The action that will be run.  Defaults to 'projects_list' if repo
+	is not set, and to 'summary' otherwise.
+
+revision::
+	Revision shown.  Defaults to HEAD.
+
+path::
+	The path within the <repository> that the action is performed on,
+	for those actions that require it.
+
+arguments::
+	Any arguments that control the behaviour of the action.
+
+Some actions require or allow to specify two revisions, and sometimes even two
+pathnames.  In most general form such path_info (component) based gitweb URL
+looks like this:
+
+-----------------------------------------------------------------------
+.../gitweb.cgi/<repo>/<action>/<revision_from>:/<path_from>..<revision_to>:/<path_to>?<arguments>
+-----------------------------------------------------------------------
+
+
+Each action is implemented as a subroutine, and must be present in %actions
+hash.  Some actions are disabled by default, and must be turned on via feature
+mechanism.  For example to enable 'blame' view add the following to gitweb
+configuration file:
+
+-----------------------------------------------------------------------
+$feature{'blame'}{'default'} = [1];
+-----------------------------------------------------------------------
+
+
+Actions:
+~~~~~~~~
+The standard actions are:
+
+project_list::
+	Lists the available Git repositories.  This is the default command if no
+	repository is specified in the URL.
+
+summary::
+	Displays summary about given repository.  This is the default command if
+	no action is specified in URL, and only repository is specified.
+
+heads::
+remotes::
+	Lists all local or all remote-tracking branches in given repository.
++
+	The latter is not available by default, unless configured.
+
+tags::
+	List all tags (lightweight and annotated) in given repository.
+
+blob::
+tree::
+	Shows the files and directories in a given repository path, at given
+	revision.  This is default command if no action is specified in the URL,
+	and path is given.
+
+blob_plain::
+	Returns the raw data for the file in given repository, at given path and
+	revision.  Links to this action are marked 'raw'.
+
+blobdiff::
+	Shows the difference between two revisions of the same file.
+
+blame::
+blame_incremental::
+	Shows the blame (also called annotation) information for a file. On a
+	per line basis it shows the revision in which that line was last changed
+	and the user that committed the change.  The incremental version (which
+	if configured is used automatically when JavaScript is enabled) uses
+	Ajax to incrementally add blame info to the contents of given file.
++
+	This action is disabled by default for performance reasons.
+
+commit::
+commitdiff::
+	Shows information about a specific commit in a repository.  The 'commit'
+	view shows information about commit in more detail, the 'commitdiff'
+	action shows changeset for given commit.
+
+patch:: 
+	Returns the commit in plain text mail format, suitable for applying with
+	linkgit:git-am[1].
+
+tag::
+	Display specific annotated tag (tag object).	
+
+log::
+shortlog::
+	Shows log information (commit message or just commit subject) for a
+	given branch (starting from given revision).
++
+	The 'shortlog' view is more compact; it shows one commit per line.
+
+history::
+	Shows history of the file or directory in a given repository path,
+	starting from given revision (defaults to HEAD, i.e. default branch).
++
+	This view is similar to 'shortlog' view.
+
+rss::
+atom::
+	Generates an RSS (or Atom) feed of changes to repository.
+
+
+WEBSERVER CONFIGURATION
+-----------------------
+This section explains how to configure some common webservers to run gitweb. In
+all cases, `/path/to/gitweb` in the examples is the directory you ran installed
+gitweb in, and contains `gitweb_config.perl`.
+
+If you've configured a web server that isn't listed here for gitweb, please send
+in the instructions so they can be included in a future release.
+
+Apache as CGI
+~~~~~~~~~~~~~
+Apache must be configured to support CGI scripts in the directory in
+which gitweb is installed.  Let's assume that it is '/var/www/cgi-bin'
+directory.
+
+-----------------------------------------------------------------------
+ScriptAlias /cgi-bin/ "/var/www/cgi-bin/"
+
+<Directory "/var/www/cgi-bin">
+    Options Indexes FollowSymlinks ExecCGI
+    AllowOverride None
+    Order allow,deny
+    Allow from all
+</Directory>
+-----------------------------------------------------------------------
+
+With that configuration the full path to browse repositories would be:
+
+  http://server/cgi-bin/gitweb.cgi
+
+Apache with mod_perl, via ModPerl::Registry
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+You can use mod_perl with gitweb.  You must install Apache::Registry
+(for mod_perl 1.x) or ModPerl::Registry (for mod_perl 2.x) to enable
+this support.
+
+Assuming that gitweb is installed to '/var/www/perl', the following
+Apache configuration (for mod_perl 2.x) is suitable.
+
+-----------------------------------------------------------------------
+Alias /perl "/var/www/perl"
+
+<Directory "/var/www/perl">
+    SetHandler perl-script
+    PerlResponseHandler ModPerl::Registry
+    PerlOptions +ParseHeaders
+    Options Indexes FollowSymlinks +ExecCGI
+    AllowOverride None
+    Order allow,deny
+    Allow from all
+</Directory>
+-----------------------------------------------------------------------
+
+With that configuration the full path to browse repositories would be:
+
+  http://server/perl/gitweb.cgi
+
+Apache with FastCGI
+~~~~~~~~~~~~~~~~~~~
+Gitweb works with Apache and FastCGI.  First you need to rename, copy
+or symlink gitweb.cgi to gitweb.fcgi.  Let's assume that gitweb is
+installed in '/usr/share/gitweb' directory.  The following Apache
+configuration is suitable (UNTESTED!)
+
+-----------------------------------------------------------------------
+FastCgiServer /usr/share/gitweb/gitweb.cgi
+ScriptAlias /gitweb /usr/share/gitweb/gitweb.cgi
+
+Alias /gitweb/static /usr/share/gitweb/static
+<Directory /usr/share/gitweb/static>
+    SetHandler default-handler
+</Directory>
+-----------------------------------------------------------------------
+
+With that configuration the full path to browse repositories would be:
+
+  http://server/gitweb
+
+
+ADVANCED WEB SERVER SETUP
+-------------------------
+All of those examples use request rewriting, and need `mod_rewrite`
+(or equivalent; examples below are written for Apache).
+
+Single URL for gitweb and for fetching
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+If you want to have one URL for both gitweb and your `http://`
+repositories, you can configure Apache like this:
+
+-----------------------------------------------------------------------
+<VirtualHost *:80>
+    ServerName    git.example.org
+    DocumentRoot  /pub/git
+    SetEnv        GITWEB_CONFIG   /etc/gitweb.conf
+
+    # turning on mod rewrite
+    RewriteEngine on
+
+    # make the front page an internal rewrite to the gitweb script
+    RewriteRule ^/$  /cgi-bin/gitweb.cgi
+
+    # make access for "dumb clients" work
+    RewriteRule ^/(.*\.git/(?!/?(HEAD|info|objects|refs)).*)?$ \
+                /cgi-bin/gitweb.cgi%{REQUEST_URI}  [L,PT]
+</VirtualHost>
+-----------------------------------------------------------------------
+
+The above configuration expects your public repositories to live under
+'/pub/git' and will serve them as `http://git.domain.org/dir-under-pub-git`,
+both as cloneable GIT URL and as browseable gitweb interface.  If you then
+start your linkgit:git-daemon[1] with `--base-path=/pub/git --export-all`
+then you can even use the `git://` URL with exactly the same path.
+
+Setting the environment variable `GITWEB_CONFIG` will tell gitweb to use the
+named file (i.e. in this example '/etc/gitweb.conf') as a configuration for
+gitweb.  You don't really need it in above example; it is required only if
+your configuration file is in different place than built-in (during
+compiling gitweb) 'gitweb_config.perl' or '/etc/gitweb.conf'.  See
+linkgit:gitweb.conf[5] for details, especially information about precedence
+rules.
+
+If you use the rewrite rules from the example you *might* also need
+something like the following in your gitweb configuration file
+('/etc/gitweb.conf' following example):
+----------------------------------------------------------------------------
+@stylesheets = ("/some/absolute/path/gitweb.css");
+$my_uri    = "/";
+$home_link = "/";
+$per_request_config = 1;
+----------------------------------------------------------------------------
+Nowadays though gitweb should create HTML base tag when needed (to set base
+URI for relative links), so it should work automatically.
+
+
+Webserver configuration with multiple projects' root
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+If you want to use gitweb with several project roots you can edit your
+Apache virtual host and gitweb configuration files in the following way.
+
+The virtual host configuration (in Apache configuration file) should look
+like this:
+--------------------------------------------------------------------------
+<VirtualHost *:80>
+    ServerName    git.example.org
+    DocumentRoot  /pub/git
+    SetEnv        GITWEB_CONFIG  /etc/gitweb.conf
+
+    # turning on mod rewrite
+    RewriteEngine on
+
+    # make the front page an internal rewrite to the gitweb script
+    RewriteRule ^/$  /cgi-bin/gitweb.cgi  [QSA,L,PT]
+
+    # look for a public_git folder in unix users' home
+    # http://git.example.org/~<user>/
+    RewriteRule ^/\~([^\/]+)(/|/gitweb.cgi)?$	/cgi-bin/gitweb.cgi \
+                [QSA,E=GITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]
+
+    # http://git.example.org/+<user>/
+    #RewriteRule ^/\+([^\/]+)(/|/gitweb.cgi)?$	/cgi-bin/gitweb.cgi \
+                 [QSA,E=GITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]
+
+    # http://git.example.org/user/<user>/
+    #RewriteRule ^/user/([^\/]+)/(gitweb.cgi)?$	/cgi-bin/gitweb.cgi \
+                 [QSA,E=GITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]
+
+    # defined list of project roots
+    RewriteRule ^/scm(/|/gitweb.cgi)?$ /cgi-bin/gitweb.cgi \
+                [QSA,E=GITWEB_PROJECTROOT:/pub/scm/,L,PT]
+    RewriteRule ^/var(/|/gitweb.cgi)?$ /cgi-bin/gitweb.cgi \
+                [QSA,E=GITWEB_PROJECTROOT:/var/git/,L,PT]
+
+    # make access for "dumb clients" work
+    RewriteRule ^/(.*\.git/(?!/?(HEAD|info|objects|refs)).*)?$ \
+                /cgi-bin/gitweb.cgi%{REQUEST_URI}  [L,PT]
+</VirtualHost>
+--------------------------------------------------------------------------
+
+Here actual project root is passed to gitweb via `GITWEB_PROJECT_ROOT`
+environment variable from a web server, so you need to put the following
+line in gitweb configuration file ('/etc/gitweb.conf' in above example):
+--------------------------------------------------------------------------
+$projectroot = $ENV{'GITWEB_PROJECTROOT'} || "/pub/git";
+--------------------------------------------------------------------------
+*Note* that this requires to be set for each request, so either
+`$per_request_config` must be false, or the above must be put in code
+referenced by `$per_request_config`;
+
+These configurations enable two things. First, each unix user (`<user>`) of
+the server will be able to browse through gitweb git repositories found in
+'~/public_git/' with the following url:
+
+  http://git.example.org/~<user>/
+
+If you do not want this feature on your server just remove the second
+rewrite rule.
+
+If you already use `mod_userdir` in your virtual host or you don't want to
+use the \'~' as first character, just comment or remove the second rewrite
+rule, and uncomment one of the following according to what you want.
+
+Second, repositories found in '/pub/scm/' and '/var/git/' will be accesible
+through `http://git.example.org/scm/` and `http://git.example.org/var/`.
+You can add as many project roots as you want by adding rewrite rules like
+the third and the fourth.
+
+
+PATH_INFO usage
+~~~~~~~~~~~~~~~
+If you enable PATH_INFO usage in gitweb by putting
+----------------------------------------------------------------------------
+$feature{'pathinfo'}{'default'} = [1];
+----------------------------------------------------------------------------
+in your gitweb configuration file, it is possible to set up your server so
+that it consumes and produces URLs in the form
+
+  http://git.example.com/project.git/shortlog/sometag
+
+i.e. without 'gitweb.cgi' part, by using a configuration such as the
+following.  This configuration assumes that '/var/www/gitweb' is the
+DocumentRoot of your webserver, contains the gitweb.cgi script and
+complementary static files (stylesheet, favicon, JavaScript):
+
+----------------------------------------------------------------------------
+<VirtualHost *:80>
+	ServerAlias git.example.com
+
+	DocumentRoot /var/www/gitweb
+
+	<Directory /var/www/gitweb>
+		Options ExecCGI
+		AddHandler cgi-script cgi
+
+		DirectoryIndex gitweb.cgi
+
+		RewriteEngine On
+		RewriteCond %{REQUEST_FILENAME} !-f
+		RewriteCond %{REQUEST_FILENAME} !-d
+		RewriteRule ^.* /gitweb.cgi/$0 [L,PT]
+	</Directory>
+</VirtualHost>
+----------------------------------------------------------------------------
+The rewrite rule guarantees that existing static files will be properly
+served, whereas any other URL will be passed to gitweb as PATH_INFO
+parameter.
+
+*Notice* that in this case you don't need special settings for
+`@stylesheets`, `$my_uri` and `$home_link`, but you lose "dumb client"
+access to your project .git dirs (described in "Single URL for gitweb and
+for fetching" section).  A possible workaround for the latter is the
+following: in your project root dir (e.g. '/pub/git') have the projects
+named *without* a .git extension (e.g. '/pub/git/project' instead of
+'/pub/git/project.git') and configure Apache as follows:
+----------------------------------------------------------------------------
+<VirtualHost *:80>
+	ServerAlias git.example.com
+
+	DocumentRoot /var/www/gitweb
+
+	AliasMatch ^(/.*?)(\.git)(/.*)?$ /pub/git$1$3
+	<Directory /var/www/gitweb>
+		Options ExecCGI
+		AddHandler cgi-script cgi
+
+		DirectoryIndex gitweb.cgi
+
+		RewriteEngine On
+		RewriteCond %{REQUEST_FILENAME} !-f
+		RewriteCond %{REQUEST_FILENAME} !-d
+		RewriteRule ^.* /gitweb.cgi/$0 [L,PT]
+	</Directory>
+</VirtualHost>
+----------------------------------------------------------------------------
+
+The additional AliasMatch makes it so that
+
+  http://git.example.com/project.git
+
+will give raw access to the project's git dir (so that the project can be
+cloned), while
+
+  http://git.example.com/project
+
+will provide human-friendly gitweb access.
+
+This solution is not 100% bulletproof, in the sense that if some project has
+a named ref (branch, tag) starting with 'git/', then paths such as
+
+  http://git.example.com/project/command/abranch..git/abranch
+
+will fail with a 404 error.
+
+
+BUGS
+----
+Please report any bugs or feature requests to git@vger.kernel.org,
+putting "gitweb" in the subject of email.
+
+SEE ALSO
+--------
+linkgit:gitweb.conf[5], linkgit:git-instaweb[1]
+
+'gitweb/README', 'gitweb/INSTALL'
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index c5236fe..c61fd62 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -229,7 +229,7 @@ Gitweb config file
 ------------------
 
 See also "Runtime gitweb configuration" section in README file
-for gitweb (in gitweb/README).
+for gitweb (in gitweb/README), and gitweb.conf(5) manpage.
 
 - You can configure gitweb further using the gitweb configuration file;
   by default this is a file named gitweb_config.perl in the same place as
@@ -276,97 +276,19 @@ adding the following lines to your $GITWEB_CONFIG:
 Gitweb repositories
 -------------------
 
-- By default all git repositories under projectroot are visible and
-  available to gitweb. The list of projects is generated by default by
-  scanning the projectroot directory for git repositories (for object
-  databases to be more exact).
-
-  You can provide a pre-generated list of [visible] repositories,
-  together with information about their owners (the project ownership
-  defaults to the owner of the repository directory otherwise), by setting
-  the GITWEB_LIST build configuration variable (or the $projects_list
-  variable in the gitweb config file) to point to a plain file.
-
-  Each line of the projects list file should consist of the url-encoded path
-  to the project repository database (relative to projectroot), followed
-  by the url-encoded project owner on the same line (separated by a space).
-  Spaces in both project path and project owner have to be encoded as either
-  '%20' or '+'.
-
-  Other characters that have to be url-encoded, i.e. replaced by '%'
-  followed by two-digit character number in octal, are: other whitespace
-  characters (because they are field separator in a record), plus sign '+'
-  (because it can be used as replacement for spaces), and percent sign '%'
-  (which is used for encoding / escaping).
-
-  You can generate the projects list index file using the project_index
-  action (the 'TXT' link on projects list page) directly from gitweb.
-
-- By default, even if a project is not visible on projects list page, you
-  can view it nevertheless by hand-crafting a gitweb URL. You can set the
-  GITWEB_STRICT_EXPORT build configuration variable (or the $strict_export
-  variable in the gitweb config file) to only allow viewing of
-  repositories also shown on the overview page.
-
-- Alternatively, you can configure gitweb to only list and allow
-  viewing of the explicitly exported repositories, via the
-  GITWEB_EXPORT_OK build configuration variable (or the $export_ok
-  variable in gitweb config file). If it evaluates to true, gitweb
-  shows repositories only if this file exists in its object database
-  (if directory has the magic file named $export_ok).
-
-- Finally, it is possible to specify an arbitrary perl subroutine that
-  will be called for each project to determine if it can be exported.
-  The subroutine receives an absolute path to the project as its only
-  parameter.
-
-  For example, if you use mod_perl to run the script, and have dumb
-  http protocol authentication configured for your repositories, you
-  can use the following hook to allow access only if the user is
-  authorized to read the files:
-
-    $export_auth_hook = sub {
-        use Apache2::SubRequest ();
-        use Apache2::Const -compile => qw(HTTP_OK);
-        my $path = "$_[0]/HEAD";
-        my $r    = Apache2::RequestUtil->request;
-        my $sub  = $r->lookup_file($path);
-        return $sub->filename eq $path
-            && $sub->status == Apache2::Const::HTTP_OK;
-    };
-
-
-Generating projects list using gitweb
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-We assume that GITWEB_CONFIG has its default Makefile value, namely
-gitweb_config.perl. Put the following in gitweb_make_index.perl file:
-
-	$GITWEB_CONFIG = "gitweb_config.perl";
-	do $GITWEB_CONFIG if -e $GITWEB_CONFIG;
-
-	$projects_list = $projectroot;
-
-Then create the following script to get list of project in the format
-suitable for GITWEB_LIST build configuration variable (or
-$projects_list variable in gitweb config):
-
-	#!/bin/sh
-
-	export GITWEB_CONFIG="gitweb_make_index.perl"
-	export GATEWAY_INTERFACE="CGI/1.1"
-	export HTTP_ACCEPT="*/*"
-	export REQUEST_METHOD="GET"
-	export QUERY_STRING="a=project_index"
-
-	perl -- /var/www/cgi-bin/gitweb.cgi
+By default gitweb shows all git repositories under single common repository
+root on a local filesystem; see description of GITWEB_PROJECTROOT build-time
+configuration variable above (and also of GITWEB_LIST).
+
+More advanced usage, like limiting access or visibility of repositories and
+managing multiple roots are described on gitweb manpage.
 
 
 Example web server configuration
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-See also "Webserver configuration" section in README file for gitweb
-(in gitweb/README).
+See also "Webserver configuration" and "Advanced web server setup" sections
+in gitweb(1) manpage.
 
 
 - Apache2, gitweb installed as CGI script,
diff --git a/gitweb/README b/gitweb/README
index 1e6cf27..b952d45 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -7,9 +7,18 @@ The one working on:
 From the git version 1.4.0 gitweb is bundled with git.
 
 
+Build time gitweb configuration
+-------------------------------
+There are many configuration variables which affect building gitweb (among
+others creating gitweb.cgi out of gitweb.perl by replacing placeholders such
+as `++GIT_BINDIR++` by their build-time values).
+
+Building and installing gitweb is described in gitweb's INSTALL file
+(in 'gitweb/INSTALL').
+
+
 Runtime gitweb configuration
 ----------------------------
-
 You can adjust gitweb behaviour using the file specified in `GITWEB_CONFIG`
 (defaults to 'gitweb_config.perl' in the same directory as the CGI), and
 as a fallback `GITWEB_CONFIG_SYSTEM` (defaults to /etc/gitweb.conf).
@@ -23,266 +32,19 @@ as comments inside 'gitweb.cgi'.
 See also gitweb.conf(5) manpage.
 
 
-Projects list file format
-~~~~~~~~~~~~~~~~~~~~~~~~~
-
-Instead of having gitweb find repositories by scanning filesystem starting
-from $projectroot (or $projects_list, if it points to directory), you can
-provide list of projects by setting $projects_list to a text file with list
-of projects (and some additional info).  This file uses the following
-format:
-
-One record (for project / repository) per line, whitespace separated fields;
-does not support (at least for now) lines continuation (newline escaping).
-Leading and trailing whitespace are ignored, any run of whitespace can be
-used as field separator (rules for Perl's "split(' ', $line)").  Keyed by
-the first field, which is project name, i.e. path to repository GIT_DIR
-relative to $projectroot.  Fields use modified URI encoding, defined in
-RFC 3986, section 2.1 (Percent-Encoding), or rather "Query string encoding"
-(see http://en.wikipedia.org/wiki/Query_string#URL_encoding), the difference
-being that SP (' ') can be encoded as '+' (and therefore '+' has to be also
-percent-encoded).  Reserved characters are: '%' (used for encoding), '+'
-(can be used to encode SPACE), all whitespace characters as defined in Perl,
-including SP, TAB and LF, (used to separate fields in a record).
-
-Currently list of fields is
- * <repository path>  - path to repository GIT_DIR, relative to $projectroot
- * <repository owner> - displayed as repository owner, preferably full name,
-                        or email, or both
-
-You can additionally use $projects_list file to limit which repositories
-are visible, and together with $strict_export to limit access to
-repositories (see "Gitweb repositories" section in gitweb/INSTALL).
-
-
-Per-repository gitweb configuration
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-You can also configure individual repositories shown in gitweb by creating
-file in the GIT_DIR of git repository, or by setting some repo configuration
-variable (in GIT_DIR/config).
-
-You can use the following files in repository:
- * README.html
-   A .html file (HTML fragment) which is included on the gitweb project
-   summary page inside <div> block element. You can use it for longer
-   description of a project, to provide links (for example to project's
-   homepage), etc. This is recognized only if XSS prevention is off
-   ($prevent_xss is false); a way to include a readme safely when XSS
-   prevention is on may be worked out in the future.
- * description (or gitweb.description)
-   Short (shortened by default to 25 characters in the projects list page)
-   single line description of a project (of a repository). Plain text file;
-   HTML will be escaped. By default set to
-     Unnamed repository; edit this file to name it for gitweb.
-   from the template during repository creation. You can use the
-   gitweb.description repo configuration variable, but the file takes
-   precedence.
- * category (or gitweb.category)
-   Singe line category of a project, used to group projects if
-   $projects_list_group_categories is enabled. By default (file and
-   configuration variable absent), uncategorized projects are put in
-   the $project_list_default_category category. You can use the
-   gitweb.category repo configuration variable, but the file takes
-   precedence.
- * cloneurl (or multiple-valued gitweb.url)
-   File with repository URL (used for clone and fetch), one per line.
-   Displayed in the project summary page. You can use multiple-valued
-   gitweb.url repository configuration variable for that, but the file
-   takes precedence.
- * gitweb.owner
-   You can use the gitweb.owner repository configuration variable to set
-   repository's owner. It is displayed in the project list and summary
-   page. If it's not set, filesystem directory's owner is used
-   (via GECOS field / real name field from getpwiud(3)).
- * various gitweb.* config variables (in config)
-   Read description of %feature hash for detailed list, and some
-   descriptions.
-
-
-Webserver configuration
------------------------
-
-If you want to have one URL for both gitweb and your http://
-repositories, you can configure apache like this:
-
-<VirtualHost *:80>
-    ServerName		git.example.org
-    DocumentRoot	/pub/git
-    SetEnv			GITWEB_CONFIG	/etc/gitweb.conf
-
-    # turning on mod rewrite
-    RewriteEngine on
-
-    # make the front page an internal rewrite to the gitweb script
-    RewriteRule ^/$  /cgi-bin/gitweb.cgi
-
-    # make access for "dumb clients" work
-    RewriteRule ^/(.*\.git/(?!/?(HEAD|info|objects|refs)).*)?$ /cgi-bin/gitweb.cgi%{REQUEST_URI}  [L,PT]
-</VirtualHost>
-
-The above configuration expects your public repositories to live under
-/pub/git and will serve them as http://git.domain.org/dir-under-pub-git,
-both as cloneable GIT URL and as browseable gitweb interface.
-If you then start your git-daemon with --base-path=/pub/git --export-all
-then you can even use the git:// URL with exactly the same path.
-
-Setting the environment variable GITWEB_CONFIG will tell gitweb to use
-the named file (i.e. in this example /etc/gitweb.conf) as a
-configuration for gitweb.  Perl variables defined in here will
-override the defaults given at the head of the gitweb.perl (or
-gitweb.cgi).  Look at the comments in that file for information on
-which variables and what they mean.
-
-If you use the rewrite rules from the example you'll likely also need
-something like the following in your gitweb.conf (or gitweb_config.perl) file:
-
-  @stylesheets = ("/some/absolute/path/gitweb.css");
-  $my_uri = "/";
-  $home_link = "/";
-
-
-Webserver configuration with multiple projects' root
-----------------------------------------------------
-
-If you want to use gitweb with several project roots you can edit your apache
-virtual host and gitweb.conf configuration files like this :
-
-virtual host configuration :
-
-<VirtualHost *:80>
-    ServerName			git.example.org
-    DocumentRoot		/pub/git
-    SetEnv				GITWEB_CONFIG	/etc/gitweb.conf
-
-    # turning on mod rewrite
-    RewriteEngine on
-
-    # make the front page an internal rewrite to the gitweb script
-    RewriteRule ^/$ 		/cgi-bin/gitweb.cgi [QSA,L,PT]
-
-    # look for a public_git folder in unix users' home
-    # http://git.example.org/~<user>/
-    RewriteRule ^/\~([^\/]+)(/|/gitweb.cgi)?$	/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]
-
-    # http://git.example.org/+<user>/
-    #RewriteRule ^/\+([^\/]+)(/|/gitweb.cgi)?$	/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]
-
-    # http://git.example.org/user/<user>/
-    #RewriteRule ^/user/([^\/]+)/(gitweb.cgi)?$	/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]
-
-    # defined list of project roots
-    RewriteRule ^/scm(/|/gitweb.cgi)?$		/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/pub/scm/,L,PT]
-    RewriteRule ^/var(/|/gitweb.cgi)?$		/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/var/git/,L,PT]
-
-    # make access for "dumb clients" work
-    RewriteRule ^/(.*\.git/(?!/?(HEAD|info|objects|refs)).*)?$ /cgi-bin/gitweb.cgi%{REQUEST_URI}  [L,PT]
-</VirtualHost>
-
-gitweb.conf configuration :
-
-$projectroot = $ENV{'GITWEB_PROJECTROOT'} || "/pub/git";
-
-These configurations enable two things. First, each unix user (<user>) of the
-server will be able to browse through gitweb git repositories found in
-~/public_git/ with the following url : http://git.example.org/~<user>/
-
-If you do not want this feature on your server just remove the second rewrite rule.
-
-If you already use mod_userdir in your virtual host or you don't want to use
-the '~' as first character just comment or remove the second rewrite rule and
-uncomment one of the following according to what you want.
-
-Second, repositories found in /pub/scm/ and /var/git/ will be accesible
-through http://git.example.org/scm/ and http://git.example.org/var/.
-You can add as many project roots as you want by adding rewrite rules like the
-third and the fourth.
-
-
-PATH_INFO usage
------------------------
-If you enable PATH_INFO usage in gitweb by putting
-
-   $feature{'pathinfo'}{'default'} = [1];
-
-in your gitweb.conf, it is possible to set up your server so that it
-consumes and produces URLs in the form
-
-http://git.example.com/project.git/shortlog/sometag
-
-by using a configuration such as the following, that assumes that
-/var/www/gitweb is the DocumentRoot of your webserver, and that it
-contains the gitweb.cgi script and complementary static files
-(stylesheet, favicon):
-
-<VirtualHost *:80>
-	ServerAlias git.example.com
-
-	DocumentRoot /var/www/gitweb
-
-	<Directory /var/www/gitweb>
-		Options ExecCGI
-		AddHandler cgi-script cgi
-
-		DirectoryIndex gitweb.cgi
-
-		RewriteEngine On
-		RewriteCond %{REQUEST_FILENAME} !-f
-		RewriteCond %{REQUEST_FILENAME} !-d
-		RewriteRule ^.* /gitweb.cgi/$0 [L,PT]
-	</Directory>
-</VirtualHost>
-
-The rewrite rule guarantees that existing static files will be properly
-served, whereas any other URL will be passed to gitweb as PATH_INFO
-parameter.
-
-Notice that in this case you don't need special settings for
-@stylesheets, $my_uri and $home_link, but you lose "dumb client" access
-to your project .git dirs. A possible workaround for the latter is the
-following: in your project root dir (e.g. /pub/git) have the projects
-named without a .git extension (e.g. /pub/git/project instead of
-/pub/git/project.git) and configure Apache as follows:
-
-<VirtualHost *:80>
-	ServerAlias git.example.com
-
-	DocumentRoot /var/www/gitweb
-
-	AliasMatch ^(/.*?)(\.git)(/.*)?$ /pub/git$1$3
-	<Directory /var/www/gitweb>
-		Options ExecCGI
-		AddHandler cgi-script cgi
-
-		DirectoryIndex gitweb.cgi
-
-		RewriteEngine On
-		RewriteCond %{REQUEST_FILENAME} !-f
-		RewriteCond %{REQUEST_FILENAME} !-d
-		RewriteRule ^.* /gitweb.cgi/$0 [L,PT]
-	</Directory>
-</VirtualHost>
-
-The additional AliasMatch makes it so that
-
-http://git.example.com/project.git
-
-will give raw access to the project's git dir (so that the project can
-be cloned), while
-
-http://git.example.com/project
-
-will provide human-friendly gitweb access.
-
-This solution is not 100% bulletproof, in the sense that if some project
-has a named ref (branch, tag) starting with 'git/', then paths such as
-
-http://git.example.com/project/command/abranch..git/abranch
-
-will fail with a 404 error.
+Web server configuration
+------------------------
+Gitweb can be run as CGI script, as legacy mod_perl application (using
+ModPerl::Registry), and as FastCGI script.  You can find some simple examples
+in "Example web server configuration" section in INSTALL file for gitweb (in
+gitweb/INSTALL).
 
+See "Webserver configuration" and "Advanced web server setup" sections in
+gitweb(1) manpage.
 
 
+AUTHORS
+-------
 Originally written by:
   Kay Sievers <kay.sievers@vrfy.org>
 
-- 
1.7.5
