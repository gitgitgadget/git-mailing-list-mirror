From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH] gitweb: Starting work on a man page for gitweb (WIP)
Date: Sun, 15 May 2011 12:34:28 +0200
Message-ID: <201105151234.29598.jnareb@gmail.com>
References: <1305141664.30104.11.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Petr Baudis <pasky@suse.cz>,
	Sylvain Rabot <sylvain@abstraction.fr>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Sun May 15 12:34:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLYez-0001eN-Uk
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 12:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755645Ab1EOKem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 06:34:42 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38730 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989Ab1EOKel (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 06:34:41 -0400
Received: by bwz15 with SMTP id 15so3067288bwz.19
        for <git@vger.kernel.org>; Sun, 15 May 2011 03:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:references
         :in-reply-to:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=SBLWOEUpW2hq5X0Ggp8c0kDfszeMaWczWe/4xFOgjdU=;
        b=YN1d6FyQacZiPPkAX68sAwlETesrxjEmkcSDPRiH0hqgjKfgZlWZHl/ogpgFjOaZO+
         qn7o8zJl3LD42FLTZO6AucOMKukt0sdEUeitY/s60vEHmelgGD3VNEOIZFKI/6B/6/CO
         5qAu5JZ/qSVG0n4Iuy/kuGFBS8kK8MPZQ8aeo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:cc
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=gNzeCqylY2KoUbxfBrYS7rAXXs0Ut5+A5NK4KeSbhgxXWMZKWx8u+GimtMwonO+0ey
         v+3Qz/F1XUkY8K8uqvvsexxeMCskc+CIkK7A7TIPW+dtqjp1ZakBTaMQF5OdiIDWc+tF
         N6D4druFIc/7wmt/CEO+Vjf+1nJlSGWAhLnJ8=
Received: by 10.204.84.203 with SMTP id k11mr1626552bkl.10.1305455679582;
        Sun, 15 May 2011 03:34:39 -0700 (PDT)
Received: from [192.168.1.13] (aeho161.neoplus.adsl.tpnet.pl [79.186.196.161])
        by mx.google.com with ESMTPS id 16sm2354076bkm.18.2011.05.15.03.34.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 May 2011 03:34:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1305141664.30104.11.camel@drew-northup.unet.maine.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173625>

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
directly from the README and INSTALL files of gitweb.  No effort has
yet been made to de-duplicate any of this, i.e. to remove contents
from gitweb/README and gitweb/INSTALL.  The AsciiDoc might (and
probably does) contain formatting errors.

Current version is almost direct translation of SVN::Web manpage, and
is missing much of information that finally are to be moved from
gitweb/README to here.

Inspired-by: Drew Northup <drew.northup@maine.edu>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is intended to go hand in hand with Drew's gitweb.conf.txt (which
probably should also go to Documentation).

The gitweb/Makefile change is here simply to be able to use "make doc"
from 'gitweb' directory, and have it work.  It would probably be more
in line what Documentation/Makefile does.

TODO:
  * Expand gitweb.txt beyond being simple translation of SVN::Web.3pm
    http://p3rl.org/SVN::Web
  * Fix and improve AsciiDoc formatting
  * Clean up gitweb/README and gitweb/INSTALL files
  * Make doc-related part of gitweb/Makefile more robust
  * Remove or rephrase redundant portions of original documentation
  * A lot more...

 Documentation/Makefile   |    2 +-
 Documentation/gitweb.txt |  216 ++++++++++++++++++++++++++++++++++++++++++++++
 git.spec.in              |    3 +
 gitweb/Makefile          |    7 ++
 4 files changed, 227 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/gitweb.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 36989b7..958c20a 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,7 +1,7 @@
 MAN1_TXT= \
 	$(filter-out $(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
 		$(wildcard git-*.txt)) \
-	gitk.txt git.txt
+	gitk.txt gitweb.txt git.txt
 MAN5_TXT=gitattributes.txt gitignore.txt gitmodules.txt githooks.txt \
 	gitrepository-layout.txt
 MAN7_TXT=gitcli.txt gittutorial.txt gittutorial-2.txt \
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
new file mode 100644
index 0000000..78cee1a
--- /dev/null
+++ b/Documentation/gitweb.txt
@@ -0,0 +1,216 @@
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
+file `gitweb_conf.perl` or `/etc/gitweb.conf`.  See the linkgit:gitweb.conf[5]
+for details.
+
+Repositories
+~~~~~~~~~~~~
+Gitweb can show information from one or more Git repositories.  These
+repositories have to be all on local filesystem, and have to share common
+repository root, i.e. be all under a single parent repository.
+
+-----------------------------------------------------------------------
+our $projectroot = '/path/to/parent/directory';
+-----------------------------------------------------------------------
+
+...
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
+	The action that will be run.
+
+revision::
+	Revision shown.
+
+path::
+	The path within the <repository> that the action is performed on.
+
+arguments::
+	Any arguments that control the behaviour of the action.
+
+...
+
+Each action is implemented as a subroutine, and must be present in %actions
+hash.  Some actions are disabled by default, and must be turned on via feature
+mechanism.
+
+The standard actions are:
+
+blame::
+blame_incremental::
+	Shows the blame (also called annotation) information for a file. On a
+	per line basis it shows the revision in which that line was last changed
+	and the user that committed the change.
++
+	This action is disabled by default for performance reasons.
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
+project_list::
+	Lists the available Git repositories.  This is the default command if no
+	repository is specified in the URL.
+
+log::
+shortlog::
+	Shows log information (commit message or just commit subject) for a
+	given branch (starting from given revision).
+
+commit::
+commitdiff::
+	Shows information about a specific commit in a repository.
+
+rss::
+atom::
+	Generates an RSS (or Atom) feed of changes to repository.
+
+WEB SERVERS
+-----------
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
+Apache configuration is suitable.
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
+BUGS
+----
+Please report any bugs or feature requests to git@vger.kernel.org,
+putting "gitweb" somewhere in the subject of email.
+
+SEE ALSO
+--------
+linkgit:gitweb.conf[5], linkgit:git-instaweb[1]
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
index 0a6ac00..945251e 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -112,6 +112,8 @@ endif
 
 GITWEB_FILES += static/git-logo.png static/git-favicon.png
 
+GITWEB_DOC = gitweb.1 gitweb.html
+
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
 	-e 's|++GIT_BINDIR++|$(bindir)|g' \
@@ -155,6 +157,11 @@ test-installed:
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
