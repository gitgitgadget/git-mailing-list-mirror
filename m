From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: [PATCH 2/5] builtin-fmt-merge-msg.c: Use for_each_revision() helper
Date: Fri, 27 Apr 2007 14:00:09 -0300
Message-ID: <11776932122334-git-send-email-lcapitulino@mandriva.com.br>
References: <11776932123749-git-send-email-lcapitulino@mandriva.com.br>
Cc: git@vger.kernel.org,
	"Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Apr 27 19:01:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhTp6-0001j2-86
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 19:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756112AbXD0RBE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 13:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756183AbXD0RBD
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 13:01:03 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:47026 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756143AbXD0RAY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 13:00:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 5545E181B4;
	Fri, 27 Apr 2007 14:00:22 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id 5vuI7-kZnKbL; Fri, 27 Apr 2007 14:00:13 -0300 (BRT)
Received: from doriath.conectiva (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id DC8C7181B6;
	Fri, 27 Apr 2007 14:00:12 -0300 (BRT)
Received: by doriath.conectiva (Postfix, from userid 500)
	id A2DAC68B586; Fri, 27 Apr 2007 14:00:12 -0300 (BRT)
X-Mailer: git-send-email 1.5.1.1.372.g4342
In-Reply-To: <11776932123749-git-send-email-lcapitulino@mandriva.com.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45734>

From: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>

Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>
---
 builtin-fmt-merge-msg.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index 5c145d2..8e1db1c 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -189,8 +189,7 @@ static void shortlog(const char *name, unsigned char *sha1,
 	add_pending_object(rev, branch, name);
 	add_pending_object(rev, &head->object, "^HEAD");
 	head->object.flags |= UNINTERESTING;
-	prepare_revision_walk(rev);
-	while ((commit = get_revision(rev)) != NULL) {
+	for_each_revision(commit, rev) {
 		char *oneline, *bol, *eol;
 
 		/* ignore merges */
-- 
1.5.1.1.372.g4342
