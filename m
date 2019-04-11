Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B05320248
	for <e@80x24.org>; Thu, 11 Apr 2019 13:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfDKNMt (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 09:12:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46175 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfDKNMt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 09:12:49 -0400
Received: by mail-pf1-f196.google.com with SMTP id 9so3424523pfj.13
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 06:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5fxda9l2kFx0WTwMmIrfiLIhHphGfG5U8X1Au3AxaLI=;
        b=k4N8LPJYsm7IwtwpsSLj4xRwWkSpfsZao9WEe1ZtqSF5LNrtSwvpKYl8RglTKm4pb/
         vCR85X3hBNe0G+tRqCu0y1blTlZ2dk88YOiVuMU7TzLabJNGjTyWMitYXOD7t+gBbuI0
         jt8yZru7ftuxWVmGXRhLi5VQ/4sjOCMoaEs6T2P8oEd0ERiUa7hHJR+Bxrlpn5YI8Lo+
         tS9yRC/bC1L9nf1xD4fVwLS7yvniNnqP0RFFGF/TdVX+QzqGVxr3MkQz5/TJJXjZcJvm
         pM2YCFXwUU3KmhYuYzdQDGeVhX+mmukCky6PO3GcPQ0hJDTexPDi0eZ7BzMWQJgghkBt
         bnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5fxda9l2kFx0WTwMmIrfiLIhHphGfG5U8X1Au3AxaLI=;
        b=tkGXBBo74sQJjdLaZcQ78iXK66zc6xo6hz8IdDSTBSO0dZ9ksUNK0PDNtive8KVRRm
         OlnZoNYQZj29wuYvAUXP2UBxIRtWCajdWJ5r52lFWE1lK4GusogNaNWXQOq7h0645mew
         hvQGbdCYrRddpogNNQsi6Icx/+haorJTPTlgYB9fUB5JHJSeuOQkyRb5s8Yi4ZuPgSuk
         vieHKyA/3eSnpA+hlAev5DG3GLpdK/1xvenPctoLPIvDlgGNyV4Vva3kR5u0DLqM5grF
         asZlSYcLHgKyLUlfPWpZL0NxDCOz2Czt+lBQFjFMpBMWfWbMnsEJIwk1TIy6XguQvOW5
         MN5w==
X-Gm-Message-State: APjAAAUufxKixDwN23ljlXhmKBi1Hemawi0DYQALSfTdixx27FMeLnq9
        FRywfjPDObm3rV49EKO4Z+w=
X-Google-Smtp-Source: APXvYqyAGDMX8ZydV6gF1t7jMtq5ISCyshrIpM6bkW66mb7lbnoydJpDCO/Zzau1JjI5Ee2PvCo7EA==
X-Received: by 2002:a63:2b0d:: with SMTP id r13mr46395868pgr.400.1554988368520;
        Thu, 11 Apr 2019 06:12:48 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id 71sm86147815pfs.36.2019.04.11.06.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 06:12:45 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 11 Apr 2019 20:12:40 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>, rybak.a.v@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        jacob.keller@gmail.com
Subject: [PATCH v2 02/16] restore: take tree-ish from --source option instead
Date:   Thu, 11 Apr 2019 20:12:04 +0700
Message-Id: <20190411131218.19195-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190411131218.19195-1-pclouds@gmail.com>
References: <20190308101655.9767-1-pclouds@gmail.com>
 <20190411131218.19195-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is another departure from 'git checkout' syntax, which uses -- to
separate ref and pathspec. The observation is restore (or "git
checkout -- <pathspec>") is most often used to restore some files from
the index. If this is correct, we can simplify it by taking away the
ref, so that we can write

    git restore some-file

without worrying about some-file being a ref and whether we need to do

    git restore -- some-file

for safety. If the source of the restore comes from a tree, it will be
in the form of an option with value, e.g.

    git restore --source=this-tree some-file

This is of course longer to type than using "--". But hopefully it
will not be used as often, and it is clearly easier to understand.

dwim_new_local_branch is no longer set (or unset) in cmd_restore_files()
because it's irrelevant because we don't really care about dwim-ing.
With accept_ref being unset, dwim can't happen.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 98dc2ded38..5aba345712 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -39,7 +39,7 @@ static const char * const switch_branch_usage[] = {
 };
 
 static const char * const restore_usage[] = {
-	N_("git restore [<options>] [<branch>] -- <file>..."),
+	N_("git restore [<options>] [--source=<branch>] <file>..."),
 	NULL,
 };
 
@@ -59,6 +59,7 @@ struct checkout_opts {
 	int overlay_mode;
 	int dwim_new_local_branch;
 	int discard_changes;
+	int accept_ref;
 	int accept_pathspec;
 	int switch_branch_doing_nothing_is_ok;
 	int only_merge_on_switching_branches;
@@ -76,6 +77,7 @@ struct checkout_opts {
 	int branch_exists;
 	const char *prefix;
 	struct pathspec pathspec;
+	const char *from_treeish;
 	struct tree *source_tree;
 };
 
@@ -1410,6 +1412,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 {
 	struct branch_info new_branch_info;
 	int dwim_remotes_matched = 0;
+	int parseopt_flags = 0;
 
 	memset(&new_branch_info, 0, sizeof(new_branch_info));
 	opts->overwrite_ignore = 1;
@@ -1421,8 +1424,13 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 
 	opts->track = BRANCH_TRACK_UNSPECIFIED;
 
-	argc = parse_options(argc, argv, prefix, options, usagestr,
-			     PARSE_OPT_KEEP_DASHDASH);
+	if (!opts->accept_pathspec && !opts->accept_ref)
+		BUG("make up your mind, you need to take _something_");
+	if (opts->accept_pathspec && opts->accept_ref)
+		parseopt_flags = PARSE_OPT_KEEP_DASHDASH;
+
+	argc = parse_options(argc, argv, prefix, options,
+			     usagestr, parseopt_flags);
 
 	if (opts->show_progress < 0) {
 		if (opts->quiet)
@@ -1481,7 +1489,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	 * including "last branch" syntax and DWIM-ery for names of
 	 * remote branches, erroring out for invalid or ambiguous cases.
 	 */
-	if (argc) {
+	if (argc && opts->accept_ref) {
 		struct object_id rev;
 		int dwim_ok =
 			!opts->patch_mode &&
@@ -1493,6 +1501,18 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 					     &dwim_remotes_matched);
 		argv += n;
 		argc -= n;
+	} else if (!opts->accept_ref && opts->from_treeish) {
+		struct object_id rev;
+
+		if (get_oid_mb(opts->from_treeish, &rev))
+			die(_("could not resolve %s"), opts->from_treeish);
+
+		setup_new_branch_info_and_source_tree(&new_branch_info,
+						      opts, &rev,
+						      opts->from_treeish);
+
+		if (!opts->source_tree)
+			die(_("reference is not a tree: %s"), opts->from_treeish);
 	}
 
 	if (argc) {
@@ -1576,6 +1596,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.dwim_new_local_branch = 1;
 	opts.switch_branch_doing_nothing_is_ok = 1;
 	opts.only_merge_on_switching_branches = 0;
+	opts.accept_ref = 1;
 	opts.accept_pathspec = 1;
 	opts.implicit_detach = 1;
 	opts.can_switch_when_in_progress = 1;
@@ -1611,6 +1632,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 1;
+	opts.accept_ref = 1;
 	opts.accept_pathspec = 0;
 	opts.switch_branch_doing_nothing_is_ok = 0;
 	opts.only_merge_on_switching_branches = 1;
@@ -1631,15 +1653,19 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 int cmd_restore(int argc, const char **argv, const char *prefix)
 {
 	struct checkout_opts opts;
-	struct option *options = NULL;
+	struct option *options;
+	struct option restore_options[] = {
+		OPT_STRING('s', "source", &opts.from_treeish, "<tree-ish>",
+			   N_("where the checkout from")),
+		OPT_END()
+	};
 	int ret;
 
 	memset(&opts, 0, sizeof(opts));
-	opts.dwim_new_local_branch = 1;
-	opts.switch_branch_doing_nothing_is_ok = 0;
+	opts.accept_ref = 0;
 	opts.accept_pathspec = 1;
 
-	options = parse_options_dup(options);
+	options = parse_options_dup(restore_options);
 	options = add_common_options(&opts, options);
 	options = add_checkout_path_options(&opts, options);
 
-- 
2.21.0.682.g30d2204636

