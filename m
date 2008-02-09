From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2] Documentation: instaweb: add 'git-web--browse'
 information.
Date: Sat, 9 Feb 2008 07:10:57 +0100
Message-ID: <20080209071058.6b64fb32.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Feb 09 07:06:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNiqf-0000NP-Cv
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 07:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbYBIGE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 01:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbYBIGE7
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 01:04:59 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:58074 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751138AbYBIGE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 01:04:58 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 413621AB2AC;
	Sat,  9 Feb 2008 07:04:57 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id B8E791AB2A9;
	Sat,  9 Feb 2008 07:04:56 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73199>

Now that 'git-instaweb' uses 'git-web--browse', update the
documentation accordingly.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-instaweb.txt |   27 +++++++++++++++++++++++----
 1 files changed, 23 insertions(+), 4 deletions(-)

	The added documentation is copied from 'Documentation/git-help.txt',
	so maybe it would be better for 'git-web--browse' to have its own
	documentation and to refer to it in both 'git-help.txt' and
	'git-instaweb.txt'.

diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.txt
index 841e8fa..a1456ab 100644
--- a/Documentation/git-instaweb.txt
+++ b/Documentation/git-instaweb.txt
@@ -38,10 +38,23 @@ OPTIONS
 	The port number to bind the httpd to.  (Default: 1234)
 
 -b|--browser::
-
-	The web browser command-line to execute to view the gitweb page.
-	If blank, the URL of the gitweb instance will be printed to
-	stdout.  (Default: 'firefox')
+	The web browser that should be used to view the gitweb
+	page. This will be passed to the 'git-web--browse' helper
+	script along with the URL of the gitweb instance. If the
+	script fails, the URL will be printed to stdout.
++
+Note that the 'git-web--browse' script tries, as much as possible, to
+display the HTML page in a new tab on an already opened browser.
++
+The following browsers are currently supported by 'git-web--browse':
++
+* firefox (this is the default under X Window when not using KDE)
+* iceweasel
+* konqueror (this is the default under KDE)
+* w3m (this is the default outside X Window)
+* links
+* lynx
+* dillo
 
 --start::
 	Start the httpd instance and exit.  This does not generate
@@ -74,6 +87,12 @@ You may specify configuration in your .git/config
 If the configuration variable 'instaweb.browser' is not set,
 'web.browser' will be used instead if it is defined.
 
+You can explicitly provide a full path to your preferred browser by
+setting the configuration variable 'browser.<tool>.path'. For example,
+you can configure the absolute path to firefox by setting
+'browser.firefox.path'. Otherwise, 'git-web--browse' assumes the tool
+is available in PATH.
+
 Author
 ------
 Written by Eric Wong <normalperson@yhbt.net>
-- 
1.5.4.16.g9f0c3
