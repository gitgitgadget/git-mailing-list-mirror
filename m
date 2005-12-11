From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] cg-merge: Improve the hook description
Date: Sun, 11 Dec 2005 20:07:33 +0100
Message-ID: <20051211190733.GE2960@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Dec 11 20:07:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElWXq-0006sG-2i
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 20:07:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbVLKTHf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Dec 2005 14:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVLKTHf
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Dec 2005 14:07:35 -0500
Received: from nhugin.diku.dk ([130.225.96.140]:4346 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1750799AbVLKTHf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Dec 2005 14:07:35 -0500
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id C67C06DFBB6; Sun, 11 Dec 2005 20:06:34 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 8872D6DF835; Sun, 11 Dec 2005 20:06:34 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id EDFCC615B3; Sun, 11 Dec 2005 20:07:33 +0100 (CET)
To: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13503>

Make it into a HOOKS section and place the argument list in the term
line.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

 Just an idea. The current thing is renderered poorly in cg-merge(1).

commit 4b1142df28132c12ce82c71757c417d8d41474ca
tree 3c317897b6ce1dde87d5ab41b1611fce3c902e56
parent 3b8f92d921868da0af9195db03b277650147498f
author Jonas Fonseca <fonseca@diku.dk> Tue, 06 Dec 2005 23:57:22 +0100
committer Jonas Fonseca <fonseca@antimatter.localdomain> Tue, 06 Dec 2005 23:57:22 +0100

 cg-merge |   24 +++++++++++-------------
 1 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/cg-merge b/cg-merge
index 08a6075..c06e4be 100755
--- a/cg-merge
+++ b/cg-merge
@@ -64,23 +64,21 @@
 #	"do it I", "fix it", "do it II", "fix it II", "fix it III" commits
 #	like you would get with a regular merge).
 #
-# FILES
+# HOOKS
 # -----
-# $GIT_DIR/hooks/merge-pre::
+# '.git/hooks/merge-pre' BRANCH BASE CURHEAD MERGEDHEAD MERGETYPE::
 #	If the file exists and is executable it will be executed right
-#	before the merge itself happens. The script is passed those
-#	arguments:
-#		BRANCHNAME BASE CURHEAD MERGEDHEAD MERGETYPE
-#	MERGETYPE is either "forward", "squash", or "tree". The merge is
-#	cancelled if the script returns non-zero exit code.
+#	before the merge itself happens. The merge is cancelled if the script
+#	returns non-zero exit code.
+#	 - MERGETYPE is either "forward", "squash", or "tree".
 #
-# $GIT_DIR/hooks/merge-post::
+# '.git/hooks/merge-post' BRANCH BASE CURHEAD MERGEDHEAD MERGETYPE STATUS::
 #	If the file exists and is executable it will be executed after
-#	the merge is done. The script is passed those arguments:
-#		BRANCHNAME BASE CURHEAD MERGEDHEAD MERGETYPE STATUS
-#	MERGETYPE is either "forward", "squash", or "tree". For "forward",
-#	the STATUS is always "ok", while for "squash" and "tree" the STATUS
-#	can be "localchanges", "conflicts", "nocommit", or "ok".
+#	the merge is done.
+#	 - MERGETYPE is either "forward", "squash", or "tree".
+#	 - For 'forward', the STATUS is always "ok", while for "squash"
+#	   and "tree" the STATUS can be "localchanges", "conflicts",
+#	   "nocommit", or "ok".
 
 # Developer's documentation:
 #

-- 
Jonas Fonseca
