Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD6DD209AA
	for <e@80x24.org>; Fri, 14 Oct 2016 11:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754704AbcJNLr0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 07:47:26 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:40814 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754336AbcJNLrY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 07:47:24 -0400
Received: (qmail 18642 invoked from network); 14 Oct 2016 11:47:22 -0000
Received: (qmail 30772 invoked from network); 14 Oct 2016 11:47:21 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 14 Oct 2016 11:47:19 -0000
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
Subject: [PATCH 2/3] i18n: apply: mark info messages for translation
Date:   Fri, 14 Oct 2016 11:43:36 +0000
Message-Id: <20161014114337.18684-2-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.10.1.459.g5fd885d
In-Reply-To: <20161014114337.18684-1-vascomalmeida@sapo.pt>
References: <20161014114337.18684-1-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark messages for translation printed to stderr.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 apply.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/apply.c b/apply.c
index 201d3a7..13b2064 100644
--- a/apply.c
+++ b/apply.c
@@ -3554,7 +3554,7 @@ static int try_threeway(struct apply_state *state,
 		return error("repository lacks the necessary blob to fall back on 3-way merge.");
 
 	if (state->apply_verbosity > verbosity_silent)
-		fprintf(stderr, "Falling back to three-way merge...\n");
+		fprintf(stderr, _("Falling back to three-way merge...\n"));
 
 	img = strbuf_detach(&buf, &len);
 	prepare_image(&tmp_image, img, len, 1);
@@ -3586,7 +3586,7 @@ static int try_threeway(struct apply_state *state,
 	if (status < 0) {
 		if (state->apply_verbosity > verbosity_silent)
 			fprintf(stderr,
-				"Failed to fall back on three-way merge...\n");
+				_("Failed to fall back on three-way merge...\n"));
 		return status;
 	}
 
@@ -3600,12 +3600,12 @@ static int try_threeway(struct apply_state *state,
 		oidcpy(&patch->threeway_stage[2], &post_oid);
 		if (state->apply_verbosity > verbosity_silent)
 			fprintf(stderr,
-				"Applied patch to '%s' with conflicts.\n",
+				_("Applied patch to '%s' with conflicts.\n"),
 				patch->new_name);
 	} else {
 		if (state->apply_verbosity > verbosity_silent)
 			fprintf(stderr,
-				"Applied patch to '%s' cleanly.\n",
+				_("Applied patch to '%s' cleanly.\n"),
 				patch->new_name);
 	}
 	return 0;
-- 
2.10.1.459.g5fd885d

