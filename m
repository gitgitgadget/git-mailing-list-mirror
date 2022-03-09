Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB521C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 23:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbiCIXEX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 18:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiCIXEW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 18:04:22 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB63ED95E0
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 15:03:22 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r6so4849013wrr.2
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 15:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=X4CTYWWdy5iVycp7d4sxXVOlKFY9zfnu5srEBSA4A74=;
        b=Chewpo51IM+3vxP/+hXq1j/XTqayTe88sAXS10oaT+9zF+1jPUITFg4G0d+RWwTcP0
         dG95Ki6Gckup/mlO6ka6F/I6QNtfzThghlT9wEWwB3YPfzeMljhbySknHF8NQd+RrkW6
         dN2q9pV/l9OqV8BnuOTd7hn6juLm200ZXa9u3GGPe1N/BgInreIHipPIeuwqNiyUJkxE
         5B+WJOy+eIcZNyV5X4z+Kp8VYfKGixP5q8rMtOxNzSgQ8feDq+HcFpayl0uWueqbvrpH
         V5hSj4QChLhDDxTaBK/7BEsRPJX8AFrFHbvIo7Dsf4UJ2TFVLXhGFsYS0eehzi+D1ELq
         bbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=X4CTYWWdy5iVycp7d4sxXVOlKFY9zfnu5srEBSA4A74=;
        b=RB74/zAGbtCJF4GBhdGRYMGyXkgt/FHlf3/CNkQnEt5TwM3tgVL284YUyl0DcEX4JE
         rCM7747USLBt14JtjOVmOs1u3JEXrjPYr1DCcwOyi5io6+KicHLErHu6nGxoh4xTvwcU
         kcKZ74yPFLO4mBnIaZj/RwpbLX1z98etoMqCm3e3wLX9xTEwOmmi0VaO4sRr1EMKrArq
         8Y5mDtv0aaqQ1lpDRPnK9Nj3USHunFSjQG4mhlA8K9dsRKYpohGlhFP/wz9dfqXCGZCL
         +9RwRcDsIqZEI+hAGdc32d7tmPNzXm/o0mECueCvtn3AAYrvQ9xwBNybY+9dpxAx0CEH
         dn2g==
X-Gm-Message-State: AOAM533v6Nx8AXQxWxZoBuZtFlAR7GUGM8avQh7eHZehCWwxvetttc5Y
        JdwKvWcq0lvowUPVRrJH7mwLywquiZo=
X-Google-Smtp-Source: ABdhPJz4PPvZV9c96aOfyTkpplh+7vYmBSbb0C/ZNDqB/ZWR9jxTQWqzebFkmi0uaiqzgQtNDknn/g==
X-Received: by 2002:adf:eb4d:0:b0:1ed:c1f7:a951 with SMTP id u13-20020adfeb4d000000b001edc1f7a951mr1317148wrn.454.1646867001162;
        Wed, 09 Mar 2022 15:03:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2-20020a056000184200b002037b40de23sm2225809wri.8.2022.03.09.15.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 15:03:20 -0800 (PST)
Message-Id: <685b1db888079c83573cfd984ae64f46284544af.1646866998.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
References: <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
        <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Mar 2022 23:03:14 +0000
Subject: [PATCH v5 1/5] wrapper: move inclusion of CSPRNG headers the
 wrapper.c file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, bagasdotme@gmail.com, newren@gmail.com,
        avarab@gmail.com, nksingh85@gmail.com, ps@pks.im,
        sandals@crustytoothpaste.net,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Including NTSecAPI.h in git-compat-util.h causes build errors in any
other file that includes winternl.h. That file was included in order to
get access to the RtlGenRandom cryptographically secure PRNG. This
change scopes the inclusion of all PRNG headers to just the wrapper.c
file, which is the only place it is really needed.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 compat/winansi.c  |  5 -----
 git-compat-util.h | 12 ------------
 wrapper.c         | 14 ++++++++++++++
 3 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index 936a80a5f00..3abe8dd5a27 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -4,11 +4,6 @@
 
 #undef NOGDI
 
-/*
- * Including the appropriate header file for RtlGenRandom causes MSVC to see a
- * redefinition of types in an incompatible way when including headers below.
- */
-#undef HAVE_RTLGENRANDOM
 #include "../git-compat-util.h"
 #include <wingdi.h>
 #include <winreg.h>
diff --git a/git-compat-util.h b/git-compat-util.h
index 876907b9df4..a25ebb822ee 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -197,12 +197,6 @@
 #endif
 #include <windows.h>
 #define GIT_WINDOWS_NATIVE
-#ifdef HAVE_RTLGENRANDOM
-/* This is required to get access to RtlGenRandom. */
-#define SystemFunction036 NTAPI SystemFunction036
-#include <NTSecAPI.h>
-#undef SystemFunction036
-#endif
 #endif
 
 #include <unistd.h>
@@ -273,12 +267,6 @@
 #else
 #include <stdint.h>
 #endif
-#ifdef HAVE_ARC4RANDOM_LIBBSD
-#include <bsd/stdlib.h>
-#endif
-#ifdef HAVE_GETRANDOM
-#include <sys/random.h>
-#endif
 #ifdef NO_INTPTR_T
 /*
  * On I16LP32, ILP32 and LP64 "long" is the safe bet, however
diff --git a/wrapper.c b/wrapper.c
index 3258cdb171f..2a1aade473b 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -4,6 +4,20 @@
 #include "cache.h"
 #include "config.h"
 
+#ifdef HAVE_RTLGENRANDOM
+/* This is required to get access to RtlGenRandom. */
+#define SystemFunction036 NTAPI SystemFunction036
+#include <NTSecAPI.h>
+#undef SystemFunction036
+#endif
+
+#ifdef HAVE_ARC4RANDOM_LIBBSD
+#include <bsd/stdlib.h>
+#endif
+#ifdef HAVE_GETRANDOM
+#include <sys/random.h>
+#endif
+
 static int memory_limit_check(size_t size, int gentle)
 {
 	static size_t limit = 0;
-- 
gitgitgadget

