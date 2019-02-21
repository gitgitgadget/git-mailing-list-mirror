Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91EC61F453
	for <e@80x24.org>; Thu, 21 Feb 2019 11:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfBULQ6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 06:16:58 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33775 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbfBULQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 06:16:58 -0500
Received: by mail-pl1-f194.google.com with SMTP id y10so14046525plp.0
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 03:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O74GZqR3azoivzcxrZ3hFRiAdXI5h4OdMGU0jydtGHM=;
        b=msGh02RkXxSSCyGGk8CSDBJeWIrTQwU0XGWMkgLHrNkfTlZ8A7eUA5paSyWZTl+mio
         WkTt+SQyx5uVPp9HvX8lrADmLlVrmqswpyQprwQMmpBGLxDMh+fcLqd4AXOrRC1WZXrR
         cRMXpwNF1E0mbueBrFqDS2KZVFV6gnIYPeN262yXk9xyagybBNr2vqNxmIItcauZ2fzT
         ttRVXDwbqjxOOXaiALupjmet0C9jEgXf8ZfkdsUWlStDEVAnVdfkNo+/mN0uxRImkBKF
         11AbJkqU2/F+whF5QQ9jqayx4UVkVMMRNafOekHSu6LJZBe+/ULtJ9A7uJkboqZOOUGx
         Cjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O74GZqR3azoivzcxrZ3hFRiAdXI5h4OdMGU0jydtGHM=;
        b=bZAIAaKqEvh9WZ0GJpmSGDUxiymN5MNol+HLHaQYF6Nur4WZsD4tbGVQZPAROR7uxW
         hoTidgjV78d/ATC9V7qlF1gy0GoCcMvXsX6Ms+kxPe7+XrfY7rqoRslmFE93SeFvHJq/
         uYoyl0s3y/vYevS5yqdeOR8VyliQrE/oBaW9NbBCDlrmCgdu76Zyt0KUBQbbHltStXso
         wRtUQ5guGQw767O09zUsB9iX5bSibGsCr20c6InxuDkppYXFVMRf5EmD8tXaNKBogg5J
         WEGZeMBhcTqfIh8dYptmJWUymnWqOcjgD3SsSgYMhYb2X/3Bvmp2sSzfsra1myl52OYL
         CzkQ==
X-Gm-Message-State: AHQUAuYgEFIDx+fK2JSxIVfkPCjCyAhkaYiNDV3YRI8VabCmQXryIbjf
        cYresyzIx15fXoAkDS2A3Z4UGoEf
X-Google-Smtp-Source: AHgI3IYjQkuZ0jQMQnKsxxgBeAmaqnfFPBlH622e95rAJ/K5MMXUTYxAKkHLjhoPVWtJ41spnrZPGQ==
X-Received: by 2002:a17:902:b784:: with SMTP id e4mr30500231pls.308.1550747817395;
        Thu, 21 Feb 2019 03:16:57 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 63sm13319765pfs.65.2019.02.21.03.16.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:16:56 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Feb 2019 18:16:53 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rybak.a.v@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 05/21] diff-parseopt: convert --summary
Date:   Thu, 21 Feb 2019 18:16:05 +0700
Message-Id: <20190221111621.27180-6-pclouds@gmail.com>
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
index 5e16082091..0276f25200 100644
--- a/diff.c
+++ b/diff.c
@@ -4942,6 +4942,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "check", &options->output_format,
 			  N_("warn if changes introduce conflict markers or whitespace errors"),
 			  DIFF_FORMAT_CHECKDIFF, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "summary", &options->output_format,
+			  N_("condensed summary such as creations, renames and mode changes"),
+			  DIFF_FORMAT_SUMMARY, PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
@@ -4970,9 +4973,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--summary"))
-		options->output_format |= DIFF_FORMAT_SUMMARY;
-	else if (!strcmp(arg, "--patch-with-stat")) {
+	if (!strcmp(arg, "--patch-with-stat")) {
 		enable_patch_output(&options->output_format);
 		options->output_format |= DIFF_FORMAT_DIFFSTAT;
 	} else if (!strcmp(arg, "--name-only"))
-- 
2.21.0.rc1.337.gdf7f8d0522

