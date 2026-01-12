Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C9A322B60
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 18:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768244084; cv=pass; b=RshC8HNdIFTE1M4FB7RReC6bMQ4+WUY8iX/6rb063FrIqT5pwJyDrySN0tnhKKC5F3FZyot8Hl2IjRvJzkWA2pi7z/M8tLPPyo+OKy/U1UgXr0ovKiq+bcF6E6/BgvHwqxDQMbni7yz1kaMmUB86kEMf/lz8EGaujeTwYdM6KFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768244084; c=relaxed/simple;
	bh=VXmlndiiceImBZLYNnWxWiOfVqVVQeYjf8MklZUqzt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAhtrRVn3eIt28cQrlQOVUNDhIV+9kNRwtO/ArzDA8GyM4lS9oHpRePh09lGHF3G7XpKmodoVoQGpeqCaQp07fTfRxX4PKzKhyblj3XH2yWV/WB/n7XbaOPwz8vbU/vrn21MJ5ZvpAb8rnhe3VNSM5qsdhEHC8GsmF3SmL9CkeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=F5121Vlh; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="F5121Vlh"
ARC-Seal: i=1; a=rsa-sha256; t=1768244068; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PeM7RwU8TpggTMWA5wI0L2BkMd7VJmrtt11VsMWIYHH2cwqFm+InQezAkN18TCBWuY7WX6Pd75KiavvqC1W7tTKnltcUiBRyrSrSoQXOhJg9qbEA4vgHcEYHsBD/jnUxk71l2i4auSUpkD+v0CG7puSpRi9eWX07emp1g2b00/Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768244068; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aH5YhLyHiojCMJOl8cb1jwrvq1lxlCkXAPhWEnlnu40=; 
	b=mbDcoCprIio29qvMOiIdPNqNjkUCCzenusKeypiWEISe9eiqTpW/6N94cQBbdpAfRr8S5pGHIEjVPECIfu4mTKSF3hUBtY42efuP7XVcJmgi5IsnHmArIpVlKy8Y1QskmM+mR5CDf2IAlO0udYOC8VRyzqx1mfMeHOy6tobRl4M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768244068;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=aH5YhLyHiojCMJOl8cb1jwrvq1lxlCkXAPhWEnlnu40=;
	b=F5121VlhKUI7SIZ9PZBs4p7STLGrGFx2eYRWw2Vw43543aURhlcHWo3qL42TkSDm
	B9vbU1VFwED7Ws66wY75UGgbmTNwmhniy1pT1QjTbhNPI5RW9N6vDpZDtkdr9VYgZJW
	ovhWdfMENnybcNjlV8tnQqhLjUMyq+lEmoc5GXOI=
Received: by mx.zohomail.com with SMTPS id 1768244065648524.7027867793196;
	Mon, 12 Jan 2026 10:54:25 -0800 (PST)
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
Subject: [PATCH v9 06/11] submodule--helper: add gitdir migration command
Date: Mon, 12 Jan 2026 20:46:27 +0200
Message-ID: <20260112184632.1334495-7-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112184632.1334495-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20260112184632.1334495-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Manually running
"git config submodule.<name>.gitdir .git/modules/<name>"
for each submodule can be impractical, so add a migration command to
submodule--helper to automatically create configs for all submodules
as required by extensions.submodulePathConfig.

The command calls create_default_gitdir_config() which validates the
gitdir paths before adding the configs.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/extensions.adoc       |  6 +-
 builtin/submodule--helper.c                | 61 ++++++++++++++++++++
 t/t7425-submodule-gitdir-path-extension.sh | 67 ++++++++++++++++++++++
 3 files changed, 132 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
index e8d9d9a19a..2aef3315b1 100644
--- a/Documentation/config/extensions.adoc
+++ b/Documentation/config/extensions.adoc
@@ -93,8 +93,10 @@ Git will error out if a module does not have a corresponding
 `submodule.<name>.gitdir` set.
 +
 Existing (pre-extension) submodules need to be migrated by adding the missing
-config entries. This is done manually for now, e.g. for each submodule:
-`git config submodule.<name>.gitdir .git/modules/<name>`.
+config entries. This can be done manually, e.g. for each submodule:
+`git config submodule.<name>.gitdir .git/modules/<name>`, or via the
+`git submodule--helper migrate-gitdir-configs` command which iterates over all
+submodules and attempts to migrate them.
 +
 The extension can be enabled automatically for new repositories by setting
 `init.defaultSubmodulePathConfig` to `true`, for example by running
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b3d6f9ff68..498c0ca770 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1266,6 +1266,66 @@ static int module_gitdir(int argc, const char **argv, const char *prefix UNUSED,
 	return 0;
 }
 
+static int module_migrate(int argc UNUSED, const char **argv UNUSED,
+			  const char *prefix UNUSED, struct repository *repo)
+{
+	struct strbuf module_dir = STRBUF_INIT;
+	DIR *dir;
+	struct dirent *de;
+	int repo_version = 0;
+
+	repo_git_path_append(repo, &module_dir, "modules/");
+
+	dir = opendir(module_dir.buf);
+	if (!dir)
+		die(_("could not open '%s'"), module_dir.buf);
+
+	while ((de = readdir(dir))) {
+		struct strbuf gitdir_path = STRBUF_INIT;
+		char *key;
+		const char *value;
+
+		if (is_dot_or_dotdot(de->d_name))
+			continue;
+
+		strbuf_addf(&gitdir_path, "%s/%s", module_dir.buf, de->d_name);
+		if (!is_git_directory(gitdir_path.buf)) {
+			strbuf_release(&gitdir_path);
+			continue;
+		}
+		strbuf_release(&gitdir_path);
+
+		key = xstrfmt("submodule.%s.gitdir", de->d_name);
+		if (!repo_config_get_string_tmp(repo, key, &value)) {
+			/* Already has a gitdir config, nothing to do. */
+			free(key);
+			continue;
+		}
+		free(key);
+
+		create_default_gitdir_config(de->d_name);
+	}
+
+	closedir(dir);
+	strbuf_release(&module_dir);
+
+	repo_config_get_int(the_repository, "core.repositoryformatversion", &repo_version);
+	if (repo_version == 0 &&
+	    repo_config_set_gently(repo, "core.repositoryformatversion", "1"))
+		die(_("could not set core.repositoryformatversion to 1.\n"
+		      "Please set it for migration to work, for example:\n"
+		      "git config core.repositoryformatversion 1"));
+
+	if (repo_config_set_gently(repo, "extensions.submodulePathConfig", "true"))
+		die(_("could not enable submodulePathConfig extension. It is required\n"
+		      "for migration to work. Please enable it in the root repo:\n"
+		      "git config extensions.submodulePathConfig true"));
+
+	repo->repository_format_submodule_path_cfg = 1;
+
+	return 0;
+}
+
 struct sync_cb {
 	const char *prefix;
 	const char *super_prefix;
@@ -3657,6 +3717,7 @@ int cmd_submodule__helper(int argc,
 		NULL
 	};
 	struct option options[] = {
+		OPT_SUBCOMMAND("migrate-gitdir-configs", &fn, module_migrate),
 		OPT_SUBCOMMAND("gitdir", &fn, module_gitdir),
 		OPT_SUBCOMMAND("clone", &fn, module_clone),
 		OPT_SUBCOMMAND("add", &fn, module_add),
diff --git a/t/t7425-submodule-gitdir-path-extension.sh b/t/t7425-submodule-gitdir-path-extension.sh
index 03ac165de9..89e2feab8b 100755
--- a/t/t7425-submodule-gitdir-path-extension.sh
+++ b/t/t7425-submodule-gitdir-path-extension.sh
@@ -279,4 +279,71 @@ test_expect_success '`git clone --recurse-submodules` respects init.defaultSubmo
 	)
 '
 
+test_expect_success 'submodule--helper migrates legacy modules' '
+	(
+		cd upstream &&
+
+		# previous submodules exist and were not migrated yet
+		test_must_fail git config submodule.sub1.gitdir &&
+		test_must_fail git config submodule.sub2.gitdir &&
+		test_path_is_dir .git/modules/sub1 &&
+		test_path_is_dir .git/modules/sub2 &&
+
+		# run migration
+		git submodule--helper migrate-gitdir-configs &&
+
+		# test that migration worked
+		git config submodule.sub1.gitdir >actual &&
+		echo ".git/modules/sub1" >expect &&
+		test_cmp expect actual &&
+		git config submodule.sub2.gitdir >actual &&
+		echo ".git/modules/sub2" >expect &&
+		test_cmp expect actual &&
+
+		# repository extension is enabled after migration
+		git config extensions.submodulePathConfig >actual &&
+		echo "true" >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '`git clone --recurse-submodules` works after migration' '
+	test_when_finished "rm -rf repo-clone-recursive" &&
+
+	# test with extension disabled after the upstream repo was migrated
+	git clone --recurse-submodules upstream repo-clone-recursive &&
+	(
+		cd repo-clone-recursive &&
+
+		# init.defaultSubmodulePathConfig was disabled before clone, so
+		# the repo extension config should also be off, the migration ignored
+		test_must_fail git config extensions.submodulePathConfig &&
+
+		# modules should look like there was no migration done
+		test_must_fail git config submodule.sub1.gitdir &&
+		test_must_fail git config submodule.sub2.gitdir &&
+		test_path_is_dir .git/modules/sub1 &&
+		test_path_is_dir .git/modules/sub2
+	) &&
+	rm -rf repo-clone-recursive &&
+
+	# enable the extension, then retry the clone
+	test_config_global init.defaultSubmodulePathConfig true &&
+	git clone --recurse-submodules upstream repo-clone-recursive &&
+	(
+		cd repo-clone-recursive &&
+
+		# repository extension is enabled
+		git config extensions.submodulePathConfig >actual &&
+		echo "true" >expect &&
+		test_cmp expect actual &&
+
+		# gitdir configs exist for submodules
+		git config submodule.sub1.gitdir &&
+		git config submodule.sub2.gitdir &&
+		test_path_is_dir .git/modules/sub1 &&
+		test_path_is_dir .git/modules/sub2
+	)
+'
+
 test_done
-- 
2.52.0

