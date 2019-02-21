Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E67D51F462
	for <e@80x24.org>; Thu, 21 Feb 2019 11:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfBULSO (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 06:18:14 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41778 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfBULSO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 06:18:14 -0500
Received: by mail-pf1-f196.google.com with SMTP id d25so5251870pfn.8
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 03:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yXHB+MO8nmJb6cofOSQUcGc1JGjBSccypND0xddgwYQ=;
        b=q1TbA60mYWG+oXurhfhLbcZxzDR0ME2MuXCEZ/zQJIwjkm7+tEn11nEsbcPzFZTTox
         fTqgKhtrBKdOUnHh4WWUwHJWcyva5oM5Pd84rhVr3A6K+piCmf8wG63ciaUgFK2weYap
         rQVTjaQNbLrrYnzD5I6OOgfKiVNH7EFe/eZeC0dawH05tOajzMwYH5llncUSvlB1ChFf
         XOY/H8BQbGi+BKMccIWc4WJB93eG8ccng0H5DDkI7R9E5LsLMU0Lih6KTxSzX3QQA8az
         q8EiUsMyAjPVOLkPUQTPT5WOHlOZG2aEimQuRfB8MiwBbQfgqypeckkommQOnk+qHLb7
         H1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yXHB+MO8nmJb6cofOSQUcGc1JGjBSccypND0xddgwYQ=;
        b=OhoTYwuAViJlwrYqg+fShagx8iXiOeXC+I1EDdSU+ykz5nnEQrEgtkSdMeEV8C2Vhf
         3uEeML/Ly8uMZtUE9P7LDKw28qE1lmR8TQSdCGN0IhTy0FWuaEJW9plxQG+YByOqa/Fj
         z6ri1SGcmueSuNpUXathyC2T2ODzhuzhgl9xISogAsBXonIIS2SJMz3/vcDdVIyQaRvJ
         6xm8IGDHox4PTc8CjOhi1MDY0wtzguwSoDtWHUkStf7tnHzjhFNCDxnvkCNb2Iem/uPy
         lMjsU0N+oN7yytIT8aPalW6USGcGeP+zNgO38kT68TeZE/nxlUBQ4qWO5Hlhiw+4/AZ9
         dMsA==
X-Gm-Message-State: AHQUAubjO2VkFC4+P5cR2N9CapGRIcF/u3renathSpF9OItjhljHbrPx
        iMu56qb0wpCRT6pMMvtcnbyOId6V
X-Google-Smtp-Source: AHgI3IbiZXYD8Elh9fQSLRkXF35u0aAX/RpCtQ1AiPauPTYb0qL1mB4JcgI+n5eHWCXjExUOUXi6FA==
X-Received: by 2002:a65:6397:: with SMTP id h23mr32859511pgv.347.1550747893317;
        Thu, 21 Feb 2019 03:18:13 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id e9sm54360468pfb.52.2019.02.21.03.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:18:12 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Feb 2019 18:18:08 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rybak.a.v@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 20/21] diff-parseopt: convert --[no-]minimal
Date:   Thu, 21 Feb 2019 18:16:20 +0700
Message-Id: <20190221111621.27180-21-pclouds@gmail.com>
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
 diff.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index b9c267a199..33492e754f 100644
--- a/diff.c
+++ b/diff.c
@@ -5105,6 +5105,11 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BOOL(0, "rename-empty", &options->flags.rename_empty,
 			 N_("use empty blobs as rename source")),
 
+		OPT_GROUP(N_("Diff algorithm options")),
+		OPT_BIT(0, "minimal", &options->xdl_opts,
+			N_("produce the smallest possible diff"),
+			XDF_NEED_MINIMAL),
+
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
 			       N_("when run from subdir, exclude changes outside and show relative paths"),
@@ -5142,11 +5147,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* xdiff options */
-	if (!strcmp(arg, "--minimal"))
-		DIFF_XDL_SET(options, NEED_MINIMAL);
-	else if (!strcmp(arg, "--no-minimal"))
-		DIFF_XDL_CLR(options, NEED_MINIMAL);
-	else if (!strcmp(arg, "-w") || !strcmp(arg, "--ignore-all-space"))
+	if (!strcmp(arg, "-w") || !strcmp(arg, "--ignore-all-space"))
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE);
 	else if (!strcmp(arg, "-b") || !strcmp(arg, "--ignore-space-change"))
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_CHANGE);
-- 
2.21.0.rc1.337.gdf7f8d0522

