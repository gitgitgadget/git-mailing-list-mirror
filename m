Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03674C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 04:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346124AbiHSE2Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 00:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242340AbiHSE2S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 00:28:18 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430972BC7
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 21:28:15 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u14so3811468wrq.9
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 21:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=GfuK3OfjqWycfIsAchRueEqPHtrs16kkw+UuZuK+2sM=;
        b=BVG2+zsi8z3raPOjH1P/VYP+2xXJT6cJFuVX4zDHrYrBYPOLOwqZwGV2yhBUX/rkgL
         GWyGeXZeCbF8Z2w/3qKhsHMi4Setd9vunWCik2WlaQkGHexrOu0FsiJYZlZHsUmA/V8J
         0+2vbvhkB3Cba4EnFF8GTTKXOe5ktbgK6RkINapWz7sg/8KP8wlUvGabVnvJyvwWuTdz
         EBQ+evFqTKHHFEMLlZa6hnlwhCOdy3vIgpRkvpY+Ec438DRW1LytBb4VIdaGX1En9YZ4
         /VbuzThezLAa+Ehpj1d/PgNq4uEt799A7ewEq0hhCmKQOk2a5eGznD6ukjX4mBHXE+Ej
         Ku3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=GfuK3OfjqWycfIsAchRueEqPHtrs16kkw+UuZuK+2sM=;
        b=az5662WnjM1mFbN0b7Y0Vh83+UDvQ8FawpKccnKAgB1Ah2irlWDM+BfZ1wBKKoA+ck
         d3Y1JKuNI12D/YM0pJ0AcHtiv5thjG8Yd+vjPWpjoYgcqm+TfySsvu8X7YAyYII/BNCE
         I0pD04fcDWOlU4iTIAAtFWhAIYFEyA3YSCVwJbgOic283QmqfUYBkYBbyN3Edqwf12T7
         R91tax9LZWn8cj3s2FSooO4TFNZKy66gE5yoceRwWI+Vrpf8fl6w2tBF+8TvWeaigMb/
         xwnEUfpNpPPy5zPuSPfJKEOEygMYrC/0J6TbMtJffRRWNjGxTYzoG2vDMp3PhFmixSKL
         a0Kg==
X-Gm-Message-State: ACgBeo1Qx0FNF8ZUL+n3pPS+A6dEw/nWvLLeomQ9rq44RK8zz8KrvrAe
        A/IKpHUVUkznFy4OQOujgvruwI6qp74=
X-Google-Smtp-Source: AA6agR7jYl/fQnLzewec889yg+OPWiI1pjFNgvgGgRmcY0/LQ/lYL74anEoSURt20pOGbqrj2Q7dgw==
X-Received: by 2002:a5d:6b01:0:b0:225:2890:516f with SMTP id v1-20020a5d6b01000000b002252890516fmr2961957wrw.665.1660883293566;
        Thu, 18 Aug 2022 21:28:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w6-20020a5d4b46000000b002205a5de337sm2969286wrs.102.2022.08.18.21.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 21:28:12 -0700 (PDT)
Message-Id: <68ab719d99c68c81159c65ee42930a3023f275db.1660883290.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1303.v3.git.1660883290.gitgitgadget@gmail.com>
References: <pull.1303.v2.git.1660803467.gitgitgadget@gmail.com>
        <pull.1303.v3.git.1660883290.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Aug 2022 04:28:08 +0000
Subject: [PATCH v3 1/3] rev-list-options.txt: fix simple typo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/rev-list-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 195e74eec63..2f85726745a 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -659,7 +659,7 @@ Here, the merge commits `O` and `P` contribute extra noise, as they did
 not actually contribute a change to `file.txt`. They only merged a topic
 that was based on an older version of `file.txt`. This is a common
 issue in repositories using a workflow where many contributors work in
-parallel and merge their topic branches along a single trunk: manu
+parallel and merge their topic branches along a single trunk: many
 unrelated merges appear in the `--full-history` results.
 
 When using the `--simplify-merges` option, the commits `O` and `P`
-- 
gitgitgadget

