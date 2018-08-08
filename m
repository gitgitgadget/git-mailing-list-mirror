Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81C041F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbeHHVUf (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:20:35 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:53886 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730552AbeHHVUf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:20:35 -0400
Received: by mail-wm0-f50.google.com with SMTP id s9-v6so3807450wmh.3
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9DVl3/f5U3XfTOC+gu3iYSlluo5icrcUXxRsYt4E0UA=;
        b=Zi5ywkMzV/FiFLce9knukdNK7tllVyawT4x5i828+IB5KsyAQWvAzZl61ep04TZM5/
         ss16VIaKbmxsneodm94s+kfCgZ5HUMyw6kkPfH59+dcRQ6uJh9qgNDyjO7XR/zVwRXYQ
         CwOC3xogIb9+HPOr61HQYCtSR3Fz27r3ZU1QDpgzemc9BJBb1EPQNfM7X1Pmk8OG0TW9
         2JaM9kcghoRRH7wbnb9eMvSoPXeT2Czl2/esxZVP/KQ4wBLEQqkZ0FC/qKBbqUBvPydd
         U8s5SFvqMd93Gvv80LHPEsKSLr6jFX5KROhJa1FaFK1XIKtugb/d66ri8ztoTP93VjJl
         Pcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9DVl3/f5U3XfTOC+gu3iYSlluo5icrcUXxRsYt4E0UA=;
        b=iqHO1BbX/j4zjV/dmhYixqS7UQazobtYCjfqpSvqim4Nr2gTmZgVOSL7M28psVjuM7
         PlANiLxApRkbuGNn5lddDuPAkgPc3+HPFIiAQAuAFnQVryHkstuBIQZf+cDXkn4OTn+S
         GDEwuRvS6A/GwuH7aIzISZ6qq9DBgzT6Fc2EzV3Izq2sj8i4ufPVGqCb35FoSJXKUDGi
         GpM4oaVbgk8qekE9qHXK7boY7gjYmYQ/mueXoDhjG3b0X7z7siSFfSXcIu/hRVOlf0SQ
         tc5tPcXiVj3TGNXY+Luq2O7Y82AqlVSZMSbttjzGrVwTjlX218hylFcT0CgZnbOKkntF
         AhPg==
X-Gm-Message-State: AOUpUlFlhou20bubY265Vrie169o2NkvDIlYTp6CY9+wmY38ofiXVIVG
        Xi/lqS/S+ZNUiWuVcvbIsk4tdI9m
X-Google-Smtp-Source: AA+uWPzbtLzMJd2ul1gcTIIocOYzjkhykAp5W7VrzVbAWQ70/lQzLDCL1SvEznAkH7DCj5bzrAmCQw==
X-Received: by 2002:a1c:f30d:: with SMTP id q13-v6mr2595007wmq.36.1533754773017;
        Wed, 08 Aug 2018 11:59:33 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([86.127.74.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm4238879wre.32.2018.08.08.11.59.32
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 11:59:32 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v7 18/26] stash: convert push to builtin
Date:   Wed,  8 Aug 2018 21:58:57 +0300
Message-Id: <b41bff3b5188ac014f9cb5024e535d6804ef1834.1533753605.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.573.g56500d98f
In-Reply-To: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add stash push to the helper.
---
 builtin/stash--helper.c | 209 ++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            |   6 +-
 2 files changed, 213 insertions(+), 2 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index f905d3908..c26cad3d5 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -23,6 +23,9 @@ static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper clear"),
 	N_("git stash--helper store [-m|--message <message>] [-q|--quiet] <commit>"),
 	N_("git stash--helper create [<message>]"),
+	N_("git stash--helper [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
+	   "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
+	   "          [--] [<pathspec>...]]"),
 	NULL
 };
 
@@ -71,6 +74,13 @@ static const char * const git_stash_helper_create_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_push_usage[] = {
+	N_("git stash--helper [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
+	   "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
+	   "          [--] [<pathspec>...]]"),
+	NULL
+};
+
 static const char *ref_stash = "refs/stash";
 static int quiet;
 static struct strbuf stash_index_path = STRBUF_INIT;
@@ -1210,6 +1220,203 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 	return ret < 0;
 }
 
+static int do_push_stash(int argc, const char **argv, const char *prefix,
+			 int keep_index, int patch_mode, int include_untracked,
+			 int quiet, const char *stash_msg)
+{
+	int ret = 0;
+	struct pathspec ps;
+	struct stash_info info;
+	if (patch_mode && keep_index == -1)
+		keep_index = 1;
+
+	if (patch_mode && include_untracked) {
+		fprintf_ln(stderr, "Can't use --patch and --include-untracked or --all at the same time");
+		return -1;
+	}
+
+	parse_pathspec(&ps, 0, PATHSPEC_PREFER_FULL, prefix, argv);
+
+	if (read_cache() < 0)
+		die(_("index file corrupt"));
+
+	if (!include_untracked && ps.nr) {
+		int i;
+		char *ps_matched = xcalloc(ps.nr, 1);
+
+		for (i = 0; i < active_nr; ++i) {
+			const struct cache_entry *ce = active_cache[i];
+			if (!ce_path_match(ce, &ps, ps_matched))
+				continue;
+		}
+
+		if (report_path_error(ps_matched, &ps, prefix)) {
+			fprintf_ln(stderr, "Did you forget to 'git add'?");
+			return -1;
+		}
+	}
+
+	read_cache_preload(NULL);
+	if (refresh_cache(REFRESH_QUIET))
+		return -1;
+
+	if (!check_changes(argv, include_untracked, prefix)) {
+		fprintf_ln(stdout, "No local changes to save");
+		return 0;
+	}
+
+	if (!reflog_exists(ref_stash) && do_clear_stash()) {
+		fprintf_ln(stderr, "Cannot initialize stash");
+		return -1;
+	}
+
+	if ((ret = do_create_stash(argc, argv, prefix, &stash_msg,
+				   include_untracked, patch_mode, &info)))
+		return ret;
+
+	if (do_store_stash(oid_to_hex(&info.w_commit), stash_msg, 1)) {
+		fprintf(stderr, "Cannot save the current status");
+		return -1;
+	}
+
+	fprintf(stdout, "Saved working directory and index state %s", stash_msg);
+
+	if (!patch_mode) {
+		if (include_untracked && ps.nr == 0) {
+			struct child_process cp = CHILD_PROCESS_INIT;
+
+			cp.git_cmd = 1;
+			argv_array_pushl(&cp.args, "clean", "--force",
+					 "--quiet", "-d", NULL);
+			if (include_untracked == 2)
+				argv_array_push(&cp.args, "-x");
+			if (run_command(&cp))
+				return -1;
+		}
+		if (argc != 0) {
+			int i;
+			struct child_process cp1 = CHILD_PROCESS_INIT;
+			struct child_process cp2 = CHILD_PROCESS_INIT;
+			struct child_process cp3 = CHILD_PROCESS_INIT;
+			struct strbuf out = STRBUF_INIT;
+
+			cp1.git_cmd = 1;
+			argv_array_push(&cp1.args, "add");
+			if (!include_untracked)
+				argv_array_push(&cp1.args, "-u");
+			if (include_untracked == 2)
+				argv_array_push(&cp1.args, "--force");
+			argv_array_push(&cp1.args, "--");
+			for (i = 0; i < ps.nr; ++i)
+				argv_array_push(&cp1.args, ps.items[i].match);
+			if (run_command(&cp1))
+				return -1;
+
+			cp2.git_cmd = 1;
+			argv_array_pushl(&cp2.args, "diff-index", "-p",
+					 "--cached", "--binary", "HEAD", "--",
+					 NULL);
+			for (i = 0; i < ps.nr; ++i)
+				argv_array_push(&cp2.args, ps.items[i].match);
+			if (pipe_command(&cp2, NULL, 0, &out, 0, NULL, 0))
+				return -1;
+
+			cp3.git_cmd = 1;
+			argv_array_pushl(&cp3.args, "apply", "--index", "-R",
+					 NULL);
+			if (pipe_command(&cp3, out.buf, out.len, NULL, 0, NULL,
+					 0))
+				return -1;
+		} else {
+			struct child_process cp = CHILD_PROCESS_INIT;
+			cp.git_cmd = 1;
+			argv_array_pushl(&cp.args, "reset", "--hard", "-q",
+					 NULL);
+			if (run_command(&cp))
+				return -1;
+		}
+
+		if (keep_index == 1 && !is_null_oid(&info.i_tree)) {
+			int i;
+			struct child_process cp1 = CHILD_PROCESS_INIT;
+			struct child_process cp2 = CHILD_PROCESS_INIT;
+			struct strbuf out = STRBUF_INIT;
+
+			if (reset_tree(&info.i_tree, 0, 1))
+				return -1;
+
+			cp1.git_cmd = 1;
+			argv_array_pushl(&cp1.args, "ls-files", "-z",
+					 "--modified", "--", NULL);
+			for (i = 0; i < ps.nr; ++i)
+				argv_array_push(&cp1.args, ps.items[i].match);
+			if (pipe_command(&cp1, NULL, 0, &out, 0, NULL, 0))
+				return -1;
+
+			cp2.git_cmd = 1;
+			argv_array_pushl(&cp2.args, "checkout-index", "-z",
+					 "--force", "--stdin", NULL);
+			if (pipe_command(&cp2, out.buf, out.len, NULL, 0, NULL,
+					 0))
+				return -1;
+		}
+	} else {
+		struct child_process cp = CHILD_PROCESS_INIT;
+
+		cp.git_cmd = 1;
+		argv_array_pushl(&cp.args, "apply", "-R", NULL);
+
+		if (pipe_command(&cp, patch.buf, patch.len, NULL, 0, NULL, 0)) {
+			fprintf_ln(stderr, "Cannot remove worktree changes");
+			return -1;
+		}
+
+		if (keep_index < 1) {
+			int i;
+			struct child_process cp = CHILD_PROCESS_INIT;
+
+			cp.git_cmd = 1;
+			argv_array_pushl(&cp.args, "reset", "-q", "--", NULL);
+			for (i = 0; i < ps.nr; ++i)
+				argv_array_push(&cp.args, ps.items[i].match);
+			if (run_command(&cp))
+				return -1;
+		}
+	}
+	return 0;
+}
+
+static int push_stash(int argc, const char **argv, const char *prefix)
+{
+	int keep_index = -1;
+	int patch_mode = 0;
+	int include_untracked = 0;
+	int quiet = 0;
+	const char *stash_msg = NULL;
+	struct option options[] = {
+		OPT_SET_INT('k', "keep-index", &keep_index,
+			N_("keep index"), 1),
+		OPT_BOOL('p', "patch", &patch_mode,
+			N_("stash in patch mode")),
+		OPT_BOOL('q', "quiet", &quiet,
+			N_("quiet mode")),
+		OPT_BOOL('u', "include-untracked", &include_untracked,
+			 N_("include untracked files in stash")),
+		OPT_SET_INT('a', "all", &include_untracked,
+			    N_("include ignore files"), 2),
+		OPT_STRING('m', "message", &stash_msg, N_("message"),
+			 N_("stash message")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_push_usage,
+			     0);
+
+	return do_push_stash(argc, argv, prefix, keep_index, patch_mode,
+			     include_untracked, quiet, stash_msg);
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
@@ -1248,6 +1455,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!store_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "create"))
 		return !!create_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "push"))
+		return !!push_stash(argc, argv, prefix);
 
 	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
 		      git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index ab06e4ffb..c3146f62a 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -412,7 +412,8 @@ save)
 	;;
 push)
 	shift
-	push_stash "$@"
+	cd "$START_DIR"
+	git stash--helper push "$@"
 	;;
 apply)
 	shift
@@ -448,7 +449,8 @@ branch)
 *)
 	case $# in
 	0)
-		push_stash &&
+		cd "$START_DIR"
+		git stash--helper push &&
 		say "$(gettext "(To restore them type \"git stash apply\")")"
 		;;
 	*)
-- 
2.18.0.573.g56500d98f

