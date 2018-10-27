Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E8201F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbeJ0PEj (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:39 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38770 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbeJ0PEi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id k11-v6so3114057lja.5
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9lmZSY4pPIgPvqsCMeyE9zdPdGZxrvR/UMk6W3APXes=;
        b=QwkPagMaCek8G7d8++udMDFM1SgJtgFwcSJXjxSKN0LU1bvtlFvZAKwiyi6A5bavV5
         VzfdVyfAh1lJ3JUnTPMBwJQNs6HK1aKXfHwqV06Q9XWFcdh2jFn0BoiylKtEcW8NqC+4
         uznkCIBsDJHOBLSQ3TipQ8GTBOgJUFsEEIgYCcIL8a46SKxkUP3hbiAdsT4lq3DeY9FO
         bN4vKpccGnQK1Ew1ycclbiLi2FNH4TrBymla1OhUzczdlzGgBObzRZiQT4EaXoJxtH2+
         flxtkme82rY8QH5o87R5dC2MAt0Z9abuUZUz6ckm4srSyhCinbgx0Oe0GIp7jTZW5Axy
         bz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9lmZSY4pPIgPvqsCMeyE9zdPdGZxrvR/UMk6W3APXes=;
        b=OZnEOy11lCi18xR4gNON8ifxlICrjLl5FTkV1pc0UaQX6+yN1UmN1Ldoj7WDdAuz6x
         twIJEnHi16UEbsLVSQXxR/AodP/7q/8icYSY10FnE4INivBOnQ0Qi3gwbdYpLkMl9g0/
         qoJv9tNt9gtDh/x84Gg1W+fYxWD3AoQgj4RLzfOfHr1WRnjOOcik2CFnjd2X58lQm7S7
         O2+f9qHjY9OROn1ZxW2WFXt5CLpdOY0SsW+fiLsdDc1S8FElxrPSPngML1oh4yYpAspW
         y5sTCI200tOqsYtDL578i/gXaqoxRQLC8m8ZX5NRvFDtBNUnWIP/vOlLFJCN+kc0NYkV
         9JZA==
X-Gm-Message-State: AGRZ1gJZXUDLh6rYHhrNGhmWkjaJmG5OLJXBdr8DKfyweXq9+duCXKXN
        YzIm86vDXkBDzBsdfvHYKsUPX1aE
X-Google-Smtp-Source: AJdET5eElXs7Wz6pBzMCtdR6bEKg2cqsTDagkukbe+hYv0/KhIGuBxLpNi4B4JykeypO8nyN47S0Iw==
X-Received: by 2002:a2e:5246:: with SMTP id g67-v6mr4159030ljb.73.1540621482640;
        Fri, 26 Oct 2018 23:24:42 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:42 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 39/78] config.txt: move init.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:12 +0200
Message-Id: <20181027062351.30446-40-pclouds@gmail.com>
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
 Documentation/config.txt      | 4 +---
 Documentation/config/init.txt | 3 +++
 2 files changed, 4 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/config/init.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 03b7ac75fc..94b14af9f3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -357,9 +357,7 @@ include::config/imap.txt[]
 
 include::config/index.txt[]
 
-init.templateDir::
-	Specify the directory from which templates will be copied.
-	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
+include::config/init.txt[]
 
 instaweb.browser::
 	Specify the program that will be used to browse your working
diff --git a/Documentation/config/init.txt b/Documentation/config/init.txt
new file mode 100644
index 0000000000..46fa8c6a08
--- /dev/null
+++ b/Documentation/config/init.txt
@@ -0,0 +1,3 @@
+init.templateDir::
+	Specify the directory from which templates will be copied.
+	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
-- 
2.19.1.647.g708186aaf9

