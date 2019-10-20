Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4379B1F4C0
	for <e@80x24.org>; Sun, 20 Oct 2019 20:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfJTUjf (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Oct 2019 16:39:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43292 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfJTUje (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Oct 2019 16:39:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so6287875wrr.10
        for <git@vger.kernel.org>; Sun, 20 Oct 2019 13:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I6SlOdXpn7EjazwJaaM9VEbPIripxYipJI5nDijyPQc=;
        b=nvt7ARhpOFzbOy1BJV0CATfwp/iTBrljxfcStG+k/DITuH12ojEP1j3/FYRajjNpir
         0U21HiVtMBqVe/8hkTb2JHBVaWeuxitaWX+3mCpE1Pa9EqzIgKFlf5kStZlXiUzYjkYB
         AGtlUw/jP/SX505mzlvNsXt0/orShkDqmJkQHU8oH4GwRAVHUtp6q5+xs+FDHDxS/e6f
         ghdMk1DhrJHhs38ZR1T3YlYR6SpYOjQMgzeM8Nowd90JaAgeCdpiitWzvB4GwwTO2Tkk
         QAGlKs6RAO9NQW84UMyYqkAerwILD++TwHCTGAYFW3Xq0PaKvUx3Cc20sASufp+64Pod
         7uMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I6SlOdXpn7EjazwJaaM9VEbPIripxYipJI5nDijyPQc=;
        b=hxrglwrTLmy3ZprFd7D2fSgnWnVrYe/L0HoVs6ByrDiMk4fYpnSrBsmanlIgPSFrnV
         eXDWRtnfId5EcjNlAygP2txpqZogdmyQyVw1aqSUv3ZV4fbZHydjCflsGC72NWy08EpU
         DI05D61p0LyDa8PjdweFXkdLx7ta8eI9bK9wUQktQZot/md0uSnVCIX5+JnicCr86KOi
         g/7JnEkZ7DeoI//vVaTt/ApOvMqZHHD/yZVEJfGmzdlsVv2ClhfspMpUGp0CK6KdTgqP
         lXyTfEf/8N9ex6vWVDCmkFWMM2eTKbmzll77vi4/ZsyUb4LgcuUMvSRnY7HiuGIOKBNM
         HQcQ==
X-Gm-Message-State: APjAAAUDmKS6ev91jDXTD5cb3XBiYVoWlIQ/cCGWdS4VJwlgn8kgS53l
        8F4+e3JR8kDl3JI+9BSzmvxFMtT0
X-Google-Smtp-Source: APXvYqwnrqds6HinAM2GXcNzuvUrfqC2Euzm0pzK3UANwdcWLNP5kHgEFOCM3gO/E2jgUyZpss41lg==
X-Received: by 2002:a5d:6992:: with SMTP id g18mr17667844wru.237.1571603972640;
        Sun, 20 Oct 2019 13:39:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d2sm4470246wmd.2.2019.10.20.13.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Oct 2019 13:39:32 -0700 (PDT)
Message-Id: <6fba3b1c76d6e28c1ef4fd6c933bd73531e6cb7e.1571603970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.410.git.1571603970.gitgitgadget@gmail.com>
References: <pull.410.git.1571603970.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Oct 2019 20:39:29 +0000
Subject: [PATCH 1/2] ci(visual-studio): use strict compile flags, and
 optimization
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To make full use of the work that went into the Visual Studio build &
test jobs in our CI/PR builds, let's turn on strict compiler flags. This
will give us the benefit of Visual C's compiler warnings (which, at
times, seem to catch things that GCC does not catch, and vice versa).

While at it, also turn on optimization; It does not make sense to
produce binaries with debug information, and we can use any ounce of
speed that we get (because the test suite is particularly slow on
Windows, thanks to the need to run inside a Unix shell, which
requires us to use the POSIX emulation layer provided by MSYS2).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 azure-pipelines.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/azure-pipelines.yml b/azure-pipelines.yml
index 9f099b9529..457c6fee31 100644
--- a/azure-pipelines.yml
+++ b/azure-pipelines.yml
@@ -157,7 +157,7 @@ jobs:
     displayName: 'Download git-sdk-64-minimal'
   - powershell: |
       & git-sdk-64-minimal\usr\bin\bash.exe -lc @"
-        make vcxproj
+        make NDEBUG=1 DEVELOPER=1 vcxproj
       "@
       if (!$?) { exit(1) }
     displayName: Generate Visual Studio Solution
-- 
gitgitgadget

