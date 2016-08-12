Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D13AD2018E
	for <e@80x24.org>; Fri, 12 Aug 2016 12:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbcHLMAP (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 08:00:15 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:37528 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751574AbcHLMAO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 08:00:14 -0400
Received: (qmail 13601 invoked from network); 12 Aug 2016 12:00:10 -0000
Received: (qmail 5770 invoked from network); 12 Aug 2016 12:00:10 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 12 Aug 2016 12:00:07 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/3] t3404: become resilient to GETTEXT_POISON
Date:	Fri, 12 Aug 2016 11:59:00 +0000
Message-Id: <1471003142-1739-1-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The concerned test greps the output of exit_with_patch() in
git-rebase--interactive.sh script.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 t/t3404-rebase-interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 197914b..597e94e 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1286,7 +1286,7 @@ test_expect_success 'rebase -i --gpg-sign=<key-id>' '
 	set_fake_editor &&
 	FAKE_LINES="edit 1" git rebase -i --gpg-sign="\"S I Gner\"" HEAD^ \
 		>out 2>err &&
-	grep "$SQ-S\"S I Gner\"$SQ" err
+	test_i18ngrep "$SQ-S\"S I Gner\"$SQ" err
 '
 
 test_done
-- 
2.7.4

