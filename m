From: Luiz Fernando N Capitulino <lcapitulino@mandriva.com.br>
Subject: [PATCH 3/5] reachable.c: Use for_each_revision() helper
Date: Thu, 26 Apr 2007 16:46:38 -0300
Message-ID: <11776168002081-git-send-email-lcapitulino@mandriva.com.br>
References: <11776168001253-git-send-email-lcapitulino@mandriva.com.br>
Cc: git@vger.kernel.org,
	Luiz Fernando N Capitulino <lcapitulino@mandriva.com.br>
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Apr 26 21:47:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hh9wA-0000ZF-Hj
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 21:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754970AbXDZTrA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 15:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031347AbXDZTrA
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 15:47:00 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:45856 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754970AbXDZTq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 15:46:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 9EF7217D50;
	Thu, 26 Apr 2007 16:46:57 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id 5H6kQJySsgFX; Thu, 26 Apr 2007 16:46:49 -0300 (BRT)
Received: from doriath.conectiva (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 397BC17D51;
	Thu, 26 Apr 2007 16:46:41 -0300 (BRT)
Received: by doriath.conectiva (Postfix, from userid 500)
	id F34D468B586; Thu, 26 Apr 2007 16:46:40 -0300 (BRT)
X-Mailer: git-send-email 1.5.1.1.320.g1cf2
In-Reply-To: <11776168001253-git-send-email-lcapitulino@mandriva.com.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45649>

Signed-off-by: Luiz Fernando N Capitulino <lcapitulino@mandriva.com.br>
---
 reachable.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/reachable.c b/reachable.c
index ff3dd34..b69edd8 100644
--- a/reachable.c
+++ b/reachable.c
@@ -79,7 +79,7 @@ static void walk_commit_list(struct rev_info *revs)
 	struct object_array objects = { 0, 0, NULL };
 
 	/* Walk all commits, process their trees */
-	while ((commit = get_revision(revs)) != NULL)
+	for_each_revision(commit, revs)
 		process_tree(commit->tree, &objects, NULL, "");
 
 	/* Then walk all the pending objects, recursively processing them too */
@@ -195,6 +195,5 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog)
 	 * Set up the revision walk - this will move all commits
 	 * from the pending list to the commit walking list.
 	 */
-	prepare_revision_walk(revs);
 	walk_commit_list(revs);
 }
-- 
1.5.1.1.320.g1cf2
