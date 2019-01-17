Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B48491F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfAQNMO (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:12:14 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33508 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNMO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:12:14 -0500
Received: by mail-pg1-f195.google.com with SMTP id z11so4451650pgu.0
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=drUko49hRVkuVq1HRl3xCkJAxyuuhVNud2kH5it/ros=;
        b=GfsCvOHN5O+Oh4TO8Z7+6yiHtxuF8SNGuxmBJY0JoOPl+Md9YDvOJX670MLAwSTE0c
         YQV2fv5H3j9k3hrdpagjvfSlCBS/qhx6y0Re9hxjdDHpMdunQ9zNGPuTsYiUoGXBMFyL
         k2SZBuVKNtqtTqUp6YmUXV1APIZ4rsXP6KjSenH/v2pvO2TtzFcx3tpMR/OTpwluT0i3
         uLxGDeqRG9GAYCoGghJUAiB77oR3CVCOtuVcCgG/ffuk8quoYgvtYlmlLdhgm4BYLW7B
         Sr8Mxmtrjh91LKVLz8y0pMoAWg/EHhQd/hEdQ67RWszrgcmQ+4ydr7ZvqZ97w2/mHb03
         EvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=drUko49hRVkuVq1HRl3xCkJAxyuuhVNud2kH5it/ros=;
        b=TUYaYC4Fuxb7ri31b9bAbtMqciP+C4ifs14cXMmSxIWEenD2rYc9Bj/sIdOUWIaZ+l
         5kVdLYlKmTCOmEVAG9EKFT/3wOZsQh7f/K79gOygqAZ6asSGsPi+tVb3ZnHsSJWyii1A
         CK5QDNavpe8c3H1wxGoRTgrHyx3sco+FPwBjv18+/0qXo9AP8l/F3av/PwxH7X6PNelw
         0RmGCQNoaLGUyLDYJBYCzqJwyMuEm+QWVgKx+ObqQyFB5rW0d2DbvGCo+/gQnp1szNug
         gV43tAT+KE2cZJDlP1+5l2JhsHrCrPJB2uwHA7CD37BjxIsNEMqKGzj11OFDuFolCDRB
         mljg==
X-Gm-Message-State: AJcUukdOSIyoc/yQM65mXOvlYyoMdeYd0j+630UHy1gt3nNJtSo8rXo5
        fB7GZFO2yNpsfKkFgRM3u3EGPkyl
X-Google-Smtp-Source: ALg8bN7f8bBBeyFUoBvimAQQWxFCSySssLyvAxvCbMqOHbnkAdVrN1pOGSyvseZbgqsvzUxmkUxdDw==
X-Received: by 2002:a63:f30d:: with SMTP id l13mr13458481pgh.399.1547730733426;
        Thu, 17 Jan 2019 05:12:13 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id x28sm7620101pge.66.2019.01.17.05.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:12:12 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:12:08 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 69/76] diff.c: convert --no-prefix
Date:   Thu, 17 Jan 2019 20:06:08 +0700
Message-Id: <20190117130615.18732-70-pclouds@gmail.com>
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
 diff.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 25c386b04c..3e7c36524d 100644
--- a/diff.c
+++ b/diff.c
@@ -5042,6 +5042,18 @@ static int diff_opt_line_prefix(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_no_prefix(const struct option *opt,
+			      const char *optarg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(optarg);
+	options->a_prefix = "";
+	options->b_prefix = "";
+	return 0;
+}
+
 static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
 					     const struct option *opt,
 					     const char *arg, int unset)
@@ -5296,6 +5308,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "line-prefix", options, N_("<prefix>"),
 			       N_("prepend an additional prefix to every line of output"),
 			       PARSE_OPT_NONEG, diff_opt_line_prefix),
+		OPT_CALLBACK_F(0, "no-prefix", options, NULL,
+			       N_("no not show any source or destination prefix"),
+			       PARSE_OPT_NONEG | PARSE_OPT_NOARG, diff_opt_no_prefix),
 		OPT_CALLBACK_F(0, "output-indicator-new",
 			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
 			       N_("<char>"),
@@ -5488,8 +5503,6 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if (!strcmp(arg, "--no-prefix"))
-		options->a_prefix = options->b_prefix = "";
 	else if (opt_arg(arg, '\0', "inter-hunk-context",
 			 &options->interhunkcontext))
 		;
-- 
2.20.0.482.g66447595a7

