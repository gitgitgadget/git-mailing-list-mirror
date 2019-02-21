Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9EFF1F462
	for <e@80x24.org>; Thu, 21 Feb 2019 11:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfBULSE (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 06:18:04 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46230 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfBULSE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 06:18:04 -0500
Received: by mail-pl1-f195.google.com with SMTP id o6so14021574pls.13
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 03:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YwBrKr8tXuuvkt//jokobu5CmCGARO/o27V+S9PMYb0=;
        b=fM6Ds2EutRKVmFpvpTFuVjrRhmFB7OwZFiiny/tpkPZAcB9yoecv9g1Hie+Q3BNJ/h
         ZFTsrJTGD6iD6uDg6lPjrNju93xqWhPJp6285++qvVTtI1KHnDKk9aduo6SXN3lLTPY+
         lSDUM1s2/82FOC88j+P64aHUkLU/vRFOqoRWe0ev0csrgrfRquyfi1Y7zKuzICZqKZA5
         w/HxOCFNt6p2g0QZsR6gBwQw389lRvYy6KCahKM7RTc3s0Lg8gZ7Ba0PiNb3Qr7HCs4W
         EoCuiK78dVqweUzx1EPImf2uCXgEyr7nczBD0qW96hpV7vBHu0jcIgi7pEWYpWFsKrrj
         A44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YwBrKr8tXuuvkt//jokobu5CmCGARO/o27V+S9PMYb0=;
        b=ruF4PrR6+eek0S4OsrEHUL+kzmnDC+hiiqPRiynRiEoWmRnIDbjisIrq1PUKmMR2wG
         lopYBnZwKJiaknsCq4YL2rfEKZNGl4zBb4kt3HlJGwBF9AgL3EXoABmRdL4pfk3FIuwg
         UQw1Q9ie8YYSfoKV5mZzsoy1WjLBbMV1SgBMp6hg4HESCxKahgOv6uAPVnKbKzYYwtIp
         R5Xd3Eqa95DHfcA1RStDAQwj2we8NGe718GLAX6M8NIGItUSEg+vYUTF2KcPmaVoPGRW
         MuM0nSCMFv72Qir3sKCaWbBU3ZeFapJg1D/Ebp/3S9tiSSC8XQHwEu5mv9Y7K5PsI/yB
         Lshg==
X-Gm-Message-State: AHQUAuZsHOpk68Q9SCYMDt2q2jmw0HZPBlrV2ndhzgmS2MVG44LWcknF
        PWxP0BTz3B1GGjHkU+RR2q664sAf
X-Google-Smtp-Source: AHgI3IZgFp6lIgGyg5g/pjUhLLk0Osjp7q9AXHSbX+HzPecG1HWTfhszPU1YV5Xb7zwYnpCrFNT34Q==
X-Received: by 2002:a17:902:8c95:: with SMTP id t21mr3476270plo.300.1550747883636;
        Thu, 21 Feb 2019 03:18:03 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id l79sm16146268pfb.102.2019.02.21.03.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:18:02 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Feb 2019 18:17:59 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rybak.a.v@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 18/21] diff-parseopt: convert --no-renames|--[no--rename-empty
Date:   Thu, 21 Feb 2019 18:16:18 +0700
Message-Id: <20190221111621.27180-19-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190221111621.27180-1-pclouds@gmail.com>
References: <20190216113655.25728-1-pclouds@gmail.com>
 <20190221111621.27180-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For --rename-empty, see 90d43b0768 (teach diffcore-rename to
optionally ignore empty content - 2012-03-22) for more information.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-options.txt |  3 +++
 diff.c                         | 13 ++++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 56b731eae5..915f2fec8b 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -392,6 +392,9 @@ endif::git-format-patch[]
 	Turn off rename detection, even when the configuration
 	file gives the default to do so.
 
+--[no-]rename-empty::
+	Whether to use empty blobs as rename source.
+
 ifndef::git-format-patch[]
 --check::
 	Warn if changes introduce conflict markers or whitespace errors.
diff --git a/diff.c b/diff.c
index abb1566f95..d423a06b41 100644
--- a/diff.c
+++ b/diff.c
@@ -5087,6 +5087,11 @@ static void prep_parse_options(struct diff_options *options)
 			       diff_opt_find_copies),
 		OPT_BOOL(0, "find-copies-harder", &options->flags.find_copies_harder,
 			 N_("use unmodified files as source to find copies")),
+		OPT_SET_INT_F(0, "no-renames", &options->detect_rename,
+			      N_("disable rename detection"),
+			      0, PARSE_OPT_NONEG),
+		OPT_BOOL(0, "rename-empty", &options->flags.rename_empty,
+			 N_("use empty blobs as rename source")),
 
 		OPT_GROUP(N_("Diff other options")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
@@ -5121,13 +5126,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* renames options */
-	if (!strcmp(arg, "--no-renames"))
-		options->detect_rename = 0;
-	else if (!strcmp(arg, "--rename-empty"))
-		options->flags.rename_empty = 1;
-	else if (!strcmp(arg, "--no-rename-empty"))
-		options->flags.rename_empty = 0;
-	else if (skip_to_optional_arg_default(arg, "--relative", &arg, NULL)) {
+	if (skip_to_optional_arg_default(arg, "--relative", &arg, NULL)) {
 		options->flags.relative_name = 1;
 		if (arg)
 			options->prefix = arg;
-- 
2.21.0.rc1.337.gdf7f8d0522

