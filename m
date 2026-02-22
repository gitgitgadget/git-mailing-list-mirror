Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1028B770FE
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 00:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771720201; cv=pass; b=oKl43YYlq/FS17oryuDj37CeJ3v2B2WH7dpgUsUEabSR1cb3SPyp54Gbs1rEiLcpV4wCXhZO4LsWqk9Td8GcAD3QeR9S55v84WCBRtB5u57tgbxSBM+WyWQx7uBiQ1I05nzPxr55NbDM0UmV/HwEx9KburoutMKWhPUSVREONCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771720201; c=relaxed/simple;
	bh=dVHT5nZOeOaypftsF/dDbQFaYQBZc2cU10pV2IpmH30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prps7bBPB/0Jg6YBUnjgUBVJ4xhvaemOSC9YjU1TDj89fXklRUvcrNQptVNPX2wd5g1rJRf5ADMf5Zp0ZC71o1GjeZJRQeutdM8N53ZHxW8l0JzcS1oelf6KSzojCzwAXkJNmGEaXrwsXzPzZTwTwPlaUwToJ7vlDznG5Vqht5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=W6F5Jq/c; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="W6F5Jq/c"
ARC-Seal: i=1; a=rsa-sha256; t=1771720181; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=R6gyRmvL863l6J/M8MAGM7xymy8+35rN/WVZc6QsywGxptI9nRzcW7fV264yvZpO+hfGU8cKxXSU/2UHFiah3Lyl+MYgyXOGmO3BIUmv3hYXvSh9GlD38AK664M1TUKZq6JgE2gTfITiDbnzAPhqiudB7S/k/z3kcBHg2XmFa0k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771720181; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TXBQALBBd5uidNe9GQtS9PG8J0koEgDs2yjr+Dw9WUA=; 
	b=fTHjtObk7Bdf+duzx0YSfh8BH4SHZdC/Ed+SD91DxliJwnHM7wB/wPg4iNg5DjjSUH1wAfLemHFSXpx3XAISOS8OHbN6QQ+4ZTzKHcrdvb2qqVp6SstaPUofxo+MEcTm2/OZa59zgdHNu73NHhcRw2/x9C0VgPsk4s8SpaWGALo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771720181;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=TXBQALBBd5uidNe9GQtS9PG8J0koEgDs2yjr+Dw9WUA=;
	b=W6F5Jq/cj0BP7v29prAB1wy/47KhQL06+64tyXEUR0Bt7QAS8NVEK9l5kVM28F2X
	/VARWwMx7NgweVw9B/zvyKfQNAq9Cd+BwFmRqoeA+0hyHrbkKFsG22wI2swdnxr+qFY
	spYf/MQX2Y5yaKvi4+MOkrVgow58bGLWgB0HaRsc=
Received: by mx.zohomail.com with SMTPS id 1771720177146888.9821505290888;
	Sat, 21 Feb 2026 16:29:37 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 09/10] hook: introduce extensions.hookStdoutToStderr
Date: Sun, 22 Feb 2026 02:29:03 +0200
Message-ID: <20260222002904.1879356-10-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260222002904.1879356-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260222002904.1879356-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

All hooks already redirect stdout to stderr with the exception of
pre-push which has a known user who depends on the separate stdout
versus stderr outputs (the git-lfs project).

The pre-push behavior was a surprise which we found out about after
causing a regression for git-lfs. Notably, it might not be the only
exception (it's the one we know about). There might be more.

This presents a challenge because stdout_to_stderr is required for
hook parallelization, so run-command can buffer and de-interleave
the hook outputs using ungroup=0, when hook.jobs > 1.

Introduce an extension to enforce consistency: all hooks merge stdout
into stderr and can be safely parallelized. This provides a clean
separation and avoids breaking existing stdout vs stderr behavior.

When this extension is disabled, the `hook.jobs` config has no
effect for pre-push, to prevent garbled (interleaved) parallel
output, so it runs sequentially like before.

Alternatives I've considered to this extension include:
1. Allowing pre-push to run in parallel with interleaved output.
2. Always running pre-push sequentially (no parallel jobs for it).
3. Making users (only git-lfs? maybe more?) fix their hooks to read
   stderr not stdout.

Out of all these alternatives, I think this extension is the most
reasonable compromise, to not break existing users, allow pre-push
parallel jobs for those who need it (with correct outputs) and also
future-proofing in case there are any more exceptions to be added.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/extensions.adoc | 12 +++++++++
 Documentation/config/hook.adoc       |  3 +++
 repository.c                         |  1 +
 repository.h                         |  1 +
 setup.c                              |  7 ++++++
 setup.h                              |  1 +
 t/t1800-hook.sh                      | 37 ++++++++++++++++++++++++++++
 transport.c                          |  7 ++----
 8 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
index 2aef3315b1..342734668d 100644
--- a/Documentation/config/extensions.adoc
+++ b/Documentation/config/extensions.adoc
@@ -102,6 +102,18 @@ The extension can be enabled automatically for new repositories by setting
 `init.defaultSubmodulePathConfig` to `true`, for example by running
 `git config --global init.defaultSubmodulePathConfig true`.
 
+hookStdoutToStderr:::
+	If enabled, the stdout of all hooks is redirected to stderr. This
+	enforces consistency, since by default most hooks already behave
+	this way, with pre-push being the only known exception.
++
+This is useful for parallel hook execution (see the `hook.jobs` config in
+linkgit:git-config[1]), as it allows the output of multiple hooks running
+in parallel to be grouped (de-interleaved) correctly.
++
+Defaults to disabled. When disabled, `hook.jobs` has no effect for pre-push
+hooks, which will always be run sequentially.
+
 worktreeConfig:::
 	If enabled, then worktrees will load config settings from the
 	`$GIT_DIR/config.worktree` file in addition to the
diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
index 6ad23ac71d..aa8a949a36 100644
--- a/Documentation/config/hook.adoc
+++ b/Documentation/config/hook.adoc
@@ -62,3 +62,6 @@ hook.jobs::
 +
 This setting has no effect unless all configured hooks for the event have
 `hook.<name>.parallel` set to `true`.
++
+This has no effect for hooks requiring separate output streams (like `pre-push`)
+unless `extensions.hookStdoutToStderr` is enabled.
diff --git a/repository.c b/repository.c
index 78aa2d31d0..d7f247b676 100644
--- a/repository.c
+++ b/repository.c
@@ -283,6 +283,7 @@ int repo_init(struct repository *repo,
 	repo->repository_format_relative_worktrees = format.relative_worktrees;
 	repo->repository_format_precious_objects = format.precious_objects;
 	repo->repository_format_submodule_path_cfg = format.submodule_path_cfg;
+	repo->repository_format_hook_stdout_to_stderr = format.hook_stdout_to_stderr;
 
 	/* take ownership of format.partial_clone */
 	repo->repository_format_partial_clone = format.partial_clone;
diff --git a/repository.h b/repository.h
index 2105768b8c..a4d7f129ad 100644
--- a/repository.h
+++ b/repository.h
@@ -173,6 +173,7 @@ struct repository {
 	int repository_format_relative_worktrees;
 	int repository_format_precious_objects;
 	int repository_format_submodule_path_cfg;
+	int repository_format_hook_stdout_to_stderr;
 
 	/* Indicate if a repository has a different 'commondir' from 'gitdir' */
 	unsigned different_commondir:1;
diff --git a/setup.c b/setup.c
index c8336eb20e..75f115faba 100644
--- a/setup.c
+++ b/setup.c
@@ -688,6 +688,9 @@ static enum extension_result handle_extension(const char *var,
 	} else if (!strcmp(ext, "submodulepathconfig")) {
 		data->submodule_path_cfg = git_config_bool(var, value);
 		return EXTENSION_OK;
+	} else if (!strcmp(ext, "hookstdouttostderr")) {
+		data->hook_stdout_to_stderr = git_config_bool(var, value);
+		return EXTENSION_OK;
 	}
 	return EXTENSION_UNKNOWN;
 }
@@ -1951,6 +1954,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 				repo_fmt.relative_worktrees;
 			the_repository->repository_format_submodule_path_cfg =
 				repo_fmt.submodule_path_cfg;
+			the_repository->repository_format_hook_stdout_to_stderr =
+				repo_fmt.hook_stdout_to_stderr;
 			/* take ownership of repo_fmt.partial_clone */
 			the_repository->repository_format_partial_clone =
 				repo_fmt.partial_clone;
@@ -2053,6 +2058,8 @@ void check_repository_format(struct repository_format *fmt)
 		fmt->submodule_path_cfg;
 	the_repository->repository_format_relative_worktrees =
 		fmt->relative_worktrees;
+	the_repository->repository_format_hook_stdout_to_stderr =
+		fmt->hook_stdout_to_stderr;
 	the_repository->repository_format_partial_clone =
 		xstrdup_or_null(fmt->partial_clone);
 	clear_repository_format(&repo_fmt);
diff --git a/setup.h b/setup.h
index 0738dec244..9de6e9b59c 100644
--- a/setup.h
+++ b/setup.h
@@ -168,6 +168,7 @@ struct repository_format {
 	int worktree_config;
 	int relative_worktrees;
 	int submodule_path_cfg;
+	int hook_stdout_to_stderr;
 	int is_bare;
 	int hash_algo;
 	int compat_hash_algo;
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index f5c0655adb..d1a0d0a3d4 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -532,6 +532,43 @@ test_expect_success 'client hooks: pre-push expects separate stdout and stderr'
 	check_stdout_separate_from_stderr pre-push
 '
 
+test_expect_success 'client hooks: extension makes pre-push merge stdout to stderr' '
+	test_when_finished "rm -rf remote2 stdout.actual stderr.actual" &&
+	git init --bare remote2 &&
+	git remote add origin2 remote2 &&
+	test_commit B &&
+	git config set core.repositoryformatversion 1 &&
+	test_config extensions.hookStdoutToStderr true &&
+	setup_hooks pre-push &&
+	git push origin2 HEAD:main >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr pre-push
+'
+
+test_expect_success 'client hooks: pre-push defaults to serial execution' '
+	test_when_finished "rm -rf remote-serial repo-serial" &&
+	git init --bare remote-serial &&
+	git init repo-serial &&
+	git -C repo-serial remote add origin ../remote-serial &&
+	test_commit -C repo-serial A &&
+
+	# Setup 2 pre-push hooks; no parallel=true so they must run serially.
+	# Use sentinel/detector pattern: hook-1 (sentinel, configured) runs first
+	# because configured hooks precede traditional hooks in list order; hook-2
+	# (detector) runs second and checks whether hook-1 has finished.
+	git -C repo-serial config hook.hook-1.event pre-push &&
+	git -C repo-serial config hook.hook-1.command \
+	    "touch sentinel.started; sleep 2; touch sentinel.done" &&
+	git -C repo-serial config hook.hook-2.event pre-push &&
+	git -C repo-serial config hook.hook-2.command \
+	    "$(sentinel_detector sentinel hook.order)" &&
+
+	git -C repo-serial config hook.jobs 2 &&
+
+	git -C repo-serial push origin HEAD >out 2>err &&
+	echo serial >expect &&
+	test_cmp expect repo-serial/hook.order
+'
+
 test_expect_success 'client hooks: commit hooks expect stdout redirected to stderr' '
 	hooks="pre-commit prepare-commit-msg \
 		commit-msg post-commit \
diff --git a/transport.c b/transport.c
index 1581aa0886..97a9c89e16 100644
--- a/transport.c
+++ b/transport.c
@@ -1388,11 +1388,8 @@ static int run_pre_push_hook(struct transport *transport,
 	opt.feed_pipe_cb_data_alloc = pre_push_hook_data_alloc;
 	opt.feed_pipe_cb_data_free = pre_push_hook_data_free;
 
-	/*
-	 * pre-push hooks expect stdout & stderr to be separate, so don't merge
-	 * them to keep backwards compatibility with existing hooks.
-	 */
-	opt.stdout_to_stderr = 0;
+	/* merge stdout to stderr only when extensions.hookStdoutToStderr is enabled */
+	opt.stdout_to_stderr = the_repository->repository_format_hook_stdout_to_stderr;
 
 	ret = run_hooks_opt(the_repository, "pre-push", &opt);
 
-- 
2.52.0.732.gb351b5166d.dirty

