Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A91E1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 10:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfBGKfU (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 05:35:20 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37561 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfBGKfT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 05:35:19 -0500
Received: by mail-pg1-f196.google.com with SMTP id c25so4313664pgb.4
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 02:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ai0wA6JWm0pH1iF6lOC7AO9zYkS8tlbFk7KZzzuDf20=;
        b=UfwuKpjUWCcydsyEBhNesFxpM4qvNJ8MAWjMAtR+6lbsno2iCQvlqWc9H4WhWZ/nxE
         UeFLiXHNvAlhs+z4UZposVpkhm0EFhER8dA4K2K1FJlSfOyFXwGk/mD4p7GASNsHAJM8
         MkzMy9+AcQJvieU7BXpP/5E/GwSTo01HQRxp3NHej9FsdOLwQHCJt8KSDQmazP1svYNX
         PrMSYd3vQ31rangdhjIYoM2/iSn3UiSY+rB6jo7ftkSkBt52unvdshXFcPlTe7RRT4Rw
         ITcjWWC2Jc9MZC93zmdqzstY/QfK8ACDVhV2EJYqovOpJBT+N1xM2bNJmLNqRfNWe+MI
         XZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ai0wA6JWm0pH1iF6lOC7AO9zYkS8tlbFk7KZzzuDf20=;
        b=eCtYctugI7LncO2fOVWPVgJolDlO6QO6LmwJEjQITSWeMSTMfqV8Rj6YgSCej6x0N/
         xIZqUnpklFXRyIRsVOEYCaOiDy2XlKTglCVR023zlJ0DYY/BdMAPxDkyhVPIXhkjXFoQ
         LRv9zVP8N1w8MBP+9UO4PhNUxO2T7R/PtwqUz3GFMZ72YnIwYcLoJnp4Pp1CsdJLbk7S
         daEPDStzEkMB0dK1RGMT0nUvYKaXwjbf+FhAx2zEkEw8ixX3xwcNvhzG+KLqI3G67Sfy
         9iLzmp8XTUWmGfP9yLOUbt12pwtemIgBUZ+fPE1SbpdJcBU/VTjIEE7ZvfJgez6eHYcb
         3EPg==
X-Gm-Message-State: AHQUAuZ7RsKsckUo6yXq+42gKeEDt5HH9VOI+p9wtZHggGOkZ7UJUsH1
        nOl635aOsP1Yc1F1j+2XdZCEaxWv
X-Google-Smtp-Source: AHgI3IbmTd1Ca/CrtId9MbbGR0PHvE1VCeYpxB2YB++XDNp4rg1p84Wtp0TUDcOgWg54BVTtAz9WtA==
X-Received: by 2002:a63:d52:: with SMTP id 18mr9643816pgn.377.1549535718902;
        Thu, 07 Feb 2019 02:35:18 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id b2sm13065516pfm.3.2019.02.07.02.35.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 02:35:18 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 07 Feb 2019 17:35:14 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 19/21] diff.c: convert --relative
Date:   Thu,  7 Feb 2019 17:33:24 +0700
Message-Id: <20190207103326.10693-20-pclouds@gmail.com>
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
 diff.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index d423a06b41..b9c267a199 100644
--- a/diff.c
+++ b/diff.c
@@ -4960,6 +4960,18 @@ static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
 	return 0;
 }
 
+static int diff_opt_relative(const struct option *opt,
+			     const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	options->flags.relative_name = 1;
+	if (arg)
+		options->prefix = arg;
+	return 0;
+}
+
 static int diff_opt_unified(const struct option *opt,
 			    const char *arg, int unset)
 {
@@ -5094,6 +5106,10 @@ static void prep_parse_options(struct diff_options *options)
 			 N_("use empty blobs as rename source")),
 
 		OPT_GROUP(N_("Diff other options")),
+		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
+			       N_("when run from subdir, exclude changes outside and show relative paths"),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
+			       diff_opt_relative),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5125,15 +5141,8 @@ int diff_opt_parse(struct diff_options *options,
 	if (ac)
 		return ac;
 
-	/* renames options */
-	if (skip_to_optional_arg_default(arg, "--relative", &arg, NULL)) {
-		options->flags.relative_name = 1;
-		if (arg)
-			options->prefix = arg;
-	}
-
 	/* xdiff options */
-	else if (!strcmp(arg, "--minimal"))
+	if (!strcmp(arg, "--minimal"))
 		DIFF_XDL_SET(options, NEED_MINIMAL);
 	else if (!strcmp(arg, "--no-minimal"))
 		DIFF_XDL_CLR(options, NEED_MINIMAL);
-- 
2.20.1.682.gd5861c6d90

