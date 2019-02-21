Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 765221F462
	for <e@80x24.org>; Thu, 21 Feb 2019 11:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfBULRz (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 06:17:55 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42005 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfBULRz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 06:17:55 -0500
Received: by mail-pf1-f195.google.com with SMTP id n74so13598424pfi.9
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 03:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d8c8v1eJMeM+oZKZP3OwQM65QTgZ+Ewm3xCsvnVYFPo=;
        b=qY6g9neVwDvOlvMW0yq6mc5PgZtgMcmqN3ujAA/woXNPB3CSVRGkY2zB0l+jgQeXT3
         Fbj+8ku5BZBtbLuB7It/prHiTSQJLY0sTXGOUukkSncF2JcmNFTW6lbtnpvz1DpjAvM7
         EVpmY1e30GJUFGeWH1u3MzSk0u6sd7mONQIhbUISMenL478uC7E97I6IlAgjxiK1lOYQ
         P1rp7mOVFPJ4xdf2YVCRtBZvD6GE8X3w+NPNsRf+6AvY6x1p2eU1Nur7JUUuEKEq6gpb
         U2I9g8TYzSezwyWhqJ4tDgsv27ID8YT6SASkx2eGKGGGZyy3HTlyAonBfbwP3Gta2Qs0
         pJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d8c8v1eJMeM+oZKZP3OwQM65QTgZ+Ewm3xCsvnVYFPo=;
        b=XfiZ2d2yxfADh5KSD3o4qsGKf14GKHGO9jhYuPxBcq996QFDo2VAvEOFa7GUWaiB0u
         6nn2sxbasIHNGCCQ6Ntm6+GpZK+UJTjGGhbclGfjXeMeH5Kr2r5vxQag1PhaoagwwtEj
         NzLmLeQJ6C8RneS7dxd+B9RZMbvnOS5yn+XWYR4vT+PtjRs9+dLuK0j5Sczso7DBhBB+
         eFPub8kpg1xMsEfOYaIkf95K00T0O8bn50hhFpcHZmvPlQjI2RUO8gSLRq4srizxmsRo
         MSuiqBbEiiQhG3J4L6fAA9zX+IdP8l3+xOxYOyGBBQyDE8exovfPgay4wbWJhm0QuHiE
         vgsA==
X-Gm-Message-State: AHQUAuYstlDNHoq6ZdDGqP/hz9ez/96kbPLIQpBUbS4plc7a9yMpEoao
        eczjhcektLDbU0m5llMsyCD1ePOw
X-Google-Smtp-Source: AHgI3IaXxHz6mPhfW07q3Cy6TrUjZF/B+tt1LqDSiKKGjI3Swnea3FNIzCnb5flMT7Mih6m28NwBgA==
X-Received: by 2002:a63:112:: with SMTP id 18mr32725826pgb.139.1550747874089;
        Thu, 21 Feb 2019 03:17:54 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 23sm26992850pft.187.2019.02.21.03.17.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:17:53 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Feb 2019 18:17:49 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rybak.a.v@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 16/21] diff-parseopt: convert -C|--find-copies
Date:   Thu, 21 Feb 2019 18:16:16 +0700
Message-Id: <20190221111621.27180-17-pclouds@gmail.com>
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
 diff.c | 59 +++++++++++++++++++++++++---------------------------------
 1 file changed, 25 insertions(+), 34 deletions(-)

diff --git a/diff.c b/diff.c
index e51f6b3005..35bac115cc 100644
--- a/diff.c
+++ b/diff.c
@@ -4617,8 +4617,6 @@ static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *va
 	return 1;
 }
 
-static int diff_scoreopt_parse(const char *opt);
-
 static inline int short_opt(char opt, const char **argv,
 			    const char **optarg)
 {
@@ -4909,6 +4907,26 @@ static int diff_opt_dirstat(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_find_copies(const struct option *opt,
+				const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	if (!arg)
+		arg = "";
+	options->rename_score = parse_rename_score(&arg);
+	if (*arg != 0)
+		return error(_("invalid argument to %s"), opt->long_name);
+
+	if (options->detect_rename == DIFF_DETECT_COPY)
+		options->flags.find_copies_harder = 1;
+	else
+		options->detect_rename = DIFF_DETECT_COPY;
+
+	return 0;
+}
+
 static int diff_opt_find_renames(const struct option *opt,
 				 const char *arg, int unset)
 {
@@ -5063,6 +5081,10 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_SET_INT_F('D', "irreversible-delete", &options->irreversible_delete,
 			      N_("omit the preimage for deletes"),
 			      1, PARSE_OPT_NONEG),
+		OPT_CALLBACK_F('C', "find-copies", options, N_("<n>"),
+			       N_("detect copies"),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
+			       diff_opt_find_copies),
 
 		OPT_GROUP(N_("Diff other options")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
@@ -5097,15 +5119,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* renames options */
-	if (starts_with(arg, "-C") ||
-		 skip_to_optional_arg(arg, "--find-copies", NULL)) {
-		if (options->detect_rename == DIFF_DETECT_COPY)
-			options->flags.find_copies_harder = 1;
-		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
-			return error("invalid argument to -C: %s", arg+2);
-		options->detect_rename = DIFF_DETECT_COPY;
-	}
-	else if (!strcmp(arg, "--no-renames"))
+	if (!strcmp(arg, "--no-renames"))
 		options->detect_rename = 0;
 	else if (!strcmp(arg, "--rename-empty"))
 		options->flags.rename_empty = 1;
@@ -5365,29 +5379,6 @@ int parse_rename_score(const char **cp_p)
 	return (int)((num >= scale) ? MAX_SCORE : (MAX_SCORE * num / scale));
 }
 
-static int diff_scoreopt_parse(const char *opt)
-{
-	int opt1, cmd;
-
-	if (*opt++ != '-')
-		return -1;
-	cmd = *opt++;
-	if (cmd == '-') {
-		/* convert the long-form arguments into short-form versions */
-		if (skip_prefix(opt, "find-copies", &opt)) {
-			if (*opt == 0 || *opt++ == '=')
-				cmd = 'C';
-		}
-	}
-	if (cmd != 'C')
-		return -1; /* that is not a -M option */
-
-	opt1 = parse_rename_score(&opt);
-	if (*opt != 0)
-		return -1;
-	return opt1;
-}
-
 struct diff_queue_struct diff_queued_diff;
 
 void diff_q(struct diff_queue_struct *queue, struct diff_filepair *dp)
-- 
2.21.0.rc1.337.gdf7f8d0522

