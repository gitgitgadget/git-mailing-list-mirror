Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86B6720248
	for <e@80x24.org>; Fri, 29 Mar 2019 10:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbfC2KlQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 06:41:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:47009 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729003AbfC2KlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 06:41:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id q1so1012268pgv.13
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 03:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UCeqqL18hPi8CwUrr5S0NZC1/O5Ua+qAL6Ewr6JQeKk=;
        b=sTRWSKFoGoTcR23hvHa8jl5sq+FSLfL321kOWvvOcciNbs5SSvEbdKwRyXCTATKKUZ
         xkpayD05PkcTc7RK8DtlvdAvEKX2m7s6K2I05j0IvRq6N7s4rAghpELgU8mSOz0wQYnH
         IeOSsiV6LBgP/8YEG6KKitOr3BJ3OUww7AQxP36ivIk62lujRqqE0u9y1j6LqIVhr2GP
         ZlCJrKnNuzj5kBzdB7g+JPmA45CSZASn2CTQbu+qCRL/wBK5mHqJyP+ExtVfg5ITD+Nb
         nfSn10MppPTcokTYFc49q1O93zB2cqkDxf6zKlceju8dK+XtEb8tFvz2kkM9YUIBKEC6
         VxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UCeqqL18hPi8CwUrr5S0NZC1/O5Ua+qAL6Ewr6JQeKk=;
        b=tiRALTkCsDuilx62fdQDaXDJJdVNjfz4aOFJAWmv8jtos1EJ8fTiHSIe2TAOlNSxo6
         +JEdOb6kiweloIhaK20MFihS5wrU0UsMTTtSP0TxlU90zvh/zutc9P5ir4aVYOzNv/j/
         8IAqFpgquA9h5bQzfbc+7ygqp7bVxGVLpR31ES4jyrk6JiF5Hce4jdfknM+qqSxcJnp4
         TET2bTm1onZ/oE+gf24lm71CuEu0imB0x3Zb7f7RFBGUhnRMcXMIIdB+RfweZCjZIoOW
         WaUTaEuEpdRveK/F11wE+Q4pdcUiP4G5VMV1FeUowl9o6Ylo4yaSLcDGyA017rvFBVPp
         3Lgw==
X-Gm-Message-State: APjAAAUGjia1akLo2Tg5LKQnD/HILHuwa6uNQyk2LT6/hz/WaTx7aQmi
        AtHIAC0JNsQhcuyhJT0L/B0=
X-Google-Smtp-Source: APXvYqww4j99b87O/rRrhecxPOAzkvOMH703PQk6qkMbNcP4rxP2lwoPVUAfl36c0n88PhqJIYfQ8A==
X-Received: by 2002:aa7:8d42:: with SMTP id s2mr14104139pfe.116.1553856075131;
        Fri, 29 Mar 2019 03:41:15 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id w3sm3346902pfn.179.2019.03.29.03.41.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 03:41:14 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 29 Mar 2019 17:41:08 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v6 14/27] switch: better names for -b and -B
Date:   Fri, 29 Mar 2019 17:39:06 +0700
Message-Id: <20190329103919.15642-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190329103919.15642-1-pclouds@gmail.com>
References: <20190321131655.15249-1-pclouds@gmail.com>
 <20190329103919.15642-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The shortcut of these options do not make much sense when used with
switch. And their descriptions are also tied to checkout. Move -b/-B
to cmd_checkout() and new -c/-C with the same functionality in
cmd_switch_branch()

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4989ca73a3..319ba372e3 100644
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
2.21.0.479.g47ac719cd3

