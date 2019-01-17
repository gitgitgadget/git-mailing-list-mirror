Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A4181F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfAQNK0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:10:26 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38962 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfAQNK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:10:26 -0500
Received: by mail-pf1-f196.google.com with SMTP id r136so4818431pfc.6
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A8UMYek9Kntu8AL6JlIe2xOenJrpljZFWxuaMmfrHEI=;
        b=RrUi1zhNqni+iqrO53aSFxrwTnhec3FLZZGZCoIBgxlx3MDAowX0fA5/EqvUz0qiQO
         wSYoG3vyFm/spRwpePb7PSP1yJst/bcxpQF9G9hPoH9xdDINYyzKAw2mHa8+CDKvqS4q
         2Z7yx7bGKKW/tcO0jRFmANW+gAH+dRQM8aPnjowFneHAF5PUv6gTIgexv5wnYEFmW9mF
         rk6gADymsxujJ84+ejnI6CYFDAMvrSKleZrE3sEZNE9YN0QEo+l+YyYhv++YS7yvjIu/
         4xuh4y7XkkNmBojXjPAixK2fkuaRZiWRpYnKhiHwWsBLGsvcRiIvJz+cbHaGSpdBB/Yu
         /OYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A8UMYek9Kntu8AL6JlIe2xOenJrpljZFWxuaMmfrHEI=;
        b=tAtQogOTLGIb99iVNDgYfm/7i52qTZJWQ8C2LJAvSgT6rQpVo/7ESOgqWYk0IqUnXp
         nJ0u0Z/GU/1QvvxCf/0OqX1IxKvIIBbqpKsHiQgO1kASVLcRIotJSeim9ce3pgYkdiI/
         5zAaspPsS1+hZRxwMqiV73et6wwL8bz5jAF6bqLYk8K5XgsnlE3+uQD79CcrPVQBii4h
         3Zq4VqbHZ/R7gX+GLf0XJsMjgqXJruO5XNFB3hEpZpR2Pr15zRnj5aBJ/gOfLCKdn2/w
         JdrQ0ZBIXY0axuXsex9uFgWhV4ikvXd9Of1GOduo6mKJ7fYKd01xCbSlIBd7iqac/TaC
         nTMg==
X-Gm-Message-State: AJcUukdS5E5fII7tfLK/n9MsXtD6VyOSsqjsGaeeCx2sftfREiIAYnd3
        wz+zZfxLvuTYtM6efJ/5ZdSVdv+v
X-Google-Smtp-Source: ALg8bN7GVE/OgBrbRkqgY0A/gCPtiSltX6OmCu3MXzra4DSOTKuK6Oj0c8oUuRxScQwFQPoJb8/zGw==
X-Received: by 2002:a62:8c11:: with SMTP id m17mr14907703pfd.224.1547730625110;
        Thu, 17 Jan 2019 05:10:25 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id q1sm2184799pgs.14.2019.01.17.05.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:10:24 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:10:20 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 47/76] diff.c: convert --[no-]color
Date:   Thu, 17 Jan 2019 20:05:46 +0700
Message-Id: <20190117130615.18732-48-pclouds@gmail.com>
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
 diff.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index 13d9e5eb05..0c7a100f84 100644
--- a/diff.c
+++ b/diff.c
@@ -5152,6 +5152,8 @@ static void prep_parse_options(struct diff_options *options)
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG, diff_opt_binary),
 		OPT_BOOL(0, "full-index", &options->flags.full_index,
 			 N_("show full pre- and post-image object names on the \"index\" lines")),
+		OPT_COLOR_FLAG(0, "color", &options->use_color,
+			       N_("show colored diff")),
 		OPT_CALLBACK_F(0, "output-indicator-new",
 			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
 			       N_("<char>"),
@@ -5272,15 +5274,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* flags options */
-	if (skip_to_optional_arg_default(arg, "--color", &arg, "always")) {
-		int value = git_config_colorbool(NULL, arg);
-		if (value < 0)
-			return error("option `color' expects \"always\", \"auto\", or \"never\"");
-		options->use_color = value;
-	}
-	else if (!strcmp(arg, "--no-color"))
-		options->use_color = 0;
-	else if (!strcmp(arg, "--color-moved")) {
+	if (!strcmp(arg, "--color-moved")) {
 		if (diff_color_moved_default)
 			options->color_moved = diff_color_moved_default;
 		if (options->color_moved == COLOR_MOVED_NO)
-- 
2.20.0.482.g66447595a7

