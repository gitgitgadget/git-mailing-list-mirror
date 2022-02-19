Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC993C433FE
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 16:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242670AbiBSQpN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 11:45:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241036AbiBSQpK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 11:45:10 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04E95F4DD
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 08:44:50 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id p9so19598245wra.12
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 08:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7YuP0Nx5zpadGi0XMIQi9hW1TFbpV+oEB6DRVtErdrw=;
        b=lhJMNVMxgPHg16sUmpfnKuEkX7AJIufBYb8XULwh6qTKN9+H5rBXVAdaffLayYS1Hw
         P9eH8OSpBL2iaWHMOHNEmhdpjU5jhd0MGylQrN+G4d4RWmy38L4rZGzgkhdNUWJM2IcW
         US3JZswrQ57j1cUAYO1f/qEQAqxQOTpFDUOZZwzosYNKQT2F9TaIrCFG80qda/QXF7FF
         Gwd+odXwYreJkKRhCnDVyLq+Oy4Ag360Pj06xUGhVGzp0I7/6rAB7TTW+kycl9aoX6Wl
         +g/fYhf123gMr0qB2m+SmT6S4LeVQ87HCnAuv4CEAokLfNPHxdytKo+WBdnJmYtmLqlT
         LBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7YuP0Nx5zpadGi0XMIQi9hW1TFbpV+oEB6DRVtErdrw=;
        b=CM2q9fJ4oogm9kqXyRIH6xTBA/9HXATDIPMbCMbA8mtFDDC9x2WH1cdxfhKfCcI7vf
         t4r77ZtCq/J49+Q/LaTYtJGK004k/NgqP2CeMl281s9DCs9+HDOCk4OFYnIruQaHOYcg
         /ab1yJ4V/dohbJLhECa/5t9/w4mP6XBm2Zq1zngDQKXV/ZEPpe5ugKSjYwCqFpcsfz66
         1eMzEG963HveZADYPOxrPw7bLVshDLTAad6nB5BlWzuTf5yNReW7DPVdPZn0EhFpOJ2E
         K1DgCBG+p7Z1KwwXdNL0vKErtkAbvWdMHH7ZwD+Ji/EuPgMreL16Hv2pwx/caQOYrozn
         LnOQ==
X-Gm-Message-State: AOAM531EmHshN8hp3d+2bWEeh8gFRdfPpV01c1PK74ttyYxuc6LY2OQE
        9eW8hyFFKo2UCr8g8S4X0xDKDw74H38=
X-Google-Smtp-Source: ABdhPJwIiwmyHyRsYJoGAadqOPmx+KKIVIIGMWfGLg5P6LEazKBJqFMOLx5M0ELWJFqOb+XYNvM2GQ==
X-Received: by 2002:a05:6000:1a8c:b0:1e8:88a7:d158 with SMTP id f12-20020a0560001a8c00b001e888a7d158mr9746320wry.364.1645289089431;
        Sat, 19 Feb 2022 08:44:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p2sm2778932wmc.33.2022.02.19.08.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 08:44:48 -0800 (PST)
Message-Id: <0c2ab523e74be6f39b82c8fc9c73b4ac57f9963e.1645289086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1118.v5.git.1645289086.gitgitgadget@gmail.com>
References: <pull.1118.v4.git.1645080889.gitgitgadget@gmail.com>
        <pull.1118.v5.git.1645289086.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 19 Feb 2022 16:44:42 +0000
Subject: [PATCH v5 2/5] sparse-checkout: correctly set non-cone mode when
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
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
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

Reviewed-by: Derrick Stolee <derrickstolee@github.com>
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

