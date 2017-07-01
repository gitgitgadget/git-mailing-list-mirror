Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F8B120209
	for <e@80x24.org>; Sat,  1 Jul 2017 22:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751783AbdGAWGE (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 18:06:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33706 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751659AbdGAWGB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 18:06:01 -0400
Received: by mail-wm0-f66.google.com with SMTP id j85so13859664wmj.0
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 15:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=y+Yd8vj9xvfVR77z5qYeGBCLxIz+VIl9TJtKaozaPcQ=;
        b=qmMjXsuPn546pPHsnNZNi7RlJDf3+wWpvYmhGIjIwy6nqVY1qeStaGpIpJWYE4L11f
         RqEl104m3erm5FYha5GI8yEX4q9GwAcNMT0CCDA7MgWM4xJPfJOGhKg/73hfnI2aqURw
         PBUvMRCizp0ftlf+Nj6MZhhCzyeZab9/m20DP7+/cTNg/4spowtgDRkvvB0JlQx5C+az
         XJaq6v6b1Hf4IE/AAU58AhJXgEEw98tyBTQU55ylA5KtD1s2yuvG5eb6Z0tLx+Xt2ufP
         d5AlNYe+cZo4DEfjbnFVwCkW9RS4AodywlqNWO7PSYMlVoAgBh7QUqI8PPoZTaWFJAYi
         Pjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=y+Yd8vj9xvfVR77z5qYeGBCLxIz+VIl9TJtKaozaPcQ=;
        b=erL/gqOsKixdYLNNaU8t7voUp4pCkcP3O6jpfWTIb1a2wvUtQ9HHt130gIZGnjAUNi
         VIv+5XXAUuw2qSsGGZ+mVRP3oFXLmFxQ56+6Ag4V4edPosAoLPZuRLm1fMmduKtGkodE
         TzFpu+RX4wVRMMSOPzYcNofTyUjKmczFPfLrsZQoSZKQebnJgMGLX/2qlpVuKP8h+f3h
         FWtk6grzUljpRJ+I0ZHaKi0qLkWmgZIVJ/tF4vyeQUWkt6sOUSzEGeq0LZ6fns7yzyoS
         HGUe7+nQWo6J72GD+IC4l7/0OzX5YRgVID/hgeD8lM8Neu9mAcleamGLkyPD6Z7HEWed
         aXsw==
X-Gm-Message-State: AKS2vOxLgY9Tn1Qu4KNHldO9h1Gj03Ttyus/ZTH1l/TLyhgMxcQ32N3U
        STlcD1fKJt1QbgjszSs=
X-Received: by 10.80.132.225 with SMTP id 88mr9610753edq.80.1498946759981;
        Sat, 01 Jul 2017 15:05:59 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e54sm4208643eda.27.2017.07.01.15.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jul 2017 15:05:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/3] sha1dc: update from upstream
Date:   Sat,  1 Jul 2017 22:05:45 +0000
Message-Id: <20170701220547.10464-2-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170701220547.10464-1-avarab@gmail.com>
References: <20170701220547.10464-1-avarab@gmail.com>
In-Reply-To: <20170627121718.12078-1-avarab@gmail.com>
References: <20170627121718.12078-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update sha1dc from the latest version by the upstream maintainer[1].

See commit 6b851e536b ("sha1dc: update from upstream", 2017-06-06) for
the last update.

This solves the Big Endian detection on Solaris reported against
v2.13.2[2], hopefully without any regressions. A version of this has
been tested on two Solaris SPARC installations, Cygwin (by jturney on
cygwin@Freenode), and on numerous more boring systems (mainly
linux/x86_64). See [3] for a discussion of the implementation and
platform-specific issues.

See commit a0103914c2 ("sha1dc: update from upstream", 2017-05-20) and
6b851e536b ("sha1dc: update from upstream", 2017-06-06) for previous
attempts in the 2.13 series to address various compile-time feature
detection in this library.

1. https://github.com/cr-marcstevens/sha1collisiondetection/commit/19d97bf5af05312267c2e874ee6bcf584d9e9681
2. <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
   (https://public-inbox.org/git/CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com/)
3. https://github.com/cr-marcstevens/sha1collisiondetection/pull/34

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sha1dc/sha1.c | 90 ++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 67 insertions(+), 23 deletions(-)

diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index 3a1735e5ca..d5948826c8 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -10,6 +10,9 @@
 #include <memory.h>
 #include <stdio.h>
 #include <stdlib.h>
+#ifdef __unix__
+#include <sys/types.h> /* make sure macros like _BIG_ENDIAN visible */
+#endif
 #endif
 
 #ifdef SHA1DC_CUSTOM_INCLUDE_SHA1_C
@@ -23,6 +26,13 @@
 #include "sha1.h"
 #include "ubc_check.h"
 
+#if (defined(__amd64__) || defined(__amd64) || defined(__x86_64__) || defined(__x86_64) || \
+     defined(i386) || defined(__i386) || defined(__i386__) || defined(__i486__)  || \
+     defined(__i586__) || defined(__i686__) || defined(_M_IX86) || defined(__X86__) || \
+     defined(_X86_) || defined(__THW_INTEL__) || defined(__I86__) || defined(__INTEL__) || \
+     defined(__386) || defined(_M_X64) || defined(_M_AMD64))
+#define SHA1DC_ON_INTEL_LIKE_PROCESSOR
+#endif
 
 /*
    Because Little-Endian architectures are most common,
@@ -32,29 +42,70 @@
    If you are compiling on a big endian platform and your compiler does not define one of these,
    you will have to add whatever macros your tool chain defines to indicate Big-Endianness.
  */
-#ifdef SHA1DC_BIGENDIAN
-#undef SHA1DC_BIGENDIAN
-#endif
 
-#if (defined(_BYTE_ORDER) || defined(__BYTE_ORDER) || defined(__BYTE_ORDER__))
-
-#if ((defined(_BYTE_ORDER) && (_BYTE_ORDER == _BIG_ENDIAN)) || \
-     (defined(__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || \
-     (defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __BIG_ENDIAN__)) )
+#if defined(__BYTE_ORDER__) && defined(__ORDER_BIG_ENDIAN__)
+/*
+ * Should detect Big Endian under GCC since at least 4.6.0 (gcc svn
+ * rev #165881). See
+ * https://gcc.gnu.org/onlinedocs/cpp/Common-Predefined-Macros.html
+ *
+ * This also works under clang since 3.2, it copied the GCC-ism. See
+ * clang.git's 3b198a97d2 ("Preprocessor: add __BYTE_ORDER__
+ * predefined macro", 2012-07-27)
+ */
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 #define SHA1DC_BIGENDIAN
 #endif
 
-#else
-
-#if (defined(_BIG_ENDIAN) || defined(__BIG_ENDIAN) || defined(__BIG_ENDIAN__) || \
-     defined(__ARMEB__) || defined(__THUMBEB__) || defined(__AARCH64EB__) || \
-     defined(__MIPSEB__) || defined(__MIPSEB) || defined(_MIPSEB) || \
-     defined(__sparc))
+/* Not under GCC-alike */
+#elif defined(__BYTE_ORDER) && defined(__BIG_ENDIAN)
+/*
+ * Should detect Big Endian under glibc.git since 14245eb70e ("entered
+ * into RCS", 1992-11-25). Defined in <endian.h> which will have been
+ * brought in by standard headers. See glibc.git and
+ * https://sourceforge.net/p/predef/wiki/Endianness/
+ */
+#if __BYTE_ORDER == __BIG_ENDIAN
 #define SHA1DC_BIGENDIAN
 #endif
 
+/* Not under GCC-alike or glibc */
+#elif defined(_BYTE_ORDER) && defined(_BIG_ENDIAN) && defined(_LITTLE_ENDIAN)
+/*
+ * *BSD and newlib (embeded linux, cygwin, etc).
+ * the defined(_BIG_ENDIAN) && defined(_LITTLE_ENDIAN) part prevents
+ * this condition from matching with Solaris/sparc.
+ * (Solaris defines only one endian macro)
+ */
+#if _BYTE_ORDER == _BIG_ENDIAN
+#define SHA1DC_BIGENDIAN
 #endif
 
+/* Not under GCC-alike or glibc or *BSD or newlib */
+#elif (defined(__ARMEB__) || defined(__THUMBEB__) || defined(__AARCH64EB__) || \
+       defined(__MIPSEB__) || defined(__MIPSEB) || defined(_MIPSEB) || \
+       defined(__sparc))
+/*
+ * Should define Big Endian for a whitelist of known processors. See
+ * https://sourceforge.net/p/predef/wiki/Endianness/ and
+ * http://www.oracle.com/technetwork/server-storage/solaris/portingtosolaris-138514.html
+ */
+#define SHA1DC_BIGENDIAN
+
+/* Not under GCC-alike or glibc or *BSD or newlib or <processor whitelist> */
+#elif defined(SHA1DC_ON_INTEL_LIKE_PROCESSOR)
+/*
+ * As a last resort before we do anything else we're not 100% sure
+ * about below, we blacklist specific processors here. We could add
+ * more, see e.g. https://wiki.debian.org/ArchitectureSpecificsMemo
+ */
+#else /* Not under GCC-alike or glibc or *BSD or newlib or <processor whitelist>  or <processor blacklist> */
+
+/* We do nothing more here for now */
+/*#error "Uncomment this to see if you fall through all the detection"*/
+
+#endif /* Big Endian detection */
+
 #if (defined(SHA1DC_FORCE_LITTLEENDIAN) && defined(SHA1DC_BIGENDIAN))
 #undef SHA1DC_BIGENDIAN
 #endif
@@ -63,15 +114,8 @@
 #endif
 /*ENDIANNESS SELECTION*/
 
-#if (defined SHA1DC_FORCE_UNALIGNED_ACCESS || \
-     defined(__amd64__) || defined(__amd64) || defined(__x86_64__) || defined(__x86_64) || \
-     defined(i386) || defined(__i386) || defined(__i386__) || defined(__i486__)  || \
-     defined(__i586__) || defined(__i686__) || defined(_M_IX86) || defined(__X86__) || \
-     defined(_X86_) || defined(__THW_INTEL__) || defined(__I86__) || defined(__INTEL__) || \
-     defined(__386) || defined(_M_X64) || defined(_M_AMD64))
-
+#if defined(SHA1DC_FORCE_UNALIGNED_ACCESS) || defined(SHA1DC_ON_INTEL_LIKE_PROCESSOR)
 #define SHA1DC_ALLOW_UNALIGNED_ACCESS
-
 #endif /*UNALIGNMENT DETECTION*/
 
 
@@ -918,7 +962,7 @@ static void sha1recompress_fast_ ## t (uint32_t ihvin[5], uint32_t ihvout[5], co
 
 #ifdef _MSC_VER
 #pragma warning(push)
-#pragma warning(disable: 4127)  /* Compiler complains about the checks in the above macro being constant. */
+#pragma warning(disable: 4127)  /* Complier complains about the checks in the above macro being constant. */
 #endif
 
 #ifdef DOSTORESTATE0
-- 
2.13.1.611.g7e3b11ae1

