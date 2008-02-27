From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Documentation: help: describe 'man.viewer' config variable.
Date: Wed, 27 Feb 2008 06:55:35 +0100
Message-ID: <20080227065535.8ac7883a.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio Hamano <junkio@cox.net>, Pascal Obry <pascal@obry.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 06:50:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUFBY-0006ep-3Q
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 06:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbYB0Ftx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 00:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbYB0Ftx
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 00:49:53 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:38360 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750805AbYB0Ftw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 00:49:52 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id F059E1AB2BF;
	Wed, 27 Feb 2008 06:49:50 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id AD13C1AB2B9;
	Wed, 27 Feb 2008 06:49:50 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75202>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt   |    4 ++++
 Documentation/git-help.txt |   32 ++++++++++++++++++++++----------
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 45bf8cd..3920285 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -743,6 +743,10 @@ log.showroot::
 	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
 	normally hide the root commit will now show it. True by default.
 
+man.viewer::
+	Specify the program that will be used to display help in the
+	'man' format. See linkgit:git-help[1].
+
 merge.summary::
 	Whether to include summaries of merged commits in newly created
 	merge commit messages. False by default.
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 0926dc1..09227b3 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -33,17 +33,21 @@ OPTIONS
 	option supersedes any other option.
 
 -i|--info::
-	Use the 'info' program to display the manual page, instead of
-	the 'man' program that is used by default.
+	Display manual documentation about the command in Info
+	format. The 'info' program will be used for that purpose.
 
 -m|--man::
-	Use the 'man' program to display the manual page. This may be
-	used to override a value set in the 'help.format'
-	configuration variable.
+	Display manual documentation about the command in Man format.
+	This option may be used to override a value set in the
+	'help.format' configuration variable.
++
+By default the 'man' program will be used to display the man pages,
+but the 'man.viewer' configuration variable may be used to choose
+another display program (see below).
 
 -w|--web::
-	Use a web browser to display the HTML manual page, instead of
-	the 'man' program that is used by default.
+	Display manual documentation about the command in HTLM format.
+	A web browser will be used for that purpose.
 +
 The web browser can be specified using the configuration variable
 'help.browser', or 'web.browser' if the former is not set. If none of
@@ -61,15 +65,23 @@ line option:
 
 * "man" corresponds to '-m|--man',
 * "info" corresponds to '-i|--info',
-* "web" or "html" correspond to '-w|--web',
+* "web" or "html" correspond to '-w|--web'.
 
 The 'help.browser', 'web.browser' and 'browser.<tool>.path' will also
 be checked if the 'web' format is chosen (either by command line
 option or configuration variable). See '-w|--web' in the OPTIONS
 section above and linkgit:git-web--browse[1].
 
-Note that these configuration variables should probably be set using
-the '--global' flag, for example like this:
+The 'man.viewer' config variable will be checked if the 'man' format
+is chosen. Only the following values are currently supported:
+
+* "man": use the 'man' program as usual,
+* "woman": use 'emacsclient' to launch the "woman" mode in emacs
+(this only works starting with emacsclient versions 22),
+* "konqueror": use a man KIO slave in konqueror.
+
+Note that all these configuration variables should probably be set
+using the '--global' flag, for example like this:
 
 ------------------------------------------------
 $ git config --global help.format web
-- 
1.5.4.2.233.gf355.dirty
