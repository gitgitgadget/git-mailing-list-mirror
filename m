Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 021A61F404
	for <e@80x24.org>; Sat, 31 Mar 2018 16:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752460AbeCaQkY (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 12:40:24 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53880 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752321AbeCaQkX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 12:40:23 -0400
Received: by mail-wm0-f67.google.com with SMTP id p9so19426303wmc.3
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 09:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9MixjjCAah6j+FuDnjP0l4yxVEVOVU6Q+Lw10sgyHKY=;
        b=LPQa9DSXNGlqJAGZogCtpTsm2YiF6SEg6FKPsJ8xmvJGzyv7mvi6Ea0E9p2Y10g+y7
         4UU3SPgIPXs9IDvRz/Axu6QoKeEgE8t36y+Fr+nIw8s9b5gnF+sDFN/oxjeaoMS0BS6k
         PEd7tQGUbHsGYdnJPc3Lh0EtjYOmC1UKwqprrzmlRcEKVVbZHCKnaihe7D4Rn6fWmJda
         RM6qOUJnJLIXoQ+8DSRpxKKnXcZghEoYWxsPYSZbUw6eiXh4GToUcf1/tpKGL3l+BIgq
         5Hl0paKV1DULlYIZ7oAy4ZQkysiRwPfyf4bgCZCbFLQyuBD3PN4pY4J+8GIAl6l/6ybV
         PNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9MixjjCAah6j+FuDnjP0l4yxVEVOVU6Q+Lw10sgyHKY=;
        b=K6eSPCTRgpQrL/Lffm4KApjNezfhMJndhL1RMaOADOskYQx5Fyb0LuvWEKL+iDlGEL
         8XnGQGkgMcEFu1Nu57NUI3GMWl8yvEpjFMHpqTsSKKSw7SrPHcpYQ5aKYTHqBB6aonBy
         1jUzOGLUUuq4QiOf6Yriw6OHyqxG8hvVnCXbnKu0I1ADyeXUesn/KKFftR6iA495Kabs
         frRkAkdG1wHZ4RBGvEAjkyCITfOfVMAByhrbcRp+2z0ER/dN/Rczloe86+HDbTsjNA9I
         jrM9rmgNR5RPWNH8Ke3deupBOgtNLvUFzXKzDih/bxAnBFCFICpsle9XugiMnj6sYF2X
         LV7A==
X-Gm-Message-State: AElRT7FRqKoaVmLvcFrUwUKzK7CsjaYsBiIl6T/e6q3VkiigdD5gMA1A
        FmIRudGfJvpk+xtSApDF0Dr4M8ft
X-Google-Smtp-Source: AIpwx49hGh7PkRY2G/PZK4oDn3elo012qpYs41ZJ3p9IyjB/unYUccGCxkdgpdubxtneS6S/Vv741A==
X-Received: by 10.28.236.145 with SMTP id h17mr4742061wmi.43.1522514421543;
        Sat, 31 Mar 2018 09:40:21 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p15sm9461920wmd.7.2018.03.31.09.40.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Mar 2018 09:40:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, ramsay@ramsayjones.plus.com,
        larsxschneider@gmail.com, ric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/3] Makefile: untangle DEVELOPER and -Werror
Date:   Sat, 31 Mar 2018 16:40:09 +0000
Message-Id: <20180331164009.2264-1-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565
In-Reply-To: <20180329150322.10722-1-pclouds@gmail.com>
References: <20180329150322.10722-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the DEVELOPER flag, and the newly added EAGER_DEVELOPER flag
which (approximately) enables -Wextra so that any combination of them
and -Werror can be set.

I've long wanted to use DEVELOPER=1 in my production builds, but on
some old systems I still get warnings, and thus the build would
fail. However if the build/tests fail for some other reason, it would
still be useful to scroll up and see what the relevant code is warning
about.

This change allows for that. Now setting DEVELOPER will set -Werror as
before, but if DEVELOPER_NONFATAL is set you'll get the same warnings,
but without -Werror.

I've renamed the newly added EAGER_DEVELOPER flag to
DEVELOPER_EXTRA. The reason is that it approximately turns on -Wextra,
and it'll be more consistent to add e.g. DEVELOPER_PEDANTIC later than
inventing some new name of our own (VERY_EAGER_DEVELOPER?).

The DEVELOPER_EXTRA flag implicitly means DEVELOPER_NONFATAL, but just
so that this change doesn't introduce yet another arbitrary limitation
it's possible to combine it with DEVELOPER_FATAL, which will turn on
-Werror for it as well.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

I really like where this is going, but as noted I think this on top
would be even better.

 Makefile       | 17 +++++++++++------
 config.mak.dev | 10 ++++++++--
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index e4f04ce1cb..641461a569 100644
--- a/Makefile
+++ b/Makefile
@@ -432,11 +432,16 @@ all::
 # When cross-compiling, define HOST_CPU as the canonical name of the CPU on
 # which the built Git will run (for instance "x86_64").
 #
-# Define DEVELOPER to enable more compiler warnings. Compiler version
-# and faimily are auto detected, but could be overridden by defining
-# COMPILER_FEATURES (see config.mak.dev).
-# Define EAGER_DEVELOPER keeps compiler warnings non-fatal, but no warning
-# class is suppressed anymore.
+# Define DEVELOPER to enable more compiler warnings. We'll also enable
+# -Werror unless DEVELOPER_NONFATAL is defined. To enable even more
+# pedantic warnings that'll flag some potential existing issues in the
+# codebase turn on DEVELOPER_EXTRA, which implicitly sets DEVELOPER as
+# well, This is -Wextra with a whitelist of disabled warnings. Unless
+# DEVELOPER_NONFATAL is set DEVELOPER_EXTRA will turn it on
+# implicitly, so if you for some reason want both DEVELOPER and
+# DEVELOPER_EXTRA with fatal warnings, you need to set
+# DEVELOPER_FATAL=1 to force -Werror. See config.mak.dev for how this
+# all works.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1043,7 +1048,7 @@ include config.mak.uname
 -include config.mak.autogen
 -include config.mak
 
-ifdef EAGER_DEVELOPER
+ifdef DEVELOPER_EXTRA
 DEVELOPER = Yes
 endif
 ifdef DEVELOPER
diff --git a/config.mak.dev b/config.mak.dev
index 13883410b3..40f3365729 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -1,6 +1,12 @@
-ifndef EAGER_DEVELOPER
+ifndef DEVELOPER_NONFATAL
+ifndef DEVELOPER_EXTRA
 CFLAGS += -Werror
 endif
+endif
+ifdef DEVELOPER_FATAL
+CFLAGS += -Werror
+endif
+
 CFLAGS += -Wdeclaration-after-statement
 CFLAGS += -Wno-format-zero-length
 CFLAGS += -Wold-style-definition
@@ -23,7 +29,7 @@ CFLAGS += -Wextra
 # if a function is public, there should be a prototype and the right
 # header file should be included. If not, it should be static.
 CFLAGS += -Wmissing-prototypes
-ifndef EAGER_DEVELOPER
+ifndef DEVELOPER_EXTRA
 # These are disabled because we have these all over the place.
 CFLAGS += -Wno-empty-body
 CFLAGS += -Wno-missing-field-initializers
-- 
2.17.0.rc1.321.gba9d0f2565

