Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C468DC433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 20:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiEXUnZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 16:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiEXUnY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 16:43:24 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4A4712E6
        for <git@vger.kernel.org>; Tue, 24 May 2022 13:43:23 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p19so2839577wmg.2
        for <git@vger.kernel.org>; Tue, 24 May 2022 13:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=AvjMCpxQsEa13sCuc0GJMJHyHjexwDXsJFXB7PzuI2w=;
        b=e0e+3tiYyq2FT8kFdmfiJMVGZaMm5Ty4H5Cu+LvsILt7mooaW5HrkHSPTkceMRfyXm
         5x9A1EYe5zu7yVArXMhfq9NlkGyKZUArk2Vq0w8wozenSgagHjMTn6r7ujoInl6Zfjhn
         oB6fHhcz8neuBaiee3+0jMZtPcJ7IejqZch/GbMbHi/fAvsdj0SKFM897wmt4kmB2osd
         vPXFudUIKVhiKmQBcB8Cf6jg/62BvUyuO4HAaMEkO52+TsG7xrC6/QCUgn29PZpw5YYA
         VXMD1RDyMsixuV0FOtw8J9+xpXpcQJRM/NMsZu9ceJx/xbXUpvGDlmvYOB/ZQwSpcsdH
         wllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AvjMCpxQsEa13sCuc0GJMJHyHjexwDXsJFXB7PzuI2w=;
        b=MpNQowJiIOVGL2h0y+JQmTkO7rvidSsQNJiDo8vXDLWXbsA+7dSC9s3MGX5GlMZp5m
         RMYvCOUW/zad8bkZBOVRCOnzYBTEOFhBdFNBxdAChoPqUNsz+g68k3bMg8J1yWSHjwyF
         Z3dd/TTMyl5tlYRoQxFqvGLrpeVayihSxcS2RLo5Duq9u4OoTOVQIx2efFh1xRy0Oezb
         8rtdvADVknN+mV75Qi9wyRHhkeKc4ezhzZEwvfE0qRiyBIa5zRR2gAcr5/gK8NuL9Quk
         C0AlNz6HNrjvnaZF/G5Wy6mST5Ja52dK0VD6u7HbBuS4IGCy6DydkBHUbsb5Wc4bEtQS
         nZGA==
X-Gm-Message-State: AOAM532ch2LFRQIMck6t9IVG6u6ewZ8TLxxpFiTiKYdZOa9bkkTHdbEq
        pGHbNLjej2IccdUbrNc8NCJZ39DY988=
X-Google-Smtp-Source: ABdhPJx5dJnoJkBYAg01VRztAGM/Z/hVgGxjZl5CdyXKDr/P0DbEOzCRQcZdH2JDYh6lLHHwVQ0TdA==
X-Received: by 2002:a05:600c:1e8e:b0:397:4770:11f5 with SMTP id be14-20020a05600c1e8e00b00397477011f5mr5309015wmb.50.1653425001133;
        Tue, 24 May 2022 13:43:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j37-20020a05600c1c2500b0039746638d6esm213772wms.33.2022.05.24.13.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 13:43:20 -0700 (PDT)
Message-Id: <pull.1241.git.1653424998869.gitgitgadget@gmail.com>
From:   "Shao-Ce SUN via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 May 2022 20:43:18 +0000
Subject: [PATCH] Fix wrong info in `INSTALL`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Shao-Ce SUN <sunshaoce@iscas.ac.cn>,
        Shao-Ce SUN <sunshaoce@iscas.ac.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Shao-Ce SUN <sunshaoce@iscas.ac.cn>

The user prompt should be `$` instead of `#`.

Signed-off-by: Shao-Ce SUN <sunshaoce@iscas.ac.cn>
---
    Fix wrong info in INSTALL
    
    The user prompt should be $ instead of #.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1241%2Fsunshaoce%2Finstall-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1241/sunshaoce/install-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1241

 INSTALL | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/INSTALL b/INSTALL
index 4140a3f5c8b..7bb3f48311d 100644
--- a/INSTALL
+++ b/INSTALL
@@ -5,8 +5,8 @@ Normally you can just do "make" followed by "make install", and that
 will install the git programs in your own ~/bin/ directory.  If you want
 to do a global install, you can do
 
-	$ make prefix=/usr all doc info ;# as yourself
-	# make prefix=/usr install install-doc install-html install-info ;# as root
+	$ make prefix=/usr all doc info ; $ as yourself
+	# make prefix=/usr install install-doc install-html install-info ; # as root
 
 (or prefix=/usr/local, of course).  Just like any program suite
 that uses $prefix, the built results have some paths encoded,
@@ -20,10 +20,10 @@ config.mak file.
 Alternatively you can use autoconf generated ./configure script to
 set up install paths (via config.mak.autogen), so you can write instead
 
-	$ make configure ;# as yourself
-	$ ./configure --prefix=/usr ;# as yourself
-	$ make all doc ;# as yourself
-	# make install install-doc install-html;# as root
+	$ make configure ; $ as yourself
+	$ ./configure --prefix=/usr ; $ as yourself
+	$ make all doc ; $ as yourself
+	# make install install-doc install-html; # as root
 
 If you're willing to trade off (much) longer build time for a later
 faster git you can also do a profile feedback build with

base-commit: 7a3eb286977746bc09a5de7682df0e5a7085e17c
-- 
gitgitgadget
