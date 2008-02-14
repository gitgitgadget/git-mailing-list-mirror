From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Documentation: add 'git-web--browse.txt' and simplify other
 docs.
Date: Thu, 14 Feb 2008 08:01:23 +0100
Message-ID: <20080214080123.5ffb1f19.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Junio Hamano <junkio@cox.net>, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Feb 14 07:56:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPY0r-0000sL-7e
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 07:56:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755159AbYBNGz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 01:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755483AbYBNGz3
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 01:55:29 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:50020 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755102AbYBNGz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 01:55:28 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 1C5DA1AB2C8;
	Thu, 14 Feb 2008 07:55:27 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 7CA721AB2E0;
	Thu, 14 Feb 2008 07:55:26 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73862>

'git-help.txt' and 'git-instaweb.txt' contained duplicated
information about 'git-web--browse'.

This patch puts this information where it belongs.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-help.txt        |   24 +----------
 Documentation/git-instaweb.txt    |   27 ++----------
 Documentation/git-web--browse.txt |   78 +++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/git-web--browse.txt

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index ad41aab..0926dc1 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -48,26 +48,8 @@ OPTIONS
 The web browser can be specified using the configuration variable
 'help.browser', or 'web.browser' if the former is not set. If none of
 these config variables is set, the 'git-web--browse' helper script
-(called by 'git-help') will pick a suitable default.
-+
-You can explicitly provide a full path to your preferred browser by
-setting the configuration variable 'browser.<tool>.path'. For example,
-you can configure the absolute path to firefox by setting
-'browser.firefox.path'. Otherwise, 'git-web--browse' assumes the tool
-is available in PATH.
-+
-Note that the script tries, as much as possible, to display the HTML
-page in a new tab on an already opened browser.
-+
-The following browsers are currently supported by 'git-web--browse':
-+
-* firefox (this is the default under X Window when not using KDE)
-* iceweasel
-* konqueror (this is the default under KDE)
-* w3m (this is the default outside X Window)
-* links
-* lynx
-* dillo
+(called by 'git-help') will pick a suitable default. See
+linkgit:git-web--browse[1] for more information about this.
 
 CONFIGURATION VARIABLES
 -----------------------
@@ -84,7 +66,7 @@ line option:
 The 'help.browser', 'web.browser' and 'browser.<tool>.path' will also
 be checked if the 'web' format is chosen (either by command line
 option or configuration variable). See '-w|--web' in the OPTIONS
-section above.
+section above and linkgit:git-web--browse[1].
 
 Note that these configuration variables should probably be set using
 the '--global' flag, for example like this:
diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.txt
index a1456ab..51f1532 100644
--- a/Documentation/git-instaweb.txt
+++ b/Documentation/git-instaweb.txt
@@ -40,21 +40,9 @@ OPTIONS
 -b|--browser::
 	The web browser that should be used to view the gitweb
 	page. This will be passed to the 'git-web--browse' helper
-	script along with the URL of the gitweb instance. If the
-	script fails, the URL will be printed to stdout.
-+
-Note that the 'git-web--browse' script tries, as much as possible, to
-display the HTML page in a new tab on an already opened browser.
-+
-The following browsers are currently supported by 'git-web--browse':
-+
-* firefox (this is the default under X Window when not using KDE)
-* iceweasel
-* konqueror (this is the default under KDE)
-* w3m (this is the default outside X Window)
-* links
-* lynx
-* dillo
+	script along with the URL of the gitweb instance. See
+	linkgit:git-web--browse[1] for more information about this. If
+	the script fails, the URL will be printed to stdout.
 
 --start::
 	Start the httpd instance and exit.  This does not generate
@@ -85,13 +73,8 @@ You may specify configuration in your .git/config
 -----------------------------------------------------------------------
 
 If the configuration variable 'instaweb.browser' is not set,
-'web.browser' will be used instead if it is defined.
-
-You can explicitly provide a full path to your preferred browser by
-setting the configuration variable 'browser.<tool>.path'. For example,
-you can configure the absolute path to firefox by setting
-'browser.firefox.path'. Otherwise, 'git-web--browse' assumes the tool
-is available in PATH.
+'web.browser' will be used instead if it is defined. See
+linkgit:git-web--browse[1] for more information about this.
 
 Author
 ------
diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
new file mode 100644
index 0000000..df57d01
--- /dev/null
+++ b/Documentation/git-web--browse.txt
@@ -0,0 +1,78 @@
+git-web--browse(1)
+==================
+
+NAME
+----
+git-web--browse - git helper script to launch a web browser
+
+SYNOPSIS
+--------
+'git-web--browse' [OPTIONS] URL/FILE ...
+
+DESCRIPTION
+-----------
+
+This script tries, as much as possible, to display the URLs and FILEs
+that are passed as arguments, as HTML pages in new tabs on an already
+opened web browser.
+
+The following browsers (or commands) are currently supported:
+
+* firefox (this is the default under X Window when not using KDE)
+* iceweasel
+* konqueror (this is the default under KDE)
+* w3m (this is the default outside graphical environments)
+* links
+* lynx
+* dillo
+* open (this is the default under Mac OS X GUI)
+
+OPTIONS
+-------
+-b BROWSER|--browser=BROWSER::
+	Use the specified BROWSER. It must be in the list of supported
+	browsers.
+
+-t BROWSER|--tool=BROWSER::
+	Same as above.
+
+-c CONF.VAR|--config=CONF.VAR::
+	CONF.VAR is looked up in the git config files. If it's set,
+	then its value specify the browser that should be used.
+
+CONFIGURATION VARIABLES
+-----------------------
+
+The web browser can be specified using a configuration variable passed
+with the -c (or --config) command line option, or the 'web.browser'
+configuration variable if the former is not used.
+
+You can explicitly provide a full path to your preferred browser by
+setting the configuration variable 'browser.<tool>.path'. For example,
+you can configure the absolute path to firefox by setting
+'browser.firefox.path'. Otherwise, 'git-web--browse' assumes the tool
+is available in PATH.
+
+Note that these configuration variables should probably be set using
+the '--global' flag, for example like this:
+
+------------------------------------------------
+$ git config --global web.browser firefox
+------------------------------------------------
+
+as they are probably more user specific than repository specific.
+See linkgit:git-config[1] for more information about this.
+
+Author
+------
+Written by Christian Couder <chriscool@tuxfamily.org> and the git-list
+<git@vger.kernel.org>, based on git-mergetool by Theodore Y. Ts'o.
+
+Documentation
+-------------
+Documentation by Christian Couder <chriscool@tuxfamily.org> and the
+git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the linkgit:git[7] suite
-- 
1.5.4.20.gc135a-dirty
