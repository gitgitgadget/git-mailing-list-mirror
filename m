Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A287A1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 11:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbfBULRD (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 06:17:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44044 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfBULRD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 06:17:03 -0500
Received: by mail-pf1-f194.google.com with SMTP id a3so3782938pff.11
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 03:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QyRAtZBqzMDqFoHD9L2pCScc1lzNrXPO4apEFtQPuB8=;
        b=W7SXVy2vn2DLUXcWn7KDeLnI4rpgHJS65d1h/gsWrzzgzrdwmmFEV9970LK9MOJyoN
         rSMpyJN9tqjb6mWS3et3by/BXycCMues5EbecRjcjtA69gzVp6FLchQXOyVeCMGpZMOX
         hixjdM6C9HhhHc29O31cA46vJuXjpSpIc2AgclSOMUgEpDlKIArDw1I/yeqL3CzsFywh
         ZgxvU6wxcx7XSrJU0XnzbQukIDDlGSHRvG6xGcTtbgPe/a5lU7MMMcKH8YxO3MwpzEQR
         eyANywpa+IpbbkFOg8liXOMX84PrgCddB4pYOvs6+dMY0qnW4vDhpZ+8x23IwH96m7yR
         BgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QyRAtZBqzMDqFoHD9L2pCScc1lzNrXPO4apEFtQPuB8=;
        b=Z3xFl3XMg9Lx+RqLtLBYPRtOWD1IpLXrxzY5pj1jLZexlvb1TIizkZdbfLeOuW42KM
         mJ+cb0S/hmA5aOtdNMWD7tvgM3Pq85f1geeEa4FyxVwFMKmjDYOSsfboJdTv+w04P+Iw
         6GZwJl8K6F4lM6aQH4gcmEMeR+lA6aliDh+HA0rSQudc3ElF3+YjHB3g0JXx4YYa8DIW
         9SkvzHtd8s4I8pijS3ZUycdjg7xZqMNCVAXNhLfNeEhHCl0DMgBQGl7c2lqhRaF6K5o/
         YplvdMgJUaw4mjJwPYiE4y+FefgmuVlqR60877wG8PBgZVGToA7a0f/HU10h207FAsli
         xUHg==
X-Gm-Message-State: AHQUAuZ8L0mvzlFFxui3tyHljCMvxs2BKa2VV5DlsxoK3WD+ae0ebQNU
        vlq0ShlXgYQaiRgpYsd3D8eMCOvx
X-Google-Smtp-Source: AHgI3IbgRxnBPT1J9FNvewPQSlfFUrjHgTvorPq5Bl2JrxUSVYX/t0JwA88CiUL3mU+g6bCxu52Cfw==
X-Received: by 2002:a63:4b0a:: with SMTP id y10mr25436927pga.66.1550747822581;
        Thu, 21 Feb 2019 03:17:02 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id b85sm30633080pfj.56.2019.02.21.03.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:17:01 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Feb 2019 18:16:57 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rybak.a.v@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 06/21] diff-parseopt: convert --patch-with-stat
Date:   Thu, 21 Feb 2019 18:16:06 +0700
Message-Id: <20190221111621.27180-7-pclouds@gmail.com>
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
 diff.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 0276f25200..b9811aefef 100644
--- a/diff.c
+++ b/diff.c
@@ -4921,6 +4921,10 @@ static void prep_parse_options(struct diff_options *options)
 			  N_("synonym for '-p --raw'"),
 			  DIFF_FORMAT_PATCH | DIFF_FORMAT_RAW,
 			  DIFF_FORMAT_NO_OUTPUT),
+		OPT_BITOP(0, "patch-with-stat", &options->output_format,
+			  N_("synonym for '-p --stat'"),
+			  DIFF_FORMAT_PATCH | DIFF_FORMAT_DIFFSTAT,
+			  DIFF_FORMAT_NO_OUTPUT),
 		OPT_BIT_F(0, "numstat", &options->output_format,
 			  N_("machine friendly --stat"),
 			  DIFF_FORMAT_NUMSTAT, PARSE_OPT_NONEG),
@@ -4973,10 +4977,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--patch-with-stat")) {
-		enable_patch_output(&options->output_format);
-		options->output_format |= DIFF_FORMAT_DIFFSTAT;
-	} else if (!strcmp(arg, "--name-only"))
+	if (!strcmp(arg, "--name-only"))
 		options->output_format |= DIFF_FORMAT_NAME;
 	else if (!strcmp(arg, "--name-status"))
 		options->output_format |= DIFF_FORMAT_NAME_STATUS;
-- 
2.21.0.rc1.337.gdf7f8d0522

