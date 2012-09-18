From: Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH] Documentation/git-filter-branch: Move note about effect of
 removing commits
Date: Tue, 18 Sep 2012 17:55:08 +0200
Message-ID: <m2627biaw3.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 17:55:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE08u-00044W-MS
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 17:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757332Ab2IRPzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 11:55:12 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:37286 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757258Ab2IRPzK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 11:55:10 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XLpgd15CCz3hhh5
	for <git@vger.kernel.org>; Tue, 18 Sep 2012 17:55:08 +0200 (CEST)
X-Auth-Info: /34mgPHG+yeRhbJjOvmPGHvAkVmudFL/StF7ke4iVhQ=
Received: from igel.home (ppp-93-104-159-39.dynamic.mnet-online.de [93.104.159.39])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XLpgc5NY7zbbjf
	for <git@vger.kernel.org>; Tue, 18 Sep 2012 17:55:08 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 42CD8CA2A2; Tue, 18 Sep 2012 17:55:08 +0200 (CEST)
X-Yow: I'm having a MID-WEEK CRISIS!
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205836>

The note that explains that changes introduced by removed commits are
preserved should be placed directly after the paragraph that describes
such commits removal.  Otherwise the reference to "the commits" appears
out of context.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 Documentation/git-filter-branch.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 15e7ac8..6e2d9ea 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -304,6 +304,11 @@ committed a merge between P1 and P2, it will be propagated properly
 and all children of the merge will become merge commits with P1,P2
 as their parents instead of the merge commit.
 
+*NOTE* the changes introduced by the commits, and which are not reverted
+by subsequent commits, will still be in the rewritten branch. If you want
+to throw out _changes_ together with the commits, you should use the
+interactive mode of 'git rebase'.
+
 You can rewrite the commit log messages using `--msg-filter`.  For
 example, 'git svn-id' strings in a repository created by 'git svn' can
 be removed this way:
@@ -329,11 +334,6 @@ git filter-branch --msg-filter '
 ' HEAD~10..HEAD
 --------------------------------------------------------
 
-*NOTE* the changes introduced by the commits, and which are not reverted
-by subsequent commits, will still be in the rewritten branch. If you want
-to throw out _changes_ together with the commits, you should use the
-interactive mode of 'git rebase'.
-
 
 Consider this history:
 
-- 
1.7.12


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
