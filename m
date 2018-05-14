Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7BAA1F42D
	for <e@80x24.org>; Mon, 14 May 2018 10:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752560AbeENK7F (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 06:59:05 -0400
Received: from ao2.it ([92.243.12.208]:53783 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752548AbeENK7D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 06:59:03 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fIBBp-000753-Oh; Mon, 14 May 2018 12:58:49 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1fIBC0-0002C7-LZ; Mon, 14 May 2018 12:59:00 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>, Antonio Ospite <ao2@ao2.it>
Subject: [RFC PATCH 03/10] t7411: be nicer to other tests and really clean things up
Date:   Mon, 14 May 2018 12:58:16 +0200
Message-Id: <20180514105823.8378-4-ao2@ao2.it>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514105823.8378-1-ao2@ao2.it>
References: <20180514105823.8378-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tests 5 and 8 in t/t7411-submodule-config.sh add two commits with
invalid lines in .gitmodules but then only the second commit is removed.

This may affect subsequent tests if they assume that the .gitmodules
file has no errors.

Since those commits are not needed anymore remove both of them.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---

I am putting these fixups to the test-suite before the patch that actually
needs them so that the test-suite passes after each commit.

 t/t7411-submodule-config.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index 0bde5850a..a648de6a9 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -135,7 +135,7 @@ test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
 			HEAD submodule \
 				>actual &&
 		test_cmp expect_error actual  &&
-		git reset --hard HEAD^
+		git reset --hard HEAD~2
 	)
 '
 
-- 
2.17.0

