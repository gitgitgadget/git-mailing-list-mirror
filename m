Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 456A31F453
	for <e@80x24.org>; Fri,  8 Feb 2019 09:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfBHJEr (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 04:04:47 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33207 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfBHJEq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 04:04:46 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so1397000pfb.0
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 01:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sQk9AT2smGrSAzGg2LXGB/pZY5NLA2Xrmm1iKFp6AOE=;
        b=c7oD7J+Olq3rcuper5f9jlRHIQctTWepNvLGXJT8FEJQe2KM6et47OwgZ4tEBgBmzz
         q9bUd9cG7xahlWUW1pYMaRxxrLISX2E0AleLWXSPo8uBBvczqMK2bKDmZgkPaaYuJCz3
         iK0dCdJh5aC0zudza+klF0wn7s0rEn3lI3lfYOSc5bk2K88Hj4MobhuUHBekgRB9B/+8
         0LJazGuxJLSGwXqe6GTYiuDZwUeyw8y+qGy113GO5XaVYRLb8rl64wKLA2pYDyZr7/lU
         y8cg//npuHloO5KJqjjNLzgwGHGko32NWQw6UDbjZfuMF3v153o4FxY1TRMDS1JlX1UG
         jF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sQk9AT2smGrSAzGg2LXGB/pZY5NLA2Xrmm1iKFp6AOE=;
        b=oFpWA+Ya+soYkQbUFLrBtr81Zh87ERrQ35n6l1A9XsXOCDdCS7Se46zPx3SHex5/6F
         1eEVE3Fx3w2tCnGihhEW8maU8h7pScD+CZRJjpCREbot9+z6+wcHWedgdJeXDA5MNA35
         hFoSzp0mYO13ZXnmiYWKww6fzEG+lQoa0tKc8qkyJGVqZvTn3WfEruHDuTDTEZdoxH+G
         Jx6jFLLbdiZ4ljEJbUaTwThrnyA3ktD2I6zkMx5lmNM/RKCvM63KQNPtkWO9i1fvRtUk
         veFlDhiMxRo48JMh/oWyvq+rvBUKrXcBUdJ/P0R6bKF2FmKsD1Kh6kbHMZFqL5jtZFPk
         lMvQ==
X-Gm-Message-State: AHQUAuYnByxfwDXr0n+R3IdiQLSsH0+sp2xOeAZFyBHqtVYR6r0B7oJc
        LBkwI/TCbQdJ94wZZTjZBVU=
X-Google-Smtp-Source: AHgI3IbjFA/hsR3ZSDp+22NIhOBm8VXwpIPWicrKl6OO6AwA7gyv1zQcJow5623VglLLn9cLpZzxiA==
X-Received: by 2002:a63:a41:: with SMTP id z1mr14571151pgk.117.1549616686011;
        Fri, 08 Feb 2019 01:04:46 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id q187sm3469149pfq.128.2019.02.08.01.04.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 01:04:45 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Feb 2019 16:04:40 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/19] checkout: factor out some code in parse_branchname_arg()
Date:   Fri,  8 Feb 2019 16:03:46 +0700
Message-Id: <20190208090401.14793-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190208090401.14793-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
 <20190208090401.14793-1-pclouds@gmail.com>
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
index f63d864a91..12b7e08d4e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1068,6 +1068,34 @@ static int git_checkout_config(const char *var, const char *value, void *cb)
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
@@ -1075,10 +1103,8 @@ static int parse_branchname_arg(int argc, const char **argv,
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
@@ -1200,26 +1226,11 @@ static int parse_branchname_arg(int argc, const char **argv,
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
2.20.1.682.gd5861c6d90

