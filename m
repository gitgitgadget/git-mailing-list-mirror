From: Alp Toker <alp@atoker.com>
Subject: [PATCH] Fix typos involving the word 'commit'
Date: Sun, 09 Jul 2006 10:36:24 +0100
Message-ID: <11524377843467-git-send-email-alp@atoker.com>
References: <11524377844177-git-send-email-alp@atoker.com>
Reply-To: Alp Toker <alp@atoker.com>
Cc: Alp Toker <alp@atoker.com>
X-From: git-owner@vger.kernel.org Sun Jul 09 11:36:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzViP-0002EJ-7T
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 11:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbWGIJga (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 05:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWGIJga
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 05:36:30 -0400
Received: from host-84-9-44-142.bulldogdsl.com ([84.9.44.142]:36369 "EHLO
	ndesk.org") by vger.kernel.org with ESMTP id S964982AbWGIJga (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 05:36:30 -0400
Received: by ndesk.org (Postfix, from userid 1000)
	id 48A6A1645C8; Sun,  9 Jul 2006 10:36:24 +0100 (BST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.1.gbe4c7
In-Reply-To: <11524377844177-git-send-email-alp@atoker.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23534>

Signed-off-by: Alp Toker <alp@atoker.com>
---
 Documentation/git-cvsexportcommit.txt |    2 +-
 refs.c                                |   12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
index 56bd3e5..27ac72d 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -8,7 +8,7 @@ git-cvsexportcommit - Export a commit to
 
 SYNOPSIS
 --------
-'git-cvsexportcommmit' [-h] [-v] [-c] [-p] [-f] [-m msgprefix] [PARENTCOMMIT] COMMITID
+'git-cvsexportcommit' [-h] [-v] [-c] [-p] [-f] [-m msgprefix] [PARENTCOMMIT] COMMITID
 
 
 DESCRIPTION
diff --git a/refs.c b/refs.c
index 713ca46..2d9c1dc 100644
--- a/refs.c
+++ b/refs.c
@@ -362,7 +362,7 @@ static int log_ref_write(struct ref_lock
 	int logfd, written, oflags = O_APPEND | O_WRONLY;
 	unsigned maxlen, len;
 	char *logrec;
-	const char *comitter;
+	const char *committer;
 
 	if (log_all_ref_updates) {
 		if (safe_create_leading_directories(lock->log_file) < 0)
@@ -380,23 +380,23 @@ static int log_ref_write(struct ref_lock
 	}
 
 	setup_ident();
-	comitter = git_committer_info(1);
+	committer = git_committer_info(1);
 	if (msg) {
-		maxlen = strlen(comitter) + strlen(msg) + 2*40 + 5;
+		maxlen = strlen(committer) + strlen(msg) + 2*40 + 5;
 		logrec = xmalloc(maxlen);
 		len = snprintf(logrec, maxlen, "%s %s %s\t%s\n",
 			sha1_to_hex(lock->old_sha1),
 			sha1_to_hex(sha1),
-			comitter,
+			committer,
 			msg);
 	}
 	else {
-		maxlen = strlen(comitter) + 2*40 + 4;
+		maxlen = strlen(committer) + 2*40 + 4;
 		logrec = xmalloc(maxlen);
 		len = snprintf(logrec, maxlen, "%s %s %s\n",
 			sha1_to_hex(lock->old_sha1),
 			sha1_to_hex(sha1),
-			comitter);
+			committer);
 	}
 	written = len <= maxlen ? write(logfd, logrec, len) : -1;
 	free(logrec);
-- 
1.4.1.gbe4c7
