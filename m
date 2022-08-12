Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FFCC00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 20:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbiHLUKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 16:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbiHLUK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 16:10:26 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4749C64CA
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 13:10:25 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id p10so2245291wru.8
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 13:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=fTQyYbLVeujkIXWBZRa69qVeE19+Lc0IZap+yd+gMZw=;
        b=F57dzq5xg1Yitx4aa+X5/VAoOGzT3p/dM4+d4mkS5W/HeAoDlH3H9srjhIeArXvuJa
         KW2Fmf8rDTdmtk885i2zGfxYzxUcxR0EFxcBFclAyJXquVJ3Un6ee2Ip7FyGnXVSnAtp
         tXFH9czvyHew/ZJgXfDLkCpArAmaDegkMNVLjZIi+oPjKZJgHnsDd/neC1QvC7vgjXCq
         Vq2dp+kCwKsu9nP6sz3WRu5royR22MN6HtZUPYf5F8beNXY/fxodM1HW/IzaWAHT1iW+
         Nzi0k+XsfYdMNWQ4FP3/Kcbe1G47y2nk8qfKr+rLJLsmmgD0jpRLt2LKgGIT+Pdk5T4b
         YXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=fTQyYbLVeujkIXWBZRa69qVeE19+Lc0IZap+yd+gMZw=;
        b=hyWJApzOT1JoYxC7/oA9Ivj/OZMc+o91CQLNLgxfe5HeIPTr0Yfes4PX6z4E8i8fQK
         cQ5V0BXzt0BbfijYsgqqsL96UN6KEhp/jpyX6Koy9PDLgQr+YR8waRqBdxpl6uTgHO/n
         nAgXV2MJRX2k8v1ALEGluO1ttfCvKPmPHviJXD8ddTXDqztBfswe56bj34DsptxZ4f9M
         EOuPi/GNyLb1Mw0SbHdSQ2CRLnaM+hlLhmG7+7IFkMdKnsgj7HYEWXzEnDz61utVh3uL
         /PWED9dahfTELc8EsX5ERPcOVHelbZ/y5/l3HUEKdMwN5hi6mknDLmWjZBOhfOeSsz6e
         ibKQ==
X-Gm-Message-State: ACgBeo3AW4l4Ulvo1Dtx5+7ztI6/DWRk4oD3A+Qpf7ZLTvsbD5kwmcD7
        G108PrJbDnR4k/uxjj3o52KC3ZymGBg=
X-Google-Smtp-Source: AA6agR5T/Ei8U/JcjW54MoPUDUzFkCNudHipDs5c2AcRf0TRSoSXGVR2gMB/KMPErm4BjD4AocfGMQ==
X-Received: by 2002:a05:6000:3c6:b0:220:5efd:423c with SMTP id b6-20020a05600003c600b002205efd423cmr3039588wrg.214.1660335023426;
        Fri, 12 Aug 2022 13:10:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c248300b003a342933727sm574106wms.3.2022.08.12.13.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 13:10:22 -0700 (PDT)
Message-Id: <78a93eb95bb0c43778501f03837bffdcf74e4c99.1660335019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>
References: <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
        <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Aug 2022 20:10:10 +0000
Subject: [PATCH v4 02/11] scalar-diagnose: avoid 32-bit overflow of size_t
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Avoid 32-bit size_t overflow when reporting the available disk space in
'get_disk_info' by casting the block size and available block count to
'off_t' before multiplying them. Without this change, 'st_mult' would
(correctly) report a size_t overflow on 32-bit systems at or exceeding 2^32
bytes of available space.

Note that 'off_t' is a 64-bit integer even on 32-bit systems due to the
inclusion of '#define _FILE_OFFSET_BITS 64' in 'git-compat-util.h' (see
b97e911643 (Support for large files on 32bit systems., 2007-02-17)).

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 contrib/scalar/scalar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 97e71fe19cd..04046452284 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -348,7 +348,7 @@ static int get_disk_info(struct strbuf *out)
 	}
 
 	strbuf_addf(out, "Available space on '%s': ", buf.buf);
-	strbuf_humanise_bytes(out, st_mult(stat.f_bsize, stat.f_bavail));
+	strbuf_humanise_bytes(out, (off_t)stat.f_bsize * (off_t)stat.f_bavail);
 	strbuf_addf(out, " (mount flags 0x%lx)\n", stat.f_flag);
 	strbuf_release(&buf);
 #endif
-- 
gitgitgadget

