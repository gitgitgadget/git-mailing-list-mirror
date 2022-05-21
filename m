Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38295C433F5
	for <git@archiver.kernel.org>; Sat, 21 May 2022 14:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355312AbiEUOt1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 10:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355302AbiEUOtS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 10:49:18 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640C96CF47
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:16 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id bd25-20020a05600c1f1900b0039485220e16so5897086wmb.0
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OTS4ftDKHJmiahNvw0ilJLOGCudFms86VmiHL0I/Lf0=;
        b=GhHI+392RXSjwhBszZqNRBkQOco7CnnAfag7VgHc5zdL4ZDaMyq1Sft+/QW6tzkJgf
         McV8eFpEOP743vviQmJuXbCHjaeumYb3CMGuE4VD/Sw3jcY1oygjZpNXViHKo7216y6g
         vbev0pTbAwUhK8uJKi7azjbVwQ9/EqPvnkCgJoRbK386FFw1yMeiTIUOzudTPBDU763q
         9+gvYBl/FnGeeDeEPaKStX7J1Kfs3KNN1m1Q8XqJVTsiwSsXL6hZUcN85hi/1ZWb9IPF
         fCSatSt8V/TKMrWzxUjaq1bzC8IOBSUk/LeH9qEe+9ZfMYyu1kzBxagqVOK6fMMnIIzn
         H1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OTS4ftDKHJmiahNvw0ilJLOGCudFms86VmiHL0I/Lf0=;
        b=XsJzFW8s/knjL7OUtFpD1ueKwkqgnBLBAthS4NgPdtHkIl+EE7b9fHEPaYV1baegL2
         on9WhZh94j3Fup+qj84AkX+gWJPKtSmiIh/MRIAyqzu+f13B3HY1RUdfj3G25Neui8UK
         QKAG56lZP6wnUq/LpyZYKoun2nUbYchyZX4l8rFoMDLc5uoafobIxHH1dy3HxBi0b52Q
         DNtNeWFDdIwGHDLgf1zybAjjWYUzcpfnjjBQH4WqpDjxcywf9nYucDcEOGOW+2bgAdzJ
         i6PVu9FF4lQ/P5hufiTihHr37baxahOcGG2b3ZO9J6CJTCke5Lqup+JIENM4xcIOPa/X
         i4Qw==
X-Gm-Message-State: AOAM531rTe4HSsRUu4RfPAsldfU7fkTH8RTkzuQQBcZ+QE9JBzQoTWzS
        JEN7vyTK9tlei/vhsEFKUTGFHKrgIFY=
X-Google-Smtp-Source: ABdhPJzCxp8/dSpZc2dsxa6LeWUiv83SsA7liLPOkfgL2GqGiYQfyUS46JBkEpyoptxAW8TnfbPkKw==
X-Received: by 2002:a05:600c:6022:b0:394:81cb:8c9 with SMTP id az34-20020a05600c602200b0039481cb08c9mr12576637wmb.111.1653144554617;
        Sat, 21 May 2022 07:49:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c500a00b00396f8c79d22sm4140515wmr.11.2022.05.21.07.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 07:49:13 -0700 (PDT)
Message-Id: <07a92c58f8e956d0906067131c5abdd990122698.1653144546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
References: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
        <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 14:48:56 +0000
Subject: [PATCH v3 05/15] bisect--helper: really retire `--bisect-autostart`
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
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Since b0f6494f70f (bisect--helper: retire `--bisect-autostart`
subcommand, 2020-10-15), the `--bisect-autostart` option is no more. But
we kept the `enum` value of the command mode around. Let's drop it, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 658390952b2..8f4dab48379 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1280,7 +1280,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_RESET = 1,
 		BISECT_TERMS,
 		BISECT_START,
-		BISECT_AUTOSTART,
 		BISECT_NEXT,
 		BISECT_STATE,
 		BISECT_LOG,
-- 
gitgitgadget

