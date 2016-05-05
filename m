From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH] gitk: Makefile: create install bin directory
Date: Thu,  5 May 2016 17:46:32 +0000
Message-ID: <1462470392-19991-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 19:47:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayNNJ-00007I-TP
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 19:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506AbcEERrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 13:47:41 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:52008 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750854AbcEERrl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 13:47:41 -0400
Received: (qmail 20083 invoked from network); 5 May 2016 17:47:38 -0000
Received: (qmail 5727 invoked from network); 5 May 2016 17:47:38 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 5 May 2016 17:47:33 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293656>

Force creation of destination bin directory. Before this commit, gitk
would fail to install if this directory didn't already exist.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 5acdc90..5bdd52a 100644
--- a/Makefile
+++ b/Makefile
@@ -50,6 +50,7 @@ endif
 all:: gitk-wish $(ALL_MSGFILES)
 
 install:: all
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -m 755 gitk-wish '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(msgsdir_SQ)'
 	$(foreach p,$(ALL_MSGFILES), $(INSTALL) -m 644 $p '$(DESTDIR_SQ)$(msgsdir_SQ)' &&) true
-- 
2.7.3
