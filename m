Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AABB1F404
	for <e@80x24.org>; Sat, 24 Mar 2018 12:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeCXMyE (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 08:54:04 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:41070 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbeCXMyD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 08:54:03 -0400
Received: by mail-lf0-f47.google.com with SMTP id o102-v6so21994803lfg.8
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 05:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4TsV/BnYgM5hz/dJBt89JWzewBODSExsF+ZA4dav9xI=;
        b=XYOCJfI4EyhLt1mb+OzOX/iy6cf7kl9EFpsvAO+GvVce/b1uIVDpOUAecqNF6YYAh8
         hbltRqlXT6kmg5snMHKBRV1MGOF+vsq2Zdilj564dgzllsec6bf+1JNR28uS1YjTRKqF
         hSTee7wQ4kieMF0xeoqQXkTWZdcvW7ivrTLPF98flcIxAueTVRZ4fHw4Dpaj6OXWvv7y
         VZ9TciEZ8pkkH8rW/5QWMba2DEMi1XYCdiVmbhKZ/xzPJjlMF/toi7hFx6pYDfGyHj7v
         FrK+1hlGdU8AdjvjBLM4in0fQ952q4qKvgGp5KHXzgZSTn8Dv4aorq1eUC+RC+k/UQpC
         OI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4TsV/BnYgM5hz/dJBt89JWzewBODSExsF+ZA4dav9xI=;
        b=ZuAWtp3UBajYLahky7qNZtH79vbGJC+l30kTa+I77wEFdxo2JNEda8OP1cE0+SlLo6
         ixm1IkjmDxCLPaXREkwg0mypUZMKdBJJqBQwsxfr6SAgSamHCnUqVHkCqjcYiQ4yxL+l
         Cr8KNf677f8Pqw8v3ouFw9OflubSmi15wWmCjTSUe5JYUeoeR8ievF/Uh4hyi4o6Orea
         9tmDtCmBbFoZPZBHr00ECatpYAiLnBiTOArrhtJ3Vi4LqIwLjltewR7puWHmwkc63Fhl
         v1uAUHlblakXV7sMwbiEqRPZUhMVdZ1lM/QmrNXxH3omQWoHAW81umbrjsO2TdfS+Whf
         bGiQ==
X-Gm-Message-State: AElRT7GsXsExkdqy7BexvkgiTCYIKOm79WoJV9qsW+NI1wog5lcHrSxt
        DngvIvL33E4Be2zdSZN1tF2Dfw==
X-Google-Smtp-Source: AG47ELt8wcKwZ9zIxCh+FHeVBQsQUyGpkLpl/iz7SUW89vaRPV0TqmR4OTk12sI8Xd6M55gTVdjP2g==
X-Received: by 2002:a19:6919:: with SMTP id e25-v6mr21616064lfc.52.1521896041294;
        Sat, 24 Mar 2018 05:54:01 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id m23sm2472676ljg.21.2018.03.24.05.54.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 05:54:00 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        larsxschneider@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2] Makefile: detect compiler and enable more warnings in DEVELOPER=1
Date:   Sat, 24 Mar 2018 13:53:48 +0100
Message-Id: <20180324125348.6614-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180318081834.16081-1-pclouds@gmail.com>
References: <20180318081834.16081-1-pclouds@gmail.com>
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
still build without showing warnings. Some of them those warnings are
probably worth fixing instead of just suppressing in future.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 v2 improves a bit over v1:

 - apple clang support (though I suspect we may want to make it a
   separate compiler family since apple clang has different
   versioning, but I can't and won't work on that front)

 - support CC='ccache gcc' (yes it breaks now if you have spaces in
   your cc path)

 - allow to skip detect-compiler by setting COMPILER_FEATURES in
   config.mak

 I notice Ramsay is working on clean -Wmaybe-uninitialized, if his
 series is merged first I'll stop disabling it here.

 Interdiff

    diff --git a/Makefile b/Makefile
    index 9dfd152a1e..04b2a39bab 100644
    --- a/Makefile
    +++ b/Makefile
    @@ -434,6 +434,10 @@ all::
     #
     # When cross-compiling, define HOST_CPU as the canonical name of the CPU on
     # which the built Git will run (for instance "x86_64").
    +#
    +# Define DEVELOPER to enable more compiler warnings. Compiler version
    +# and faimily are auto detected, but could be overridden by defining
    +# COMPILER_FEATURES (see config.mak.dev)
     
     GIT-VERSION-FILE: FORCE
     	@$(SHELL_PATH) ./GIT-VERSION-GEN
    diff --git a/config.mak.dev b/config.mak.dev
    index 59aef342c4..d8beaf9347 100644
    --- a/config.mak.dev
    +++ b/config.mak.dev
    @@ -8,7 +8,9 @@ CFLAGS += -Wstrict-prototypes
     CFLAGS += -Wunused
     CFLAGS += -Wvla
     
    +ifndef COMPILER_FEATURES
     COMPILER_FEATURES := $(shell ./detect-compiler $(CC))
    +endif
     
     ifneq ($(filter clang4,$(COMPILER_FEATURES)),)
     CFLAGS += -Wtautological-constant-out-of-range-compare
    diff --git a/detect-compiler b/detect-compiler
    index bc2ea39ef5..70b754481c 100755
    --- a/detect-compiler
    +++ b/detect-compiler
    @@ -9,7 +9,7 @@ CC="$*"
     #
     # FreeBSD clang version 3.4.1 (tags/RELEASE...)
     get_version_line() {
    -	"$CC" -v 2>&1 | grep ' version '
    +	$CC -v 2>&1 | grep ' version '
     }
     
     get_family() {
    @@ -38,12 +38,15 @@ case "$(get_family)" in
     gcc)
     	print_flags gcc
     	;;
    -*clang)
    +clang)
     	print_flags clang
     	;;
     "FreeBSD clang")
     	print_flags clang
     	;;
    +"Apple LLVM")
    +	print_flags clang
    +	;;
     *)
     	: unknown compiler family
     	;;

 Makefile        | 15 +++++---------
 config.mak.dev  | 30 ++++++++++++++++++++++++++++
 detect-compiler | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 10 deletions(-)
 create mode 100644 config.mak.dev
 create mode 100755 detect-compiler

diff --git a/Makefile b/Makefile
index a1d8775adb..04b2a39bab 100644
--- a/Makefile
+++ b/Makefile
@@ -434,6 +434,10 @@ all::
 #
 # When cross-compiling, define HOST_CPU as the canonical name of the CPU on
 # which the built Git will run (for instance "x86_64").
+#
+# Define DEVELOPER to enable more compiler warnings. Compiler version
+# and faimily are auto detected, but could be overridden by defining
+# COMPILER_FEATURES (see config.mak.dev)
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -442,15 +446,6 @@ GIT-VERSION-FILE: FORCE
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
@@ -1051,7 +1046,7 @@ include config.mak.uname
 -include config.mak
 
 ifdef DEVELOPER
-CFLAGS += $(DEVELOPER_CFLAGS)
+include config.mak.dev
 endif
 
 comma := ,
diff --git a/config.mak.dev b/config.mak.dev
new file mode 100644
index 0000000000..d8beaf9347
--- /dev/null
+++ b/config.mak.dev
@@ -0,0 +1,30 @@
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
+CFLAGS += -Wmissing-prototypes
+CFLAGS += -Wno-empty-body
+CFLAGS += -Wno-missing-field-initializers
+CFLAGS += -Wno-sign-compare
+CFLAGS += -Wno-unused-function
+CFLAGS += -Wno-unused-parameter
+ifneq ($(filter gcc6,$(COMPILER_FEATURES)),)
+CFLAGS += -Wno-maybe-uninitialized
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
2.17.0.rc0.348.gd5a49e0b6f

