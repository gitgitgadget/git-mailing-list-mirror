Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 100781F462
	for <e@80x24.org>; Wed, 29 May 2019 16:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfE2QQC (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 12:16:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40450 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfE2QQB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 12:16:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id d30so180789pgm.7
        for <git@vger.kernel.org>; Wed, 29 May 2019 09:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=connect-hku-hk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uzk13SCFW/9AlqPeEJddbik19pZgX9MsfxzCBb0p6jc=;
        b=kt1LRfzF5e9ciBUgK8es/MWgP+zETJKYeSBS7SxVBdeVrZSd3QUCgv1e0v1q4Su+Hz
         NaHGfywpE4jWx/IEnyy/tKfdClFPe+WkEHb41bNJPukTevy/1t1dViB0MHOOM7Hu1got
         NKwe4WBXTlTeWinF74IBlyRxQAWeJBxmDMkNyVCYRv95WkMawAn7h4pagRu/Hlh5SbNi
         qFriruKSApB6z56xBejxf8GrgznoR5mlETE37jLvXzooR8Zwdgh30g56ogonf+xbC/MY
         TGfbTfCV/CbHmWw2cMymCvkr/opwUGEUlyDCIsSbC9rtj6fH/VT+JsVT9RBNyGDC8s+x
         4OsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uzk13SCFW/9AlqPeEJddbik19pZgX9MsfxzCBb0p6jc=;
        b=NJO71BWJzaPOFQlFUVC3ADn4S/qCHsq2ZyiZFPyxlJzatlvy4hPJzdF9E9Ktsfz+wE
         jXkkb4wiJdymLHDlgBtSRoNUIIiYR6rxmKHOulL//hD9D4BWBEoddPywjKICt3EZqEQt
         qnM0EK3smMgsJ5zYB2KTqUjGo2KmLVf5BG7annhxR5uVU1yVQJy2t7DPC8L0NPFWoPSa
         NnLGeg5T7vHXxftOG0D9KzcGSzb2JlG8/2p1WyjcBNEqEYydFGRuj86ICLfTWYuQByZZ
         qSMK5fDSbCqfPlvkOb6JCuPIYH+KYAZwp7Cn1tNKRuD6MSyUw3/c9nvrNEUBBAWHh3un
         a8YQ==
X-Gm-Message-State: APjAAAVVboZgH+Gw1yLY26h4TWb1eoPZgxoRO0UJXWfqzK4J3JEcjeon
        3XEhg8BBuhBzPzKyLFDeZZyf+Fwoemk=
X-Google-Smtp-Source: APXvYqyoEgAZR3zVrFPBReghZFTb05NTu+zfULRW2NZFyTJK4g2eNJZcy6+YKK9M3zsyHesCVoCNcg==
X-Received: by 2002:a63:1c19:: with SMTP id c25mr15442322pgc.183.1559146560832;
        Wed, 29 May 2019 09:16:00 -0700 (PDT)
Received: from MBP.local.hk ([175.159.177.52])
        by smtp.gmail.com with ESMTPSA id x7sm106573pfm.82.2019.05.29.09.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 May 2019 09:16:00 -0700 (PDT)
From:   Boxuan Li <liboxuan@connect.hku.hk>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, philipoakley@iee.org, gitster@pobox.com,
        j6t@kdbg.org, Boxuan Li <liboxuan@connect.hku.hk>
Subject: [PATCH] userdiff: fix grammar and style issues
Date:   Thu, 30 May 2019 00:15:39 +0800
Message-Id: <20190529161539.47445-1-liboxuan@connect.hku.hk>
X-Mailer: git-send-email 2.21.0.777.g83232e3864
In-Reply-To: <1c31f3fc-9283-91ef-7c96-6eed2f010491@kdbg.org>
References: <1c31f3fc-9283-91ef-7c96-6eed2f010491@kdbg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
---
Based on 'next' branch
---
 Documentation/gitattributes.txt | 2 +-
 userdiff.c                      | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index ade5e6d400..2796dfc83b 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -819,7 +819,7 @@ patterns are available:
 
 - `java` suitable for source code in the Java language.
 
-- `matlab` suitable for source code in the MATLAB and Octave language.
+- `matlab` suitable for source code in the MATLAB and Octave languages.
 
 - `objc` suitable for source code in the Objective-C language.
 
diff --git a/userdiff.c b/userdiff.c
index 5a3bff3836..a47b24b320 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -58,9 +58,11 @@ PATTERNS("java",
 	 "|[-+*/<>%&^|=!]="
 	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
 PATTERNS("matlab",
-	 /* Octave pattern is mostly the same as matlab, except that '%%%' and
+	 /*
+	  * Octave pattern is mostly the same as matlab, except that '%%%' and
 	  * '##' can also be used to begin code sections, in addition to '%%'
-	  * that is understood by both. */
+	  * that is understood by both.
+	  */
 	 "^[[:space:]]*((classdef|function)[[:space:]].*)$|^(%%%?|##)[[:space:]].*$",
 	 "[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[=~<>]=|\\.[*/\\^']|\\|\\||&&"),
 PATTERNS("objc",
-- 
2.21.0.777.g83232e3864

