From: Luiz Fernando N Capitulino <lcapitulino@mandriva.com.br>
Subject: [PATCH 4/5] builtin-shortlog.c:  Use for_each_revision() helper
Date: Thu, 26 Apr 2007 16:46:39 -0300
Message-ID: <11776168011384-git-send-email-lcapitulino@mandriva.com.br>
References: <11776168001253-git-send-email-lcapitulino@mandriva.com.br>
Cc: git@vger.kernel.org,
	Luiz Fernando N Capitulino <lcapitulino@mandriva.com.br>
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Apr 26 21:47:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hh9w9-0000ZF-8S
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 21:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754960AbXDZTqy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 15:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754971AbXDZTqx
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 15:46:53 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:45837 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754960AbXDZTqw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 15:46:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id B903A17D44;
	Thu, 26 Apr 2007 16:46:50 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id zd-pGXAHE1De; Thu, 26 Apr 2007 16:46:41 -0300 (BRT)
Received: from doriath.conectiva (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 2B1F717D50;
	Thu, 26 Apr 2007 16:46:41 -0300 (BRT)
Received: by doriath.conectiva (Postfix, from userid 500)
	id 1036768B58A; Thu, 26 Apr 2007 16:46:41 -0300 (BRT)
X-Mailer: git-send-email 1.5.1.1.320.g1cf2
In-Reply-To: <11776168001253-git-send-email-lcapitulino@mandriva.com.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45648>

Signed-off-by: Luiz Fernando N Capitulino <lcapitulino@mandriva.com.br>
---
 builtin-shortlog.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 3f93498..eca802d 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -216,8 +216,7 @@ static void get_from_rev(struct rev_info *rev, struct path_list *list)
 	char scratch[1024];
 	struct commit *commit;
 
-	prepare_revision_walk(rev);
-	while ((commit = get_revision(rev)) != NULL) {
+	for_each_revision(commit, rev) {
 		const char *author = NULL, *oneline, *buffer;
 		int authorlen = authorlen, onelinelen;
 
-- 
1.5.1.1.320.g1cf2
