Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 272841F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeJTUt5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:49:57 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40463 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbeJTUt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:49:56 -0400
Received: by mail-lf1-f66.google.com with SMTP id n3-v6so277337lfe.7
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GO1QHN01H56hz9fSYQsF0Cbs+1gK4YWKnXuQJkoyZqQ=;
        b=SOgoiFtpoR9AKdas3aRRkkDZp1UDAD1X84tzUjVXviPMT3eRWeSNXFI/mPPcfzYWA+
         SttcQxmxbDuYaRf9gkp6WPkpOFb1bNKW125EInGtNFYzh6f3WqyUfV45xhdnk4QvYkV9
         7CrJpg2FQDGObe1jraV4MF7cqYs3bVgr6bbTkFIOxLzeZ3vvfUh3xWq6PRrEP+bthW+4
         1Xid5h8tfQBBCwon1JNoEnzhC+lcfSScxbtyBYFIKMv7vsvr4hhdsElAjmSN1McCp5xV
         tx9i0F7RB1i1aFrp/hrFGlT+1SxJfoiC0ndlr5Xex1O6RyY2lnX8g+PibElUXyi5Bcr0
         VLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GO1QHN01H56hz9fSYQsF0Cbs+1gK4YWKnXuQJkoyZqQ=;
        b=f5wQrBSDWI1jzbP8+Ygb7By1wL2mKokSd1PjIv0zL1rcqNAj1U9FyQ1ZvkEj+ZalB7
         NtaI0S3Gaviu64bffAPU9R9vDuY/7JSsHHsD/RbGbq27++qmHO0D7HogY99hXsRwmq+D
         XEWbgiNj2QCeWn8Gz5RfGj4yBosHk+jgqVGL1oP9+jIH2uPxl3CIxGlb7T6b2nsSu6KI
         wHMNBBFsgcXXqZNOJn2fz4xorwgEWDSU49mEUzpyzY5Og8eS/Stqw6CKTCwulWlwEdnY
         jX6c9HxWzjl+qgS3db0Q2TaLFLZ7RV8MspRD89+KC9Yjj8NRHS50TFdxw0ijs3B6h4Fv
         xHAw==
X-Gm-Message-State: ABuFfohLj19dGqemxbjJQoB4l7HGQHIptSj7oC8VvXb6HAMOm/7jm1Pm
        Xyg8pKQynxlLMwx9+XGKyrg3OhSh
X-Google-Smtp-Source: ACcGV63HLFQf7JGOu9fEZgUrj01THMNraS2XhVC5ZTYJZ4BucbzhUwV0VPc3R/CZsUJl/BXchf8eug==
X-Received: by 2002:a19:2583:: with SMTP id l125-v6mr5496851lfl.73.1540039174130;
        Sat, 20 Oct 2018 05:39:34 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:33 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 26/59] config.txt: move help.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:15 +0200
Message-Id: <20181020123848.2785-27-pclouds@gmail.com>
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
 Documentation/config.txt      | 24 +-----------------------
 Documentation/help-config.txt | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/help-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 93ec85ab6e..bb49f4c894 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -347,29 +347,7 @@ include::gui-config.txt[]
 
 include::guitool-config.txt[]
 
-help.browser::
-	Specify the browser that will be used to display help in the
-	'web' format. See linkgit:git-help[1].
-
-help.format::
-	Override the default help format used by linkgit:git-help[1].
-	Values 'man', 'info', 'web' and 'html' are supported. 'man' is
-	the default. 'web' and 'html' are the same.
-
-help.autoCorrect::
-	Automatically correct and execute mistyped commands after
-	waiting for the given number of deciseconds (0.1 sec). If more
-	than one command can be deduced from the entered text, nothing
-	will be executed.  If the value of this option is negative,
-	the corrected command will be executed immediately. If the
-	value is 0 - the command will be just shown but not executed.
-	This is the default.
-
-help.htmlPath::
-	Specify the path where the HTML documentation resides. File system paths
-	and URLs are supported. HTML pages will be prefixed with this path when
-	help is displayed in the 'web' format. This defaults to the documentation
-	path of your Git installation.
+include::help-config.txt[]
 
 http.proxy::
 	Override the HTTP proxy, normally configured using the 'http_proxy',
diff --git a/Documentation/help-config.txt b/Documentation/help-config.txt
new file mode 100644
index 0000000000..224bbf5a28
--- /dev/null
+++ b/Documentation/help-config.txt
@@ -0,0 +1,23 @@
+help.browser::
+	Specify the browser that will be used to display help in the
+	'web' format. See linkgit:git-help[1].
+
+help.format::
+	Override the default help format used by linkgit:git-help[1].
+	Values 'man', 'info', 'web' and 'html' are supported. 'man' is
+	the default. 'web' and 'html' are the same.
+
+help.autoCorrect::
+	Automatically correct and execute mistyped commands after
+	waiting for the given number of deciseconds (0.1 sec). If more
+	than one command can be deduced from the entered text, nothing
+	will be executed.  If the value of this option is negative,
+	the corrected command will be executed immediately. If the
+	value is 0 - the command will be just shown but not executed.
+	This is the default.
+
+help.htmlPath::
+	Specify the path where the HTML documentation resides. File system paths
+	and URLs are supported. HTML pages will be prefixed with this path when
+	help is displayed in the 'web' format. This defaults to the documentation
+	path of your Git installation.
-- 
2.19.1.647.g708186aaf9

