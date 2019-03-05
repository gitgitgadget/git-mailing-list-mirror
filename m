Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC3C920248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfCEMbg (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:31:36 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33584 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbfCEMbg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:31:36 -0500
Received: by mail-pf1-f196.google.com with SMTP id i19so5602218pfd.0
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HyhNLTV0DfRulN3pU2g3J0a9kLEFDhlmnqxTJuJJjdw=;
        b=pFlXmfwF8Nzi7iPHVCla+IhyZa0czep6P8AqxCwhX48tvKfK1PYyj/aF+UuVDvRVcH
         71rSNgHnoIjIZPoP77vPpa3snAgAQgHAyvUl7b67lOet2fRF3UKCGmXS2c2xJFvh3YMC
         yR4agTkxcF3dY9YfigHKsJGhD1wacrCTO0j2BPb3T4jC07sdmLNTVmVsZJtzzdpYAeGm
         /MayW+vNaLurCvMivSeIve/qtd4lH/1EeYvahneC60L0gUL1Csv41lxkWbclUb0h6PYK
         /NeHOu4vM8LdHuxmQIBlVDwTL1NI/wIi1rh1ntVSluhsJkMfkK1GGhVtHPu1Kz0IlN22
         A0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HyhNLTV0DfRulN3pU2g3J0a9kLEFDhlmnqxTJuJJjdw=;
        b=LJUWnyQLG6sIqzNbRpyBdZ244t6mBFhyD0SMih72wRsX6sXLINmJBtzrZtjk8rcO5Q
         8bMuzmXagHl0ZbCmlPsJlML333YYtDrwYr8WLDq9mvPOyYIbWAzQ0LdVWjdWgEgK+9bQ
         sxRPXXfGTR14UY/koE7/JsE3Y+lFhpgjx2iFk+8wLuqrincQ6nDkKqn8VRZhbNEY6Iws
         Fh9wm3Ppb7HJR6f7xQPjWD6ZbHu5nxUQj41q2Skrp9ywOmxeflmVzYAlwc0HfRuz2KIe
         P08GW3wOWPWsFWAQo5LkhKB8Bah6uQxyJdxUy+SW8nmdjmk1YVgsKWYCz4R6c+7fzX08
         3lww==
X-Gm-Message-State: APjAAAWihSooUHB4T21H95LYfs4v+q1hHlSOLuMGZgZNwnE0ETpTzks9
        HRcJ8z4mZBX2xVw9/0YcPnWczZcA
X-Google-Smtp-Source: APXvYqz0NF6MUvgCVQphtpS1WeGaWpGj9zsWbqNKWNHpUjmr+Zs9ReVfp6L7CObjo9umStyKFCkkMQ==
X-Received: by 2002:a62:1ace:: with SMTP id a197mr1666686pfa.78.1551789095552;
        Tue, 05 Mar 2019 04:31:35 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id z77sm15545814pfi.155.2019.03.05.04.31.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 04:31:34 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 05 Mar 2019 19:31:31 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/20] diff-parseopt: convert --[no-]color
Date:   Tue,  5 Mar 2019 19:30:17 +0700
Message-Id: <20190305123026.7266-12-pclouds@gmail.com>
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
 diff.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index ad813ea418..bb36d507ec 100644
--- a/diff.c
+++ b/diff.c
@@ -5148,6 +5148,8 @@ static void prep_parse_options(struct diff_options *options)
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG, diff_opt_binary),
 		OPT_BOOL(0, "full-index", &options->flags.full_index,
 			 N_("show full pre- and post-image object names on the \"index\" lines")),
+		OPT_COLOR_FLAG(0, "color", &options->use_color,
+			       N_("show colored diff")),
 		OPT_CALLBACK_F(0, "output-indicator-new",
 			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
 			       N_("<char>"),
@@ -5268,15 +5270,7 @@ int diff_opt_parse(struct diff_options *options,
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
2.21.0.rc1.337.gdf7f8d0522

