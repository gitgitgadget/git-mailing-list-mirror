Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 066D91F462
	for <e@80x24.org>; Thu, 21 Feb 2019 11:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfBULSK (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 06:18:10 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33341 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfBULSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 06:18:09 -0500
Received: by mail-pf1-f194.google.com with SMTP id i19so586391pfd.0
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 03:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r+IoTu+5nGfYAI5Wxu/4xsWNz0YtQsh3jxogcADZQwU=;
        b=g+RLRdgmtKKNIvcyrPq+Eo8eGTmo38NXx/rPp/0sT+GsA8LS0MR8pRkJj+9GOL3ARo
         X/f482DLiLzwgXZqWJTDUHm1amMhy1gyufutmfgEKiZE4Qg9QcTdhj+tc3vIU95NccJI
         ePlWuHPRsu224oUBxUwwmp7kUmq2q6yCFtZdzxJ6UX7ByGKsCHzQGORMqTkhFKVPVkbj
         KOuS1syhIIHPkb9bFVxyED8oZv0oBQN6yEnIrHdUSb2vb5iTjLv1U6gM0LkJ3wJcloy7
         gJWwQlNmkGAFUa6S1meF3Z0JBElYpqGcE3cMft69mLU3YCHZV2gYDPoFhej9ydeO4REK
         8vuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r+IoTu+5nGfYAI5Wxu/4xsWNz0YtQsh3jxogcADZQwU=;
        b=aZVLLWEC9cJmFRCtFFhdZ8mlbln44XTcAf+URUCyHVH+iCDkdHhc+ac554FiMQnoau
         SPdRVXuj/Nr6NVvJv6DJEJ2tSKCkRzX4UAoa/kCjLKs+jb4JgSTulTI+aRiqeFt/36Mh
         9kusQxOCBuPMjthORQfMNCwbDTW8CYACazYm3tTYbfpVFT2iVzlzU6lsjLvaABNEGysP
         Jf14gUIMn1kugJZDR5WLsT3XLYb32iusoVItRXnN0QKLH57Md9noKm7tWWDL3QISoJz5
         VcvX4VrifmuSDuQgpvbcXt0Lox6Oy8E7Q55EV3xfXjbPwFt49tOv3wvEcbRkYz1ywFzC
         fXqg==
X-Gm-Message-State: AHQUAuZf22/ax8lWKIy9Kk/RxU6vfESg4pWKLhJPefRybM1n6LBany0u
        O4venUqAaDDtQg2ShLi8HciCSTov
X-Google-Smtp-Source: AHgI3IZ3wX9A0t8JIodZTe7aZDLaPbhqRnmVyZfg8WJtub8aKioZeXjbd8Xj1kTIChpMBHBHLXo8Jw==
X-Received: by 2002:a63:c503:: with SMTP id f3mr33373901pgd.431.1550747888399;
        Thu, 21 Feb 2019 03:18:08 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id x1sm25290524pge.73.2019.02.21.03.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:18:07 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Feb 2019 18:18:03 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rybak.a.v@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 19/21] diff-parseopt: convert --relative
Date:   Thu, 21 Feb 2019 18:16:19 +0700
Message-Id: <20190221111621.27180-20-pclouds@gmail.com>
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
 diff.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index d423a06b41..b9c267a199 100644
--- a/diff.c
+++ b/diff.c
@@ -4960,6 +4960,18 @@ static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
 	return 0;
 }
 
+static int diff_opt_relative(const struct option *opt,
+			     const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	options->flags.relative_name = 1;
+	if (arg)
+		options->prefix = arg;
+	return 0;
+}
+
 static int diff_opt_unified(const struct option *opt,
 			    const char *arg, int unset)
 {
@@ -5094,6 +5106,10 @@ static void prep_parse_options(struct diff_options *options)
 			 N_("use empty blobs as rename source")),
 
 		OPT_GROUP(N_("Diff other options")),
+		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
+			       N_("when run from subdir, exclude changes outside and show relative paths"),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
+			       diff_opt_relative),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5125,15 +5141,8 @@ int diff_opt_parse(struct diff_options *options,
 	if (ac)
 		return ac;
 
-	/* renames options */
-	if (skip_to_optional_arg_default(arg, "--relative", &arg, NULL)) {
-		options->flags.relative_name = 1;
-		if (arg)
-			options->prefix = arg;
-	}
-
 	/* xdiff options */
-	else if (!strcmp(arg, "--minimal"))
+	if (!strcmp(arg, "--minimal"))
 		DIFF_XDL_SET(options, NEED_MINIMAL);
 	else if (!strcmp(arg, "--no-minimal"))
 		DIFF_XDL_CLR(options, NEED_MINIMAL);
-- 
2.21.0.rc1.337.gdf7f8d0522

