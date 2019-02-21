Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B4111F453
	for <e@80x24.org>; Thu, 21 Feb 2019 11:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfBULRO (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 06:17:14 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:43312 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBULRO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 06:17:14 -0500
Received: by mail-pf1-f170.google.com with SMTP id q17so13595822pfh.10
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 03:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X3KYPN3+Tdv5ZnbVUaHTegzuXkFIudtM6V9yBs8v7uA=;
        b=lr04lNeYv1vzmZKsZS9WU5K2EK3SSaJu8tNfA1vCbre2q/9p2kDt9UdrM+BLp9QYW6
         0yGY6XjUgQiP6DNNOgz3ny2Qxoa0VgeuAMrOE46mzJZa4o8RyNlM42dG1g6ebwwCh+G+
         xCHOTbWXgF6dBrLFEd1+0vzp01/teoJDVJYdussO0mC4nH0O2YzffiBsl2jOyVxt8qy7
         OmOew8jFasC9eZM+9/yhaR/dzDNuceus96fAdpQUWnZtpGS4M12eTUcOoBfGg1Idh7BW
         f2T7bWZrMxy+9tV34OOLnuww0FLK9ObjIE3YpuiE7A5xunHzVBikNFiq8J4gr1HgYQr1
         5WAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X3KYPN3+Tdv5ZnbVUaHTegzuXkFIudtM6V9yBs8v7uA=;
        b=Ioe0QkTpN2s3/zNZnsk+4p1uodLHLmCo2oFoz4bwpmk+zCa/vBAsTJdxT4dC7aLiU0
         tMI5wug5rnxonNXTFJbQyhKDRk+Vp6Wr6BActDK1mlCRxeZHFSRB5JIeaOOQzN1AfgFU
         pfQKrtq7GqFyPlSPReOizaPbUMgUv7/azh+HHbowqF+hkJmeuijEZt5AiJW3MHv+VW/O
         QAKJoqjQHZ/HBGDbz141kSOttRTtG3LWQqWqtT5qWyhzh2tIRnN5yQcxKRqRxoZmDLNV
         KIXijNMTJIZsl6W8HvE759XpstvUzYQbIb9wGrFW8haisumCJldOIMt2PCwpXPNhxMv6
         SiQA==
X-Gm-Message-State: AHQUAuZ/00iEssNdsG4Fe+IF8REmaHaNuAqjAj88nJPZITb0yaZqHHRW
        CwSqMENy++61o+d0TEIdGTwGmiLP
X-Google-Smtp-Source: AHgI3IaG3m5SjR+J1PHP0GnS1ChR7M7V4VbBaXXce5OoKtIPzfJsgKeXruL3nKGQ58aCvXudoxDnhQ==
X-Received: by 2002:a63:680a:: with SMTP id d10mr1306542pgc.46.1550747833142;
        Thu, 21 Feb 2019 03:17:13 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id z4sm24599223pgu.10.2019.02.21.03.17.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:17:12 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Feb 2019 18:17:08 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rybak.a.v@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 08/21] diff-parseopt: convert --name-status
Date:   Thu, 21 Feb 2019 18:16:08 +0700
Message-Id: <20190221111621.27180-9-pclouds@gmail.com>
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
index 7ea308814f..99047fb5fe 100644
--- a/diff.c
+++ b/diff.c
@@ -4952,6 +4952,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "name-only", &options->output_format,
 			  N_("show only names of changed files"),
 			  DIFF_FORMAT_NAME, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "name-status", &options->output_format,
+			  N_("show only names and status of changed files"),
+			  DIFF_FORMAT_NAME_STATUS, PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
@@ -4980,9 +4983,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--name-status"))
-		options->output_format |= DIFF_FORMAT_NAME_STATUS;
-	else if (!strcmp(arg, "-s") || !strcmp(arg, "--no-patch"))
+	if (!strcmp(arg, "-s") || !strcmp(arg, "--no-patch"))
 		options->output_format |= DIFF_FORMAT_NO_OUTPUT;
 	else if (starts_with(arg, "--stat"))
 		/* --stat, --stat-width, --stat-name-width, or --stat-count */
-- 
2.21.0.rc1.337.gdf7f8d0522

