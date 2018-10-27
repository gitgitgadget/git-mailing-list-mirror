Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB6831F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbeJ0PEb (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:31 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38760 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbeJ0PEa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:30 -0400
Received: by mail-lj1-f195.google.com with SMTP id k11-v6so3113902lja.5
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tQc5uEvZzisxb2oXRlmo5DlAx8q00fmVbSP1wi/W+is=;
        b=clMcLGqGh6m5B2YJJy1OoIbimvk9pk0apFoVMzOxIJzQBYNZRlhXgohxbBC3NRvA6q
         h+Dr9IUBpVRAwNTMFVqc5//eIykwzwf/xGXxYrOQLMtuZs9as+Nz8+WWIoAyS12c79rB
         mJ07/XQ2aeloAboLstTIpwBaHisxP4yrTMXTF069umSLK0G+gNM5WyXoTGgvVRxJN1Ao
         G8VV3x161saKyn9qKJhauMRMMzxUGX7N3HIj0HFwDnGmkWnYfVI6fLiFF0AGIJmrXBf3
         2xXV4LZ6CgnoI+/wXr6OSzgTOfQW+dT8Dy/z8v5ZkGDTJWXCV3aGkIkVP6ho5v4rCtx6
         pdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tQc5uEvZzisxb2oXRlmo5DlAx8q00fmVbSP1wi/W+is=;
        b=H33Jhi6m2a64JpD+hsbXy+rw4mk7XK57YMoe+TdHCl1RhyEphuNvESG5fOp0Zlcef1
         9FrwYqbWqjWu1qQaZmboLRzak1wThIx4OiObCeKo07VqNJGqLKYSprm4O3aHt8nfUp2B
         Q3A1/pxniDfxPdaO46Qej6vyWR8j+fVEFC9xGEroEKz/2pL19vg8RbiB/WDr8a+J/F1y
         XSY1eAH03ckpRdoH3zDdjOrs67HV/7MDD/WuhfV9Dd1K0opqlRE3y0dlryGoXM0r29jO
         jOmx268ftE94RtAJBqt7cUsgdE4IJJRXL87Q3msvkwbV5B9gYedwzyZ/xMHBHTKMldwU
         UCrA==
X-Gm-Message-State: AGRZ1gJFyAEFSZ5VWoRywpEmdBLsIwa4BZB8BQzU5Y/CgTO6kcRGft2Y
        hZYSpcoFLQKAu1Eobkpl7Ef9eHI0
X-Google-Smtp-Source: AJdET5eAbqpmGhONGuuq8Jo/ZAEaIMHexgG6t0eQQH/72Xs4NJA3zHVrrZxA7Z3ru7+ZvfY7RtVZ9A==
X-Received: by 2002:a2e:5b1d:: with SMTP id p29-v6mr4156779ljb.176.1540621474529;
        Fri, 26 Oct 2018 23:24:34 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:33 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 33/78] config.txt: move help.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:06 +0200
Message-Id: <20181027062351.30446-34-pclouds@gmail.com>
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
 Documentation/config.txt      | 24 +-----------------------
 Documentation/config/help.txt | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/config/help.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index dda5812a8a..ba3b775fb0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -347,29 +347,7 @@ include::config/gui.txt[]
 
 include::config/guitool.txt[]
 
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
+include::config/help.txt[]
 
 http.proxy::
 	Override the HTTP proxy, normally configured using the 'http_proxy',
diff --git a/Documentation/config/help.txt b/Documentation/config/help.txt
new file mode 100644
index 0000000000..224bbf5a28
--- /dev/null
+++ b/Documentation/config/help.txt
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

