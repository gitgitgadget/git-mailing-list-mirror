From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH] git-push: fix the documentation to explain all the status flags
Date: Mon,  8 Feb 2010 18:44:14 -0500
Message-ID: <1265672654-26511-1-git-send-email-larry@elder-gods.org>
References: <7vmxzj726j.fsf@alter.siamese.dyndns.org>
Cc: Larry D'Anna <larry@elder-gods.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 00:44:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NedHF-0000Ip-Rs
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 00:44:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220Ab0BHXoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 18:44:21 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:50546 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab0BHXoU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 18:44:20 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 742508221D5; Mon,  8 Feb 2010 18:44:15 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc1.33.g07cf0f.dirty
In-Reply-To: <7vmxzj726j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139336>

git-push prints a flag indicating the status of each ref that was pushed, or
attempted to be pushed.  The documentation did not correctly list all of the
possible flags.
---
 Documentation/git-push.txt |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 73a921c..61b6894 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -176,12 +176,17 @@ If --porcelain is used, then each line of the output is of the form:
  <flag> \t <from>:<to> \t <summary> (<reason>)
 -------------------------------
 
+The status of up to date refs is shown only if --porcelain or --verbose is used.
+
 flag::
 	A single character indicating the status of the ref. This is
-	blank for a successfully pushed ref, `!` for a ref that was
-	rejected or failed to push, and '=' for a ref that was up to
-	date and did not need pushing (note that the status of up to
-	date refs is shown only when `git push` is running verbosely).
+[horizontal]
+	" " (space)::: for a successfully pushed fast-forward
+	"+"::: for a successful forced update
+	"-"::: for a successfully deleted ref
+	"*"::: for a successfully pushed new ref
+	"!"::: for a ref that was rejected or failed to push
+	"="::: for a ref that was up to date and did not need pushing
 
 summary::
 	For a successfully pushed ref, the summary shows the old and new
-- 
1.7.0.rc1.33.g07cf0f.dirty
