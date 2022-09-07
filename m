Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8501AC6FA86
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 14:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiIGOh7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 10:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiIGOh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 10:37:56 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0807755C
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 07:37:55 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bq9so7809282wrb.4
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 07:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=oXEoc6/5lUfAgWQpoF3mlId0HIU3GZEyBxBCSN9AC7I=;
        b=nvToeB2U2YA9UuO/YrxK72C4OourEmNtgNOQDtmHItpaPejKgLHaFiTWKEnqabRqt/
         Pok29Pq+zsT4HVY/jJ67MqGDIFWpz9khVU2gtVm4O0AAvrMoeDesYspgAKm5vWMW1iT9
         pMKWrddRFgmFie4IO/Uqy/Yd2TUAIXdR0zkvoPLBAS0oLDML/aiqiFXW9JX+PZp/dsvH
         t0Uh6jR+19k2SRV06ESG0ikIa4hIsvyqaesOAWNlwn5W7XqLqJmh9TBFHivaBZnBxNor
         PwwnMJo8ncfPW+rE8/j6IT/V8LysauX/g+rNmCBk8UGxIeDcypcev2eteQNlBny/Jq7b
         W3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=oXEoc6/5lUfAgWQpoF3mlId0HIU3GZEyBxBCSN9AC7I=;
        b=ROEtm31DfR8C80l0nBZ0zZbGdaY3wei/0o3RvLOCdcqcZ60FXO3VRoHwny9wjWdre+
         E3vy5+3cO2MEomz0kb1OOBU9MO6EksFVFa1S6v0S9EKhmuCOtsDvDrzsAfE4pEs3x7UP
         qeJrZuXf/CDQ5XFEpKgaShwhFRrFAgYnVknaSqd7c2LPfFHAOOAlpj+mlw/aUIt5sRGK
         fOuE/mRDX7Yo14r+0IwZoDx1Z9d4zdmCQIaVpE5jCvctrSaBInni0jPpz8Mm1XASqiIf
         cpLSe2KBssWTLpDPkkBtYCok5bWaJQe6j6/Gfxn5o4rgYV1RDFBh0JPAKT+nyYcBJPpx
         bFYg==
X-Gm-Message-State: ACgBeo0gKInuZB+AlD1QscOLYkHj3RctkjJqBnFIek3IZcnfTTzQyzY4
        R00gVkhqgctMYf23BqF7krkzULt34Zs=
X-Google-Smtp-Source: AA6agR52Z4NCeHvSGVUFgFwiR9gkalr+QsRo0ceZ2gMihQ3cwJ862nWvwbhNG5RzTLpdreuRjGC2rg==
X-Received: by 2002:a5d:6388:0:b0:228:c792:aabe with SMTP id p8-20020a5d6388000000b00228c792aabemr2268863wru.689.1662561473606;
        Wed, 07 Sep 2022 07:37:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bt24-20020a056000081800b0022377df817fsm18059192wrb.58.2022.09.07.07.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 07:37:52 -0700 (PDT)
Message-Id: <12fb0ac6d5d932f9a8685d803ed017c357182768.1662561470.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
        <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Sep 2022 14:37:44 +0000
Subject: [PATCH v2 1/7] t3416: tighten two tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add a check for the correct error message to the tests that check we
require a single merge base so we can be sure the rebase failed for
the correct reason. Also rename the tests to reflect what they are
testing.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3416-rebase-onto-threedots.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
index 3e04802cb00..dc67d2308f3 100755
--- a/t/t3416-rebase-onto-threedots.sh
+++ b/t/t3416-rebase-onto-threedots.sh
@@ -97,13 +97,14 @@ test_expect_success 'rebase -i --onto main...' '
 	test_cmp expect actual
 '
 
-test_expect_success 'rebase -i --onto main...side' '
+test_expect_success 'rebase --onto main...side requires a single merge-base' '
 	git reset --hard &&
 	git checkout side &&
 	git reset --hard K &&
 
 	set_fake_editor &&
-	test_must_fail git rebase -i --onto main...side J
+	test_must_fail git rebase -i --onto main...side J 2>err &&
+	grep "need exactly one merge base" err
 '
 
 test_expect_success 'rebase --keep-base --onto incompatible' '
@@ -182,13 +183,14 @@ test_expect_success 'rebase -i --keep-base main topic from main' '
 	test_cmp expect actual
 '
 
-test_expect_success 'rebase -i --keep-base main from side' '
+test_expect_success 'rebase --keep-base requires a single merge base' '
 	git reset --hard &&
 	git checkout side &&
 	git reset --hard K &&
 
 	set_fake_editor &&
-	test_must_fail git rebase -i --keep-base main
+	test_must_fail git rebase -i --keep-base main 2>err &&
+	grep "need exactly one merge base with branch" err
 '
 
 test_done
-- 
gitgitgadget

