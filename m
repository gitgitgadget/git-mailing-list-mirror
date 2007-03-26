From: James Bowes <jbowes@dangerouslyinc.com>
Subject: [PATCH] use xmalloc in git.c and help.c
Date: Sun, 25 Mar 2007 20:39:36 -0400
Message-ID: <11748695762499-git-send-email-jbowes@dangerouslyinc.com>
Cc: git@vger.kernel.org
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Mar 26 02:40:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVdGW-00072i-R9
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 02:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933247AbXCZAku (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 20:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933258AbXCZAku
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 20:40:50 -0400
Received: from ms-smtp-04.southeast.rr.com ([24.25.9.103]:35795 "EHLO
	ms-smtp-04.southeast.rr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933247AbXCZAkt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Mar 2007 20:40:49 -0400
Received: from localhost (cpe-066-057-086-146.nc.res.rr.com [66.57.86.146])
	by ms-smtp-04.southeast.rr.com (8.13.6/8.13.6) with ESMTP id l2Q0ell8029330;
	Sun, 25 Mar 2007 20:40:47 -0400 (EDT)
X-Mailer: git-send-email 1.5.0.5
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43100>

Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
---
 git.c  |    2 +-
 help.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index ed1c65e..5b1bc2a 100644
--- a/git.c
+++ b/git.c
@@ -99,7 +99,7 @@ static int split_cmdline(char *cmdline, const char ***argv)
 	int src, dst, count = 0, size = 16;
 	char quoted = 0;
 
-	*argv = malloc(sizeof(char*) * size);
+	*argv = xmalloc(sizeof(char*) * size);
 
 	/* split alias_string */
 	(*argv)[count++] = cmdline;
diff --git a/help.c b/help.c
index 0893fea..be8651a 100644
--- a/help.c
+++ b/help.c
@@ -58,7 +58,7 @@ static void add_cmdname(const char *name, int len)
 		if (!cmdname)
 			oom();
 	}
-	ent = malloc(sizeof(*ent) + len);
+	ent = xmalloc(sizeof(*ent) + len);
 	if (!ent)
 		oom();
 	ent->len = len;
-- 
1.5.0.5
