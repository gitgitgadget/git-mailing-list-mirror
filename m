From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: [PATCH 4/5] builtin-shortlog.c:  Use for_each_revision() helper
Date: Fri, 27 Apr 2007 14:00:11 -0300
Message-ID: <11776932121002-git-send-email-lcapitulino@mandriva.com.br>
References: <11776932123749-git-send-email-lcapitulino@mandriva.com.br>
Cc: git@vger.kernel.org,
	"Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Apr 27 19:01:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhTp9-0001j2-D7
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 19:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756205AbXD0RBM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 13:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756198AbXD0RBI
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 13:01:08 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:47026 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756150AbXD0RA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 13:00:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 7D26A181B1;
	Fri, 27 Apr 2007 14:00:26 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id ufiRxENzGdnb; Fri, 27 Apr 2007 14:00:20 -0300 (BRT)
Received: from doriath.conectiva (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 07C9A181BA;
	Fri, 27 Apr 2007 14:00:12 -0300 (BRT)
Received: by doriath.conectiva (Postfix, from userid 500)
	id AE6E268B58A; Fri, 27 Apr 2007 14:00:12 -0300 (BRT)
X-Mailer: git-send-email 1.5.1.1.372.g4342
In-Reply-To: <11776932123749-git-send-email-lcapitulino@mandriva.com.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45731>

From: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>

Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>
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
1.5.1.1.372.g4342
