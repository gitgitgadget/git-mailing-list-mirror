Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885BF2D613
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 03:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752810758; cv=none; b=hufofwvIA44yUm+tB01YuIrNVYkZNmtaeUm3CR1N5BAbGj8PWJrt2zPhxknKZxDBsgdnrbXSDbYPKKr/C34mgV80VzuvRaVPpshw1+8jHwDIJa/5xHuyhhon9fFNn6Gx9bJ9fSlLqHI5tFyK+xJ0c6bPe5z+0oLHd8yatSdW/+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752810758; c=relaxed/simple;
	bh=S6Wk9LVCHfQ/hUQOuAaVY7RKIIk2cTh2DDR6LP214lk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oolaWWvCRiWqJDHOReldN5qZo/rgC7Je0Il1udDzRo0VCXcuCk8dDJTuBXLntDFWXaAjvenPySQRkVJD5ZA6MhqEsmZgI8Oey8wZ9fZNjZFTYfCDDNcSCuFTLOVhxQ4svYKGd1Vylc4Ml4ziEZtuqyFLHQN7ItiMMeCo/7qBky0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZRR1YBi; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZRR1YBi"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-31329098ae8so1497667a91.1
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 20:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752810756; x=1753415556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysNGHn6eKx0sWZM+/Xe1D4FaRC6JybVh8EZnTouZfao=;
        b=VZRR1YBiGpUwjoqM37V1S8m/Y0tVGfu+jtXgiYkIFr4IidRakzpfGLCoWP6klS9Kvv
         hBWu8TJ2vbVI8DEFwWGN1MFVx8kTgvhlMyFsKY/kgUY7UODf/Az8BJIG42FEY3UKWtRl
         6FerZ8vbLOup4JFd2fO0KEwuntTVbzmADOfH8/DBFfF71aVrOm/V2g3d98lY2jkyIvcj
         vQzMFm3haJkyXSxESchdmxea/l8rvb33tlG34i6I4IGz5WTNSA+jLCcee2WsSbNCqerZ
         1EccdKkm5pH+pt7vPrF271J+/va3/dtFmC3ccUjpLfEmLckLb4ptukoPH+x8VahArLEz
         wdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752810756; x=1753415556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysNGHn6eKx0sWZM+/Xe1D4FaRC6JybVh8EZnTouZfao=;
        b=ElHlYk6tnCM4Ci9DsLpgRM1B/h+5Qy10iVlFZ0lAAB48ExEtf3acmUWVY+YzsBTIyg
         rSRHV8NkY/bq4FoJaX33J0S900X+eMKTcEdPZAbwLEZh2DgnkVzKiFfyoqI21zfnM8E1
         FsWsB5ZkfDzOKS04ydFCZbTSnHDQdzceiFIMmpMsMgvzMFErNz1uAG5haU3EiW6JnUP+
         h+6uTdBFW+F1IyBp6kAYzsVbGk2SMlGki/8qQUrJ/KoYAafNRHIHLl7szqyu2kuXjH/x
         iCTsX9jQhbgPwNwPjrgqRSNCLWH0KNShGRJs7NDUBBTQAlZT8LUaGerrE32t02U1TAKX
         OmDw==
X-Gm-Message-State: AOJu0YzeQr26o+KAYzFFnqXga59OWVVfUwhX9mHNNDBkWNmG9Spljo/j
	Y1rDEFw9S/YunfM/4QHhXeD+rWUqgp3h6bARi1iXkoGR3gYFUNsij80V
X-Gm-Gg: ASbGnct/QTdc08jK9juC2Hz6QFHT6VB8mR7djMCFvTWm9XptgADIH65zn0B3xvwQZVg
	XRn9Oee11DpjaoMqzV88hs+K+wSoCCut0N+3oVdKScEs3uVjAnwjSysYAe+9ecUhGBb2lhi1Jzq
	VQlroMOVFrgV24npLK/5jB8qgGXx7ozi6X8Jf9QKAW0eP8zHIoKnnb6rIXfCWGFlfwvzE1mhWfO
	/A6IAFL5z0SRG6Lqlpk4lbYkBGHX/nEUpQJxKdlVckKFKok8WEG4rpHygfPa7EazSqqVWPVgAon
	n1ZYA69mmfcFmPiUB/WlVXcl5RTBghBuZs62AMFB4iQzO0dJZbRDJXhKlNLL9M4eT6GJBNp8oPP
	GCsswOznZpGhrwfkp5Hydlui/QQ6GBNriYpykQPI=
X-Google-Smtp-Source: AGHT+IGDyNIow7QMTtYU88tvJmEGwdf9AM+bCIm3mOl9CrKiXzXPJX4tWQCXL4mVwU0nApy5OWWR5Q==
X-Received: by 2002:a17:90b:288b:b0:30e:e9f1:8447 with SMTP id 98e67ed59e1d1-31cc03c01e6mr2854119a91.4.1752810755331;
        Thu, 17 Jul 2025 20:52:35 -0700 (PDT)
Received: from localhost.localdomain ([188.253.126.216])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3f2dbd9sm323050a91.32.2025.07.17.20.52.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Jul 2025 20:52:34 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
To: yldhome2d2@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	hi@looping.me,
	j6t@kdbg.org
Subject: [PATCH] pull: add pull.autoStash config option
Date: Fri, 18 Jul 2025 11:52:21 +0800
Message-Id: <20250718035221.2293-1-yldhome2d2@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250717030732.75106-1-yldhome2d2@gmail.com>
References: <20250717030732.75106-1-yldhome2d2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Git uses `rebase.autostash` or `merge.autostash` to determine whether a
dirty worktree is allowed during pull. However, this behavior is not
clearly documented, making it difficult for users to discover how to
enable autostash, or causing them to unknowingly enable it. Add new
config option `pull.autostash` along with its documentation and test
cases.

`pull.autostash` provides the same functionality as `rebase.autostash`
and `merge.autostash`, but overrides them when set. If `pull.autostash`
is not set, it falls back to `rebase.autostash` or `merge.autostash`,
depending on the value of `pull.rebase`.

Signed-off-by: Lidong Yan <yldhome2d2@gmail.com>
---
 Documentation/config/pull.adoc | 11 +++++
 builtin/pull.c                 | 20 ++++++--
 t/t5520-pull.sh                | 90 ++++++++++++++++++++++++++++++++++
 3 files changed, 118 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/pull.adoc b/Documentation/config/pull.adoc
index 9349e09261..3aa1e67923 100644
--- a/Documentation/config/pull.adoc
+++ b/Documentation/config/pull.adoc
@@ -13,6 +13,17 @@ pull.rebase::
 	of merging the default branch from the default remote when "git
 	pull" is run. See "branch.<name>.rebase" for setting this on a
 	per-branch basis.
+
+pull.autoStash::
+	When true, Git will automatically perform a `git stash` before the
+	operation and then restore the local changes with `git stash pop`
+	after the pull is complete. This means that you can run pull on a
+	dirty worktree. If `pull.autostash` is set, it takes precedence over
+	`rebase.autostash` and `merge.autostash`. If `pull.autostash` is not
+	set, it falls back to `rebase.autostash` or `merge.autostash`,
+	depending on the value of `pull.rebase`. This option can be
+	overridden by the `--no-autostash` and `--autostash` options of
+	linkgit:git-pull[1]. Defaults to false.
 +
 When `merges` (or just 'm'), pass the `--rebase-merges` option to 'git rebase'
 so that the local merge commits are included in the rebase (see
diff --git a/builtin/pull.c b/builtin/pull.c
index c593f324fe..2a6c2e4a37 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -90,7 +90,8 @@ static char *opt_ff;
 static const char *opt_verify_signatures;
 static const char *opt_verify;
 static int opt_autostash = -1;
-static int config_autostash;
+static int config_rebase_autostash;
+static int config_pull_autostash = -1;
 static int check_trust_level = 1;
 static struct strvec opt_strategies = STRVEC_INIT;
 static struct strvec opt_strategy_opts = STRVEC_INIT;
@@ -367,7 +368,18 @@ static int git_pull_config(const char *var, const char *value,
 			   const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(var, "rebase.autostash")) {
-		config_autostash = git_config_bool(var, value);
+		/*
+		 * run_rebase() also reads this option. The reason we handle it here is
+		 * that when pull.rebase is true, a fast-forward may occur without
+		 * invoking run_rebase(). We need to ensure that autostash is set even
+		 * in the fast-forward case.
+		 *
+		 * run_merge() handles merge.autostash, so we don't handle it here.
+		 */
+		config_rebase_autostash = git_config_bool(var, value);
+		return 0;
+	} else if (!strcmp(var, "pull.autostash")) {
+		config_pull_autostash = git_config_bool(var, value);
 		return 0;
 	} else if (!strcmp(var, "submodule.recurse")) {
 		recurse_submodules = git_config_bool(var, value) ?
@@ -1006,6 +1018,8 @@ int cmd_pull(int argc,
 	}
 
 	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
+	if (opt_autostash == -1)
+		opt_autostash = config_pull_autostash;
 
 	if (recurse_submodules_cli != RECURSE_SUBMODULES_DEFAULT)
 		recurse_submodules = recurse_submodules_cli;
@@ -1052,7 +1066,7 @@ int cmd_pull(int argc,
 
 	if (opt_rebase) {
 		if (opt_autostash == -1)
-			opt_autostash = config_autostash;
+			opt_autostash = config_rebase_autostash;
 
 		if (is_null_oid(&orig_head) && !is_index_unborn(the_repository->index))
 			die(_("Updating an unborn branch with changes added to the index."));
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 63c9a8f04b..134da2185c 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -472,6 +472,96 @@ test_expect_success 'pull --no-autostash & merge.autostash unset' '
 	test_pull_autostash_fail --no-autostash --no-rebase
 '
 
+test_expect_success 'pull succeeds with dirty working directory and pull.autostash set' '
+	test_config pull.autostash true &&
+	test_pull_autostash 1 --rebase &&
+	test_pull_autostash 2 --no-rebase
+'
+
+test_expect_success 'pull --autostash & pull.autostash=true' '
+	test_config pull.autostash true &&
+	test_pull_autostash 1 --autostash --rebase &&
+	test_pull_autostash 2 --autostash --no-rebase
+'
+
+test_expect_success 'pull --autostash & pull.autostash=false' '
+	test_config pull.autostash false &&
+	test_pull_autostash 1 --autostash --rebase &&
+	test_pull_autostash 2 --autostash --no-rebase
+'
+
+test_expect_success 'pull --autostash & pull.autostash unset' '
+	test_unconfig pull.autostash &&
+	test_pull_autostash 1 --autostash --rebase &&
+	test_pull_autostash 2 --autostash --no-rebase
+'
+
+test_expect_success 'pull --no-autostash & pull.autostash=true' '
+	test_config pull.autostash true &&
+	test_pull_autostash_fail --no-autostash --rebase &&
+	test_pull_autostash_fail --no-autostash --no-rebase
+'
+
+test_expect_success 'pull --no-autostash & pull.autostash=false' '
+	test_config pull.autostash false &&
+	test_pull_autostash_fail --no-autostash --rebase &&
+	test_pull_autostash_fail --no-autostash --no-rebase
+'
+
+test_expect_success 'pull --no-autostash & pull.autostash unset' '
+	test_unconfig pull.autostash &&
+	test_pull_autostash_fail --no-autostash --rebase &&
+	test_pull_autostash_fail --no-autostash --no-rebase
+'
+
+test_expect_success 'pull.autostash=true & rebase.autostash=true' '
+	test_config pull.autostash true &&
+	test_config rebase.autostash true &&
+	test_pull_autostash 1 --rebase
+'
+
+test_expect_success 'pull.autostash=true & rebase.autostash=false' '
+	test_config pull.autostash true &&
+	test_config rebase.autostash false &&
+	test_pull_autostash 1 --rebase
+'
+
+test_expect_success 'pull.autostash=false & rebase.autostash=true' '
+	test_config pull.autostash false &&
+	test_config rebase.autostash true &&
+	test_pull_autostash_fail --rebase
+'
+
+test_expect_success 'pull.autostash=false & rebase.autostash=false' '
+	test_config pull.autostash false &&
+	test_config rebase.autostash false &&
+	test_pull_autostash_fail --rebase
+'
+
+test_expect_success 'pull.autostash=true & merge.autostash=true' '
+	test_config pull.autostash true &&
+	test_config merge.autostash true &&
+	test_pull_autostash 2 --no-rebase
+'
+
+test_expect_success 'pull.autostash=true & merge.autostash=false' '
+	test_config pull.autostash true &&
+	test_config merge.autostash false &&
+	test_pull_autostash 2 --no-rebase
+'
+
+test_expect_success 'pull.autostash=false & merge.autostash=true' '
+	test_config pull.autostash false &&
+	test_config merge.autostash true &&
+	test_pull_autostash_fail --no-rebase
+'
+
+test_expect_success 'pull.autostash=false & merge.autostash=false' '
+	test_config pull.autostash false &&
+	test_config merge.autostash false &&
+	test_pull_autostash_fail --no-rebase
+'
+
 test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
 	test_config pull.rebase true &&
-- 
2.39.5 (Apple Git-154)

