Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EB9220248
	for <e@80x24.org>; Fri, 29 Mar 2019 10:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfC2Kkm (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 06:40:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34749 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728732AbfC2Kkm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 06:40:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so1042818pgq.1
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 03:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d3yLKHIQY4MgBDrVTdQobRUujCLVNtYd9YhkxB2Of1U=;
        b=TE57MnQEOPXoW+gKnIjMO5aF/8YSzGlcMSMLrkT+Ie1nozGie8c8ZRABPAPcg88BZ6
         E1fgRa4IUq8w0RezgHBypA3OaRL6MvmaZipMQ3vxbmUEECS1rd7kwsQCIRo7pzIc3g9U
         bJdN2hUwCgQqLmuGT/zF4uisqlDgm2xIic+IVu7Nx3a+UdgN3bIs/TibMqHdXYYAhx3Z
         fuPyi6n6cwuiupnTHcOU/0AdJYnDZUOhRYheaPEE2hc5HPT0M6AXkNr40Fliiwp7AFCd
         oe2itAVhAoFgnQai1UmMjiqLzalRu7ngeOHhkAuYVRfzJLDmGt737Hjpl9psnZKxF1AQ
         pcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d3yLKHIQY4MgBDrVTdQobRUujCLVNtYd9YhkxB2Of1U=;
        b=f0PK5+oCZ5rjrv/6rgMm6/i5qN2GfnQy9ISP14gPl8xbOViQ/uyc1p/5VdHpNg+T0Y
         /VBOKuihWDQLvJ4RJ2/9VV12eEm9S5iC5jpp+pkwtapMbvtc/htYA93kcvd5mCaUScyZ
         IpuNybWIhHoxiXjtgTOxL4bdd4odZwOl1E52JJ57zrhyfwepJbdKVk/4Exo0t4ukparj
         Mcdf7LvgURSB4BoodxPlxR+NBtV7D+KemW1E/Moxa/MhBtlNtB71k/f2OEksj9zS+GVO
         0aiXu6KxF6SBg6j/IYm5DSzd+JtfLgg27Y8/p7oLI8bJiJsUGjSpgNjSWZzPgGL4E4ta
         bAsA==
X-Gm-Message-State: APjAAAVdqWTEYgsGD/3vA2OGuo8Kez4txduQRe4f07fQWrnGCUURwe5f
        CdYN4M70gRRGc1N+i/l7oy8=
X-Google-Smtp-Source: APXvYqxwu8s/ysqMDbPUvM2ZRcfy3IYix8Nf1rj1MI2aV4XzT2UBRfPfW8Nkb36dif7JPw0hFl7kuA==
X-Received: by 2002:aa7:8a92:: with SMTP id a18mr46761040pfc.218.1553856041508;
        Fri, 29 Mar 2019 03:40:41 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id m67sm2587947pfj.70.2019.03.29.03.40.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 03:40:40 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 29 Mar 2019 17:40:35 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v6 09/27] checkout: factor out some code in parse_branchname_arg()
Date:   Fri, 29 Mar 2019 17:39:01 +0700
Message-Id: <20190329103919.15642-10-pclouds@gmail.com>
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

This is in preparation for the new command restore, which also
needs to parse opts->source_tree but does not need all the
disambiguation logic.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 51 ++++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 15ee5181eb..897eefe16d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1081,6 +1081,34 @@ static int git_checkout_config(const char *var, const char *value, void *cb)
 	return git_xmerge_config(var, value, NULL);
 }
 
+static void setup_new_branch_info_and_source_tree(
+	struct branch_info *new_branch_info,
+	struct checkout_opts *opts,
+	struct object_id *rev,
+	const char *arg)
+{
+	struct tree **source_tree = &opts->source_tree;
+	struct object_id branch_rev;
+
+	new_branch_info->name = arg;
+	setup_branch_path(new_branch_info);
+
+	if (!check_refname_format(new_branch_info->path, 0) &&
+	    !read_ref(new_branch_info->path, &branch_rev))
+		oidcpy(rev, &branch_rev);
+	else
+		new_branch_info->path = NULL; /* not an existing branch */
+
+	new_branch_info->commit = lookup_commit_reference_gently(the_repository, rev, 1);
+	if (!new_branch_info->commit) {
+		/* not a commit */
+		*source_tree = parse_tree_indirect(rev);
+	} else {
+		parse_commit_or_die(new_branch_info->commit);
+		*source_tree = get_commit_tree(new_branch_info->commit);
+	}
+}
+
 static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
 				struct branch_info *new_branch_info,
@@ -1088,10 +1116,8 @@ static int parse_branchname_arg(int argc, const char **argv,
 				struct object_id *rev,
 				int *dwim_remotes_matched)
 {
-	struct tree **source_tree = &opts->source_tree;
 	const char **new_branch = &opts->new_branch;
 	int argcount = 0;
-	struct object_id branch_rev;
 	const char *arg;
 	int dash_dash_pos;
 	int has_dash_dash = 0;
@@ -1213,26 +1239,11 @@ static int parse_branchname_arg(int argc, const char **argv,
 	argv++;
 	argc--;
 
-	new_branch_info->name = arg;
-	setup_branch_path(new_branch_info);
-
-	if (!check_refname_format(new_branch_info->path, 0) &&
-	    !read_ref(new_branch_info->path, &branch_rev))
-		oidcpy(rev, &branch_rev);
-	else
-		new_branch_info->path = NULL; /* not an existing branch */
+	setup_new_branch_info_and_source_tree(new_branch_info, opts, rev, arg);
 
-	new_branch_info->commit = lookup_commit_reference_gently(the_repository, rev, 1);
-	if (!new_branch_info->commit) {
-		/* not a commit */
-		*source_tree = parse_tree_indirect(rev);
-	} else {
-		parse_commit_or_die(new_branch_info->commit);
-		*source_tree = get_commit_tree(new_branch_info->commit);
-	}
-
-	if (!*source_tree)                   /* case (1): want a tree */
+	if (!opts->source_tree)                   /* case (1): want a tree */
 		die(_("reference is not a tree: %s"), arg);
+
 	if (!has_dash_dash) {	/* case (3).(d) -> (1) */
 		/*
 		 * Do not complain the most common case
-- 
2.21.0.479.g47ac719cd3

