Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10FEE1F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeJTUtY (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:49:24 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35823 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbeJTUtY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:49:24 -0400
Received: by mail-lj1-f193.google.com with SMTP id o14-v6so33123351ljj.2
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O/l2rnaRHIUY8ml5xzAxdlXbT1eyT0Ej/FGcY6v3eMc=;
        b=WKFKsfmchgjnKdIXLGQsv+3axYEz9cQW0k5gy0cRLvW/Br2HkD9GvWoS2lxCR5CMXg
         IJW4tcDP4rYMIG5IXoiEeGaSI4GkbJnc3bvjO/nrNrotDqZXIx/l8PVifeb46khbh+9V
         3giltnFbqYC53pgX6vMsi+YiMg/uvO0GiDOe7S+uQKjiqGzaP0eKGEkcGYa5ne5y9oO+
         pOriyQHDoTbA9e7Cs4coiBPIVp4GPPUFqXytLrEOjyj9BoNNh/Bwu4LibzkA9G4xuE7T
         WvD0xDtL5t2NIMBalODlATAmbEWn7j3iOia9zsU8bbv3uKbHU6Xe7tUaeyqWgnbPtaDL
         9HRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O/l2rnaRHIUY8ml5xzAxdlXbT1eyT0Ej/FGcY6v3eMc=;
        b=VXnwffFAGkSLOi1JEZNrjzJvc3cx5iLx4U5L2rjZyunvsnmZtBigVQM1n3z97KFKt/
         qKwBUXW0mryRH8kJhzux1Y1h8o9ooRC/IcCD8pJ4QINHVvP9HYr7LqL3gd97FoGXaUOk
         0S/YeS0yZ6ZhdD0+e/w+7OZZ7DWpKBDOi29jKVUO09kaWdOwAKrx+JWbu3Z9tDPgkGH5
         ge2S3aA0jGxHZWkjK84ONXyvjwca+ziEkpgZajnNeLBZZvev89c+dz+5MdAraduwvQfw
         ++eM+PxFLyslrsoqfldLFaFBIBGsnpOEqP00oqAdT2pizVWckcvU3ecOLpVk5eMlFQOg
         Ph3w==
X-Gm-Message-State: ABuFfojXQ9qUvy1vFtt7CDhx7NZu2JZDK5v7Az7V0Pa+G8Ayai4SuXc3
        yQQZ/sIhiTXLu/XJcKIqNuetJ/iD
X-Google-Smtp-Source: ACcGV61EapTF0SkR5fC/MzZ8wUDRt1Mvgz4p7G5wuAO7sgKQUneTpaQAJwJ9p/sHs1b5aaBpoQ3yvQ==
X-Received: by 2002:a2e:980f:: with SMTP id a15-v6mr27846265ljj.6.1540039142135;
        Sat, 20 Oct 2018 05:39:02 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:01 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/59] config.txt: move am.* to a separate file
Date:   Sat, 20 Oct 2018 14:37:54 +0200
Message-Id: <20181020123848.2785-6-pclouds@gmail.com>
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
 Documentation/am-config.txt | 14 ++++++++++++++
 Documentation/config.txt    | 15 +--------------
 2 files changed, 15 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/am-config.txt

diff --git a/Documentation/am-config.txt b/Documentation/am-config.txt
new file mode 100644
index 0000000000..5bcad2efb1
--- /dev/null
+++ b/Documentation/am-config.txt
@@ -0,0 +1,14 @@
+am.keepcr::
+	If true, git-am will call git-mailsplit for patches in mbox format
+	with parameter `--keep-cr`. In this case git-mailsplit will
+	not remove `\r` from lines ending with `\r\n`. Can be overridden
+	by giving `--no-keep-cr` from the command line.
+	See linkgit:git-am[1], linkgit:git-mailsplit[1].
+
+am.threeWay::
+	By default, `git am` will fail if the patch does not apply cleanly. When
+	set to true, this setting tells `git am` to fall back on 3-way merge if
+	the patch records the identity of blobs it is supposed to apply to and
+	we have those blobs available locally (equivalent to giving the `--3way`
+	option from the command line). Defaults to `false`.
+	See linkgit:git-am[1].
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5b46310dd4..29dd694438 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -295,20 +295,7 @@ include::add-config.txt[]
 
 include::alias-config.txt[]
 
-am.keepcr::
-	If true, git-am will call git-mailsplit for patches in mbox format
-	with parameter `--keep-cr`. In this case git-mailsplit will
-	not remove `\r` from lines ending with `\r\n`. Can be overridden
-	by giving `--no-keep-cr` from the command line.
-	See linkgit:git-am[1], linkgit:git-mailsplit[1].
-
-am.threeWay::
-	By default, `git am` will fail if the patch does not apply cleanly. When
-	set to true, this setting tells `git am` to fall back on 3-way merge if
-	the patch records the identity of blobs it is supposed to apply to and
-	we have those blobs available locally (equivalent to giving the `--3way`
-	option from the command line). Defaults to `false`.
-	See linkgit:git-am[1].
+include::am-config.txt[]
 
 apply.ignoreWhitespace::
 	When set to 'change', tells 'git apply' to ignore changes in
-- 
2.19.1.647.g708186aaf9

