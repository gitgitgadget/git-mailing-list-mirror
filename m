From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [PATCH] contrib/subtree: Fix make install target
Date: Tue, 30 Jul 2013 10:16:09 +0200
Message-ID: <1375172169-26582-1-git-send-email-sojkam1@fel.cvut.cz>
Cc: gitster@pobox.com, Michal Sojka <sojkam1@fel.cvut.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 30 10:16:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V456v-0000sN-K4
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 10:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758088Ab3G3IQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 04:16:44 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:36501 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758079Ab3G3IQg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 04:16:36 -0400
Received: from localhost (unknown [192.168.200.7])
	by max.feld.cvut.cz (Postfix) with ESMTP id 11FE63CFEAB;
	Tue, 30 Jul 2013 10:16:33 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10044)
	with ESMTP id LfTLjnA9BlAq; Tue, 30 Jul 2013 10:16:28 +0200 (CEST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id E29B83CFE87;
	Tue, 30 Jul 2013 10:16:27 +0200 (CEST)
Received: from wsh by steelpick.2x.cz with local (Exim 4.80)
	(envelope-from <sojkam1@fel.cvut.cz>)
	id 1V456V-0006vK-24; Tue, 30 Jul 2013 10:16:23 +0200
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231352>

If the libexec directory doesn't exist, git-subtree gets installed as
$prefix/share/libexec/git-core file. This patch creates the directory
before installing git-subtree file into it.

Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
---
 contrib/subtree/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
index b507505..435b2de 100644
--- a/contrib/subtree/Makefile
+++ b/contrib/subtree/Makefile
@@ -30,6 +30,7 @@ $(GIT_SUBTREE): $(GIT_SUBTREE_SH)
 doc: $(GIT_SUBTREE_DOC)
 
 install: $(GIT_SUBTREE)
+	$(INSTALL) -d -m 755 $(DESTDIR)$(libexecdir)
 	$(INSTALL) -m 755 $(GIT_SUBTREE) $(DESTDIR)$(libexecdir)
 
 install-doc: install-man
-- 
1.8.3.2
