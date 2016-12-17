Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DB191FF76
	for <e@80x24.org>; Sat, 17 Dec 2016 14:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757715AbcLQO4U (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 09:56:20 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34676 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756968AbcLQO4S (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 09:56:18 -0500
Received: by mail-wm0-f65.google.com with SMTP id g23so10603650wme.1
        for <git@vger.kernel.org>; Sat, 17 Dec 2016 06:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jE9ECWTwW5/yUAJrnidAdeF+KZfKnBnMnv2ODT31bEI=;
        b=nki1JP5c8w+9cYcyz5ZboFq9nguw/9F2eTl5paCF1vfPZPL+Vw4rLVOjC7t907ISio
         aK/oaKH6SJ1k6zA6GPFU4S1S+fAO6weODq2woi2L9Q2dkbAXKI05Eu5VYifIvI6dkXa6
         EGQ+9QCkXyRF0jFlYPnV1VDRvOVaYx8kgb/Y50WQFkMXZmZKztkuYisGb854WUyQFhos
         GkPOw91MvwoteIcvIn1gcFJkzBczZiGUDd8flCzJh7Xh0S15GxIL74NK2ob6JN508Lds
         dZ7Bofp6NZpoLR9Eq1QNtsxY7cKJGdaOMBZhZHCgdxxUWUU0YFz1uiYgUjxPaTw8bGMo
         2BGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jE9ECWTwW5/yUAJrnidAdeF+KZfKnBnMnv2ODT31bEI=;
        b=fLnqYE7so7s3HTFUIlbx9Um14xcjL1k+2JDfFyWt5gGLIg2x/GwDZOdjXizLU64sRB
         QrAocVhlLuanLs1IbHiJF22TGwY/4Iw/HV1QCxfRPDCHuKGie2eJa4rM71i6IXnn4Hp+
         Q1UA4rxVFv9ABNud31y7lHlobXb071F5DNO9Qg6MTDQGGMdpAwa+V5S07/dvM501Xo7b
         PkV0k57rJQorrQiQnlHeYhoTwSDMDyoM2+/oLQ0IKqXE7Cj+Z7z3oy9eiknOd13+vG6s
         oE+Yfky8gFIas214oOa4rByqp8Ye7mxFNI45byuj+pLI3vOYlGdtFvKJ61ZJyp8epJUG
         yjwg==
X-Gm-Message-State: AIkVDXLxXqK1lzGTqdIPvJeQBRigcdlmkHjanQkg4VVykodnAkInMv2xPGfxM/84qThESA==
X-Received: by 10.28.21.1 with SMTP id 1mr7853096wmv.133.1481986576686;
        Sat, 17 Dec 2016 06:56:16 -0800 (PST)
Received: from localhost.localdomain (85.198.126.78.rev.sfr.net. [78.126.198.85])
        by smtp.gmail.com with ESMTPSA id y4sm11823449wjp.0.2016.12.17.06.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Dec 2016 06:56:16 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 12/21] Documentation/config: add splitIndex.maxPercentChange
Date:   Sat, 17 Dec 2016 15:55:38 +0100
Message-Id: <20161217145547.11748-13-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.49.g2414764.dirty
In-Reply-To: <20161217145547.11748-1-chriscool@tuxfamily.org>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index dc44d8a417..08f638c65c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2763,6 +2763,19 @@ showbranch.default::
 	The default set of branches for linkgit:git-show-branch[1].
 	See linkgit:git-show-branch[1].
 
+splitIndex.maxPercentChange::
+	When the split index feature is used, this specifies the
+	percent of entries the split index can contain compared to the
+	whole number of entries in both the split index and the shared
+	index before a new shared index is written.
+	The value should be between 0 and 100. If the value is 0 then
+	a new shared index is always written, if it is 100 a new
+	shared index is never written.
+	By default the value is 20, so a new shared index is written
+	if the number of entries in the split index would be greater
+	than 20 percent of the total number of entries.
+	See linkgit:git-update-index[1].
+
 status.relativePaths::
 	By default, linkgit:git-status[1] shows paths relative to the
 	current directory. Setting this variable to `false` shows paths
-- 
2.11.0.49.g2414764.dirty

