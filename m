Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 654C91F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeJTUuh (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:37 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36898 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbeJTUuh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:37 -0400
Received: by mail-lj1-f196.google.com with SMTP id 63-v6so33123096ljs.4
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A+fZ2W1DKO1AQPA9KQk4WC+0KJbobMi+X7yIJnxUiZQ=;
        b=KI9pxyuGborZZgUYOui+ADqiGX7z2GFy1XIXB5Fd/wf4vhUUuXrSjaB9LncyabF+SK
         VVIe/XjeKv1VifDainIojlq7yffgE5MKjeIPy7nnx65LGpxcPWddbR9FyHHVBRA7ELDw
         SS30s5dz2+QAJMuKMUgQV7P0fLfx1zgKHWe9CiXHRGx9kKx4Oa3OCQRqs3JADh4wjr7c
         ou5nfI/dsXy+7UanHlgBQNKYx7qbSG7vC1ExiPxdrOWy/auDQTepayiF+iJeByMj5Qcy
         STZJ+xj2cV82DAG+xUdbzk1Nf/vV0nKRK74vVeEuRj090H+Sl37lA9uZ2r53YmJdWNnd
         TJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A+fZ2W1DKO1AQPA9KQk4WC+0KJbobMi+X7yIJnxUiZQ=;
        b=PVtmmdZ/59xUKlcjWEPlk6p2BWpjULlCoGOTUQ1QSBHTlEoczH5kSkd6Uo3mNV1MKZ
         XJKODWYDEBoxvkeUVME/P3YbcgkxLB22CF541pXCOzisk8S+M5PU4qNJPe+v+ssUQ45s
         VbYLt011Z2PZRl/XJ/hs8c6kfWeRRGoyPa3PYVHJDI0xMyo0kXlkequ2u92Y16rtsBpR
         z0NubwuiXAKGZdMdS50ioZtg5Mgvu9vZRWitr8aMGmt29ezfevOvNDNf3ech6dWRYGqZ
         t+40gKtKxDD9KsGEXZuvU/1Ttf1c03JwNRsKDt28T6yg/IAYmXMB4syhd45/zs2dEoxu
         HxHA==
X-Gm-Message-State: ABuFfohgHw2me6tPZi8Nai3ilyPlPUs8BAV/A5WBTYBR9EOQBQQxzMnQ
        MeYs507CMTxVt+gUiQ8hSD5Qe/3o
X-Google-Smtp-Source: ACcGV603lZqM+O8xR1RfLGndz98KgSGaIOcciPn9XNaYcQioAP3tdLYALZ6sGxI63AyEaqMHHhrwDg==
X-Received: by 2002:a2e:9b8a:: with SMTP id z10-v6mr8637883lji.55.1540039214621;
        Sat, 20 Oct 2018 05:40:14 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.40.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:40:14 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 49/59] config.txt: move splitIndex.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:38 +0200
Message-Id: <20181020123848.2785-50-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181020123848.2785-1-pclouds@gmail.com>
References: <20181020123848.2785-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt            | 25 +------------------------
 Documentation/splitindex-config.txt | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/splitindex-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6136c5638c..2330acd840 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -658,30 +658,7 @@ include::sequencer-config.txt[]
 
 include::showbranch-config.txt[]
 
-splitIndex.maxPercentChange::
-	When the split index feature is used, this specifies the
-	percent of entries the split index can contain compared to the
-	total number of entries in both the split index and the shared
-	index before a new shared index is written.
-	The value should be between 0 and 100. If the value is 0 then
-	a new shared index is always written, if it is 100 a new
-	shared index is never written.
-	By default the value is 20, so a new shared index is written
-	if the number of entries in the split index would be greater
-	than 20 percent of the total number of entries.
-	See linkgit:git-update-index[1].
-
-splitIndex.sharedIndexExpire::
-	When the split index feature is used, shared index files that
-	were not modified since the time this variable specifies will
-	be removed when a new shared index file is created. The value
-	"now" expires all entries immediately, and "never" suppresses
-	expiration altogether.
-	The default value is "2.weeks.ago".
-	Note that a shared index file is considered modified (for the
-	purpose of expiration) each time a new split-index file is
-	either created based on it or read from it.
-	See linkgit:git-update-index[1].
+include::splitindex-config.txt[]
 
 include::ssh-config.txt[]
 
diff --git a/Documentation/splitindex-config.txt b/Documentation/splitindex-config.txt
new file mode 100644
index 0000000000..afdb186df8
--- /dev/null
+++ b/Documentation/splitindex-config.txt
@@ -0,0 +1,24 @@
+splitIndex.maxPercentChange::
+	When the split index feature is used, this specifies the
+	percent of entries the split index can contain compared to the
+	total number of entries in both the split index and the shared
+	index before a new shared index is written.
+	The value should be between 0 and 100. If the value is 0 then
+	a new shared index is always written, if it is 100 a new
+	shared index is never written.
+	By default the value is 20, so a new shared index is written
+	if the number of entries in the split index would be greater
+	than 20 percent of the total number of entries.
+	See linkgit:git-update-index[1].
+
+splitIndex.sharedIndexExpire::
+	When the split index feature is used, shared index files that
+	were not modified since the time this variable specifies will
+	be removed when a new shared index file is created. The value
+	"now" expires all entries immediately, and "never" suppresses
+	expiration altogether.
+	The default value is "2.weeks.ago".
+	Note that a shared index file is considered modified (for the
+	purpose of expiration) each time a new split-index file is
+	either created based on it or read from it.
+	See linkgit:git-update-index[1].
-- 
2.19.1.647.g708186aaf9

