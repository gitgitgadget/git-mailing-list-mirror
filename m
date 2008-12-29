From: Thomas Rast <trast@student.ethz.ch>
Subject: rebase: update documentation for --root
Date: Mon, 29 Dec 2008 17:45:47 +0100
Message-ID: <17ca8054dfa6d82df9e7e7f40f2f9183d3039056.1230569041.git.trast@student.ethz.ch>
References: <cover.1230568082.git.trast@student.ethz.ch>
 <e8008f8e16a28c83a4fc6984966c91733b138598.1230569041.git.trast@student.ethz.ch>
 <5d0be6d15bbdaa8b95c1df161b67ecd4120d7ce4.1230569041.git.trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 17:47:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHLH0-00063I-Hi
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 17:47:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbYL2QqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 11:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751970AbYL2QqA
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 11:46:00 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:14401 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751929AbYL2Qp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 11:45:57 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 29 Dec 2008 17:45:53 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 29 Dec 2008 17:45:53 +0100
X-Mailer: git-send-email 1.6.1.1.g4c1d9.dirty
In-Reply-To: <5d0be6d15bbdaa8b95c1df161b67ecd4120d7ce4.1230569041.git.trast@student.ethz.ch>
In-Reply-To: <cover.1230569041.git.trast@student.ethz.ch>
References: <cover.1230569041.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 29 Dec 2008 16:45:53.0364 (UTC) FILETIME=[E9D28140:01C969D4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104113>

Since the new option depends on --onto and omission of <upstream>, use
a separate invocation style, and omit most options to save space.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-rebase.txt |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index c8ad86a..3268cd2 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -8,10 +8,11 @@ git-rebase - Forward-port local commits to the updated upstream head
 SYNOPSIS
 --------
 [verse]
-'git rebase' [-i | --interactive] [-v | --verbose] [-m | --merge]
-	[-s <strategy> | --strategy=<strategy>] [--no-verify]
-	[-C<n>] [ --whitespace=<option>] [-p | --preserve-merges]
-	[--onto <newbase>] <upstream> [<branch>]
+'git rebase' [-i | --interactive] [options] [--onto <newbase>]
+	<upstream> [<branch>]
+'git rebase' [-i | --interactive] [options] --onto <newbase>
+	--root [<branch>]
+
 'git rebase' --continue | --skip | --abort
 
 DESCRIPTION
@@ -22,7 +23,8 @@ it remains on the current branch.
 
 All changes made by commits in the current branch but that are not
 in <upstream> are saved to a temporary area.  This is the same set
-of commits that would be shown by `git log <upstream>..HEAD`.
+of commits that would be shown by `git log <upstream>..HEAD` (or
+`git log HEAD`, if --root is specified).
 
 The current branch is reset to <upstream>, or <newbase> if the
 --onto option was supplied.  This has the exact same effect as
@@ -255,6 +257,11 @@ OPTIONS
 --preserve-merges::
 	Instead of ignoring merges, try to recreate them.
 
+--root::
+	Rebase all commits reachable from <branch>, instead of
+	limiting them with an <upstream>.  This allows you to rebase
+	the root commit(s) on a branch.  Must be used with --onto.
+
 include::merge-strategies.txt[]
 
 NOTES
-- 
1.6.1.1.g4c1d9.dirty
