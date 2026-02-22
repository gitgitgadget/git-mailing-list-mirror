Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84B54AEE2
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 00:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771720210; cv=pass; b=RRlw54mce5qVnzAN8cRZs4psjCwoo8fb1Warc9UjatzWGSGTGcPTfr9b/t6JYAbRGy4Kn3QBlICsjg6TEOANpjwBlhtIuqQ5E96iIAqPD2ThPvCoWD34lKS1b8cO5j+cLeoF43Ux6DeGLWvdoXmfxygnh3RdCq/BcUaNilrnRd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771720210; c=relaxed/simple;
	bh=+KyWL/F1YZ2Vue18o0ZOa8PkCUlU+S93rFeLiexhUXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMe9M9BKdcAZtO4T7M+TzS6jNvAR5OKEEVw8ulbEH1ABgbWWwu/JXsxPm7yLUUX5IhfCMIImLPSOVsGbvfqLA0p6T0J87V5Ci0t7ugpuCaUsso7Azb5YeyskODFdsaH4KhVPLos1of4rlIcBOQljMFGYRBKoLr8PN7Mc3iH5m9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=ULtj234h; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="ULtj234h"
ARC-Seal: i=1; a=rsa-sha256; t=1771720183; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YFIlrIGy24LOOv4+L1HiVdpy84X3bMbHdsJ6XMfmjcEjiVRW8UmAVnii3FHNZSiz7FH1NgT4Jc5zx31qgPo/Bv0RK6Ad9g4JAiiFxrm4y0Rjgyott5L1nWXJlQdfTtSh3j9grHQ+QhLLgrV76SVfSh8z4q/dlES2axeFxLjN/JI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771720183; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sujov4qZ9BoB0q/to7ThT5x0BJcIN0yn4dP0BfnV624=; 
	b=Dq7pxBMgpT/axLiyfG/xnQWT68199cUwzRTPTeg3Ak6WmFOUih8ORaDXeRIiwRSmRsaQFmT2pBC8rTGzbXyo1OOdqR/iUynzc8OK1PZ27NQByiC0HCorNi0EykNYzhLvFLNATZb+SPwmX6zQx2PVZv5x3zGfAaqfhjL0LGwF3tE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771720183;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=sujov4qZ9BoB0q/to7ThT5x0BJcIN0yn4dP0BfnV624=;
	b=ULtj234h55joLofLsq5IXudKQCepVnNV0EzZhSQI+7rgv4pOlwh3Sdksk1HDVU9W
	lyT3i5AcNGZa+Amemb4xg2haTuIEi1g0z4dZ7G/fT/OmKGk2br5xHGS1XiUfAn1INGj
	MJjGrlyIZ4Siai1uvP9i032I1St5MqqNT79sOEG8=
Received: by mx.zohomail.com with SMTPS id 1771720179185784.6618662893222;
	Sat, 21 Feb 2026 16:29:39 -0800 (PST)
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
Subject: [PATCH v2 10/10] hook: allow runtime enabling extensions.hookStdoutToStderr
Date: Sun, 22 Feb 2026 02:29:04 +0200
Message-ID: <20260222002904.1879356-11-adrian.ratiu@collabora.com>
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

Add a new config `hook.forceStdoutToStderr` which allows enabling
extensions.hookStdoutToStderr by default at runtime, both for new
and existing repositories.

This makes it easier for users to enable hook parallelization for
hooks like pre-push by enforcing output consistency. See previous
commit for a more in-depth explanation & alternatives considered.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/extensions.adoc |  3 ++
 Documentation/config/hook.adoc       |  6 +++
 hook.c                               | 28 ++++++++++-
 hook.h                               |  1 +
 setup.c                              | 10 ++++
 t/t1800-hook.sh                      | 69 ++++++++++++++++++++++++++++
 6 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
index 342734668d..b152c6f681 100644
--- a/Documentation/config/extensions.adoc
+++ b/Documentation/config/extensions.adoc
@@ -113,6 +113,9 @@ in parallel to be grouped (de-interleaved) correctly.
 +
 Defaults to disabled. When disabled, `hook.jobs` has no effect for pre-push
 hooks, which will always be run sequentially.
++
+The extension can also be enabled by setting `hook.forceStdoutToStderr`
+to `true` in the global configuration.
 
 worktreeConfig:::
 	If enabled, then worktrees will load config settings from the
diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
index aa8a949a36..7b81d2b615 100644
--- a/Documentation/config/hook.adoc
+++ b/Documentation/config/hook.adoc
@@ -65,3 +65,9 @@ This setting has no effect unless all configured hooks for the event have
 +
 This has no effect for hooks requiring separate output streams (like `pre-push`)
 unless `extensions.hookStdoutToStderr` is enabled.
+
+hook.forceStdoutToStderr::
+	A boolean that enables the `extensions.hookStdoutToStderr` behavior
+	(merging stdout to stderr for all hooks) globally. This effectively
+	forces all hooks to behave as if the extension was enabled, allowing
+	parallel execution for hooks like `pre-push`.
diff --git a/hook.c b/hook.c
index 013e41a8d6..d5675df238 100644
--- a/hook.c
+++ b/hook.c
@@ -136,6 +136,7 @@ struct hook_config_cache_entry {
  * event_jobs: event-name to per-event jobs count (heap-allocated unsigned int *,
  *             where NULL == unset).
  * jobs: value of the global hook.jobs key. Defaults to 0 if unset.
+ * force_stdout_to_stderr: value of hook.forceStdoutToStderr. Defaults to 0.
  */
 struct hook_all_config_cb {
 	struct strmap commands;
@@ -144,6 +145,7 @@ struct hook_all_config_cb {
 	struct strmap parallel_hooks;
 	struct strmap event_jobs;
 	unsigned int jobs;
+	int force_stdout_to_stderr;
 };
 
 /* repo_config() callback that collects all hook.* configuration in one pass. */
@@ -169,6 +171,10 @@ static int hook_config_lookup_all(const char *key, const char *value,
 				warning(_("hook.jobs must be positive, ignoring: 0"));
 			else
 				data->jobs = v;
+		} else if (!strcmp(subkey, "forcestdouttostderr") && value) {
+			int v = git_parse_maybe_bool(value);
+			if (v >= 0)
+				data->force_stdout_to_stderr = v;
 		}
 		return 0;
 	}
@@ -325,6 +331,7 @@ static void build_hook_config_map(struct repository *r,
 
 	cache->jobs = cb_data.jobs;
 	cache->event_jobs = cb_data.event_jobs;
+	cache->force_stdout_to_stderr = cb_data.force_stdout_to_stderr;
 
 	strmap_clear(&cb_data.commands, 1);
 	strmap_clear(&cb_data.parallel_hooks, 0); /* values are uintptr_t, not heap ptrs */
@@ -530,6 +537,20 @@ static void run_hooks_opt_clear(struct run_hooks_opt *options)
 	strvec_clear(&options->args);
 }
 
+static void hook_force_apply_stdout_to_stderr(struct repository *r,
+					      struct run_hooks_opt *options)
+{
+	int force = 0;
+
+	if (r && r->gitdir && r->hook_config_cache)
+		force = r->hook_config_cache->force_stdout_to_stderr;
+	else
+		repo_config_get_bool(r, "hook.forceStdoutToStderr", &force);
+
+	if (force)
+		options->stdout_to_stderr = 1;
+}
+
 /* Determine how many jobs to use for hook execution. */
 static unsigned int get_hook_jobs(struct repository *r,
 				  struct run_hooks_opt *options,
@@ -539,9 +560,12 @@ static unsigned int get_hook_jobs(struct repository *r,
 	unsigned int jobs;
 
 	/*
-	 * Hooks needing separate output streams must run sequentially. Next
-	 * commits will add an extension to allow parallelizing these as well.
+	 * Apply hook.forceStdoutToStderr before anything else: it affects
+	 * whether we can run in parallel or not.
 	 */
+	hook_force_apply_stdout_to_stderr(r, options);
+
+	/* Hooks needing separate output streams must run sequentially. */
 	if (!options->stdout_to_stderr)
 		return 1;
 
diff --git a/hook.h b/hook.h
index 22fc59e67a..6ea6dbca40 100644
--- a/hook.h
+++ b/hook.h
@@ -224,6 +224,7 @@ struct hook_config_cache {
 	struct strmap hooks; /* maps event name -> string_list of hooks */
 	struct strmap event_jobs; /* maps event name -> heap-allocated unsigned int * */
 	unsigned int jobs; /* hook.jobs config value; 0 if unset (defaults to serial) */
+	int force_stdout_to_stderr; /* hook.forceStdoutToStderr config value */
 };
 
 /**
diff --git a/setup.c b/setup.c
index 75f115faba..c64496adac 100644
--- a/setup.c
+++ b/setup.c
@@ -2317,6 +2317,7 @@ void initialize_repository_version(int hash_algo,
 	struct strbuf repo_version = STRBUF_INIT;
 	int target_version = GIT_REPO_VERSION;
 	int default_submodule_path_config = 0;
+	int default_hook_stdout_to_stderr = 0;
 
 	/*
 	 * Note that we initialize the repository version to 1 when the ref
@@ -2364,6 +2365,15 @@ void initialize_repository_version(int hash_algo,
 		repo_config_set(the_repository, "extensions.submodulepathconfig", "true");
 	}
 
+	repo_config_get_bool(the_repository, "hook.forceStdoutToStderr",
+			     &default_hook_stdout_to_stderr);
+	if (default_hook_stdout_to_stderr) {
+		/* extensions.hookstdouttostderr requires at least version 1 */
+		if (target_version == 0)
+			target_version = 1;
+		repo_config_set(the_repository, "extensions.hookstdouttostderr", "true");
+	}
+
 	strbuf_addf(&repo_version, "%d", target_version);
 	repo_config_set(the_repository, "core.repositoryformatversion", repo_version.buf);
 
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index d1a0d0a3d4..d8f60f2ced 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -916,4 +916,73 @@ test_expect_success 'hook.<event>.jobs still requires hook.<name>.parallel=true'
 	test_cmp expect hook.order
 '
 
+test_expect_success '`git init` respects hook.forceStdoutToStderr' '
+	test_when_finished "rm -rf repo-init" &&
+	test_config_global hook.forceStdoutToStderr true &&
+	git init repo-init &&
+	git -C repo-init config extensions.hookStdoutToStderr >actual &&
+	echo true >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '`git init` does not set extensions.hookStdoutToStderr by default' '
+	test_when_finished "rm -rf upstream" &&
+	git init upstream &&
+	test_must_fail git -C upstream config extensions.hookStdoutToStderr
+'
+
+test_expect_success '`git clone` does not set extensions.hookStdoutToStderr by default' '
+	test_when_finished "rm -rf upstream repo-clone-no-ext" &&
+	git init upstream &&
+	git clone upstream repo-clone-no-ext &&
+	test_must_fail git -C repo-clone-no-ext config extensions.hookStdoutToStderr
+'
+
+test_expect_success '`git clone` respects hook.forceStdoutToStderr' '
+	test_when_finished "rm -rf upstream repo-clone" &&
+	git init upstream &&
+	test_config_global hook.forceStdoutToStderr true &&
+	git clone upstream repo-clone &&
+	git -C repo-clone config extensions.hookStdoutToStderr >actual &&
+	echo true >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'hook.forceStdoutToStderr enables extension for existing repos' '
+	test_when_finished "rm -rf remote-repo existing-repo" &&
+	git init --bare remote-repo &&
+	git init -b main existing-repo &&
+	# No local extensions.hookStdoutToStderr config set here
+	# so global config should apply
+	test_config_global hook.forceStdoutToStderr true &&
+	cd existing-repo &&
+	test_commit A &&
+	git remote add origin ../remote-repo &&
+	setup_hooks pre-push &&
+	git push origin HEAD >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr pre-push &&
+	cd ..
+'
+
+test_expect_success 'hook.forceStdoutToStderr enables pre-push parallel runs' '
+	test_when_finished "rm -rf repo-parallel remote-parallel" &&
+	git init --bare remote-parallel &&
+	git init repo-parallel &&
+	git -C repo-parallel remote add origin ../remote-parallel &&
+	test_commit -C repo-parallel A &&
+
+	write_sentinel_hook repo-parallel/.git/hooks/pre-push &&
+	git -C repo-parallel config hook.hook-2.event pre-push &&
+	git -C repo-parallel config hook.hook-2.command \
+	    "$(sentinel_detector sentinel hook.order)" &&
+	git -C repo-parallel config hook.hook-2.parallel true &&
+
+	git -C repo-parallel config hook.jobs 2 &&
+	git -C repo-parallel config hook.forceStdoutToStderr true &&
+
+	git -C repo-parallel push origin HEAD >out 2>err &&
+	echo parallel >expect &&
+	test_cmp expect repo-parallel/hook.order
+'
+
 test_done
-- 
2.52.0.732.gb351b5166d.dirty

