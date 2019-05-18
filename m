Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 457AB1F461
	for <e@80x24.org>; Sat, 18 May 2019 03:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfERDqi (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 23:46:38 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46884 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfERDqi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 23:46:38 -0400
Received: by mail-pl1-f193.google.com with SMTP id r18so4191109pls.13
        for <git@vger.kernel.org>; Fri, 17 May 2019 20:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=connect-hku-hk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XMdtvC8tM8eM+B5OsovpeghxW1hMKBMuVJVVO/xWFhI=;
        b=Fm39wJ1VMd1bvHuaL6xrCAZTtB3EcGHRKzgIOpe/L9f9qHykkkXdO4BpBzmOMdDMGs
         Oi/todFdu6HH75EmFFPS3AbvgdjtCvO/yJY9L2hCviidfwkPURMMibjfRfiN3S+ezMGX
         6p3/ZplQXSFC/+vVHCU/ZYcDLrtza/gNeb7sbGM8m3AHc8UxMHDNcPZ/rQ2ZaDO4GVF4
         J9c3qireFf8+Hc23bSqDad4xraDmsmvIX5AlSKRXRP1ca6XLwiQhVA+4wxGzgV7I+xik
         kmbHdux82Buvtzd8St7hFy8EWXTyzGiiKuVXyPL51X84PKk2x0eNun1bEayrkSL2ns6K
         ikdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XMdtvC8tM8eM+B5OsovpeghxW1hMKBMuVJVVO/xWFhI=;
        b=KYP74a6v5yKxqOYl6FW2rur44ZyFAWMdMprh027MS/S3kIoWu3bYqsvtdoBpP1OP61
         8zbtWxJo5weKYyPcY9gT3BzCyYxkh/RzjGwQj2cbtuP9I9/DpgPj2tVeRnhTBagQPs+J
         u6RpBVMAnTfU2Ew8wstT7IUTDr3yhyVscFPLzrfFZ/w5C6W/ArcKJgeWpCF0srec03ru
         g9NWGp/IGiXRVvNvU4K4P9wcJFAdp7tj1r94sueyFCVo0b8YEqNK5GeQo3b7wqMJRj19
         +d00CWBn0aWB2KyMVe3T/6//3s153tgG/FGahIMHuZqDPzKqWgFJKZDWW5sSRZ/ZVPn6
         9IxQ==
X-Gm-Message-State: APjAAAVGLxcu7yCY3ydoE0NHkDWNHRe3gH3pc+rAmKD37uk3PdzGuqYZ
        Zbzx+3C3eUt85xR+nELpLhXJpElSK/+aaQ==
X-Google-Smtp-Source: APXvYqwQ2wNjCBAXBQADtkaq1Iqvb8jlVmQQFKy1reHsYYknyTChRS9hVOd+koTnpENhGgVo3J/fjg==
X-Received: by 2002:a17:902:9007:: with SMTP id a7mr59791093plp.221.1558151197595;
        Fri, 17 May 2019 20:46:37 -0700 (PDT)
Received: from MBP.local.hk ([175.159.183.189])
        by smtp.gmail.com with ESMTPSA id a26sm18902090pfl.177.2019.05.17.20.46.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 May 2019 20:46:36 -0700 (PDT)
From:   Boxuan Li <liboxuan@connect.hku.hk>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, philipoakley@iee.org, gitster@pobox.com,
        j6t@kdbg.org, Boxuan Li <liboxuan@connect.hku.hk>
Subject: [PATCH v5] userdiff: add Octave
Date:   Sat, 18 May 2019 11:46:23 +0800
Message-Id: <20190518034623.87702-1-liboxuan@connect.hku.hk>
X-Mailer: git-send-email 2.21.0.777.g83232e3864
In-Reply-To: <CALM0=-mTLakSBW67vqHNX84p=uw990QDbpeUfh1HKq9N0CiiLA@mail.gmail.com>
References: <CALM0=-mTLakSBW67vqHNX84p=uw990QDbpeUfh1HKq9N0CiiLA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Octave pattern is almost the same as matlab, except
that '%%%' and '##' can also be used to begin code sections,
in addition to '%%' that is understood by both. Octave
pattern is merged into Matlab pattern. Test cases for
the hunk header patterns of matlab and octave under
t/t4018 are added.

Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
---
v1: use matlab pattern for octave
v2: add a new octave pattern
v3: fix indentation problem of v2
v4: improve doc and commit message
v5: merge octave pattern into matlab and add test cases
---
 Documentation/gitattributes.txt | 2 +-
 t/t4018/matlab-class-definition | 5 +++++
 t/t4018/matlab-function         | 4 ++++
 t/t4018/matlab-octave-section-1 | 3 +++
 t/t4018/matlab-octave-section-2 | 3 +++
 t/t4018/matlab-section          | 3 +++
 userdiff.c                      | 5 ++++-
 7 files changed, 23 insertions(+), 2 deletions(-)
 create mode 100644 t/t4018/matlab-class-definition
 create mode 100644 t/t4018/matlab-function
 create mode 100644 t/t4018/matlab-octave-section-1
 create mode 100644 t/t4018/matlab-octave-section-2
 create mode 100644 t/t4018/matlab-section

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 4fb20cd0e9..e657a6b7b7 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -819,7 +819,7 @@ patterns are available:
 
 - `java` suitable for source code in the Java language.
 
-- `matlab` suitable for source code in the MATLAB language.
+- `matlab` suitable for source code in the MATLAB and Octave language.
 
 - `objc` suitable for source code in the Objective-C language.
 
diff --git a/t/t4018/matlab-class-definition b/t/t4018/matlab-class-definition
new file mode 100644
index 0000000000..84daedfb4e
--- /dev/null
+++ b/t/t4018/matlab-class-definition
@@ -0,0 +1,5 @@
+classdef RIGHT
+    properties
+        ChangeMe
+    end
+end
diff --git a/t/t4018/matlab-function b/t/t4018/matlab-function
new file mode 100644
index 0000000000..897a9b13ff
--- /dev/null
+++ b/t/t4018/matlab-function
@@ -0,0 +1,4 @@
+function y = RIGHT()
+x = 5;
+y = ChangeMe + x;
+end
diff --git a/t/t4018/matlab-octave-section-1 b/t/t4018/matlab-octave-section-1
new file mode 100644
index 0000000000..3bb6c4670e
--- /dev/null
+++ b/t/t4018/matlab-octave-section-1
@@ -0,0 +1,3 @@
+%%% RIGHT section
+# this is octave script
+ChangeMe = 1;
diff --git a/t/t4018/matlab-octave-section-2 b/t/t4018/matlab-octave-section-2
new file mode 100644
index 0000000000..ab2980f7f2
--- /dev/null
+++ b/t/t4018/matlab-octave-section-2
@@ -0,0 +1,3 @@
+## RIGHT section
+# this is octave script
+ChangeMe = 1;
diff --git a/t/t4018/matlab-section b/t/t4018/matlab-section
new file mode 100644
index 0000000000..5ea59a5de0
--- /dev/null
+++ b/t/t4018/matlab-section
@@ -0,0 +1,3 @@
+%% RIGHT section
+% this is understood by both matlab and octave
+ChangeMe = 1;
diff --git a/userdiff.c b/userdiff.c
index 3a78fbf504..bcae006abe 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -58,7 +58,10 @@ PATTERNS("java",
 	 "|[-+*/<>%&^|=!]="
 	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
 PATTERNS("matlab",
-	 "^[[:space:]]*((classdef|function)[[:space:]].*)$|^%%[[:space:]].*$",
+	 /* Octave pattern is mostly the same as matlab, except that '%%%' and
+	  * '##' can also be used to begin code sections, in addition to '%%'
+	  * that is understood by both. */
+	 "^[[:space:]]*((classdef|function)[[:space:]].*)$|^(%%%?|##)[[:space:]].*$",
 	 "[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[=~<>]=|\\.[*/\\^']|\\|\\||&&"),
 PATTERNS("objc",
 	 /* Negate C statements that can look like functions */
-- 
2.21.0.777.g83232e3864

