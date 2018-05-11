Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7A6F1F42D
	for <e@80x24.org>; Fri, 11 May 2018 07:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752518AbeEKH4I (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 03:56:08 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40185 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752337AbeEKH4H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 03:56:07 -0400
Received: by mail-lf0-f65.google.com with SMTP id p85-v6so6604620lfg.7
        for <git@vger.kernel.org>; Fri, 11 May 2018 00:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ogX9p7Lb958GWrJf+XLcB4tfRY/rELjE2I4zqBeH/YY=;
        b=sNN6obzZJzctxh/zTIqoINwK2D0Dd1M14ydd0pTAvDf4hAd0wU2Npy9KLRGPtNmHm6
         c9xU0qnIgPX4+OEKmjCPdZy+KI0m6YZL2H4jQ8pH1zod3WR6kzRofcDtDhXjhYz7lyIL
         DNP7J5zgL2RFCEhtMFO2ioI+lkwnIXmjGPB9l5us4QxeoiTKYmCS3HKoGXhxiCQRFrV4
         /w7NzLSdRidAEW3l69QTZPYq41J7XxHLgXbqfDgqzWiSEB+0mBCtByRc8Viz1VAjhPYX
         h9r8HVeVJKw2kjrPXcQf7mW2ZqP6gkQP0iCyG7gozsok/BalLCtDJH73M7Vnx/D4CvmE
         ddFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ogX9p7Lb958GWrJf+XLcB4tfRY/rELjE2I4zqBeH/YY=;
        b=fMcEvb62Zn9rw1Hl/jDyeh+cie7s3NFAnMkohrOWc28962oE/ITG8BDE/E5hlqom0L
         9l4BySDkTBfn13t4hCx05XvKwFwoUdC9LukG5zEfgcTQ4vrQY7lNm2ul06A+rY586Dvi
         LIXRGmHl8kNE4jb2ALZTvTlk3M+rmiaIAlFOPnhnlQ1v4VvvjvjJ311wIpXHHK842QVL
         bldcW691B0smGQLI1RkBnPiYMoFT5jPVGZyPs3mtID0T/Nq3koUIE4G5v7TpiE8oaMMZ
         gshZ/1dT+RlXNZR5MfjLg4DDCcKA/y7d+tANsQoF7Vj1s/fYqw6UEN/ttR3h/sPN8twW
         lPlw==
X-Gm-Message-State: ALKqPwcDaUS8BbJUcCzEHIYZjky4PqxwrnrkoJxFs/SsVshJ+0yoa5Yf
        Jiu8XZcShilkFcQphb92A44v7Q==
X-Google-Smtp-Source: AB8JxZr+KmBnM7m2Bh0TG4ZCnyXEYltu4jXXkguSkXMBN8Jw9/4has0PGYE0KxJAhzUdNwQnXA0r2Q==
X-Received: by 2002:a19:a688:: with SMTP id p130-v6mr846639lfe.4.1526025366093;
        Fri, 11 May 2018 00:56:06 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r5-v6sm524766ljr.41.2018.05.11.00.56.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 May 2018 00:56:04 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] tag: fix column output not using all terminal space
Date:   Fri, 11 May 2018 09:56:02 +0200
Message-Id: <20180511075602.9182-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-tag runs a separate git-column command via run_column_filter().
This makes the new 'git-column' process fail to pick up the terminal
width for some reason and fall back to default width. Just explicitly
pass terminal width and avoid this terminal width detection business
in subprocesses.

While at there, fix an off-by-one column setting in git-column. We do
not want to use up _all_ terminal columns because the last character
is going hit the border and wrap. Keep it at term_columns() - 1 like
print_columns() does. This affects the test in t7004 because effective
column width before was 40 but now 39 so we need to adjust it back.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/column.c | 2 +-
 column.c         | 2 ++
 t/t7004-tag.sh   | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/column.c b/builtin/column.c
index 0c3223d64b..182c84f778 100644
--- a/builtin/column.c
+++ b/builtin/column.c
@@ -42,7 +42,7 @@ int cmd_column(int argc, const char **argv, const char *prefix)
 		git_config(column_config, NULL);
 
 	memset(&copts, 0, sizeof(copts));
-	copts.width = term_columns();
+	copts.width = term_columns() - 1;
 	copts.padding = 1;
 	argc = parse_options(argc, argv, "", options, builtin_column_usage, 0);
 	if (argc)
diff --git a/column.c b/column.c
index 49ab85b769..382537b324 100644
--- a/column.c
+++ b/column.c
@@ -381,6 +381,8 @@ int run_column_filter(int colopts, const struct column_options *opts)
 	argv_array_pushf(argv, "--raw-mode=%d", colopts);
 	if (opts && opts->width)
 		argv_array_pushf(argv, "--width=%d", opts->width);
+	else
+		argv_array_pushf(argv, "--width=%d", term_columns() - 1);
 	if (opts && opts->indent)
 		argv_array_pushf(argv, "--indent=%s", opts->indent);
 	if (opts && opts->padding)
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index e3f1e014aa..d7b319e919 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -363,7 +363,7 @@ test_expect_success 'tag -l <pattern> -l <pattern> works, as our buggy documenta
 '
 
 test_expect_success 'listing tags in column' '
-	COLUMNS=40 git tag -l --column=row >actual &&
+	COLUMNS=41 git tag -l --column=row >actual &&
 	cat >expected <<\EOF &&
 a1      aa1     cba     t210    t211
 v0.2.1  v1.0    v1.0.1  v1.1.3
-- 
2.17.0.705.g3525833791

