Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BCC71F660
	for <e@80x24.org>; Tue,  3 Jul 2018 13:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753348AbeGCNR1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 09:17:27 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43595 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753341AbeGCNRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 09:17:25 -0400
Received: by mail-pl0-f68.google.com with SMTP id c41-v6so1034074plj.10
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 06:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=whileimautomaton-net.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s3XTVp+g6O74gesnZI/Hvk4WhVt1Ytnf3g53R3mW3Iw=;
        b=zk0c5ox1seFQeTKX+oeM1QdSwdBrsbFn6o1TRGUk/jQbrSLvwDEjGl/mgAhtQNj1BJ
         L+wnEvch4DR1nkozTfm8QrpeihhsCq9O3XEa0wGOZRELQK8NdVtN5tsH05zfb0a7kyU4
         PtaWCrPU+sXFEiFF7N7JajOc4CNPxbFQj124qtFq/UaqiiO3XF2gpPejK8FVxLnBpBil
         yVyOIisFuE86YIjF3i+sDAILWrPMDKtdbfdXTeuA4mHtQ32lAoEiuNovhMSAYdk50Fp4
         tfbbKsO/fwmouNtPCJ0RbHBdtbrGz+/wQQfsbuMgoRrtViZCuNm6WG1TYLcTQ071EwR6
         db2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=s3XTVp+g6O74gesnZI/Hvk4WhVt1Ytnf3g53R3mW3Iw=;
        b=P7B5D0Yz2Da6ffkILeWWbXWyHh4cMBrIyog5jpF8mBOLZgFh2She5hIpf+CU/m3fwB
         ySgGs7CEaPT08T83HxlfVXIV0UZDgAu4JQdFrfsthrH5gJoDl5PSR/SUNBPfLjW9dBJa
         AT45VnPfD6lX3pExmDH5WjAnvawk+Ra468LilIVyYzc4hd+4sDhysiYItsPKnvFFhn3X
         VtYC+28xMOyv2bg57pInC0gjumHUdrzdyNhU1mVnCZZlMWBuWi0dfQ9hdLPukvTQ9qa0
         utDZeJtO7T0wiLy3SoXgwZdX+4SGWMN0IXRGzfbjIv83JBkNhlIesiahdZZGF1HeDYVO
         nK5w==
X-Gm-Message-State: APt69E2I02xOlqGrGdR5kAbkrQ9dPKdAz5pB6ZOn6fbPtinSEyGmLfhZ
        4mhYnFtkKkaCx13uIE276dlHDITMeWwbLA==
X-Google-Smtp-Source: ADUXVKJYHKMwd083yfZFf5LVn0ZMSIR3gfgv/mP7beqPPQWozo/zXojrMoH9JzGaYFVsyk/V/Uy4+Q==
X-Received: by 2002:a17:902:b28c:: with SMTP id u12-v6mr29513459plr.16.1530623845274;
        Tue, 03 Jul 2018 06:17:25 -0700 (PDT)
Received: from localhost.localdomain ([150.249.215.106])
        by smtp.gmail.com with ESMTPSA id 14-v6sm3664730pft.10.2018.07.03.06.17.23
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 03 Jul 2018 06:17:24 -0700 (PDT)
From:   Kana Natsuno <dev@whileimautomaton.net>
To:     git@vger.kernel.org
Cc:     Kana Natsuno <dev@whileimautomaton.net>
Subject: [PATCH 2/2] userdiff: support new keywords in PHP hunk header
Date:   Tue,  3 Jul 2018 22:15:40 +0900
Message-Id: <20180703131540.60789-3-dev@whileimautomaton.net>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20180703131540.60789-1-dev@whileimautomaton.net>
References: <20180703131540.60789-1-dev@whileimautomaton.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Recent version of PHP supports interface, trait, abstract class and
final class.  This patch fixes the PHP hunk header regexp to support
all of these keywords.

Signed-off-by: Kana Natsuno <dev@whileimautomaton.net>
---
 t/t4018/php-abstract-class | 4 ++++
 t/t4018/php-final-class    | 4 ++++
 t/t4018/php-interface      | 4 ++++
 t/t4018/php-trait          | 7 +++++++
 userdiff.c                 | 2 +-
 5 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 t/t4018/php-abstract-class
 create mode 100644 t/t4018/php-final-class
 create mode 100644 t/t4018/php-interface
 create mode 100644 t/t4018/php-trait

diff --git a/t/t4018/php-abstract-class b/t/t4018/php-abstract-class
new file mode 100644
index 0000000..5213e12
--- /dev/null
+++ b/t/t4018/php-abstract-class
@@ -0,0 +1,4 @@
+abstract class RIGHT
+{
+    const FOO = 'ChangeMe';
+}
diff --git a/t/t4018/php-final-class b/t/t4018/php-final-class
new file mode 100644
index 0000000..69f5710
--- /dev/null
+++ b/t/t4018/php-final-class
@@ -0,0 +1,4 @@
+final class RIGHT
+{
+    const FOO = 'ChangeMe';
+}
diff --git a/t/t4018/php-interface b/t/t4018/php-interface
new file mode 100644
index 0000000..86b49ad
--- /dev/null
+++ b/t/t4018/php-interface
@@ -0,0 +1,4 @@
+interface RIGHT
+{
+    public function foo($ChangeMe);
+}
diff --git a/t/t4018/php-trait b/t/t4018/php-trait
new file mode 100644
index 0000000..65b8c82
--- /dev/null
+++ b/t/t4018/php-trait
@@ -0,0 +1,7 @@
+trait RIGHT
+{
+    public function foo($ChangeMe)
+    {
+        return 'foo';
+    }
+}
diff --git a/userdiff.c b/userdiff.c
index a69241b..36af25e 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -114,7 +114,7 @@ PATTERNS("perl",
 	 "|<<|<>|<=>|>>"),
 PATTERNS("php",
 	 "^[\t ]*(((public|protected|private|static)[\t ]+)*function.*)$\n"
-	 "^[\t ]*(class.*)$",
+	 "^[\t ]*((((final|abstract)[\t ]+)?class|interface|trait).*)$",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+"
-- 
2.10.1 (Apple Git-78)

