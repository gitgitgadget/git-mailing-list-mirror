Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493F8C433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 15:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376510AbiATPMZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 10:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376488AbiATPMV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 10:12:21 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B81EC061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:20 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id r7-20020a1c4407000000b0034e043aaac7so286687wma.5
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GydEKk/lw83MzlrywQVkOlfzU6wNV+DIBi8JuH4hUEI=;
        b=FIMT4tbd2i1Ga/sqi7Duk5CuM5JSpTePFDIXkKRsGAeM5Cl1iK2t0ecmYjFHzReFEJ
         BoWL8wkSoRV8nuPwFMOPfwzazrgEVIHOQfSaFFApayMSgzjGn6YpRQObUhA3loF6/cEJ
         qNkwZJbvj6OSvStXsiS7LE9+uOxRA9l1qzaWf0dXWl3lP64tMvLmghICnfBNr9EaDgXM
         PZcDLslFvPqu7cYKS4ey8lSjNkadej7/YRiIiRHWqFvw5SZZBrPqNTlh4Bl9iweOaGIv
         TBm+4z9UqISPotP0iyKoswX1OlbPsG0nvYlMvxw/fkg4HzefgsYOP0NAj0oqBPqb1dTt
         /E+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GydEKk/lw83MzlrywQVkOlfzU6wNV+DIBi8JuH4hUEI=;
        b=KGVUxxNjTg1FSvUcGqAINvg3XDftU4FQGLaNJr1GDaGa78NM0vYMmEGUpNkyyLiEnJ
         +/fodhJjEEc7O68iSGO7gQ0Pn+AubtjYv35sTQnqdy74VBHLHPlGF2MLne2Wj1EBzoTe
         Do8iGm8rgNxt2Sv37f0cAwIRAPEn8SrpbcPDWo3hYCFEFXE0zjc/rDKrzn0+ZgmmL2wt
         mWtO6PfB5A505z/rKypbGeqoEUdP63qAbYoJQ/lYQVcBfPrJFQvrwYfo1FC/s3doFY9A
         lGVxbtVK5Iubr8LJyFG7BYgqKHWBYBlj/vcS3kJ8lZMS50bZbwEgr01hLFe2qLNJfhun
         BHaA==
X-Gm-Message-State: AOAM5324iqmg/9T2ylGLMe6+QXi/RiuS5AD1ixEcD3zO4HhOIY6NAcTY
        PYC9je9a4l1sxHggxloA4JuzVPZsZyU=
X-Google-Smtp-Source: ABdhPJwkrpVm0n6J4R0VME5/JnU9Qwji2HkJ0LIabERh977rxnwNVczarX1hEXLScFvAQY8Fosuq+g==
X-Received: by 2002:a1c:a7c4:: with SMTP id q187mr7541791wme.35.1642691539049;
        Thu, 20 Jan 2022 07:12:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n32sm8286644wms.8.2022.01.20.07.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 07:12:18 -0800 (PST)
Message-Id: <8740ba92981c77f85b855e69c237fdb7449cca58.1642691534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
References: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
        <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Jan 2022 15:12:03 +0000
Subject: [PATCH v6 04/15] reftable: check reftable_stack_auto_compact() return
 value
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

Fixes a problem detected by Coverity.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/stack_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index f4c743db80c..e84f50d27ff 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -839,6 +839,7 @@ static void test_reftable_stack_auto_compaction(void)
 		EXPECT_ERR(err);
 
 		err = reftable_stack_auto_compact(st);
+		EXPECT_ERR(err);
 		EXPECT(i < 3 || st->merged->stack_len < 2 * fastlog2(i));
 	}
 
-- 
gitgitgadget

