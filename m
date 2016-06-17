Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F29711FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 20:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbcFQUYg (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:24:36 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:60182 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964897AbcFQUYf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:24:35 -0400
Received: (qmail 21746 invoked from network); 17 Jun 2016 20:24:34 -0000
Received: (qmail 8665 invoked from network); 17 Jun 2016 20:24:33 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 20:24:33 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 24/38] i18n: transport-helper.c: change N_() call to _()
Date:	Fri, 17 Jun 2016 20:21:13 +0000
Message-Id: <1466194887-18236-25-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
2.6.6

