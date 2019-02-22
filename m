Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3038B20248
	for <e@80x24.org>; Fri, 22 Feb 2019 14:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfBVOly (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 09:41:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55382 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfBVOlx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 09:41:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id q187so2184853wme.5
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 06:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZJjz7gTFzyXKrhNwSlcQXO9emcXvb3jrsFKhdH3eCWQ=;
        b=YgOIhH/SlLfedcg/AgVr4nW/5vopyDC7We667lE7aLwm+n9YhrCBSe2xPoGbdJvrYH
         XKFsFGoS29HyOTe0Iit31NNAvI016H7pBRSH+rDMHIyXeOTijJ6CqhJDeFfnNF72B/ri
         0Vd3Sq8IZtNQN563IJ9T8vmCCmbtAq1WgdsQliK3Vy2dlXZCgQiQL1wme9Bk+4NlPTou
         Zfr5oWOoXYzg3XkvJHbfmG0wMPiH6hd1iFsJuSG+EDgYixDFBX+HFnEvAfqjedpENqvb
         CtCspHTa5IPUm1sbA1CoxE/3Jt1smNXX0yL1bJ/Zwr/tqG/wXu8Elw3/E6MDzmcPCgEK
         lv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZJjz7gTFzyXKrhNwSlcQXO9emcXvb3jrsFKhdH3eCWQ=;
        b=XNItWREl9gkV9L/it2loa/S829aoT45wnuL9PX82nR/JKnJ+zs1B5Zpq9UFHmyWcIG
         3qq+4LJInwZgkXTy6OwOrNiHGHv91QN8gTgypaodpOj2o1lwPysk3p/bwDrSO7uv1Vyc
         WpjVPDSop68JIE8Aqem8jaj4uy5HfhJfOtAjDc/ccn+XjfJtooSrTUr8uhGHTEOGvvpO
         5g7VirlkHbyHF6Cn5WgITMpd9sqRCb0f3x2+46hBJ17pXTqrfInLjyHfUIFZpS9p8O/o
         E6OeIZU3XokKxN3byr8Zr/xEhp+3f3mZfUPsztYCHVakSpKQr8oTUGX0wBBLjdzqgj7+
         GaKQ==
X-Gm-Message-State: AHQUAub2w5RmpunvB3DNqXL6NIrgPRUMek0uhmV2d+ft2Dl1ATinJVNm
        69+XHKZh6E4eRYooliCIQ60jBPknIjQ=
X-Google-Smtp-Source: AHgI3Ib7SHqyzF8hgEhyPH420K22RqonoxFENtXpZJTmA9gg/lTCT1TlPZSDiEJkFtf2HYmLBX9IKQ==
X-Received: by 2002:a1c:230e:: with SMTP id j14mr2857654wmj.9.1550846509476;
        Fri, 22 Feb 2019 06:41:49 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z15sm1481689wmi.46.2019.02.22.06.41.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Feb 2019 06:41:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Lars Schneider <larsxschneider@gmail.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/6] Makefile: allow for combining DEVELOPER=1 and CFLAGS="..."
Date:   Fri, 22 Feb 2019 15:41:27 +0100
Message-Id: <20190222144127.32248-7-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b
In-Reply-To: <20190222105658.26831-1-avarab@gmail.com>
References: <20190222105658.26831-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ever since the DEVELOPER=1 facility introduced there's been no way to
have custom CFLAGS (e.g. CFLAGS="-O0 -g -ggdb3") while still
benefiting from the set of warnings and assertions DEVELOPER=1
enables.

This is because the semantics of variables in the Makefile are such
that the user setting CFLAGS overrides anything we set, including what
we're doing in config.mak.dev[1].

So let's introduce a "DEVELOPER_CFLAGS" variable in config.mak.dev and
add it to ALL_CFLAGS. Before this the ALL_CFLAGS variable
would (basically, there's some nuance we won't go into) be set to:

    $(CPPFLAGS) [$(CFLAGS) *or* $(CFLAGS) in config.mak.dev] $(BASIC_CFLAGS) $(EXTRA_CPPFLAGS)

But will now be:

    $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS) $(BASIC_CFLAGS) $(EXTRA_CPPFLAGS)

The reason for putting DEVELOPER_CFLAGS first is to allow for
selectively overriding something DEVELOPER=1 brings in. On both GCC
and Clang later settings override earlier ones. E.g. "-Wextra
-Wno-extra" will enable no "extra" warnings, but not if those two
arguments are reversed.

Examples of things that weren't possible before, but are now:

    # Use -O0 instead of -O2 for less painful debuggng
    DEVELOPER=1 CFLAGS="-O0 -g"
    # DEVELOPER=1 plus -Wextra, but disable some of the warnings
    DEVELOPER=1 DEVOPTS="no-error extra-all" CFLAGS="-O0 -g -Wno-unused-parameter"

The reason for the patches leading up to this one re-arranged the
various *FLAGS assignments and includes is just for readability. The
Makefile supports assignments out of order, e.g.:

    $ cat Makefile
    X = $(A) $(B) $(C)
    A = A
    B = B
    include c.mak
    all:
            @echo $(X)
    $ cat c.mak
    C=C
    $ make
    A B C

So we could have gotten away with the much smaller change of changing
"CFLAGS" in config.mak.dev to "DEVELOPER_CFLAGS" and adding that to
ALL_CFLAGS earlier in the Makefile "before" the config.mak.*
includes. But I think it's more readable to use variables "after"
they're included.

1. https://www.gnu.org/software/make/manual/html_node/Overriding.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile       |  8 ++++++--
 config.mak.dev | 44 ++++++++++++++++++++++----------------------
 2 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/Makefile b/Makefile
index 82cfd6c2e4..710a3475a9 100644
--- a/Makefile
+++ b/Makefile
@@ -479,7 +479,11 @@ all::
 #
 # Define DEVELOPER to enable more compiler warnings. Compiler version
 # and family are auto detected, but could be overridden by defining
-# COMPILER_FEATURES (see config.mak.dev)
+# COMPILER_FEATURES (see config.mak.dev). You can still set
+# CFLAGS="..." in combination with DEVELOPER enables, whether that's
+# for tweaking something unrelated (e.g. optimization level), or for
+# selectively overriding something DEVELOPER or one of the DEVOPTS
+# (see just below) brings in.
 #
 # When DEVELOPER is set, DEVOPTS can be used to control compiler
 # options.  This variable contains keywords separated by
@@ -1169,7 +1173,7 @@ ifdef DEVELOPER
 include config.mak.dev
 endif
 
-ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
+ALL_CFLAGS = $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
 
 comma := ,
diff --git a/config.mak.dev b/config.mak.dev
index 7354fe15b3..bf1f3fcdee 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -1,41 +1,41 @@
 ifeq ($(filter no-error,$(DEVOPTS)),)
-CFLAGS += -Werror
+DEVELOPER_CFLAGS += -Werror
 endif
 ifneq ($(filter pedantic,$(DEVOPTS)),)
-CFLAGS += -pedantic
+DEVELOPER_CFLAGS += -pedantic
 # don't warn for each N_ use
-CFLAGS += -DUSE_PARENS_AROUND_GETTEXT_N=0
-endif
-CFLAGS += -Wall
-CFLAGS += -Wdeclaration-after-statement
-CFLAGS += -Wformat-security
-CFLAGS += -Wno-format-zero-length
-CFLAGS += -Wold-style-definition
-CFLAGS += -Woverflow
-CFLAGS += -Wpointer-arith
-CFLAGS += -Wstrict-prototypes
-CFLAGS += -Wunused
-CFLAGS += -Wvla
+DEVELOPER_CFLAGS += -DUSE_PARENS_AROUND_GETTEXT_N=0
+endif
+DEVELOPER_CFLAGS += -Wall
+DEVELOPER_CFLAGS += -Wdeclaration-after-statement
+DEVELOPER_CFLAGS += -Wformat-security
+DEVELOPER_CFLAGS += -Wno-format-zero-length
+DEVELOPER_CFLAGS += -Wold-style-definition
+DEVELOPER_CFLAGS += -Woverflow
+DEVELOPER_CFLAGS += -Wpointer-arith
+DEVELOPER_CFLAGS += -Wstrict-prototypes
+DEVELOPER_CFLAGS += -Wunused
+DEVELOPER_CFLAGS += -Wvla
 
 ifndef COMPILER_FEATURES
 COMPILER_FEATURES := $(shell ./detect-compiler $(CC))
 endif
 
 ifneq ($(filter clang4,$(COMPILER_FEATURES)),)
-CFLAGS += -Wtautological-constant-out-of-range-compare
+DEVELOPER_CFLAGS += -Wtautological-constant-out-of-range-compare
 endif
 
 ifneq ($(or $(filter gcc6,$(COMPILER_FEATURES)),$(filter clang4,$(COMPILER_FEATURES))),)
-CFLAGS += -Wextra
+DEVELOPER_CFLAGS += -Wextra
 # if a function is public, there should be a prototype and the right
 # header file should be included. If not, it should be static.
-CFLAGS += -Wmissing-prototypes
+DEVELOPER_CFLAGS += -Wmissing-prototypes
 ifeq ($(filter extra-all,$(DEVOPTS)),)
 # These are disabled because we have these all over the place.
-CFLAGS += -Wno-empty-body
-CFLAGS += -Wno-missing-field-initializers
-CFLAGS += -Wno-sign-compare
-CFLAGS += -Wno-unused-parameter
+DEVELOPER_CFLAGS += -Wno-empty-body
+DEVELOPER_CFLAGS += -Wno-missing-field-initializers
+DEVELOPER_CFLAGS += -Wno-sign-compare
+DEVELOPER_CFLAGS += -Wno-unused-parameter
 endif
 endif
 
@@ -43,6 +43,6 @@ endif
 # not worth fixing since newer compilers correctly stop complaining
 ifneq ($(filter gcc4,$(COMPILER_FEATURES)),)
 ifeq ($(filter gcc5,$(COMPILER_FEATURES)),)
-CFLAGS += -Wno-uninitialized
+DEVELOPER_CFLAGS += -Wno-uninitialized
 endif
 endif
-- 
2.21.0.rc2.1.g2d5e20a900.dirty

