From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/4] Rename 'git-help--browse.sh' to 'git-web--browse.sh'.
Date: Sat, 2 Feb 2008 07:32:53 +0100
Message-ID: <20080202073253.8f1e377b.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Feb 02 07:27:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLBqq-0000tD-Jh
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 07:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755958AbYBBG0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 01:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755725AbYBBG0u
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 01:26:50 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:54081 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755550AbYBBG0t (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 01:26:49 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 63B1D1AB2C3;
	Sat,  2 Feb 2008 07:26:48 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 197901AB2AF;
	Sat,  2 Feb 2008 07:26:48 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72227>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-help.txt                |    6 +++---
 Makefile                                  |    2 +-
 git-help--browse.sh => git-web--browse.sh |    0 
 help.c                                    |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)
 rename git-help--browse.sh => git-web--browse.sh (100%)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index fb77ca3..ad41aab 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -47,19 +47,19 @@ OPTIONS
 +
 The web browser can be specified using the configuration variable
 'help.browser', or 'web.browser' if the former is not set. If none of
-these config variables is set, the 'git-help--browse' helper script
+these config variables is set, the 'git-web--browse' helper script
 (called by 'git-help') will pick a suitable default.
 +
 You can explicitly provide a full path to your preferred browser by
 setting the configuration variable 'browser.<tool>.path'. For example,
 you can configure the absolute path to firefox by setting
-'browser.firefox.path'. Otherwise, 'git-help--browse' assumes the tool
+'browser.firefox.path'. Otherwise, 'git-web--browse' assumes the tool
 is available in PATH.
 +
 Note that the script tries, as much as possible, to display the HTML
 page in a new tab on an already opened browser.
 +
-The following browsers are currently supported by 'git-help--browse':
+The following browsers are currently supported by 'git-web--browse':
 +
 * firefox (this is the default under X Window when not using KDE)
 * iceweasel
diff --git a/Makefile b/Makefile
index a03fd2e..d288378 100644
--- a/Makefile
+++ b/Makefile
@@ -231,7 +231,7 @@ SCRIPT_SH = \
 	git-lost-found.sh git-quiltimport.sh git-submodule.sh \
 	git-filter-branch.sh \
 	git-stash.sh \
-	git-help--browse.sh
+	git-web--browse.sh
 
 SCRIPT_PERL = \
 	git-add--interactive.perl \
diff --git a/git-help--browse.sh b/git-web--browse.sh
similarity index 100%
rename from git-help--browse.sh
rename to git-web--browse.sh
diff --git a/help.c b/help.c
index 058a397..c35912b 100644
--- a/help.c
+++ b/help.c
@@ -347,7 +347,7 @@ static void show_html_page(const char *git_cmd)
 
 	get_html_page_path(&page_path, page);
 
-	execl_git_cmd("help--browse", "-c", "help.browser", page_path.buf, NULL);
+	execl_git_cmd("web--browse", "-c", "help.browser", page_path.buf, NULL);
 }
 
 void help_unknown_cmd(const char *cmd)
-- 
1.5.4.rc5.25.g7a831-dirty
