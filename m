Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8619D20248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfCEMcR (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:32:17 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46218 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbfCEMcR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:32:17 -0500
Received: by mail-pg1-f195.google.com with SMTP id 196so5545343pgf.13
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jqSOvYhLPVVb+z5X/j19KgWRwXJvbhACZvtr3rqYnVw=;
        b=snveaiYWyXPKIRyySJWstp2DKb1DjhTnEhs2pqPNqy/0wbtOiOmOChuBboTqa4RCCK
         jgZYsl3GSIkCWFiwHiG4uThJEVQZUIqs5Y2WrbeqZbRTbfvaNTwOCKT7pB8GxLWVjQXF
         VNGDunSQJ9CHKINCLKGhnnlE4qIqh+s8rhnqzkODkr3P9xNCoK2ryovSlRuQYOmYrio4
         WLshqtVgtl9WPrEMTDI+OpREorHX75aV4a9yl1MK0tYDB9qOc4neN1VBed3n8QRRuGCJ
         HsLUM9VwzUVSIvqMzxUIrHgBMp/+9xzEURFNG+oV8+ff0eBW22u+BeiWTwmz1cKV8u5q
         zUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jqSOvYhLPVVb+z5X/j19KgWRwXJvbhACZvtr3rqYnVw=;
        b=gXFqPBvfp0vkEynNDCXNd7ZEYxf067v0dr9oCGzkE1Lmn5nFP9t7FHiO8QibDsfmJ0
         MSE4leVI1auWkfuR8oEVJhZcahn4e1eIfx+bY3scBRbQ3AK0tFVyx1Nk2hE59HtC8Utf
         O0oCyB4awVLFRiQ6bw1+19/yzJDFCP/NzAs1/j0fRmkO+BMC0W/YIFjxHONLMG3JjLm4
         0iBxUp8m7HTJFGOaAQkdSzw7PlrUdcoQfA8mdYax/NBF/jAdjR1WH4UX+j1jPZRmWE+8
         dLlNKUhqcI/pdwc+VC5RHEzlpbl4bmE1kqk39RVox9qoQnhRV0Hy/07YmxEN2xXzsfa8
         WZHw==
X-Gm-Message-State: APjAAAUXuxBmmzmoFpog1vhGrlqxfyjsFOkbOD90WKQKYzUek8kg1sI+
        NVLmBP5hqSgx/EygoNHGtlmJ1z4l
X-Google-Smtp-Source: APXvYqzf0ZFhtlvBVea4evoOCnv5lMuDynSi0EsVRcmJGBTFTaL8bj5iCy351/gRDe4H0hiNRAZYxw==
X-Received: by 2002:a65:5a81:: with SMTP id c1mr1183591pgt.217.1551789136375;
        Tue, 05 Mar 2019 04:32:16 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id x23sm31599111pfe.0.2019.03.05.04.32.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 04:32:15 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 05 Mar 2019 19:32:12 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 20/20] diff-parseopt: convert --submodule
Date:   Tue,  5 Mar 2019 19:30:26 +0700
Message-Id: <20190305123026.7266-21-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190305123026.7266-1-pclouds@gmail.com>
References: <20190305123026.7266-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index 6fd6106963..ce118bb326 100644
--- a/diff.c
+++ b/diff.c
@@ -4721,14 +4721,6 @@ static int parse_dirstat_opt(struct diff_options *options, const char *params)
 	return 1;
 }
 
-static int parse_submodule_opt(struct diff_options *options, const char *value)
-{
-	if (parse_submodule_params(options, value))
-		die(_("Failed to parse --submodule option parameter: '%s'"),
-			value);
-	return 1;
-}
-
 static const char diff_status_letters[] = {
 	DIFF_STATUS_ADDED,
 	DIFF_STATUS_COPIED,
@@ -5075,6 +5067,20 @@ static int diff_opt_relative(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_submodule(const struct option *opt,
+			      const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	if (!arg)
+		arg = "log";
+	if (parse_submodule_params(options, arg))
+		return error(_("failed to parse --submodule option parameter: '%s'"),
+			     arg);
+	return 0;
+}
+
 static int diff_opt_textconv(const struct option *opt,
 			     const char *arg, int unset)
 {
@@ -5338,6 +5344,10 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("ignore changes to submodules in the diff generation"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
 			       diff_opt_ignore_submodules),
+		OPT_CALLBACK_F(0, "submodule", options, N_("<format>"),
+			       N_("specify how differences in submodules are shown"),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
+			       diff_opt_submodule),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5387,9 +5397,7 @@ int diff_opt_parse(struct diff_options *options,
 		if (cm & COLOR_MOVED_WS_ERROR)
 			return -1;
 		options->color_moved_ws_handling = cm;
-	} else if (skip_to_optional_arg_default(arg, "--submodule", &arg, "log"))
-		return parse_submodule_opt(options, arg);
-	else if (skip_prefix(arg, "--ws-error-highlight=", &arg))
+	} else if (skip_prefix(arg, "--ws-error-highlight=", &arg))
 		return parse_ws_error_highlight_opt(options, arg);
 	else if (!strcmp(arg, "--ita-invisible-in-index"))
 		options->ita_invisible_in_index = 1;
-- 
2.21.0.rc1.337.gdf7f8d0522

