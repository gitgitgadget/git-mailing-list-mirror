Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE40D20248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfCEMat (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:30:49 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35072 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbfCEMat (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:30:49 -0500
Received: by mail-pf1-f193.google.com with SMTP id j5so5598940pfa.2
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hxERyCsr2cRvd88rOL08MO0R8g9JcvSKzSwYxbV+H5I=;
        b=egve2aITCWZuO4ZHq1E8ivO8FNa3ESjFQKAX6Baod4aU/9of/KXhn0A7zn5T9/E2k3
         h9ViRzaTbYuqPmcOZBVK31lboKaiGzI9TAmB3EqwZR0E4u/2IDdCZU+u5g2aIh2PoI9Z
         1b12CV+Sp2oLz0dz55942hDX+g6qSnzNiTa68cBNTKM0dbt7gyIFyEcHk2euXElNHrN4
         DHCP6hM1d2gpwMHxC10C0LYcTllfudVSyjXNxzV5xqS2cBVm9mEJxPKMN9vXRxtfVF1W
         Px31pUJESRhuUPgOam3Pw433oSI5Q4dyI+ViVz+KrOzFtl+XJ85PudJCeFN97ocCzr8V
         5FSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hxERyCsr2cRvd88rOL08MO0R8g9JcvSKzSwYxbV+H5I=;
        b=fcm6dHyFBPXSuQncfh+odmLAKHiiRV/bHKP04BE0Z6UtRTjD3uXqHO5l8/dqfXsktP
         fQvXPcchK6cY+pcmH1xA/XIZjArDQfo0Sd9dk4TY2t0fTcyYHpl0RQb04pQ0OOuSxrQn
         udJtDXTV/Yq8PIMydyHQ5lZ5f3tWG4tJgf+bi2l+TNfx0A7yvKptCFp5uqr0Hv8M5jnM
         4/k2yU1yleqrH5VcX0Gg7lqfO31rQVtCXIcq9ELIxfggFsSD1ur54aY1mth/8YpKyuwF
         xZyPYIICXIcrEm4wI7FZQF45fnAJkulU8Y7VnDKvI5iEH+Ug7CMQQo6GiUt8jxpojVPI
         uDfQ==
X-Gm-Message-State: APjAAAVmYX7A5uQz+cLOlV0oDAO/gBVqZHul1/JONm6RuFqDRUTxpvBO
        IrK7sJTOOAeThL86B2PvfTEjMh5N
X-Google-Smtp-Source: APXvYqwiQNMBGstUaylQB/S3qLX9Ih7FF/MvM7j2nh8wP3RbCjEHQppKl4jQdRHmHr4qEzyfviJ3Vw==
X-Received: by 2002:a62:7602:: with SMTP id r2mr1593193pfc.191.1551789048017;
        Tue, 05 Mar 2019 04:30:48 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id z18sm24893716pfl.164.2019.03.05.04.30.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 04:30:47 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 05 Mar 2019 19:30:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/20] diff-parseopt: convert --[no-]indent-heuristic
Date:   Tue,  5 Mar 2019 19:30:07 +0700
Message-Id: <20190305123026.7266-2-pclouds@gmail.com>
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
 diff.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index a63ee4a44d..c4cd84f1b3 100644
--- a/diff.c
+++ b/diff.c
@@ -5124,6 +5124,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "ignore-blank-lines", &options->xdl_opts,
 			  N_("ignore changes whose lines are all blank"),
 			  XDF_IGNORE_BLANK_LINES, PARSE_OPT_NONEG),
+		OPT_BIT(0, "indent-heuristic", &options->xdl_opts,
+			N_("heuristic to shift diff hunk boundaries for easy reading"),
+			XDF_INDENT_HEURISTIC),
 
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
@@ -5162,11 +5165,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* xdiff options */
-	if (!strcmp(arg, "--indent-heuristic"))
-		DIFF_XDL_SET(options, INDENT_HEURISTIC);
-	else if (!strcmp(arg, "--no-indent-heuristic"))
-		DIFF_XDL_CLR(options, INDENT_HEURISTIC);
-	else if (!strcmp(arg, "--patience")) {
+	if (!strcmp(arg, "--patience")) {
 		int i;
 		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
 		/*
-- 
2.21.0.rc1.337.gdf7f8d0522

