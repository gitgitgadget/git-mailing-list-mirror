Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E06A17F0
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 03:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708227197; cv=none; b=BnhPNBDsBXuPtfoMLaOlU9Z5sD56wvRGl+rLwG1DtxcPbOs4XifuuXathwDx1C/7COPk8lRgHTTOVU/semFrfpbqen/0KihWsTRNZ1+KFho7hle8Y00+rNrV+K8yq0hKdEMy3xP7OGQ+is5v1hDki9DAPfPPNGbZKDhmtUz2MsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708227197; c=relaxed/simple;
	bh=vwLMm264DreVcMhSrfA/o+W6cvdBWXp/bew4fXom4Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nhPjE26oU+Cm4aPWgyD53uJrQvJU3vu//hOlOq6Ol/mllUC6g6NkelstbnFSPHEEMjgsxCYDCmPh/7xHoQNwH5GLJYYrh1zRJNxZHr9AJt/yaM0aVAqI/MQeO4AZU0+pnoZ4Qq7j7i4flzTctP2kwfeQTKhIRONmAeyMhX1jL3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lD2g03vf; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lD2g03vf"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-785d57056b0so193579185a.0
        for <git@vger.kernel.org>; Sat, 17 Feb 2024 19:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708227194; x=1708831994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ejjlnJI3fE4CbxDo56yk7ELYjq1BcQKFUl04oMBursE=;
        b=lD2g03vfNwRdikDpYBydzHSex+gTJWirUjZjDxlY9dUq4Jc5qBQp/ecX+ZgFIDEs6b
         SpHJhmpWuYG4t7w9EvvsRHvMXTXBZZbImVxT+3LNCzUmxnYkTHdfYCQSp+FXLlJ5Z1Er
         wRhlkUe9TdlMsD4qudKKZU8uDptDkYKvFoZs8KuVGpJfCXWpwGcMQwdwOYjPtsB2F5z0
         TdK51vyN0L61B72AlLfEbBib0kDoqdteclYCJGbGGa5Tbgc2LK0uS2Kz9OQLMR0Sn3Ld
         8fneVLUVmW003Fc7QjcLRe45w2ZWviQ1P1B4K13E3zkmnxrbacMXHRxRTxUDiZNSD12e
         A2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708227194; x=1708831994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ejjlnJI3fE4CbxDo56yk7ELYjq1BcQKFUl04oMBursE=;
        b=hlJeMRQdY0UMMkJAtwXZj0fb5ETuqu5Hd0psNLX2nnKLUsBYai/hXSrbYvhpZa6bP6
         tnpbRx0KPuAHXbilM9zu1setew29bLfdhnzao/4YcRdizSLDS+kYwrBvnaG34FR/UKvl
         zOeXTpAr/EP/nncY/ffEHzidO0U8Bg5orRiZUdzBLT/yndxXyIbzTXAOHr7jiP+Nd7H/
         g+MAWsd/KxUsTRFRHdkNiC1/7gjCyvwns1WYfFtyFwnWa62qtl7wuiJy7ri2lKL7hTrS
         72oaj2A0uZIR4pMlaIlXSfNEOLGsTjklFXAs4onxY0Jr+KPbkADEz+/a+AxSRu6nFz3E
         6oKQ==
X-Gm-Message-State: AOJu0YxxqGVI4rynD46WSil/b/DYgOvPLBpNBFinei/PE+zrbNVaG9dX
	YHAzj2e3GcCzfjDY6FLfqCtgURm1XsPtojw1gKNTdfVmwV+OwHUPLwPpIoKfKS8=
X-Google-Smtp-Source: AGHT+IH7bMmko8D0271f500ej8wyVJolhtxLjSXtDIStrFQN8qaExo5rvy/En05TH+Uu4OLzE9uL+g==
X-Received: by 2002:a05:620a:29d2:b0:787:3f0e:ee22 with SMTP id s18-20020a05620a29d200b007873f0eee22mr8948656qkp.55.1708227193608;
        Sat, 17 Feb 2024 19:33:13 -0800 (PST)
Received: from apollonius.localdomain ([152.3.43.40])
        by smtp.gmail.com with ESMTPSA id q26-20020ae9e41a000000b00783ce19f9e6sm1314223qkc.57.2024.02.17.19.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 19:33:13 -0800 (PST)
From: MithicSpirit <rpc01234@gmail.com>
To: git@vger.kernel.org
Cc: MithicSpirit <rpc01234@gmail.com>
Subject: [PATCH] builtin/stash: configs keepIndex, includeUntracked
Date: Sat, 17 Feb 2024 22:30:46 -0500
Message-ID: <20240218033146.372727-2-rpc01234@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds options `stash.keepIndex` and `stash.includeUntracked`, which
enable `--keep-index` and `--include-untracked` by default (unless it
would conflict with another option). This is done to facilitate the
workflow where a user:

. Makes modifications;
. Selectively adds them with `git add -p`; and
. Stashes the unadded changes to run tests with only the current
  modifications.

`stash.keepIndex` is especially important for this, as otherwise the
work done in `git add -p` is lost since applying the stash does not
restore the index. This problem could also be solved by adding
functionality to the stash to restore the index specifically, but this
would create much more complexity and still wouldn't be as convenient
for that workflow.

Signed-off-by: Ricardo Prado Cunha (MithicSpirit) <rpc01234@gmail.com>
---
This is my first patch to git and my first time using mailing lists for this
kind of stuff. Please do let me know of any mistakes or gaffes I've made.

 Documentation/config/stash.txt |  13 ++++
 builtin/stash.c                |  65 ++++++++++++------
 t/t3903-stash.sh               | 119 +++++++++++++++++++++++++++++++++
 3 files changed, 178 insertions(+), 19 deletions(-)

diff --git a/Documentation/config/stash.txt b/Documentation/config/stash.txt
index ec1edaeba6..d6d9ea7daa 100644
--- a/Documentation/config/stash.txt
+++ b/Documentation/config/stash.txt
@@ -1,6 +1,19 @@
+stash.includeUntracked::
+	Boolean option that configures whether the `git stash push` and `git
+	stash save` commands also stash untracked files by default. This option
+	is ignored if `--include-untracked`, `--no-include-untracked`, `--all`,
+	`--patch`, or `--staged` are used. Defaults to `false`. See
+	linkgit:git-stash[1].
+
+stash.keepIndex::
+	Boolean option that configures whether the `git stash push` and `git
+	stash save` commands also stash changes that have been added to the
+	index. This option is ignored if `--keep-index`, `--no-keep-index`, or
+	`--patch` are used. Defaults to `false`. See linkgit:git-stash[1].
+
 stash.showIncludeUntracked::
 	If this is set to true, the `git stash show` command will show
 	the untracked files of a stash entry.  Defaults to false. See
 	the description of the 'show' command in linkgit:git-stash[1].

 stash.showPatch::
diff --git a/builtin/stash.c b/builtin/stash.c
index 7fb355bff0..c591a2bf4b 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -836,12 +836,14 @@ static int list_stash(int argc, const char **argv, const char *prefix)
 	return run_command(&cp);
 }

 static int show_stat = 1;
 static int show_patch;
 static int show_include_untracked;
+static int default_keep_index;
+static int default_include_untracked;

 static int git_stash_config(const char *var, const char *value,
 			    const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(var, "stash.showstat")) {
 		show_stat = git_config_bool(var, value);
@@ -852,12 +854,20 @@ static int git_stash_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "stash.showincludeuntracked")) {
 		show_include_untracked = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "stash.keepindex")) {
+		default_keep_index = git_config_bool(var, value);
+		return 0;
+	}
+	if (!strcmp(var, "stash.includeuntracked")) {
+		default_include_untracked = git_config_bool(var, value);
+		return 0;
+	}
 	return git_diff_basic_config(var, value, ctx, cb);
 }

 static void diff_include_untracked(const struct stash_info *info, struct diff_options *diff_opt)
 {
 	const struct object_id *oid[] = { &info->w_commit, &info->u_tree };
@@ -1509,33 +1519,50 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 	int ret = 0;
 	struct stash_info info = STASH_INFO_INIT;
 	struct strbuf patch = STRBUF_INIT;
 	struct strbuf stash_msg_buf = STRBUF_INIT;
 	struct strbuf untracked_files = STRBUF_INIT;

-	if (patch_mode && keep_index == -1)
-		keep_index = 1;
-
-	if (patch_mode && include_untracked) {
-		fprintf_ln(stderr, _("Can't use --patch and --include-untracked"
-				     " or --all at the same time"));
-		ret = -1;
-		goto done;
+	if (keep_index == -1) {
+		if (patch_mode)
+			keep_index = 1;
+		else
+			keep_index = default_keep_index;
 	}

-	/* --patch overrides --staged */
-	if (patch_mode)
+	if (patch_mode) {
+		if (include_untracked == -1)
+			include_untracked = 0;
+		else if (include_untracked) {
+			fprintf_ln(stderr,
+				   _("Can't use --patch and --include-untracked"
+				     " or --all at the same time"));
+			ret = -1;
+			goto done;
+		}
+
+		/* --patch overrides --staged */
 		only_staged = 0;
-
-	if (only_staged && include_untracked) {
-		fprintf_ln(stderr, _("Can't use --staged and --include-untracked"
-				     " or --all at the same time"));
-		ret = -1;
-		goto done;
 	}

+	if (only_staged) {
+		if (include_untracked == -1)
+			include_untracked = 0;
+		else if (include_untracked) {
+			fprintf_ln(
+				stderr,
+				_("Can't use --staged and --include-untracked"
+				  " or --all at the same time"));
+			ret = -1;
+			goto done;
+		}
+	}
+
+	if (include_untracked == -1)
+		include_untracked = default_include_untracked;
+
 	repo_read_index_preload(the_repository, NULL, 0);
 	if (!include_untracked && ps->nr) {
 		int i;
 		char *ps_matched = xcalloc(ps->nr, 1);

 		/* TODO: audit for interaction with sparse-index. */
@@ -1688,13 +1715,13 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 				fprintf_ln(stderr, _("Cannot remove "
 						     "worktree changes"));
 			ret = -1;
 			goto done;
 		}

-		if (keep_index < 1) {
+		if (!keep_index) {
 			struct child_process cp = CHILD_PROCESS_INIT;

 			cp.git_cmd = 1;
 			strvec_pushl(&cp.args, "reset", "-q", "--refresh", "--",
 				     NULL);
 			add_pathspecs(&cp.args, ps);
@@ -1718,13 +1745,13 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 		      int push_assumed)
 {
 	int force_assume = 0;
 	int keep_index = -1;
 	int only_staged = 0;
 	int patch_mode = 0;
-	int include_untracked = 0;
+	int include_untracked = -1;
 	int quiet = 0;
 	int pathspec_file_nul = 0;
 	const char *stash_msg = NULL;
 	const char *pathspec_from_file = NULL;
 	struct pathspec ps;
 	struct option options[] = {
@@ -1798,13 +1825,13 @@ static int push_stash_unassumed(int argc, const char **argv, const char *prefix)

 static int save_stash(int argc, const char **argv, const char *prefix)
 {
 	int keep_index = -1;
 	int only_staged = 0;
 	int patch_mode = 0;
-	int include_untracked = 0;
+	int include_untracked = -1;
 	int quiet = 0;
 	int ret = 0;
 	const char *stash_msg = NULL;
 	struct pathspec ps;
 	struct strbuf stash_msg_buf = STRBUF_INIT;
 	struct option options[] = {
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 00db82fb24..4ffcca742c 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1565,7 +1565,126 @@ test_expect_success 'stash apply reports a locked index' '
 		EOF
 		test_must_fail git stash apply 2>err &&
 		test_cmp expect err
 	)
 '

+setup_dirty() {
+	echo a >tracked &&
+	echo b >added-modified &&
+	git add tracked added-modified &&
+	git commit -m initial &&
+	echo 1 >>tracked &&
+	echo 2 >>added-modified &&
+	echo c >added-new &&
+	echo d >untracked &&
+	git add added-modified added-new
+}
+
+test_expect_success 'stash.includeuntracked equivalent to --include-untracked' '
+	git init using_opt &&
+	test_when_finished rm -rf using_opt &&
+	(
+		cd using_opt &&
+		setup_dirty &&
+		git stash push &&
+		git stash show -u --patch >../using-opt
+	) &&
+
+	test_config stash.includeuntracked true &&
+	git init using_config &&
+	test_when_finished rm -rf using_config &&
+	(
+		cd using_config &&
+		setup_dirty &&
+		git stash push &&
+		git stash show -u --patch >../using-config
+	) &&
+
+	test_cmp using-opt using-config
+'
+
+test_expect_success 'stash.includeuntracked yields to --no-include-untracked' '
+	git init no_config &&
+	test_when_finished rm -rf no_config &&
+	(
+		cd no_config &&
+		setup_dirty &&
+		git stash push --no-include-untracked &&
+		git stash show -u --patch >../no-config
+	) &&
+
+	test_config stash.includeuntracked true &&
+	git init using_config &&
+	test_when_finished rm -rf using_config &&
+	(
+		cd using_config &&
+		setup_dirty &&
+		git stash push --no-include-untracked &&
+		git stash show -u --patch >../using-config
+	) &&
+
+	test_cmp no-config using-config
+'
+
+test_expect_success 'stash.includeuntracked succeeds with --patch' '
+	test_config stash.includeuntracked true &&
+	git stash --patch
+'
+
+test_expect_success 'stash.includeuntracked succeeds with --staged' '
+	test_config stash.includeuntracked true &&
+	git stash --staged
+'
+
+test_expect_success 'stash.keepindex equivalent to --keep-index' '
+	git init using_opt &&
+	test_when_finished rm -rf using_opt &&
+	(
+		cd using_opt &&
+		setup_dirty &&
+		git stash push &&
+		git stash show -u --patch >../using-opt
+	) &&
+
+	test_config stash.keepindex true &&
+	git init using_config &&
+	test_when_finished rm -rf using_config &&
+	(
+		cd using_config &&
+		setup_dirty &&
+		git stash push &&
+		git stash show -u --patch >../using-config
+	) &&
+
+	test_cmp using-opt using-config
+'
+
+test_expect_success 'stash.keepindex yields to --no-keep-index' '
+	git init no_config &&
+	test_when_finished rm -rf no_config &&
+	(
+		cd no_config &&
+		setup_dirty &&
+		git stash push --no-keep-index &&
+		git stash show -u --patch >../no-config
+	) &&
+
+	test_config stash.keepindex true &&
+	git init using_config &&
+	test_when_finished rm -rf using_config &&
+	(
+		cd using_config &&
+		setup_dirty &&
+		git stash push --no-keep-index &&
+		git stash show -u --patch >../using-config
+	) &&
+
+	test_cmp no-config using-config
+'
+
+test_expect_success 'stash.keepindex succeeds with --patch' '
+	test_config stash.keepindex true &&
+	git stash --patch
+'
+
 test_done
--
2.43.2
