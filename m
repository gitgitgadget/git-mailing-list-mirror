Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 833A71FC45
	for <e@80x24.org>; Sun, 12 Feb 2017 21:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbdBLVya (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 16:54:30 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34667 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbdBLVyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 16:54:25 -0500
Received: by mail-wm0-f67.google.com with SMTP id c85so16203041wmi.1
        for <git@vger.kernel.org>; Sun, 12 Feb 2017 13:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4uZU4bTi1AIcsvDWkdpW0eNlnGboubzT457WQ8IMWHk=;
        b=tSJPwOhOtZUo9xMxrsJFUo4oruNg5nH4COf55HCdo0yQPXiPdQNe2+QyxOkgOUvz/u
         OwSmko/BxRNp7c2A4vudx4MNkYC9zl3/8+JRlRalf88Rk5mOJDDwJy+kWeBIemV2+mKS
         hE040xAtiSZx5f7fIuCSTB/YYCwO6AZqI5NVGJh2cyQi5ay63kjs+XZ5hhvTpJ3EuBIs
         bfdw3wRuKGMF7brthQlyZB22SswOB34rll9vG2QxDuEjYMpvhG+VPKB3mW/Sy1kmxTYO
         r4rfIWlpxY2QiBFosbhlTY/pLpjStBdNCPc2x6qqoExIfr9Iyhfu7hJ7QhYmgGzVRzRM
         tfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4uZU4bTi1AIcsvDWkdpW0eNlnGboubzT457WQ8IMWHk=;
        b=cFWX+LpO0abYTgUV7TsosSAfKKdWZlyabRramYZJzA/UYgzJwRJV21MS73PNNeInN8
         myruYa9jgSbg5tayf8pNow7XAjF+DVF+Nng0+SESrScQ+U80uQ2bNOSBn1PqXFhuVPR1
         8hZ+uJ4nFySLKDhYG9hVnr74CsOMg4uTMKc0ksrbaCkiPCOqkuwDgv6l2lKy0+16dxMX
         C93NEW6iHTmPiRfD6+m7Mubo9+sjXqv4UEtrFWfUbdqwoDc4SprJxqEqbZa2Y3vedYAr
         W81BSWAU1HcKX1rnA6gDtVU2PaI7UFE67nQsRtltg4XuSP8Ze/YDhheYt1d03e4AyYuX
         jl+Q==
X-Gm-Message-State: AMke39l1aSlS0YRu4BU7rNK1Gj8QqSzQOddeUbRcYkTDlAU7jWsIV0/ELPOCQ4RH9Qgacg==
X-Received: by 10.28.215.200 with SMTP id o191mr15846727wmg.118.1486936463875;
        Sun, 12 Feb 2017 13:54:23 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id q16sm8247422wra.69.2017.02.12.13.54.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Feb 2017 13:54:23 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=20=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 3/7] stash: add test for the create command line arguments
Date:   Sun, 12 Feb 2017 21:54:16 +0000
Message-Id: <20170212215420.16701-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.301.g86e6ecc671.dirty
In-Reply-To: <20170212215420.16701-1-t.gummerer@gmail.com>
References: <mailto:20170205202642.14216-1-t.gummerer@gmail.com>
 <20170212215420.16701-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently there is no test showing the expected behaviour of git stash
create's command line arguments.  Add a test for that to show the
current expected behaviour and to make sure future refactorings don't
break those expectations.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/t3903-stash.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 3577115807..ffe3549ea5 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -784,4 +784,22 @@ test_expect_success 'push -m shows right message' '
 	test_cmp expect actual
 '
 
+test_expect_success 'create stores correct message' '
+	>foo &&
+	git add foo &&
+	STASH_ID=$(git stash create "create test message") &&
+	echo "On master: create test message" >expect &&
+	git show --pretty=%s -s ${STASH_ID} >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'create with multiple arguments for the message' '
+	>foo &&
+	git add foo &&
+	STASH_ID=$(git stash create test untracked) &&
+	echo "On master: test untracked" >expect &&
+	git show --pretty=%s -s ${STASH_ID} >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.11.0.301.g86e6ecc671.dirty

