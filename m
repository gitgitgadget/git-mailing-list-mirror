Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 816F720248
	for <e@80x24.org>; Thu, 21 Mar 2019 13:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfCUNSo (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 09:18:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40086 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbfCUNSn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 09:18:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id c207so4275861pfc.7
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 06:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jkGSFpma4/a2Zgk1mBUxf3RvxnKUIEFCE4qjgChO6io=;
        b=eaMdQ8WoiNH2deT1izWPdpupnY7cU0lU6jfPODyBSchYDV0O8z8l6hDTkVf4Wcl+n0
         u2vQRA4LD7j3vty7PHl6x2jtGdeE+kaGvcj6CXoi5kXScVRe2euL7EAtGRkBF+UetUH2
         Tj8qDRz7yfzLtKAR+6i1YfEWl/oD2SpLvz0zN/ENHve6WgKXWx3UJv1GA1jDwJtkHbQb
         7yh4XVM0QqSKkZQR1+Pe3RENWFSnFYtLZ62bnuWZOwQlq9oDk2Guy82RnpxxvQQa23UB
         nemmOQnRI2VIWqI2uIo6l7zEilCYFYElWkWLhroON/ltj6J3063XalMfRUoOusHaHp8i
         uBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jkGSFpma4/a2Zgk1mBUxf3RvxnKUIEFCE4qjgChO6io=;
        b=XyeIsupL3fNeE4fn5MjWuh3SulzYcLBIaPxuer33lPLpp+H4OHqI72/5jTbylR9twA
         spD8nzE7bngZ0YtgyX6RXCEpdcn0MX31HU8n/6tgm9xEWuI6W+2jFNapUd3lD+2YIiJ/
         BeO8SU3OqAymzr36mRr6v3H4xMz8QXTUk2cPL8Vev+Bqo9WeB+erKNGvNULtaF2MQ0jE
         Pxdt4vKK/HL6j/lkmcbKcuqA5lu43X+sGpC0gk+cG49vTTz2GXeI7Ez+XBijGq0rOgGc
         VpAKg0DDEqyfCWlZrp6aMDJO1/9WmGdeYnm/GCpoNuu4u2oAA+R/4Owi9rLMk7XiiKoS
         P+Vw==
X-Gm-Message-State: APjAAAU6yUVwm6jI0v4GbIvYLyMgt1fCtL29ny1i9URy3DYKTcZZau68
        kkFa/PKHD+hhgHSIOdZY/10=
X-Google-Smtp-Source: APXvYqynfsos52Kr4DYCm6c8u+YO8GQULCvTlfGokyH6fw972BJ1yr2/S1HeQIemnNZOTehkO5vIBA==
X-Received: by 2002:a65:6299:: with SMTP id f25mr3327350pgv.376.1553174321783;
        Thu, 21 Mar 2019 06:18:41 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id j14sm7316827pfn.77.2019.03.21.06.18.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 06:18:40 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Mar 2019 20:18:35 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v5 13/26] switch: better names for -b and -B
Date:   Thu, 21 Mar 2019 20:16:42 +0700
Message-Id: <20190321131655.15249-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190321131655.15249-1-pclouds@gmail.com>
References: <20190317124926.17137-1-pclouds@gmail.com>
 <20190321131655.15249-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The shortcut of these options do not make much sense when used with
switch. And their descriptions are also tied to checkout. Move -b/-B
to cmd_checkout() and new -c/-C with the same functionality in
cmd_switch_branch()
---
 builtin/checkout.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index dd3c200cb5..400a0d5620 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1368,14 +1368,10 @@ static struct option *add_common_options(struct checkout_opts *opts,
 	return newopts;
 }
 
-static struct option *add_switch_branch_options(struct checkout_opts *opts,
-						struct option *prevopts)
+static struct option *add_common_switch_branch_options(
+	struct checkout_opts *opts, struct option *prevopts)
 {
 	struct option options[] = {
-		OPT_STRING('b', NULL, &opts->new_branch, N_("branch"),
-			   N_("create and checkout a new branch")),
-		OPT_STRING('B', NULL, &opts->new_branch_force, N_("branch"),
-			   N_("create/reset and checkout a branch")),
 		OPT_BOOL('l', NULL, &opts->new_branch_log, N_("create reflog for new branch")),
 		OPT_BOOL(0, "detach", &opts->force_detach, N_("detach HEAD at named commit")),
 		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
@@ -1571,15 +1567,22 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 int cmd_checkout(int argc, const char **argv, const char *prefix)
 {
 	struct checkout_opts opts;
-	struct option *options = NULL;
+	struct option *options;
+	struct option checkout_options[] = {
+		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
+			   N_("create and checkout a new branch")),
+		OPT_STRING('B', NULL, &opts.new_branch_force, N_("branch"),
+			   N_("create/reset and checkout a branch")),
+		OPT_END()
+	};
 	int ret;
 
 	memset(&opts, 0, sizeof(opts));
 	opts.no_dwim_new_local_branch = 0;
 
-	options = parse_options_dup(options);
+	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
-	options = add_switch_branch_options(&opts, options);
+	options = add_common_switch_branch_options(&opts, options);
 	options = add_checkout_path_options(&opts, options);
 
 	ret = checkout_main(argc, argv, prefix, &opts,
@@ -1592,14 +1595,21 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 {
 	struct checkout_opts opts;
 	struct option *options = NULL;
+	struct option switch_options[] = {
+		OPT_STRING('c', "create", &opts.new_branch, N_("branch"),
+			   N_("create and switch to a new branch")),
+		OPT_STRING('C', "force-create", &opts.new_branch_force, N_("branch"),
+			   N_("create/reset and switch to a branch")),
+		OPT_END()
+	};
 	int ret;
 
 	memset(&opts, 0, sizeof(opts));
 	opts.no_dwim_new_local_branch = 0;
 
-	options = parse_options_dup(options);
+	options = parse_options_dup(switch_options);
 	options = add_common_options(&opts, options);
-	options = add_switch_branch_options(&opts, options);
+	options = add_common_switch_branch_options(&opts, options);
 
 	ret = checkout_main(argc, argv, prefix, &opts,
 			    options, switch_branch_usage);
-- 
2.21.0.548.gd3c7d92dc2

