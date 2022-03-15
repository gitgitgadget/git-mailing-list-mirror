Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0108C433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 01:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244798AbiCOBvC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 21:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344223AbiCOBu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 21:50:57 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD45E1CFEF
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 18:49:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r6so26319271wrr.2
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 18:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fyiFNCooMn8skm8kf56i+jirRha3dnEx0CGS66bx7Qo=;
        b=MKhzxPRWwu6cwxnmqT92lxSjisGktkvMD+89qYXvp4Bq3WavoKmW6jHpPB9MjGd7Kl
         +hIlii9sNzap/aB+ryoaBplh7vjQvBfhdxC7iYJNSXY6obUp3wrYkHbC0JB/UDlNAzvO
         BM/4cqyu0y/EcFeOWyW19TAHW/V6ZoQHzwpzW1kd5zf1xdGtugSc7f5cSU6o+VTdJ7R8
         gU98J+YJX6E8wolNHhjVcZV52SECytw1w8EuSGbF2g2iG2qqL8SxSRZBC5kKujYI6AC1
         n9k/Dz1kkYI2SXpYQmH+L+CKKtl1BslrhH3pEF4gPzFzKZ4AxBpVxIA2vWNIymiT9sxW
         SHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fyiFNCooMn8skm8kf56i+jirRha3dnEx0CGS66bx7Qo=;
        b=UyOL9qlD0uxCgQvbxD7/mBBhY/2WxDulrtI6vzUD1qWh7p2/6mn4RA+Du8fV1gCp7v
         RsUPFMognA5en0zDyhZ54ZyA+dU9Y1YN2MzqAlwTp0qCDcKqBZCi9kok63yf34IO0X1b
         JHZq7/NGEezHtrfv22CB6aMF5FqKNYOuR4qfu0LhZXL4x4wvvl58wK6YTyhJ9ZV4ZbKJ
         0nPfoN0iJpd8BJWQSkJkoHTMpIaEv3/7izuwtfROOa29lqFflm+H1TdiiCqJdLpP7HBZ
         jWmP0MhACTANvHCAoQbhIDGtrKgmypSfAAGxW/ZTmrR/CuoNljR8ermSkq8qjDUe1f0r
         ySRg==
X-Gm-Message-State: AOAM531tcOrgecWLOvubNyJh5/ldmUdTsfR/Pv0M5Eiq167DhjVRH6RA
        LRuvwsUIcix0EkgigcHxhEkU4jhD7wg=
X-Google-Smtp-Source: ABdhPJz0dLwleanTe3p5FcSba8pIY+VlD83e2f5RXUsS4FWLafaEadgYDTNfAhjeCUqCfCx7zv990A==
X-Received: by 2002:adf:ef81:0:b0:1f0:95f:30a7 with SMTP id d1-20020adfef81000000b001f0095f30a7mr18085198wro.636.1647308985053;
        Mon, 14 Mar 2022 18:49:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8-20020a05600c068800b00389bdc8c8c2sm842786wmn.12.2022.03.14.18.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 18:49:44 -0700 (PDT)
Message-Id: <101cee42dd6d5a4e5f12da647eafab9334d69a2d.1647308982.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1170.v3.git.1647308982.gitgitgadget@gmail.com>
References: <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
        <pull.1170.v3.git.1647308982.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Mar 2022 01:49:39 +0000
Subject: [PATCH v3 2/5] reset: introduce --[no-]refresh option to --mixed
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
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-reset.txt |  9 +++++
 builtin/reset.c             | 13 ++++++-
 t/t7102-reset.sh            | 73 +++++++++++++++++++++++++++++++++----
 3 files changed, 87 insertions(+), 8 deletions(-)

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
index d05426062ec..1dc3911a060 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -462,14 +462,73 @@ test_expect_success 'resetting an unmodified path is a no-op' '
 	git diff-index --cached --exit-code HEAD
 '
 
+test_reset_refreshes_index () {
+
+	# To test whether the index is refreshed in `git reset --mixed` with
+	# the given options, create a scenario where we clearly see different
+	# results depending on whether the refresh occurred or not.
+
+	# Step 0: start with a clean index
+	git reset --hard HEAD &&
+
+	# Step 1: remove file2, but only in the index (no change to worktree)
+	git rm --cached file2 &&
+
+	# Step 2: reset index & leave worktree unchanged from HEAD
+	git $1 reset $2 --mixed HEAD &&
+
+	# Step 3: verify whether the index is refreshed by checking whether
+	# file2 still has staged changes in the index differing from HEAD (if
+	# the refresh occurred, there should be no such changes)
+	git diff-files >output.log &&
+	test_must_be_empty output.log
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
+	test_reset_refreshes_index
+'
+test_expect_success '--mixed --[no-]quiet sets default refresh behavior' '
+	# Verify that --[no-]quiet and `reset.quiet` (without --[no-]refresh)
+	# determine refresh behavior
+
+	# Config setting
+	! test_reset_refreshes_index "-c reset.quiet=true" &&
+	test_reset_refreshes_index "-c reset.quiet=false" &&
+
+	# Command line option
+	! test_reset_refreshes_index "" --quiet &&
+	test_reset_refreshes_index "" --no-quiet &&
+
+	# Command line option overrides config setting
+	! test_reset_refreshes_index "-c reset.quiet=false" --quiet &&
+	test_reset_refreshes_index "-c reset.refresh=true" --no-quiet
+'
+
+test_expect_success '--mixed --[no-]refresh sets refresh behavior' '
+	# Verify that --[no-]refresh and `reset.refresh` control index refresh
+
+	# Config setting
+	test_reset_refreshes_index "-c reset.refresh=true" &&
+	! test_reset_refreshes_index "-c reset.refresh=false" &&
+
+	# Command line option
+	test_reset_refreshes_index "" --refresh &&
+	! test_reset_refreshes_index "" --no-refresh &&
+
+	# Command line option overrides config setting
+	test_reset_refreshes_index "-c reset.refresh=false" --refresh &&
+	! test_reset_refreshes_index "-c reset.refresh=true" --no-refresh
+'
+
+test_expect_success '--mixed --refresh overrides --quiet refresh behavior' '
+	# Verify that *both* --refresh and `reset.refresh` override the
+	# default non-refresh behavior of --quiet
+	test_reset_refreshes_index "" "--quiet --refresh" &&
+	test_reset_refreshes_index "-c reset.quiet=true" --refresh &&
+	test_reset_refreshes_index "-c reset.refresh=true" --quiet &&
+	test_reset_refreshes_index "-c reset.refresh=true -c reset.quiet=true"
 '
 
 test_expect_success '--mixed preserves skip-worktree' '
-- 
gitgitgadget

