Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 863961F404
	for <e@80x24.org>; Thu, 29 Mar 2018 15:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752259AbeC2PDl (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 11:03:41 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34608 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752085AbeC2PDi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 11:03:38 -0400
Received: by mail-lf0-f65.google.com with SMTP id c78-v6so8891536lfh.1
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 08:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vWIa+DcT/uycv65CKpgr5s8acGzQQELCelHc0zMHZGE=;
        b=kV2kWIiSO5sc6ourngvwW4djuV7gyzZwqeHDvQI2XHrBqATK86s+yg0gnNXx73fcXs
         /OUzB/3G1Yts9gOHknihnqVfuw+suRn0aCVeGEB8ksR/cvfPZ/tngVkJBfZuTh2BVNhv
         dqKSbH1tcv/owPIPdYN62Bt+cnV/r9sCiMnrmGZ4CnGwCqnQmpv5GEtGRc8keoAJ/Sfv
         GakgM4lRdGpiKJfl4LzwiBnsQ0wMeHvHPFb5l+C0FlkbrwNETwG4yCoEDLQnuy1/bvZN
         3wBSh2QJHbpCGmK0rl2tD/z/7K2a8dU8e8O86d3zqW5K/zkjTZMvISLXlh+3CL9m3hl1
         kQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vWIa+DcT/uycv65CKpgr5s8acGzQQELCelHc0zMHZGE=;
        b=gSXckEkoBFBMNmyo0k7Gf76VxcycCX3DDfeyhI1eqtdFZn5ob1XIMFU05qmoehNxyO
         52iQHOp342q4Bm861R5frxfz7W5og7EGhuh8SE4aJ3oHrUK5vbzY+wfy1lMcbNVsdJXA
         jlGRkptBhyZNiYgsfLBDiVwKh7h5KyI/bcoFaCxPN5HUFW2o15ox+a08uGXm4buAmWqY
         UxMlXyRPu6U6lIH52YgIWmxkrvEI1fY9TfbsYsfddSWGXquQgQIowwHcNl/VREnjzbmx
         fOEqqAnejSE9dFxWTwNgtx4YEBFRt1hM9FF3XqvBLCvhdc2IaWrznbIKI9xNvqSHGYmw
         Rzng==
X-Gm-Message-State: AElRT7GlNpipDa+tqcrNJvIpNKspowZJNPoDO2nBdDDD47w8XVHwdxAq
        hagIr+3DFCExUJIPck4Fb27KhA==
X-Google-Smtp-Source: AIpwx4/T2Ns3BQID3wytsMMfBshpG+DV9fIXW9TgPGeikbc3PuhTPkbd+cAzPc9PoDzPYYLxnIWeHQ==
X-Received: by 10.46.153.147 with SMTP id w19mr2059021lji.93.1522335816666;
        Thu, 29 Mar 2018 08:03:36 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x7-v6sm1186265lff.64.2018.03.29.08.03.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Mar 2018 08:03:35 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        ramsay@ramsayjones.plus.com, larsxschneider@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 3/3] Makefile: add EAGER_DEVELOPER mode
Date:   Thu, 29 Mar 2018 17:03:22 +0200
Message-Id: <20180329150322.10722-4-pclouds@gmail.com>
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

This mode is for developers who want to keep the code base
clean. There are warning classes that are currently suppressed because
we have too many of them in the code base. This mode will stop the
suppression, let the developer see and decide how to fix them.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Makefile       | 7 ++++++-
 config.mak.dev | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

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
index 716a14ecc7..13883410b3 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -1,4 +1,6 @@
+ifndef EAGER_DEVELOPER
 CFLAGS += -Werror
+endif
 CFLAGS += -Wdeclaration-after-statement
 CFLAGS += -Wno-format-zero-length
 CFLAGS += -Wold-style-definition
@@ -21,6 +23,7 @@ CFLAGS += -Wextra
 # if a function is public, there should be a prototype and the right
 # header file should be included. If not, it should be static.
 CFLAGS += -Wmissing-prototypes
+ifndef EAGER_DEVELOPER
 # These are disabled because we have these all over the place.
 CFLAGS += -Wno-empty-body
 CFLAGS += -Wno-missing-field-initializers
@@ -28,6 +31,7 @@ CFLAGS += -Wno-sign-compare
 CFLAGS += -Wno-unused-function
 CFLAGS += -Wno-unused-parameter
 endif
+endif
 
 # uninitialized warnings on gcc 4.9.2 in xdiff/xdiffi.c and config.c
 # not worth fixing since newer compilers correctly stop complaining
-- 
2.17.0.rc1.439.gca064e2955

