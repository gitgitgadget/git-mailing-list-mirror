Received: from sender4-pp-g123.zoho.com (sender4-pp-g123.zoho.com [136.143.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1815434B425
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 17:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770226457; cv=pass; b=HGqAmBUMjV3aqQbA5rYdlQTqbdGPYjK5FKR0L4/WmS1k3+y7RFdYKStsOh1AWqi7xYqCnttwoWxFd43Tys/v8bTPIY8yVRtlIF6/Q11PaR7igT3mISZHV83JbIlm8Wp7kg4rI35OekfdGPHlFBuNP/x3ZMMAdQemXc3pxMJU9Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770226457; c=relaxed/simple;
	bh=jgd9fHnach0WQXp6KAAAXS02+o3IbxRLeZHkO4LYk6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvhalm3FkamyLQdHyc22NMb8k76sd5y11axYiJNO0QyBskPNkeV7+/mtOzzpLjK5Nentaq8aZX9Q3QXEkoMhyNFTojOHWaZCAS0lHE5o+su807M35A5kQ3MDm3NY++Wl9NZojWjBP7J21aHtb0Fvdyi8pl9k8+VNxtN+zW5jfKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=FCqmwI5k; arc=pass smtp.client-ip=136.143.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="FCqmwI5k"
ARC-Seal: i=1; a=rsa-sha256; t=1770226443; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Y+VVaRZgDt0eNau51AqeTpLlG89CXMI4xrjpstgMW+D8Ubz2RMWMhjS3OHPvmvkXfvXgYwsoXOqj3Q34qaXLThGFUOGPpkTcv+ANk42D9Vr6hZyT/NjFvwJKyv3EafjHwVj6aYkpoLz+wZYdogRnuxISD/Va0MkB+R7rzrK6+uY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770226443; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DSVFqdfr8j37qOZwp0CY0Wne6Kh0Jy9gc1PZyRr0iLQ=; 
	b=X2KX1leY/Pg/2EYxxV6h8u1FlOMh8cn+zYnI5RBhE+OmEmFbmlxTONU1bxE/uVg7Y9mO7bi1ksfjKDvGfMk5d+kSFI+ixeuVzJX3r7Ncrxr6BbE9+gXgYjZ2mQvsnL6iI7mJKgqkkUDHMcbTWkJma0iazp1WX5yEmgW29iiDY8s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770226443;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=DSVFqdfr8j37qOZwp0CY0Wne6Kh0Jy9gc1PZyRr0iLQ=;
	b=FCqmwI5kKYT1giL3JAYQAbnMS0gZKtB8sw25JuVc4wC4ZyzDe91AlZ7IrVW2xQNE
	TA9ymQAIuGfyy+r96Hgu43tlI05pM0EwTQKdjNqPKY7+dimL/+Glp0cqXoAqEIbkqIx
	PoJbm27BIBesqCL3BSp+ebLd2A48F7R7qe3k7fi4=
Received: by mx.zohomail.com with SMTPS id 1770226441562290.28530610549865;
	Wed, 4 Feb 2026 09:34:01 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 4/4] hook: allow runtime enabling extensions.hookStdoutToStderr
Date: Wed,  4 Feb 2026 19:33:28 +0200
Message-ID: <20260204173328.1601807-5-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
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
 hook.c                               | 10 ++++
 setup.c                              | 10 ++++
 t/t1800-hook.sh                      | 74 ++++++++++++++++++++++++++++
 5 files changed, 103 insertions(+)

diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
index de47d97f6d..0db485dd54 100644
--- a/Documentation/config/extensions.adoc
+++ b/Documentation/config/extensions.adoc
@@ -84,6 +84,9 @@ in parallel to be grouped (de-interleaved) correctly.
 +
 Defaults to disabled. When disabled, `hook.jobs` has no effect for pre-push
 hooks, which will always be run sequentially.
++
+The extension can also be enabled by setting `hook.forceStdoutToStderr`
+to `true` in the global configuration.
 
 worktreeConfig:::
 	If enabled, then worktrees will load config settings from the
diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
index 56e6b4e5c3..a6a79a1670 100644
--- a/Documentation/config/hook.adoc
+++ b/Documentation/config/hook.adoc
@@ -23,3 +23,9 @@ hook.jobs::
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
index e07e8f4efe..bae6e35943 100644
--- a/hook.c
+++ b/hook.c
@@ -264,6 +264,16 @@ static unsigned int get_hook_jobs(struct repository *r, struct run_hooks_opt *op
 {
 	unsigned int jobs = options->jobs;
 
+	/*
+	 * Allow hook.forceStdoutToStderr to enable extensions.hookStdoutToStderr
+	 * for existing repositories (runtime override).
+	 */
+	if (!options->stdout_to_stderr) {
+		int v = 0;
+		repo_config_get_bool(r, "hook.forceStdoutToStderr", &v);
+		options->stdout_to_stderr = v;
+	}
+
 	/*
 	 * Hooks which configure stdout_to_stderr=0 (like pre-push), expect separate
 	 * output streams. Unless extensions.StdoutToStderr is enabled (which forces
diff --git a/setup.c b/setup.c
index cf4949c086..037ab2e21d 100644
--- a/setup.c
+++ b/setup.c
@@ -2310,6 +2310,7 @@ void initialize_repository_version(int hash_algo,
 {
 	struct strbuf repo_version = STRBUF_INIT;
 	int target_version = GIT_REPO_VERSION;
+	int default_hook_stdout_to_stderr = 0;
 
 	/*
 	 * Note that we initialize the repository version to 1 when the ref
@@ -2348,6 +2349,15 @@ void initialize_repository_version(int hash_algo,
 		clear_repository_format(&repo_fmt);
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
index bf19579f3a..db0f96f778 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -649,4 +649,78 @@ test_expect_success 'hook.jobs=2 config runs hooks in parallel' '
 	test $duration -lt 4
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
+	test_when_finished "rm -rf repo-parallel" &&
+	git init --bare remote-parallel &&
+	git init repo-parallel &&
+	git -C repo-parallel remote add origin ../remote-parallel &&
+	test_commit -C repo-parallel A &&
+
+	write_script repo-parallel/.git/hooks/pre-push <<-EOF &&
+	sleep 2
+	echo "Hook 1" >&2
+	EOF
+	git -C repo-parallel config hook.hook-2.event pre-push &&
+	git -C repo-parallel config hook.hook-2.command "sleep 2; echo Hook 2 >&2" &&
+
+	git -C repo-parallel config hook.jobs 2 &&
+	git -C repo-parallel config hook.forceStdoutToStderr true &&
+
+	start=$(date +%s) &&
+	git -C repo-parallel push origin HEAD >out 2>err &&
+	end=$(date +%s) &&
+
+	duration=$((end - start)) &&
+	# Serial >= 4s, parallel < 4s.
+	test $duration -lt 4
+'
+
 test_done
-- 
2.52.0.732.gb351b5166d.dirty

