Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA153A8C8
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 18:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710096427; cv=none; b=M3/a5fkfRJZV24f3UqVyNjKr1pNL34SY/USOJ8n0YPgtTP71wIeH+0xeAtNpeoJayoMafkzhGeJjDpJO1V8JxCSuEBKFiZOsWsvCKe5M4OBrTA0CjBs6pODDHZirtCnBbfEd+YJNDBRoQT901fPNKbkPzgwrYCd346gp7xQBs/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710096427; c=relaxed/simple;
	bh=mnn23Px3iME41iR+wCaWjfwP2pi7RdfyKu+EOPKgXnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYAjnV82KRmzq4cfFQksxbnfIJRm0BxIXvuCsEO4zYsYQ/Kdts7LUfEdvYx1Mac+TPwK8ucwenJSCYOW2Y+AbpIg38JD9/j+IBsxFGTt/oVEINEA+1sMfZRfINs3VxDC30eyTOHBH0RrO+vz6vAhA10ABFL7DhHfwks9grxLwNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fej7y01I; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fej7y01I"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e4e8be9c85so1859004a34.3
        for <git@vger.kernel.org>; Sun, 10 Mar 2024 11:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710096424; x=1710701224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcbP4Zzt4o2xDMKv0SidjS77/NdcCcat3aXSsqCAgrw=;
        b=fej7y01I1B4Jq5EaGSqOrSaA1mTbt/5OPRSsj3WH+aocYurNCLm7qfDw1EAiKo6y0F
         SjAYdXEd3Tx7Nh0VmnL7z6xzNED9kRh6Cs8knroo35SHc+jIP5ARcyvfPhi1sQ6QcfWA
         aFRX0hGp6lXdoyRsQX27uIOIrzHCJ1p7lF4zJUJjQkvHuAHbiFZyEfaTsJwNsdy3Pcs+
         fIDRxSeNP7o1CqyF/ofAbNUyXHB0CCWgnL5hAPIJfj1/Zp4IQsYOtSxet5rtEG49cgO9
         /KdyX6McKo5YDkuV0cdGhVPT89YH8eUbQMM+uHEWv0wKmDPE9fg/R/HHAwqiENhkdeZZ
         0u0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710096424; x=1710701224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcbP4Zzt4o2xDMKv0SidjS77/NdcCcat3aXSsqCAgrw=;
        b=rxupLpRB42UXEb93JaSz+AmoBDVqiVu+MKt/miR8hjFnt5RAX6gE7dovIrLjGUtZh1
         gVeQ3h7mh57rCqj+v4CW3HxlucyMsb0NFpJhMFcmACSIy3MHvjQIntgz5xGBCMl/tN9s
         6e81fmmHwwsOHFlzinCM0kr85KQA04bPJstn3ebiUiXcsDFjYKFgCxDwHncva5bOGOgA
         CCSsbHyTDPa5iiA9lAcjTTFuD3heFYOlGQDYC+6KMLQwoCRN+ELT8lwAoZz9VltcR5e3
         niNV4PLNhxXZlktFbB6F10l9frc+QzIxxsIcBu0z2Dk0CSFhq0B+qdInrcdl49+TmQVO
         qNTg==
X-Gm-Message-State: AOJu0YyDxgJFNCJpZhWmLXfwmlhVhWX2IQ44wFm0oIx2+JoE1mcipLyZ
	jXdDOrWK5Owsq0mA9qp3umUs7abUgLFAU2gjd8CHiQ7z86K3ZS1Zz9TLMhHycJw=
X-Google-Smtp-Source: AGHT+IH+6wmmzlXtt7+7l/P23KKDVQegws4ngFS9ZB0gGdbzk+gChNDsD+xZuTb8SltxldcHqQPPmg==
X-Received: by 2002:a9d:4814:0:b0:6e4:e39f:b095 with SMTP id c20-20020a9d4814000000b006e4e39fb095mr5687478otf.7.1710096424196;
        Sun, 10 Mar 2024 11:47:04 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id l8-20020a0568302b0800b006e4c97ec1f4sm742131otv.69.2024.03.10.11.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 11:47:03 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v3 7/7] cherry-pick: add `--empty` for more robust redundant commit handling
Date: Sun, 10 Mar 2024 13:42:06 -0500
Message-ID: <20240310184602.539656-8-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As with git-rebase(1) and git-am(1), git-cherry-pick(1) can result in a
commit being made redundant if the content from the picked commit is
already present in the target history. However, git-cherry-pick(1) does
not have the same options available that git-rebase(1) and git-am(1) have.

There are three things that can be done with these redundant commits:
drop them, keep them, or have the cherry-pick stop and wait for the user
to take an action. git-rebase(1) has the `--empty` option added in commit
e98c4269c8 (rebase (interactive-backend): fix handling of commits that
become empty, 2020-02-15), which handles all three of these scenarios.
Similarly, git-am(1) got its own `--empty` in 7c096b8d61 (am: support
--empty=<option> to handle empty patches, 2021-12-09).

git-cherry-pick(1), on the other hand, only supports two of the three
possiblities: Keep the redundant commits via `--keep-redundant-commits`,
or have the cherry-pick fail by not specifying that option. There is no
way to automatically drop redundant commits.

In order to bring git-cherry-pick(1) more in-line with git-rebase(1) and
git-am(1), this commit adds an `--empty` option to git-cherry-pick(1). It
has the same three options (keep, drop, and stop), and largely behaves
the same. The notable difference is that for git-cherry-pick(1), the
default will be `stop`, which maintains the current behavior when the
option is not specified.

Like the existing `--keep-redundant-commits`, `--empty=keep` will imply
`--allow-empty`.

The `--keep-redundant-commits` option will be documented as a deprecated
synonym of `--empty=keep`, and will be supported for backwards
compatibility for the time being.

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---

Differences from v2:

- `--empty=keep` will now imply `--allow-empty`, consistent with
  `--keep-redundant-commits`. See [1] for more information.
- Tests for persistence of the new behaviors after `--continue`, etc.
  are more focused on user-visible behaviors rather than implementation
  details.
- The new empty_action enum uses -1 for unspecified instead of 0.

[1]: https://lore.kernel.org/git/xmqqttltu7zs.fsf@gitster.g/

 Documentation/git-cherry-pick.txt | 30 +++++++++++++++++++------
 builtin/revert.c                  | 37 ++++++++++++++++++++++++++++++-
 sequencer.c                       |  6 +++++
 t/t3505-cherry-pick-empty.sh      | 37 ++++++++++++++++++++++++++++++-
 t/t3510-cherry-pick-sequence.sh   | 32 ++++++++++++++++++++++++++
 5 files changed, 133 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index fdcad3d200..e6a61503c7 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -131,20 +131,36 @@ effect to your index in a row.
 	even without this option.  Note also, that use of this option only
 	keeps commits that were initially empty (i.e. the commit recorded the
 	same tree as its parent).  Commits which are made empty due to a
-	previous commit are dropped.  To force the inclusion of those commits
-	use `--keep-redundant-commits`.
+	previous commit will cause the cherry-pick to fail.  To force the
+	inclusion of those commits, use `--empty=keep`.
 
 --allow-empty-message::
 	By default, cherry-picking a commit with an empty message will fail.
 	This option overrides that behavior, allowing commits with empty
 	messages to be cherry picked.
 
+--empty=(drop|keep|stop)::
+	How to handle commits being cherry-picked that are redundant with
+	changes already in the current history.
++
+--
+`drop`;;
+	The commit will be dropped.
+`keep`;;
+	The commit will be kept. Implies `--allow-empty`.
+`stop`;;
+	The cherry-pick will stop when the commit is applied, allowing
+	you to examine the commit. This is the default behavior.
+--
++
+Note that this option specifies how to handle a commit that was not initially
+empty, but rather became empty due to a previous commit. Commits that were
+initially empty will cause the cherry-pick to fail. To force the inclusion of
+those commits, use `--allow-empty`.
++
+
 --keep-redundant-commits::
-	If a commit being cherry picked duplicates a commit already in the
-	current history, it will become empty.  By default these
-	redundant commits cause `cherry-pick` to stop so the user can
-	examine the commit. This option overrides that behavior and
-	creates an empty commit object.  Implies `--allow-empty`.
+	Deprecated synonym for `--empty=keep`.
 
 --strategy=<strategy>::
 	Use the given merge strategy.  Should only be used once.
diff --git a/builtin/revert.c b/builtin/revert.c
index a1936ef70e..53935d2c68 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -43,6 +43,31 @@ static const char * const *revert_or_cherry_pick_usage(struct replay_opts *opts)
 	return opts->action == REPLAY_REVERT ? revert_usage : cherry_pick_usage;
 }
 
+enum empty_action {
+	EMPTY_COMMIT_UNSPECIFIED = -1,
+	STOP_ON_EMPTY_COMMIT,      /* output errors and stop in the middle of a cherry-pick */
+	DROP_EMPTY_COMMIT,         /* skip with a notice message */
+	KEEP_EMPTY_COMMIT,         /* keep recording as empty commits */
+};
+
+static int parse_opt_empty(const struct option *opt, const char *arg, int unset)
+{
+	int *opt_value = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+
+	if (!strcmp(arg, "stop"))
+		*opt_value = STOP_ON_EMPTY_COMMIT;
+	else if (!strcmp(arg, "drop"))
+		*opt_value = DROP_EMPTY_COMMIT;
+	else if (!strcmp(arg, "keep"))
+		*opt_value = KEEP_EMPTY_COMMIT;
+	else
+		return error(_("invalid value for '%s': '%s'"), "--empty", arg);
+
+	return 0;
+}
+
 static int option_parse_m(const struct option *opt,
 			  const char *arg, int unset)
 {
@@ -85,6 +110,7 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
 	const char *me = action_name(opts);
 	const char *cleanup_arg = NULL;
+	enum empty_action empty_opt = EMPTY_COMMIT_UNSPECIFIED;
 	int cmd = 0;
 	struct option base_options[] = {
 		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
@@ -114,7 +140,10 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 			OPT_BOOL(0, "ff", &opts->allow_ff, N_("allow fast-forward")),
 			OPT_BOOL(0, "allow-empty", &opts->allow_empty, N_("preserve initially empty commits")),
 			OPT_BOOL(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
-			OPT_BOOL(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
+			OPT_BOOL(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("deprecated: use --empty=keep instead")),
+			OPT_CALLBACK_F(0, "empty", &empty_opt, "(stop|drop|keep)",
+				       N_("how to handle commits that become empty"),
+				       PARSE_OPT_NONEG, parse_opt_empty),
 			OPT_END(),
 		};
 		options = parse_options_concat(options, cp_extra);
@@ -134,6 +163,11 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
+	if (opts->action == REPLAY_PICK) {
+		opts->drop_redundant_commits = (empty_opt == DROP_EMPTY_COMMIT);
+		opts->keep_redundant_commits = opts->keep_redundant_commits || (empty_opt == KEEP_EMPTY_COMMIT);
+	}
+
 	/* implies allow_empty */
 	if (opts->keep_redundant_commits)
 		opts->allow_empty = 1;
@@ -168,6 +202,7 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 				"--rerere-autoupdate", opts->allow_rerere_auto == RERERE_AUTOUPDATE,
 				"--no-rerere-autoupdate", opts->allow_rerere_auto == RERERE_NOAUTOUPDATE,
 				"--keep-redundant-commits", opts->keep_redundant_commits,
+				"--empty", empty_opt != EMPTY_COMMIT_UNSPECIFIED,
 				NULL);
 	}
 
diff --git a/sequencer.c b/sequencer.c
index 8dce175f2e..a3c73ecb9f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2924,6 +2924,9 @@ static int populate_opts_cb(const char *key, const char *value,
 	else if (!strcmp(key, "options.allow-empty-message"))
 		opts->allow_empty_message =
 			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
+	else if (!strcmp(key, "options.drop-redundant-commits"))
+		opts->drop_redundant_commits =
+			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
 	else if (!strcmp(key, "options.keep-redundant-commits"))
 		opts->keep_redundant_commits =
 			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
@@ -3468,6 +3471,9 @@ static int save_opts(struct replay_opts *opts)
 	if (opts->allow_empty_message)
 		res |= git_config_set_in_file_gently(opts_file,
 				"options.allow-empty-message", "true");
+	if (opts->drop_redundant_commits)
+		res |= git_config_set_in_file_gently(opts_file,
+				"options.drop-redundant-commits", "true");
 	if (opts->keep_redundant_commits)
 		res |= git_config_set_in_file_gently(opts_file,
 				"options.keep-redundant-commits", "true");
diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
index 61f91aaa0a..9748443530 100755
--- a/t/t3505-cherry-pick-empty.sh
+++ b/t/t3505-cherry-pick-empty.sh
@@ -84,7 +84,7 @@ test_expect_success 'cherry-pick a commit that becomes no-op (prep)' '
 	git commit -m "add file2 on the side"
 '
 
-test_expect_success 'cherry-pick a no-op without --keep-redundant' '
+test_expect_success 'cherry-pick a no-op with neither --keep-redundant nor --empty' '
 	git reset --hard &&
 	git checkout fork^0 &&
 	test_must_fail git cherry-pick main
@@ -113,4 +113,39 @@ test_expect_success '--keep-redundant-commits is incompatible with operations' '
 	git cherry-pick --abort
 '
 
+test_expect_success '--empty is incompatible with operations' '
+	test_must_fail git cherry-pick HEAD 2>output &&
+	test_grep "The previous cherry-pick is now empty" output &&
+	test_must_fail git cherry-pick --empty=stop --continue 2>output &&
+	test_grep "fatal: cherry-pick: --empty cannot be used with --continue" output &&
+	test_must_fail git cherry-pick --empty=stop --skip 2>output &&
+	test_grep "fatal: cherry-pick: --empty cannot be used with --skip" output &&
+	test_must_fail git cherry-pick --empty=stop --abort 2>output &&
+	test_grep "fatal: cherry-pick: --empty cannot be used with --abort" output &&
+	test_must_fail git cherry-pick --empty=stop --quit 2>output &&
+	test_grep "fatal: cherry-pick: --empty cannot be used with --quit" output &&
+	git cherry-pick --abort
+'
+
+test_expect_success 'cherry-pick a no-op with --empty=stop' '
+	git reset --hard &&
+	git checkout fork^0 &&
+	test_must_fail git cherry-pick --empty=stop main 2>output &&
+	test_grep "The previous cherry-pick is now empty" output
+'
+
+test_expect_success 'cherry-pick a no-op with --empty=drop' '
+	git reset --hard &&
+	git checkout fork^0 &&
+	git cherry-pick --empty=drop main &&
+	test_commit_message HEAD -m "add file2 on the side"
+'
+
+test_expect_success 'cherry-pick a no-op with --empty=keep' '
+	git reset --hard &&
+	git checkout fork^0 &&
+	git cherry-pick --empty=keep main &&
+	test_commit_message HEAD -m "add file2 on main"
+'
+
 test_done
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 72020a51c4..7eb52b12ed 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -90,6 +90,38 @@ test_expect_success 'cherry-pick persists opts correctly' '
 	test_cmp expect actual
 '
 
+test_expect_success 'cherry-pick persists --empty=stop correctly' '
+	pristine_detach yetanotherpick &&
+	# Picking `anotherpick` forces a conflict so that we stop. That
+	# commit is then skipped, after which we pick `yetanotherpick`
+	# while already on `yetanotherpick` to cause an empty commit
+	test_must_fail git cherry-pick --empty=stop anotherpick yetanotherpick &&
+	test_must_fail git cherry-pick --skip 2>msg &&
+	test_grep "The previous cherry-pick is now empty" msg &&
+	rm msg &&
+	git cherry-pick --abort
+'
+
+test_expect_success 'cherry-pick persists --empty=drop correctly' '
+	pristine_detach yetanotherpick &&
+	# Picking `anotherpick` forces a conflict so that we stop. That
+	# commit is then skipped, after which we pick `yetanotherpick`
+	# while already on `yetanotherpick` to cause an empty commit
+	test_must_fail git cherry-pick --empty=drop anotherpick yetanotherpick &&
+	git cherry-pick --skip &&
+	test_cmp_rev yetanotherpick HEAD
+'
+
+test_expect_success 'cherry-pick persists --empty=keep correctly' '
+	pristine_detach yetanotherpick &&
+	# Picking `anotherpick` forces a conflict so that we stop. That
+	# commit is then skipped, after which we pick `yetanotherpick`
+	# while already on `yetanotherpick` to cause an empty commit
+	test_must_fail git cherry-pick --empty=keep anotherpick yetanotherpick &&
+	git cherry-pick --skip &&
+	test_cmp_rev yetanotherpick HEAD^
+'
+
 test_expect_success 'revert persists opts correctly' '
 	pristine_detach initial &&
 	# to make sure that the session to revert a sequence
-- 
2.43.0

