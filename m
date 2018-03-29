Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61D171F404
	for <e@80x24.org>; Thu, 29 Mar 2018 15:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752188AbeC2PDf (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 11:03:35 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43673 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751398AbeC2PDe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 11:03:34 -0400
Received: by mail-lf0-f66.google.com with SMTP id v207-v6so8848757lfa.10
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 08:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TqxpSpRwcrZHB5UAHywFdMK6lvR9usylOZ3c6rbWqbM=;
        b=Nmrw5SbxbKsPXmh/GmZbWzSOyCOCfZ4e5VB8/BlAlfraF82wt73EwRoaehR+nJe5GM
         OklPyK6goF/fbDwVmT1Si4y78z20jurnJUNAnlzabtvlhxvCa+g/SGAejCD6KzqVANnT
         uOB5h+fDuVDP+X5UWNLu7WIkECzzLOqNdvm9FQuu5xKELUFkR7e7bDsl6RmtDiOLbzPe
         +p2RNEvn0gUlfYMdpEdW15NqbUeTpXFKpD/o3cEj0aWCmEeGdMFfQL2oFWv6ign4/ffL
         IbIvYau1SrV5Zx16VZE/xH0jM6pEkaI/xg0k4WrVwLcowywz6OqdJjF3R3EL+5BOzX4Q
         /n1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TqxpSpRwcrZHB5UAHywFdMK6lvR9usylOZ3c6rbWqbM=;
        b=tVWl0dwWzpyKsEXQpiiA5gBwG60tiqn0xB+2/LgkKZpQEZvxbb2zDUij56HuxLh1ys
         Qs95mQ1qTou3KlELqo/J2u77YpMVhJew1hGSZWSx0cYuROXnYVerTKzD/sFLRJTObReT
         wPbgtUg9zvj3GXOhrLVQE4JUFtukWajfRCLwtqTge6yIA0Vt2quo1R3ZUDQmrDkwLoAG
         71SU6TuGD0H7nmWK5y5c/5yyHyD/BWydFQF2u5umyqWlQnjKlrWO3NKubEMWQXLgC5Z0
         jr1geZ1OrKppn/dqnuOrg7fuiv9CXkCDmSXB8XDq6XosWRTIuUfH7623gymSTOBerz/a
         h8ww==
X-Gm-Message-State: AElRT7F3U5XlJxKuxXGoxRONzR4ysW6MczmdjWQbhlht7LxC8jNT8uCb
        KgdUti9G8iTk2bXbNQmjqP6gXA==
X-Google-Smtp-Source: AIpwx48C5p8onHEBK0kybgw+XLyWfIP8NOX7P0ObyCtw7L5GFw9FW5FodVXoyriYgPI5PwoVy7eTUw==
X-Received: by 2002:a19:23c5:: with SMTP id j188-v6mr5381136lfj.122.1522335812480;
        Thu, 29 Mar 2018 08:03:32 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x7-v6sm1186265lff.64.2018.03.29.08.03.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Mar 2018 08:03:31 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        ramsay@ramsayjones.plus.com, larsxschneider@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 0/3] Enable more compiler warnings for devs
Date:   Thu, 29 Mar 2018 17:03:19 +0200
Message-Id: <20180329150322.10722-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.439.gca064e2955
In-Reply-To: <20180324125348.6614-1-pclouds@gmail.com>
References: <20180324125348.6614-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 fixes the fallthru warnings in connect.c, and with json-writer
series rerolled, 'pu' should build cleanly now.
-Wno-maybe-uninitialized is removed, thanks to Ramsay.

v3 also adds an experimental patch that adds EAGER_DEVELOPER=1. These
developers will have all warnings enabled (nothing is suppressed) but
they are not fatal. They could go through them and perhaps clean up
the code base a bit more.

Interdiff

diff --git a/Makefile b/Makefile
index e6680a8977..e4f04ce1cb 100644
--- a/Makefile
+++ b/Makefile
@@ -434,7 +434,9 @@ all::
 #
 # Define DEVELOPER to enable more compiler warnings. Compiler version
 # and faimily are auto detected, but could be overridden by defining
-# COMPILER_FEATURES (see config.mak.dev)
+# COMPILER_FEATURES (see config.mak.dev).
+# Define EAGER_DEVELOPER keeps compiler warnings non-fatal, but no warning
+# class is suppressed anymore.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1041,6 +1043,9 @@ include config.mak.uname
 -include config.mak.autogen
 -include config.mak
 
+ifdef EAGER_DEVELOPER
+DEVELOPER = Yes
+endif
 ifdef DEVELOPER
 include config.mak.dev
 endif
diff --git a/config.mak.dev b/config.mak.dev
index d8beaf9347..13883410b3 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -1,4 +1,6 @@
+ifndef EAGER_DEVELOPER
 CFLAGS += -Werror
+endif
 CFLAGS += -Wdeclaration-after-statement
 CFLAGS += -Wno-format-zero-length
 CFLAGS += -Wold-style-definition
@@ -18,13 +20,23 @@ endif
 
 ifneq ($(or $(filter gcc6,$(COMPILER_FEATURES)),$(filter clang4,$(COMPILER_FEATURES))),)
 CFLAGS += -Wextra
+# if a function is public, there should be a prototype and the right
+# header file should be included. If not, it should be static.
 CFLAGS += -Wmissing-prototypes
+ifndef EAGER_DEVELOPER
+# These are disabled because we have these all over the place.
 CFLAGS += -Wno-empty-body
 CFLAGS += -Wno-missing-field-initializers
 CFLAGS += -Wno-sign-compare
 CFLAGS += -Wno-unused-function
 CFLAGS += -Wno-unused-parameter
-ifneq ($(filter gcc6,$(COMPILER_FEATURES)),)
-CFLAGS += -Wno-maybe-uninitialized
+endif
+endif
+
+# uninitialized warnings on gcc 4.9.2 in xdiff/xdiffi.c and config.c
+# not worth fixing since newer compilers correctly stop complaining
+ifneq ($(filter gcc4,$(COMPILER_FEATURES)),)
+ifeq ($(filter gcc5,$(COMPILER_FEATURES)),)
+CFLAGS += -Wno-uninitialized
 endif
 endif
diff --git a/connect.c b/connect.c
index c3a014c5ba..49eca46462 100644
--- a/connect.c
+++ b/connect.c
@@ -46,7 +46,7 @@ int check_ref_type(const struct ref *ref, int flags)
 	return check_ref(ref->name, flags);
 }
 
-static void die_initial_contact(int unexpected)
+static NORETURN void die_initial_contact(int unexpected)
 {
 	if (unexpected)
 		die(_("The remote end hung up upon initial contact"));


Nguyễn Thái Ngọc Duy (3):
  connect.c: mark die_initial_contact() NORETURN
  Makefile: detect compiler and enable more warnings in DEVELOPER=1
  Makefile: add EAGER_DEVELOPER mode

 Makefile        | 20 +++++++++----------
 config.mak.dev  | 42 +++++++++++++++++++++++++++++++++++++++
 connect.c       |  2 +-
 detect-compiler | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 106 insertions(+), 11 deletions(-)
 create mode 100644 config.mak.dev
 create mode 100755 detect-compiler

-- 
2.17.0.rc1.439.gca064e2955

