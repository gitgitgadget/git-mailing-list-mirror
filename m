From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Document option --only of git commit
Date: Thu, 10 Apr 2008 13:33:09 +0200
Message-ID: <1207827189-7509-2-git-send-email-johannes.sixt@telecom.at>
References: <1207827189-7509-1-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 13:34:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjv2b-000151-Ka
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 13:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755627AbYDJLdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 07:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754433AbYDJLdR
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 07:33:17 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:8920 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbYDJLdP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 07:33:15 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1Jjv1h-00023L-Uh; Thu, 10 Apr 2008 13:33:11 +0200
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A97A5C6A5; Thu, 10 Apr 2008 13:33:09 +0200 (CEST)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id 4D44CFA41; Thu, 10 Apr 2008 13:33:09 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.33.g376d1
In-Reply-To: <1207827189-7509-1-git-send-email-johannes.sixt@telecom.at>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79208>

Its documentation was removed by 6c96753df9db7f790a2ac4d95ec2a868394cd5ff,
even though it is referenced from a few places, including builtin-commit.c
(as part of the commentary in the commit message template).

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Documentation/git-commit.txt |   11 +++++++++++
 builtin-commit.c             |    2 +-
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index b4ae61f..4bb51cc 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -139,6 +139,17 @@ but can be used to amend a merge commit.
 	as well.  This is usually not what you want unless you
 	are concluding a conflicted merge.
 
+-o|--only::
+	Make a commit only from the paths specified on the
+	command line, disregarding any contents that have been
+	staged so far. This is the default mode of operation of
+	'git commit' if any paths are given on the command line,
+	in which case this option can be omitted.
+	If this option is specified together with '--amend', then
+	no paths need be specified, which can be used to amend
+	the last commit without committing changes that have
+	already been staged.
+
 -u|--untracked-files::
 	Show all untracked files, also those in uninteresting
 	directories, in the "Untracked files:" section of commit
diff --git a/builtin-commit.c b/builtin-commit.c
index e3adfdf..bcb7aaa 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -98,7 +98,7 @@ static struct option builtin_commit_options[] = {
 	OPT_BOOLEAN('a', "all", &all, "commit all changed files"),
 	OPT_BOOLEAN('i', "include", &also, "add specified files to index for commit"),
 	OPT_BOOLEAN(0, "interactive", &interactive, "interactively add files"),
-	OPT_BOOLEAN('o', "only", &only, ""),
+	OPT_BOOLEAN('o', "only", &only, "commit only specified files"),
 	OPT_BOOLEAN('n', "no-verify", &no_verify, "bypass pre-commit hook"),
 	OPT_BOOLEAN(0, "amend", &amend, "amend previous commit"),
 	OPT_BOOLEAN(0, "untracked-files", &untracked_files, "show all untracked files"),
-- 
1.5.5.33.g376d1
