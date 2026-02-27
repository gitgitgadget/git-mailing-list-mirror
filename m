Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B89441045
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207345; cv=none; b=TJqvJMrr3eBy5PPIPNB4GPtq1qMets0mdcHLfHznC2eSPK/epHguydsza/xrGCCPdtNDRc+26A6J/3bdFS4YY6xk+YOxzSBoENRsIHCGst49hlkwZ4jMbUnMn02qhsddY4LKyQCzK4SdZVs8T0mfFAYy2zhTkm0RnTYul1PVHBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207345; c=relaxed/simple;
	bh=s07IdFywwKKoALgsCow0wZUqDowByoPEOXbzBA3HXQM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nmplB4rBvsvKZVGpkJDhP7z28idm8Aj81gFVME4jrCX53ZwTjJp2wrpn+kNu9v7qFJQ2ezm0rzJvZzbAjNOEe5sL2Eh6aJ9lksmL5c5qTYA2o6sQtL4ICY9O7hyjGnmZwx0IhfFoCkA1GtdMpe6sAHxCZmOLVcFyS/VsIFpg9H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gr/FKe0A; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gr/FKe0A"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2bdbe434b47so4771904eec.1
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 07:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772207337; x=1772812137; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igXA1tQ+2CnhFKKITSE4mXbuG2uTjt3xErRblA66M9Y=;
        b=gr/FKe0AkQoGLHBrChE6Qsdsxc+lkA90kYsknaQLRX4OyAW5vl9DjOoJlW29z4qMOZ
         1Mmvz9v5brQ2r1E1DpJQr4Ik3iD5FwhB8Nh/gWxLadQLOFp4ZvaQAFnLUEPd8LVyk6/3
         +11Zhf8GhmP90f/kNDBfRvGOeIkKgCV833xex98ZHdzLwIsEVL5acMoMcSrWXCVglXsL
         afPdi1tRUys5QVhZRFE2FO4clt8flLU7LRQ+rSzHEFMr2FEOBvoSzMxVZFOTmCyY8pzZ
         21LVWo85RF4dCqjhBGS/4H+hsedOavegUWsJhg0ltpoSbPL+NSmTO6uBWWWY6aEzyVxU
         yPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772207337; x=1772812137;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=igXA1tQ+2CnhFKKITSE4mXbuG2uTjt3xErRblA66M9Y=;
        b=i0sFOGBb+v5z2rRJqwj8Ri7qGjRQPBPb9P+eNUWpIYSymSuW4fNGduewa1iKRdZDNo
         uaFepUyTQmEsfaNUte3r8oYAGFwCzxi31PSvC83+MV7wF+Vb8rcnZr5l93Io8srdwvcr
         9mCaWCz/slbGAuZBGGZ8qB+DvuIj+PBQO/0yen8eH3LfYYRtDMKcAlIOGCE/suMphb9D
         dABJ6uPR7HyyvJjMdXHLMGw/aDFFxmYxSRoPmaZOX84qFryuxIS5+p6rLrcB/yBhkfs0
         rAPViS+SUHuaKsb6haXjhay+FCi9VAR6SMAzgZoLiEoxfGicS1TwqPo7DC/DAFKmzAMG
         PS8g==
X-Gm-Message-State: AOJu0YwlXtz7phusAMOT4R7XvSLjFVO4O4JVI0Mic06o18kjALjULdIi
	J50zVu1ecwGplkTSvtJNd03ET49fpSBGZyX8sxeu69wVDgdo+ns7U2HQp++9ew==
X-Gm-Gg: ATEYQzyPWzZFRgwZl3b0RUEtSlMZtwmir0oNYUC2MvALIUK5jxMTZGGl0W/D+DYX0wG
	ej9RJVAQoTQwtTPYQmUQTisWBfa9WMHH8I/J4WpkFH4yN36FO+ZTLmMzAVdogAIp4JDyHlVvvum
	iYFda1oS813T4GqJ4am44WJQaUvPm4PcgOcqkJhoJKQEAQ6Jdx7+0HxsC0g2pJmu6xs/mPBAeex
	HHT75tEL9flz3szl00kLA2ozeU4y//girlcflqbGwXmj9hn+TNoyBUfG33qG0VX8ioWXxTIc7Qk
	PRSNdw3jpJhz36Ku+oMojLtU+AcAzYUCOuveMoDgMPhXN3iURbwCs57BnhzmSwjz5XxatCv4w0B
	377MxiU3DpS9UnEPYQroZdH7C+dtmOx2COBiKbmlO0LxLIK2KF2ygMqVgTpcafhLVDEQa/OfPq9
	zfuN/pNiGo7B4LMLtIm1+TBc4XiG0=
X-Received: by 2002:a05:7300:dc8c:b0:2bd:c58b:d6c with SMTP id 5a478bee46e88-2bde1d33636mr1710235eec.31.1772207336528;
        Fri, 27 Feb 2026 07:48:56 -0800 (PST)
Received: from [127.0.0.1] ([172.184.209.165])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f23bdcsm4525683eec.21.2026.02.27.07.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 07:48:55 -0800 (PST)
Message-Id: <49641fb34c2ad5ab987082085d96b04196951c3f.1772207333.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2202.v2.git.git.1772207333.gitgitgadget@gmail.com>
References: <pull.2202.git.git.1771574833967.gitgitgadget@gmail.com>
	<pull.2202.v2.git.git.1772207333.gitgitgadget@gmail.com>
From: "VALERI Yoann via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Feb 2026 15:48:52 +0000
Subject: [PATCH v2 1/2] branch: add 'branch.addCurrentBranchAsPrefix' config
 param
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
    Yoann Valeri <yoann.valeri@cea.fr>,
    VALERI Yoann <yoann.valeri@cea.fr>

From: VALERI Yoann <yoann.valeri@cea.fr>

This patch adds a new configuration parameter for the branch creation
feature: 'branch.addCurrentBranchAsPrefix'. When set to true, if one
creates a new branch with either `git branch`, `git checkout -[bB]` or
`git switch -[cC]`, we will now retrieve the current branch's name, and
use it as prefix for the name of the newly created branch, alongside a
hyphen separating the two.

For instance, using this parameter, and attempting to create a branch
'test' while on the 'main' branch will instead create a branch
'main-test'.

This parameters is useful for projects handling many branches, with
features often needing backport on different branches, so as to reduce
the time taken to create branches without having to come up with clever
names.

Signed-off-by: VALERI Yoann <yoann.valeri@cea.fr>
---
 Documentation/config/branch.adoc |  7 +++++
 branch.c                         | 14 +++++++++
 branch.h                         |  8 +++++
 builtin/branch.c                 | 17 ++++++-----
 builtin/checkout.c               | 52 +++++++++++++++++++++++---------
 t/t2018-checkout-branch.sh       | 26 ++++++++++++++++
 t/t2060-switch.sh                | 26 ++++++++++++++++
 t/t3200-branch.sh                | 14 +++++++++
 8 files changed, 142 insertions(+), 22 deletions(-)

diff --git a/Documentation/config/branch.adoc b/Documentation/config/branch.adoc
index a4db9fa5c8..bd153ea406 100644
--- a/Documentation/config/branch.adoc
+++ b/Documentation/config/branch.adoc
@@ -35,6 +35,13 @@ This option defaults to `never`.
 	value of this variable will be used as the default.
 	See linkgit:git-for-each-ref[1] field names for valid values.
 
+`branch.addCurrentBranchAsPrefix`::
+	When a new branch is created with `git branch`, `git switch` or `git
+	checkout` use the name of the current branch as a prefix for the new
+	branch's name, alongside the one provided by the user, with a hyphen in the
+	middle. For instance, using this configuration variable, creating the branch
+	`test` while on `main` will create the branch `main-test`. False by default.
+
 `branch.<name>.remote`::
 	When on branch _<name>_, it tells `git fetch` and `git push`
 	which remote to fetch from or push to.  The remote to push to
diff --git a/branch.c b/branch.c
index 243db7d0fc..f2d348b046 100644
--- a/branch.c
+++ b/branch.c
@@ -365,6 +365,20 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
 	return 0;
 }
 
+void add_branch_prefix(const char *current_branch,
+					   const char *target_branch, struct strbuf *buf)
+{
+	int value = 0;
+
+	repo_config_get_bool(the_repository,
+						 "branch.addCurrentBranchAsPrefix", &value);
+
+	if (value)
+		strbuf_addf(buf, "%s-%s", current_branch, target_branch);
+	else
+		strbuf_addstr(buf, target_branch);
+}
+
 /*
  * Check if 'name' can be a valid name for a branch; die otherwise.
  * Return 1 if the named branch already exists; return 0 otherwise.
diff --git a/branch.h b/branch.h
index ec2f35fda4..060de1b72c 100644
--- a/branch.h
+++ b/branch.h
@@ -148,6 +148,14 @@ int install_branch_config(int flag, const char *local, const char *origin, const
  */
 int read_branch_desc(struct strbuf *, const char *branch_name);
 
+/*
+ * Fetch the configuration parameter 'branch.addCurrentBranchAsPrefix' and
+ * fill the buffer 'buf' with '<current_branch>-<target_branch>' if true,
+ * otherwise just '<current_branch>'.
+ */
+void add_branch_prefix(const char *current_branch,
+					   const char *target_branch, struct strbuf *buf);
+
 /*
  * Check if a branch is checked out in the main worktree or any linked
  * worktree and die (with a message describing its checkout location) if
diff --git a/builtin/branch.c b/builtin/branch.c
index c577b5d20f..2fbf2d9722 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -995,6 +995,7 @@ int cmd_branch(int argc,
 	} else if (!noncreate_actions && argc > 0 && argc <= 2) {
 		const char *branch_name = argv[0];
 		const char *start_name = argc == 2 ? argv[1] : head;
+		struct strbuf new_branch_name = STRBUF_INIT;
 
 		if (filter.kind != FILTER_REFS_BRANCHES)
 			die(_("the -a, and -r, options to 'git branch' do not take a branch name.\n"
@@ -1003,15 +1004,17 @@ int cmd_branch(int argc,
 		if (track == BRANCH_TRACK_OVERRIDE)
 			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead"));
 
-		if (recurse_submodules) {
-			create_branches_recursively(the_repository, branch_name,
+		add_branch_prefix(start_name, branch_name, &new_branch_name);
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
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f7b313816e..9dc1d00ed2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1170,31 +1170,42 @@ static void orphaned_commit_warning(struct commit *old_commit, struct commit *ne
 	release_revisions(&revs);
 }
 
+static void get_current_branch_info(struct branch_info *branch_info)
+{
+	struct object_id rev;
+	int flag;
+
+	branch_info->path = refs_resolve_refdup(get_main_ref_store(the_repository),
+											"HEAD", 0, &rev, &flag);
+
+	if (branch_info->path)
+		branch_info->commit = lookup_commit_reference_gently(the_repository,
+															 &rev, 1);
+
+	if (!(flag & REF_ISSYMREF))
+		FREE_AND_NULL(branch_info->path);
+
+	if (branch_info->path) {
+		const char *const prefix = "refs/heads/";
+		const char *p;
+
+		if (skip_prefix(branch_info->path, prefix, &p))
+			branch_info->name = xstrdup(p);
+	}
+}
+
 static int switch_branches(const struct checkout_opts *opts,
 			   struct branch_info *new_branch_info)
 {
 	int ret = 0;
 	struct branch_info old_branch_info = { 0 };
-	struct object_id rev;
-	int flag, writeout_error = 0;
+	int writeout_error = 0;
 	int do_merge = 1;
 
 	trace2_cmd_mode("branch");
 
 	memset(&old_branch_info, 0, sizeof(old_branch_info));
-	old_branch_info.path = refs_resolve_refdup(get_main_ref_store(the_repository),
-						   "HEAD", 0, &rev, &flag);
-	if (old_branch_info.path)
-		old_branch_info.commit = lookup_commit_reference_gently(the_repository, &rev, 1);
-	if (!(flag & REF_ISSYMREF))
-		FREE_AND_NULL(old_branch_info.path);
-
-	if (old_branch_info.path) {
-		const char *const prefix = "refs/heads/";
-		const char *p;
-		if (skip_prefix(old_branch_info.path, prefix, &p))
-			old_branch_info.name = xstrdup(p);
-	}
+	get_current_branch_info(&old_branch_info);
 
 	if (opts->new_orphan_branch && opts->orphan_from_empty_tree) {
 		if (new_branch_info->name)
@@ -1772,6 +1783,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	int parseopt_flags = 0;
 	struct branch_info new_branch_info = { 0 };
 	int ret;
+	struct strbuf full_branch_name = { 0 };
 
 	opts->overwrite_ignore = 1;
 	opts->prefix = prefix;
@@ -1962,7 +1974,15 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	}
 
 	if (opts->new_branch) {
+		struct branch_info current_branch = { 0 };
 		struct strbuf buf = STRBUF_INIT;
+		strbuf_init(&full_branch_name, 0);
+
+		get_current_branch_info(&current_branch);
+		add_branch_prefix(current_branch.name, opts->new_branch,
+						  &full_branch_name);
+		branch_info_release(&current_branch);
+		opts->new_branch = full_branch_name.buf;
 
 		if (opts->new_branch_force)
 			opts->branch_exists = validate_branchname(opts->new_branch, &buf);
@@ -1981,6 +2001,8 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	clear_pathspec(&opts->pathspec);
 	free(opts->pathspec_from_file);
 	free(options);
+	if (full_branch_name.buf)
+		strbuf_release(&full_branch_name);
 
 	return ret;
 }
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index a48ebdbf4d..8345a509dc 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -285,4 +285,30 @@ test_expect_success 'checkout -b rejects an extra path argument' '
 	test_grep "Cannot update paths and switch to branch" err
 '
 
+test_expect_success 'checkout -b with prefix is valid' '
+	git checkout -b main &&
+	git checkout -b checkoutb-with-prefix &&
+	git checkout main &&
+	test_config branch.addCurrentBranchAsPrefix false &&
+	test_must_fail git checkout -b checkoutb-with-prefix &&
+	test_config branch.addCurrentBranchAsPrefix true &&
+	git checkout -b checkoutb-with-prefix &&
+	git checkout -b checkoutb-with-prefix &&
+	test_ref_exists refs/heads/checkoutb-with-prefix &&
+	test_ref_exists refs/heads/main-checkoutb-with-prefix &&
+	test_ref_exists refs/heads/main-checkoutb-with-prefix-checkoutb-with-prefix
+'
+
+test_expect_success 'checkout -B with prefix is valid' '
+	git checkout main &&
+	git checkout -B checkoutB-with-prefix &&
+	git checkout main &&
+	test_config branch.addCurrentBranchAsPrefix false &&
+	git checkout -B checkoutB-with-prefix &&
+	test_config branch.addCurrentBranchAsPrefix true &&
+	git checkout -B checkoutB-with-prefix &&
+	test_ref_exists refs/heads/checkoutB-with-prefix &&
+	test_ref_exists refs/heads/checkoutB-with-prefix-checkoutB-with-prefix
+'
+
 test_done
diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index c91c4db936..458f8b9f3f 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -177,4 +177,30 @@ test_expect_success 'switch back when temporarily detached and checked out elsew
 	git -C wt2 switch --ignore-other-worktrees shared
 '
 
+test_expect_success 'switch -c with prefix is valid' '
+	git switch main &&
+	git switch -c switchc-with-prefix &&
+	git checkout main &&
+	test_config branch.addCurrentBranchAsPrefix false &&
+	test_must_fail git switch -c switchc-with-prefix &&
+	test_config branch.addCurrentBranchAsPrefix true &&
+	git switch -c switchc-with-prefix &&
+	git switch -c switchc-with-prefix &&
+	test_ref_exists refs/heads/switchc-with-prefix &&
+	test_ref_exists refs/heads/main-switchc-with-prefix &&
+	test_ref_exists refs/heads/main-switchc-with-prefix-switchc-with-prefix
+'
+
+test_expect_success 'switch -C with prefix is valid' '
+	git switch main &&
+	git switch -C switchC-with-prefix &&
+	git checkout main &&
+	test_config branch.addCurrentBranchAsPrefix false &&
+	git switch -C switchC-with-prefix &&
+	test_config branch.addCurrentBranchAsPrefix true &&
+	git switch -C switchC-with-prefix &&
+	test_ref_exists refs/heads/switchC-with-prefix &&
+	test_ref_exists refs/heads/switchC-with-prefix-switchC-with-prefix
+'
+
 test_done
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index c58e505c43..496b034d0b 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1716,4 +1716,18 @@ test_expect_success 'errors if given a bad branch name' '
 	test_cmp expect actual
 '
 
+test_expect_success 'create branch with prefix' '
+	git config branch.autosetupmerge false &&
+	git branch branch-with-prefix &&
+	test_config branch.addCurrentBranchAsPrefix false &&
+	test_must_fail git branch branch-with-prefix &&
+	test_config branch.addCurrentBranchAsPrefix true &&
+	git branch branch-with-prefix &&
+	git checkout branch-with-prefix &&
+	git branch branch-with-prefix &&
+	test_ref_exists refs/heads/branch-with-prefix &&
+	test_ref_exists refs/heads/main-branch-with-prefix &&
+	test_ref_exists refs/heads/branch-with-prefix-branch-with-prefix
+'
+
 test_done
-- 
gitgitgadget

