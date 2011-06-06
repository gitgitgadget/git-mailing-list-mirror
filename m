From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3 1/5] gitweb: Move information about installation from README to INSTALL
Date: Mon,  6 Jun 2011 19:44:27 +0200
Message-ID: <1307382271-7677-2-git-send-email-jnareb@gmail.com>
References: <1307382271-7677-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>,
	Drew Northup <drew.northup@maine.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 19:54:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTe0B-0006Pu-8v
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 19:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756827Ab1FFRyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 13:54:04 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44832 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756587Ab1FFRyB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 13:54:01 -0400
Received: by wya21 with SMTP id 21so2983427wya.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 10:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=C5MKdfjeCgGV+o5KN4JM1AiiTsLy/yM9wGCSbXfD9GI=;
        b=bIc8M6EaO3NcT804eyJr3/jU6uW2FKUBwjzmoCCl1ISkOYAksBcoE3jaP0S3h6KeD5
         g90nx7Y9SKcZvW8jXwiXFkLp9WH6MDbuCOreUt1PL5yVGUgCaE4lFQnlaPogTPTXrsH7
         mRFiIY8PuL60D+c/wFIj2t/g0aHXk1iH7iGp8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vnaC+yQ63i4kyQrPWFiMEBkKVsynN7IHZ6pNSH0IHyJ9hywat8D5mYAf+K7M7p7Vps
         a8Hm53XskJFIFgtKSqX+ITnwvgrJY6hPxls0H8KhAunK3hcNntsOXn2ZKrHoFxeymXX/
         EEShHjJcD3aGLjTSirSRO2SlCC7K0k+jf6if4=
Received: by 10.216.255.73 with SMTP id i51mr2725899wes.88.1307382840254;
        Mon, 06 Jun 2011 10:54:00 -0700 (PDT)
Received: from localhost.localdomain (abwr100.neoplus.adsl.tpnet.pl [83.8.241.100])
        by mx.google.com with ESMTPS id t79sm2440982weq.5.2011.06.06.10.53.57
        (version=SSLv3 cipher=OTHER);
        Mon, 06 Jun 2011 10:53:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1307382271-7677-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175141>

Almost straightformard moving of "How to configure gitweb for your
local system" section from gitweb/README to gitweb/INSTALL, as it is
about build time configuration.  Updated references to it.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
No differences from previous version.

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
