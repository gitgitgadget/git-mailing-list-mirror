Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35FD21F462
	for <e@80x24.org>; Thu, 21 Feb 2019 11:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfBULQo (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 06:16:44 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40200 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfBULQn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 06:16:43 -0500
Received: by mail-pg1-f193.google.com with SMTP id u9so10110496pgo.7
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 03:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NIC5BMrDA/jjPY8ux1gqOzAv6/Ta0xgWF86dLsG8TNU=;
        b=QJLFHHI+txyqPKb9fY+gtqw9CE/U7AKzh6pzVkzKXqsP5GTTEvPGxJ931+SOgb4KtU
         frS3m7ykZwBuqsf46H4s9weypMFQFfXIDgEoC1L6u6TKCvaJum2kWnDGC+4WBkMp5lZI
         dXnUY0+9Bq6oDfS1mP4jVR8M8g/F93qYW+WGZRdkzoFLYCJcOJNaXw6oq/rnfhRBBj1y
         rUEqbnGf0em2xvG0DtLMgqUp3X4R/w7dA/5uXBGqbWQEgin1RLkmLBgOL85NfxfHT0jG
         3jQFlzZcRo9dFbo4cfjig7iiqYzNOpAuLRypBzKd2r5TqYqXHVQ7tRJ1tUvfcuTzyJns
         JV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NIC5BMrDA/jjPY8ux1gqOzAv6/Ta0xgWF86dLsG8TNU=;
        b=ZPTVxjndslPoA6iZ57r0ajvjpj5+aaZ9GrzMF2yOEpvL+/sv9VPvYpQLGHaXKych+p
         ihapBOP4nZ4zPoEBLtRSo+SxfdpNMga62lz4jBSyx3PJzx3KWdfb2rBpVR27mQyf/mqw
         u+a3f6MQhwgJWxMeGF9J2jBpzBeGcSb8Rw2Gnnz+j8lYvhS07YLhgSlIrG/iY5G01fsJ
         vQQuGBl+y5cGnosKjDcC4FB1EOzP+008/syNwJFlO+v5BEtUwlFNC8CRgT0fKz/2HMzP
         KJNXyHVsSUylvSij9ZAw4h6twCZkahI5fUsFwHNj+4p1rgTKpV5TulXgWkFx3OCNCBty
         To7w==
X-Gm-Message-State: AHQUAubXIY9GgdeZotLpNVQbj7kB8wzVAsKFXRyH/+UU4oCpLqQPVtby
        ekfBSnhaALzIazVQkRqcAcuwyaPB
X-Google-Smtp-Source: AHgI3IaRaNZu7NCGprPD0GWG/ExqdYi+wVZ2raJsHNQiBB5Dpvt8MZP9Bt2citutgWb9Om+gzG+/TA==
X-Received: by 2002:a63:575d:: with SMTP id h29mr19413752pgm.442.1550747802826;
        Thu, 21 Feb 2019 03:16:42 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id v15sm28363044pfa.75.2019.02.21.03.16.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:16:41 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Feb 2019 18:16:37 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rybak.a.v@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 02/21] diff-parseopt: convert --numstat and --shortstat
Date:   Thu, 21 Feb 2019 18:16:02 +0700
Message-Id: <20190221111621.27180-3-pclouds@gmail.com>
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
 diff.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 12e333c67f..419b6ac4ae 100644
--- a/diff.c
+++ b/diff.c
@@ -4905,6 +4905,12 @@ static void prep_parse_options(struct diff_options *options)
 			  N_("synonym for '-p --raw'"),
 			  DIFF_FORMAT_PATCH | DIFF_FORMAT_RAW,
 			  DIFF_FORMAT_NO_OUTPUT),
+		OPT_BIT_F(0, "numstat", &options->output_format,
+			  N_("machine friendly --stat"),
+			  DIFF_FORMAT_NUMSTAT, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "shortstat", &options->output_format,
+			  N_("output only the last line of --stat"),
+			  DIFF_FORMAT_SHORTSTAT, PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
@@ -4933,11 +4939,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--numstat"))
-		options->output_format |= DIFF_FORMAT_NUMSTAT;
-	else if (!strcmp(arg, "--shortstat"))
-		options->output_format |= DIFF_FORMAT_SHORTSTAT;
-	else if (skip_prefix(arg, "-X", &arg) ||
+	if (skip_prefix(arg, "-X", &arg) ||
 		 skip_to_optional_arg(arg, "--dirstat", &arg))
 		return parse_dirstat_opt(options, arg);
 	else if (!strcmp(arg, "--cumulative"))
-- 
2.21.0.rc1.337.gdf7f8d0522

