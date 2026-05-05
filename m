Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2DB3DC4CB
	for <git@vger.kernel.org>; Tue,  5 May 2026 07:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777965760; cv=none; b=Bo8GGHSy9PyODX3gA+74+Gb9QyN1+WOhN0nuGi5K72vWelfACtMpxDGL3iGFS9NhCIhAfa0Gk0wyiya7gMl+FgbYDGW/+PuQPccqUfM3aWkFw8lvtMLrxC5u29R3xglO6DIN71pzzKoVNgu88vAzhaiS9JSKovTjkEnllyZAK0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777965760; c=relaxed/simple;
	bh=kBtSzPK4d36cj+OiStenRuYYQQfp3WyY1FsZ2EkcCsc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=L+HcyJy3BjLpZttBGl/SU0R1PJYKKP1+oUs6fCjDGHAuj5GWm2syJG6cKhIqoejS3iu5tMTg1OT7xQMfTLYCg5/DMiVKZiIJiCQAIE45EEkBs5UmvgE94Wjrtw3o0Dsp3w8UoPPrlISCLKPhcWcTXMftb+P6MfdkrXjxGezM0QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTyfqagB; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTyfqagB"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8b6c9fdb68cso24875526d6.2
        for <git@vger.kernel.org>; Tue, 05 May 2026 00:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777965757; x=1778570557; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbVZqfQ26q1X6jgq29KyRO8gN8QkVkMqOv54PQn9m0U=;
        b=ZTyfqagBYQoA25W2KvJB/9LaHT3lLxFsH5HjDWC+JLqFWe7PTIgg7acTuLBVdKEmz5
         SexeINSW7tOBIBdib4xAYZjmTafkZZ64DmgOtgI00IC6ZcynEdajYpD0Tu1a2s2hVbgi
         ftzbEfyW2VO71Q02ct+AcMoHWb6bBEsMPye+LE1xCIpwbSzv4Z5xf/NDlf+mN+pIk6+i
         PJDe/8esN+HNHT3KnKOW9lnGUxhDXpOY/QfyS+/EqOx+M3TXfsm4jd4XBVy9O6i/zoh7
         C6ebtHaWTPa7ZXPahjKV3XPCmawRq9YixrefehqMozcuaHlxxqUpdZv/Z9s582qlXD+n
         v8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777965757; x=1778570557;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zbVZqfQ26q1X6jgq29KyRO8gN8QkVkMqOv54PQn9m0U=;
        b=Boygo4abYT2oBjeAFaT/T1d3eBxEXOjUJAZl8lA/SuvdVn+D4s2cVStKRaCoDvb9HR
         L8ipU86Uvaeh+gkZgbpkLjxCPoYaVm9g1taVrPxG4ybbUzo4xGG5pUqg5Jd/rNNtuz93
         DS0suhQYyxFF6XlHkXZw1iKZ/pH+00sgC1YcbCLhuvvvwA2QdQVRDHblx62dFJ6kLl3C
         96Aox1EbKaYdc96DoJarryPe0MuYHMfJRqAROPF6MmP2wXhwlGqjteOejeR09qsvx/q0
         3piamAGgIDIdWoHuToXcPtoVXmn/cS7um9De65fxaZCd2AKjZ/E3+8fiJmJ+4he/rjIc
         bCLA==
X-Gm-Message-State: AOJu0YxRBJ//dWnpNBYmusqhYfKY4oy571lFMD03VTGNkO+oPpkJD0b6
	FLb0xPrVsmFlc6ne35s211ciZMVsReFjPt8QzN+MA7sP7EOuqw5kqzZz/VKx/BZ9
X-Gm-Gg: AeBDieuvoT7JWQTeASznRi+TCYkMZ1B6gJU5YyOtA7lNDPqx9+4hHxkn+OrRUdruf+Y
	m6sFkJ7t46Nlr+NS8IFjVMOBZrq2MGOvnPo2vLm5Xx8RQailLOI8FrgQ+kqW4u4WUd6XC2Uq8j8
	v15AS3gZKNzblPeoOosOCjP+UZk6umx36tnlRVGPynEKDFBjWglaETu8NDL2BwCJrCxf9kuFVUM
	UdqLeNksZObMNiE2aOLER8U3tux+zOH6lfG1qxYC7Uu2yKAuLqTp703VxNSd9mCiq7mv4cHWTAp
	1I/NSchPXPYDSAz/h4+fHL0iyY9+klAi1yx51CM1/y9Jje8/+2piFgTBlmqXG3DN4fV9NC/tXcD
	yXPWVnzRqTPUJgUPK3oMzhc3Rs45vzEMQmnDvrPnz/hC4V1nv+h8jfvKS86AlD34KVniN2KTS6X
	/8lQQWBmEtqu763WFNGjQUm/HfptgR9vI60fuz
X-Received: by 2002:a0c:e001:0:b0:89c:d50e:b57 with SMTP id 6a1803df08f44-8b6665f1489mr185812956d6.15.1777965756988;
        Tue, 05 May 2026 00:22:36 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.126.87])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c6b8398sm158703976d6.37.2026.05.05.00.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:22:36 -0700 (PDT)
Message-Id: <6462642cd040e37ccc90ccc6e3f905cb005eda18.1777965748.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v3.git.git.1777965747.gitgitgadget@gmail.com>
References: <pull.2285.v2.git.git.1777919250.gitgitgadget@gmail.com>
	<pull.2285.v3.git.git.1777965747.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 May 2026 07:22:27 +0000
Subject: [PATCH v3 6/6] branch: add --all-remotes flag
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Combined with --forked or --prune-merged, --all-remotes acts on
every configured remote, in addition to any explicit <remote>
arguments. Used alone, it errors out.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  9 ++++++--
 builtin/branch.c              | 40 ++++++++++++++++++++++++-----------
 t/t3200-branch.sh             | 40 +++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 9d4944d17e..5c5b91d9b6 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -24,8 +24,8 @@ git branch (-m|-M) [<old-branch>] <new-branch>
 git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
-git branch --forked <remote>...
-git branch [-f] --prune-merged <remote>...
+git branch --forked (<remote>... | --all-remotes)
+git branch [-f] --prune-merged (<remote>... | --all-remotes)
 
 DESCRIPTION
 -----------
@@ -226,6 +226,11 @@ With `--force` (or `-f`), delete them regardless. The currently
 checked-out branch in any worktree is always preserved, as is
 any branch with `branch.<name>.pruneMerged` set to `false`.
 
+`--all-remotes`::
+	With `--forked` or `--prune-merged`, act on every
+	configured remote in addition to any explicit _<remote>_
+	arguments.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index c2094ca34d..78272daa10 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -685,6 +685,13 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	free_worktrees(worktrees);
 }
 
+static int collect_remote_name(struct remote *remote, void *cb_data)
+{
+	struct string_list *remote_names = cb_data;
+	string_list_insert(remote_names, remote->name);
+	return 0;
+}
+
 static void parse_forked_args(int argc, const char **argv,
 			      struct string_list *remote_names,
 			      struct string_list *tracking_refs)
@@ -754,7 +761,7 @@ static int collect_forked_branch(const struct reference *ref, void *cb_data)
 	return 0;
 }
 
-static void collect_forked_set(int argc, const char **argv,
+static void collect_forked_set(int argc, const char **argv, int all_remotes,
 			       struct string_list *out)
 {
 	struct string_list remote_names = STRING_LIST_INIT_NODUP;
@@ -766,6 +773,8 @@ static void collect_forked_set(int argc, const char **argv,
 	};
 
 	parse_forked_args(argc, argv, &remote_names, &tracking_refs);
+	if (all_remotes)
+		for_each_remote(collect_remote_name, &remote_names);
 
 	refs_for_each_branch_ref(get_main_ref_store(the_repository),
 				 collect_forked_branch, &cb);
@@ -776,15 +785,15 @@ static void collect_forked_set(int argc, const char **argv,
 	string_list_clear(&tracking_refs, 0);
 }
 
-static int list_forked_branches(int argc, const char **argv)
+static int list_forked_branches(int argc, const char **argv, int all_remotes)
 {
 	struct string_list out = STRING_LIST_INIT_DUP;
 	struct string_list_item *item;
 
-	if (!argc)
-		die(_("--forked requires at least one <remote>"));
+	if (!argc && !all_remotes)
+		die(_("--forked requires at least one <remote> or --all-remotes"));
 
-	collect_forked_set(argc, argv, &out);
+	collect_forked_set(argc, argv, all_remotes, &out);
 	for_each_string_list_item(item, &out)
 		puts(item->string);
 
@@ -792,8 +801,8 @@ static int list_forked_branches(int argc, const char **argv)
 	return 0;
 }
 
-static int prune_merged_branches(int argc, const char **argv, int force,
-				 int quiet)
+static int prune_merged_branches(int argc, const char **argv,
+				 int all_remotes, int force, int quiet)
 {
 	struct string_list candidates = STRING_LIST_INIT_DUP;
 	struct strvec deletable = STRVEC_INIT;
@@ -801,10 +810,10 @@ static int prune_merged_branches(int argc, const char **argv, int force,
 	int n_not_merged = 0;
 	int ret = 0;
 
-	if (!argc)
-		die(_("--prune-merged requires at least one <remote>"));
+	if (!argc && !all_remotes)
+		die(_("--prune-merged requires at least one <remote> or --all-remotes"));
 
-	collect_forked_set(argc, argv, &candidates);
+	collect_forked_set(argc, argv, all_remotes, &candidates);
 
 	for_each_string_list_item(item, &candidates) {
 		const char *short_name = item->string;
@@ -911,6 +920,7 @@ int cmd_branch(int argc,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	int forked = 0;
 	int prune_merged = 0;
+	int all_remotes = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -968,6 +978,9 @@ int cmd_branch(int argc,
 			N_("list local branches forked from the given <remote>s")),
 		OPT_BOOL(0, "prune-merged", &prune_merged,
 			N_("delete local branches forked from the given <remote>s that are merged into their upstream")),
+		OPT_BOOL_F(0, "all-remotes", &all_remotes,
+			N_("with --forked or --prune-merged, act on every configured remote"),
+			PARSE_OPT_NONEG),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -1011,6 +1024,9 @@ int cmd_branch(int argc,
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
 
+	if (all_remotes && !forked && !prune_merged)
+		die(_("--all-remotes requires --forked or --prune-merged"));
+
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
 	    !show_current && !unset_upstream && !forked && !prune_merged &&
 	    argc == 0)
@@ -1064,10 +1080,10 @@ int cmd_branch(int argc,
 				      quiet, 0, NULL);
 		goto out;
 	} else if (forked) {
-		ret = list_forked_branches(argc, argv);
+		ret = list_forked_branches(argc, argv, all_remotes);
 		goto out;
 	} else if (prune_merged) {
-		ret = prune_merged_branches(argc, argv, force, quiet);
+		ret = prune_merged_branches(argc, argv, all_remotes, force, quiet);
 		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 9af7de690e..f401d8db19 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1771,6 +1771,27 @@ test_expect_success '--forked requires at least one <remote>' '
 	test_grep "at least one <remote>" err
 '
 
+test_expect_success '--forked --all-remotes covers every configured remote' '
+	git -C forked branch --forked --all-remotes >actual &&
+	cat >expect <<-\EOF &&
+	local-foreign
+	local-one
+	local-two
+	main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--forked --all-remotes still validates explicit <remote>' '
+	test_must_fail git -C forked branch --forked nope --all-remotes 2>err &&
+	test_grep "neither a configured remote nor a remote-tracking branch" err
+'
+
+test_expect_success '--all-remotes alone is rejected' '
+	test_must_fail git -C forked branch --all-remotes 2>err &&
+	test_grep "requires --forked or --prune-merged" err
+'
+
 test_expect_success '--prune-merged: setup' '
 	test_create_repo pm-upstream &&
 	test_commit -C pm-upstream base &&
@@ -1892,4 +1913,23 @@ test_expect_success 'branch -d still deletes a pruneMerged=false branch' '
 	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
 '
 
+test_expect_success '--prune-merged --all-remotes covers every configured remote' '
+	test_when_finished "rm -rf pm-allremotes" &&
+	git clone pm-upstream pm-allremotes &&
+	test_create_repo pm-other &&
+	test_commit -C pm-other other-base &&
+	git -C pm-other branch foreign other-base &&
+	git -C pm-allremotes remote add other ../pm-other &&
+	git -C pm-allremotes fetch other &&
+	git -C pm-allremotes branch one --track origin/one &&
+	git -C pm-allremotes branch foreign --track other/foreign &&
+
+	git -C pm-allremotes update-ref -d refs/remotes/origin/one &&
+	git -C pm-allremotes update-ref -d refs/remotes/other/foreign &&
+	git -C pm-allremotes branch --force --prune-merged --all-remotes &&
+
+	test_must_fail git -C pm-allremotes rev-parse --verify refs/heads/one &&
+	test_must_fail git -C pm-allremotes rev-parse --verify refs/heads/foreign
+'
+
 test_done
-- 
gitgitgadget
