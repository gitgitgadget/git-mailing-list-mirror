Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 527F51F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeJTUte (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:49:34 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44790 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbeJTUtd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:49:33 -0400
Received: by mail-lj1-f193.google.com with SMTP id v6-v6so33058133ljc.11
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=adnGBkQE5hEj+othxFloSyP1k6ObcmtONZhYM4G5mEk=;
        b=VV+g/fVdoDG4vmwmWA9nViBodxgBd4u3+qICRpUaH2Jn4zcmllcItVP0Cb1Fa2EIBE
         ic/hmt/+PCDqQFsk6SbVdfO6JaXrxjQoRSVaa1KmZt+2nTmPvfW+HsNN8DE4zad13HqK
         eSLVEQjW4NoUgna3hjx37TsZfCK7CqoHcUSakE7G5Iu0Vvi5oOL9vBMqaWcIKTLwOzEQ
         mcxQdn6gxVR/gAKUON3F9fYjhuadXpPGrqF9AkWJP+ACHdPmH4EwiUFAmTinxmcOQp9S
         fq+QM8ORmrW2WIS+/2RcCBKuC8sDva0EHf2+F7kIBfWF4TMJCp1e8sLhemXZgxU98GMl
         ThQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=adnGBkQE5hEj+othxFloSyP1k6ObcmtONZhYM4G5mEk=;
        b=bublV8lpCAb4udspNfsOGteaZZI6edInbMScYKbQ1Rh6rsPv5g92KzBmCTPhxJwiFv
         eMtNP1ug7s0dZYANrIEMln355mvkYgRDg22dop6ig7YLpjeL25+qo0gSTLoFnPJ9GWN5
         WScasQSFaICe0XrWbcw0eb8MsDyz06GlAzgTcepYHu2wF3vrfKuzcpqJzlPRBuHa4aqK
         Kkv+/AWig77puChX2+qXA29JWrrO6w5RJb0HnqOZP5QLUmIR2U4K7pHJJu3nAgEAUxCD
         7Bj3FyzDxvfnTkNC8GieGuEKZizcDxGGbcvBoib8wmLCdaNv4L8E3i2Hn4L3lrAwrPBe
         qitg==
X-Gm-Message-State: ABuFfoh7VlUW+fRI7+o3JoYH8aPZBk8RskDE/x08Ub0NVekUVzIoSuEq
        tnRskTUh43nTq1Y6LUHd5y1EqoXp
X-Google-Smtp-Source: ACcGV61YJSQ3x9W/80ymF3ztKDGtz35PqFTKyBTzj3VKbm66I6DdcblVzl210r6ai3Eln5U12H04SA==
X-Received: by 2002:a2e:9b8a:: with SMTP id z10-v6mr8636148lji.55.1540039150741;
        Sat, 20 Oct 2018 05:39:10 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:10 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 13/59] config.txt: move column.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:02 +0200
Message-Id: <20181020123848.2785-14-pclouds@gmail.com>
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
 Documentation/column-config.txt | 55 ++++++++++++++++++++++++++++++++
 Documentation/config.txt        | 56 +--------------------------------
 2 files changed, 56 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/column-config.txt

diff --git a/Documentation/column-config.txt b/Documentation/column-config.txt
new file mode 100644
index 0000000000..76aa2f29dc
--- /dev/null
+++ b/Documentation/column-config.txt
@@ -0,0 +1,55 @@
+column.ui::
+	Specify whether supported commands should output in columns.
+	This variable consists of a list of tokens separated by spaces
+	or commas:
++
+These options control when the feature should be enabled
+(defaults to 'never'):
++
+--
+`always`;;
+	always show in columns
+`never`;;
+	never show in columns
+`auto`;;
+	show in columns if the output is to the terminal
+--
++
+These options control layout (defaults to 'column').  Setting any
+of these implies 'always' if none of 'always', 'never', or 'auto' are
+specified.
++
+--
+`column`;;
+	fill columns before rows
+`row`;;
+	fill rows before columns
+`plain`;;
+	show in one column
+--
++
+Finally, these options can be combined with a layout option (defaults
+to 'nodense'):
++
+--
+`dense`;;
+	make unequal size columns to utilize more space
+`nodense`;;
+	make equal size columns
+--
+
+column.branch::
+	Specify whether to output branch listing in `git branch` in columns.
+	See `column.ui` for details.
+
+column.clean::
+	Specify the layout when list items in `git clean -i`, which always
+	shows files and directories in columns. See `column.ui` for details.
+
+column.status::
+	Specify whether to output untracked files in `git status` in columns.
+	See `column.ui` for details.
+
+column.tag::
+	Specify whether to output tag listing in `git tag` in columns.
+	See `column.ui` for details.
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9e2c6c292b..48ce01f596 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -311,61 +311,7 @@ include::clean-config.txt[]
 
 include::color-config.txt[]
 
-column.ui::
-	Specify whether supported commands should output in columns.
-	This variable consists of a list of tokens separated by spaces
-	or commas:
-+
-These options control when the feature should be enabled
-(defaults to 'never'):
-+
---
-`always`;;
-	always show in columns
-`never`;;
-	never show in columns
-`auto`;;
-	show in columns if the output is to the terminal
---
-+
-These options control layout (defaults to 'column').  Setting any
-of these implies 'always' if none of 'always', 'never', or 'auto' are
-specified.
-+
---
-`column`;;
-	fill columns before rows
-`row`;;
-	fill rows before columns
-`plain`;;
-	show in one column
---
-+
-Finally, these options can be combined with a layout option (defaults
-to 'nodense'):
-+
---
-`dense`;;
-	make unequal size columns to utilize more space
-`nodense`;;
-	make equal size columns
---
-
-column.branch::
-	Specify whether to output branch listing in `git branch` in columns.
-	See `column.ui` for details.
-
-column.clean::
-	Specify the layout when list items in `git clean -i`, which always
-	shows files and directories in columns. See `column.ui` for details.
-
-column.status::
-	Specify whether to output untracked files in `git status` in columns.
-	See `column.ui` for details.
-
-column.tag::
-	Specify whether to output tag listing in `git tag` in columns.
-	See `column.ui` for details.
+include::column-config.txt[]
 
 commit.cleanup::
 	This setting overrides the default of the `--cleanup` option in
-- 
2.19.1.647.g708186aaf9

