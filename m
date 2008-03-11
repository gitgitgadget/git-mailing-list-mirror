From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v5 4/5] git-submodule summary: documentation
Date: Tue, 11 Mar 2008 21:52:18 +0800
Message-ID: <1205243539-797-5-git-send-email-pkufranky@gmail.com>
References: <1205243539-797-1-git-send-email-pkufranky@gmail.com>
 <1205243539-797-2-git-send-email-pkufranky@gmail.com>
 <1205243539-797-3-git-send-email-pkufranky@gmail.com>
 <1205243539-797-4-git-send-email-pkufranky@gmail.com>
Cc: git@vger.kernel.org, Ping Yin <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 11 14:53:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ4un-0006eX-6A
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 14:53:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbYCKNwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 09:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752706AbYCKNwb
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 09:52:31 -0400
Received: from mail.qikoo.org ([60.28.205.235]:57654 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751573AbYCKNw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 09:52:26 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 3C852470B1; Tue, 11 Mar 2008 21:52:19 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
In-Reply-To: <1205243539-797-4-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76848>

Signed-off-by: Ping Yin <pkufranky@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-submodule.txt |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index b4d0160..41f9f63 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git-submodule' [--quiet] add [-b branch] [--] <repository> [<path>]
 'git-submodule' [--quiet] status [--cached] [--] [<path>...]
 'git-submodule' [--quiet] [init|update] [--] [<path>...]
+'git-submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
 
 
 COMMANDS
@@ -47,6 +48,11 @@ update::
 	checkout the commit specified in the index of the containing repository.
 	This will make the submodules HEAD be detached.
 
+summary::
+	Show commit summary between the given commit (defaults to HEAD) and
+	working tree/index. For a submodule in question, a series of commits
+	in the submodule between the given super project commit and the
+	index or working tree (switched by --cached) are shown.
 
 OPTIONS
 -------
@@ -57,9 +63,16 @@ OPTIONS
 	Branch of repository to add as submodule.
 
 --cached::
-	Display the SHA-1 stored in the index, not the SHA-1 of the currently
-	checked out submodule commit. This option is only valid for the
-	status command.
+	This option is only valid for status and summary commands.  These
+	commands typically use the commit found in the submodule HEAD, but
+	with this option, the commit stored in the index is used instead.
+
+-n, --summary-limit::
+	This option is only valid for the summary command.
+	Limit the summary size (number of commits shown in total).
+	Giving 0 will disable the summary; a negative number means unlimted
+	(the default). This limit only applies to modified submodules. The
+	size is always limited to 1 for added/deleted/typechanged submodules.
 
 <path>::
 	Path to submodule(s). When specified this will restrict the command
-- 
1.5.4.3.347.g5314c
