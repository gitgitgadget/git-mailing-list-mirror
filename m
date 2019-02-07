Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E6531F453
	for <e@80x24.org>; Thu,  7 Feb 2019 10:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfBGKez (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 05:34:55 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44335 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfBGKey (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 05:34:54 -0500
Received: by mail-pg1-f194.google.com with SMTP id y1so4296409pgk.11
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 02:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bkpc6gAvbtzkeJPrOem+Jy5N3M3ZNfY2QvQAWSTD2rw=;
        b=FyWEr4j9furP52C4rU7bcs6ELKy81K20lBDDLDwUJu9VuJ2nVISZ9BDzpeoCgP4zZr
         1FmuMoj494mHtao3UCh7WoO3+uGyyq5U4q/0F45BEiN/y+1yD4E3VSp8y3c5BaM7S7Rc
         tsJ1pbcWOvgeK+bUwJUm+3PHFbzw//naa05aZcrgswAZERJLbUWYRxtwAAZgQhw2Xplm
         bcr8cm32/R+eQOc68tzWwcZgKQdZ+uL010lYPcj96CzMaDH08g6sGGkpJtZIiNfo09t2
         3vxcO6bvl0n/wC5NNRDFp032a4JE2Z8PVcPlgjE61pbEnzBIzQjfTRTRAAWLVK4fkDg7
         jAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bkpc6gAvbtzkeJPrOem+Jy5N3M3ZNfY2QvQAWSTD2rw=;
        b=diPyahryF9g8Ka/u3KjXDkqgkwh96MKhQrL78JROlDI21hjST5NXc+uMaCcTQ3VIpu
         qOcWTXMXFk+bRc9c1Z4tFzsblGxv9bVT7h1ymeNzOUjvVQbAqrD2jTzDK+xjZDmJXO2n
         tejNpq5R6YgdXoT63AiIv4Sf2/XVnHkdpc953Wy4C9RuE8sXZ70vxM0RFbwvnzKsHvk4
         lg+LIuFr/RQ2ARbRJodiKxoP4cUiAu2Th2eqXy9YdKmPDXlNRFtKQHyBtJ8JhbL494az
         lnpE5L+xEWfcnK3isPwIgt+YRY+I9vqKUTX+xoytxYgKs6rr+1+bRQRJSqMl9h6rGm3v
         NTPQ==
X-Gm-Message-State: AHQUAuamxbCOyPZROgzGfe0Tp+2cSoViOd51twT9+ikRT4Br/7wXWPHM
        JkHXPWkKaEGN1xqc7z0atzC2d48m
X-Google-Smtp-Source: AHgI3IYJzzNKUAcPfkXPR+Hq0Nv9wFz289P66nU8T79+tZhE4b4Gfw581Kj/LXyt3SA1Wueebiee4w==
X-Received: by 2002:a63:d846:: with SMTP id k6mr14380398pgj.251.1549535693949;
        Thu, 07 Feb 2019 02:34:53 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id u8sm12571979pfl.16.2019.02.07.02.34.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 02:34:53 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 07 Feb 2019 17:34:49 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 14/21] diff.c: convert -M|--find-renames
Date:   Thu,  7 Feb 2019 17:33:19 +0700
Message-Id: <20190207103326.10693-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190207103326.10693-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/diff.c b/diff.c
index d2139082b7..2c904e0526 100644
--- a/diff.c
+++ b/diff.c
@@ -4909,6 +4909,22 @@ static int diff_opt_dirstat(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_find_renames(const struct option *opt,
+				 const char *arg, int unset)
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
+	options->detect_rename = DIFF_DETECT_RENAME;
+	return 0;
+}
+
 static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
 					     const struct option *opt,
 					     const char *arg, int unset)
@@ -5040,6 +5056,10 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("break complete rewrite changes into pairs of delete and create"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
 			       diff_opt_break_rewrites),
+		OPT_CALLBACK_F('M', "find-renames", options, N_("<n>"),
+			       N_("detect renames"),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
+			       diff_opt_find_renames),
 
 		OPT_GROUP(N_("Diff other options")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
@@ -5074,13 +5094,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* renames options */
-	if (starts_with(arg, "-M") ||
-		 skip_to_optional_arg(arg, "--find-renames", NULL)) {
-		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
-			return error("invalid argument to -M: %s", arg+2);
-		options->detect_rename = DIFF_DETECT_RENAME;
-	}
-	else if (!strcmp(arg, "-D") || !strcmp(arg, "--irreversible-delete")) {
+	if (!strcmp(arg, "-D") || !strcmp(arg, "--irreversible-delete")) {
 		options->irreversible_delete = 1;
 	}
 	else if (starts_with(arg, "-C") ||
@@ -5363,13 +5377,10 @@ static int diff_scoreopt_parse(const char *opt)
 		if (skip_prefix(opt, "find-copies", &opt)) {
 			if (*opt == 0 || *opt++ == '=')
 				cmd = 'C';
-		} else if (skip_prefix(opt, "find-renames", &opt)) {
-			if (*opt == 0 || *opt++ == '=')
-				cmd = 'M';
 		}
 	}
-	if (cmd != 'M' && cmd != 'C')
-		return -1; /* that is not a -M, or -C option */
+	if (cmd != 'C')
+		return -1; /* that is not a -M option */
 
 	opt1 = parse_rename_score(&opt);
 	if (*opt != 0)
-- 
2.20.1.682.gd5861c6d90

