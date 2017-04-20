Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BA98207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 21:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033059AbdDTVZY (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 17:25:24 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33651 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031972AbdDTVZN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 17:25:13 -0400
Received: by mail-wm0-f67.google.com with SMTP id o81so989540wmb.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 14:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nQeLVU5NctuLwqO6YQjTW5TU36QnvTaK2U3rJZj2iN4=;
        b=qIWDZcVYcCQSy9tlbonuMguFkqRpfgv3hudI0mH7uRwLElCaXcnCRPI6UJRLRFhHS6
         Y+oE2FBxMn0bcUz+V2P/yNeI1PnDafagMUA3mnXMPzTZ0U0mjitAfskoKBWZs+wMVapQ
         bVP2JhA71z2YZj68qGreM+wcDtPhORnWL1IFO+Zr9MFY7dKdQvuSE/QKFU/r0yDxEeBH
         BdFuhwB0V14iozPLtIS4JoyoM5ujubLZd/KXfuPTj1Ts82ZssWpOWWVCB1Uf0MTlUqmd
         jb3H8thDgqi7eoR6UvpHiGYcbRzzH1C/zNqDwIhQAo1OC4U1Zrh86Gizo5PrV/FDZom7
         1bmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nQeLVU5NctuLwqO6YQjTW5TU36QnvTaK2U3rJZj2iN4=;
        b=Os67J/JcwDTXrLX3AcFfc35pfgJdQW354cZdcuqU/VGhjW6XYnyS7XNdMaDpSAbx3n
         KjBBQgcp3WHj+R8garIorgbgnCvD782uTkdiK9IKKr7OZjXAhCZpE9PabUSCJ7Ry6rvN
         ZU1UY0yz5kgbJ5BFHrJWg5cI0aCOQONUbD68hbluZKpCSXhMOiGA1l7sTU3iuoi4wkVX
         xxa8jlpHhtYWVah6Tu6iM1s7Otwyg4Vjell7Ey7VNDM42djt0NNC4UmkODcSnEi0smYS
         Wez+j/MQZhfUB3flHDQPKd+DYh4X6Kk2MTMxZT4UoOSXrgjgW0hboPWK+Osb0qOeg9aB
         CEng==
X-Gm-Message-State: AN3rC/5JHVJoY1wWPI2kyD8AgvEK1fxIIqVQL5Nc+5afZlT+jR9QW/sC
        Yu093Z01rMazIg==
X-Received: by 10.28.35.207 with SMTP id j198mr5044307wmj.17.1492723512294;
        Thu, 20 Apr 2017 14:25:12 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k63sm442322wmf.9.2017.04.20.14.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 14:25:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        =?UTF-8?q?Zolt=C3=A1n=20Herczeg?= <hzmester@freemail.hu>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 18/18] Makefile & configure: make PCRE v2 the default PCRE implementation
Date:   Thu, 20 Apr 2017 21:23:45 +0000
Message-Id: <20170420212345.7408-19-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170420212345.7408-1-avarab@gmail.com>
References: <20170420212345.7408-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the USE_LIBPCRE=YesPlease & --with-libpcre flags to the
Makefile & configure script, respectively, to mean use PCRE v2, not
PCRE v1. The legacy library is still available on request via
USE_LIBPCRE1=YesPlease or --with-libpcre1.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile     | 21 ++++++++++-----------
 configure.ac | 18 +++++++++---------
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/Makefile b/Makefile
index a792f206b9..42b09f9632 100644
--- a/Makefile
+++ b/Makefile
@@ -29,10 +29,10 @@ all::
 # Perl-compatible regular expressions instead of standard or extended
 # POSIX regular expressions.
 #
-# Currently USE_LIBPCRE is a synonym for USE_LIBPCRE1, define
-# USE_LIBPCRE2 instead if you'd like to use version 2 of the PCRE
-# library. The USE_LIBPCRE flag will likely be changed to mean v2 by
-# default in future releases.
+# The USE_LIBPCRE flag is a synonym for USE_LIBPCRE2, in previous
+# versions it meant the same thing USE_LIBPCRE1 does now. Define
+# USE_LIBPCRE1 instead if you'd like to use the legacy version 1 of
+# the PCRE library.
 #
 # Define LIBPCREDIR=/foo/bar if your PCRE header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.
@@ -1090,18 +1090,17 @@ ifdef NO_LIBGEN_H
 	COMPAT_OBJS += compat/basename.o
 endif
 
-USE_LIBPCRE1 ?= $(USE_LIBPCRE)
-
-ifneq (,$(USE_LIBPCRE1))
-	ifdef USE_LIBPCRE2
-$(error Only set USE_LIBPCRE1 (or its alias USE_LIBPCRE) or USE_LIBPCRE2, not both!)
-	endif
+USE_LIBPCRE2 ?= $(USE_LIBPCRE)
 
+ifdef USE_LIBPCRE1
 	BASIC_CFLAGS += -DUSE_LIBPCRE1
 	EXTLIBS += -lpcre
 endif
 
-ifdef USE_LIBPCRE2
+ifneq (,$(USE_LIBPCRE2))
+	ifdef USE_LIBPCRE1
+$(error Only set USE_LIBPCRE2 (or its alias USE_LIBPCRE) or USE_LIBPCRE1, not both!)
+	endif
 	BASIC_CFLAGS += -DUSE_LIBPCRE2
 	EXTLIBS += -lpcre2-8
 endif
diff --git a/configure.ac b/configure.ac
index 11d083fbe0..f9659daeb7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -255,25 +255,25 @@ GIT_PARSE_WITH([openssl]))
 # Perl-compatible regular expressions instead of standard or extended
 # POSIX regular expressions.
 #
-# Currently USE_LIBPCRE is a synonym for USE_LIBPCRE1, define
-# USE_LIBPCRE2 instead if you'd like to use version 2 of the PCRE
-# library. The USE_LIBPCRE flag will likely be changed to mean v2 by
-# default in future releases.
+# The USE_LIBPCRE flag is a synonym for USE_LIBPCRE2, in previous
+# versions it meant the same thing USE_LIBPCRE1 does now. Define
+# USE_LIBPCRE1 instead if you'd like to use the legacy version 1 of
+# the PCRE library.
 #
 # Define LIBPCREDIR=/foo/bar if your PCRE header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.
 #
 AC_ARG_WITH(libpcre,
-AS_HELP_STRING([--with-libpcre],[synonym for --with-libpcre1]),
+AS_HELP_STRING([--with-libpcre],[synonym for --with-libpcre2]),
     if test "$withval" = "no"; then
-	USE_LIBPCRE1=
+	USE_LIBPCRE2=
     elif test "$withval" = "yes"; then
-	USE_LIBPCRE1=YesPlease
+	USE_LIBPCRE2=YesPlease
     else
-	USE_LIBPCRE1=YesPlease
+	USE_LIBPCRE2=YesPlease
 	LIBPCREDIR=$withval
 	AC_MSG_NOTICE([Setting LIBPCREDIR to $LIBPCREDIR])
-        dnl USE_LIBPCRE1 can still be modified below, so don't substitute
+        dnl USE_LIBPCRE2 can still be modified below, so don't substitute
         dnl it yet.
 	GIT_CONF_SUBST([LIBPCREDIR])
     fi)
-- 
2.11.0

