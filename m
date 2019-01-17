Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE1321F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbfAQNLO (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:11:14 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45886 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNLO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:11:14 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so4421694pgc.12
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zVe3ZtM4I+Rq+nDaOwQ5TfGQt91t8ECFcGEfL4Uo0Sc=;
        b=LI5g1a/84RivSki3Z5ZN9K1lbUkbARjHYKFbsJyTnfDXFnWFj0utKd75Lo3C2snFqh
         ISInG9yDOZyCI8b3O4n5VF0u9ApfG0WF6EXkRV8we3sHYpE03R/LjDSitpwGPcL7kiSO
         rMHor6SNa/RHfOxywMlwMDmwS3rd5Af1d8McVI/xux9Vp8Rd1Lx6J9/aDSIS5iZI5orL
         y4o6yhE2ImlkKiVmHU5yVjJRFUgnV33sFGH59ELLd1oNhQVd1EmbCZDuHdOFn6M6jOxZ
         myqQY1K+EMbJ2TWKUzD65hv1AS2/fy1RN+DuM6vbZksoMqZbRLlnGEAnKjPFCWd66QwB
         3nEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zVe3ZtM4I+Rq+nDaOwQ5TfGQt91t8ECFcGEfL4Uo0Sc=;
        b=auXqmmy1i/jKSNUYBIRBfbHvOklf9nBg/UeOk8zvHiFnyFbI+yGpWgL1rau4pr0aFB
         yeuyPmDrYvSuGRw9tMTetyA0BITdiV7MNv2QBFOYQFL+7K9zxjTdJZ+IF5kEgJ8pvu6p
         wJDGXd7MgLF4tVScBrFKMXkY9bnb9KVN8YaOt2T+V5aGURBiQUk2cH5IGm8KSdJ+5Rw2
         1Xap9QfCeGIiK7Eh5ebC7FW9tHXbvQRM7o78sCq8kOn9k3FNf+Txtl1Qeccs6wAEPx/y
         cMKTImw55iRiQdUlotROIVFpe5lSQhr+HtHQHPQNorS1zwMyRcifHxa+JBqIqoPkCDQc
         pr/w==
X-Gm-Message-State: AJcUukdMVlgnLG8ldzmJ584NSQK8Rm5VHnJG1tRs8Tj9p2dzhX2bLDkA
        IUCwNNFtUKw7yGuB+w/9GerL/mnC
X-Google-Smtp-Source: ALg8bN7LOTbHslnlSAyVi5F147qPNTU1O4kL+4/iilhCkGNox16po1I6SkL/jBpjc77sN2au2UYS5g==
X-Received: by 2002:a63:9256:: with SMTP id s22mr13045898pgn.224.1547730673210;
        Thu, 17 Jan 2019 05:11:13 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 5sm4230589pfz.149.2019.01.17.05.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:11:12 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:11:08 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 57/76] diff.c: convert --ws-error-highlight
Date:   Thu, 17 Jan 2019 20:05:56 +0700
Message-Id: <20190117130615.18732-58-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190117130615.18732-1-pclouds@gmail.com>
References: <20190117130615.18732-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/diff.c b/diff.c
index 4d3eababe3..c60cfc80a4 100644
--- a/diff.c
+++ b/diff.c
@@ -4804,17 +4804,18 @@ static void enable_patch_output(int *fmt) {
 	*fmt |= DIFF_FORMAT_PATCH;
 }
 
-static int parse_ws_error_highlight_opt(struct diff_options *opt, const char *arg)
+static int diff_opt_ws_error_highlight(const struct option *option,
+				       const char *arg, int unset)
 {
+	struct diff_options *opt = option->value;
 	int val = parse_ws_error_highlight(arg);
 
-	if (val < 0) {
-		error("unknown value after ws-error-highlight=%.*s",
-		      -1 - val, arg);
-		return 0;
-	}
+	BUG_ON_OPT_NEG(unset);
+	if (val < 0)
+		return error("unknown value after ws-error-highlight=%.*s",
+			     -1 - val, arg);
 	opt->ws_error_highlight = val;
-	return 1;
+	return 0;
 }
 
 static int parse_objfind_opt(struct diff_options *opt, const char *arg)
@@ -5238,6 +5239,9 @@ static void prep_parse_options(struct diff_options *options)
 			 N_("show full pre- and post-image object names on the \"index\" lines")),
 		OPT_COLOR_FLAG(0, "color", &options->use_color,
 			       N_("show colored diff")),
+		OPT_CALLBACK_F(0, "ws-error-highlight", options, N_("<kind>"),
+			       N_("highlight whitespaces errors in the context, old or new lines in the diff"),
+			       PARSE_OPT_NONEG, diff_opt_ws_error_highlight),
 		OPT_CALLBACK_F(0, "output-indicator-new",
 			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
 			       N_("<char>"),
@@ -5401,9 +5405,7 @@ int diff_opt_parse(struct diff_options *options,
 		if (cm & COLOR_MOVED_WS_ERROR)
 			return -1;
 		options->color_moved_ws_handling = cm;
-	} else if (skip_prefix(arg, "--ws-error-highlight=", &arg))
-		return parse_ws_error_highlight_opt(options, arg);
-	else if (!strcmp(arg, "--ita-invisible-in-index"))
+	} else if (!strcmp(arg, "--ita-invisible-in-index"))
 		options->ita_invisible_in_index = 1;
 	else if (!strcmp(arg, "--ita-visible-in-index"))
 		options->ita_invisible_in_index = 0;
-- 
2.20.0.482.g66447595a7

