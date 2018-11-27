Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFEA41F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 10:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbeK0VDz (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 16:03:55 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33533 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeK0VDz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 16:03:55 -0500
Received: by mail-oi1-f194.google.com with SMTP id c206so18797274oib.0
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 02:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wVLfcx8BwQ/WebjVbzkyhSpk81xwBr+lq8HK+J05VtQ=;
        b=QixAhM32wLq3neMeCChcXqnR/zG2mIbTVGs923gOhHY3uPqeW+yWytHfe+FH2Xr8nk
         1HghabdT5Oby50YJBRQ8bL+TOmtfQHwf4WEdaRtwJoFznnBw6gYuysz1k7JRaR/Scyc0
         jykw44KpSP6olcjT8g/qnKMx7CO4cPmpF1HM9na/rnA0Z7wygABL3A3UHE5x2aZhBmAG
         5ebFs/Ou0pxRUh/Lny2wDuYNvtAPV77iC3rV2XHjEd+E/SgQcLAw9Gs88TVX6Nd8Yd4w
         oH6ZiQTsccyP6tQoaTdSiSXk0Y2JbfLafQRm4HCACTXlnDblpCM0WtkLCrgkBQqJnFPx
         81WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wVLfcx8BwQ/WebjVbzkyhSpk81xwBr+lq8HK+J05VtQ=;
        b=R35zQm2Qm5J6+qgba31lG/y76KL/jz01AHQIdCzIUiXj6E1v7sNSJPw7u5deeAU7we
         UqzB2dnzsjtXx08H63VgFJVmZZOic4s0HPQWwfE+AmIzW/H1H0nmvQPVizysUcZSbXQD
         P6PFiESI2LdQV831pvaoipt/dEOKGVm3IsyUB/OyvjrUWnObWwYiPos/bfQx4f3qGD+g
         nFzDXZc7I85gIbGH30YZObd+QpUPQATXVWSfIFNxpFyFXF6BBI9FHjYt8nV0zzYp4QUY
         An9/0QBe5xvQ+RhGbjT/U17vF8rG/1GarpG1Jzsi7FgyERQlf+mAysT5LLid9Px7READ
         U8qw==
X-Gm-Message-State: AGRZ1gKTMQA+muvo6nPMUPt0ZxBsRsP0ymgFP4ftjBwYVN7MYv4ruj/d
        hU63JJZ18SBMIvxEJNjID96FgWni
X-Google-Smtp-Source: AJdET5dZbWJf32ylPEth+u8t0+1wQSf4iRRQmqoSAKPgOaG2gh/2TcvMEO/hf8YJDxfY+vB7vR/pUA==
X-Received: by 2002:a54:4581:: with SMTP id z1mr18056075oib.192.1543313192013;
        Tue, 27 Nov 2018 02:06:32 -0800 (PST)
Received: from Carlos-MBP-2.attlocal.net (76-219-66-166.lightspeed.irvnca.sbcglobal.net. [76.219.66.166])
        by smtp.gmail.com with ESMTPSA id l5sm923242oil.15.2018.11.27.02.06.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Nov 2018 02:06:31 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     dev+git@drbeat.li, pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH] config.mak.dev: enable -Wpedantic in clang
Date:   Tue, 27 Nov 2018 02:05:57 -0800
Message-Id: <20181127100557.53891-1-carenas@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DEVOPTS=pedantic adds -pedantic to the compiler flags, but misses on some
diagnostics when using clang, and that are only enabled with -Wpedantic

46c0eb5843 ("files-backend.c: fix build error on Solaris", 2018-11-25)
fixes an issue that was visible also with gcc but not clang so correct
that with the hope that in the future CI could be used for early detection
of similar issues

-Wpedantic is only enabled for clang 10 or higher (only available in macOS
with latest Xcode) but this restriction should be relaxed further as more
environments are tested

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 config.mak.dev | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/config.mak.dev b/config.mak.dev
index bbeeff44fe..ad25beacd8 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -1,8 +1,15 @@
+ifndef COMPILER_FEATURES
+COMPILER_FEATURES := $(shell ./detect-compiler $(CC))
+endif
+
 ifeq ($(filter no-error,$(DEVOPTS)),)
 CFLAGS += -Werror
 endif
 ifneq ($(filter pedantic,$(DEVOPTS)),)
 CFLAGS += -pedantic
+ifneq ($(filter clang10,$(COMPILER_FEATURES)),)
+CFLAGS += -Wpedantic
+endif
 # don't warn for each N_ use
 CFLAGS += -DUSE_PARENS_AROUND_GETTEXT_N=0
 endif
@@ -16,10 +23,6 @@ CFLAGS += -Wstrict-prototypes
 CFLAGS += -Wunused
 CFLAGS += -Wvla
 
-ifndef COMPILER_FEATURES
-COMPILER_FEATURES := $(shell ./detect-compiler $(CC))
-endif
-
 ifneq ($(filter clang4,$(COMPILER_FEATURES)),)
 CFLAGS += -Wtautological-constant-out-of-range-compare
 endif
-- 
2.20.0.rc1

