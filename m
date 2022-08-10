Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35717C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 23:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiHJXep (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 19:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbiHJXem (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 19:34:42 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A6486C19
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 16:34:38 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l22so19494173wrz.7
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 16:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=fTQyYbLVeujkIXWBZRa69qVeE19+Lc0IZap+yd+gMZw=;
        b=VZqy5rsbsaSw8BX7n3+dqC+Ekk/DEziEpJcbwN9v20C6VXHWiw15bUOll8wwaWg6EL
         hjBdIw8g1aA/lPUZfxblqo42twT+qD+1wdNY0gYP++flaTYNOZf0a+rrlp/egFninTOt
         j2t+MU8+wF6woPZJgUoV4gjIpQu2yiKB9OOT34S/O2a7KbT73vCfGBdvhAEq0DvbvjeP
         AGgPhZ87t862x8/zCJBtTwKS9odB0cT6BvRZbw9sdhWQk6Eh+3QNeCL/5V7xK1rgCgUi
         5dGhWKEewisHNIUu4SuhvGBG9mYW94vRxorzr41K4IpdJyQzWgavRS7gdLskqbuuiyZ3
         q4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=fTQyYbLVeujkIXWBZRa69qVeE19+Lc0IZap+yd+gMZw=;
        b=VDN8weCvwUVrmb88ACibFu4Z/j71cV+/QCJhAUbvNblPU/IhbCg6foEvoGYRibd0B1
         kyBQtZiiiU0woCe2w7M4oYCHMuJuMAKa29H0L50sEbrT+5N3tNMEmanepCtBhrdtAyd1
         Ben24YerNB39+SNQd74tJyVpCz8bMcTA2qaoPQVtKStXoYzCvYD8p2viS3KKyHj/hBFt
         wcyqjI7szy05BIVvNS3v/We6ogovd13qe/wxk9hu75CDKz+JirKIfBmP5ndjXygOV7va
         +YZbX/iaB9T2jczIPPe6JeURu3nUO06akDNhz6ih6Qa4XVAJJhsnAQTB5s/fcbQ+21bY
         8+TQ==
X-Gm-Message-State: ACgBeo1zaPCBe35QvHY6Z1VLM/WhLusEwaBxbzLURqbx719GIVbJvdmn
        aBtcOMXAt1Kn+76yJEZbPgtkvT2vt9o=
X-Google-Smtp-Source: AA6agR42/N65aA1Cc/PIlLC10PBIqPDTt4APaVWvm4rSXa1kDc5dVjrfaaFrKMfcdP0ZzDSc16NT2A==
X-Received: by 2002:adf:f5cc:0:b0:221:7e3f:41eb with SMTP id k12-20020adff5cc000000b002217e3f41ebmr13818146wrp.551.1660174476910;
        Wed, 10 Aug 2022 16:34:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c274200b003a54f1d007csm4059733wmw.10.2022.08.10.16.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 16:34:36 -0700 (PDT)
Message-Id: <78a93eb95bb0c43778501f03837bffdcf74e4c99.1660174473.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
References: <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
        <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Aug 2022 23:34:24 +0000
Subject: [PATCH v3 02/11] scalar-diagnose: avoid 32-bit overflow of size_t
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

