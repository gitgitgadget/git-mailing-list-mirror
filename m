Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110663B7756
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775731395; cv=none; b=GDrjZ4ZyTL4lpYjVywK7EcCM0wIQTiZoYMOyG3g5cmJ4iSLQgrJyyYnwyS+bZ2/A7/qfbA5Ni4khv0RtWiphvLK53CW+mucrR+5X5oXaVIGbhVioxhFeUWWDwQOzIejxTQbk9l/yA6u2NT8ay3nB7CCuRI1mbzyp3iOuo+IFWH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775731395; c=relaxed/simple;
	bh=pli05elWMZ4KlK4kbNJFM6OTklDX0l4Djl02ro9lWQY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Fb7pW6kuz2O1PjFn7HIlxq+l1cKdKRwjtsSIHJObGr+oEheo9NpscjHm908v3a+E7a3sC+rUApuviEblWGc5jJb0rkzqjd4rl9ZbPRmJS395toI5OONnG3netM8Ezo2eTFz2lexIobU4M61uSQffODCdMp/nGPCwiCFRtYbyRNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyPIblk6; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyPIblk6"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50b392f1846so11461451cf.3
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 03:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775731393; x=1776336193; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89+eXghHDB7+uzBiHGsdCdNYHodZIQ2e2ynI8yhhvUI=;
        b=jyPIblk6WAI3d7rTZ+3jEPiUL/06xPZsONxwQ/KDzxCjXBEpw42SQiKHPNj94qpIuh
         Fkh6fzf9y+sp16xpTK11h9sZHgLv5w6Cbu6jMFzo8Z3AyvEEcemVPtA++joDAeIH48pb
         7Dy5RFr1yjfXb9cFrXnLHNUnT+B0mZFXne5hlnU4FNtzKt2Yzr4pQQ3gRVbGPhOcnzfS
         o/BoVbxpbAHA0lAEDsXH5Uaka98MR+zSpgeZ/YjEjdsWXjGA4z2sSjgA12Yg7OOtgD1z
         H4+WNhMQaQIA8D1xx1GhJ9gitffmxCCqWMGg2hPd9+ItTQoRVJSc7MwL1aeXYh0P+gzz
         Itxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775731393; x=1776336193;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=89+eXghHDB7+uzBiHGsdCdNYHodZIQ2e2ynI8yhhvUI=;
        b=pcrmXfWQNcEYOi1alK5TyvL27x5LKfTudcvBQfe8P/BjAb2QTN2cOu53uk4JjygFCZ
         oiYAFBNLTaXg+HGxaTVvZy8IHrfjXIRe9oL9sTbmXeRhAwPBcwYk+VF1kjGKbDKvIzmU
         isSeGLBxIRismU4+FFUM4QLSICxWsKbT5xjGQAX8AtOLzu9JIWDnf7Ekqm1naUtHeRSM
         nPYk1pKb7wB/askn91ZA9tpV+unu3WPmTrwr14n2ie9zZG2GR8V7K7oH0ledMjuewrPF
         0G1o4reDlnBZmH4LuGBHWShoMHey7mn8PT/Y5IF3AeriL+d0L6DnnuUDGgMHqUTSQmsW
         aYcw==
X-Gm-Message-State: AOJu0Yz5SdlNNLrMY3CJcH3Ljv49L2YqYbKYSTL/tORMAr3qXiiInKfB
	RZ0SBJFOxC8PCnGYAMwyriiih3ol7qWH0se1yZTMfrtltCq9Vwk+7npdCP3JRA==
X-Gm-Gg: AeBDies99ycLV5P9GUeCCqeRMrLpmgZnfME21c8QHR8dWXaz7Xvz9Q7EKTH0+N4tufW
	MkAfsLWJgWvHmWApZ2vLo3c96Mv3PXBTMefT9FnlOVCTWHcf8YWloaAGS7/1E7vNIvb+mEhgv7d
	6r08HP+8mjjvzVNHIx1eBq4AyxMfKqAyiiBgyMLm7UkJvxOAGj4PouqaiSn+vy0v5wCFeIWQf00
	qMrBUj44sJZAxvtWM8dM4Re7ExuMNH1RQd24WQwydtJjSv+DY8WUQ2mKRQY6DkHB0CT5gRLd7IA
	c0K0h+zbr/K30Ufj+5NZKOasM04QXM1yMLbkjo2czFAytTxSNFEzAxijzx8DxdwptaIFe3V0ECf
	2n/t+U0bzB74cr0/tv7b3DnRw+sc77/DdoVLYGhosamY2pqjFrrwSniOvyUCHaoSUy5gmYuthWb
	o4WiNXDOzOPcNPqsjUESGdfSo7fQ==
X-Received: by 2002:a05:622a:4cc8:b0:50b:409d:48b7 with SMTP id d75a77b69052e-50dc229e946mr43652301cf.44.1775731392531;
        Thu, 09 Apr 2026 03:43:12 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.28.177])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac56318036sm67606776d6.28.2026.04.09.03.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 03:43:11 -0700 (PDT)
Message-Id: <322f94d12173e55e03baf187a37a3870192bc1d2.1775731390.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2202.v4.git.git.1775731390.gitgitgadget@gmail.com>
References: <pull.2202.v3.git.git.1772802872.gitgitgadget@gmail.com>
	<pull.2202.v4.git.git.1775731390.gitgitgadget@gmail.com>
From: "VALERI Yoann via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 10:43:09 +0000
Subject: [PATCH v4 1/2] branch: add '--name-prefix' option
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Yoann Valeri <yoann.valeri@cea.fr>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Yoann Valeri <yoann.valeri@cea.fr>,
    VALERI Yoann <yoann.valeri@cea.fr>

From: VALERI Yoann <yoann.valeri@cea.fr>

This patch adds a '--name-prefix' option to add a prefix to a newly
created branch. It can use a regular string or a token as prefix. The
only token currently handled is '@{current}', which is substituted for
the current branch's name.

Signed-off-by: VALERI Yoann <yoann.valeri@cea.fr>
---
 Documentation/git-branch.adoc | 11 ++++++-
 branch.c                      | 57 +++++++++++++++++++++++++++++++++++
 branch.h                      | 12 ++++++++
 builtin/branch.c              | 24 ++++++++++-----
 t/t3200-branch.sh             | 24 +++++++++++++++
 5 files changed, 120 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index c0afddc424..631b912119 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -17,7 +17,8 @@ git branch [--color[=<when>] | --no-color] [--show-current]
 	   [(-r|--remotes) | (-a|--all)]
 	   [--list] [<pattern>...]
 git branch [--track[=(direct|inherit)] | --no-track] [-f]
-	   [--recurse-submodules] <branch-name> [<start-point>]
+	   [--recurse-submodules] [--name-prefix=<token>]
+	   <branch-name> [<start-point>]
 git branch (--set-upstream-to=<upstream>|-u <upstream>) [<branch-name>]
 git branch --unset-upstream [<branch-name>]
 git branch (-m|-M) [<old-branch>] <new-branch>
@@ -64,6 +65,10 @@ Note that this will create the new branch, but it will not switch the
 working tree to it; use `git switch <new-branch>` to switch to the
 new branch.
 
+With a `--name-prefix` option, you can add a prefix to the branch to create.
+This can either be a simple name, or a token. Currently, only '@{current}' is
+supported as token, and will use the current branch name as prefix.
+
 When a local branch is started off a remote-tracking branch, Git sets up the
 branch (specifically the `branch.<name>.remote` and `branch.<name>.merge`
 configuration entries) so that `git pull` will appropriately merge from
@@ -319,6 +324,10 @@ superproject's "origin/main", but tracks the submodule's "origin/main".
 	and the object it points at.  _<format>_ is the same as
 	that of linkgit:git-for-each-ref[1].
 
+`--name-prefix <token>`::
+	A string that will be used as prefix to the name of the new branch to
+        create. Can be '@{current}' to use the current branch's name.
+
 _<branch-name>_::
 	The name of the branch to create or delete.
 	The new branch name must pass all checks defined by
diff --git a/branch.c b/branch.c
index 243db7d0fc..42e7c799ad 100644
--- a/branch.c
+++ b/branch.c
@@ -365,6 +365,63 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
 	return 0;
 }
 
+static char *get_current_branch_name(void)
+{
+	const char *const prefix = "refs/heads/";
+	struct object_id rev;
+	const char *p;
+	char *output;
+	char *path;
+	int flag;
+
+	path = refs_resolve_refdup(get_main_ref_store(the_repository),
+							   "HEAD", 0, &rev, &flag);
+	if (!path) {
+		warning(_("Failed to get the current branch's path"));
+		return NULL;
+	} else if (!(flag & REF_ISSYMREF)) {
+		FREE_AND_NULL(path);
+		warning(_("Failed to get the current branch's name"));
+		return NULL;
+	}
+
+	if (skip_prefix(path, prefix, &p)) {
+		output = xstrdup(p);
+		free(path);
+		return output;
+	}
+
+	warning(_("Failed to get the current branch's name"));
+	return NULL;
+}
+
+int add_branch_prefix(const char *name_prefix, struct strbuf *buf)
+{
+	if (!name_prefix)
+		return 0;
+
+	if (name_prefix[0] != '@') {
+		strbuf_addstr(buf, name_prefix);
+		return 0;
+	}
+
+	if (strcmp(name_prefix, "@{current}") == 0) {
+		char *current_branch_name = get_current_branch_name();
+
+		if (!current_branch_name)
+			return 1;
+
+		strbuf_addstr(buf, current_branch_name);
+		free(current_branch_name);
+	} else {
+		advise(_("Token '%s' unrecognized, only '@{current}' is managed currently"),
+			   name_prefix);
+		return 1;
+	}
+
+	return 0;
+}
+
 /*
  * Check if 'name' can be a valid name for a branch; die otherwise.
  * Return 1 if the named branch already exists; return 0 otherwise.
diff --git a/branch.h b/branch.h
index 3dc6e2a0ff..97371444ff 100644
--- a/branch.h
+++ b/branch.h
@@ -146,6 +146,18 @@ int install_branch_config(int flag, const char *local, const char *origin, const
  */
 int read_branch_desc(struct strbuf *, const char *branch_name);
 
+/*
+ * Store in 'buf' a prefix to the name of a branch to create by using the given
+ * string 'name_prefix'. It can either be a simple string to a shorthand
+ * starting with '@'.
+ *
+ * Currently, only '@{current}' is managed, and will retrieve the current branch
+ * to use as prefix.
+ *
+ * Return 1 if the function failed to set the branch prefix, 0 otherwise.
+ */
+int add_branch_prefix(const char *name_prefix, struct strbuf *buf);
+
 /*
  * Check if a branch is checked out in the main worktree or any linked
  * worktree and die (with a message describing its checkout location) if
diff --git a/builtin/branch.c b/builtin/branch.c
index 1572a4f9ef..cf7d095f22 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -725,6 +725,7 @@ int cmd_branch(int argc,
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
 	struct ref_format format = REF_FORMAT_INIT;
 	struct repo_config_values *cfg = repo_config_values(the_repository);
+	char *name_prefix = NULL;
 	int ret;
 
 	struct option options[] = {
@@ -777,6 +778,7 @@ int cmd_branch(int argc,
 		OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
 		OPT_BOOL(0, "recurse-submodules", &recurse_submodules_explicit, N_("recurse through submodules")),
 		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
+		OPT_STRING(0, "name-prefix", &name_prefix, N_("name"), N_("prefix for the branch to create")),
 		OPT_END(),
 	};
 
@@ -996,6 +998,8 @@ int cmd_branch(int argc,
 	} else if (!noncreate_actions && argc > 0 && argc <= 2) {
 		const char *branch_name = argv[0];
 		const char *start_name = argc == 2 ? argv[1] : head;
+		struct strbuf new_branch_name = STRBUF_INIT;
+		int rc;
 
 		if (filter.kind != FILTER_REFS_BRANCHES)
 			die(_("the -a, and -r, options to 'git branch' do not take a branch name.\n"
@@ -1004,15 +1008,21 @@ int cmd_branch(int argc,
 		if (track == BRANCH_TRACK_OVERRIDE)
 			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead"));
 
-		if (recurse_submodules) {
-			create_branches_recursively(the_repository, branch_name,
+		rc = add_branch_prefix(name_prefix, &new_branch_name);
+		if (rc)
+			die(_("Failed to add a branch prefix to '%s'"), branch_name);
+
+		strbuf_addstr(&new_branch_name, branch_name);
+
+		if (recurse_submodules)
+			create_branches_recursively(the_repository, new_branch_name.buf,
 						    start_name, NULL, force,
 						    reflog, quiet, track, 0);
-			ret = 0;
-			goto out;
-		}
-		create_branch(the_repository, branch_name, start_name, force, 0,
-			      reflog, quiet, track, 0);
+		else
+			create_branch(the_repository, new_branch_name.buf, start_name,
+						  force, 0, reflog, quiet, track, 0);
+
+		strbuf_release(&new_branch_name);
 	} else
 		usage_with_options(builtin_branch_usage, options);
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index e7829c2c4b..f81d4380a9 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1717,4 +1717,28 @@ test_expect_success 'errors if given a bad branch name' '
 	test_cmp expect actual
 '
 
+test_expect_success 'create branch with --name-prefix' '
+	test_config branch.autosetupmerge false &&
+	git branch branch-with-prefix &&
+	test_ref_exists refs/heads/branch-with-prefix &&
+	git branch --name-prefix "blob" -- -with-prefix &&
+	test_ref_exists refs/heads/blob-with-prefix &&
+	test_must_fail git branch --name-prefix "blob" -- -with-prefix &&
+	git branch --name-prefix "@{current}" -- -with-prefix &&
+	test_ref_exists refs/heads/main-with-prefix &&
+	git switch blob-with-prefix &&
+	git branch --name-prefix "@{current}" -- -with-prefix &&
+	test_ref_exists refs/heads/blob-with-prefix-with-prefix &&
+	test_must_fail git branch --name-prefix "@{current}" -- -with-prefix &&
+	git branch --name-prefix "blob" --no-name-prefix branch-with-no-prefix &&
+	test_ref_exists refs/heads/branch-with-no-prefix &&
+	git checkout main &&
+	test_config alias.bn "branch --name-prefix=blob" &&
+	git bn --no-name-prefix bn-with-no-prefix &&
+	test_ref_exists refs/heads/bn-with-no-prefix &&
+	git branch -D branch-with-prefix main-with-prefix blob-with-prefix &&
+	git branch -D blob-with-prefix-with-prefix branch-with-no-prefix &&
+	git branch -D bn-with-no-prefix
+'
+
 test_done
-- 
gitgitgadget

