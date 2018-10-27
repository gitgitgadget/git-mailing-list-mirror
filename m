Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04D9A1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbeJ0PEC (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:02 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37844 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbeJ0PD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:03:59 -0400
Received: by mail-lf1-f65.google.com with SMTP id a82-v6so2479661lfa.4
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6U/sfe/BuNGpP2atgJUU58rC/jyasVzEda2nDcz4N0w=;
        b=TVPJoOsWugkdkRXBLkZ2QRKTJgMG1KB+JwrFv2LGVWmpidcus/ME/+Zfhut7FGja0C
         HM44Pyi6Mu51+oFZ+4M+jZotGsELDDOOEzlGAY3rFPCyHuRvB7krgb15+hrG7F5gwXhD
         sfPdIfFs1PruynIPBUk/dlBOrmZEZAw2191FHml0hCzfoWor7OBsKwJAEIK8PhSpR+vT
         LkZKyYTKTpuxVX/1kk0epxyr89Z97eVmWJdb67VyHgJ3qmiH8cYmT9C2BSU3+9Gyeba3
         o+pfWEXTxd0uMc6m3SixbgAhUfOKrQSokFJ5ijhMiRIo21F6f5LXebY/nSvteyM43sXg
         UQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6U/sfe/BuNGpP2atgJUU58rC/jyasVzEda2nDcz4N0w=;
        b=E7Ze6drW6Xbq/dPzFuhe3Ifbn2ZraqfCMgsnuFeYWREuPf4sdq2hr0suqUX3lw8ulw
         FvHbJ8TxkmPtVgZXerdcIIbEp7kft4a5fav3S+IXzT4APegIB2WQXQy0SXykp/tgjLQ/
         GaNdkRFAUD7Df1Io76xr9jzOtxlt/avqsak9+lmUeMNYrvUNvUslZeOmRVycQ8z9SSdh
         PhZKeMBbfKm0Djwyg6vwySwhyjRrm4nRETjahY9f9+ZhVZLkExjJ1CF85NtfR51SvsVD
         n3OkbGpqE5w3qkh26XjaHpg7mHJk4mj8p6hC2hhnhkitfYWo/SzuaXbO/IivStTRDgLA
         N5Gg==
X-Gm-Message-State: AGRZ1gIJM4DZfZdOeofOTqyIlrH6o9nH1UqWgGzrPLri2ITVujbapI/q
        TDD3TOUuXYMOQqEwRQqmmg/dYVd9
X-Google-Smtp-Source: AJdET5eZG9bLaOnmZn4nojdobhyd8LeCLRA2EI0idWsWYdjhLxGyEQylw9gmuP4uctCiRbKHH+Mh6w==
X-Received: by 2002:a19:6e0b:: with SMTP id j11-v6mr3665064lfc.118.1540621444132;
        Fri, 26 Oct 2018 23:24:04 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:03 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/78] config.txt: move apply.* to a separate file
Date:   Sat, 27 Oct 2018 08:22:40 +0200
Message-Id: <20181027062351.30446-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027062351.30446-1-pclouds@gmail.com>
References: <20181027062351.30446-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt       | 12 +-----------
 Documentation/config/apply.txt | 11 +++++++++++
 2 files changed, 12 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/config/apply.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5e0f76fc6e..c8d20227a8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -297,17 +297,7 @@ include::config/alias.txt[]
 
 include::config/am.txt[]
 
-apply.ignoreWhitespace::
-	When set to 'change', tells 'git apply' to ignore changes in
-	whitespace, in the same way as the `--ignore-space-change`
-	option.
-	When set to one of: no, none, never, false tells 'git apply' to
-	respect all whitespace differences.
-	See linkgit:git-apply[1].
-
-apply.whitespace::
-	Tells 'git apply' how to handle whitespaces, in the same way
-	as the `--whitespace` option. See linkgit:git-apply[1].
+include::config/apply.txt[]
 
 blame.blankBoundary::
 	Show blank commit object name for boundary commits in
diff --git a/Documentation/config/apply.txt b/Documentation/config/apply.txt
new file mode 100644
index 0000000000..8fb8ef763d
--- /dev/null
+++ b/Documentation/config/apply.txt
@@ -0,0 +1,11 @@
+apply.ignoreWhitespace::
+	When set to 'change', tells 'git apply' to ignore changes in
+	whitespace, in the same way as the `--ignore-space-change`
+	option.
+	When set to one of: no, none, never, false tells 'git apply' to
+	respect all whitespace differences.
+	See linkgit:git-apply[1].
+
+apply.whitespace::
+	Tells 'git apply' how to handle whitespaces, in the same way
+	as the `--whitespace` option. See linkgit:git-apply[1].
-- 
2.19.1.647.g708186aaf9

