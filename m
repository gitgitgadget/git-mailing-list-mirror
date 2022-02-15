Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5376C433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 08:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbiBOIcm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 03:32:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiBOIch (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 03:32:37 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959D2C3309
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 00:32:28 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m126-20020a1ca384000000b0037bb8e379feso903376wme.5
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 00:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YIwZ1zfPp3II5K+wfNAzshh5OSylkxFuME6uVSGIRF4=;
        b=i7K8FnMCEPah4pqhbToU8yLwKL4lp7o5Wnl/mn/oXHzLDqSfUPAUc/I85Sl81cPht1
         k+CKZOaEeqV2UiN1n7tUr4QM4vpN6eG/PokLQe5XXK5Zw9NeLzDKRZDXG71b+5hLJCYV
         TxnqnZpy9xzTzB5RDct9ORIKS7IFne1sexFC+N43WVxkKkjCVJ05kBCG2d4i6ycJMPj3
         Z2LZkR44sh9/ddNgXDL64EpdLftqqHoPYzBzfJeJ7gzZDeGI+RfCDYWsZLy0MCgol1x4
         DXCqItqqnu8CaFM9Nnjkd5FpnuFwOkau017BXiVPzi8D8Y7ONfCeP/wB/6QdMWW+sVs5
         k7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YIwZ1zfPp3II5K+wfNAzshh5OSylkxFuME6uVSGIRF4=;
        b=nQyESKlmGgiA57COUWeKfl7iUQ5gaYWI3qif4qXZ0KFUVsRYaxkpZwwlbU4tBMwFCn
         1P50vp027x/W5AX92ZXs+126YGUixtHxTv/m1YlohKxhWWY7dUOZv9cyJX3LnTYLXAJx
         dIJ5eFlCu/UekPXQ/xSlQ/P8+yxJ5Yv6StCSqVNjQOye3XmT7KqAcnLrssINMcBJcL5a
         DP6nDeKEQIsd+VjJquvAUiZ5xMfwOtuU1CH8i99e42vJYTJ1rdfo48nSDYrlSKNtpR5x
         ymeyEWYDk8cQiPu5M+DbdW/HMV3QglYSjPDQwrp5ljEdTXpGmXcQ36bSjcmUjDaxvVMl
         fHjA==
X-Gm-Message-State: AOAM5332B01+6A/6iE0hGCvJBUhpAxEEMTbS8ouadsgfzJSMziD8Df6A
        7axh3G1ZDb3oQwcjiiPZ09h24l6rfTw=
X-Google-Smtp-Source: ABdhPJzorLbk6FDq6Z79gZHdW+8duqnTUdzXWaJvGpdE7YWS4nUChDcP5oTMM3QWkd/MuIprTOXItA==
X-Received: by 2002:a1c:f403:: with SMTP id z3mr2121528wma.83.1644913946989;
        Tue, 15 Feb 2022 00:32:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n2sm4980456wmq.6.2022.02.15.00.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 00:32:26 -0800 (PST)
Message-Id: <9edad872e0d986c8f9e18dae58e86e826c97237b.1644913943.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com>
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
        <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 08:32:19 +0000
Subject: [PATCH v2 2/6] sparse-checkout: correctly set non-cone mode when
 expected
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

commit f2e3a218e8 ("sparse-checkout: enable `set` to initialize
sparse-checkout mode", 2021-12-14) made the `set` command able to
initialize sparse-checkout mode, but it also had to function when
sparse-checkout mode was already setup and the user just wanted to
change the sparsity paths.  So, if the user passed --cone or --no-cone,
then we should override the current setting, but if they didn't pass
either, we should use whatever the current cone mode setting is.

Unfortunately, there was a small error in the logic in that it would not
set the in-memory cone mode value (core_sparse_checkout_one) when
--no-cone was specified, but since it did set the config setting on
disk, any subsequent git invocation would correctly get non-cone mode.
As such, the error did not previously matter.  However, a subsequent
commit will add some logic that depends on core_sparse_checkout_cone
being set to the correct mode, so make sure it is set consistently with
the config values we will be writing to disk.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index fcd574f5fc1..fb85a1459c3 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -403,6 +403,7 @@ static int update_modes(int *cone_mode, int *sparse_index)
 		core_sparse_checkout_cone = 1;
 	} else {
 		mode = MODE_ALL_PATTERNS;
+		core_sparse_checkout_cone = 0;
 	}
 	if (record_mode && set_config(mode))
 		return 1;
-- 
gitgitgadget

