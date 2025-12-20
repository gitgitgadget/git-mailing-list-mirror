Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528BC3090C5
	for <git@vger.kernel.org>; Sat, 20 Dec 2025 10:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766225787; cv=pass; b=g9BgvbjnO00awb40FGGjInjwzn6eV3D7hBBDiCzyk8Hm1D7ZcTa7V7oZd5tnSzk/ZpyVV8b5j5N9bM8reKfJXX1wCaLp8Jno6uwUEmdH/NfNwV3LMJy0ABDT60/QVmkiIS6y+vSZfoINVK9+laWDph6/W9JHOioKCEWcq4snFsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766225787; c=relaxed/simple;
	bh=PzBHP82FBmoMQeqqwqFZYrUwRtRwXHziSaja0SeOtig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eueG92vKt31wMbNqfI50nVfFhL8UuXf8YsoVklpuCzuypCycBmOROINBZf3pJDX/ZYtjC5EUYD6kDm3/wWben4Rv6jgKzS8qHPE6LqgGFnlVQTxLl0LkDcoB98OFTPvMGlx8joczd/l76uSwPos8gKNIz1oDs9myuuMXErJG75E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=G0P48Thf; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="G0P48Thf"
ARC-Seal: i=1; a=rsa-sha256; t=1766225771; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UeO4yQSxColSpCiJBUIoCwhcZLK1i1UWCZK7joB8HU9FbMAeRDBSKlKDH0GssdvsPmqxH/wCAvoeqPwpvda+7+gIXvw1C3lQESiGjepocLfSHU7HGleVdb92680jM9CmKYqXoe38BB6j6E60z27cR+71jkPaYhpMcbNgLK9s268=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766225771; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aqAiDouFuqImwD9tj7DD7jHjrGHRBYOxCZBz2HmdRBw=; 
	b=ebOpYUU+ATlVH8T6U6g+d/eZYq52hd5ubfZNp6b8ztPyUhv0TjATPr53xiibYU8Zopq/ACjFGZ3pwuoXe6ngWXu/nGoek0VNuVO1S5SMW5p58usNdsixKyjlEqHGpBlsdi2Qhdg5HwBlSeceew3VzdfGyZyt69fo+ITc/5Tqg00=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766225771;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=aqAiDouFuqImwD9tj7DD7jHjrGHRBYOxCZBz2HmdRBw=;
	b=G0P48ThfSOyf9u0jZDFxBEEecbPB825AwrhmTPeNOfZ0AdL6LxNdSHvwk1zbcCgd
	C4sP8ZOL5URdqm9YhIn69j93zQaawN10X+3EOMo3/GSxAZRJ8KZpfSCDWbxtOxBogE5
	8wP2Jj3wbe7v4WL1K+gDppjVlOgO02H53MB1TsUU=
Received: by mx.zohomail.com with SMTPS id 176622576984810.85388288829995;
	Sat, 20 Dec 2025 02:16:09 -0800 (PST)
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
Subject: [PATCH v7 06/11] submodule--helper: add gitdir migration command
Date: Sat, 20 Dec 2025 12:15:23 +0200
Message-ID: <20251220101528.1227487-7-adrian.ratiu@collabora.com>
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
 builtin/submodule--helper.c                | 58 +++++++++++++++++++
 t/t7425-submodule-gitdir-path-extension.sh | 67 ++++++++++++++++++++++
 3 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
index 0968ac3d5c..62dc112874 100644
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
 `init.autoSetupSubmodulePathConfig` to `true`, for example by running
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f8cae345a5..5a6436f18f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1266,6 +1266,63 @@ static int module_gitdir(int argc, const char **argv, const char *prefix UNUSED,
 	return 0;
 }
 
+static int module_migrate(int argc UNUSED, const char **argv UNUSED,
+			  const char *prefix UNUSED, struct repository *repo)
+{
+	struct strbuf module_dir = STRBUF_INIT;
+	DIR *dir;
+	struct dirent *de;
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
+	if (repo_config_set_gently(repo, "core.repositoryformatversion", "1"))
+		die(_("could not set core.repositoryformatversion to 1. "
+		      "Please enable it for migration to work, for example: "
+		      "git config core.repositoryformatversion 1"));
+
+	if (repo_config_set_gently(repo, "extensions.submodulePathConfig", "true"))
+		die(_("could not enable submodulePathConfig extension. It is required "
+		      "for migration to work. Please enable it in the root repo: "
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
@@ -3649,6 +3706,7 @@ int cmd_submodule__helper(int argc,
 		NULL
 	};
 	struct option options[] = {
+		OPT_SUBCOMMAND("migrate-gitdir-configs", &fn, module_migrate),
 		OPT_SUBCOMMAND("gitdir", &fn, module_gitdir),
 		OPT_SUBCOMMAND("clone", &fn, module_clone),
 		OPT_SUBCOMMAND("add", &fn, module_add),
diff --git a/t/t7425-submodule-gitdir-path-extension.sh b/t/t7425-submodule-gitdir-path-extension.sh
index 06ee1ff86b..6ca9f13a59 100755
--- a/t/t7425-submodule-gitdir-path-extension.sh
+++ b/t/t7425-submodule-gitdir-path-extension.sh
@@ -260,4 +260,71 @@ test_expect_success '`git clone --recurse-submodules` respects init.autoSetupSub
 	git config --global --unset init.autoSetupSubmodulePathConfig
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
+		git config extensions.submodulePathConfig > actual &&
+		echo "true" > expect &&
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
+		# init.autoSetupSubmodulePathConfig was disabled before clone, so
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
+	git config --global init.autoSetupSubmodulePathConfig true &&
+	git clone --recurse-submodules upstream repo-clone-recursive &&
+	(
+		cd repo-clone-recursive &&
+
+		# repository extension is enabled
+		git config extensions.submodulePathConfig > actual &&
+		echo "true" > expect &&
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
2.51.2

