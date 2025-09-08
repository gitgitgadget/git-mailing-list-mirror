Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E1630BF59
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340157; cv=pass; b=eTR0vRCgoOQwZFgpJ2dzFKXgzkdwaKV39zbUh8eOajLmw+TTMXpiek48cjSyxaP6c7cEpTwdCpYHDb02+oVolP6tj3/dcT+J02aqoszBd2BaatCgz6TfcQnDbHQfdhaQscMziu4KabNBojCmb33THCM40+LYbFSmfTsvSup1tIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340157; c=relaxed/simple;
	bh=5Q9hh1KYKa9wyDg779L+IMlqW3EUymeB2kcwLkf6wcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KToc/mbg+/XMzBQOyxsPMyUaVF/F8ieau0RUZr5HZ+e6vYEvLpSJE5SN+iE5CF7bYxZhyDI7ag46hVnlM3iWPlwImhQ9UBphBT5bq/gRir4ktyebHVX3AtFuZg9BD98l7LsIpDvZnc1I8lB6VxpLLczAceWl78xz+hXCFmmx1FM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=goM8OPrB; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="goM8OPrB"
ARC-Seal: i=1; a=rsa-sha256; t=1757340133; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MbIhbD0/VCu3aa29ZUnXt8uLzDHHwWjyqZ9UQJ3iGfZ1SlfDVseu03mttDundUlBpucmWNG0moTp+C31mWMoW8GHzuT9e0v7AdSxg7ZGCQrsDDvtq6Hpj7C7Ekb+wKc6SCaCR0LWaoLfxb47I847ZCV6tv4U8+hV00CKAbIhFAg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757340133; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vibf0qBsQINVC+UsPFzOKKA60u7Ska9VjgV/bUCLDCw=; 
	b=MgDoMzsAmaLa05RXXX7wBTLZz4NW0eNLcZzQM/Lk80Y1N9aUutRkxA5uXYlyFQb5LnuxuJudAnrgkSI1BfhP9TuEYLKIzCjD231j0eGgXaa7wclQOc005UYO1YKZYFzC+NoiCwaiBXSxrm30f7Ygskn0dmFymjYx5REsj3fA/Ng=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757340133;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=vibf0qBsQINVC+UsPFzOKKA60u7Ska9VjgV/bUCLDCw=;
	b=goM8OPrB+kgzPhxzmU70xJgFbQnlldejFTohACU77OIfqByPG94KWmpgw/FvpZVD
	uuX+BPhBn+RMx3a/f6flN0qRYUzwkTrcQE9DUmlTlB07TG6Q0HvNOK6w/CGpU6Mq3jh
	+aJmfNWA2+OcAQW+CppR13uI7eV+S728cHF5BZ4I=
Received: by mx.zohomail.com with SMTPS id 1757340126434797.5631945887542;
	Mon, 8 Sep 2025 07:02:06 -0700 (PDT)
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
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 03/10] submodule: add gitdir path config override
Date: Mon,  8 Sep 2025 17:01:10 +0300
Message-ID: <20250908140117.262205-4-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.GIT
In-Reply-To: <20250908140117.262205-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This adds an ability to override gitdir paths via config files
(not .gitmodules), such that any encoding scheme can be changed
and JGit & co don't need to exactly match the default encoding.

A new test and a helper are added. The helper will be used by
further tests exercising gitdir paths & encodings.

Based-on-patch-by: Brandon Williams <bmwill@google.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/submodule.adoc   |  4 ++++
 builtin/submodule--helper.c           | 17 +++++++++++++++++
 submodule.c                           | 11 +++++++++++
 t/lib-verify-submodule-gitdir-path.sh | 20 ++++++++++++++++++++
 t/t7400-submodule-basic.sh            |  9 +++++++++
 t/t9902-completion.sh                 |  1 +
 6 files changed, 62 insertions(+)
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
index d06e2fe265..564f7aadf8 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1214,6 +1214,22 @@ static int module_summary(int argc, const char **argv, const char *prefix,
 	return ret;
 }
 
+static int module_gitdir(int argc, const char **argv, const char *prefix UNUSED,
+			 struct repository *repo UNUSED)
+{
+	struct strbuf gitdir = STRBUF_INIT;
+
+	if (argc != 2)
+		usage(_("git submodule--helper gitdir <name>"));
+
+	submodule_name_to_gitdir(&gitdir, the_repository, argv[1]);
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
@@ -3597,6 +3613,7 @@ int cmd_submodule__helper(int argc,
 		NULL
 	};
 	struct option options[] = {
+		OPT_SUBCOMMAND("gitdir", &fn, module_gitdir),
 		OPT_SUBCOMMAND("clone", &fn, module_clone),
 		OPT_SUBCOMMAND("add", &fn, module_add),
 		OPT_SUBCOMMAND("update", &fn, module_update),
diff --git a/submodule.c b/submodule.c
index dbf2244e60..bf78636195 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2611,6 +2611,17 @@ void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
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
 
 	/* Legacy behavior: allow existing paths under modules/<name>. */
 	repo_git_path_append(r, buf, "modules/");
diff --git a/t/lib-verify-submodule-gitdir-path.sh b/t/lib-verify-submodule-gitdir-path.sh
new file mode 100644
index 0000000000..ef2a8a47a7
--- /dev/null
+++ b/t/lib-verify-submodule-gitdir-path.sh
@@ -0,0 +1,20 @@
+# Helper to verify if repo $1 contains a submodule named $2 with gitdir path $3
+
+# This does not check filesystem existence. That is done in submodule.c via the
+# submodule_name_to_gitdir() API which this helper ends up calling. The gitdirs
+# might or might not exist (eg. when adding a new submodule), so this only checks
+# the expected configuration path, which might be overridden by the user.
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
index 178c386212..a632f47b73 100755
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
+	verify_submodule_gitdir_path test-submodule child submodules/child &&
+	test_config -C test-submodule submodule.child.gitdirpath ".git/submodules/custom-child" &&
+	verify_submodule_gitdir_path test-submodule child submodules/custom-child &&
+	test_unconfig -C test-submodule submodule.child.gitdirpath &&
+	verify_submodule_gitdir_path test-submodule child submodules/child
+'
+
 test_done
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 6650d33fba..928e519267 100755
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
2.51.GIT

