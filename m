Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D21C433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 13:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiJQNRw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 09:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiJQNRu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 09:17:50 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113FD5F7E9
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:17:49 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bk15so18379450wrb.13
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXEoc6/5lUfAgWQpoF3mlId0HIU3GZEyBxBCSN9AC7I=;
        b=GTDwGcRuXzKQPikPRZFvNgULJhKwapc/VqxrLPza9PMEMOpOnZMxHc8d1MruGIO559
         c6UKiygT//HtBRgqLMgWZKluTFQtHd1yhtz3nJV8d3+h5GxIHRXLIyX/nR2EOO51UpsM
         U+hH0rukhh0P59supCiFcJopHwEQuBo5E/5avUlBCrbSWnZufLkOVAlNaWZJ0g4tX4Uw
         Onyn1K32FxQrmrIeHT6X1e0IydENOxrKXCdBFoAfLtzs7tVGpyvW6BRjHMCNH0wD04uC
         p5AwthyFc9Gpjug8/DGm2ai6WjGp6a4g10dD9x4kaxJwdZ1wLZoMgu/pEQBI7kTTXinc
         TEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXEoc6/5lUfAgWQpoF3mlId0HIU3GZEyBxBCSN9AC7I=;
        b=tzeYl36wHADrLZW4qVFqNABC5RkgnuYWnh/MgDL2oWQC1ZDz5LQFkx1vdfEDS+qhjU
         NFpHrBExrX2Reuh+gM8cRilfco+sba8YTMqi9Kgc/0xsSIgluDc76cIK8tcMgxtaYASE
         GY6/LS9ELLHdQ0IM8aZfxh3JjGlizeVP3lLx6LdEou3DBB5nBWxmLoiAdCkDyzEHmN0U
         lGx2KzbORgOZYFVMqsQRqGU7Hf4hERSHWkNZP61puuNFNFyXRWvWZRQRaFnYZ/OR2+qM
         fjV/dTxSoTpQDdPs+Z5zHBAlCliNFZvWR5gaeFw77ZF4aBN388MyN8iE8Aoskr82hzcY
         D25g==
X-Gm-Message-State: ACrzQf3RV2E7hHyAMqD0pxIVsM6F4rvqHygl3zCCRDmjLqt1xWTO+2vR
        hnw/lRbsP4rFPptBo7nlJWflENbrbzc=
X-Google-Smtp-Source: AMsMyM7stMAy/bF8BlVxqrYf2eJWy3FtLP7pOadf2KFse59klzLNcKb4QrXFsS4Pej6f/vuinVjewA==
X-Received: by 2002:a5d:408e:0:b0:22e:650a:ec4b with SMTP id o14-20020a5d408e000000b0022e650aec4bmr6439055wrp.212.1666012667357;
        Mon, 17 Oct 2022 06:17:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u7-20020adfed47000000b002286670bafasm8565550wro.48.2022.10.17.06.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 06:17:46 -0700 (PDT)
Message-Id: <12fb0ac6d5d932f9a8685d803ed017c357182768.1666012665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1323.v4.git.1666012665.gitgitgadget@gmail.com>
References: <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
        <pull.1323.v4.git.1666012665.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Oct 2022 13:17:38 +0000
Subject: [PATCH v4 1/8] t3416: tighten two tests
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
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
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

