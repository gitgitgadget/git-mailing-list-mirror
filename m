Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E59CB1F462
	for <e@80x24.org>; Tue, 21 May 2019 14:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfEUO5c (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 10:57:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35524 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbfEUO5b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 10:57:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id t1so7305851pgc.2
        for <git@vger.kernel.org>; Tue, 21 May 2019 07:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=connect-hku-hk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TVWVBYftWwdiBHJwSUVc4c+PzIc3P8RSqks+5odTBMc=;
        b=rPIHTxZAmDMSXg61o4BP/XMUpUQTxrM84dyatymAf9/M4FS1yxdTkIOmw1UZovbkyi
         E0uce+wdv0oaoq+uentK5qwWQjXUYTwVI6YIG4K9sT9tfENp0CuvS6X+6M89iJK2FhA5
         vFM7RJVP45pq6ATunBVBGRm6rcNvSA7CnfLBobCJFY+EfEf2uGEXx4CljmTWi/eGEmrH
         os7MwVFKhW9L90OOOrywpcH41momgPRM7kzKVuagyGPL3N8BGxjdsK8YPU2chNuw3mhS
         hj+domgU2oLVAcbU8rFvIB4928l/zPSCKmukVHf0anqjLevaIHvI3LqOwYjvVlWi6/Bo
         +9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TVWVBYftWwdiBHJwSUVc4c+PzIc3P8RSqks+5odTBMc=;
        b=IekDaoITg3CGeHpRpoWUNu9x/jIyXm35u/0Fu7QRydIPLF9j65deobi3dbr41gfC3k
         XCk5qvEbiBzTjGmWTXN+4CS2iLHh4C+rHcYnysPuK/hWgyO3spP1TyKv/f9ZZ1Q7raC9
         0m2Qp3Uwtkg68e5gESghSkq10k0onJxU+rm2hdf2fbH9awMF/hzm/7VvZkyZjWeIKEGk
         +VByUXpNDQmL+J2QtzpUh/gl+qPPIhiYOnoa/lVXCCXfvdYAYWkfRAVTlfJvBaf77e/N
         oaj9Sii1Hyg9nq+S2IeC5/XsQqqJbm3brO5dwN4ZyRd2lHQZYwUlAkjWk6uUxxQjtEwV
         JwVA==
X-Gm-Message-State: APjAAAVo3aEEWvV9jdgs5iZtik+z7sosr4qtrRmMwc6HVkRLmPCGkYEA
        Yp0KZLN8fLgAdsrFXNvRonnzCb6Q2REBcQ==
X-Google-Smtp-Source: APXvYqyJnV65JCSYoBOcUh61pCcQJc0ANNbh6Xk5awR9vYqOUcjrvamvrb9ObPa6of48VXBWNqMyjQ==
X-Received: by 2002:aa7:842f:: with SMTP id q15mr88669499pfn.161.1558450650973;
        Tue, 21 May 2019 07:57:30 -0700 (PDT)
Received: from MBP.local.hk ([175.159.177.127])
        by smtp.gmail.com with ESMTPSA id a37sm10934638pga.67.2019.05.21.07.57.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 07:57:30 -0700 (PDT)
From:   Boxuan Li <liboxuan@connect.hku.hk>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, philipoakley@iee.org, gitster@pobox.com,
        j6t@kdbg.org, Boxuan Li <liboxuan@connect.hku.hk>
Subject: [PATCH v6] userdiff: add Octave
Date:   Tue, 21 May 2019 22:57:18 +0800
Message-Id: <20190521145718.56693-1-liboxuan@connect.hku.hk>
X-Mailer: git-send-email 2.21.0.777.g83232e3864
In-Reply-To: <3b7a22e8-0310-3738-0476-b6d73f187331@kdbg.org>
References: <3b7a22e8-0310-3738-0476-b6d73f187331@kdbg.org>
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
Acked-by: Johannes Sixt <j6t@kdbg.org>
---
Thanks to review from Johannes, update from v5:
Fix grammar and style
---
 Documentation/gitattributes.txt | 2 +-
 t/t4018/matlab-class-definition | 5 +++++
 t/t4018/matlab-function         | 4 ++++
 t/t4018/matlab-octave-section-1 | 3 +++
 t/t4018/matlab-octave-section-2 | 3 +++
 t/t4018/matlab-section          | 3 +++
 userdiff.c                      | 7 ++++++-
 7 files changed, 25 insertions(+), 2 deletions(-)
 create mode 100644 t/t4018/matlab-class-definition
 create mode 100644 t/t4018/matlab-function
 create mode 100644 t/t4018/matlab-octave-section-1
 create mode 100644 t/t4018/matlab-octave-section-2
 create mode 100644 t/t4018/matlab-section

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 4fb20cd0e9..e387cc6dda 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -819,7 +819,7 @@ patterns are available:
 
 - `java` suitable for source code in the Java language.
 
-- `matlab` suitable for source code in the MATLAB language.
+- `matlab` suitable for source code in the MATLAB and Octave languages.
 
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
index 3a78fbf504..04270fb4d7 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -58,7 +58,12 @@ PATTERNS("java",
 	 "|[-+*/<>%&^|=!]="
 	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
 PATTERNS("matlab",
-	 "^[[:space:]]*((classdef|function)[[:space:]].*)$|^%%[[:space:]].*$",
+	 /*
+	  * Octave pattern is mostly the same as matlab, except that '%%%' and
+	  * '##' can also be used to begin code sections, in addition to '%%'
+	  * that is understood by both.
+	  */
+	 "^[[:space:]]*((classdef|function)[[:space:]].*)$|^(%%%?|##)[[:space:]].*$",
 	 "[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[=~<>]=|\\.[*/\\^']|\\|\\||&&"),
 PATTERNS("objc",
 	 /* Negate C statements that can look like functions */
-- 
2.21.0.777.g83232e3864

