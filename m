Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F22771F462
	for <e@80x24.org>; Thu, 21 Feb 2019 11:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfBULST (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 06:18:19 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40351 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfBULSS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 06:18:18 -0500
Received: by mail-pf1-f195.google.com with SMTP id h1so13593720pfo.7
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 03:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q1STGAwhspv4W/QiXrlxh+NSfu/xQMHcVrif1RNV0oI=;
        b=i73RCWScYMaSwEtVbMHmdt21IE0bqWoixpvmtelsn5PqfuSwTHfbBYTo+ftSRQyZDb
         099UZEZw/qBKA0zjTE3hXerEX7fx+QSVyU2XF2Ei/cU1T3H5KqclSrqUd0V91fz43X7/
         5UgeNKXG19IW3G4o402gqvaZsRNZTLG9EzW7alwMfAOdIjho0ffeq3MdxfXd7b+BXtsP
         mKlreU3ihz8R5mp5IqtoGu4/KseFz5VwerP+rXD/W7jmBAPUvxJnf0gZ9uEmxlLAVYNU
         bTQ/AwprrWdV4nmYrptVYUgDimyX6IaeHM7ortaQEk8oHG4IgURw3HRqfkClBF/7NW1u
         MjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q1STGAwhspv4W/QiXrlxh+NSfu/xQMHcVrif1RNV0oI=;
        b=Vb/6Miho23r+PLCBiyYIUCN8PunnQGA62A5urY6EHWFWmG1gowtjvYBKoBz5oAWz9Z
         iOPjSmfYyw9qQxNVBmrtuz+cKT5JZ/k6SuhLRY1ZbFrI+F6JO6BQpR8OuqhNhE5LbyAX
         7MWTMU6wsK69XMb0OX/vE48EW+zXvyb3o5BEowcT0+Rvscoei5L0DVNs9GQ2seG7fHIT
         WvVZmHqtS2EfNKnlJ353Ygf/oJvg4bhxnwxT1Hw1S7IY0xYWgdbnfE4jISlhYNytnAPh
         T38B19iE8y3dQztyU4j5GDUWCSVEuDgKjK8myRuKil4hcjuGWWfUJRJ01eY3J2P25CkY
         RIMw==
X-Gm-Message-State: AHQUAuZGUzQCGu2yuA6m6MJ9FSm79LMHD3ftqbNQq+BcxVVGwiDeP8Ca
        QxYyRtVj+R0qsrIzNbrtrXlhGF5+
X-Google-Smtp-Source: AHgI3IbFyvX/WuPOvhRCG+7SFF5ktYuNZoLbIOtDkCutxU/MbccvVxNdEGTWgVBf2PI2yOBewNI9rA==
X-Received: by 2002:a63:c40a:: with SMTP id h10mr34343027pgd.131.1550747898052;
        Thu, 21 Feb 2019 03:18:18 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id n19sm54659056pfg.67.2019.02.21.03.18.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:18:17 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Feb 2019 18:18:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rybak.a.v@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 21/21] diff-parseopt: convert --ignore-some-changes
Date:   Thu, 21 Feb 2019 18:16:21 +0700
Message-Id: <20190221111621.27180-22-pclouds@gmail.com>
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index 33492e754f..a63ee4a44d 100644
--- a/diff.c
+++ b/diff.c
@@ -5109,6 +5109,21 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT(0, "minimal", &options->xdl_opts,
 			N_("produce the smallest possible diff"),
 			XDF_NEED_MINIMAL),
+		OPT_BIT_F('w', "ignore-all-space", &options->xdl_opts,
+			  N_("ignore whitespace when comparing lines"),
+			  XDF_IGNORE_WHITESPACE, PARSE_OPT_NONEG),
+		OPT_BIT_F('b', "ignore-space-change", &options->xdl_opts,
+			  N_("ignore changes in amount of whitespace"),
+			  XDF_IGNORE_WHITESPACE_CHANGE, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "ignore-space-at-eol", &options->xdl_opts,
+			  N_("ignore changes in whitespace at EOL"),
+			  XDF_IGNORE_WHITESPACE_AT_EOL, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "ignore-cr-at-eol", &options->xdl_opts,
+			  N_("ignore carrier-return at the end of line"),
+			  XDF_IGNORE_CR_AT_EOL, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "ignore-blank-lines", &options->xdl_opts,
+			  N_("ignore changes whose lines are all blank"),
+			  XDF_IGNORE_BLANK_LINES, PARSE_OPT_NONEG),
 
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
@@ -5147,17 +5162,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* xdiff options */
-	if (!strcmp(arg, "-w") || !strcmp(arg, "--ignore-all-space"))
-		DIFF_XDL_SET(options, IGNORE_WHITESPACE);
-	else if (!strcmp(arg, "-b") || !strcmp(arg, "--ignore-space-change"))
-		DIFF_XDL_SET(options, IGNORE_WHITESPACE_CHANGE);
-	else if (!strcmp(arg, "--ignore-space-at-eol"))
-		DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
-	else if (!strcmp(arg, "--ignore-cr-at-eol"))
-		DIFF_XDL_SET(options, IGNORE_CR_AT_EOL);
-	else if (!strcmp(arg, "--ignore-blank-lines"))
-		DIFF_XDL_SET(options, IGNORE_BLANK_LINES);
-	else if (!strcmp(arg, "--indent-heuristic"))
+	if (!strcmp(arg, "--indent-heuristic"))
 		DIFF_XDL_SET(options, INDENT_HEURISTIC);
 	else if (!strcmp(arg, "--no-indent-heuristic"))
 		DIFF_XDL_CLR(options, INDENT_HEURISTIC);
-- 
2.21.0.rc1.337.gdf7f8d0522

