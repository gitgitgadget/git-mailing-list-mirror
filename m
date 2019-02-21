Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F6F61F453
	for <e@80x24.org>; Thu, 21 Feb 2019 11:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfBULRT (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 06:17:19 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35677 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBULRT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 06:17:19 -0500
Received: by mail-pf1-f193.google.com with SMTP id j5so9096996pfa.2
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 03:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JdpWqYqmcMHMXCmm61a2Q6WAgqhYXu5N4iZFEj9jTX8=;
        b=HOiKlFKVbFgK2jq21fiaP+ki91UEuq7kzTFUVZEeaJwPB7vAaoSKNekfJl6J8c66RE
         A0FlrZ6/CnyT0zGMshN65JYVob9NGwvt4onFlVjbe7XqAiSN2Qb1j2nngaqMeXfWTSZV
         iZrnsEo6bzJBcbrwyDh2AE+9/QwqXCyRq1eAMxWIFk3MEBXDa5PuA08PhQpeQo4wxYQC
         rHI1t/88prDjCrnkKFylEr9x6+xu3odfER5QDUVrV1IQfl4wl0UvyZsE4gGLoYhG0eZX
         Z4x/R74qO5QBDaPu7rR6v3WquWz0Jj4bNOWBK2U74igN8Qj/P8my8TvnTUjzVZYcWaT/
         U63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JdpWqYqmcMHMXCmm61a2Q6WAgqhYXu5N4iZFEj9jTX8=;
        b=PSFbE2TU/IeCpN0uOM6IxoyOQPSqSsWuDRgT/VLLMbstSrhYB17kkgZl0Q3vVG80Dn
         uHh84U1cghjhA6rzn33L8Hh/vh5U2byP4Aj9Wh3U9bwjVQ0qbeHiE+nYd4CQ0TSyeeOu
         wb1suc8W2ypCO4h7g3tv0fVo1Tx+KpTFiDNFYGtQJGaFh0RxcE6h62+40BOwt4rIaqvS
         04CFDxx+tCQIbJhpMf5oVpOjDitKQWqgtkg6RmbVSYXo2CszBEEO0M1LlEDekDqtI3cg
         Jf8PMcUerIk8dx6iPu4XoNqgh+bHOBjI1S1qjAT1k6ORkx8Xqo0++qbse9Qnvoa1A/uJ
         kT7Q==
X-Gm-Message-State: AHQUAuYy6oDMw0XOCj91UGRUUdyzKHCBD8VLP6HDwmYjTcWVKsWYRI2Q
        TycpAeMfxw7+ex6qAbr7IhS2y2ib
X-Google-Smtp-Source: AHgI3IYbL7ibwUFeBhI7BTmScb06OQO68AXn43VjVXqtdMPVgNV1f9I5jfZlC731UvSN7zOEbE085w==
X-Received: by 2002:a62:398d:: with SMTP id u13mr39617135pfj.32.1550747837958;
        Thu, 21 Feb 2019 03:17:17 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id o2sm30882638pgq.29.2019.02.21.03.17.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:17:17 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Feb 2019 18:17:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rybak.a.v@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 09/21] diff-parseopt: convert -s|--no-patch
Date:   Thu, 21 Feb 2019 18:16:09 +0700
Message-Id: <20190221111621.27180-10-pclouds@gmail.com>
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
 diff.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 99047fb5fe..9c8f5336bc 100644
--- a/diff.c
+++ b/diff.c
@@ -4906,6 +4906,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BITOP('p', "patch", &options->output_format,
 			  N_("generate patch"),
 			  DIFF_FORMAT_PATCH, DIFF_FORMAT_NO_OUTPUT),
+		OPT_BIT_F('s', "no-patch", &options->output_format,
+			  N_("suppress diff output"),
+			  DIFF_FORMAT_NO_OUTPUT, PARSE_OPT_NONEG),
 		OPT_BITOP('u', NULL, &options->output_format,
 			  N_("generate patch"),
 			  DIFF_FORMAT_PATCH, DIFF_FORMAT_NO_OUTPUT),
@@ -4983,9 +4986,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "-s") || !strcmp(arg, "--no-patch"))
-		options->output_format |= DIFF_FORMAT_NO_OUTPUT;
-	else if (starts_with(arg, "--stat"))
+	if (starts_with(arg, "--stat"))
 		/* --stat, --stat-width, --stat-name-width, or --stat-count */
 		return stat_opt(options, av);
 	else if (!strcmp(arg, "--compact-summary")) {
-- 
2.21.0.rc1.337.gdf7f8d0522

