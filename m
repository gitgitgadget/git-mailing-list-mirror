Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9208EECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 18:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiH3Su7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 14:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiH3Sue (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 14:50:34 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3001C45F43
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:31 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m16so15382318wru.9
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=vJ/hCck+XaBNHDW9f2+pkxNta44cpypydrMCRFEptu8=;
        b=GxYPbP4vOOVYZCDqm6EcsZ26hCBJJtYJ1ruPXR0r2fub0nrpvFT81DzPkFSuM8t/wr
         QPZWc5r/ssjOOPIfbfmb0FT0vKye7c7OkZ5CkikjL975vqlQw5iyNfh2ZmXtdSCheBHi
         Wr0rX6kZQ2iiXPqktvWIZRN+ZdnGpNDNn0lYzCgfFgzlo4g8EF1q8rOmznE/N0L9L+rY
         RT4B5p5dG8y41FRL4Yh4FS6FbeKaM3BLTZ3w0HnyHypo2wrMc/VMg3eNYkvZm3Ba5Gp8
         r3+Kg4hDbTPxXFwSLO5sPUt503rMwJJJxPg/q/djwMZvxb4qjREm9YDCXlnma2LYpP3Y
         VXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=vJ/hCck+XaBNHDW9f2+pkxNta44cpypydrMCRFEptu8=;
        b=6dmrDd0IxOwjVE1zgchN75tEeqvKkrEJ1C9bJ2MijYxi0TIPHOVl/DSoMt5sdDrIfx
         YACiSop3ckcrWoXfO8JulBerjMwmXh5+MkHH+kj7tZKIujfANh6WtxbtboKk4WEE8Io8
         lECXHIQVe74TgrPGrhfXeg0mDLvgLLxBYr9/G5rqM3Pb+Q6Dw/sC+a4KoFBMDu4sFBa/
         TS3e8gIL9Bt2bU/XKkIPLMU4KAQb7o04c0mO/zGyOWPm5hOcpd+f5D3NhEqQYgtj6XQq
         kry85lvBDz6TsZOmRh1McNwk3fFmBJ6a5lofdGRiTtWjXEZfexeEWmk2xsa1ByR0BN1L
         2m7Q==
X-Gm-Message-State: ACgBeo3LR+3/uarAVvOEytOsXQNTpyv6CmrXbq8E/DRws3cXXZlZFXs6
        oLaRYn0ijUhGYI7LpQCr2qT1F8qDciE=
X-Google-Smtp-Source: AA6agR7keGNgmkTpLYYKSoxCUYu7HievzJCWmIkIMA41xyouoMLQdUzZMMcLkWsL1D/ZtjzUD6jmDg==
X-Received: by 2002:a05:6000:1e1e:b0:226:e5c9:4b08 with SMTP id bj30-20020a0560001e1e00b00226e5c94b08mr2303985wrb.648.1661885430142;
        Tue, 30 Aug 2022 11:50:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l14-20020adfe58e000000b0022377df817fsm10149727wrm.58.2022.08.30.11.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:50:29 -0700 (PDT)
Message-Id: <30c87f2e92eacd315cf2ade6d704cdb03ef17a84.1661885419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
References: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
        <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Aug 2022 18:50:11 +0000
Subject: [PATCH v6 08/16] bisect: verify that a bogus option won't try to
 start a bisection
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We do not want `git bisect --bogus-option` to start a bisection. To
verify that, we look for the tell-tale error message `You need to start
by "git bisect start"` and fail if it was found.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6030-bisect-porcelain.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 83931d482fb..6d6e72276ae 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -900,6 +900,16 @@ test_expect_success 'bisect start with one term1 and term2' '
 	git bisect reset
 '
 
+test_expect_success 'bogus command does not start bisect' '
+	git bisect reset &&
+	test_must_fail git bisect --bisect-terms 1 2 2>out &&
+	! grep "You need to start" out &&
+	test_must_fail git bisect --bisect-terms 2>out &&
+	! grep "You need to start" out &&
+	grep "git bisect.*visualize" out &&
+	git bisect reset
+'
+
 test_expect_success 'bisect replay with term1 and term2' '
 	git bisect replay log_to_replay.txt >bisect_result &&
 	grep "$HASH2 is the first term1 commit" bisect_result &&
-- 
gitgitgadget

