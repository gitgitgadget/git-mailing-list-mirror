Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F6451F453
	for <e@80x24.org>; Wed, 30 Jan 2019 09:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbfA3JtW (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 04:49:22 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37484 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730329AbfA3JtV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 04:49:21 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so11179311pfb.4
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 01:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YXbFRl2H6CJd5ifq5Q0k8LlrW/Wtxny1t6TN4DT/Q08=;
        b=OsXV/LWc+iVlTVGtYbno6qLgjad5nHI+Q2T9On689wWgTaQPUBCGS7/6D7i5I7NaXG
         PvhmMZTd3SOxVahGG4/kVGyyWYRlJfVOdxk0CwpIqCHgjWmTJVqIAAKGdd/bjbEbnIat
         kmRhS9kqSxvRbDw7GcHhNOMkmX8Rrrn30vHfr9Ylg5Fi1fUt0We51+ZksSttwEzNOWKh
         Wp3Yoe/Dobhv0sPNtzXkloab+wKXSK63cVUDq+lfhnngISw8JjazWa1kkOFCMNwlP+Vi
         BHXERzUb9tpX/ztCH15TW/KKFlYa9oh+4eL/mlF2ftWbUFjSwBouKM4ANizNAC4E2xi3
         qPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YXbFRl2H6CJd5ifq5Q0k8LlrW/Wtxny1t6TN4DT/Q08=;
        b=n+SVcoBlSOsMBuQHbdggjiwkuer1eD5+Q7qx38Ayt8sjYcAUB3mUFu3mTq9LQc4Epm
         rLS+rNn2rp32iiENN1WlXDpCZP8/F0pBkDO2GEzIMKXuDJK5ou4e31+pRouJn0M1G3eG
         4PsxpVaE8ZgPvnzZ1sJYDZm8w/tuUNl3aUA1U0mYQbYdgrIfAHh7S6wPDX4JjFD6dSfD
         TV6Z78kAlc8pwFtf9Wm9f/SFe+K7CfozoX0e0Nq5fDr7A1ZHpf9DpOT2Dg3EL7SBxZOa
         1O47ss+OCECeH57h9aFUYjkc7lBU1KbBnRFAqwXFrzdB9uH/Y5YHQ9Lhu5TaIWiM+bIT
         DwwQ==
X-Gm-Message-State: AJcUukciM7mwJPLLYS4bc3UPjeUBitRGROrjWxBHprIQR/rgBab0wRxs
        aHaxaLJtBMVTkEJQYgHrH4ICmROi
X-Google-Smtp-Source: ALg8bN5YSfQWn8y0rnKFz/M7ICvZ9YFT/uJqab5XGXtC1nNnTMcXBdQ2zlP+BTMiZU/72UEMhNHD0A==
X-Received: by 2002:a65:55ca:: with SMTP id k10mr26630543pgs.448.1548841760537;
        Wed, 30 Jan 2019 01:49:20 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id x11sm5471246pfe.72.2019.01.30.01.49.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:49:19 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 30 Jan 2019 16:49:16 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/19] switch: better names for -b and -B
Date:   Wed, 30 Jan 2019 16:48:21 +0700
Message-Id: <20190130094831.10420-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190130094831.10420-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The shortcut of these options do not make much sense when used with
switch. And their descriptions are also tied to checkout
out. Move -b/-B to cmd_checkout() and new -c/-C with the same
functionality in cmd_switch_branch()

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2ac53b4302..2251883a88 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1353,14 +1353,10 @@ static struct option *add_common_options(struct checkout_opts *opts,
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
@@ -1556,15 +1552,22 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
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
@@ -1577,14 +1580,21 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 {
 	struct checkout_opts opts;
 	struct option *options = NULL;
+	struct option switch_options[] = {
+		OPT_STRING('c', "create", &opts.new_branch, N_("branch"),
+			   N_("create and switch to a new branch")),
+		OPT_STRING('C', "force-create", &opts.new_branch_force, N_("branch"),
+			   N_("create/reset and switch to a new branch")),
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
2.20.1.682.gd5861c6d90

