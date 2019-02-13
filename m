Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF9E91F453
	for <e@80x24.org>; Wed, 13 Feb 2019 10:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388076AbfBMKTw (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 05:19:52 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:46067 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbfBMKTw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 05:19:52 -0500
Received: by mail-ed1-f51.google.com with SMTP id d9so1409738edh.12
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 02:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HnHVCxn3EgBEiaZfu6PhG1GeNGDBzsK8ScoTKeaskdA=;
        b=dVvQos23S68LNJ2CIjUr3g68IevtHDTns7NiTneiQ3rCF5jiFdsWngpG+ji10XMCZh
         kfc+RokkzkpHC9GOnYvBhsZyyB9XTUL57mWsClLNEDQ/Jk9MO0SlvClrh4vP18xuJ9RN
         fguRvb1KPXGl1hdkisGiNrg9ScyPStUyvsRu314y6hgwYU++fXE0tPkKWhfWJKxCtymm
         fT5Z9lXVBi8OCih7Xx3Tg8DUkn10yECtXG4teVclUQDO27wu4eO0Zp7AKl/N++Jpsdca
         GXeDlpkiSHo68Zq3xqHM7nmybAbocd2easzw8EzSVZZ/19OjPxpb+5jtwXoLcUoO2hak
         HP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HnHVCxn3EgBEiaZfu6PhG1GeNGDBzsK8ScoTKeaskdA=;
        b=tW4SOUcgY4RRS2nzj5h8uT7Ic+bdeAesUXHYghNFUCf/ElQWeUV3xoqUwPLJmrEtBK
         t99LMCYfKQxCtdyj4A3lh1qI3ZlFhcjGLIJJYybBOjyPvELKprHuJtaW5O2w5pE5k8c1
         Y6dmKFpPlyPqTu/M5eUZ3Y3crKZOJKwJW6dMvDQiZeKICkMROgdLwLPIz1g6AI/D5qFk
         B8IttmqULxSeK6x1tBSryVc2ZAZRBLeMK4uWav/12PRCTCGiiMTcEUu6K5R2p6OO05oX
         Werfe6ZLUl6hh3pHaCJLXVjipY9qQISSBpxjyREo+nibzAqAXOMNBS2gat7028U8oNHp
         DqfA==
X-Gm-Message-State: AHQUAubNpwOJY1eqp8RQSjlcn4hLxHj6DdhPjbspBsnZ+eGejg9XRiYG
        AFVdjLqpxDH129BC3dAlCqHyEaoJ
X-Google-Smtp-Source: AHgI3IbAQH+Mav+xI/pUcWqcDVC5dZhis/KzMaMCJD2Wxa3p9Q+WelTX+IeCrMYLgIQi7pfnH20f8Q==
X-Received: by 2002:a50:ca86:: with SMTP id x6mr6606265edh.287.1550053189898;
        Wed, 13 Feb 2019 02:19:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q50sm4672323edd.66.2019.02.13.02.19.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 02:19:49 -0800 (PST)
Date:   Wed, 13 Feb 2019 02:19:49 -0800 (PST)
X-Google-Original-Date: Wed, 13 Feb 2019 10:19:47 GMT
Message-Id: <68df753d12b712ec33943a310f0bc80f4ec78d9a.1550053187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.125.git.gitgitgadget@gmail.com>
References: <pull.125.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] mingw: use a more canonical method to fix the CPU
 reporting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In `git version --build-options`, we report also the CPU, but in Git for
Windows we actually cross-compile the 32-bit version in a 64-bit Git for
Windows, so we cannot rely on the auto-detected value.

In 3815f64b0dd9 (mingw: fix CPU reporting in `git version
--build-options`, 2019-02-07), we fixed this by a Windows-only
workaround, making use of magic pre-processor constants, which works in
GCC, but most likely not all C compilers.

As pointed out by Eric Sunshine, there is a better way, anyway: to set
the Makefile variable HOST_CPU explicitly for cross-compiled Git. So
let's do that!

This reverts commit 3815f64b0dd983bdbf9242a0547706d5d81cb3e6 partially.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.h   | 19 -------------------
 config.mak.uname |  2 ++
 2 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 363f047df0..8c24ddaa3e 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -6,25 +6,6 @@ typedef _sigset_t sigset_t;
 #include <winsock2.h>
 #include <ws2tcpip.h>
 
-#ifdef __MINGW64_VERSION_MAJOR
-/*
- * In Git for Windows, we cannot rely on `uname -m` to report the correct
- * architecture: /usr/bin/uname.exe will report the architecture with which the
- * current MSYS2 runtime was built, not the architecture for which we are
- * currently compiling (both 32-bit and 64-bit `git.exe` is built in the 64-bit
- * Git for Windows SDK).
- */
-#undef GIT_HOST_CPU
-/* This was figured out by looking at `cpp -dM </dev/null`'s output */
-#if defined(__x86_64__)
-#define GIT_HOST_CPU "x86_64"
-#elif defined(__i686__)
-#define GIT_HOST_CPU "i686"
-#else
-#error "Unknown architecture"
-#endif
-#endif
-
 /* MinGW-w64 reports to have flockfile, but it does not actually have it. */
 #ifdef __MINGW64_VERSION_MAJOR
 #undef _POSIX_THREAD_SAFE_FUNCTIONS
diff --git a/config.mak.uname b/config.mak.uname
index 3ee7da0e23..194f20a8b3 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -553,9 +553,11 @@ else
 		prefix = /usr/
 		ifeq (MINGW32,$(MSYSTEM))
 			prefix = /mingw32
+			HOST_CPU = i686
 		endif
 		ifeq (MINGW64,$(MSYSTEM))
 			prefix = /mingw64
+			HOST_CPU = x86_64
 		else
 			COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
 			BASIC_LDFLAGS += -Wl,--large-address-aware
-- 
gitgitgadget
