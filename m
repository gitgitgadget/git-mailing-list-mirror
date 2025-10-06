Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009E021576E
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 11:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759749969; cv=pass; b=YrxL0b0SJQWbS+6JLfg04tL89tclvwK3DysM1kIY8l3TBZOnSAqZ6qBUNRCJRbYzYrXM2H9tAGTqcjD2NOrlHOV5ttE1OS+ysSuxWmmbKcBcG7I5Yqf2qjtevbzqF/FizNnvZTMf3kdHMeKNcl817pM8SPVSDZT2qV6OxAYfmhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759749969; c=relaxed/simple;
	bh=ZI3uH21+sts0BwP+u4e8HojHwGK7zHw3dO4KgrL5chk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1CD/4H/Tv/KoCEPL4HjL/eblLWRY7X53Yoiy4kLsozkuzyG3vO1hTbWn54dAi2g2mZHDb+BB+G1FVhotZcQxv6CcJ+Ww/E7EoaO7aXrTOc47e6B9frRAAhJdwBfzppCWBn3t5zhQExfyKCjxVW19zXU68vJ/NyC+4bobfmZB6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=kaJzrWc2; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="kaJzrWc2"
ARC-Seal: i=1; a=rsa-sha256; t=1759749952; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YxGqykosnZlcUNWToua5AXFm5HLcIV6dA2I7+vQsigC/TRw5xMjiGEcCRHxhezlludT+bs9ebyYZv+mKprFunnMbnjmd6sUbjwcD1hb3pIFiX8OOg9v3CdKyZbW7VPVbuHuptVk9+6PikDaKQtvrQezEGh9ORzxi7vu2R3P/+ig=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759749952; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Sjd+26LSv4yJUIlDroCeVEJ7BHzJC6CRw/BIRSQV0Do=; 
	b=Oxd0q4/MnhtwpCgMqKQKW+SWrPbJr6I9pOIr80D1381koN4KKlEA8NyLrBgI0R+wbAjxqJtaFMhtDOgMIFP6gtj2DZsNfWQv1FFAgh/7xnYwteDsjwyZ6/M5kD7ZcUwjZnqqo4rlGwAfNRuNGvMYulD9dcidPGsAiDni01ZGvvQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759749952;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Sjd+26LSv4yJUIlDroCeVEJ7BHzJC6CRw/BIRSQV0Do=;
	b=kaJzrWc2ShKW/3vRBbT56Xn4JXEfCadlTKl6yZRAnqNwdm9BIOIejwlUVegthBuq
	ivEj928oop+3YFgy0x53jCxEuW5KUU9jeX4zMzOpKji5nyJ8k94fpSffgujBB5Ikvb4
	arEeiQ5U5OtLG8EPHdTLKNqkOzhIslnzXvRlTS2A=
Received: by mx.zohomail.com with SMTPS id 1759749949295819.1646806214911;
	Mon, 6 Oct 2025 04:25:49 -0700 (PDT)
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
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 2/5] submodule: add gitdir path config override
Date: Mon,  6 Oct 2025 14:25:15 +0300
Message-ID: <20251006112518.3764240-3-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251006112518.3764240-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This adds the ability to override gitdir paths via config files
(not .gitmodules) such that the encoding scheme (or plain text
name if the encoding extension is disabled) can be changed via
config entries.

These entries are not added by default for all submodules: they
should be used on an as-needed basis.

A new test and a helper are added. The helper will also be used
in further tests exercising gitdir encoding functionality.

Based-on-patch-by: Brandon Williams <bmwill@google.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/submodule.adoc   |  4 ++++
 builtin/submodule--helper.c           | 17 +++++++++++++++++
 submodule.c                           | 12 ++++++++++++
 t/lib-verify-submodule-gitdir-path.sh | 20 ++++++++++++++++++++
 t/t7400-submodule-basic.sh            |  9 +++++++++
 t/t9902-completion.sh                 |  1 +
 6 files changed, 63 insertions(+)
 create mode 100644 t/lib-verify-submodule-gitdir-path.sh

diff --git a/Documentation/config/submodule.adoc b/Documentation/config/submodule.adoc
index 0672d99117..8f64adfbe3 100644
--- a/Documentation/config/submodule.adoc
+++ b/Documentation/config/submodule.adoc
@@ -52,6 +52,10 @@ submodule.<name>.active::
 	submodule.active config option. See linkgit:gitsubmodules[7] for
 	details.
 
+submodule.<name>.gitdir::
+	This option sets the gitdir path for submodule <name>, allowing users
+	to override the default path or change the default path name encoding.
+
 submodule.active::
 	A repeated field which contains a pathspec used to match against a
 	submodule's path to determine if the submodule is of interest to git
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2873b2780e..abd20eee53 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1208,6 +1208,22 @@ static int module_summary(int argc, const char **argv, const char *prefix,
 	return ret;
 }
 
+static int module_gitdir(int argc, const char **argv, const char *prefix UNUSED,
+			 struct repository *repo)
+{
+	struct strbuf gitdir = STRBUF_INIT;
+
+	if (argc != 2)
+		usage(_("git submodule--helper gitdir <name>"));
+
+	submodule_name_to_gitdir(&gitdir, repo, argv[1]);
+
+	printf("%s\n", gitdir.buf);
+
+	strbuf_release(&gitdir);
+	return 0;
+}
+
 struct sync_cb {
 	const char *prefix;
 	const char *super_prefix;
@@ -3591,6 +3607,7 @@ int cmd_submodule__helper(int argc,
 		NULL
 	};
 	struct option options[] = {
+		OPT_SUBCOMMAND("gitdir", &fn, module_gitdir),
 		OPT_SUBCOMMAND("clone", &fn, module_clone),
 		OPT_SUBCOMMAND("add", &fn, module_add),
 		OPT_SUBCOMMAND("update", &fn, module_update),
diff --git a/submodule.c b/submodule.c
index 35c55155f7..7a2d7cd592 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2604,6 +2604,18 @@ void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
 	 * administrators can explicitly set. Nothing has been decided,
 	 * so for now, just append the name at the end of the path.
 	 */
+	char *gitdir_path, *key;
+
+	/* Allow config override. */
+	key = xstrfmt("submodule.%s.gitdirpath", submodule_name);
+	if (!repo_config_get_string(r, key, &gitdir_path)) {
+		strbuf_addstr(buf, gitdir_path);
+		free(key);
+		free(gitdir_path);
+		return;
+	}
+	free(key);
+
 	repo_git_path_append(r, buf, "modules/");
 	strbuf_addstr(buf, submodule_name);
 }
diff --git a/t/lib-verify-submodule-gitdir-path.sh b/t/lib-verify-submodule-gitdir-path.sh
new file mode 100644
index 0000000000..3a83f2d975
--- /dev/null
+++ b/t/lib-verify-submodule-gitdir-path.sh
@@ -0,0 +1,20 @@
+# Helper to verify if repo $1 contains a submodule named $2 with gitdir path $3
+
+# This does not check filesystem existence. That is done in submodule.c via the
+# submodule_name_to_gitdir() API which this helper ends up calling. The gitdirs
+# might or might not exist (e.g. when adding a new submodule), so this only
+# checks the expected configuration path, which might be overridden by the user.
+
+verify_submodule_gitdir_path() {
+	repo="$1" &&
+	name="$2" &&
+	path="$3" &&
+	(
+		cd "$repo" &&
+		cat >expect <<-EOF &&
+			$(git rev-parse --git-common-dir)/$path
+		EOF
+		git submodule--helper gitdir "$name" >actual &&
+		test_cmp expect actual
+	)
+}
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index fd3e7e355e..11c84a7bdf 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -13,6 +13,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-verify-submodule-gitdir-path.sh
 
 test_expect_success 'setup - enable local submodules' '
 	git config --global protocol.file.allow always
@@ -1505,4 +1506,12 @@ test_expect_success 'submodule add fails when name is reused' '
 	)
 '
 
+test_expect_success 'submodule helper gitdir config overrides' '
+	verify_submodule_gitdir_path test-submodule child modules/child &&
+	test_config -C test-submodule submodule.child.gitdirpath ".git/modules/custom-child" &&
+	verify_submodule_gitdir_path test-submodule child modules/custom-child &&
+	test_unconfig -C test-submodule submodule.child.gitdirpath &&
+	verify_submodule_gitdir_path test-submodule child modules/child
+'
+
 test_done
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 964e1f1569..ffb9c8b522 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -3053,6 +3053,7 @@ test_expect_success 'git config set - variable name - __git_compute_second_level
 	submodule.sub.fetchRecurseSubmodules Z
 	submodule.sub.ignore Z
 	submodule.sub.active Z
+	submodule.sub.gitdir Z
 	EOF
 '
 
-- 
2.49.1

