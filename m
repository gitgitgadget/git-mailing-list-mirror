Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCB881F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbeJTUtq (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:49:46 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37870 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbeJTUtq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:49:46 -0400
Received: by mail-lj1-f195.google.com with SMTP id 63-v6so33122042ljs.4
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ZjnXr0QrGlwOcbqQy9O96Rrb9/u4acirWtkEB9+97c=;
        b=ira4ykyyQY1Ic41raEZQ2C2juwGgsutjHMZjDhG9c502htvrtLN88P12ebWguEFOxV
         B2qiw6y0RRu2YsBD/5f2lkBYaQnZUt4YWbPGx0dChAYX+DrrvG+ErRkwmm/6Q3igbGeg
         0WSX2TStFelcxKc5Vx8OnVWEcGghbaveGNC4z5BfwqgAotDf6o1ckWDbag1Y7s0Uwkif
         YtzVxAX8NQg8cX0++pDmm2sRrU8fe/274/Y/KiTJV4vrGflIM0W16oFtqiWB0QxKs7ax
         mtYcKgymdpETDpTy/DYOO/16+xHOGCnKKhUAMIG96/yw1sJTf9yo8l4lVMUJjAcJ36BL
         aIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ZjnXr0QrGlwOcbqQy9O96Rrb9/u4acirWtkEB9+97c=;
        b=LuYjWUl6qbtoW1LCauYXVk4HUMeBBF5OIIK7g16MgdhWk/6TTVhiGLkMqvCc9e/vyj
         s/IPCzjFbsnIv8mBg0v1bMb8IbpUYgAKtWeWiMSWrg8F1eni7htYznJs4h5YGUwD8nrj
         bXnIaP6jwvGWhztb07SqLF64uZaBHKPXCvXMy8dYyseIaqheLoh7HUt/Hn//dS27UPaw
         UXVrsCB7fbZVpDKmxYcnNzxv2y7d3z/VUrTZy9bFASAnnqM9dWdvOd/8AtMvQbjYtZye
         4kFIVqqubtUzTgpxJ6FN7TMIFViqWphwlJNYhGjh5KpJppqulQ3OF8nNE841wyoHankt
         /jdw==
X-Gm-Message-State: ABuFfoh8K/CwUd2nC7aHpYQh4N8LRzRPxPmpirXz//5aOJKYK61y8QGn
        vfkAOQ/Gjq1mmjthc4c7BgHyFgOS
X-Google-Smtp-Source: AJdET5cWgKcgWMQkn443AoUYDXtAbuMT1CqAtCMcyPMyd8MnANfE63DixAg45Ul+WCvCxVhqHy2Whw==
X-Received: by 2002:a2e:7217:: with SMTP id n23-v6mr3464054ljc.71.1540039163679;
        Sat, 20 Oct 2018 05:39:23 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:22 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 22/59] config.txt: move gitweb.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:11 +0200
Message-Id: <20181020123848.2785-23-pclouds@gmail.com>
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
 Documentation/config.txt        | 17 +----------------
 Documentation/gitweb-config.txt | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/gitweb-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ebef3c867a..6898c9f567 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -337,22 +337,7 @@ include::gc-config.txt[]
 
 include::gitcvs-config.txt[]
 
-gitweb.category::
-gitweb.description::
-gitweb.owner::
-gitweb.url::
-	See linkgit:gitweb[1] for description.
-
-gitweb.avatar::
-gitweb.blame::
-gitweb.grep::
-gitweb.highlight::
-gitweb.patches::
-gitweb.pickaxe::
-gitweb.remote_heads::
-gitweb.showSizes::
-gitweb.snapshot::
-	See linkgit:gitweb.conf[5] for description.
+include::gitweb-config.txt[]
 
 grep.lineNumber::
 	If set to true, enable `-n` option by default.
diff --git a/Documentation/gitweb-config.txt b/Documentation/gitweb-config.txt
new file mode 100644
index 0000000000..1b51475108
--- /dev/null
+++ b/Documentation/gitweb-config.txt
@@ -0,0 +1,16 @@
+gitweb.category::
+gitweb.description::
+gitweb.owner::
+gitweb.url::
+	See linkgit:gitweb[1] for description.
+
+gitweb.avatar::
+gitweb.blame::
+gitweb.grep::
+gitweb.highlight::
+gitweb.patches::
+gitweb.pickaxe::
+gitweb.remote_heads::
+gitweb.showSizes::
+gitweb.snapshot::
+	See linkgit:gitweb.conf[5] for description.
-- 
2.19.1.647.g708186aaf9

