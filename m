Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCFCF1F424
	for <e@80x24.org>; Thu, 29 Mar 2018 15:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbeC2PDk (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 11:03:40 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40865 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752231AbeC2PDh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 11:03:37 -0400
Received: by mail-lf0-f65.google.com with SMTP id e5-v6so8860556lfb.7
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 08:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P+MIbVi50+iJg2jW4UON0+2mgffReuzpRKfO0qwB0So=;
        b=n1z0BNvnV8DlLidS233/vEiMTvkqhhqc+CbOM956G+0Zf82PQNSpIfhsY3p7Kggg19
         Q8czJ3MLXRk6wxU0BP5n9ulJXxsbcRuUO7+RDgy9/lYC0VM3ChVEizyAwQnNr5bae/+x
         GuivJGoUKuMwGlhKfyshVJuIqdZBwd4iMRQBmRfgH1JlR4jWVy9e1KMhPXwnF5NO2Bll
         wCZpPJf8YRcL/4QA8raFLtU3Xl70qxDWLHGgji8BCWDzkFY10guVPFGw+Hee9Cksgyzf
         hE//AVSFDm0C4H0WY4L2WuPvY8wTcM7fMLJ5aWs6OzZlfxHfv9AuH+JcA8hFBrTow3un
         UwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P+MIbVi50+iJg2jW4UON0+2mgffReuzpRKfO0qwB0So=;
        b=lnRwwbFIKKgkzNg3ZLiAk8aEQD3083YOEkCQGI85YiXOf0DIBZTxb3RU2Dc5UpILc9
         yspUVo8Eg234X6+LKXp+Xfko5i/Y46KWNL6l1vCQYLoCVYzkY+iY1eA+a6ylh57c28Vf
         9GJzVw2F3YSy0qBoBKCnVIsILGs9clagAEA2lmtTcFx7o4gkR5ufEWDpd+/wjwivSfxz
         ONkaylvmQXxtkFgD09cYhm+69EgSg6CoeUDJQm1alA3C0aCkDaQFYPP3M65qGfAnd+yD
         1Tfi5LY2W6LTkNjEcURfsadJjOVCli20l+oHw9T3R6hBwCiTpXdLRsiTJ2C2ZAyp05ME
         KxLA==
X-Gm-Message-State: AElRT7H6LRHriAlrjNGKGUkQ1930+GLH0CtGumLXW4XGyi7q4uibbcuz
        Lhp8tsz+4wfKp1UbkRmcNh0+pQ==
X-Google-Smtp-Source: AIpwx48aKp0zcmFiG/qztC+ovCW5qC+Kk/J/YIJP+Pq7xdX9vd6f9SJdiQJZIyY9CX8Mtkmf2XnDlQ==
X-Received: by 10.46.62.12 with SMTP id l12mr5504737lja.66.1522335815326;
        Thu, 29 Mar 2018 08:03:35 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x7-v6sm1186265lff.64.2018.03.29.08.03.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Mar 2018 08:03:34 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        ramsay@ramsayjones.plus.com, larsxschneider@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 2/3] Makefile: detect compiler and enable more warnings in DEVELOPER=1
Date:   Thu, 29 Mar 2018 17:03:21 +0200
Message-Id: <20180329150322.10722-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.439.gca064e2955
In-Reply-To: <20180329150322.10722-1-pclouds@gmail.com>
References: <20180324125348.6614-1-pclouds@gmail.com>
 <20180329150322.10722-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
index 7f40f76739..e6680a8977 100644
--- a/Makefile
+++ b/Makefile
@@ -431,6 +431,10 @@ all::
 #
 # When cross-compiling, define HOST_CPU as the canonical name of the CPU on
 # which the built Git will run (for instance "x86_64").
+#
+# Define DEVELOPER to enable more compiler warnings. Compiler version
+# and faimily are auto detected, but could be overridden by defining
+# COMPILER_FEATURES (see config.mak.dev)
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -439,15 +443,6 @@ GIT-VERSION-FILE: FORCE
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
@@ -1047,7 +1042,7 @@ include config.mak.uname
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
2.17.0.rc1.439.gca064e2955

