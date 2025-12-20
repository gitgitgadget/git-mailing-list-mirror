Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B03307AF4
	for <git@vger.kernel.org>; Sat, 20 Dec 2025 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766225783; cv=pass; b=Z6CPv4uNt+jD1mtgoSwt1388DH9HC6hgrNwT2Ro66AqH0bpBbDWipw7RxB6KU/TKNIRjx/j8N+r3gnLDmQK5u12P3fWwi5gWXMTRQSwucQWu9GZtWWj9irG1cTSSYzQPVmihY3UakG5LCobstchBSWKNHHpRMNfURMRHTJNN4+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766225783; c=relaxed/simple;
	bh=LdQQmAe/j1RPghIAFQKCftNWmQwoc+lhBMumvmXQFac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXdDa2oJsSEdhzhxiegZ9GIkDhDA3wBg0uAIs/L4PLAOTmVjn+P7Vhzr3V79TBcBvuktXOJ7Hw4EhfB2R/LjqMYFWyJptVzFjKtGmtcmY9rfjdMvT31fVoH9DBVXfGo8ctwZObqoUcAtjM66qWYl2HU/e9DMAU67opmQaHRQHps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=FdUTyw1d; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="FdUTyw1d"
ARC-Seal: i=1; a=rsa-sha256; t=1766225767; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=E2BBDv9VzSbufchweOYHdDB/nIWfU/iaAIFXUuOkN1rQkeKPXatcppYUznS78xAJ/RP0itzrCCNHeHAysLq4z0Hqtx//j671ENafH7cuLI2YYwNcRZf/RUMX8VvgpKwW2q59WUQ7XNj475UyNReYkDBc8dqP2gbVmkAENrkUUz8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766225767; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=op9Muy5p+u/fTtwSnrUyo4OD5JDSlthMxVPbin/Tv+8=; 
	b=cOgbBPnzhsQTABV6WdgCquSo9PrP6uIAPQ1qcjbCs04baoiMkMp3AQ7su06kFwbU6CLzm0+4wS7asvQuXlU7VNpha5b6MqrzLCQ0oSXBPqrTeDdJMpaTMJa2YLBc3Bv/dNnaAtLqB1BuqFyk4B9X0qGtc5BNN5QdwjSC2TYMcqE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766225767;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=op9Muy5p+u/fTtwSnrUyo4OD5JDSlthMxVPbin/Tv+8=;
	b=FdUTyw1dvdlkrRKWUTJmeoqQizUxRAivlAdEaDFNtgR1Je2SouqgVKvk0AAe3XDn
	4kO4GIK2eg+LujW4ntbhKQjs1nRma7cZ/nztGlWaLAE6mSz0Bi8DuJk8OmgPkDrDR34
	omoym79ino8tsT15geKt8SsHvglBt/TncNtI7+20=
Received: by mx.zohomail.com with SMTPS id 1766225765468280.04301246230307;
	Sat, 20 Dec 2025 02:16:05 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v7 05/11] submodule: allow runtime enabling extensions.submodulePathConfig
Date: Sat, 20 Dec 2025 12:15:22 +0200
Message-ID: <20251220101528.1227487-6-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251220101528.1227487-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251220101528.1227487-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add a new config `init.autoSetupSubmodulePathConfig` which allows
enabling `extensions.submodulePathConfig` for new submodules by
default (those created via git init or clone).

Important: setting init.autoSetupSubmodulePathConfig = true does
not globally enable `extensions.submodulePathConfig`. Existing
repositories will still have the extension disabled and will
require migration (for example via git submodule--helper command
added in the next commit).

Suggested-by: Patrick Steinhardt <ps@pks.im>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/extensions.adoc       |   4 +
 Documentation/config/init.adoc             |   6 +
 setup.c                                    |  12 +-
 t/t7425-submodule-gitdir-path-extension.sh | 125 +++++++++++++++++++++
 4 files changed, 146 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
index e15b93f2fb..0968ac3d5c 100644
--- a/Documentation/config/extensions.adoc
+++ b/Documentation/config/extensions.adoc
@@ -95,6 +95,10 @@ Git will error out if a module does not have a corresponding
 Existing (pre-extension) submodules need to be migrated by adding the missing
 config entries. This is done manually for now, e.g. for each submodule:
 `git config submodule.<name>.gitdir .git/modules/<name>`.
++
+The extension can be enabled automatically for new repositories by setting
+`init.autoSetupSubmodulePathConfig` to `true`, for example by running
+`git config --global init.autoSetupSubmodulePathConfig true`.
 
 worktreeConfig:::
 	If enabled, then worktrees will load config settings from the
diff --git a/Documentation/config/init.adoc b/Documentation/config/init.adoc
index e45b2a8121..293a2ddbdf 100644
--- a/Documentation/config/init.adoc
+++ b/Documentation/config/init.adoc
@@ -18,3 +18,9 @@ endif::[]
 	See `--ref-format=` in linkgit:git-init[1]. Both the command line
 	option and the `GIT_DEFAULT_REF_FORMAT` environment variable take
 	precedence over this config.
+
+init.autoSetupSubmodulePathConfig::
+	A boolean that specifies if `git init` and `git clone` should
+	automatically set `extensions.submodulePathConfig` to `true`. This
+	allows all new repositories to automatically use the submodule path
+	extension. Defaults to `false` when unset.
diff --git a/setup.c b/setup.c
index 428427d689..3e05fe7c58 100644
--- a/setup.c
+++ b/setup.c
@@ -2661,7 +2661,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	    const char *initial_branch,
 	    int init_shared_repository, unsigned int flags)
 {
-	int reinit;
+	int reinit, auto_setup_submodule_path_config = 0;
 	int exist_ok = flags & INIT_DB_EXIST_OK;
 	char *original_git_dir = real_pathdup(git_dir, 1);
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
@@ -2712,6 +2712,16 @@ int init_db(const char *git_dir, const char *real_git_dir,
 					  initial_branch, flags & INIT_DB_QUIET);
 	create_object_directory();
 
+	repo_config_get_bool(the_repository, "init.autoSetupSubmodulePathConfig",
+			     &auto_setup_submodule_path_config);
+	if (auto_setup_submodule_path_config) {
+		int version = 0;
+		repo_config_get_int(the_repository, "core.repositoryformatversion", &version);
+		if (version < 1)
+			repo_config_set(the_repository, "core.repositoryformatversion", "1");
+		repo_config_set(the_repository, "extensions.submodulepathconfig", "true");
+	}
+
 	if (repo_settings_get_shared_repository(the_repository)) {
 		char buf[10];
 		/* We do not spell "group" and such, so that
diff --git a/t/t7425-submodule-gitdir-path-extension.sh b/t/t7425-submodule-gitdir-path-extension.sh
index 5d52a289f8..06ee1ff86b 100755
--- a/t/t7425-submodule-gitdir-path-extension.sh
+++ b/t/t7425-submodule-gitdir-path-extension.sh
@@ -135,4 +135,129 @@ test_expect_success 'fetch mixed submodule changes and verify updates' '
 	)
 '
 
+test_expect_success '`git init` respects init.autoSetupSubmodulePathConfig' '
+	git config --global init.autoSetupSubmodulePathConfig true &&
+	git init repo-init &&
+	git -C repo-init config extensions.submodulePathConfig > actual &&
+	echo true > expect &&
+	test_cmp expect actual &&
+	# create a submodule and check gitdir
+	(
+		cd repo-init &&
+		git init -b main sub &&
+		test_commit -C sub sub-initial &&
+		git submodule add ./sub sub &&
+		git config submodule.sub.gitdir > actual &&
+		echo ".git/modules/sub" > expect &&
+		test_cmp expect actual
+	) &&
+	git config --global --unset init.autoSetupSubmodulePathConfig
+'
+
+test_expect_success '`git init` does not set extension by default' '
+	git init upstream &&
+	test_commit -C upstream initial &&
+	test_must_fail git -C upstream config extensions.submodulePathConfig &&
+	# create a pair of submodules and check gitdir is not created
+	git init -b main sub &&
+	test_commit -C sub sub-initial &&
+	(
+		cd upstream &&
+		git submodule add ../sub sub1 &&
+		test_path_is_dir .git/modules/sub1 &&
+		test_must_fail git config submodule.sub1.gitdir &&
+		git submodule add ../sub sub2 &&
+		test_path_is_dir .git/modules/sub2 &&
+		test_must_fail git config submodule.sub2.gitdir &&
+		git commit -m "Add submodules"
+	)
+'
+
+test_expect_success '`git clone` does not set extension by default' '
+	test_when_finished "rm -rf repo-clone-no-ext" &&
+	git clone upstream repo-clone-no-ext &&
+	(
+		cd repo-clone-no-ext &&
+
+		test_must_fail git config extensions.submodulePathConfig &&
+		test_path_is_missing .git/modules/sub1 &&
+		test_path_is_missing .git/modules/sub2 &&
+
+		# create a submodule and check gitdir is not created
+		git submodule add ../sub sub3 &&
+		test_must_fail git config submodule.sub3.gitdir
+	)
+'
+
+test_expect_success '`git clone --recurse-submodules` does not set extension by default' '
+	test_when_finished "rm -rf repo-clone-no-ext" &&
+	git clone --recurse-submodules upstream repo-clone-no-ext &&
+	(
+		cd repo-clone-no-ext &&
+
+		# verify that that submodules do not have gitdir set
+		test_must_fail git config extensions.submodulePathConfig &&
+		test_path_is_dir .git/modules/sub1 &&
+		test_must_fail git config submodule.sub1.gitdir &&
+		test_path_is_dir .git/modules/sub2 &&
+		test_must_fail git config submodule.sub2.gitdir &&
+
+		# create another submodule and check that gitdir is not created
+		git submodule add ../sub sub3 &&
+		test_path_is_dir .git/modules/sub3 &&
+		test_must_fail git config submodule.sub3.gitdir
+	)
+
+'
+
+test_expect_success '`git clone` respects init.autoSetupSubmodulePathConfig' '
+	test_when_finished "rm -rf repo-clone" &&
+	git config --global init.autoSetupSubmodulePathConfig true &&
+	git clone upstream repo-clone &&
+	(
+		cd repo-clone &&
+
+		# verify new repo extension is inherited from global config
+		git config extensions.submodulePathConfig > actual &&
+		echo true > expect &&
+		test_cmp expect actual &&
+
+		# new submodule has a gitdir config
+		git submodule add ../sub sub &&
+		test_path_is_dir .git/modules/sub &&
+		git config submodule.sub.gitdir > actual &&
+		echo ".git/modules/sub" > expect &&
+		test_cmp expect actual
+	) &&
+	git config --global --unset init.autoSetupSubmodulePathConfig
+'
+
+test_expect_success '`git clone --recurse-submodules` respects init.autoSetupSubmodulePathConfig' '
+	test_when_finished "rm -rf repo-clone-recursive" &&
+	git config --global init.autoSetupSubmodulePathConfig true &&
+	git clone  --recurse-submodules upstream repo-clone-recursive &&
+	(
+		cd repo-clone-recursive &&
+
+		# verify new repo extension is inherited from global config
+		git config extensions.submodulePathConfig > actual &&
+		echo true > expect &&
+		test_cmp expect actual &&
+
+		# previous submodules should exist
+		git config submodule.sub1.gitdir &&
+		git config submodule.sub2.gitdir &&
+		test_path_is_dir .git/modules/sub1 &&
+		test_path_is_dir .git/modules/sub2 &&
+
+		# create another submodule and check that gitdir is created
+		git submodule add ../sub new-sub &&
+		test_path_is_dir .git/modules/new-sub &&
+		git config submodule.new-sub.gitdir > actual &&
+		echo ".git/modules/new-sub" > expect &&
+		test_cmp expect actual
+	) &&
+	git config --global --unset init.autoSetupSubmodulePathConfig
+'
+
 test_done
-- 
2.51.2

