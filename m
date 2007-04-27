From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: [PATCH 3/5] reachable.c: Use for_each_revision() helper
Date: Fri, 27 Apr 2007 14:00:10 -0300
Message-ID: <1177693212471-git-send-email-lcapitulino@mandriva.com.br>
References: <11776932123749-git-send-email-lcapitulino@mandriva.com.br>
Cc: git@vger.kernel.org,
	"Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Apr 27 19:01:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhTp8-0001j2-6e
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 19:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756183AbXD0RBH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 13:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756143AbXD0RBG
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 13:01:06 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:47035 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756145AbXD0RA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 13:00:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 8E9C6181B6;
	Fri, 27 Apr 2007 14:00:24 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id ARxw4zWddFzL; Fri, 27 Apr 2007 14:00:18 -0300 (BRT)
Received: from doriath.conectiva (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id F15FF181B7;
	Fri, 27 Apr 2007 14:00:12 -0300 (BRT)
Received: by doriath.conectiva (Postfix, from userid 500)
	id A938F68B587; Fri, 27 Apr 2007 14:00:12 -0300 (BRT)
X-Mailer: git-send-email 1.5.1.1.372.g4342
In-Reply-To: <11776932123749-git-send-email-lcapitulino@mandriva.com.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45732>

From: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>

Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>
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
1.5.1.1.372.g4342
