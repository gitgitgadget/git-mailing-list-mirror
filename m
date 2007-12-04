From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Documentation: add a new man page for "git-help" and
 -i|--info option.
Date: Tue, 4 Dec 2007 06:44:29 +0100
Message-ID: <20071204064429.1b5007b2.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Dec 04 06:38:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzQUG-0003cT-Cg
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 06:38:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbXLDFiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 00:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbXLDFiJ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 00:38:09 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:35266 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409AbXLDFiG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 00:38:06 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 9AB701AB2C6;
	Tue,  4 Dec 2007 06:38:04 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 643551AB2C3;
	Tue,  4 Dec 2007 06:38:04 +0100 (CET)
X-Mailer: Sylpheed 2.4.7 (GTK+ 2.12.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67004>

Option -i|--info for "git-help" is documented only in the new
"git-help.txt" man page, but this new man page is referenced
from the "--help" option documentation in the "git.txt" man page.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-help.txt |   53 ++++++++++++++++++++++++++++++++++++++++++++
 Documentation/git.txt      |   11 ++++++--
 2 files changed, 61 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/git-help.txt

	This is a first documentation patch in my git-help
	improvement series. 

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
new file mode 100644
index 0000000..232daae
--- /dev/null
+++ b/Documentation/git-help.txt
@@ -0,0 +1,53 @@
+git-help(1)
+======
+
+NAME
+----
+git-help - display help information about git
+
+SYNOPSIS
+--------
+'git help' [-a|--all|-i|--info] [COMMAND]
+
+DESCRIPTION
+-----------
+
+With no options and no COMMAND given, the synopsis of the 'git'
+command and a list of the most commonly used git commands are printed
+on the standard output.
+
+If the option '--all' or '-a' is given, then all available commands are
+printed on the standard output.
+
+If a git command is named, a manual page for that command is brought
+up. The 'man' program is used by default for this purpose, but this
+can be overriden by other options.
+
+Note that 'git --help ...' is identical as 'git help ...' because the
+former is internally converted into the latter.
+
+OPTIONS
+-------
+-a|--all::
+
+	Prints all the available commands on the standard output. This
+	option superseeds any other option.
+
+-i|--info::
+	Use the 'info' program to display the manual page, instead of
+	the 'man' program that is used by default.
+
+Author
+------
+Written by Junio C Hamano <gitster@pobox.com> and the git-list
+<git@vger.kernel.org>.
+
+Documentation
+-------------
+Initial documentation was part of the gitlink:git[7] man page.
+Christian Couder <chriscool@tuxfamily.org> extracted and rewrote it a
+little. Maintenance is done by the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the gitlink:git[7] suite
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 5460201..f8d1eef 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -100,9 +100,14 @@ OPTIONS
 
 --help::
 	Prints the synopsis and a list of the most commonly used
-	commands.  If a git command is named this option will bring up
-	the man-page for that command. If the option '--all' or '-a' is
-	given then all available commands are printed.
+	commands. If the option '--all' or '-a' is given then all
+	available commands are printed. If a git command is named this
+	option will bring up the manual page for that command.
+
+	Other options are available to control how the manual page is
+	displayed. See gitlink:git-help[1] for more information,
+	because 'git --help ...' is converted internally into 'git
+	help ...'.
 
 --exec-path::
 	Path to wherever your core git programs are installed.
-- 
1.5.3.6.1993.g154f-dirty
