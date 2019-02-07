Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D012C1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 10:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfBGKe7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 05:34:59 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43244 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfBGKe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 05:34:59 -0500
Received: by mail-pl1-f196.google.com with SMTP id gn14so4574131plb.10
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 02:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=svOllokAsr1AaFW//l2kzBARxPOBlfr1kmSwg6mqJA4=;
        b=MtpraIUfUSvVsTR5zmxJtaQI8hq0PoNp9iCzq9OD+/pcXn+7dqmFdOIorz/bgOtNXk
         2bosLpZh53EdmK+CAC56l/bZ5gzDQVpUU8VodHiJK44JRPB0oRKO800cqZx//ZxcJ456
         7rWpegCeHGfC7WF22sFT7Wfzqb/NyiuWZGGtA5DjuJIG/HAXlvbyFS5umCkeDxKyFPiV
         6Hw14TOCQqpJfE5qnkKHVIcIeyg3fj6bMtGPPf8xHXXrgPgip5FxTzjoj7BK8e80m30i
         V9HRn6XaSM4B5zkkLXAx/MiF8SeVGCOTXIlrcBKhVrSEbV6DRHIseOKaz8awH9N+0lFy
         11VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=svOllokAsr1AaFW//l2kzBARxPOBlfr1kmSwg6mqJA4=;
        b=aPx1DFUE7SG9XDFst6N2Co0pyehRNn+jfMYc0+RZd827/de/uQaV2qXzvh4uTCVos0
         3Mw4URt2QMo5RkO6ktUKJHNuACiW8ytNgOaMphtvAHasYyMW4oXTnedcgvChrCL0cbvk
         Xw6tf+4FCLUe1iQui0ZbTC7D1FzPuacG2uXulLOovCyT7sfReOQ5iT4Y8a9yL9yEVmX1
         aTyxA7Nv6tF2/RLt9CNxfLIYKulB1ZZ8urVJTgttIyIdN9kqXycZY+j01Fug5yMlS/om
         o2x3HBVr+WNdP4E76dsQWscAN24zCdewCLUcatsF6JQZuKcKQeG50fS7JntVCQRKYWks
         byYA==
X-Gm-Message-State: AHQUAuaWXFuIZhRDPTDmiclI1uKRNr5abnS2RNADspgXaIlJKVJ5efFx
        BKxD1e7EUXZqk5Dc4eVAXXRrN87q
X-Google-Smtp-Source: AHgI3IYB4L+JeIQd1Xkj3W2QVPv5wiHRrXfUPjEIbrngJk4bwOt+CvtdU4LXDHKvMM4X+O0mnSsy0w==
X-Received: by 2002:a17:902:aa8d:: with SMTP id d13mr14100043plr.293.1549535698895;
        Thu, 07 Feb 2019 02:34:58 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id z9sm28348610pfd.99.2019.02.07.02.34.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 02:34:58 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 07 Feb 2019 17:34:54 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 15/21] diff.c: convert -D|--irreversible-delete
Date:   Thu,  7 Feb 2019 17:33:20 +0700
Message-Id: <20190207103326.10693-16-pclouds@gmail.com>
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
 diff.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 2c904e0526..e51f6b3005 100644
--- a/diff.c
+++ b/diff.c
@@ -5060,6 +5060,9 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("detect renames"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
 			       diff_opt_find_renames),
+		OPT_SET_INT_F('D', "irreversible-delete", &options->irreversible_delete,
+			      N_("omit the preimage for deletes"),
+			      1, PARSE_OPT_NONEG),
 
 		OPT_GROUP(N_("Diff other options")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
@@ -5094,10 +5097,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* renames options */
-	if (!strcmp(arg, "-D") || !strcmp(arg, "--irreversible-delete")) {
-		options->irreversible_delete = 1;
-	}
-	else if (starts_with(arg, "-C") ||
+	if (starts_with(arg, "-C") ||
 		 skip_to_optional_arg(arg, "--find-copies", NULL)) {
 		if (options->detect_rename == DIFF_DETECT_COPY)
 			options->flags.find_copies_harder = 1;
-- 
2.20.1.682.gd5861c6d90

