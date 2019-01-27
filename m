Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05DE41F453
	for <e@80x24.org>; Sun, 27 Jan 2019 00:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfA0AhD (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 19:37:03 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43067 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfA0AhC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 19:37:02 -0500
Received: by mail-pf1-f195.google.com with SMTP id w73so6351760pfk.10
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 16:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6P34m5nuc80QMYbxc14caHHZxpjLY+GCJR7IZrfgd7Y=;
        b=BhIw+eFj54KFRdzoSSp8qVQif2t9aXkDwiXKFCL1cCnUrXlY7OzNsmJ6UMXunw7iQy
         2IUmsEX+UGphPaUTAvE32dTObca+7g2uZ5KtIvzS4ZlkNYBMzcD7PAi1dU8h4gDC3GnB
         LsEIbs4w19zMppBakjGD5d/RzFNa3OaBQWV4PdBsr9sS201fg42/gWpH6w0N0js+xPpJ
         l2FyHFAH0BtN/ao+qRFPgJDbxcMexm2p0gm2CxI/GAuPCgo97odKN2Y7qEfbdqd/idNA
         Q+sP5ovIKdUQPMQ2CozDJOF39HthWMelXtwHzaW9OTvki3dWPb/wxBhqTeR6+qY+JuTF
         emvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6P34m5nuc80QMYbxc14caHHZxpjLY+GCJR7IZrfgd7Y=;
        b=TP+ev3EDgzj92R8i2dmEY2N/IZGGINS/UUMPBdYmp9uRIu+LdhGppsZw4V5uQJfZMC
         75rpx9yEsgdjRrFLFGTVZGymCpQUelivhj+Qu/12tsKhIr9wGaC/iHVwRAfjwlFT+tot
         DHUiIvkq5Cd+TzIQjXicL55SzmzKlIE0pq2j/YNIisz1fb8FTLQ/gKyNWw8NguDgy+nS
         +yI5nGNkZcCEsMTbYQG2s95QyKKcyW5bjqycXFMNRJPTCirvdEXqrl9bL2NGJ8r3ig9s
         t9w9uMBuejKFHKEznE1zaBhLo5T9Asbjv49q/MlJ5ejXef+fArXlwYxxkoHO1l6C3tDS
         Hsuw==
X-Gm-Message-State: AJcUukd4c4tezD90cq8ax/IQuXaeMzywU4085p+VVy1HLL27SUzfp8TL
        TJkK1yWB1eibyg5KBvn/cbSSD4kt
X-Google-Smtp-Source: ALg8bN7xpnaXj8O5J5/rVv2V78HWPdV2ni918zjhhKd9X+UfDIfOgc/hqdEEvTa/WlC2tMw1f3Rgqg==
X-Received: by 2002:a62:9111:: with SMTP id l17mr16628195pfe.200.1548549421750;
        Sat, 26 Jan 2019 16:37:01 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id b27sm37107025pfh.113.2019.01.26.16.36.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 16:37:01 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 27 Jan 2019 07:36:56 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/14] diff.c: convert -u|-p|--patch
Date:   Sun, 27 Jan 2019 07:35:32 +0700
Message-Id: <20190127003535.28341-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
In-Reply-To: <20190127003535.28341-1-pclouds@gmail.com>
References: <20190127003535.28341-1-pclouds@gmail.com>
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
 diff.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 80b4af23d7..a4a40e4aa8 100644
--- a/diff.c
+++ b/diff.c
@@ -4870,6 +4870,13 @@ static int parse_objfind_opt(struct diff_options *opt, const char *arg)
 static void prep_parse_options(struct diff_options *options)
 {
 	struct option parseopts[] = {
+		OPT_GROUP(N_("Diff output format options")),
+		OPT_BITOP('p', "patch", &options->output_format,
+			  N_("generate patch"),
+			  DIFF_FORMAT_PATCH, DIFF_FORMAT_NO_OUTPUT),
+		OPT_BITOP('u', NULL, &options->output_format,
+			  N_("generate patch"),
+			  DIFF_FORMAT_PATCH, DIFF_FORMAT_NO_OUTPUT),
 		OPT_END()
 	};
 
@@ -4898,8 +4905,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "-p") || !strcmp(arg, "-u") || !strcmp(arg, "--patch")
-	    || opt_arg(arg, 'U', "unified", &options->context))
+	if (opt_arg(arg, 'U', "unified", &options->context))
 		enable_patch_output(&options->output_format);
 	else if (!strcmp(arg, "--raw"))
 		options->output_format |= DIFF_FORMAT_RAW;
-- 
2.20.1.560.g70ca8b83ee

