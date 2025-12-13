Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910DF28C00C
	for <git@vger.kernel.org>; Sat, 13 Dec 2025 08:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765613366; cv=pass; b=FF+iZmFHybRlT9IgNnbjJXFm9bGX39MC+uAP+XWf5WhoOEPekqV0V7qv8mt3/tYRvve3/gig9WGPE/M2LDZHh4w3DEfqVr8cfKTCLoBDyAkGgmjCddrf7/edLfgTzQB4bEkKG9JN4ebzKWD6jXIfPKZLuXGZqvQ3xOKqwyeJjkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765613366; c=relaxed/simple;
	bh=Qfx1Rnm7GpplwUy5m4ziyegudzIAkfjwUgGHu147xyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQ770nSx4Oz6eVAkI54q68dvDZqy0zUELvZjQmLsfAq/mbYPwuPkU0WFlIQYwwFVkLWWkBHHPMFM9ylXEz3jxZnsFVHRZnIQzQv5nrv8FRrYJdWiD5UxiE44/l7xs+Y8BBgiYt16ou1zpBiCysEwkRrtLCOfRkQ+rDeQ3YLESRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=gZ5K+UHM; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="gZ5K+UHM"
ARC-Seal: i=1; a=rsa-sha256; t=1765613349; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WcvH1OZVAiR9PXbUioR+YD/iqIL2s7k9+DH4edpT3YZ2UhIXR1pdwoBdLEixhtErbn+VE4HgZDYXjdgoqisJH72UqwxCIkUZCBb1Amy2uIvSNdjvIH2xLoOcUrZhM3S8sOyhnloQ+3M9BH3E9YAmfST8spwe60+v/hBLWlgf/f0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765613349; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pEE5RS7psOhkVoF10TFoiPE8vL1kbNtoCVtDnU32xWw=; 
	b=RFkSANeov1pOoHUbKEhLHcRRw/gF4sLqM0lG6EqxpnPtju5Wv4wprTtpvz9n5lPaU4bdT5atpu+bQ8oUb+TCpBL5aU7lP9OaF0Yj631ghm3MsjzxZAoWHqQxOZY40gjU2Y0z7rQYKLKFFcDg78CH7Efz3BUhyMmZRn6LpehywXw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765613349;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=pEE5RS7psOhkVoF10TFoiPE8vL1kbNtoCVtDnU32xWw=;
	b=gZ5K+UHML8MI5uUBqbpiiM6+PHT/gCAUIPUw8b0xY2F9NFctSZivu+ZADSszSIUL
	pOZRWb0aXDxUn/8QjHBgl3300gxYn5/DjsMFuv83gGAaFIr7nr+IHMl5DfIBqffo/K/
	zPedNcW7c7v+dncTqAaxXB8yIJ9YGhSZ2uPXgkNE=
Received: by mx.zohomail.com with SMTPS id 176561334716738.02110745731807;
	Sat, 13 Dec 2025 00:09:07 -0800 (PST)
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
Subject: [PATCH v6 05/10] submodule: allow runtime enabling extensions.submodulePathConfig
Date: Sat, 13 Dec 2025 10:08:11 +0200
Message-ID: <20251213080817.347922-6-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251213080817.347922-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251213080817.347922-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This adds the ability to enable the new extension via a runtime
config to avoid having to enable it in each repo configuration.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/extensions.adoc       |  2 +
 builtin/submodule--helper.c                |  8 +++-
 submodule.c                                |  4 +-
 submodule.h                                |  2 +
 t/t7425-submodule-gitdir-path-extension.sh | 46 ++++++++++++++++++++++
 5 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
index 6ce1dcc98b..929e4e1bf1 100644
--- a/Documentation/config/extensions.adoc
+++ b/Documentation/config/extensions.adoc
@@ -77,6 +77,8 @@ submodulePathConfig:::
 	If enabled, the submodule.<name>.gitdir config is the single source of
 	truth for submodule gitdir paths and is always set for new submodules.
 	Git will error if a module does not have submodule.<name>.gitdir set.
+	This extension can also be enabled as a global runtime config, with
+	the local repository config having precedence (overwrites it).
 	Existing pre-extension submodules need to be migrated by adding the
 	missing config entries. This is done manually for now, e.g. for each
 	submodule: "git config submodule.<name>.gitdir .git/modules/<name>".
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 699ac32004..2b5b4f575b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -466,7 +466,8 @@ static void create_default_gitdir_config(const char *submodule_name)
 	struct strbuf gitdir_path = STRBUF_INIT;
 
 	/* The config is set only when extensions.submodulePathConfig is enabled */
-	if (!the_repository->repository_format_submodule_path_cfg)
+	if (!the_repository->repository_format_submodule_path_cfg &&
+	    !submodule_path_config_enabled)
 		return;
 
 	repo_git_path_append(the_repository, &gitdir_path, "modules/%s", submodule_name);
@@ -3483,7 +3484,7 @@ static void die_on_repo_without_commits(const char *path)
 static int module_add(int argc, const char **argv, const char *prefix,
 		      struct repository *repo UNUSED)
 {
-	int force = 0, quiet = 0, progress = 0, dissociate = 0;
+	int force = 0, quiet = 0, progress = 0, dissociate = 0, path_cfg_ext = 0;
 	struct add_data add_data = ADD_DATA_INIT;
 	const char *ref_storage_format = NULL;
 	char *to_free = NULL;
@@ -3517,6 +3518,9 @@ static int module_add(int argc, const char **argv, const char *prefix,
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
+	if (!repo_config_get_bool(the_repository, "extensions.submodulepathconfig", &path_cfg_ext))
+		submodule_path_config_enabled = path_cfg_ext;
+
 	if (!is_writing_gitmodules_ok())
 		die(_("please make sure that the .gitmodules file is in the working tree"));
 
diff --git a/submodule.c b/submodule.c
index 85ca7ea0fb..5752909999 100644
--- a/submodule.c
+++ b/submodule.c
@@ -32,6 +32,8 @@
 #include "read-cache-ll.h"
 #include "setup.h"
 
+int submodule_path_config_enabled;
+
 static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
 static int initialized_fetch_ref_tips;
 static struct oid_array ref_tips_before_fetch;
@@ -2575,7 +2577,7 @@ void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
 	int ret;
 
 	/* If extensions.submodulePathConfig is disabled, continue to use the plain path */
-	if (!r->repository_format_submodule_path_cfg) {
+	if (!r->repository_format_submodule_path_cfg && !submodule_path_config_enabled) {
 		repo_git_path_append(r, buf, "modules/%s", submodule_name);
 		if (validate_submodule_git_dir(buf->buf, submodule_name) < 0)
 			die(_("refusing to create/use '%s' in another submodule's "
diff --git a/submodule.h b/submodule.h
index b10e16e6c0..c15630bf26 100644
--- a/submodule.h
+++ b/submodule.h
@@ -172,4 +172,6 @@ void absorb_git_dir_into_superproject(const char *path,
  */
 int get_superproject_working_tree(struct strbuf *buf);
 
+extern int submodule_path_config_enabled;
+
 #endif
diff --git a/t/t7425-submodule-gitdir-path-extension.sh b/t/t7425-submodule-gitdir-path-extension.sh
index 5d52a289f8..2f198bff82 100755
--- a/t/t7425-submodule-gitdir-path-extension.sh
+++ b/t/t7425-submodule-gitdir-path-extension.sh
@@ -135,4 +135,50 @@ test_expect_success 'fetch mixed submodule changes and verify updates' '
 	)
 '
 
+test_expect_success 'runtime config extensions.submodulePathConfig on new repo' '
+	git config --global extensions.submodulePathConfig true &&
+	git init -b main runtime-test-new-repo &&
+	(
+		cd runtime-test-new-repo &&
+
+		git init -b main sub &&
+		test_commit -C sub sub-initial &&
+
+		git submodule add ./sub sub &&
+
+		# Verify that the gitdir config was created correctly
+		git config submodule.sub.gitdir > actual &&
+		echo ".git/modules/sub" > expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'runtime config extensions.submodulePathConfig on existing repo' '
+	# create a repo with the extension disabled then enable it
+	git config --global extensions.submodulePathConfig false &&
+	git init -b main runtime-test-existing-repo &&
+	(
+		cd runtime-test-existing-repo &&
+
+		git init -b main sub &&
+		test_commit -C sub sub-initial &&
+
+		git submodule add ./sub sub &&
+
+		# gitdir should not exist for this repo: it must be migrated
+		test_must_fail git config submodule.sub.gitdir
+	) &&
+	git config --global extensions.submodulePathConfig true &&
+	(
+		cd runtime-test-existing-repo &&
+
+		git submodule add ./sub sub2 &&
+
+		# gitdir should exist after enabling the global config
+		git config submodule.sub2.gitdir > actual &&
+		echo ".git/modules/sub2" > expect &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.51.2

