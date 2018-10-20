Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 079F51F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeJTUuP (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:15 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43197 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeJTUuO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:14 -0400
Received: by mail-lf1-f65.google.com with SMTP id p34-v6so27138013lfg.10
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2/sNaApBIyBZ7A54y0FtXxH1ysQkFibSOpvKt+9LCN4=;
        b=N0C8FvEtjzfCiobMymiFQXWSEiYcSRmv5NedYsgpSSFzlcIiszareozbtxFDmAYuEQ
         fG3qT2RfXQjBNbQHTXL0S8je/04IXb0Jq417E17zA5mbPg5E/BwqXWX3kPCVqLGqxlgY
         H/yQtXMhmdNQNSH4CKKAwTs5aqAcGZ6GnGdoXZW0cC3MfS6uZp2bBnDxW2Lv2MBf3VxQ
         KBtMu1UVnVVuUYrT4hxFdF0w7WvTGJy3avP5WCvs1yQ54NnbvfrfOt66oTiP4tc31/N0
         +a00ydJ1WhWwQ5mg2q6ClCt1tck9cN/sCnvVFLBZ2HRcYWxJkorPPy9dlDxX00gGcTkA
         d5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2/sNaApBIyBZ7A54y0FtXxH1ysQkFibSOpvKt+9LCN4=;
        b=ge4ecncKMem95f+mInK5jCK28I8iP0gvJcih/fL3tiXC6mS+pKZKoe03KrCZ9163Ke
         EhVNM3SDYJObV2UHsbfsafEKxtkAfi9/WPjoKWTsBy7nkihUWYEn1oiVOyUoBbcC+eoP
         KXt1jiK/WtyC2myS8/BctUTvTYOAL+0fip9iSs7MevQtiVhWleAHWR8OekxYzuL9xduL
         /EX96NFw7/Bq17S44EEmoLaJkzp5pTEj2OzS2ajYHLtZuUD/DGYlXwOK3ubkU0VM8Zur
         nNHtNUZATvSCGcpkP8yMj829B4gH2j1VQzsHftgkfpguSXFNtRNGoTndN0TbMbqP5AeY
         DHxQ==
X-Gm-Message-State: ABuFfohuNt01VTEz8iG6qVxqmliNK6bsLbLk1gyJ0Zd4Jq3+x7Z0HAil
        RKqBCemrpyru0aaUk8eD7lYZnNgr
X-Google-Smtp-Source: ACcGV62kGY1TyBevL7LiXjM8jH46/LiTLGIgYF5E2VBJhUnSv/ym713/2gzrfwsSDhINfH8q7W9brg==
X-Received: by 2002:a19:5710:: with SMTP id l16-v6mr5675822lfb.71.1540039192117;
        Sat, 20 Oct 2018 05:39:52 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:51 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 36/59] config.txt: move man.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:25 +0200
Message-Id: <20181020123848.2785-37-pclouds@gmail.com>
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
 Documentation/config.txt     | 13 +------------
 Documentation/man-config.txt | 12 ++++++++++++
 2 files changed, 13 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/man-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c057a290a4..72222c113f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -620,18 +620,7 @@ include::mailinfo-config.txt[]
 
 include::mailmap-config.txt[]
 
-man.viewer::
-	Specify the programs that may be used to display help in the
-	'man' format. See linkgit:git-help[1].
-
-man.<tool>.cmd::
-	Specify the command to invoke the specified man viewer. The
-	specified command is evaluated in shell with the man page
-	passed as argument. (See linkgit:git-help[1].)
-
-man.<tool>.path::
-	Override the path for the given tool that may be used to
-	display help in the 'man' format. See linkgit:git-help[1].
+include::man-config.txt[]
 
 include::merge-config.txt[]
 
diff --git a/Documentation/man-config.txt b/Documentation/man-config.txt
new file mode 100644
index 0000000000..a727d987a8
--- /dev/null
+++ b/Documentation/man-config.txt
@@ -0,0 +1,12 @@
+man.viewer::
+	Specify the programs that may be used to display help in the
+	'man' format. See linkgit:git-help[1].
+
+man.<tool>.cmd::
+	Specify the command to invoke the specified man viewer. The
+	specified command is evaluated in shell with the man page
+	passed as argument. (See linkgit:git-help[1].)
+
+man.<tool>.path::
+	Override the path for the given tool that may be used to
+	display help in the 'man' format. See linkgit:git-help[1].
-- 
2.19.1.647.g708186aaf9

