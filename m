Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97DC3112C0
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 19:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781810235; cv=none; b=Tpiio7p1kohDBDc6N+m0e0zbojCH2LWYWc71YotSCDvMvi0UOT/VmH265UJbz4zLeZPuPwBVRxcrOcYyjNRtIR/p/T3+8ckPf3A4YE0oXYG1PEDS+hLcw5o1oA9kV12LVZICPs5YnqPQIrnc6sUXmfHMsAqAdDPXo3tt+L8QLHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781810235; c=relaxed/simple;
	bh=V88nHPkk7oFTqbdnNYi+4yf2Mx3Nhvvgx7wWAjFZQCM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bmPxZH02UxDVZEsD8qOvl2O/JopcY/AJl8mFDP4Uxi0e3eQjy4V6TKeJcnVmWB/Nwdo/xBZ1jJf6JYkqB7udiRp1j4RdiiwW61pIQcnMDY+aFPAPe51r6PupGX5AHog41T+3+YP6j1qor8ElZQzZLvled2hJg2xeq+Q6cFvYjos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xgu2ut5s; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xgu2ut5s"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-517654b8e28so11162591cf.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 12:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781810233; x=1782415033; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sL+dPj1o2V/AuDNiBNw1gptInSU2QeZ0y4hYGOr046Y=;
        b=Xgu2ut5sBulEWZ0v/Moj024H7jCiK/9jGHltGeaa8ZvmL2boLvVlRspgiupFFMdaFb
         KixDhuyLOOCvwwzefdfGJXT8IiLQ3POe/c46DIK8uVHZk6ADxEygK5JBoXZqd7KBeyFJ
         OVfBgIyiGltGz6dFwjkJq0+L83zfWY4OuRGMED0JzFkI/HSiDLKGLWBfgkzm9+pfdb1d
         LDD2qR4bp+8lIU+/ZtVGG5TQ+k475dSIQksweNS3Aw9mr5zMi2UlcMHbMqchppETiAqG
         DE7gScaev6BQz1IUGMSeKdsOBu2GLWNPetHWSLmxSxQl7gr4UBg7ZhHaBLSRgAzk4nM6
         EkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781810233; x=1782415033;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sL+dPj1o2V/AuDNiBNw1gptInSU2QeZ0y4hYGOr046Y=;
        b=L7sG0DJGCSoOdhG1LZ5WTmclebZ9JzEbiKNQjPKhxlPH0te2xcNAbSKEqlYL9izGkD
         cW/rfxGpFEK+IWUHfUSUqEEQlpX/VQuk+Umudn/bbt8GaWVzqZa2fpXZ26ugfZQnqdVa
         nWlqywcksOWr89HW/ac3TbSch4n5jzs/yQYtvFCDoBERenlgs69q+fQyl1af8CkMKBIE
         S74lHZXooMxq0erE6CHfqEgOIBc34yDv4zmAAcx5TWZmMvK/vpFYLtzRp6qS/fBE1tYY
         CktThdA9+nhLtIH2E9Ss0NIjKTWaGM+S9o89RjP8PgMqXaeEq4lvFrAbbui4cxRbtd0G
         j0uQ==
X-Gm-Message-State: AOJu0YxbVXyWZQlxLMntDcBYZNBjPO0frZ9JCF8esasKUlWoLjs+6Fg8
	ZmMAY76J5aWzAhy0TCGQPbfSiz2EyZZ1Us0A/dUTjfqGWLEF4Q8NzaKArlbvOg==
X-Gm-Gg: AfdE7clr4WigzZxfHzTuoCHJ09VKPyZobcFXTKa8GK73ICsPOqSwXBqqo38XXEEH81c
	/jmrqdqysNU/vLAwAC4bV1dMqpp8HDEm23ACeQDCZgKiya15SSSD6zyczTju8iqYf2GPDOl1EmE
	kDB7by785SKLNTGgLGC3rgLVnONpNW6ffwxo8CYTvamL2PG/jrqZS/A5HHj8rcv2fPgxS2IHks5
	fAOtcmD4yy2Yn1SgkJ+StWnu3ZXL8xypbJinIhrao+SKMVF1xhpCWjh1bhh096wizNCJw51kIhm
	ConSBH7/YeYi69mvofnfpZ22GzE7t9owfdobm90NQj4mcOyecJaOrT8S1ApuKABBFPf46fDb06x
	7LmDO4zX6CNFdjVty6AqYEVPZQtY0grZxUK87q7+z1zGLM1KSV45Zk1JsSVzuJs+DETTosWzQcg
	NrsdP/BkjY6ZLXsP/ZIwTobQihdg==
X-Received: by 2002:a05:622a:1496:b0:516:e39a:8540 with SMTP id d75a77b69052e-519e4de436emr6910981cf.48.1781810232329;
        Thu, 18 Jun 2026 12:17:12 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.77.168])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-519e4e9a107sm2302331cf.12.2026.06.18.12.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 12:17:11 -0700 (PDT)
Message-Id: <66b2f49fb427c7328136b2d440dc7461b97fb4e0.1781810227.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v3.git.git.1781810226.gitgitgadget@gmail.com>
References: <pull.2337.v2.git.git.1781512625.gitgitgadget@gmail.com>
	<pull.2337.v3.git.git.1781810226.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jun 2026 19:17:05 +0000
Subject: [PATCH v3 3/4] history: add squash subcommand to fold a range
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Folding a series of commits into one required either an interactive
rebase where each commit after the first was hand-edited to "fixup", or
a "git reset --soft" to the merge base followed by "git commit --amend".

Add "git history squash <revision-range>" to do this directly. It folds
every commit in the range into the oldest one, keeping that commit's
message and authorship and taking the tree of the newest commit, so the
range collapses into a single commit. Commits above the range are
replayed on top of the result.

The range is given as <base>..<tip>, so "git history squash @~3.."
folds the three most recent commits and "git history squash @~5..@~2"
squashes an interior range. A merge inside the range is folded like any
other commit, but the range must have a single base, so a range with
more than one entry point is rejected.

Inspired-by: Sergey Chernov <serega.morph@gmail.com>
Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-history.adoc |  20 ++++
 builtin/history.c              | 154 ++++++++++++++++++++++++
 t/meson.build                  |   1 +
 t/t3454-history-squash.sh      | 213 +++++++++++++++++++++++++++++++++
 4 files changed, 388 insertions(+)
 create mode 100755 t/t3454-history-squash.sh

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 2ba8121795..d3a5ad28a3 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -11,6 +11,7 @@ SYNOPSIS
 git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)]
 git history reword <commit> [--dry-run] [--update-refs=(branches|head)]
 git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]
+git history squash <revision-range> [--dry-run] [--update-refs=(branches|head)] [--reedit-message]
 
 DESCRIPTION
 -----------
@@ -97,6 +98,25 @@ linkgit:gitglossary[7].
 It is invalid to select either all or no hunks, as that would lead to
 one of the commits becoming empty.
 
+`squash <revision-range>`::
+	Fold all commits in _<revision-range>_ into the oldest commit of that
+	range. The resulting commit keeps the oldest commit's message and
+	authorship and takes the tree of the range's newest commit, so the
+	whole range collapses into a single commit. Commits above the range
+	are replayed on top of the result.
++
+The range is given in the usual `<base>..<tip>` form, where _<base>_ is
+the commit just below the oldest commit to squash. For example, `git
+history squash @~3..` folds the three most recent commits into one, and
+`git history squash @~5..@~2` squashes an interior range while leaving
+the two newest commits in place.
++
+The oldest commit's message and authorship are preserved by default,
+unless you specify `--reedit-message`. A merge commit inside the range is
+folded like any other, but the range must have a single base, so a range
+that reaches more than one entry point (for example a side branch that
+forked before the range and was later merged into it) is rejected.
+
 OPTIONS
 -------
 
diff --git a/builtin/history.c b/builtin/history.c
index 305bde3102..9d9416870f 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -30,6 +30,8 @@
 	N_("git history reword <commit> [--dry-run] [--update-refs=(branches|head)]")
 #define GIT_HISTORY_SPLIT_USAGE \
 	N_("git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]")
+#define GIT_HISTORY_SQUASH_USAGE \
+	N_("git history squash <revision-range> [--dry-run] [--update-refs=(branches|head)] [--reedit-message]")
 
 static void change_data_free(void *util, const char *str UNUSED)
 {
@@ -973,6 +975,156 @@ out:
 	return ret;
 }
 
+/*
+ * Resolve a "<base>..<tip>" revision range into the base commit just outside
+ * the range (which becomes the parent of the squashed commit), the oldest
+ * commit contained in the range (whose message the squash reuses), and the
+ * range tip (whose tree becomes the result). A merge inside the range is fine,
+ * but the range must have a single base and must not reach a root commit.
+ */
+static int resolve_squash_range(struct repository *repo,
+				const char *range,
+				struct commit **base_out,
+				struct commit **oldest_out,
+				struct commit **tip_out)
+{
+	struct rev_info revs;
+	struct commit *commit, *base = NULL, *oldest = NULL, *tip = NULL;
+	struct strvec args = STRVEC_INIT;
+	int ret;
+
+	repo_init_revisions(repo, &revs, NULL);
+	strvec_push(&args, "ignored");
+	strvec_push(&args, "--reverse");
+	strvec_push(&args, "--topo-order");
+	strvec_push(&args, "--boundary");
+	strvec_push(&args, range);
+	setup_revisions_from_strvec(&args, &revs, NULL);
+	if (args.nr != 1) {
+		ret = error(_("'%s' does not name a revision range"), range);
+		goto out;
+	}
+
+	if (prepare_revision_walk(&revs) < 0) {
+		ret = error(_("error preparing revisions"));
+		goto out;
+	}
+
+	while ((commit = get_revision(&revs))) {
+		if (commit->object.flags & BOUNDARY) {
+			if (base) {
+				ret = error(_("range '%s' has more than one base; "
+					      "cannot squash"), range);
+				goto out;
+			}
+			base = commit;
+			continue;
+		}
+		if (!oldest)
+			oldest = commit;
+		tip = commit;
+	}
+
+	if (!oldest) {
+		ret = error(_("the range '%s' is empty"), range);
+		goto out;
+	}
+
+	if (!base) {
+		ret = error(_("cannot squash the root commit"));
+		goto out;
+	}
+
+	*base_out = base;
+	*oldest_out = oldest;
+	*tip_out = tip;
+	ret = 0;
+
+out:
+	reset_revision_walk();
+	release_revisions(&revs);
+	strvec_clear(&args);
+	return ret;
+}
+
+static int cmd_history_squash(int argc,
+			      const char **argv,
+			      const char *prefix,
+			      struct repository *repo)
+{
+	const char * const usage[] = {
+		GIT_HISTORY_SQUASH_USAGE,
+		NULL,
+	};
+	enum ref_action action = REF_ACTION_DEFAULT;
+	enum commit_tree_flags flags = 0;
+	int dry_run = 0;
+	struct option options[] = {
+		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
+			       N_("control which refs should be updated"),
+			       PARSE_OPT_NONEG, parse_ref_action),
+		OPT_BOOL('n', "dry-run", &dry_run,
+			 N_("perform a dry-run without updating any refs")),
+		OPT_BIT(0, "reedit-message", &flags,
+			N_("open an editor to modify the commit message"),
+			COMMIT_TREE_EDIT_MESSAGE),
+		OPT_END(),
+	};
+	struct strbuf reflog_msg = STRBUF_INIT;
+	struct commit *base, *oldest, *tip, *rewritten;
+	const struct object_id *base_tree_oid, *tip_tree_oid;
+	struct commit_list *parents = NULL;
+	struct rev_info revs = { 0 };
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	if (argc != 1) {
+		ret = error(_("command expects a single revision range"));
+		goto out;
+	}
+	repo_config(repo, git_default_config, NULL);
+
+	if (action == REF_ACTION_DEFAULT)
+		action = REF_ACTION_BRANCHES;
+
+	ret = resolve_squash_range(repo, argv[0], &base, &oldest, &tip);
+	if (ret < 0)
+		goto out;
+
+	ret = setup_revwalk(repo, action, tip, &revs);
+	if (ret < 0)
+		goto out;
+
+	base_tree_oid = &repo_get_commit_tree(repo, base)->object.oid;
+	tip_tree_oid = &repo_get_commit_tree(repo, tip)->object.oid;
+	commit_list_append(base, &parents);
+
+	ret = commit_tree_ext(repo, "squash", oldest, NULL, parents,
+			      base_tree_oid, tip_tree_oid, &rewritten, flags);
+	if (ret < 0) {
+		ret = error(_("failed writing squashed commit"));
+		goto out;
+	}
+
+	strbuf_addf(&reflog_msg, "squash: updating %s", argv[0]);
+
+	ret = handle_reference_updates(&revs, action, tip, rewritten,
+				       reflog_msg.buf, dry_run,
+				       REPLAY_EMPTY_COMMIT_ABORT);
+	if (ret < 0) {
+		ret = error(_("failed replaying descendants"));
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	strbuf_release(&reflog_msg);
+	commit_list_free(parents);
+	release_revisions(&revs);
+	return ret;
+}
+
 int cmd_history(int argc,
 		const char **argv,
 		const char *prefix,
@@ -982,6 +1134,7 @@ int cmd_history(int argc,
 		GIT_HISTORY_FIXUP_USAGE,
 		GIT_HISTORY_REWORD_USAGE,
 		GIT_HISTORY_SPLIT_USAGE,
+		GIT_HISTORY_SQUASH_USAGE,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
@@ -989,6 +1142,7 @@ int cmd_history(int argc,
 		OPT_SUBCOMMAND("fixup", &fn, cmd_history_fixup),
 		OPT_SUBCOMMAND("reword", &fn, cmd_history_reword),
 		OPT_SUBCOMMAND("split", &fn, cmd_history_split),
+		OPT_SUBCOMMAND("squash", &fn, cmd_history_squash),
 		OPT_END(),
 	};
 
diff --git a/t/meson.build b/t/meson.build
index 3219264fe7..d7ae5a46ef 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -399,6 +399,7 @@ integration_tests = [
   't3451-history-reword.sh',
   't3452-history-split.sh',
   't3453-history-fixup.sh',
+  't3454-history-squash.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3454-history-squash.sh b/t/t3454-history-squash.sh
new file mode 100755
index 0000000000..6c6a75bf00
--- /dev/null
+++ b/t/t3454-history-squash.sh
@@ -0,0 +1,213 @@
+#!/bin/sh
+
+test_description='tests for git-history squash subcommand'
+
+. ./test-lib.sh
+
+test_expect_success 'setup linear history touching two files' '
+	test_commit base file a &&
+	git tag start &&
+	test_commit one other x &&
+	test_commit two file c &&
+	test_commit three file d
+'
+
+test_expect_success 'errors on missing range argument' '
+	test_must_fail git history squash 2>err &&
+	test_grep "command expects a single revision range" err
+'
+
+test_expect_success 'errors on too many arguments' '
+	test_must_fail git history squash start.. HEAD 2>err &&
+	test_grep "command expects a single revision range" err
+'
+
+test_expect_success 'errors on an empty range' '
+	test_must_fail git history squash HEAD..HEAD 2>err &&
+	test_grep "the range .* is empty" err
+'
+
+test_expect_success 'errors when the range includes the root commit' '
+	test_must_fail git history squash HEAD 2>err &&
+	test_grep "cannot squash the root commit" err
+'
+
+test_expect_success 'squashes a range into a single commit without changing the tree' '
+	git reset --hard three &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash start.. &&
+
+	git rev-list --count start..HEAD >count &&
+	echo 1 >expect &&
+	test_cmp expect count &&
+	test_cmp_rev start HEAD^ &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+	git log --format="%s" -1 >subject &&
+	echo one >expect &&
+	test_cmp expect subject &&
+	git reflog >reflog &&
+	test_grep "squash: updating" reflog
+'
+
+test_expect_success 'squashes an interior range and replays descendants verbatim' '
+	git reset --hard three &&
+	final_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash start..@~1 &&
+
+	git log --format="%s" start..HEAD >actual &&
+	cat >expect <<-\EOF &&
+	three
+	one
+	EOF
+	test_cmp expect actual &&
+
+	test_cmp_rev start HEAD~2 &&
+	test "$final_tree" = "$(git rev-parse HEAD^{tree})"
+'
+
+test_expect_success 'squashes when the base is the root commit' '
+	git reset --hard three &&
+	root=$(git rev-list --max-parents=0 HEAD) &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash "$root.." &&
+
+	git rev-list --count "$root..HEAD" >count &&
+	echo 1 >expect &&
+	test_cmp expect count &&
+	test_cmp_rev "$root" HEAD^ &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
+'
+
+test_expect_success 'squashing a single-commit range replays the rest' '
+	git reset --hard three &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash start..@~2 &&
+
+	git log --format="%s" start..HEAD >actual &&
+	cat >expect <<-\EOF &&
+	three
+	two
+	one
+	EOF
+	test_cmp expect actual &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
+'
+
+test_expect_success 'reuses the message of a fixup! commit in the range' '
+	git reset --hard start &&
+	test_commit reg1 file b &&
+	git commit --allow-empty -m "fixup! reg1" &&
+	test_commit reg2 file c &&
+
+	git history squash start.. &&
+
+	git log --format="%s" -1 >actual &&
+	echo reg1 >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'keeps the oldest message even if it is a fixup!' '
+	git reset --hard start &&
+	test_commit --no-tag "fixup! something" file b &&
+	test_commit tail file c &&
+
+	git history squash start.. &&
+
+	git log --format="%s" -1 >actual &&
+	echo "fixup! something" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'preserves authorship of the oldest commit' '
+	git reset --hard start &&
+	GIT_AUTHOR_NAME=Squasher GIT_AUTHOR_EMAIL=squash@example.com \
+		test_commit oldest file b &&
+	test_commit newest file c &&
+
+	git history squash start.. &&
+
+	git log -1 --format="%an <%ae>" >actual &&
+	echo "Squasher <squash@example.com>" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--dry-run predicts the rewrite without performing it' '
+	git reset --hard three &&
+	head_before=$(git rev-parse HEAD) &&
+
+	git history squash --dry-run start.. >out &&
+	grep "^update refs/heads/" out >update &&
+	predicted=$(awk "{print \$3}" update) &&
+	test_cmp_rev "$head_before" HEAD &&
+
+	git history squash start.. &&
+	test "$predicted" = "$(git rev-parse HEAD)"
+'
+
+test_expect_success '--update-refs=head only moves HEAD' '
+	git reset --hard three &&
+	git branch -f other HEAD &&
+	other_before=$(git rev-parse other) &&
+
+	git history squash --update-refs=head start.. &&
+
+	git rev-list --count start..HEAD >count &&
+	echo 1 >expect &&
+	test_cmp expect count &&
+	test_cmp_rev "$other_before" other
+'
+
+test_expect_success '--update-refs=branches moves a branch pointing into the range' '
+	git reset --hard three &&
+	git branch -f mid HEAD~2 &&
+	mid_before=$(git rev-parse mid) &&
+
+	git history squash start..@~1 &&
+
+	test_cmp_rev "$mid_before" mid &&
+	test_commit_message mid -m one
+'
+
+test_expect_success 'squashes a range whose internal merge has a single base' '
+	git reset --hard start &&
+	test_commit before-side file b &&
+	git checkout -b inner-side &&
+	test_commit on-inner-side inner x &&
+	git checkout - &&
+	test_commit after-side file c &&
+	git merge --no-ff -m merge inner-side &&
+	test_commit after-merge file d &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash start.. &&
+
+	git rev-list --count start..HEAD >count &&
+	echo 1 >expect &&
+	test_cmp expect count &&
+	git log --format="%s" -1 >subject &&
+	echo before-side >expect &&
+	test_cmp expect subject &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+	test_path_is_file inner
+'
+
+test_expect_success 'refuses to squash a range with more than one base' '
+	git reset --hard start &&
+	head_before=$(git rev-parse HEAD) &&
+	git checkout -b forked-before &&
+	test_commit forked-side fside x &&
+	git checkout - &&
+	test_commit forked-main file b &&
+	git merge --no-ff -m merge forked-before &&
+	merged=$(git rev-parse HEAD) &&
+
+	test_must_fail git history squash forked-main.. 2>err &&
+	test_grep "more than one base" err &&
+	test_cmp_rev "$merged" HEAD
+'
+
+test_done
-- 
gitgitgadget

