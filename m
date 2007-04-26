From: Luiz Fernando N Capitulino <lcapitulino@mandriva.com.br>
Subject: [PATCH 2/5] builtin-fmt-merge-msg.c: Use for_each_revision() helper
Date: Thu, 26 Apr 2007 16:46:37 -0300
Message-ID: <11776168001607-git-send-email-lcapitulino@mandriva.com.br>
References: <11776168001253-git-send-email-lcapitulino@mandriva.com.br>
Cc: git@vger.kernel.org,
	Luiz Fernando N Capitulino <lcapitulino@mandriva.com.br>
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Apr 26 21:47:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hh9w8-0000ZF-Ln
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 21:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754967AbXDZTqw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 15:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754968AbXDZTqv
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 15:46:51 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:45831 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754967AbXDZTqu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 15:46:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id B298417D3F;
	Thu, 26 Apr 2007 16:46:48 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id Tm94c48Byqbl; Thu, 26 Apr 2007 16:46:41 -0300 (BRT)
Received: from doriath.conectiva (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 05D2817D44;
	Thu, 26 Apr 2007 16:46:41 -0300 (BRT)
Received: by doriath.conectiva (Postfix, from userid 500)
	id DEEA768B587; Thu, 26 Apr 2007 16:46:40 -0300 (BRT)
X-Mailer: git-send-email 1.5.1.1.320.g1cf2
In-Reply-To: <11776168001253-git-send-email-lcapitulino@mandriva.com.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45645>

Signed-off-by: Luiz Fernando N Capitulino <lcapitulino@mandriva.com.br>
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
1.5.1.1.320.g1cf2
