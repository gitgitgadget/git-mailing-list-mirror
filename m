Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F524C19F29
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 01:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbiHDBp4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 21:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238079AbiHDBpy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 21:45:54 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82062E9CC
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 18:45:53 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bv3so9647935wrb.5
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 18:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fTQyYbLVeujkIXWBZRa69qVeE19+Lc0IZap+yd+gMZw=;
        b=GXSHJAD5U/9VKnkSpAgvnU8H/wpT/fPBIn4G1iAMh8SixoAwyNtokARgiB+tPh21KZ
         muuCo81Ze0tBgtId/Gg8YLYDwg4imCRCz3nghs72U0OQ9OnlasVSqW9iajcr17ozdQjW
         ZDKo1Kc19Kfj6cJTqNu/xdcCMsEVZbq3jU/f1HMkwR4WGAK6gc1g04e0rDByro1eO37E
         3VRACmBJ55xNpefCnIsvod5m6dsd43I6qgcs3bLLvW06lbIfbXGVIIWairxO71P43z54
         jjnjjSTXU/nFjVM+FqQ9LXJKbUAp7PUmpMaaCtHckhknZTOtdos1mp7Enf5+OBvjR73e
         iS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fTQyYbLVeujkIXWBZRa69qVeE19+Lc0IZap+yd+gMZw=;
        b=5blePIgiNcB/66vsRHPbkGjtoiCjTALeg/H09HAPmTf/rNsHsMRGKtTtWyiubaxQv1
         DM47qUZrhyjIuBnQRC8CNkllGeOx16Mj19wytPD9nPvWjX6B0X0T0XzC3vjUasNPt9pE
         8db16VUPI4VFmwVt+RJMYV0OXyIWY5LzaVBFE9KohyVGDOf0tkFq0RzsxxwtElkRXNEl
         VwkPpGAJwe0LiDOvsfMhl76EMwXldbszJIeClYQuLybx00XnrgA8Jd85dDMllp2YLhwY
         8gwIPOke1L8Qw4ARnKmGypMK8/07Xa7sfBB6wWqvA83ynTybb6ZePU/ZRuTRkEezFoQi
         UpCQ==
X-Gm-Message-State: ACgBeo2E5gpHEb4tcUvLxIMgi0pZ+zTUrygk0/CXvFUYXO7wekMJDNsC
        yC9C7MVkZNVSmDdyGCTkvtydhjvJTgQ=
X-Google-Smtp-Source: AA6agR7e7DwLHP+eOLX4XhiOHXxCb+G36ZA+TWM1koLOp4HArtT28UOiFzCk2McHdTH9au1Oq2k4XQ==
X-Received: by 2002:a5d:444f:0:b0:21e:e83e:66d6 with SMTP id x15-20020a5d444f000000b0021ee83e66d6mr16894707wrr.102.1659577551970;
        Wed, 03 Aug 2022 18:45:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6-20020a5d6b06000000b0021e5adb92desm19471030wrw.60.2022.08.03.18.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 18:45:50 -0700 (PDT)
Message-Id: <7956dc24b30247ee2e401fca61897522483c5c3e.1659577543.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
        <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Aug 2022 01:45:35 +0000
Subject: [PATCH v2 02/10] scalar-diagnose: avoid 32-bit overflow of size_t
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

