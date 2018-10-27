Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 744C61F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbeJ0PE1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:27 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33842 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbeJ0PEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:25 -0400
Received: by mail-lf1-f67.google.com with SMTP id n26-v6so2495204lfl.1
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rlYYof9FY3FhCHsoTeOe9UWUQPHGi/7JNYHj7JPUmxY=;
        b=sUHG/Jj94jI09leXNdonYJ8flx2Tnlr9XyMotUy4G773iEtHb5FG9uBGVudrK1pgKr
         yG84sLaF/V1RHKYhEK2ygZcKdpuMeNgbU3Szx3wcpPXYDd5n1KWbkOa0bKnQ50bDgr8x
         VCn454ODVK3RuNUHvKSEqquuxLyma+Y7rLvvzkdnrdWI0Vlb8QwNRbGYHgifzHdyL6Ua
         Z6fFy7HGvmKUAUutKfxSmRbjCYxA6uK+Aftv3TZkRGI0lP3eyyJN+hG+Z1FctFWGaqKJ
         IoZoqSeP2nfmVyeABehQqOAlbafma8/sPjcbdZL7m/TgkYq/CJow/GTF1a3r6/SRVasE
         kO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rlYYof9FY3FhCHsoTeOe9UWUQPHGi/7JNYHj7JPUmxY=;
        b=jNFbjwkGbLCKmicoB+/i/yQ2PQ+YeAtDJ4viK5pEi1uQOpQR5zMiZVsDpuGna2Hf+l
         ku8gZ+K9dyvQVIY8Z8vr8DeZZrrLpRTo3pUeiyjMpCAldsbndCV4q1b5fG7Zu/C9ua0g
         be1B9BDVwVGKgziWZa4KI3UjYLOvOI4DBLUR4qpbaiVStIte9+pXCFXzxKQptR/f3w1r
         Ud7sYymCU31GYtB9rXDdlLHFuxC3bo/I0JbR76LJpTY9uen2f2PffzmJH5/Z78kZAIzs
         5EYMxhCqHbX5zuIddLuUpOwCKXS8vaRshebfvaHNkmGTpNXxiv+KfFXJJxTD+7L2q6y2
         Iu8A==
X-Gm-Message-State: AGRZ1gInk+ANFLTvtCVrnN87gjPIprSu3BmZaLOhtO6w2AgLUBywxk/R
        vTL1v0mwfxqlUxjDDTtU/aRtkein
X-Google-Smtp-Source: AJdET5cDTP4NgEvCjN/uH/YXtrxsB1ExazPKobxC2HYgSF981X5UwbMQnGAk39Yw3VNByPz6GMLulQ==
X-Received: by 2002:a19:d612:: with SMTP id n18-v6mr3675605lfg.4.1540621470505;
        Fri, 26 Oct 2018 23:24:30 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:29 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 29/78] config.txt: move grep.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:02 +0200
Message-Id: <20181027062351.30446-30-pclouds@gmail.com>
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
 Documentation/config.txt      | 25 +------------------------
 Documentation/config/grep.txt | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/config/grep.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 99ac8fc8ec..177fefc83c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -339,30 +339,7 @@ include::config/gitcvs.txt[]
 
 include::config/gitweb.txt[]
 
-grep.lineNumber::
-	If set to true, enable `-n` option by default.
-
-grep.column::
-	If set to true, enable the `--column` option by default.
-
-grep.patternType::
-	Set the default matching behavior. Using a value of 'basic', 'extended',
-	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
-	`--fixed-strings`, or `--perl-regexp` option accordingly, while the
-	value 'default' will return to the default matching behavior.
-
-grep.extendedRegexp::
-	If set to true, enable `--extended-regexp` option by default. This
-	option is ignored when the `grep.patternType` option is set to a value
-	other than 'default'.
-
-grep.threads::
-	Number of grep worker threads to use.
-	See `grep.threads` in linkgit:git-grep[1] for more information.
-
-grep.fallbackToNoIndex::
-	If set to true, fall back to git grep --no-index if git grep
-	is executed outside of a git repository.  Defaults to false.
+include::config/grep.txt[]
 
 gpg.program::
 	Use this custom program instead of "`gpg`" found on `$PATH` when
diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
new file mode 100644
index 0000000000..44abe45a7c
--- /dev/null
+++ b/Documentation/config/grep.txt
@@ -0,0 +1,24 @@
+grep.lineNumber::
+	If set to true, enable `-n` option by default.
+
+grep.column::
+	If set to true, enable the `--column` option by default.
+
+grep.patternType::
+	Set the default matching behavior. Using a value of 'basic', 'extended',
+	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
+	`--fixed-strings`, or `--perl-regexp` option accordingly, while the
+	value 'default' will return to the default matching behavior.
+
+grep.extendedRegexp::
+	If set to true, enable `--extended-regexp` option by default. This
+	option is ignored when the `grep.patternType` option is set to a value
+	other than 'default'.
+
+grep.threads::
+	Number of grep worker threads to use.
+	See `grep.threads` in linkgit:git-grep[1] for more information.
+
+grep.fallbackToNoIndex::
+	If set to true, fall back to git grep --no-index if git grep
+	is executed outside of a git repository.  Defaults to false.
-- 
2.19.1.647.g708186aaf9

