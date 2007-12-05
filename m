From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Documentation: describe -w/--web option to "git-help".
Date: Wed, 5 Dec 2007 06:09:40 +0100
Message-ID: <20071205060940.20687a64.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Dec 05 06:03:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzmQ5-0000Dx-PW
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 06:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbXLEFDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 00:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbXLEFDR
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 00:03:17 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:44823 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750739AbXLEFDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 00:03:16 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 2AB3E1AB2B0;
	Wed,  5 Dec 2007 06:03:15 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id EE5311AB2AA;
	Wed,  5 Dec 2007 06:03:14 +0100 (CET)
X-Mailer: Sylpheed 2.4.7 (GTK+ 2.12.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67101>

Also explain that "git instaweb" may use "web.browser" config
variable.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-help.txt     |   21 +++++++++++++++++++--
 Documentation/git-instaweb.txt |    3 +++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index c94e27b..ac9e15d 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -7,7 +7,7 @@ git-help - display help information about git
 
 SYNOPSIS
 --------
-'git help' [-a|--all|-i|--info] [COMMAND]
+'git help' [-a|--all|-i|--info|-w|--web] [COMMAND]
 
 DESCRIPTION
 -----------
@@ -29,7 +29,6 @@ former is internally converted into the latter.
 OPTIONS
 -------
 -a|--all::
-
 	Prints all the available commands on the standard output. This
 	option superseeds any other option.
 
@@ -37,6 +36,24 @@ OPTIONS
 	Use the 'info' program to display the manual page, instead of
 	the 'man' program that is used by default.
 
+-w|--web::
+	Use a web browser to display the HTML manual page, instead of
+	the 'man' program that is used by default.
++
+The web browser can be specified using the configuration variable
+'help.browser', or 'web.browser' if the former is not set. If none of
+these config variables is set, the 'git-browse-help' script (called by
+'git-help') will pick a suitable default.
++
+You can explicitly provide a full path to your prefered browser by
+setting the configuration variable 'browser.<tool>.path'. For example,
+you can configure the absolute path to firefox by setting
+'browser.firefox.path'. Otherwise, 'git-browse-help' assumes the tool
+is available in PATH.
++
+Note that the script tries, as much as possible, to display the HTML
+page in a new tab on an already opened browser.
+
 Author
 ------
 Written by Junio C Hamano <gitster@pobox.com> and the git-list
diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.txt
index 735008c..d2ce779 100644
--- a/Documentation/git-instaweb.txt
+++ b/Documentation/git-instaweb.txt
@@ -71,6 +71,9 @@ You may specify configuration in your .git/config
 
 -----------------------------------------------------------------------
 
+If the configuration variable 'instaweb.browser' is not set,
+'web.browser' will be used instead if it is defined.
+
 Author
 ------
 Written by Eric Wong <normalperson@yhbt.net>
-- 
1.5.3.6.1993.g154f-dirty
