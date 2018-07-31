Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 471581F597
	for <e@80x24.org>; Tue, 31 Jul 2018 13:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732197AbeGaOr4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 10:47:56 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55870 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731962AbeGaOr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 10:47:56 -0400
Received: by mail-wm0-f67.google.com with SMTP id f21-v6so2995734wmc.5
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 06:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rsUn5gimoEnmc3yKoDdGMCUACbM1kjEloO5ZsRZj7d8=;
        b=VhPHtcMK44/MGfEBngJVggmyBfKkZQUC0FWE4f/IfxwBRz5p1RHAQv3naEZ+LKc/2O
         MNJ/1pB9M5H6SU1N89wJNnh+k8lofVXXVOlYaKjNrl3EGYMsitBLUujs2xREXt40DJmE
         SB+Ciapn7kOvFl0DlxDRWZypxXqdiLcptiPa+KOiF1Dx8W6Aop6oQmXWSjYfieun99bA
         fu3+NDXZdND551HKXseryPWV5Gl7zRMXqS7lCliKk+U2sMIntl/c9zO0de8q79iiL9tD
         YgJgYFJGDrpQ9JxefUEo81xaLOdZczlWxFa46ZpeQKUWktxBrJrs3QrwyQ4LzsspCkfh
         P8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rsUn5gimoEnmc3yKoDdGMCUACbM1kjEloO5ZsRZj7d8=;
        b=WlFiI7IbiqnPT/sHxM23fApYLYGqKMj2sK6GwI5I6YjMwqJLoPDsmFku8CeiTRIA5F
         EIOD3RyOAPB9HvkdS6haGS4UtLjIw42PsZra4AGbMHX4t7hUxawVY0l6zIvmK3mWqmVK
         jzj3klPGG9wejiFBJYq32Cx4C31Wvzhy/nq2RbaSih0ckfvJHOicj+loBgQpC0S4uQRX
         cl+gTPu9g8uppEeRfUGXAgvssoyvSBUPvWNEIwipYoLBFJx6JE+0S6dvgBbkAB7VOMqe
         BqerY+TDYFGxc9DtbFF4AnvnotioEFdLD9euesRdGRAIvAxV53I2vwCWd5mMPg1mWDrJ
         bllQ==
X-Gm-Message-State: AOUpUlG3rp7MS1VAGpef9ApMM+1hqitQX4GWH6SlBTkZv2w6AR58Kl5h
        /OPnpI3FOc/I+b9Ivhppeb4yTF2iScs=
X-Google-Smtp-Source: AAOMgpfa0vEkkxQ9/2/swdB7K1d4j41rICCxIFYkdLQfC+OC/kf/Y4Vxs6gjmpieDd6rmvSWjAqjMg==
X-Received: by 2002:a1c:7408:: with SMTP id p8-v6mr2183632wmc.118.1533042459607;
        Tue, 31 Jul 2018 06:07:39 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p25-v6sm894081wmc.29.2018.07.31.06.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 06:07:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/10] push tests: fix logic error in "push" test assertion
Date:   Tue, 31 Jul 2018 13:07:11 +0000
Message-Id: <20180731130718.25222-4-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180429202100.32353-1-avarab@gmail.com>
References: <20180429202100.32353-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a logic error that's been here since this test was added in
dbfeddb12e ("push: require force for refs under refs/tags/",
2012-11-29).

The intent of this test is to force-create a new tag pointing to
HEAD~, and then assert that pushing it doesn't work without --force.

Instead, the code was not creating a new tag at all, and then failing
to push the previous tag for the unrelated reason of providing a
refspec that doesn't make any sense.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5516-fetch-push.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 4d487d6875..82af990ab3 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -979,8 +979,8 @@ test_expect_success 'push requires --force to update lightweight tag' '
 		git tag -f testTag &&
 		test_must_fail git push ../child2 testTag &&
 		git push --force ../child2 testTag &&
-		git tag -f testTag &&
-		test_must_fail git push ../child2 testTag HEAD~ &&
+		git tag -f testTag HEAD~ &&
+		test_must_fail git push ../child2 testTag &&
 		git push --force ../child2 testTag
 	)
 '
-- 
2.18.0.345.g5c9ce644c3

