Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068B1366816
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138027; cv=none; b=A3ZlOz3gj3yuVbmGVBk0/XsXFbAhDhyk3wan3ZOAjaXAStl1XjM0frIci8QmZlzx0UogBv7B1Pp7rU+bhb2zw/emvHSTST/RuNoFTAalV4QOZrb3YTe7ASb7WMqKIh/KqQVM9mcwHC2badgDRGpwc9Cz2Zmvo9L9yjGnBkSm8o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138027; c=relaxed/simple;
	bh=m3MAjXRyJx4y5FQY1+ntKLMuT0KcT0w/H5s38HI9uDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8vk2gzjrz31yBX78L4mbHIXBFawwsfS5WpUVSxli3GcGeVOwCUU7OuYCn/ltmEiFL3L1yTs+fJ2OPFfeFsaNWK/n7/nYy9lsq1z0Jszg/h9PK7KQrdYAnZ73mGnVCnmdSCtFUa66fqM+adSgsIitmq0VwUPZvfD9Lm1sb1M0AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcpYV2Hc; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcpYV2Hc"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6b1b766bf01so554455eaf.0
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 07:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789138021; x=1789742821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F00ssfjEJD5OZD0uznaHQdS+Qe+qY0Wat9zxEjKB2r0=;
        b=JcpYV2HcTvMrg3ZniAwAuo03vSrC/YvohdIfskze+OyXy9hE2sK24lGxsNLheq1jfz
         tBPR+FvA7Slb41rUGinoMGS1aZV4NYjIoS0JKQNbO1tNL+grn/27W6fcOPapUvg6gN8J
         jPEev/hkrp5pyAd6VMJC7/flVaUH/akZNz3jspsCPZP728JQYNbsSB5aA7omviuBlU4A
         HwKCwdIjHexKsQh9KXCJvr5w6Ax/+CIsKW6gO6b53Lhf0ZuLDJEFQefKRBTqGT2F2BGh
         k2ESjSRp4uQRJL8B2yAqlLuXQCWeDT6d3ZGJyPOdTwyP6x+IEjWaNAQYnn0tomRSuP7c
         aTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138021; x=1789742821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F00ssfjEJD5OZD0uznaHQdS+Qe+qY0Wat9zxEjKB2r0=;
        b=AcyaaY6DnenBIIcksWN+rRFP2i6YM5bTUerxoi6wztyDs8Y0oGWnoY5/5QOat9tHqG
         cH2lYTCnUVjTUWP6xj0DoN2BpnmtAPctN/MkSq2emIfjIyEgb7EBk9GNGb8hWnAHF6x3
         FUh2H7/TLmiIdlvLAm5c0+fP4Us/o72zx8dgi47AaS5635tVbIz0cWcV7JbIeIEWVj6Y
         uab03f0lmzMB9/e7d90kRmYlS3Ww1UtiPdyqbmoGWiKIqURqm8UMJZRrsyltJqOf9nPc
         +954zDJ5rFnmPKA9RHy6+VDWr9FGU3B34iSoqEoMBqw2LqwDQ29aZISGJ3Q5eO1/7lua
         xZGw==
X-Gm-Message-State: AFuF++nps2G/dz5fyrAtnWCujzp5E7Bc0M2eXqv7mnJzBn+x01Tn3mV5
	COWbupUh1DRmXdbWdj9zzM5Q3o+OsKmrmxVXAFoYUcUaWNHjSh0Nsz/O
X-Gm-Gg: AYBFou0E5nFxG3ycI+IODay4xJda+T/r+NCRG6hb9SSIO0oVW/TRfJuJ/l9oxonF7pX
	t2pHIQLGEDt4RGkB6BLQM8Q/ZDByGbo/zSTK/4X5VV2XX+rTl09ShudauPPiNe67HIEVPyKnEZ9
	px8Lgt+FAVTRZ8dEt8Ya+3/BijD42cEDJaN/hXq0SiQudMoDyJEC8rJCrAnL/8s6h2usBqy2WiU
	vP9EQtGTtJOtLWRJC+vqUvlYEMePUiY1KwT+PrR2NlvlpiKd4tqfRKDaT5EiJRz+B7QiSO4dRnp
	xM30Bh5zyhJThRqDJg80D6wjSX3ztxEpcqSXEcI8yY5tpTO1BfyeHk/kZv2V0WrEIOaw3bKm/rn
	F+QPNGtvm+uNud3W6WxGpz/g+shdrGeLViE8Wl3OC2pk9U5eJgPn1855OJW2PgU29hCt9Gohp6h
	BMaHQbOUJVyP0BBwc+rC2iMQA9FEuv5EQvd/Ct/KHBfwOb8iGPFJ8VkuBUGnRTKVbMZFF73GD9Q
	871EhB3utoCcx8kGzgoGZEeCS2sJOTcYAMVs+iTtqOHT1lnZdWft2Gd6vfUzvbYfdbghwHLAlDv
	7/E+ng==
X-Received: by 2002:a05:6820:5615:b0:6b7:8396:f3d6 with SMTP id 006d021491bc7-6c0bcea7f77mr2230867eaf.56.1789138021324;
        Fri, 11 Sep 2026 07:47:01 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b759d0sm7843335c88.7.2026.09.11.07.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:47:00 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com
Subject: [GSoC Patch v6 2/7] repo: add path.superproject-root with absolute and relative suffixes
Date: Fri, 11 Sep 2026 20:15:14 +0530
Message-ID: <20260911144519.1011780-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260911144519.1011780-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260911144519.1011780-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Scripts working in multi-repository setups often need to identify the
top-level working tree of a superproject from within a submodule.
Currently, this is only exposed via `git rev-parse
--show-superproject-working-tree`.

Introduce `path.superproject-root.absolute` and
`path.superproject-root.relative` keys to `git repo info`.
This exposes the core submodule context via a scriptable config-like key
using standard format rules.

If requested when not inside a submodule, the command returns an empty
string.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc | 10 +++++++
 builtin/repo.c              | 31 ++++++++++++++++++++
 builtin/rev-parse.c         |  2 +-
 submodule.c                 | 43 ++++++++++++++--------------
 submodule.h                 |  2 +-
 t/t1900-repo-info.sh        | 57 +++++++++++++++++++++++++++++++++++++
 6 files changed, 122 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index e34abe5fea..e524a07f53 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -119,6 +119,16 @@ values that they return:
 `path.gitdir.relative`::
 	The path to the Git repository directory relative to the current working directory.
 
+`path.superproject-root.absolute`::
+	The canonical absolute path to the working tree root of the superproject
+	if the current repository is an initialized submodule. Outputs an empty
+	string if not in a submodule.
+
+`path.superproject-root.relative`::
+	The path to the working tree root of the superproject relative to the
+	current working directory if the current repository is an initialized
+	submodule. Outputs an empty string if not in a submodule.
+
 `path.toplevel.absolute`::
 	The canonical absolute path to the top-level directory of the
 	repository's working tree. Outputs an empty string if the repository
diff --git a/builtin/repo.c b/builtin/repo.c
index c31e9cfa70..27ebb7a1c9 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -18,6 +18,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "shallow.h"
+#include "submodule.h"
 #include "tree.h"
 #include "tree-walk.h"
 #include "utf8.h"
@@ -121,6 +122,34 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_superproject_absolute(struct repository *repo, struct strbuf *buf)
+{
+	struct strbuf superproject = STRBUF_INIT;
+
+	if (!get_superproject_working_tree(repo, &superproject)) {
+		strbuf_release(&superproject);
+		return 0;
+	}
+
+	format_path(buf, superproject.buf, "", PATH_FORMAT_CANONICAL);
+	strbuf_release(&superproject);
+	return 0;
+}
+
+static int get_path_superproject_relative(struct repository *repo, struct strbuf *buf)
+{
+	struct strbuf superproject = STRBUF_INIT;
+
+	if (!get_superproject_working_tree(repo, &superproject)) {
+		strbuf_release(&superproject);
+		return 0;
+	}
+
+	format_path(buf, superproject.buf, repo->prefix, PATH_FORMAT_RELATIVE);
+	strbuf_release(&superproject);
+	return 0;
+}
+
 static int get_path_toplevel_absolute(struct repository *repo, struct strbuf *buf)
 {
 	const char *work_tree = repo_get_work_tree(repo);
@@ -159,6 +188,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
+	{ "path.superproject-root.absolute", get_path_superproject_absolute },
+	{ "path.superproject-root.relative", get_path_superproject_relative },
 	{ "path.toplevel.absolute", get_path_toplevel_absolute },
 	{ "path.toplevel.relative", get_path_toplevel_relative },
 	{ "references.format", get_references_format },
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 43693454d5..e1a6da0076 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -997,7 +997,7 @@ int cmd_rev_parse(int argc,
 			}
 			if (!strcmp(arg, "--show-superproject-working-tree")) {
 				struct strbuf superproject = STRBUF_INIT;
-				if (get_superproject_working_tree(&superproject))
+				if (get_superproject_working_tree(the_repository, &superproject))
 					print_path(superproject.buf, prefix, format, DEFAULT_UNMODIFIED);
 				strbuf_release(&superproject);
 				continue;
diff --git a/submodule.c b/submodule.c
index 5c92575888..78856f9840 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2610,34 +2610,35 @@ void absorb_git_dir_into_superproject(const char *path,
 	absorb_git_dir_into_superproject_recurse(path, super_prefix);
 }
 
-int get_superproject_working_tree(struct strbuf *buf)
+int get_superproject_working_tree(struct repository *r, struct strbuf *buf)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf one_up = STRBUF_INIT;
-	char *cwd = xgetcwd();
+	struct strbuf target_wt = STRBUF_INIT;
+	const char *worktree;
 	int ret = 0;
 	const char *subpath;
 	int code;
 	ssize_t len;
 
-	if (!is_inside_work_tree(the_repository))
-		/*
-		 * FIXME:
-		 * We might have a superproject, but it is harder
-		 * to determine.
-		 */
+	worktree = repo_get_work_tree(r);
+	if (!worktree)
+		goto out;
+
+	if (!strbuf_realpath(&target_wt, worktree, 0))
 		goto out;
 
-	if (!strbuf_realpath(&one_up, "../", 0))
+	strbuf_addf(&one_up, "%s/..", target_wt.buf);
+	if (!strbuf_realpath(&one_up, one_up.buf, 0))
 		goto out;
 
-	subpath = relative_path(cwd, one_up.buf, &sb);
+	subpath = relative_path(target_wt.buf, one_up.buf, &sb);
 
 	prepare_submodule_repo_env(&cp.env);
 	strvec_pop(&cp.env);
 
-	strvec_pushl(&cp.args, "--literal-pathspecs", "-C", "..",
+	strvec_pushl(&cp.args, "--literal-pathspecs", "-C", one_up.buf,
 		     "ls-files", "-z", "--stage", "--full-name", "--",
 		     subpath, NULL);
 	strbuf_reset(&sb);
@@ -2648,14 +2649,14 @@ int get_superproject_working_tree(struct strbuf *buf)
 	cp.git_cmd = 1;
 
 	if (start_command(&cp))
-		die(_("could not start ls-files in .."));
+		die(_("could not start ls-files in %s"), one_up.buf);
 
 	len = strbuf_read(&sb, cp.out, PATH_MAX);
 	close(cp.out);
 
 	if (starts_with(sb.buf, "160000")) {
 		int super_sub_len;
-		int cwd_len = strlen(cwd);
+		int wt_len = target_wt.len;
 		char *super_sub, *super_wt;
 
 		/*
@@ -2666,12 +2667,12 @@ int get_superproject_working_tree(struct strbuf *buf)
 		super_sub = strchr(sb.buf, '\t') + 1;
 		super_sub_len = strlen(super_sub);
 
-		if (super_sub_len > cwd_len ||
-		    strcmp(&cwd[cwd_len - super_sub_len], super_sub))
-			BUG("returned path string doesn't match cwd?");
+		if (super_sub_len > wt_len ||
+		    strcmp(&target_wt.buf[wt_len - super_sub_len], super_sub))
+			BUG("returned path string doesn't match worktree?");
 
-		super_wt = xstrdup(cwd);
-		super_wt[cwd_len - super_sub_len] = '\0';
+		super_wt = xstrdup(target_wt.buf);
+		super_wt[wt_len - super_sub_len] = '\0';
 
 		strbuf_realpath(buf, super_wt, 1);
 		ret = 1;
@@ -2681,10 +2682,10 @@ int get_superproject_working_tree(struct strbuf *buf)
 	code = finish_command(&cp);
 
 	if (code == 128)
-		/* '../' is not a git repository */
+		/* parent directory is not a git repository */
 		ret = 0;
 	else if (code == 0 && len == 0)
-		/* There is an unrelated git repository at '../' */
+		/* There is an unrelated git repository at parent directory */
 		ret = 0;
 	else if (code)
 		die(_("ls-tree returned unexpected return code %d"), code);
@@ -2692,7 +2693,7 @@ int get_superproject_working_tree(struct strbuf *buf)
 out:
 	strbuf_release(&sb);
 	strbuf_release(&one_up);
-	free(cwd);
+	strbuf_release(&target_wt);
 	return ret;
 }
 
diff --git a/submodule.h b/submodule.h
index b10e16e6c0..1a465a1208 100644
--- a/submodule.h
+++ b/submodule.h
@@ -170,6 +170,6 @@ void absorb_git_dir_into_superproject(const char *path,
  * project is a submodule of. If this repository is not a submodule of
  * another repository, return 0.
  */
-int get_superproject_working_tree(struct strbuf *buf);
+int get_superproject_working_tree(struct repository *r, struct strbuf *buf);
 
 #endif
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 9417d1ab65..2dc0c0fbc5 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -213,6 +213,45 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_expect_success 'path.superproject-root absolute and relative' '
+	test_when_finished "rm -rf sub super" &&
+	git init sub &&
+	test_commit -C sub initial &&
+	git init super &&
+	(
+		cd super &&
+		git -c protocol.file.allow=always submodule add "../sub" sub &&
+		git commit -m "add submodule" &&
+
+		cd sub &&
+		ROOT="$(test-tool path-utils real_path ..)" &&
+
+		echo "path.superproject-root.absolute=$ROOT" >expect.abs &&
+		git repo info path.superproject-root.absolute >actual.abs &&
+		test_cmp expect.abs actual.abs &&
+
+		echo "path.superproject-root.relative=../" >expect.rel &&
+		git repo info path.superproject-root.relative >actual.rel &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
+test_expect_success 'path.superproject-root returns empty when not in a submodule' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		echo "path.superproject-root.absolute=" >expect.abs &&
+		git repo info path.superproject-root.absolute >actual.abs &&
+		test_cmp expect.abs actual.abs &&
+
+		echo "path.superproject-root.relative=" >expect.rel &&
+		git repo info path.superproject-root.relative >actual.rel &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
 test_expect_success 'path.toplevel absolute and relative' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
@@ -248,4 +287,22 @@ test_expect_success 'path.toplevel absolute and relative in a bare repository' '
 	)
 '
 
+test_expect_success 'path.superproject-root works with --git-dir' '
+	test_when_finished "rm -rf sub super" &&
+	git init sub &&
+	test_commit -C sub initial &&
+	git init super &&
+	(
+		cd super &&
+		git -c protocol.file.allow=always submodule add "../sub" sub &&
+		git commit -m "add submodule" &&
+
+		SUPER_ROOT="$(test-tool path-utils real_path .)" &&
+		MODULE_DIR="$SUPER_ROOT/.git/modules/sub" &&
+
+		echo "path.superproject-root.absolute=$SUPER_ROOT" >expect &&
+		git --git-dir="$MODULE_DIR" repo info path.superproject-root.absolute >actual &&
+		test_cmp expect actual
+	)
+'
 test_done
-- 
2.55.GIT

