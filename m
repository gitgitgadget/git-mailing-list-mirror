Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D076820248
	for <e@80x24.org>; Fri,  8 Mar 2019 09:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfCHJ66 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 04:58:58 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40719 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfCHJ66 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 04:58:58 -0500
Received: by mail-pg1-f196.google.com with SMTP id u9so13756958pgo.7
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 01:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l1KAiUzOHdXPzGKXJtZsKPQoo/8tzKTIDnzlu+KHyh0=;
        b=NMMYCu5mZZEBB63uvWKxeODwdzGkLeKYF0nEXSAR2TAmOGR+s8YGmdqj8jpNlSN7EK
         nZrgXuLMugBOc9DWlRrlKrHTKJcodohX0w0QahP43+sQyjaPdN/xB+NLi8oLdwsr2Pnc
         MOPlcq4fkgoZKwdKTdn4mRNc3NVNZWDTqIqycRlNtibsNRXM606YX59X+uArNQZM2CtW
         BoWSQWjxsCorbyyC2l+6XTrKyAUV4xeO2QEGjxpbQZP/5iUc312BZR7wAFIPAIxc9KiO
         SwUIs1+h3gRIzucq7f29ZWH80zvG9tj4q0cAnQ4zMBSIgF3r8kh5d55twag0+b894dwi
         H8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l1KAiUzOHdXPzGKXJtZsKPQoo/8tzKTIDnzlu+KHyh0=;
        b=Qowx7RNpVUfaoaJUUCuJNrdPg52Gc06Oejm9jlt5minQB8IaUvTWGnctVGQ4i/P97X
         ntAuwv5bBGJmTZ+PPTppR2VwK29lQwEHnE1f6bM2ILPXsVGc0xqgQ5u7Lsk4kLdAVLfe
         uDSVA17kYMWZKPvmvQSUvjBbxsvNKL1i1DyrXckOL/csf6wh4qmLrniKSv3nCfZhFYV9
         /TYDQI/zj5UHDgHq8KeU2MfHrLQ04WKZ/JqKoXrUhcmC5zGHizondgq/eRU3IrvMmfev
         VLgR0A3UErTGb94/bBRKWXdMXlKv6YNKkwKlv5xRKWpy2ifURNnbl9oXWwuxJFWSv4/i
         P38Q==
X-Gm-Message-State: APjAAAW5zEWEdSucCAbtvqBAEdH+wGWVmenQxUrpPSZD2/5Rv4xQ/Top
        5GtS8DxYpXlhNuyEBD5vVDk=
X-Google-Smtp-Source: APXvYqwVUrYDIVZP/7nOB7hycXi0oRSPQKYMdjJlkpBTVdVyKD2bVFgMMnUVpXSAbAnekG7wIAjcPQ==
X-Received: by 2002:a63:fd03:: with SMTP id d3mr15614507pgh.359.1552039137823;
        Fri, 08 Mar 2019 01:58:57 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id n4sm18282615pfh.8.2019.03.08.01.58.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 01:58:57 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 16:58:52 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 11/21] switch: better names for -b and -B
Date:   Fri,  8 Mar 2019 16:57:42 +0700
Message-Id: <20190308095752.8574-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190308095752.8574-1-pclouds@gmail.com>
References: <20190208090401.14793-1-pclouds@gmail.com>
 <20190308095752.8574-1-pclouds@gmail.com>
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
index 1eff10dbef..4c3f0f6ac7 100644
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
2.21.0.rc1.337.gdf7f8d0522

