Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BF1A2070F
	for <e@80x24.org>; Thu, 15 Sep 2016 15:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbcIOPAW (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 11:00:22 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:55501 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750922AbcIOPAU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 11:00:20 -0400
Received: (qmail 17882 invoked from network); 15 Sep 2016 15:00:17 -0000
Received: (qmail 12958 invoked from network); 15 Sep 2016 15:00:16 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 15 Sep 2016 15:00:11 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 01/14] i18n: apply: mark plural string for translation
Date:   Thu, 15 Sep 2016 14:58:55 +0000
Message-Id: <1473951548-31733-1-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
References: <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark plural string for translation using Q_().

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/apply.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 1a488f9..ef03c74 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4768,10 +4768,12 @@ static int apply_all_patches(struct apply_state *state,
 			       state->whitespace_error),
 			    state->whitespace_error);
 		if (state->applied_after_fixing_ws && state->apply)
-			warning("%d line%s applied after"
-				" fixing whitespace errors.",
-				state->applied_after_fixing_ws,
-				state->applied_after_fixing_ws == 1 ? "" : "s");
+			warning(Q_("%d line applied after"
+				   " fixing whitespace errors.",
+				   "%d lines applied after"
+				   " fixing whitespace errors.",
+				   state->applied_after_fixing_ws),
+				state->applied_after_fixing_ws);
 		else if (state->whitespace_error)
 			warning(Q_("%d line adds whitespace errors.",
 				   "%d lines add whitespace errors.",
-- 
2.7.4

