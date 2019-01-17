Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98CE21F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfAQNKV (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:10:21 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35355 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfAQNKV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:10:21 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so4747980plo.2
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CpbPLqt5LDDZ7uGXfNIM983kH7PqlVYsUyfmHMvSi/E=;
        b=F7QYS8VBmjqOAP9F0bFOd4nss8ahM+e1VVlWCY7ppZAmBDRYcAqFlRy2qtA1TjYEnZ
         jNH5DE3cFJvQP7cOIvCkjMkaSaX9ozxdEsm5YE1R58HNQJ8VNZ9DK5drQDr7DUj2trIR
         6f2BBpYDc5eHGATg+R4PsRe+msbSSzbaZReagS84EvrRlT1OKOfU42JGPfvaoqmVdERK
         V5Tl1GXuyBxB3xZMmlnmwFBUw8QQewsaUiGJSG5e5lIS7pmo2Tw6YsAR7pQszrGUfT43
         LmHX9P0iQJlQViTEmIfjNXGAyY04UZXnYHEub6k/a0kpxXpTMvu1U0OY0/5W9MHIpoAc
         y7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CpbPLqt5LDDZ7uGXfNIM983kH7PqlVYsUyfmHMvSi/E=;
        b=giS2a8n4rZ0tCfsykQ3rUJQVojCw/zSCJuo1fUGN3Vk+68K5GfRpqZLQ7kSx0fa7l/
         jJwE9O2KXj6B9ZbOHVTMz+V9qJq/L5nxSRCxHGqwTA6xuHHCNqabUImQ+MteWdCJ9fJB
         eLiKnhMxYYAl8WprxrCmLqb9FlvGx07wz+o+veWRPwscDlHYb3cSUo1S49nqJAQPxM+/
         kawdhp/wo8IDHth4PJgNtFeZDj9sppKUnBFnNpP9Qh52BIAc9dQKjb3wZgrB3ci3fHPv
         wzPvY2uoVeHqGOMZrG0nTq1K7M4cJq3j8UcpDrVm7yLTl5IRxlE4AO6+LCnmEwx5H/cl
         8Fyg==
X-Gm-Message-State: AJcUukfG6lnkf3xe7Q6lXg34mOTsvPIMzjed4rvoI5iNGLr3JjUgkA68
        PthjyXTZJ44cIO4cmqR871zdCovU
X-Google-Smtp-Source: ALg8bN4psFn3vk0MHWttqSsPMSKLRjHJOwzDw44C+JLqVZ8M8+P+cLZL8bPRGTlINNKxT6n02s0K+w==
X-Received: by 2002:a17:902:780c:: with SMTP id p12mr14599662pll.197.1547730620326;
        Thu, 17 Jan 2019 05:10:20 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id s190sm2518952pfb.103.2019.01.17.05.10.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:10:19 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:10:15 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 46/76] diff.c: convert --[no-]follow
Date:   Thu, 17 Jan 2019 20:05:45 +0700
Message-Id: <20190117130615.18732-47-pclouds@gmail.com>
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
 diff.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 13de6ea35c..13d9e5eb05 100644
--- a/diff.c
+++ b/diff.c
@@ -4990,6 +4990,21 @@ static int diff_opt_find_renames(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_follow(const struct option *opt,
+			   const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_ARG(arg);
+	if (unset) {
+		options->flags.follow_renames = 0;
+		options->flags.default_follow_renames = 0;
+	} else {
+		options->flags.follow_renames = 1;
+	}
+	return 0;
+}
+
 static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
 					     const struct option *opt,
 					     const char *arg, int unset)
@@ -5176,6 +5191,9 @@ static void prep_parse_options(struct diff_options *options)
 			      0, PARSE_OPT_NONEG),
 		OPT_BOOL(0, "rename-empty", &options->flags.rename_empty,
 			 N_("use empty blobs as rename source")),
+		OPT_CALLBACK_F(0, "follow", options, NULL,
+			       N_("continue listing the history of a file beyond renames"),
+			       PARSE_OPT_NOARG, diff_opt_follow),
 
 		OPT_GROUP(N_("Diff algorithm options")),
 		OPT_BIT(0, "minimal", &options->xdl_opts,
@@ -5254,12 +5272,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* flags options */
-	if (!strcmp(arg, "--follow"))
-		options->flags.follow_renames = 1;
-	else if (!strcmp(arg, "--no-follow")) {
-		options->flags.follow_renames = 0;
-		options->flags.default_follow_renames = 0;
-	} else if (skip_to_optional_arg_default(arg, "--color", &arg, "always")) {
+	if (skip_to_optional_arg_default(arg, "--color", &arg, "always")) {
 		int value = git_config_colorbool(NULL, arg);
 		if (value < 0)
 			return error("option `color' expects \"always\", \"auto\", or \"never\"");
-- 
2.20.0.482.g66447595a7

