Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7EC01F404
	for <e@80x24.org>; Sat, 14 Apr 2018 19:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751600AbeDNTUN (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 15:20:13 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46043 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751202AbeDNTUM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 15:20:12 -0400
Received: by mail-wr0-f193.google.com with SMTP id u11so15836038wri.12
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 12:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=WCkTokRbnjg+v7Cx4u2NvxXGjRaW1FNr+NAGkgTxrIw=;
        b=M7KM9oIpY24NeP2/UtcUwA/5xh1/0X/AnpBajmLPk9x01Lqvx47ek3LW0BfHWtc12r
         0uJlrOe8VgmMlXKy7nD9zWvbbXb6bEt8ymxWrg4OObGUcAnyv3Y4yQviYfPprRw+MRtL
         JafFhLlqxAxPMfBDUZZkVF6oWypdMTZkVNLl1NrY/nLt/D7149nbJ7FaXqed19CEA7ht
         dOp5+VFgntaL/3VvXF+iihJlkinpE6n2/Qq/N3fUTvMjzZVc/rhdMbdR8CJsI5K+15f8
         2D4J8ZPyYMQ/8gR8Ujv4CGq7cjIr90BVP8Orox3iRsSluqEsFq/0jT4NUYA3TRc8D1gU
         9YcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WCkTokRbnjg+v7Cx4u2NvxXGjRaW1FNr+NAGkgTxrIw=;
        b=WcW2cYna6ApwN6DRkh54GyGs40/4InRW4BDM0jAHhF2turI+ku5tDSvJfUpB7Hz61g
         8VLostivL4E42aGzoG+pRo7CYt6UtmMo3WPEOBwjAbmRPW7zt2lb3yr3/U1zbvzcXkSR
         qWPvMrEpEM9oxrA860SEKYWC3qLZSpvy7m9yIZHr1tE7sTZcVdVYNHuU5BX0Meu8NTzi
         QXqotuRGcIshrAWodeXQ1XkSTHTSDvc46BOXOtKUJtlOSLwGfIuTjQYZXIs94FGzn9VK
         /L8ky7It91RScfIHrqYmLo3R25GA3/pz+as0MtGHWP9fFxZYYaqSanNJaYjG6P5zkFYQ
         92/Q==
X-Gm-Message-State: ALQs6tDDyo96SLG/z5Isy4sL+7V770x/wCpjr5ny7DozC1kGzq1uyF68
        F/S7CTUnMxkvVFMfEsojvXHlGZge
X-Google-Smtp-Source: AIpwx4+ZAqGZk5cUqWnbtu5aV4lHG9vowubvBZZETIGBg7LYrv4l7P9peN/k8+E6dpsZM0KkXhh/vQ==
X-Received: by 10.28.210.198 with SMTP id j189mr2288545wmg.145.1523733610585;
        Sat, 14 Apr 2018 12:20:10 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 31sm8610644wrm.68.2018.04.14.12.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Apr 2018 12:20:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>, larsxschneider@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 2/4] Makefile: detect compiler and enable more warnings in DEVELOPER=1
Date:   Sat, 14 Apr 2018 19:19:44 +0000
Message-Id: <20180414191946.30674-3-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180414191946.30674-1-avarab@gmail.com>
References: <20180414191946.30674-1-avarab@gmail.com>
In-Reply-To: <20180329150322.10722-1-pclouds@gmail.com>
References: <20180329150322.10722-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

The set of extra warnings we enable when DEVELOPER has to be
conservative because we can't assume any compiler version the
developer may use. Detect the compiler version so we know when it's
safe to enable -Wextra and maybe more.

These warning settings are mostly from my custom config.mak a long
time ago when I tried to enable as many warnings as possible that can
still build without showing warnings. Some of those warnings are
probably worth fixing instead of just suppressing in future.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Makefile        | 15 +++++---------
 config.mak.dev  | 38 +++++++++++++++++++++++++++++++++++
 detect-compiler | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 10 deletions(-)
 create mode 100644 config.mak.dev
 create mode 100755 detect-compiler

diff --git a/Makefile b/Makefile
index f181687250..3038c78325 100644
--- a/Makefile
+++ b/Makefile
@@ -441,6 +441,10 @@ all::
 #
 # When cross-compiling, define HOST_CPU as the canonical name of the CPU on
 # which the built Git will run (for instance "x86_64").
+#
+# Define DEVELOPER to enable more compiler warnings. Compiler version
+# and family are auto detected, but could be overridden by defining
+# COMPILER_FEATURES (see config.mak.dev)
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -449,15 +453,6 @@ GIT-VERSION-FILE: FORCE
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
 CFLAGS = -g -O2 -Wall
-DEVELOPER_CFLAGS = -Werror \
-	-Wdeclaration-after-statement \
-	-Wno-format-zero-length \
-	-Wold-style-definition \
-	-Woverflow \
-	-Wpointer-arith \
-	-Wstrict-prototypes \
-	-Wunused \
-	-Wvla
 LDFLAGS =
 ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
@@ -1062,7 +1057,7 @@ include config.mak.uname
 -include config.mak
 
 ifdef DEVELOPER
-CFLAGS += $(DEVELOPER_CFLAGS)
+include config.mak.dev
 endif
 
 comma := ,
diff --git a/config.mak.dev b/config.mak.dev
new file mode 100644
index 0000000000..716a14ecc7
--- /dev/null
+++ b/config.mak.dev
@@ -0,0 +1,38 @@
+CFLAGS += -Werror
+CFLAGS += -Wdeclaration-after-statement
+CFLAGS += -Wno-format-zero-length
+CFLAGS += -Wold-style-definition
+CFLAGS += -Woverflow
+CFLAGS += -Wpointer-arith
+CFLAGS += -Wstrict-prototypes
+CFLAGS += -Wunused
+CFLAGS += -Wvla
+
+ifndef COMPILER_FEATURES
+COMPILER_FEATURES := $(shell ./detect-compiler $(CC))
+endif
+
+ifneq ($(filter clang4,$(COMPILER_FEATURES)),)
+CFLAGS += -Wtautological-constant-out-of-range-compare
+endif
+
+ifneq ($(or $(filter gcc6,$(COMPILER_FEATURES)),$(filter clang4,$(COMPILER_FEATURES))),)
+CFLAGS += -Wextra
+# if a function is public, there should be a prototype and the right
+# header file should be included. If not, it should be static.
+CFLAGS += -Wmissing-prototypes
+# These are disabled because we have these all over the place.
+CFLAGS += -Wno-empty-body
+CFLAGS += -Wno-missing-field-initializers
+CFLAGS += -Wno-sign-compare
+CFLAGS += -Wno-unused-function
+CFLAGS += -Wno-unused-parameter
+endif
+
+# uninitialized warnings on gcc 4.9.2 in xdiff/xdiffi.c and config.c
+# not worth fixing since newer compilers correctly stop complaining
+ifneq ($(filter gcc4,$(COMPILER_FEATURES)),)
+ifeq ($(filter gcc5,$(COMPILER_FEATURES)),)
+CFLAGS += -Wno-uninitialized
+endif
+endif
diff --git a/detect-compiler b/detect-compiler
new file mode 100755
index 0000000000..70b754481c
--- /dev/null
+++ b/detect-compiler
@@ -0,0 +1,53 @@
+#!/bin/sh
+#
+# Probe the compiler for vintage, version, etc. This is used for setting
+# optional make knobs under the DEVELOPER knob.
+
+CC="$*"
+
+# we get something like (this is at least true for gcc and clang)
+#
+# FreeBSD clang version 3.4.1 (tags/RELEASE...)
+get_version_line() {
+	$CC -v 2>&1 | grep ' version '
+}
+
+get_family() {
+	get_version_line | sed 's/^\(.*\) version [0-9][^ ]* .*/\1/'
+}
+
+get_version() {
+	get_version_line | sed 's/^.* version \([0-9][^ ]*\) .*/\1/'
+}
+
+print_flags() {
+	family=$1
+	version=$(get_version | cut -f 1 -d .)
+
+	# Print a feature flag not only for the current version, but also
+	# for any prior versions we encompass. This avoids needing to do
+	# numeric comparisons in make, which are awkward.
+	while test "$version" -gt 0
+	do
+		echo $family$version
+		version=$((version - 1))
+	done
+}
+
+case "$(get_family)" in
+gcc)
+	print_flags gcc
+	;;
+clang)
+	print_flags clang
+	;;
+"FreeBSD clang")
+	print_flags clang
+	;;
+"Apple LLVM")
+	print_flags clang
+	;;
+*)
+	: unknown compiler family
+	;;
+esac
-- 
2.17.0.290.gded63e768a

