Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58ED71F453
	for <e@80x24.org>; Thu, 21 Feb 2019 11:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfBULRJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 06:17:09 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38493 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBULRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 06:17:09 -0500
Received: by mail-pf1-f194.google.com with SMTP id n125so6319737pfn.5
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 03:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t1y+HyLvueKFGu8cPhQWWu2MxhbNOIiVvKdNy/Xiyj4=;
        b=XjFzA/WmIEiW2jKfHCp4K94I4V3t2j22GPnw43lmZmyoFlsmS3Q9YhiMtAzVK4GPIE
         kckVLhbNB3kU6sYC5RQRNPeRDVeq/fHleH8TNoadOwK+ewNLmYDooDhIZcnEdUjNcK92
         ABtrfTyou6Swa6hC5SpXkdT3y3eV8wXypXoyuD3d1dyAJLlpkbuv5qhMKliw7NpaToA0
         74Wn39155fevkQroxsvdwQRTeTQV5r4sGse5BZiZoVnt3fJkRCw/E6wN/yvQhxtV/kCF
         L0g/d0LptKQDG8DfluRBCLPVTzzNTAPwIXgDqw+bst4oUnF90C23h1UILX7+Ho3Pw8r3
         1YBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t1y+HyLvueKFGu8cPhQWWu2MxhbNOIiVvKdNy/Xiyj4=;
        b=A31EyQNPAnlYmppjpXdYXg3rN3aMls49lJZ+lDlXG+1C2DTd5J2Q/WkPeo4sETm/Cl
         Zbmwkuopm6eFtfADuahfuLkS6NZ8mp6NsXHDzk2oanh7/qcqJcXf3rF8GdcBg3iQImje
         0AA15X7K3t6AUTePyJzqOKPEGHzZx6PzGNOrVvOEI9MAhvy2uTuhVJHSk4Wi4BWNzk3q
         0t2IDI/WDEg+TvpMSD4c9x9qc+64zt6SW1ZMTpRn3CQOGkzKy+rabNxbhb30PKJ1ppCb
         KolXyoowSMeGgmBw49q+LAgV6rv7ZTMuTvEpoxln7h84cRESgG7ZYvFHaYtPUqI7kYJK
         H7tg==
X-Gm-Message-State: AHQUAuZDOFSL3NedaeaojxtBnl9l1xo+Jo8DDP/tJjqHf3SDYpbGpwjf
        d9Dt2UyM+wiQTx5uVW1Rf0IiXzoI
X-Google-Smtp-Source: AHgI3IayZVGL2SRVUYqkhNqY/RVv6EpT5VEjCOMeXapRTd3291Edla1joddQE+PQwRWPbO7FfdvYPQ==
X-Received: by 2002:a62:b608:: with SMTP id j8mr41027854pff.183.1550747828065;
        Thu, 21 Feb 2019 03:17:08 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id x1sm25274324pge.73.2019.02.21.03.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:17:06 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Feb 2019 18:17:02 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rybak.a.v@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 07/21] diff-parseopt: convert --name-only
Date:   Thu, 21 Feb 2019 18:16:07 +0700
Message-Id: <20190221111621.27180-8-pclouds@gmail.com>
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
index b9811aefef..7ea308814f 100644
--- a/diff.c
+++ b/diff.c
@@ -4949,6 +4949,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "summary", &options->output_format,
 			  N_("condensed summary such as creations, renames and mode changes"),
 			  DIFF_FORMAT_SUMMARY, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "name-only", &options->output_format,
+			  N_("show only names of changed files"),
+			  DIFF_FORMAT_NAME, PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
@@ -4977,9 +4980,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--name-only"))
-		options->output_format |= DIFF_FORMAT_NAME;
-	else if (!strcmp(arg, "--name-status"))
+	if (!strcmp(arg, "--name-status"))
 		options->output_format |= DIFF_FORMAT_NAME_STATUS;
 	else if (!strcmp(arg, "-s") || !strcmp(arg, "--no-patch"))
 		options->output_format |= DIFF_FORMAT_NO_OUTPUT;
-- 
2.21.0.rc1.337.gdf7f8d0522

