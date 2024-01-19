Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7A28F6F
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 06:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705644815; cv=none; b=BPdJJ36d6/g66Rf/rymMPnqiCfd0Rk6H++POORVrU80Q69lunxYQn7y4yadnvD7l5TavCgO/VVrR/H1oQr5L2ivgJtUoqDAzWPESh1HlR695tlw7YnJ0LWqIHEbiLz21l0Bvb5uSrcteLsj+uf6T8fVcE2SA+Bs7DsBqP4saFZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705644815; c=relaxed/simple;
	bh=JbYw8/tCQMM8oDmrHeHqVwSS5J2+YGxyUiA+tnwvZaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCByfNeAiJROmjxpWhqWhuk2BJZYuSVEPPrE0snqTD9TbsMeg6F6dN+SKq6XiszcU4QhJHa1p9IEPKOMLqaGtmDBDBGy8Hii6nKbp6gypaabo6ursoPy3PKR6/gJvYXXU2lNEyqraPHX3b4qtm8/t78VRShxW1w9W6Sij9Zt3gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWEIcw4A; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWEIcw4A"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6817a470730so2554746d6.3
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 22:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705644811; x=1706249611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AM03DHO352yrSOr/SCeIFKedS926D0+8H1PePxSHqIo=;
        b=TWEIcw4AJxZE23UBHmeW58Lrl1zO9vh2SqsXgsN1jmA0kXU81B7v2q3alhvaukX4JR
         iiRypMqfL/vDxAnrZp9i6iDO+p6Z7uhGkLIbQhSFSEAi2YsnQMAq42NhL9DyEXeFGSUE
         AlksZLuGG2b5JGbxVgx6aQGydjdlwt9uwfg0m86gP+7jnevuE9YIfjnXpJcr8HIr6ZEs
         1Rxug7j7r0ZfDis687YyBverPCwZi4/MFEZWW/25mLBEU+XmpDsXnbFiWbRoupSvCJGQ
         Rv2VcSiPja+BNSOJdL8vmDgoo24kpyHlCAr+saMJa60WE6DemFemXb2axPPiTrToapMk
         aMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705644811; x=1706249611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AM03DHO352yrSOr/SCeIFKedS926D0+8H1PePxSHqIo=;
        b=YVr7zYvmPXLF9OFLDf6bE2CIKggPJpn9y206853Uq0gtlb5kGBa7ilDhPU0eWwNzEf
         gul6p0B/Zi/VNW5O7E5KTWp0IlDlz21UHdv2d/HrPBmRcpvDQCnVyzU0SS7fRQu+7qFF
         JuOi8DLcvaLnxcPgmCPSun6+XO39jtbvOCwPS+HxlYRt2q6iR19q8Eyy4mprtcaNByyA
         bI7XpBuGywQ4BBW2B3lEYVy0zBixJKIICCBrsbM7KIak7pxOkmL+wlYefDMgUREdElWg
         LXUrqHrNjwyZyUCcEeOghzKu6g/LDtNjvfFig6G0ZmZN0DjIkwIz2NSbK68I+9yyK0XT
         GV5g==
X-Gm-Message-State: AOJu0Ywu7U/fm4fBmixn3As5aEeyof7wLQRcirZWgiE88wBmmRj7PJwi
	rLBAFIaD4r+RdgT4oh++xmHBNlIDS1fC26G3sCSsnTneyZ0Ck5J9xhzvThNZ
X-Google-Smtp-Source: AGHT+IHvkTk5szbxHZFDE1OQdVCC5RPwHQ+S7m9/VQ1QlGzLhfiGfqlwuRXCoU5+p+Rsw2Kv4va/oA==
X-Received: by 2002:ad4:5d67:0:b0:681:8873:c532 with SMTP id fn7-20020ad45d67000000b006818873c532mr1926458qvb.52.1705644811326;
        Thu, 18 Jan 2024 22:13:31 -0800 (PST)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id op23-20020a056214459700b0068189a17598sm1365062qvb.72.2024.01.18.22.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 22:13:30 -0800 (PST)
From: brianmlyles@gmail.com
To: git@vger.kernel.org
Cc: me@ttaylorr.com,
	newren@gmail.com,
	Brian Lyles <brianmlyles@gmail.com>
Subject: [PATCH 4/4] cherry-pick: Add `--empty` for more robust redundant commit handling
Date: Thu, 18 Jan 2024 23:59:20 -0600
Message-ID: <20240119060721.3734775-5-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brian Lyles <brianmlyles@gmail.com>

As with `git-rebase` and `git-am`, `git-cherry-pick` can result in a
commit being made redundant if the content from the picked commit is
already present in the target history. However, `git-cherry-pick` does
not have the same options available that `git-rebase` and `git-am` have.

There are three things that can be done with these redundant commits:
drop them, keep them, or have the cherry-pick stop and wait for the user
to take an action. `git-rebase` has the `--empty` option added in commit
e98c4269c8 (rebase (interactive-backend): fix handling of commits that
become empty, 2020-02-15), which handles all three of these scenarios.
Similarly, `git-am` got its own `--empty` in 7c096b8d61 (am: support
--empty=<option> to handle empty patches, 2021-12-09).

`git-cherry-pick`, on the other hand, only supports two of the three
possiblities: Keep the redundant commits via `--keep-redundant-commits`,
or have the cherry-pick fail by not specifying that option. There is no
way to automatically drop redundant commits.

In order to bring `git-cherry-pick` more in-line with `git-rebase` and
`git-am`, this commit adds an `--empty` option to `git-cherry-pick`. It
has the same three options (keep, drop, and stop), and largely behaves
the same. The notable difference is that for `git-cherry-pick`, the
default will be `stop`, which maintains the current behavior when the
option is not specified.

The `--keep-redundant-commits` option will be documented as a deprecated
synonym of `--empty=keep`, and will be supported for backwards
compatibility for the time being.

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---
 Documentation/git-cherry-pick.txt | 28 ++++++++++++++++++-------
 builtin/revert.c                  | 35 ++++++++++++++++++++++++++++++-
 sequencer.c                       |  6 ++++++
 t/t3505-cherry-pick-empty.sh      | 26 ++++++++++++++++++++++-
 4 files changed, 86 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 806295a730..8c20a10d4b 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -132,23 +132,37 @@ effect to your index in a row.
 	keeps commits that were initially empty (i.e. the commit recorded the
 	same tree as its parent).  Commits which are made empty due to a
 	previous commit will cause the cherry-pick to fail.  To force the
-	inclusion of those commits use `--keep-redundant-commits`.
+	inclusion of those commits use `--empty=keep`.
 
 --allow-empty-message::
 	By default, cherry-picking a commit with an empty message will fail.
 	This option overrides that behavior, allowing commits with empty
 	messages to be cherry picked.
 
---keep-redundant-commits::
-	If a commit being cherry picked duplicates a commit already in the
-	current history, it will become empty.  By default these
-	redundant commits cause `cherry-pick` to stop so the user can
-	examine the commit. This option overrides that behavior and
-	creates an empty commit object. Note that use of this option only
+--empty=(stop|drop|keep)::
+	How to handle commits being cherry-picked that are redundant with
+	changes already in the current history.
++
+-- 
+`stop`;;
+	The cherry-pick will stop when the empty commit is applied, allowing
+	you to examine the commit. This is the default behavior.
+`drop`;;
+	The empty commit will be dropped.
+`keep`;;
+	The empty commit will be kept. Note that use of this option only
 	results in an empty commit when the commit was not initially empty,
 	but rather became empty due to a previous commit. Commits that were
 	initially empty will cause the cherry-pick to fail. To force the
 	inclusion of those commits use `--allow-empty`.
+--
++
+Note that commits which start empty will cause the cherry-pick to fail (unless
+`--allow-empty` is specified).
++
+
+--keep-redundant-commits::
+	Deprecated synonym for `--empty=keep`.
 
 --strategy=<strategy>::
 	Use the given merge strategy.  Should only be used once.
diff --git a/builtin/revert.c b/builtin/revert.c
index b2cfde7a87..1491c45e26 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -45,6 +45,30 @@ static const char * const *revert_or_cherry_pick_usage(struct replay_opts *opts)
 	return opts->action == REPLAY_REVERT ? revert_usage : cherry_pick_usage;
 }
 
+enum empty_action {
+	STOP_ON_EMPTY_COMMIT = 0,  /* output errors and stop in the middle of a cherry-pick */
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
@@ -87,6 +111,7 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
 	const char *me = action_name(opts);
 	const char *cleanup_arg = NULL;
+	enum empty_action empty_opt;
 	int cmd = 0;
 	struct option base_options[] = {
 		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
@@ -116,7 +141,10 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
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
@@ -136,6 +164,11 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
+	if (opts->action == REPLAY_PICK) {
+		opts->drop_redundant_commits = (empty_opt == DROP_EMPTY_COMMIT);
+		opts->keep_redundant_commits = opts->keep_redundant_commits || (empty_opt == KEEP_EMPTY_COMMIT);
+	}
+
 	if (cleanup_arg) {
 		opts->default_msg_cleanup = get_cleanup_mode(cleanup_arg, 1);
 		opts->explicit_cleanup = 1;
diff --git a/sequencer.c b/sequencer.c
index 582bde8d46..c49c27c795 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2934,6 +2934,9 @@ static int populate_opts_cb(const char *key, const char *value,
 	else if (!strcmp(key, "options.allow-empty-message"))
 		opts->allow_empty_message =
 			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
+	else if (!strcmp(key, "options.drop-redundant-commits"))
+		opts->drop_redundant_commits =
+			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
 	else if (!strcmp(key, "options.keep-redundant-commits"))
 		opts->keep_redundant_commits =
 			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
@@ -3478,6 +3481,9 @@ static int save_opts(struct replay_opts *opts)
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
index 6adfd25351..ae0cf7886a 100755
--- a/t/t3505-cherry-pick-empty.sh
+++ b/t/t3505-cherry-pick-empty.sh
@@ -89,7 +89,7 @@ test_expect_success 'cherry-pick a commit that becomes no-op (prep)' '
 	git commit -m "add file2 on the side"
 '
 
-test_expect_success 'cherry-pick a no-op without --keep-redundant' '
+test_expect_success 'cherry-pick a no-op with neither --keep-redundant nor --empty' '
 	git reset --hard &&
 	git checkout fork^0 &&
 	test_must_fail git cherry-pick main
@@ -104,4 +104,28 @@ test_expect_success 'cherry-pick a no-op with --keep-redundant' '
 	test_cmp expect actual
 '
 
+test_expect_success 'cherry-pick a no-op with --empty=ask' '
+	git reset --hard &&
+	git checkout fork^0 &&
+	test_must_fail git cherry-pick --empty=ask main
+'
+
+test_expect_success 'cherry-pick a no-op with --empty=drop' '
+	git reset --hard &&
+	git checkout fork^0 &&
+	git cherry-pick --empty=drop main &&
+	git show -s --format=%s >actual &&
+	echo "add file2 on the side" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cherry-pick a no-op with --empty=keep' '
+	git reset --hard &&
+	git checkout fork^0 &&
+	git cherry-pick --empty=keep main &&
+	git show -s --format=%s >actual &&
+	echo "add file2 on main" >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.41.0

