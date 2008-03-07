From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v3 4/4] git-submodule summary: documentation
Date: Sat,  8 Mar 2008 02:27:19 +0800
Message-ID: <1204914439-23145-4-git-send-email-pkufranky@gmail.com>
References: <1204914439-23145-1-git-send-email-pkufranky@gmail.com>
 <1204914439-23145-2-git-send-email-pkufranky@gmail.com>
 <1204914439-23145-3-git-send-email-pkufranky@gmail.com>
Cc: git@vger.kernel.org, Ping Yin <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 07 19:29:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXhJL-0006ub-MO
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 19:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbYCGS11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 13:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbYCGS1Z
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 13:27:25 -0500
Received: from mail.qikoo.org ([60.28.205.235]:43649 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932296AbYCGS1X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 13:27:23 -0500
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 6DFF4470B0; Sat,  8 Mar 2008 02:27:19 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
In-Reply-To: <1204914439-23145-3-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76509>

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 Documentation/git-submodule.txt |   22 +++++++++++++++++++---
 1 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index e818e6e..4fbc182 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git-submodule' [--quiet] add [-b branch] [--] <repository> [<path>]
 'git-submodule' [--quiet] status [--cached] [--] [<path>...]
 'git-submodule' [--quiet] [init|update] [--] [<path>...]
+'git-submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
 
 
 COMMANDS
@@ -46,6 +47,12 @@ update::
 	checkout the commit specified in the index of the containing repository.
 	This will make the submodules HEAD be detached.
 
+summary::
+	Show commit summary between given commit (default to HEAD) and
+	working tree/index. For a submodule in question, a series of commits
+	between src sha1 and dst sha1 will be shown where src sha1 is from the
+	given super project commit and dst sha1 is from the index or working
+	tree (switched by --cached).
 
 OPTIONS
 -------
@@ -56,9 +63,18 @@ OPTIONS
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
+	(the default). This limit only applies to modified submodules. The
+	size is always limited to 1 for added/deleted/typechanged submodules.
 
 <path>::
 	Path to submodule(s). When specified this will restrict the command
-- 
1.5.4.3.347.g5314c

