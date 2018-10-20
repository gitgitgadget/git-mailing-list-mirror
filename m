Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 412901F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeJTUuH (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:07 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39228 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeJTUuG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:06 -0400
Received: by mail-lj1-f195.google.com with SMTP id p1-v6so33094323ljg.6
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q9WWmR8nZyxJUY86EZUHofEX9Rtsin489A2I8rnCcYU=;
        b=I+2JHAJ85ZySn8mYQ991nVwI2Cozoj5cckkim5VYMIlCG75n2/fPmlg3QqAKN0pJJd
         Ao6xtrtSthbly9E5o7nG06S6oDtQx6q8Uh/cyFu6uoqe385mQeztTx3VJC626duUFoFr
         rhTNVMxgbugmDf+cUU6svAxluwRbWhEKAwQyRRflqPwY3OeExHCftsQwSD3+FFIKgvYk
         AWIPJ7rVrSBsCSptOdKzrNgWAjCLK7Zqk7ovKH0BpkuQb6wsXz3/GXQB29zdfe9qG6de
         +JyjK/drMIXCN0oT7tdB7wMtRhibEMn5LzVymlXYm+Lidiux89H9k71ftbTrxf+ZhN8A
         XSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q9WWmR8nZyxJUY86EZUHofEX9Rtsin489A2I8rnCcYU=;
        b=WvL/k+Gid2Sk3URYgCbUdC61aj9FMqVKIwYbeGGUXuSibEreIa3gV2rB6mp8oEfvzI
         TPxietZAUhKsDz1dhwzH2NW9A4yaSJS4QoeKZrF2TH6CHx5DN9P8zzc7x35WZe+YgeDV
         PNe3g36DR7C4wPlqrYe4Is6QjxCQz5O8hBudH8Lb9MW762k/mSm3YizQ3LAa8g7OAZOJ
         Hg/9ZaiN4yJEVkt92XUFoDRxaoYuMl5IqDS0uq77gFczmzFDkghhBon717Xs4Kgyi936
         2W/2hYmolU2P3h7Npadm+83lmOio5xrKvyd+5EbVt7IlEWfUAESeSWjgShaN37vX1udf
         tG3A==
X-Gm-Message-State: AGRZ1gIwpdCrfjF7FA502qVDfD16Ct7atP2+FF1JZKFLGuDNB8X5Y3cC
        qgtSs3Cdr/JLOuj2LyaMWtcfotRa
X-Google-Smtp-Source: ACcGV61D9jNar2SXcFlSSFcJiqm7PZr5s1UMTif5v38MVjlJoU+X66lokDpld97HaJx3oYoHYJgj8A==
X-Received: by 2002:a2e:574f:: with SMTP id r15-v6mr7507786ljd.106.1540039184609;
        Sat, 20 Oct 2018 05:39:44 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:44 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 31/59] config.txt: move instaweb.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:20 +0200
Message-Id: <20181020123848.2785-32-pclouds@gmail.com>
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
 Documentation/config.txt          | 21 +--------------------
 Documentation/instaweb-config.txt | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/instaweb-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c91dc2ceef..2d60aead5d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -610,26 +610,7 @@ include::index-config.txt[]
 
 include::init-config.txt[]
 
-instaweb.browser::
-	Specify the program that will be used to browse your working
-	repository in gitweb. See linkgit:git-instaweb[1].
-
-instaweb.httpd::
-	The HTTP daemon command-line to start gitweb on your working
-	repository. See linkgit:git-instaweb[1].
-
-instaweb.local::
-	If true the web server started by linkgit:git-instaweb[1] will
-	be bound to the local IP (127.0.0.1).
-
-instaweb.modulePath::
-	The default module path for linkgit:git-instaweb[1] to use
-	instead of /usr/lib/apache2/modules.  Only used if httpd
-	is Apache.
-
-instaweb.port::
-	The port number to bind the gitweb httpd to. See
-	linkgit:git-instaweb[1].
+include::instaweb-config.txt[]
 
 interactive.singleKey::
 	In interactive commands, allow the user to provide one-letter
diff --git a/Documentation/instaweb-config.txt b/Documentation/instaweb-config.txt
new file mode 100644
index 0000000000..50cb2f7d62
--- /dev/null
+++ b/Documentation/instaweb-config.txt
@@ -0,0 +1,20 @@
+instaweb.browser::
+	Specify the program that will be used to browse your working
+	repository in gitweb. See linkgit:git-instaweb[1].
+
+instaweb.httpd::
+	The HTTP daemon command-line to start gitweb on your working
+	repository. See linkgit:git-instaweb[1].
+
+instaweb.local::
+	If true the web server started by linkgit:git-instaweb[1] will
+	be bound to the local IP (127.0.0.1).
+
+instaweb.modulePath::
+	The default module path for linkgit:git-instaweb[1] to use
+	instead of /usr/lib/apache2/modules.  Only used if httpd
+	is Apache.
+
+instaweb.port::
+	The port number to bind the gitweb httpd to. See
+	linkgit:git-instaweb[1].
-- 
2.19.1.647.g708186aaf9

