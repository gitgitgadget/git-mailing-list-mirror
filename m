Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B92A20248
	for <e@80x24.org>; Fri, 22 Feb 2019 14:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfBVOlw (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 09:41:52 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:37968 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfBVOlv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 09:41:51 -0500
Received: by mail-wm1-f49.google.com with SMTP id v26so2190586wmh.3
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 06:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LWP7dbZHkbXCqT0bzAK4YrQDhwucrowZyuLcWiDnZiU=;
        b=XEgAUEkUTD7fE2OX0O/ZLp7wEPcGJM6RTJzFGUmHSCL2Ip7/B6PLRwS5lQLanRR/Ba
         ITt30u8rywN4I3viNCKZTa7dtcvA6kZPkWw9pXKAp7MsF1FE2LJiVpGegbPMsUCVGMn/
         Zx5jm1dFNxyF6vc0KTZ8iuC4lLZws4N8sIgBpIcuPa2FhhFPnimail37GWS+tE/aVusJ
         m5EjDxH5PwME2VScwCz/8O1wbV50lHoD57CnzWsfdlO2snI1D0kUPw6r8orfwRkwN22e
         ymCU4PHIYKzwVvKfbluWaybxhYhurQ9Ck5mNpevxEd5nArt/ZWELF7GyuQEVA0qJGofi
         DVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LWP7dbZHkbXCqT0bzAK4YrQDhwucrowZyuLcWiDnZiU=;
        b=qfyV33WnbdDZ99k9bx99nBdBFWCJxWsZbGNeZTdOaptTsl62++SaAVk9F8ZkWOATN6
         lSHnwSzyX8v92E2uGt6HQpvqsgZO6CTIZPpP11Zl5nxQtrtYBMJvCBeRLSRlg/NcZ9P6
         lFDeFodUCFHtYYQcTu51lcu/E0N85xVZtoU0SXBc6hJ6PrnUNOhM0KsvwYZYyR5pLD07
         B9/C5B+OoARosmTOLsRFmsmOun4B10j2Kd8qTREO8roCwj7RfHJf2+YuuwhNvvSUsBqH
         TPzTU+fAY8A+fi/KdepZ1lIEqKq8nMtWQ2dFaGm3UApaHq8MoXvCUF4dskvbY3vCQiYI
         cBLg==
X-Gm-Message-State: AHQUAuZqAovU57T49zA3WlePtBVfn+SPsHjh3ElzTPKPxj+WlXkfx/I8
        vuOBurk/TfZltGhoErFHI7utNdATgdc=
X-Google-Smtp-Source: AHgI3IaUNscjDQ002vDfyVVSiFmGD9Pokng3LwHXvt3uPJgvheU+MWtvXqj4JayxI8qtROOoD74/5A==
X-Received: by 2002:a1c:d183:: with SMTP id i125mr2612949wmg.30.1550846507636;
        Fri, 22 Feb 2019 06:41:47 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z15sm1481689wmi.46.2019.02.22.06.41.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Feb 2019 06:41:46 -0800 (PST)
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
Subject: [PATCH v2 5/6] Makefile: move the setting of *FLAGS closer to "include"
Date:   Fri, 22 Feb 2019 15:41:26 +0100
Message-Id: <20190222144127.32248-6-avarab@gmail.com>
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

Move the setting of variables like CFLAGS down past settings like
"prefix" and default programs like "TAR" to just before we do the
include from "config.mak.*".

There's no functional changes here yet, but move note that
"ALL_CFLAGS" and "ALL_LDFLAGS" are moved below the include. A
follow-up change will tweak those depending on a variable set in
config.mak.dev.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/Makefile b/Makefile
index 59674ce9d7..82cfd6c2e4 100644
--- a/Makefile
+++ b/Makefile
@@ -506,13 +506,6 @@ GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
 -include GIT-VERSION-FILE
 
-# CFLAGS and LDFLAGS are for the users to override from the command line.
-CFLAGS = -g -O2 -Wall
-LDFLAGS =
-ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
-ALL_LDFLAGS = $(LDFLAGS)
-ARFLAGS = rcs
-
 # Set our default configuration.
 #
 # Among the variables below, these:
@@ -572,7 +565,6 @@ TCLTK_PATH = wish
 XGETTEXT = xgettext
 MSGFMT = msgfmt
 CURL_CONFIG = curl-config
-PTHREAD_CFLAGS =
 GCOV = gcov
 STRIP = strip
 SPATCH = spatch
@@ -582,16 +574,6 @@ export TCL_PATH TCLTK_PATH
 # Set our default LIBS variables
 PTHREAD_LIBS = -lpthread
 
-# user customisation variable for 'sparse' target
-SPARSE_FLAGS ?=
-# internal/platform customisation variable for 'sparse'
-SP_EXTRA_FLAGS =
-
-SPATCH_FLAGS = --all-includes --patch .
-
-BASIC_CFLAGS = -I.
-BASIC_LDFLAGS =
-
 # Guard against environment variables
 BUILTIN_OBJS =
 BUILT_INS =
@@ -1160,6 +1142,25 @@ ifeq ($(wildcard sha1collisiondetection/lib/sha1.h),sha1collisiondetection/lib/s
 DC_SHA1_SUBMODULE = auto
 endif
 
+# Set CFLAGS, LDFLAGS and other *FLAGS variables. These might be
+# tweaked by config.* below as well as the command-line, both of
+# which'll override these defaults.
+CFLAGS = -g -O2 -Wall
+LDFLAGS =
+BASIC_CFLAGS = -I.
+BASIC_LDFLAGS =
+
+# library flags
+ARFLAGS = rcs
+PTHREAD_CFLAGS =
+
+# For the 'sparse' target
+SPARSE_FLAGS ?=
+SP_EXTRA_FLAGS =
+
+# For the 'coccicheck' target
+SPATCH_FLAGS = --all-includes --patch .
+
 include config.mak.uname
 -include config.mak.autogen
 -include config.mak
@@ -1168,6 +1169,9 @@ ifdef DEVELOPER
 include config.mak.dev
 endif
 
+ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
+ALL_LDFLAGS = $(LDFLAGS)
+
 comma := ,
 empty :=
 space := $(empty) $(empty)
-- 
2.21.0.rc2.1.g2d5e20a900.dirty

