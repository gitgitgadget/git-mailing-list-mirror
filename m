From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v4 24/38] i18n: transport-helper.c: change N_() call to _()
Date: Tue,  7 Jun 2016 11:52:23 +0000
Message-ID: <1465300357-7557-25-git-send-email-vascomalmeida@sapo.pt>
References: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 13:55:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAFbF-000827-HI
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 13:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161140AbcFGLzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 07:55:04 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:58244 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754088AbcFGLy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 07:54:59 -0400
Received: (qmail 1824 invoked from network); 7 Jun 2016 11:54:57 -0000
Received: (qmail 21278 invoked from network); 7 Jun 2016 11:54:57 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 7 Jun 2016 11:54:55 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296654>

The N_() no-op call currently marks the string to be extracted by
xgettext but doesn't trigger the retrieval of the translation at run
time, whereas _() does both. Meaning that, in spite of having
translations available, they were never retrieved to make use of them.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 transport-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index bd666b2..4208743 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1038,7 +1038,7 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 				(*tail)->status |= REF_STATUS_UPTODATE;
 				if (read_ref((*tail)->name,
 					     (*tail)->old_oid.hash) < 0)
-					die(N_("Could not read ref %s"),
+					die(_("Could not read ref %s"),
 					    (*tail)->name);
 			}
 		}
-- 
2.7.3
