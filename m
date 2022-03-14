Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABABC433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 16:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242898AbiCNQLq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 12:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242868AbiCNQLp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 12:11:45 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CFC3E0C9
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 09:10:35 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j26so24826443wrb.1
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 09:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gsKzs7AJFyckwXhNdgglhBMpOVXFbOPZgH1AOJ2vYWo=;
        b=kbyMw+XkBzD0kG9KcRZDRMm5sjnmLPL1xlkJ1VngX2F1x8qAnjMEvTDz0Fvicd3Q9M
         wAMyVxTgc5t21L00hasKyCxHwTSHd3WKAjHZx4JdLYOtr298agNFQsf5cYEQhMVUZ4xI
         xCGW9/um1Y/4uxbU6JqBn2qyyU41ucNFnodKMCjPLOkJzMw4NDPpthLuMKkZu7aVKcD/
         uaHAje9maVMR5t2ZsduRqJueysz2Xsz2FvCloWRRvbDysI+Bar4halBY/l+ANaIHFC+I
         T7MWK/iU7y/Hvc4wTnrvdn7QohMB2g8K7NFm7nj+AbXSsYxWRZZDE4MAl9Yy5nMsALkG
         7JOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gsKzs7AJFyckwXhNdgglhBMpOVXFbOPZgH1AOJ2vYWo=;
        b=yGoBlWytF8Sibdx8jIawAN6jmwoIHnVHy+kRPK2/fmScn31E+bSF/coFDpvpV5MRsD
         GPyLrkXKVQW4W9lKM5D/z0jS6WlRrCSkaAwe+6WgqVTYoOWzQ+5VSzERIv6g5kMmhgEu
         ZTZKRbYgNh3Wv5jWHckJ2RS0+VAV1y3HnteFM1UoT+Fn73+cwJjB9u6fNLIi/TJ9TSW9
         l53HPzKnb1rtq8sdpNSfOizMdI6XWpw06T3n3SCF9t5f/Atssp28X2yyCWXYXGBcblF9
         FIMMF0axWA3IuWcZKFfhXvA2V6bxyU6DbeK8r4YlKx1J3uqeaWusU+QwWyryVfC6AMlz
         bT1Q==
X-Gm-Message-State: AOAM530KVLN/Q/o6nUDXU9WS8QfZ3fiYFod8VMbrcp9IRjQWZqNcmtyE
        PPKzO1cojSwTMjYugx/Avb3xtbG3hkg=
X-Google-Smtp-Source: ABdhPJzOgsYN+8WBgoAIdQyRnjh6i21bafLxKLnJskd5Uz0lnVFB3UiJz0TfVJ/8rKG99Qfjwohp3A==
X-Received: by 2002:a5d:588d:0:b0:203:8c45:8050 with SMTP id n13-20020a5d588d000000b002038c458050mr15786571wrf.502.1647274233611;
        Mon, 14 Mar 2022 09:10:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm22259749wri.0.2022.03.14.09.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 09:10:33 -0700 (PDT)
Message-Id: <7f0226bc3e646167808fbd2413dc54e87417230c.1647274230.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
References: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
        <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Mar 2022 16:10:27 +0000
Subject: [PATCH v2 2/5] reset: introduce --[no-]refresh option to --mixed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add a new --[no-]refresh option that is intended to explicitly determine
whether a mixed reset should end in an index refresh.

Starting at 9ac8125d1a (reset: don't compute unstaged changes after reset
when --quiet, 2018-10-23), using the '--quiet' option results in skipping
the call to 'refresh_index(...)' at the end of a mixed reset with the goal
of improving performance. However, by coupling behavior that modifies the
index with the option that silences logs, there is no way for users to have
one without the other (i.e., silenced logs with a refreshed index) without
incurring the overhead of a separate call to 'git update-index --refresh'.
Furthermore, there is minimal user-facing documentation indicating that
--quiet skips the index refresh, potentially leading to unexpected issues
executing commands after 'git reset --quiet' that do not themselves refresh
the index (e.g., internals of 'git stash', 'git read-tree').

To mitigate these issues, '--[no-]refresh' and 'reset.refresh' are
introduced to provide a dedicated mechanism for refreshing the index. When
either is set, '--quiet' and 'reset.quiet' revert to controlling only
whether logs are silenced and do not affect index refresh.

Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-reset.txt |  9 +++++
 builtin/reset.c             | 13 ++++++-
 t/t7102-reset.sh            | 77 +++++++++++++++++++++++++++++++++----
 3 files changed, 91 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 6f7685f53d5..89ddc85c2e4 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -110,6 +110,15 @@ OPTIONS
 	`reset.quiet` config option. `--quiet` and `--no-quiet` will
 	override the default behavior.
 
+--refresh::
+--no-refresh::
+	Proactively refresh the index after a mixed reset. If unspecified, the
+	behavior falls back on the `reset.refresh` config option. If neither
+	`--[no-]refresh` nor `reset.refresh` are set, the default behavior is
+	decided by the `--[no-]quiet` option and/or `reset.quiet` config.
+	If `--quiet` is specified or `reset.quiet` is set with no command-line
+	"quiet" setting, refresh is disabled. Otherwise, refresh is enabled.
+
 --pathspec-from-file=<file>::
 	Pathspec is passed in `<file>` instead of commandline args. If
 	`<file>` is exactly `-` then standard input is used. Pathspec
diff --git a/builtin/reset.c b/builtin/reset.c
index a420497a14f..7f667e13d71 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -392,6 +392,7 @@ static int git_reset_config(const char *var, const char *value, void *cb)
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
 	int reset_type = NONE, update_ref_status = 0, quiet = 0;
+	int refresh = -1;
 	int patch_mode = 0, pathspec_file_nul = 0, unborn;
 	const char *rev, *pathspec_from_file = NULL;
 	struct object_id oid;
@@ -399,6 +400,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	int intent_to_add = 0;
 	const struct option options[] = {
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_BOOL(0, "refresh", &refresh,
+				N_("skip refreshing the index after reset")),
 		OPT_SET_INT(0, "mixed", &reset_type,
 						N_("reset HEAD and index"), MIXED),
 		OPT_SET_INT(0, "soft", &reset_type, N_("reset only HEAD"), SOFT),
@@ -421,11 +424,19 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	git_config(git_reset_config, NULL);
 	git_config_get_bool("reset.quiet", &quiet);
+	git_config_get_bool("reset.refresh", &refresh);
 
 	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
 						PARSE_OPT_KEEP_DASHDASH);
 	parse_args(&pathspec, argv, prefix, patch_mode, &rev);
 
+	/*
+	 * If refresh is completely unspecified (either by config or by command
+	 * line option), decide based on 'quiet'.
+	 */
+	if (refresh < 0)
+		refresh = !quiet;
+
 	if (pathspec_from_file) {
 		if (patch_mode)
 			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--patch");
@@ -517,7 +528,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			if (read_from_tree(&pathspec, &oid, intent_to_add))
 				return 1;
 			the_index.updated_skipworktree = 1;
-			if (!quiet && get_git_work_tree()) {
+			if (refresh && get_git_work_tree()) {
 				uint64_t t_begin, t_delta_in_ms;
 
 				t_begin = getnanotime();
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index d05426062ec..005940778b7 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -462,14 +462,77 @@ test_expect_success 'resetting an unmodified path is a no-op' '
 	git diff-index --cached --exit-code HEAD
 '
 
+test_index_refreshed () {
+
+	# To test whether the index is refresh, create a scenario where a
+	# command will fail if the index is *not* refreshed:
+	#   1. update the worktree to match HEAD & remove file2 in the index
+	#   2. reset --mixed to unstage the change from step 1
+	#   3. read-tree HEAD~1 (which differs from HEAD in file2)
+	# If the index is refreshed in step 2, then file2 in the index will be
+	# up-to-date with HEAD and read-tree will succeed (thus failing the
+	# test). If the index is *not* refreshed, however, the staged deletion
+	# of file2 from step 1 will conflict with the changes from the tree read
+	# in step 3, resulting in a failure.
+
+	# Step 0: start with a clean index
+	git reset --hard HEAD &&
+
+	# Step 1
+	git rm --cached file2 &&
+
+	# Step 2
+	git $1 reset $2 --mixed HEAD &&
+
+	# Step 3
+	git read-tree -m HEAD~1
+}
+
 test_expect_success '--mixed refreshes the index' '
-	cat >expect <<-\EOF &&
-	Unstaged changes after reset:
-	M	file2
-	EOF
-	echo 123 >>file2 &&
-	git reset --mixed HEAD >output &&
-	test_cmp expect output
+	# Verify default behavior (with no config settings or command line
+	# options)
+	test_index_refreshed
+'
+test_expect_success '--mixed --[no-]quiet sets default refresh behavior' '
+	# Verify that --[no-]quiet and `reset.quiet` (without --[no-]refresh)
+	# determine refresh behavior
+
+	# Config setting
+	! test_index_refreshed "-c reset.quiet=true" &&
+	test_index_refreshed "-c reset.quiet=false" &&
+
+	# Command line option
+	! test_index_refreshed "" --quiet &&
+	test_index_refreshed "" --no-quiet &&
+
+	# Command line option overrides config setting
+	! test_index_refreshed "-c reset.quiet=false" --quiet &&
+	test_index_refreshed "-c reset.refresh=true" --no-quiet
+'
+
+test_expect_success '--mixed --[no-]refresh sets refresh behavior' '
+	# Verify that --[no-]refresh and `reset.refresh` control index refresh
+
+	# Config setting
+	test_index_refreshed "-c reset.refresh=true" &&
+	! test_index_refreshed "-c reset.refresh=false" &&
+
+	# Command line option
+	test_index_refreshed "" --refresh &&
+	! test_index_refreshed "" --no-refresh &&
+
+	# Command line option overrides config setting
+	test_index_refreshed "-c reset.refresh=false" --refresh &&
+	! test_index_refreshed "-c reset.refresh=true" --no-refresh
+'
+
+test_expect_success '--mixed --refresh overrides --quiet refresh behavior' '
+	# Verify that *both* --refresh and `reset.refresh` override the
+	# default non-refresh behavior of --quiet
+	test_index_refreshed "" "--quiet --refresh" &&
+	test_index_refreshed "-c reset.quiet=true" --refresh &&
+	test_index_refreshed "-c reset.refresh=true" --quiet &&
+	test_index_refreshed "-c reset.refresh=true -c reset.quiet=true"
 '
 
 test_expect_success '--mixed preserves skip-worktree' '
-- 
gitgitgadget

