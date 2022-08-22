Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A44C3F6B0
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 18:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbiHVS0y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 14:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbiHVS0s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 14:26:48 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C87148C81
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 11:26:47 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h24so14263501wrb.8
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 11:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=UtFOpsAFtA+0uOV/y++ymgbeFjDHTU0b15sKcoQ4Xck=;
        b=VJRSKttLCNf0Q/oJpRmKdtGtz/qjG1wrP4idwpxRpOhEWX58fHPThlOmN4RcCzbzM0
         amyS3/HFK/T6xvW3em5XbIsjL6uPBODiwP2O7FpEISg1isCTbws+0rNyGLSxinDu4uE0
         4nYRdZNLaKRyaOeFhb+COclH1yNPNBoPrP4jQZBY1LDEGTgf4DSc1wOnwiijPrb9b37R
         cVfsxElL6sA0D+xKc01DIsb8l7b97bh2FpzFfPeeDS+pr29QU9Vd6wgH4gwXMc6oQIt8
         hceZKs3T4oj1GtSddaEGdS40G5R6+WAxPo9bJz1sjT8GOS99xXOphkK6UG8/nQPmmtA+
         slIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=UtFOpsAFtA+0uOV/y++ymgbeFjDHTU0b15sKcoQ4Xck=;
        b=60iEVLzY0oGAOCvXeR1L1liLl8Y18GQjiWIRq2hITUs+IlUNSCJiRGW4o0zqFEN1F2
         NqRjuhPpWO7nGZba63X0ALrE49p8lvtFao3AkVRBBziF2syzSoZReS8CiDcv4yN+UefC
         o6aDkrJ4LFhXnuox0TTvoRVa80TOymVBRZhXtx9hhold1sm/+kqmqwnTeOGpPGb7yLLE
         9nPZpx/IfpE3Mcg8Gw/O1VBO+C3h+w4fmVYafhstUEJjWMexiVkEWJ4K4IFJwopPT9Ty
         /LwmX0fAU0Qo+I5nxpTkJHUyq9Z0zBNQSlesC1+zJXVsJMr+/OHzrTpiH6MRo6cb2r6W
         vkHw==
X-Gm-Message-State: ACgBeo2Q4iJVhMNJBHlX7QXiq3CoRA+/HbKkTRtKDjXl6kPonkCgorW8
        ESt1w16DwWVCiYPXUZItxkfRHcDU2nE=
X-Google-Smtp-Source: AA6agR5ZtxuRYUxpe7+1zC/DQ+2wpwMmuewh0YGbWBehy3kWCWGZvM8bhg0OHnDrX7Gq6MMIW/TtrA==
X-Received: by 2002:a05:6000:11ce:b0:225:2e98:2c20 with SMTP id i14-20020a05600011ce00b002252e982c20mr11757415wrx.137.1661192805612;
        Mon, 22 Aug 2022 11:26:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q3-20020a05600000c300b00225285b8136sm11930733wrx.38.2022.08.22.11.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:26:45 -0700 (PDT)
Message-Id: <7b0784056f3cc0c96e9543ae44d0f5a7b0bf85fa.1661192802.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1312.git.git.1661192802.gitgitgadget@gmail.com>
References: <pull.1312.git.git.1661192802.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Aug 2022 18:26:41 +0000
Subject: [PATCH 2/3] t1092: fix buggy sparse "blame" test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

This test wants to verify that `git blame` errors out when asked to
blame a file _not_ in the sparse checkout. However, the very first file
it asks to blame _is_ present in the checkout, thus `test_must_fail git
blame $file` gives an unexpected result (the "blame" succeeds). This
problem went unnoticed because the test invokes `test_must_fail git
blame $file` in loop but forgets to break out of the loop early upon
failure, thus the failure gets swallowed.

Fix the test by having it not ask to blame a file present in the sparse
checkout, and instead only blame files not present, as intended. While
at it, also add the missing `|| return 1` which allowed this bug to go
unnoticed.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index a6a14c8a21f..e13368861ce 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -567,7 +567,7 @@ test_expect_success 'blame with pathspec outside sparse definition' '
 	init_repos &&
 	test_sparse_match git sparse-checkout set &&
 
-	for file in a \
+	for file in \
 			deep/a \
 			deep/deeper1/a \
 			deep/deeper1/deepest/a
@@ -579,7 +579,7 @@ test_expect_success 'blame with pathspec outside sparse definition' '
 		# We compare sparse-checkout-err and sparse-index-err in
 		# `test_sparse_match`. Given we know they are the same, we
 		# only check the content of sparse-index-err here.
-		test_cmp expect sparse-index-err
+		test_cmp expect sparse-index-err || return 1
 	done
 '
 
-- 
gitgitgadget

