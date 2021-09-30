Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D63C4332F
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 14:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6896E61A55
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 14:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351926AbhI3Owt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 10:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351915AbhI3Ows (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 10:52:48 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7473DC06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 07:51:05 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m22so5086221wrb.0
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 07:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kWQPjrk76/fCKSTx7JTIfz6mPHkIGUtZo1+CF8cCSwM=;
        b=UlvV1jAHkkaTlOPkDGbT6NdT/wJ2jL5xpNKInkZSHM7RRnApDmuKA5CY/5cQRj6FB9
         qSC9i+AaqUSXxEJyFNlM7bAO3z9pPNrdTCJmW4h2i4N/kq9fSyB1pCcYU5S8goVEihOk
         AmjRfcRZ+K6AepFaIZlngof3KrdiMqx5P1RszOUCWiJ6yDxSsCVeCO3oDZh4qbQxHMRy
         kbz32DvKzl335aYZz5X/42egVbnMwQq0djd01kEgiXwSn8q4VymD7a7eLLNrH1HNRWtQ
         g7G/tkmJ4DCGv6KIwJYazLXM6tQaJ3fOXFlfR+gXsH00XW+Wu6rckLKQ3fjvXFk9Bf0a
         7U3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kWQPjrk76/fCKSTx7JTIfz6mPHkIGUtZo1+CF8cCSwM=;
        b=XrVNH0WLJa4R1w+wtCP7L+TMYwPmoE5CK/B4SGqd09cfosoDyh/txMRBYjPwUuW0ZK
         7+rQg2ai8A0JTWevhnkN0sPCpelrlJK4FQs9ads/q8chm7dfSh9ALmqULMvjTgDqjjxA
         5BDQDJPlHGKwRbdsP1ZMp9fcN5pbg1YGAFwdfeTEdYTAjLANQ2f9udaAUkRTcQe+qtXb
         doE6axAgETY+NZ6pLvwKAsOkI4uwpN6OMNFj2NSNmR9ZY4sx2kk8eWK/U2kcQxIFp/MJ
         74RmWm3QA94dLkYxxIyLHC6+Vd+JJ0Uh+3y7tvB9NPvZobJP9B1hUbdUfNI6O6vwuNOh
         wlKg==
X-Gm-Message-State: AOAM531v4Dzrf8LnGdh6Ooe5x4ZOaMsYiU/ov7twRMjuRi2Ozw7GcdVd
        mqD6uXQ4Y5s5GRYL7T83Dxx+CgKY4fg=
X-Google-Smtp-Source: ABdhPJzG/pR1APraOVqqMd/p0ppchvxH0YV43q0bwBOybMqjdpyUgVKBpvUZpmuR0lTp0d32/P/AhQ==
X-Received: by 2002:adf:b7c1:: with SMTP id t1mr6622593wre.387.1633013464117;
        Thu, 30 Sep 2021 07:51:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c17sm4843637wmr.15.2021.09.30.07.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:51:03 -0700 (PDT)
Message-Id: <a1fa7c080aed2056afaad6415186c125c04a80cb.1633013461.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Sep 2021 14:50:56 +0000
Subject: [PATCH 2/7] sparse-index: update command for expand/collapse test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

In anticipation of multiple commands being fully integrated with sparse
index, update the test for index expand and collapse for non-sparse index
integrated commands to use `mv`.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index c5977152661..aed8683e629 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -642,7 +642,7 @@ test_expect_success 'sparse-index is expanded and converted back' '
 	init_repos &&
 
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
-		git -C sparse-index -c core.fsmonitor="" reset --hard &&
+		git -C sparse-index -c core.fsmonitor="" mv a b &&
 	test_region index convert_to_sparse trace2.txt &&
 	test_region index ensure_full_index trace2.txt
 '
-- 
gitgitgadget

