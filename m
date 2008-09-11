From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/2] Documentation: Refer to git-rebase(1) to warn against rewriting
Date: Thu, 11 Sep 2008 17:38:45 +0200
Message-ID: <1221147525-5589-3-git-send-email-trast@student.ethz.ch>
References: <200809030738.09589.trast@student.ethz.ch>
 <1221147525-5589-1-git-send-email-trast@student.ethz.ch>
 <1221147525-5589-2-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 17:40:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdoHe-0005YK-TJ
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 17:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755542AbYIKPjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 11:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755495AbYIKPi7
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 11:38:59 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:24730 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755484AbYIKPi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 11:38:57 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 11 Sep 2008 17:38:51 +0200
Received: from localhost.localdomain ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 11 Sep 2008 17:38:51 +0200
X-Mailer: git-send-email 1.6.0.1.470.g200b
In-Reply-To: <1221147525-5589-2-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 11 Sep 2008 15:38:51.0017 (UTC) FILETIME=[7D4A4F90:01C91424]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95611>

This points readers at the "Recovering from upstream rebase" warning
in git-rebase(1) when we talk about rewriting published history in the
'reset', 'commit --amend', and 'filter-branch' documentation.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-commit.txt        |    4 ++++
 Documentation/git-filter-branch.txt |    4 +++-
 Documentation/git-reset.txt         |    4 +++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index eb05b0f..eeba58d 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -144,6 +144,10 @@ It is a rough equivalent for:
 ------
 but can be used to amend a merge commit.
 --
++
+You should understand the implications of rewriting history if you
+amend a commit that has already been published.  (See the "RECOVERING
+FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
 
 -i::
 --include::
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index b0e710d..fed6de6 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -36,7 +36,9 @@ the objects and will not converge with the original branch.  You will not
 be able to easily push and distribute the rewritten branch on top of the
 original branch.  Please do not use this command if you do not know the
 full implications, and avoid using it anyway, if a simple single commit
-would suffice to fix your problem.
+would suffice to fix your problem.  (See the "RECOVERING FROM UPSTREAM
+REBASE" section in linkgit:git-rebase[1] for further information about
+rewriting published history.)
 
 Always verify that the rewritten version is correct: The original refs,
 if different from the rewritten ones, will be stored in the namespace
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 6abaeac..52aab5e 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -82,7 +82,9 @@ $ git reset --hard HEAD~3   <1>
 +
 <1> The last three commits (HEAD, HEAD^, and HEAD~2) were bad
 and you do not want to ever see them again.  Do *not* do this if
-you have already given these commits to somebody else.
+you have already given these commits to somebody else.  (See the
+"RECOVERING FROM UPSTREAM REBASE" section in linkgit:git-rebase[1] for
+the implications of doing so.)
 
 Undo a commit, making it a topic branch::
 +
-- 
1.6.0.1.470.g200b
