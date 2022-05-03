Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799C0C433EF
	for <git@archiver.kernel.org>; Tue,  3 May 2022 10:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbiECKas (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 06:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbiECKaa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 06:30:30 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71FF26F3
        for <git@vger.kernel.org>; Tue,  3 May 2022 03:26:56 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k2so22747338wrd.5
        for <git@vger.kernel.org>; Tue, 03 May 2022 03:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=f2zNf8f8AmMY58c6kV8zXESPkKP5CdvURxartU7hBY8=;
        b=KigVSK7uT6taAQNVm5onw0Hr8CmKKrnloc7Vcm3mNexFNN1S4tgbELyxfuC7m3Tw9m
         iONp6G5Ab+xk4y/9dmFYxbpYM1TrtfcgSTRf3JQw9SzZNqA++A/WEMgaLJvBJ7hxdVQ6
         kThYWvtIpk5DY2kcafWJL9zQojRDW+zfdamrzx5tTDPvAWTyKIvUsDXzvtJPUf5LT0RD
         wUQt0vW65/NSEw3Xh4Aap8rDHTbOdHWUdqHFB71nBSYp5u+e//h8oM3BLi0+nETJWNxF
         df6txMZfxT+WMA5qsvf4hN7JUD4wPkD7EQDxsekdCUziztgEZFKZx0QArrhEIV35a4K2
         dX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=f2zNf8f8AmMY58c6kV8zXESPkKP5CdvURxartU7hBY8=;
        b=ARyTjt4ND1bNGv043RUuCwSfCQM3k2y9Hne/JK4mWmMxcI00M0zAyHjtLgQVH9OOZf
         0t4Kmme0txiLZN5UhU63lNuj9ucAeqIthh/gNuUkWaSgnJwVcLSrhc54mnPlOuyvYQQH
         1cVMWtmzbm6FJD3z8mePBOAbyIqsWtShRV+1gTNpvYwwbnCuWriKRO2FzQLS6RGEqxIn
         BtnuDcLC00YKkWVjR03jCT7pW8S9VCEjlomOYDTcLsQf9IdP6oYCY+KlLBVWTmu0Mly1
         FbEr8Iis/FE83m7zpOQoioauQH4jGcBwoUXYchlADJGh7d/3kL3wj7YhOU3fijAQxcNY
         /xKw==
X-Gm-Message-State: AOAM533x8IFPDTqTr/r34nmAyAVlkvf77hzp67CeiJPepgl8ukgtn51/
        Vlz0Vl2S2qaBBEiteU7svAGXBPnt8jM=
X-Google-Smtp-Source: ABdhPJxgdZdFttDR/JET6lNBIIwkKcjIKI+pGhs5dLuuCoJ7Cwsi9UsX+iXzGzhSmYyHECmjyuJlxA==
X-Received: by 2002:a05:6000:144f:b0:20c:6090:3040 with SMTP id v15-20020a056000144f00b0020c60903040mr7205899wrx.479.1651573614655;
        Tue, 03 May 2022 03:26:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f2-20020a7bcd02000000b003942a244f48sm1333062wmj.33.2022.05.03.03.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 03:26:53 -0700 (PDT)
Message-Id: <2ddd9ff4506475c44f68e14a4e0a9abce2806e3b.1651573607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1172.v2.git.1651573607.gitgitgadget@gmail.com>
References: <pull.1172.git.1646919331.gitgitgadget@gmail.com>
        <pull.1172.v2.git.1651573607.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 May 2022 10:26:44 +0000
Subject: [PATCH v2 3/6] trace2 docs: surround more terms in backticks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/technical/api-trace2.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 1f1a06eabc6..e8a5d7c78d0 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -35,7 +35,7 @@ Format details are given in a later section.
 === The Normal Format Target
 
 The normal format target is a traditional `printf()` format and similar
-to the GIT_TRACE format.  This format is enabled with the `GIT_TRACE2`
+to the `GIT_TRACE` format.  This format is enabled with the `GIT_TRACE2`
 environment variable or the `trace2.normalTarget` system or global
 config setting.
 
@@ -69,8 +69,8 @@ $ cat ~/log.normal
 === The Performance Format Target
 
 The performance format target (PERF) is a column-based format to
-replace GIT_TRACE_PERFORMANCE and is suitable for development and
-testing, possibly to complement tools like gprof.  This format is
+replace `GIT_TRACE_PERFORMANCE` and is suitable for development and
+testing, possibly to complement tools like `gprof`.  This format is
 enabled with the `GIT_TRACE2_PERF` environment variable or the
 `trace2.perfTarget` system or global config setting.
 
@@ -172,7 +172,7 @@ take a `va_list` argument.
 Some functions have a `_printf_fl()` suffix to indicate that they also
 take a varargs argument.
 
-There are CPP wrapper macros and ifdefs to hide most of these details.
+There are CPP wrapper macros and `#ifdef`s to hide most of these details.
 See `trace2.h` for more details.  The following discussion will only
 describe the simplified forms.
 
@@ -1214,11 +1214,11 @@ as each thread starts and allocates TLS storage.
 There are a few issues to resolve before we can completely
 switch to Trace2.
 
-* Updating existing tests that assume GIT_TRACE format messages.
+* Updating existing tests that assume `GIT_TRACE` format messages.
 
-* How to best handle custom GIT_TRACE_<key> messages?
+* How to best handle custom `GIT_TRACE_<key>` messages?
 
-** The GIT_TRACE_<key> mechanism allows each <key> to write to a
+** The `GIT_TRACE_<key>` mechanism allows each <key> to write to a
 different file (in addition to just stderr).
 
 ** Do we want to maintain that ability or simply write to the existing
-- 
gitgitgadget

