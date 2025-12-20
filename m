Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C62F30B53F
	for <git@vger.kernel.org>; Sat, 20 Dec 2025 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766225798; cv=pass; b=Lx51m4ffc6uLEw1iHMLUzjjoNMHzH9HvexFqRGVmAP6PSveSHjr0wUPs0A7oJjWbIsgMNUGImj+tFfAu4zirlGkNqIlWZNLEv19Ezt2OMsoNBpjLC9DTB7VugztUd1hDtJue9evn/tkQhL4F6P8UxO4hiGErhY23rTkPqmJc99E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766225798; c=relaxed/simple;
	bh=nnFnqdpELSHwxkZ9/6vzYKcO/K5Xr6ToD9GmllhUhGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bX0LTXa0iEL5Lwpqb4EdJQoKbk9vokGNbtRw8dpIW91M9PfwZmgJ3iNiGQQegFKVIV06FEL1/dg4qOpI2buQN8aPjqFWRiluTfTOYbbi/wXqBYjZnMO5JD0emzgF1p3IsuCRn/1LBJ6fMJVYSvjlXspNtwP2bCGnzxLDlH0qpHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=BXEnwkHj; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="BXEnwkHj"
ARC-Seal: i=1; a=rsa-sha256; t=1766225781; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=F+qsr6mCeO/jxb1vw0NfZHWOec+NrSWBezOyIALOCA+B3w7kHUQhZnCyZDtYp10R64PC847qmxnLffOYSjAX8nR1l7x84qxho0X3iUQLZCtl/Khd4msOB8QT9susCmOKsz7aSHc2ueTZQYQt8uKg7ETcUhJslZJSl0rKDE41J9U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766225781; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6O+bncBjGI3hGIYwx+PWX4IPFjivGxnkGYJstcr0Z/w=; 
	b=mL2b4kOO7saOy7mg97PnnZfZBJnElrRF82bPyc+EwGyZScaR/ngiD5tUQE40iYMVV3nA7GtRPSwcMedL7w0ePyToDwlJfuUWP2x0xyYFjGAdLUAqFhpFBjlptBDoY3Qb/tbFcu7VMXrQ+nX7Iwt/EtnYkc7QA1Q6aI+jALfMDlU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766225781;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=6O+bncBjGI3hGIYwx+PWX4IPFjivGxnkGYJstcr0Z/w=;
	b=BXEnwkHjswvZQC7Fa1fM7aIr3mDXOzrtZp4EbpUD4nuNDdlwLbSsjJyB7laZVF+y
	+F8ioCKxCQ64i3PNXdB26VN4iIww2cTMR2zbO2NkCT3mahp9fbVMQ4/l/Finx3ll4zj
	3oF+NQLsiYvJoPoCwRQVJeHGPZEdpTZVzS+CXlls=
Received: by mx.zohomail.com with SMTPS id 1766225778891984.266179844556;
	Sat, 20 Dec 2025 02:16:18 -0800 (PST)
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
Subject: [PATCH v7 08/11] submodule--helper: fix filesystem collisions by encoding gitdir paths
Date: Sat, 20 Dec 2025 12:15:25 +0200
Message-ID: <20251220101528.1227487-9-adrian.ratiu@collabora.com>
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

Fix nested filesystem collisions by url-encoding gitdir paths stored
in submodule.%s.gitdir, when extensions.submodulePathConfig is enabled.

Credit goes to Junio and Patrick for coming up with this design: the
encoding is only applied when necessary, to newly added submodules.

Existing modules don't need the encoding because git already errors
out when detecting nested gitdirs before this patch.

This commit adds the basic url-encoding and some tests. Next commits
extend the encode -> validate -> retry loop to fix more conflicts.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/submodule--helper.c                | 12 +++++
 submodule.c                                | 42 +++++++++++++++-
 t/t7425-submodule-gitdir-path-extension.sh | 57 ++++++++++++++++++++++
 3 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5a6436f18f..81ba95d11c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -34,6 +34,7 @@
 #include "list-objects-filter-options.h"
 #include "wildmatch.h"
 #include "strbuf.h"
+#include "url.h"
 
 #define OPT_QUIET (1 << 0)
 #define OPT_CACHED (1 << 1)
@@ -465,12 +466,23 @@ static void create_default_gitdir_config(const char *submodule_name)
 {
 	struct strbuf gitdir_path = STRBUF_INIT;
 
+	/* Case 1: try the plain module name */
 	repo_git_path_append(the_repository, &gitdir_path, "modules/%s", submodule_name);
 	if (!validate_and_set_submodule_gitdir(&gitdir_path, submodule_name)) {
 		strbuf_release(&gitdir_path);
 		return;
 	}
 
+	/* Case 2: Try URI-safe (RFC3986) encoding first, this fixes nested gitdirs */
+	strbuf_reset(&gitdir_path);
+	repo_git_path_append(the_repository, &gitdir_path, "modules/");
+	strbuf_addstr_urlencode(&gitdir_path, submodule_name, is_rfc3986_unreserved);
+	if (!validate_and_set_submodule_gitdir(&gitdir_path, submodule_name)) {
+		strbuf_release(&gitdir_path);
+		return;
+	}
+
+	/* Case 3: nothing worked, error out */
 	die(_("failed to set a valid default config for 'submodule.%s.gitdir'. "
 	      "Please ensure it is set, for example by running something like: "
 	      "'git config submodule.%s.gitdir .git/modules/%s'"),
diff --git a/submodule.c b/submodule.c
index e3692009cd..cf32872ec7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -31,6 +31,7 @@
 #include "commit-reach.h"
 #include "read-cache-ll.h"
 #include "setup.h"
+#include "url.h"
 
 static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
 static int initialized_fetch_ref_tips;
@@ -2246,12 +2247,43 @@ int submodule_move_head(const char *path, const char *super_prefix,
 	return ret;
 }
 
-int validate_submodule_git_dir(char *git_dir, const char *submodule_name)
+/*
+ * Encoded gitdir validation, only used when extensions.submodulePathConfig is enabled.
+ * This does not print errors like the non-encoded version, because encoding is supposed
+ * to mitigate / fix all these.
+ */
+static int validate_submodule_encoded_git_dir(char *git_dir, const char *submodule_name UNUSED)
+{
+	const char *modules_marker = "/modules/";
+	char *p = git_dir, *last_submodule_name = NULL;
+
+	if (!the_repository->repository_format_submodule_path_cfg)
+		BUG("validate_submodule_encoded_git_dir() must be called with "
+		    "extensions.submodulePathConfig enabled.");
+
+	/* Find the last submodule name in the gitdir path (modules can be nested). */
+	while ((p = strstr(p, modules_marker))) {
+		last_submodule_name = p + strlen(modules_marker);
+		p++;
+	}
+
+	/* Prevent the use of '/' in encoded names */
+	if (!last_submodule_name || strchr(last_submodule_name, '/'))
+		return -1;
+
+	return 0;
+}
+
+static int validate_submodule_legacy_git_dir(char *git_dir, const char *submodule_name)
 {
 	size_t len = strlen(git_dir), suffix_len = strlen(submodule_name);
 	char *p;
 	int ret = 0;
 
+	if (the_repository->repository_format_submodule_path_cfg)
+		BUG("validate_submodule_git_dir() must be called with "
+		    "extensions.submodulePathConfig disabled.");
+
 	if (len <= suffix_len || (p = git_dir + len - suffix_len)[-1] != '/' ||
 	    strcmp(p, submodule_name))
 		BUG("submodule name '%s' not a suffix of git dir '%s'",
@@ -2287,6 +2319,14 @@ int validate_submodule_git_dir(char *git_dir, const char *submodule_name)
 	return 0;
 }
 
+int validate_submodule_git_dir(char *git_dir, const char *submodule_name)
+{
+	if (!the_repository->repository_format_submodule_path_cfg)
+		return validate_submodule_legacy_git_dir(git_dir, submodule_name);
+
+	return validate_submodule_encoded_git_dir(git_dir, submodule_name);
+}
+
 int validate_submodule_path(const char *path)
 {
 	char *p = xstrdup(path);
diff --git a/t/t7425-submodule-gitdir-path-extension.sh b/t/t7425-submodule-gitdir-path-extension.sh
index 6ca9f13a59..dbe18f2925 100755
--- a/t/t7425-submodule-gitdir-path-extension.sh
+++ b/t/t7425-submodule-gitdir-path-extension.sh
@@ -327,4 +327,61 @@ test_expect_success '`git clone --recurse-submodules` works after migration' '
 	)
 '
 
+test_expect_success 'setup submodules with nested git dirs' '
+	git init nested &&
+	test_commit -C nested nested &&
+	(
+		cd nested &&
+		cat >.gitmodules <<-EOF &&
+		[submodule "hippo"]
+			url = .
+			path = thing1
+		[submodule "hippo/hooks"]
+			url = .
+			path = thing2
+		EOF
+		git clone . thing1 &&
+		git clone . thing2 &&
+		git add .gitmodules thing1 thing2 &&
+		test_tick &&
+		git commit -m nested
+	)
+'
+
+test_expect_success 'git dirs of encoded sibling submodules must not be nested' '
+	git clone -c extensions.submodulePathConfig=true --recurse-submodules nested clone_nested &&
+
+	verify_submodule_gitdir_path clone_nested hippo modules/hippo &&
+	git -C clone_nested config submodule.hippo.gitdir > actual &&
+	test_grep "\.git/modules/hippo$" actual &&
+
+	verify_submodule_gitdir_path clone_nested hippo/hooks modules/hippo%2fhooks &&
+	git -C clone_nested config submodule.hippo/hooks.gitdir > actual &&
+	test_grep "\.git/modules/hippo%2fhooks$" actual
+'
+
+test_expect_success 'submodule git dir nesting detection must work with parallel cloning' '
+	git clone -c extensions.submodulePathConfig=true --recurse-submodules --jobs=2 nested clone_parallel &&
+
+	verify_submodule_gitdir_path clone_parallel hippo modules/hippo &&
+	git -C clone_nested config submodule.hippo.gitdir > actual &&
+	test_grep "\.git/modules/hippo$" actual &&
+
+	verify_submodule_gitdir_path clone_parallel hippo/hooks modules/hippo%2fhooks &&
+	git -C clone_nested config submodule.hippo/hooks.gitdir > actual &&
+	test_grep "\.git/modules/hippo%2fhooks$" actual
+'
+
+test_expect_success 'disabling extensions.submodulePathConfig prevents nested submodules' '
+	(
+		cd clone_nested &&
+		# disable extension and verify failure
+		git config --replace-all extensions.submodulePathConfig false &&
+		test_must_fail git submodule add ./thing2 hippo/foobar &&
+		# re-enable extension and verify it works
+		git config --replace-all extensions.submodulePathConfig true &&
+		git submodule add ./thing2 hippo/foobar
+	)
+'
+
 test_done
-- 
2.51.2

