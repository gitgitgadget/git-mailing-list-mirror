Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3351C433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 15:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376542AbiATPMb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 10:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiATPMY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 10:12:24 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D875C061759
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:24 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id i187-20020a1c3bc4000000b0034d2ed1be2aso21196158wma.1
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s8KHLkLqupAFa85TGasfQB8YpksyOQa7dTuyqNPbJZM=;
        b=DRxjwg+yq/gkc7QeQ2Evwutq50I+Ny4TmImaRpa1aDoxwx0AOJu44Gv37i2AfHtPOo
         /KuBqNPQE2gTmDo2qg/LeQ7iAaQKjvGVGvAXbp4efhm/OjKH5ih6g5v/XMemMYdsFlsj
         Jpxw7Fj72cpzgqyJx7B4jBakdMdyUm3KC6Nadgl/B5I9ITTvKjyPmuYPTfGteSn68pv7
         XDFprZ4F/9FWLlgKzWcWXiW/Fm3hLxgydlVsE4pXacL4wyto18siM4nOIpqY8vzD7V4D
         sb9S3qWdPSnrVhKjP25vruauj6uuKtAgNCoN1Cuk4/gtR61Y6O9Lm4ZRRTbNbB7F8H4s
         k7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s8KHLkLqupAFa85TGasfQB8YpksyOQa7dTuyqNPbJZM=;
        b=obOMN/PbBsAH70424EpD5x4z2ueKGv7CkKbHPmz94RNOaeJXKtHByeUfymz3S9TmjC
         GMp+E+LhQqufUD9eikviYzXqVQi7RKdSM2yUGlv9MhV0Tpr788UMlyUyqUFKz0MDy9wY
         kWScce4EzqD0pP+mO0DFdxyECfsDBhlq05jtK/C28X1FhnyQgxkDyQJo6sXqFP2vas32
         xCQgx0oILojcdSru8cGwZZFWZS0Zu4DPHSiZJWIfqFyno8R+wwKlGPc7tr4uqJf2darb
         MAD2zaWM4MvmK1t1Um5im35J+RcNFkWaTf0QONr7kYSuaXY3lGg+s6Dp6SLIY2K7afth
         4RyQ==
X-Gm-Message-State: AOAM530NlUoquYvFgu18Shm2ndM43hAi6qkDHPeye/x405uVutp6XKqs
        KYyJ0Z11GGWwc1HWzHuKwSiUxt6W7yw=
X-Google-Smtp-Source: ABdhPJwgznvatoQAPxWUxgXLglJfXY5rhwHrM7hMDVyxjlKcXLzB0Q1UFXkgx9LI9EveNi1iXlD1rQ==
X-Received: by 2002:a5d:5887:: with SMTP id n7mr23810634wrf.499.1642691542823;
        Thu, 20 Jan 2022 07:12:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8sm8801634wmq.26.2022.01.20.07.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 07:12:22 -0800 (PST)
Message-Id: <0abaab1d7c47dfcea4490459897dd100d2be39a5.1642691534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
References: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
        <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Jan 2022 15:12:08 +0000
Subject: [PATCH v6 09/15] reftable: drop stray printf in readwrite_test
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

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/readwrite_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index edb9cfc1930..605ba0f9fd4 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -696,7 +696,6 @@ static void test_write_key_order(void)
 	err = reftable_writer_add_ref(w, &refs[0]);
 	EXPECT_ERR(err);
 	err = reftable_writer_add_ref(w, &refs[1]);
-	printf("%d\n", err);
 	EXPECT(err == REFTABLE_API_ERROR);
 	reftable_writer_close(w);
 	reftable_writer_free(w);
-- 
gitgitgadget

