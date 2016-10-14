Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBC0C209AA
	for <e@80x24.org>; Fri, 14 Oct 2016 11:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754668AbcJNLrY (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 07:47:24 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:40765 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751605AbcJNLrX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 07:47:23 -0400
Received: (qmail 18479 invoked from network); 14 Oct 2016 11:47:19 -0000
Received: (qmail 30008 invoked from network); 14 Oct 2016 11:47:19 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 14 Oct 2016 11:47:17 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>
Subject: [PATCH 1/3] i18n: apply: mark plural string for translation
Date:   Fri, 14 Oct 2016 11:43:35 +0000
Message-Id: <20161014114337.18684-1-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.10.1.459.g5fd885d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark plural string for translation using Q_().

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 apply.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/apply.c b/apply.c
index b03d274..201d3a7 100644
--- a/apply.c
+++ b/apply.c
@@ -4869,10 +4869,12 @@ int apply_all_patches(struct apply_state *state,
 			goto end;
 		}
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
2.10.1.459.g5fd885d

