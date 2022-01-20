Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B7BC433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 15:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376524AbiATPMe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 10:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376514AbiATPMY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 10:12:24 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C18C061753
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:23 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso22639740wmj.2
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pMYa0dfQa1Y/HGAo4moCXBwMLCmicYjMXhnW/sy5Md0=;
        b=qyV/9O4Znm4gOArqo6ts0AYtWYyIVLX2JDCEDy33fDt3rghy0b2xvkWpAHpXdp+pNQ
         jPuZt3md/hARNAZaGMmhVt+XciaMXQclkGBr3sZY2RFn5wbZJaBeBdk6ERdk8qyV3ZhF
         mKR/Y+Mmo4ZXvh0srDsw7liKXvO9XaIUr0WMf1yOipMBXHXTKBFS0UdOy6fztunTPK92
         ikzevtAcWH+VIBuBgoq8GpJW3e8p3qrPMfouc06FmOvzKuQ5t9v3NUt6Nyba9QBNKfkZ
         fMaibLeqwVJTVfAOFQOYDYGADoCwIF3zT7g2XRSu2IBQD6m7hR9t8iHnhj9DLlrwR6H7
         xQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pMYa0dfQa1Y/HGAo4moCXBwMLCmicYjMXhnW/sy5Md0=;
        b=ERtUToBTsf+X2IRZKa/LhfdumdUMhXPW5kHOrQ0cS0CB1bqnQ/9OPkt0FSGiiAGCgD
         q7EpMyXwDIZ3OGqTEbjb0+QOWYfpYyhQOpFYYpPPAvfzLdpkmRYxUkbA1qHg8W2Fg69V
         Vs3oQChrPKiqAzUFZ3lBFzlwbVZYQsjYoiAQ+ADs8ZxFfN4FoQK3tdOOwUQtFeaq903W
         mjvq6ZDocW+QkISAylaOCBMJbsHXkwBGNjgYpSUmW1UVvv12hEvNVh2GIz5A08eEjJgP
         j3vmDXLU8Tn6HDILyUhx7saN37nbrm5qVH63t+Gex+7l9iZ9S9Hox4VF6H8Nxp0GAStE
         p+og==
X-Gm-Message-State: AOAM532bT6weeKjWr0XYlKTpdSgAZZyNXr/aUO+e9g4A/fOovuSIVt+x
        ZNmkxiP5AHv56VZLty5v8JIDfkYbNyM=
X-Google-Smtp-Source: ABdhPJxsaTXdtvMC+0xKn95nbK8JVenqFUcssAOHyL1mbRfQrf4sRrALrUQmlO0lu4uVihZK3E+pJA==
X-Received: by 2002:a5d:4944:: with SMTP id r4mr6610908wrs.550.1642691542030;
        Thu, 20 Jan 2022 07:12:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15sm4140992wrf.79.2022.01.20.07.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 07:12:21 -0800 (PST)
Message-Id: <6f4f24c17ad91b28b22deff2530039bcfde2cbe9.1642691534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
References: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
        <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Jan 2022 15:12:07 +0000
Subject: [PATCH v6 08/15] reftable: order unittests by complexity
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This is a more practical ordering when working on refactorings of the
reftable code.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/helper/test-reftable.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 26b03d7b789..1f0a28cbb64 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -3,15 +3,16 @@
 
 int cmd__reftable(int argc, const char **argv)
 {
+	/* test from simple to complex. */
 	basics_test_main(argc, argv);
+	record_test_main(argc, argv);
 	block_test_main(argc, argv);
-	merged_test_main(argc, argv);
+	tree_test_main(argc, argv);
 	pq_test_main(argc, argv);
-	record_test_main(argc, argv);
-	refname_test_main(argc, argv);
 	readwrite_test_main(argc, argv);
+	merged_test_main(argc, argv);
 	stack_test_main(argc, argv);
-	tree_test_main(argc, argv);
+	refname_test_main(argc, argv);
 	return 0;
 }
 
-- 
gitgitgadget

