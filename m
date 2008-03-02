From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v3 4/4] git-submodule: New subcommand 'summary' (4) - Update the document
Date: Mon,  3 Mar 2008 02:15:10 +0800
Message-ID: <1204481710-29791-4-git-send-email-pkufranky@gmail.com>
References: <1204481710-29791-1-git-send-email-pkufranky@gmail.com>
Cc: git@vger.kernel.org, Ping Yin <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Mar 02 19:16:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVsjM-0001qt-7n
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 19:16:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063AbYCBSPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 13:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753020AbYCBSPV
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 13:15:21 -0500
Received: from mail.qikoo.org ([60.28.205.235]:50502 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753140AbYCBSPP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 13:15:15 -0500
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 0F58A470B0; Mon,  3 Mar 2008 02:15:10 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
In-Reply-To: <1204481710-29791-1-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75825>

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 Documentation/git-submodule.txt |   24 +++++++++++++++++++++---
 1 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index e818e6e..598e116 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git-submodule' [--quiet] add [-b branch] [--] <repository> [<path>]
 'git-submodule' [--quiet] status [--cached] [--] [<path>...]
 'git-submodule' [--quiet] [init|update] [--] [<path>...]
+'git-submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
 
 
 COMMANDS
@@ -46,6 +47,13 @@ update::
 	checkout the commit specified in the index of the containing repository.
 	This will make the submodules HEAD be detached.
 
+summary::
+	Show commit summary between given commit (default to HEAD) and
+	working tree/index. For a submodule in question, a series of commits
+	will be shown as the path from the src commit to the dst commit,
+	where the src commit is from the given super project commit, and the
+	dst commit is from the index or working tree (switched by --cached).
+
 
 OPTIONS
 -------
@@ -56,9 +64,19 @@ OPTIONS
 	Branch of repository to add as submodule.
 
 --cached::
-	Display the SHA-1 stored in the index, not the SHA-1 of the currently
-	checked out submodule commit. This option is only valid for the
-	status command.
+	This option is only valid for commands status and summary.
+	When combined with status, display the SHA-1 stored in the index,
+	not the SHA-1 of the currently checked out submodule commit. When
+	combined with summary, switch dst comparison side from working
+	tree to index.
+
+-n, --summary-limit::
+	This option is only valid for the summary command.
+	Limit the summary size (number of commits shown in total).
+	Number 0 will disable summary and minus number means unlimted
+	(the default). For beauty and clarification, the fork-point commits
+	will always be shown. So actual summary size may be greater than
+	the given limit.
 
 <path>::
 	Path to submodule(s). When specified this will restrict the command
-- 
1.5.4.3.347.g5314c

