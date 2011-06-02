From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/2] gitweb: Move information about installation from README to INSTALL
Date: Thu,  2 Jun 2011 16:55:52 +0200
Message-ID: <1307026553-1181-2-git-send-email-jnareb@gmail.com>
References: <1307026553-1181-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 16:56:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QS9K6-0001Vr-JY
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 16:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639Ab1FBO43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 10:56:29 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54507 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613Ab1FBO42 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 10:56:28 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so748737fxm.19
        for <git@vger.kernel.org>; Thu, 02 Jun 2011 07:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=tZrAyvgdnifklGr38weymCTaTXzowNqbjrY5fIjvW6Q=;
        b=sBCtjitXAbAjV8bBgvpw++Q/ct4oEKAgYqZ7TXbvu4vcBbgwHsl/5vQphHn3QYIaTx
         erHBj6z50WMEtGlf4zKbXjLMK6lYV4RII8Ko5rV3BDdgv4lDxoCDHZBFt3wJaG5ztezO
         apl2GivHfgL/P518pRHCU+Ooxz5ytn3MsZ0sc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Wa77RvhesSL4tYIJ0JdeFG1hi6qWBS76KLUvBxhwFvtT5/3iK4tsrQZVfeKOmp35E2
         swlJDgjgGPfr3HHuC4WVycr2AZuZPoUOLtB29t2rsXZ5+LLuxrAQmcFzJDeYcfO3teFu
         fCG6KquZKh47gXROHxOoqmgZ86j+lpKNrHHcY=
Received: by 10.223.75.146 with SMTP id y18mr934201faj.61.1307026587388;
        Thu, 02 Jun 2011 07:56:27 -0700 (PDT)
Received: from localhost.localdomain (abvc230.neoplus.adsl.tpnet.pl [83.8.200.230])
        by mx.google.com with ESMTPS id c1sm204029faa.37.2011.06.02.07.56.25
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Jun 2011 07:56:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1307026553-1181-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174955>

Almost straightformard moving of "How to configure gitweb for your
local system" section from gitweb/README to gitweb/INSTALL, as it is
about build time configuration.  Updated references to it.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/INSTALL |  115 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 gitweb/README  |  114 -------------------------------------------------------
 2 files changed, 113 insertions(+), 116 deletions(-)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 4964a67..32a52b7 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -28,8 +28,7 @@ scripts).
 Build time configuration
 ------------------------
 
-See also "How to configure gitweb for your local system" in README
-file for gitweb (in gitweb/README).
+See also "How to configure gitweb for your local system" section below.
 
 - There are many configuration variables which affect building of
   gitweb.cgi; see "default configuration for gitweb" section in main
@@ -73,6 +72,118 @@ file for gitweb (in gitweb/README).
   substitute gitweb.min.js and gitweb.min.css for all uses of gitweb.js and
   gitweb.css in the help files.
 
+
+How to configure gitweb for your local system
+---------------------------------------------
+
+You can specify the following configuration variables when building GIT:
+
+ * GIT_BINDIR
+   Points where to find the git executable.  You should set it up to
+   the place where the git binary was installed (usually /usr/bin) if you
+   don't install git from sources together with gitweb.  [Default: $(bindir)]
+ * GITWEB_SITENAME
+   Shown in the title of all generated pages, defaults to the server name
+   (SERVER_NAME CGI environment variable) if not set. [No default]
+ * GITWEB_PROJECTROOT
+   The root directory for all projects shown by gitweb. Must be set
+   correctly for gitweb to find repositories to display.  See also
+   "Gitweb repositories" in the INSTALL file for gitweb.  [Default: /pub/git]
+ * GITWEB_PROJECT_MAXDEPTH
+   The filesystem traversing limit for getting the project list; the number
+   is taken as depth relative to the projectroot.  It is used when
+   GITWEB_LIST is a directory (or is not set; then project root is used).
+   This is meant to speed up project listing on large work trees by limiting
+   search depth.  [Default: 2007]
+ * GITWEB_LIST
+   Points to a directory to scan for projects (defaults to project root
+   if not set / if empty) or to a file with explicit listing of projects
+   (together with projects' ownership). See "Generating projects list
+   using gitweb" in INSTALL file for gitweb to find out how to generate
+   such file from scan of a directory. [No default, which means use root
+   directory for projects]
+ * GITWEB_EXPORT_OK
+   Show repository only if this file exists (in repository).  Only
+   effective if this variable evaluates to true.  [No default / Not set]
+ * GITWEB_STRICT_EXPORT
+   Only allow viewing of repositories also shown on the overview page.
+   This for example makes GITWEB_EXPORT_OK to decide if repository is
+   available and not only if it is shown.  If GITWEB_LIST points to
+   file with list of project, only those repositories listed would be
+   available for gitweb.  [No default]
+ * GITWEB_HOMETEXT
+   Points to an .html file which is included on the gitweb project
+   overview page ('projects_list' view), if it exists.  Relative to
+   gitweb.cgi script.  [Default: indextext.html]
+ * GITWEB_SITE_HEADER
+   Filename of html text to include at top of each page.  Relative to
+   gitweb.cgi script.  [No default]
+ * GITWEB_SITE_FOOTER
+   Filename of html text to include at bottom of each page.  Relative to
+   gitweb.cgi script.  [No default]
+ * GITWEB_HOME_LINK_STR
+   String of the home link on top of all pages, leading to $home_link
+   (usually main gitweb page, which means projects list).  Used as first
+   part of gitweb view "breadcrumb trail": <home> / <project> / <view>.
+   [Default: projects]
+ * GITWEB_SITENAME
+   Name of your site or organization to appear in page titles.  Set it
+   to something descriptive for clearer bookmarks etc.  If not set
+   (if empty) gitweb uses "$SERVER_NAME Git", or "Untitled Git" if
+   SERVER_NAME CGI environment variable is not set (e.g. if running
+   gitweb as standalone script).  [No default]
+ * GITWEB_BASE_URL
+   Git base URLs used for URL to where fetch project from, i.e. full
+   URL is "$git_base_url/$project".  Shown on projects summary page.
+   Repository URL for project can be also configured per repository; this
+   takes precedence over URLs composed from base URL and a project name.
+   Note that you can setup multiple base URLs (for example one for
+   git:// protocol access, another for http:// access) from the gitweb
+   config file.  [No default]
+ * GITWEB_CSS
+   Points to the location where you put gitweb.css on your web server
+   (or to be more generic, the URI of gitweb stylesheet).  Relative to the
+   base URI of gitweb.  Note that you can setup multiple stylesheets from
+   the gitweb config file.  [Default: static/gitweb.css (or
+   static/gitweb.min.css if the CSSMIN variable is defined / CSS minifier
+   is used)]
+ * GITWEB_LOGO
+   Points to the location where you put git-logo.png on your web server
+   (or to be more generic URI of logo, 72x27 size, displayed in top right
+   corner of each gitweb page, and used as logo for Atom feed).  Relative
+   to base URI of gitweb.  [Default: static/git-logo.png]
+ * GITWEB_FAVICON
+   Points to the location where you put git-favicon.png on your web server
+   (or to be more generic URI of favicon, assumed to be image/png type;
+   web browsers that support favicons (website icons) may display them
+   in the browser's URL bar and next to site name in bookmarks).  Relative
+   to base URI of gitweb.  [Default: static/git-favicon.png]
+ * GITWEB_JS
+   Points to the location where you put gitweb.js on your web server
+   (or to be more generic URI of JavaScript code used by gitweb).
+   Relative to base URI of gitweb.  [Default: static/gitweb.js (or
+   static/gitweb.min.js if JSMIN build variable is defined / JavaScript
+   minifier is used)]
+ * GITWEB_CONFIG
+   This Perl file will be loaded using 'do' and can be used to override any
+   of the options above as well as some other options -- see the "Runtime
+   gitweb configuration" section below, and top of 'gitweb.cgi' for their
+   full list and description.  If the environment variable GITWEB_CONFIG
+   is set when gitweb.cgi is executed, then the file specified in the
+   environment variable will be loaded instead of the file specified
+   when gitweb.cgi was created.  [Default: gitweb_config.perl]
+ * GITWEB_CONFIG_SYSTEM
+   This Perl file will be loaded using 'do' as a fallback if GITWEB_CONFIG
+   does not exist.  If the environment variable GITWEB_CONFIG_SYSTEM is set
+   when gitweb.cgi is executed, then the file specified in the environment
+   variable will be loaded instead of the file specified when gitweb.cgi was
+   created.  [Default: /etc/gitweb.conf]
+ * HIGHLIGHT_BIN
+   Path to the highlight executable to use (must be the one from
+   http://www.andre-simon.de due to assumptions about parameters and output).
+   Useful if highlight is not installed on your webserver's PATH.
+   [Default: highlight]
+
 Build example
 ~~~~~~~~~~~~~
 
diff --git a/gitweb/README b/gitweb/README
index a3a697b..a4cfcb4 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -7,120 +7,6 @@ The one working on:
 From the git version 1.4.0 gitweb is bundled with git.
 
 
-How to configure gitweb for your local system
----------------------------------------------
-
-See also the "Build time configuration" section in the INSTALL
-file for gitweb (in gitweb/INSTALL).
-
-You can specify the following configuration variables when building GIT:
- * GIT_BINDIR
-   Points where to find the git executable.  You should set it up to
-   the place where the git binary was installed (usually /usr/bin) if you
-   don't install git from sources together with gitweb.  [Default: $(bindir)]
- * GITWEB_SITENAME
-   Shown in the title of all generated pages, defaults to the server name
-   (SERVER_NAME CGI environment variable) if not set. [No default]
- * GITWEB_PROJECTROOT
-   The root directory for all projects shown by gitweb. Must be set
-   correctly for gitweb to find repositories to display.  See also
-   "Gitweb repositories" in the INSTALL file for gitweb.  [Default: /pub/git]
- * GITWEB_PROJECT_MAXDEPTH
-   The filesystem traversing limit for getting the project list; the number
-   is taken as depth relative to the projectroot.  It is used when
-   GITWEB_LIST is a directory (or is not set; then project root is used).
-   This is meant to speed up project listing on large work trees by limiting
-   search depth.  [Default: 2007]
- * GITWEB_LIST
-   Points to a directory to scan for projects (defaults to project root
-   if not set / if empty) or to a file with explicit listing of projects
-   (together with projects' ownership). See "Generating projects list
-   using gitweb" in INSTALL file for gitweb to find out how to generate
-   such file from scan of a directory. [No default, which means use root
-   directory for projects]
- * GITWEB_EXPORT_OK
-   Show repository only if this file exists (in repository).  Only
-   effective if this variable evaluates to true.  [No default / Not set]
- * GITWEB_STRICT_EXPORT
-   Only allow viewing of repositories also shown on the overview page.
-   This for example makes GITWEB_EXPORT_OK to decide if repository is
-   available and not only if it is shown.  If GITWEB_LIST points to
-   file with list of project, only those repositories listed would be
-   available for gitweb.  [No default]
- * GITWEB_HOMETEXT
-   Points to an .html file which is included on the gitweb project
-   overview page ('projects_list' view), if it exists.  Relative to
-   gitweb.cgi script.  [Default: indextext.html]
- * GITWEB_SITE_HEADER
-   Filename of html text to include at top of each page.  Relative to
-   gitweb.cgi script.  [No default]
- * GITWEB_SITE_FOOTER
-   Filename of html text to include at bottom of each page.  Relative to
-   gitweb.cgi script.  [No default]
- * GITWEB_HOME_LINK_STR
-   String of the home link on top of all pages, leading to $home_link
-   (usually main gitweb page, which means projects list).  Used as first
-   part of gitweb view "breadcrumb trail": <home> / <project> / <view>.
-   [Default: projects]
- * GITWEB_SITENAME
-   Name of your site or organization to appear in page titles.  Set it
-   to something descriptive for clearer bookmarks etc.  If not set
-   (if empty) gitweb uses "$SERVER_NAME Git", or "Untitled Git" if
-   SERVER_NAME CGI environment variable is not set (e.g. if running
-   gitweb as standalone script).  [No default]
- * GITWEB_BASE_URL
-   Git base URLs used for URL to where fetch project from, i.e. full
-   URL is "$git_base_url/$project".  Shown on projects summary page.
-   Repository URL for project can be also configured per repository; this
-   takes precedence over URLs composed from base URL and a project name.
-   Note that you can setup multiple base URLs (for example one for
-   git:// protocol access, another for http:// access) from the gitweb
-   config file.  [No default]
- * GITWEB_CSS
-   Points to the location where you put gitweb.css on your web server
-   (or to be more generic, the URI of gitweb stylesheet).  Relative to the
-   base URI of gitweb.  Note that you can setup multiple stylesheets from
-   the gitweb config file.  [Default: static/gitweb.css (or
-   static/gitweb.min.css if the CSSMIN variable is defined / CSS minifier
-   is used)]
- * GITWEB_LOGO
-   Points to the location where you put git-logo.png on your web server
-   (or to be more generic URI of logo, 72x27 size, displayed in top right
-   corner of each gitweb page, and used as logo for Atom feed).  Relative
-   to base URI of gitweb.  [Default: static/git-logo.png]
- * GITWEB_FAVICON
-   Points to the location where you put git-favicon.png on your web server
-   (or to be more generic URI of favicon, assumed to be image/png type;
-   web browsers that support favicons (website icons) may display them
-   in the browser's URL bar and next to site name in bookmarks).  Relative
-   to base URI of gitweb.  [Default: static/git-favicon.png]
- * GITWEB_JS
-   Points to the location where you put gitweb.js on your web server
-   (or to be more generic URI of JavaScript code used by gitweb).
-   Relative to base URI of gitweb.  [Default: static/gitweb.js (or
-   static/gitweb.min.js if JSMIN build variable is defined / JavaScript
-   minifier is used)]
- * GITWEB_CONFIG
-   This Perl file will be loaded using 'do' and can be used to override any
-   of the options above as well as some other options -- see the "Runtime
-   gitweb configuration" section below, and top of 'gitweb.cgi' for their
-   full list and description.  If the environment variable GITWEB_CONFIG
-   is set when gitweb.cgi is executed, then the file specified in the
-   environment variable will be loaded instead of the file specified
-   when gitweb.cgi was created.  [Default: gitweb_config.perl]
- * GITWEB_CONFIG_SYSTEM
-   This Perl file will be loaded using 'do' as a fallback if GITWEB_CONFIG
-   does not exist.  If the environment variable GITWEB_CONFIG_SYSTEM is set
-   when gitweb.cgi is executed, then the file specified in the environment
-   variable will be loaded instead of the file specified when gitweb.cgi was
-   created.  [Default: /etc/gitweb.conf]
- * HIGHLIGHT_BIN
-   Path to the highlight executable to use (must be the one from
-   http://www.andre-simon.de due to assumptions about parameters and output).
-   Useful if highlight is not installed on your webserver's PATH.
-   [Default: highlight]
-
-
 Runtime gitweb configuration
 ----------------------------
 
-- 
1.7.5
