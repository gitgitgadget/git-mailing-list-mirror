Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1A61207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 12:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753184AbcJLM11 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 08:27:27 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:54244 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752653AbcJLM10 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 08:27:26 -0400
Received: (qmail 16429 invoked from network); 12 Oct 2016 12:26:26 -0000
Received: (qmail 8336 invoked from network); 12 Oct 2016 12:26:26 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 12 Oct 2016 12:26:21 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>, Jeff King <peff@peff.net>
Subject: [PATCH] t1512: become resilient to GETTEXT_POISON build
Date:   Wed, 12 Oct 2016 12:25:33 +0000
Message-Id: <20161012122533.32223-1-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.10.1.396.gf6299d3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The concerned message was marked for translation by 0c99171
("get_short_sha1: mark ambiguity error for translation", 2016-09-26).

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 t/t1512-rev-parse-disambiguation.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 7c659eb..711704b 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -42,7 +42,7 @@ test_expect_success 'blob and tree' '
 
 test_expect_success 'warn ambiguity when no candidate matches type hint' '
 	test_must_fail git rev-parse --verify 000000000^{commit} 2>actual &&
-	grep "short SHA1 000000000 is ambiguous" actual
+	test_i18ngrep "short SHA1 000000000 is ambiguous" actual
 '
 
 test_expect_success 'disambiguate tree-ish' '
-- 
2.7.4

