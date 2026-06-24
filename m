Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9DB30FF2A
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338113; cv=none; b=swSNTZPmtYU8+KNOjnCrbSv3e6W8DdpQwzXxDqiYWm2kMncmsYZaivE7sjFHcZZQj/gBaiWJtkIZPNFLGewzTJv9LjsWUHw9IvRkhC1qRsx4Rvb71HlMdyvvX4M/WWVNM4lPMVH6x9Fxmphj4tqLY9feBCRXM3SSxRjOKGVhvoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338113; c=relaxed/simple;
	bh=A6Pa0hlOdjJmb0M276nwjZLP3UVjpfrC2OqpBD2p8B0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Y9K43j/3sKzR2+r/HO6bURbbfLxU3HzJ2XGeGpls61l4VQDwo9uCvZNIHB8H4CSsmWorA7zQrONKWQedxwo+cVnB2NyhZrJVEEZIpHziYfGAS18hILbpT3z+JtN7CJG3jLUCQlEDdPdqCQGhkkLpbAdPcNyVj7NvG/FkqcOU2mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2IcfDrY; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2IcfDrY"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1384ebe7a10so3458730c88.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 14:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782338110; x=1782942910; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9kl3REEwUz71fhgvqWM41TxstaWZ95J6HWwwMcO9zI=;
        b=X2IcfDrYL9lrPt9HVrO2gCrqawo9A8xVk/NYFFciMEKzJBSeXi4sYqjpNYXKIBS/C6
         EdJDwv4PgLebk+QSXjTH9wrm7k6H0X9A7CyAPlP7K/ZrsRD4wM4a2p73+lFSsHC1tXXe
         0bWyU7ki9Hiv3rhMVlQ6bUcUoA8vTvmO6eozSm8by17hqDOWXG4/OvZC9XWsXEAaz1y+
         DukOWVMG+VxKCwz6DNZHHlftZdC1Hxz5SQJI/mInS9WXjyKfnY6vcm0pSfbipc1oT03T
         jdf/s8WIyYQVBe1dyzRRzWcpmVedGRJWhaa1ToFxiRmoUoYFX3P85Lpx/YzkLG/6OCu0
         9r8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338110; x=1782942910;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g9kl3REEwUz71fhgvqWM41TxstaWZ95J6HWwwMcO9zI=;
        b=r8QEs1IrMdBN4ulq9kfTsk3OgAvXojzJOu0YkMUYqNYIC9N5ZON5C9I7/D5qY+qb6V
         k8yeDR1hwk7afBIHJKI5L6yIdL59eDyuIpUEvyWXShZFYSnzAFhWpnsSzuHQFv1xKRVA
         Oh4lQqE0q8EpCZ52koghovO2MutZky3BUmSmdZ7XHQsNRC5G4L1mAkEvb/s10QsAIUNQ
         b91b9IabjxVwqTKHHJqMuxFJ1eAVUFpM5Zi/lXSTUX/mqVVozC6o0+YGZiYEJmz8GQdK
         RQdRVTXLnrx9cPgej53vC5//PMk6vPagYXqncJ5+Zyga/csWEBQjtkftiVBKY+PQUqRN
         m3Rw==
X-Gm-Message-State: AOJu0Yx+l8zoihsK2v/XtIv0n1+0akgZRRiWvYImwkWNdpXDd3bYT9P4
	bac9pw7kfKN9auaTwF1+ZnUlCbYITX2ELaQkhU5wCH8FrjAHrH7LRPtlKBi2+w==
X-Gm-Gg: AfdE7cnQwo4thlc9qe0rVriGD9qQVne69AULlk3f2JuskE0LypqdGhYgt+5phbPtC9i
	7wIjkQ4UdaZWiWV1dYkzHt0Myu1+embCjZJQEstsuPf3AqRxHn3OHNciuFG/Ag8B7ssbTGl6yK2
	ZO5EpN3znSLD2TSf6MFkFNCXJOB4doe9fz8twA5SVKkkEemWDt46LzCCK16Zd4jvxVb20PlcWVK
	r86zibtPBFc0VhHL0ngkhv7eeaq7A+8lpp+5j5qN/+gkBQfAzl3mSEmT1w2wEoIDPp5tiqzueLG
	W3Gg3+1/EHqyIY0z7yYM/rhNC928/ZC3nVDxqp1hVFTWgVKoX2FMaR8vFaqdVMNP9xu8zfKcnOX
	u/bvE/8VvKGbYTPSWTzz5EmVvn5NgykYdJwvrvvDXY4sTTH6iLO3uLrgEjv4sk38M5Do5Mgsb7O
	2Bs74dkbEf8OWkXhvt
X-Received: by 2002:a05:7022:6b87:b0:137:feeb:3fc9 with SMTP id a92af1059eb24-139c5dc689fmr7134678c88.18.1782338110238;
        Wed, 24 Jun 2026 14:55:10 -0700 (PDT)
Received: from [127.0.0.1] ([52.160.149.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d9105b57sm1782714c88.14.2026.06.24.14.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:55:09 -0700 (PDT)
Message-Id: <3e29ff17bd703d8333c2d65d36b15c69ddfc2ab9.1782338106.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
References: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
	<pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jun 2026 21:55:00 +0000
Subject: [PATCH v18 1/7] branch: add --forked filter for --list mode
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
    Johannes Sixt <j6t@kdbg.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add a --forked option to "git branch" list mode that lists only
branches whose configured upstream matches <branch>. The argument
can be a ref (e.g. "origin/main", "master"), a remote name like
"origin" for the branch its origin/HEAD points at, or a shell glob
(e.g. "origin/*"), and may be repeated to widen the filter.

It is an ordinary list filter, so it combines with the others:

    git branch --merged origin/main --forked 'origin/*'

lists branches forked from origin that are already merged into
origin/main, and --no-merged inverts the question.

This is the building block for --delete-merged, which deletes the
listed branches once they have landed on their upstream.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  12 +++-
 builtin/branch.c              |  18 ++++-
 ref-filter.c                  |  70 +++++++++++++++++++
 ref-filter.h                  |  10 +++
 t/t3200-branch.sh             | 122 ++++++++++++++++++++++++++++++++++
 5 files changed, 229 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index c0afddc424..b0d66a6deb 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -13,6 +13,7 @@ git branch [--color[=<when>] | --no-color] [--show-current]
 	   [--column[=<options>] | --no-column] [--sort=<key>]
 	   [--merged [<commit>]] [--no-merged [<commit>]]
 	   [--contains [<commit>]] [--no-contains [<commit>]]
+	   [(--forked <branch>)...]
 	   [--points-at <object>] [--format=<format>]
 	   [(-r|--remotes) | (-a|--all)]
 	   [--list] [<pattern>...]
@@ -51,7 +52,8 @@ merged into the named commit (i.e. the branches whose tip commits are
 reachable from the named commit) will be listed.  With `--no-merged` only
 branches not merged into the named commit will be listed.  If the _<commit>_
 argument is missing it defaults to `HEAD` (i.e. the tip of the current
-branch).
+branch).  With `--forked`, only branches whose configured upstream matches
+the given branch or pattern will be listed.
 
 The command's second form creates a new branch head named _<branch-name>_
 which points to the current `HEAD`, or _<start-point>_ if given. As a
@@ -311,6 +313,14 @@ superproject's "origin/main", but tracks the submodule's "origin/main".
 	Only list branches whose tips are not reachable from
 	_<commit>_ (`HEAD` if not specified). Implies `--list`.
 
+`--forked <branch>`::
+	Only list branches whose configured upstream matches
+	_<branch>_. The argument can be a ref (e.g. `origin/main`,
+	`master`), a remote name like `origin` for the branch its
+	`origin/HEAD` points at, or a shell-style glob (e.g.
+	`'origin/*'`). The option can be repeated to widen the
+	filter. Implies `--list`.
+
 `--points-at <object>`::
 	Only list branches of _<object>_.
 
diff --git a/builtin/branch.c b/builtin/branch.c
index 1572a4f9ef..c159f45b4c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -30,7 +30,7 @@
 #include "commit-reach.h"
 
 static const char * const builtin_branch_usage[] = {
-	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged]"),
+	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged] [(--forked <branch>)...]"),
 	N_("git branch [<options>] [-f] [--recurse-submodules] <branch-name> [<start-point>]"),
 	N_("git branch [<options>] [-l] [<pattern>...]"),
 	N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
@@ -673,6 +673,16 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	free_worktrees(worktrees);
 }
 
+static int parse_opt_forked(const struct option *opt, const char *arg, int unset)
+{
+	struct ref_filter *filter = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	if (ref_filter_forked_add(filter, arg) < 0)
+		die(_("'%s' is not a valid branch or pattern"), arg);
+	return 0;
+}
+
 static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
 
 static int edit_branch_description(const char *branch_name)
@@ -770,6 +780,9 @@ int cmd_branch(int argc,
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
+		OPT_CALLBACK_F(0, "forked", &filter, N_("branch"),
+			N_("print only branches whose upstream matches <branch> (repeatable)"),
+			PARSE_OPT_NONEG, parse_opt_forked),
 		OPT_COLUMN(0, "column", &colopts, N_("list branches in columns")),
 		OPT_REF_SORT(&sorting_options),
 		OPT_CALLBACK(0, "points-at", &filter.points_at, N_("object"),
@@ -815,7 +828,8 @@ int cmd_branch(int argc,
 		list = 1;
 
 	if (filter.with_commit || filter.no_commit ||
-	    filter.reachable_from || filter.unreachable_from || filter.points_at.nr)
+	    filter.reachable_from || filter.unreachable_from ||
+	    filter.points_at.nr || filter.forked.nr)
 		list = 1;
 
 	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
diff --git a/ref-filter.c b/ref-filter.c
index 8ba91c72a1..6ee2328bdb 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2744,6 +2744,72 @@ static int filter_exclude_match(struct ref_filter *filter, const char *refname)
 	return match_pattern(filter->exclude.v, refname, filter->ignore_case);
 }
 
+static const char *short_upstream_name(const char *full_ref)
+{
+	const char *short_name = full_ref;
+	(void)(skip_prefix(short_name, "refs/heads/", &short_name) ||
+	       skip_prefix(short_name, "refs/remotes/", &short_name));
+	return short_name;
+}
+
+/*
+ * Match the configured upstream of a branch against the registered
+ * --forked patterns. Exact patterns are compared against the full
+ * upstream refname so they are unambiguous; glob patterns are matched
+ * against the abbreviated upstream so that a glob such as origin/...
+ * works as typed.
+ */
+static int filter_forked_match(struct ref_filter *filter, const char *refname)
+{
+	const char *short_name;
+	struct branch *branch;
+	const char *upstream;
+	int i;
+
+	if (!skip_prefix(refname, "refs/heads/", &short_name))
+		return 0;
+	branch = branch_get(short_name);
+	if (!branch)
+		return 0;
+	upstream = branch_get_upstream(branch, NULL);
+	if (!upstream)
+		return 0;
+
+	for (i = 0; i < filter->forked.nr; i++) {
+		const char *pattern = filter->forked.v[i];
+		if (has_glob_specials(pattern)) {
+			if (!wildmatch(pattern, short_upstream_name(upstream),
+				       WM_PATHNAME))
+				return 1;
+		} else if (!strcmp(pattern, upstream)) {
+			return 1;
+		}
+	}
+	return 0;
+}
+
+int ref_filter_forked_add(struct ref_filter *filter, const char *arg)
+{
+	struct object_id oid;
+	char *full_ref = NULL;
+
+	if (has_glob_specials(arg)) {
+		strvec_push(&filter->forked, arg);
+		return 0;
+	}
+
+	if (repo_dwim_ref(the_repository, arg, strlen(arg), &oid,
+			  &full_ref, 0) == 1 &&
+	    (starts_with(full_ref, "refs/heads/") ||
+	     starts_with(full_ref, "refs/remotes/"))) {
+		strvec_push(&filter->forked, full_ref);
+		free(full_ref);
+		return 0;
+	}
+	free(full_ref);
+	return -1;
+}
+
 /*
  * We need to seek to the reference right after a given marker but excluding any
  * matching references. So we seek to the lexicographically next reference.
@@ -2979,6 +3045,9 @@ static struct ref_array_item *apply_ref_filter(const struct reference *ref,
 	if (filter->points_at.nr && !match_points_at(&filter->points_at, ref->oid, ref->name))
 		return NULL;
 
+	if (filter->forked.nr && !filter_forked_match(filter, ref->name))
+		return NULL;
+
 	/*
 	 * A merge filter is applied on refs pointing to commits. Hence
 	 * obtain the commit using the 'oid' available and discard all
@@ -3765,6 +3834,7 @@ void ref_filter_init(struct ref_filter *filter)
 void ref_filter_clear(struct ref_filter *filter)
 {
 	strvec_clear(&filter->exclude);
+	strvec_clear(&filter->forked);
 	oid_array_clear(&filter->points_at);
 	commit_list_free(filter->with_commit);
 	commit_list_free(filter->no_commit);
diff --git a/ref-filter.h b/ref-filter.h
index 120221b47f..9361296e2a 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -67,6 +67,7 @@ struct ref_filter {
 	const char **name_patterns;
 	const char *start_after;
 	struct strvec exclude;
+	struct strvec forked;
 	struct oid_array points_at;
 	struct commit_list *with_commit;
 	struct commit_list *no_commit;
@@ -110,6 +111,7 @@ struct ref_format {
 #define REF_FILTER_INIT { \
 	.points_at = OID_ARRAY_INIT, \
 	.exclude = STRVEC_INIT, \
+	.forked = STRVEC_INIT, \
 }
 #define REF_FORMAT_INIT {             \
 	.use_color = GIT_COLOR_UNKNOWN, \
@@ -172,6 +174,14 @@ void ref_sorting_release(struct ref_sorting *);
 struct ref_sorting *ref_sorting_options(struct string_list *);
 /*  Function to parse --merged and --no-merged options */
 int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
+/*
+ * Register a --forked <branch> pattern on the filter. The argument is
+ * either a ref, which is resolved to its full refname, or a shell-style
+ * glob. Branches are kept only when their configured upstream matches
+ * one of the registered patterns. Returns -1 if the argument is not a
+ * valid ref or pattern.
+ */
+int ref_filter_forked_add(struct ref_filter *filter, const char *arg);
 /*  Get the current HEAD's description */
 char *get_head_description(void);
 /*  Set up translated strings in the output. */
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index e7829c2c4b..3104c555f6 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1717,4 +1717,126 @@ test_expect_success 'errors if given a bad branch name' '
 	test_cmp expect actual
 '
 
+test_expect_success '--forked: setup' '
+	test_create_repo forked-upstream &&
+	(
+		cd forked-upstream &&
+		test_commit base &&
+		git branch one base &&
+		git branch two base
+	) &&
+
+	test_create_repo forked-other &&
+	(
+		cd forked-other &&
+		test_commit other-base &&
+		git branch foreign other-base
+	) &&
+
+	git clone forked-upstream forked &&
+	(
+		cd forked &&
+		git remote add -f other ../forked-other &&
+		git remote set-head origin one &&
+		git branch local-base &&
+		git branch --track local-one origin/one &&
+		git branch --track local-two origin/two &&
+		git branch --track local-foreign other/foreign &&
+		git branch --track local-onbase local-base &&
+
+		git checkout local-one &&
+		test_commit --no-tag local-one-work local-one.t &&
+		git checkout local-foreign &&
+		test_commit --no-tag local-foreign-work local-foreign.t &&
+		git checkout --detach
+	)
+'
+
+test_expect_success '--forked <upstream-tracking-branch> filters by upstream' '
+	git -C forked branch --forked origin/one --format="%(refname:short)" >actual &&
+	echo local-one >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--forked <glob> filters by wildmatch' '
+	git -C forked branch --forked "origin/*" --format="%(refname:short)" >actual &&
+	cat >expect <<-\EOF &&
+	local-one
+	local-two
+	main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--forked <local-branch> matches branches with local upstream' '
+	git -C forked branch --forked local-base --format="%(refname:short)" >actual &&
+	echo local-onbase >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--forked can be repeated to widen the filter' '
+	git -C forked branch --forked origin/one --forked other/foreign --format="%(refname:short)" >actual &&
+	cat >expect <<-\EOF &&
+	local-foreign
+	local-one
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--forked combines literal and glob arguments' '
+	git -C forked branch --forked local-base --forked "other/*" --format="%(refname:short)" >actual &&
+	cat >expect <<-\EOF &&
+	local-foreign
+	local-onbase
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--forked "*/*" covers every remote-tracking upstream' '
+	git -C forked branch --forked "*/*" --format="%(refname:short)" >actual &&
+	cat >expect <<-\EOF &&
+	local-foreign
+	local-one
+	local-two
+	main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--forked composes with --no-merged' '
+	test_when_finished "git -C forked checkout --detach" &&
+	git -C forked checkout local-one &&
+	test_commit -C forked local-only &&
+	git -C forked branch --forked "origin/*" --no-merged origin/one \
+		--format="%(refname:short)" >actual &&
+	echo local-one >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--forked rejects unknown branch/pattern' '
+	test_must_fail git -C forked branch --forked nope 2>err &&
+	test_grep "not a valid branch or pattern" err
+'
+
+test_expect_success '--forked requires a value' '
+	test_must_fail git -C forked branch --forked 2>err &&
+	test_grep "requires a value" err
+'
+
+test_expect_success '--forked <remote> uses the branch <remote>/HEAD points at' '
+	git -C forked branch --forked origin --format="%(refname:short)" >actual &&
+	echo local-one >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--forked narrows a <pattern> argument' '
+	git -C forked branch --forked "origin/*" "local-*" \
+		--format="%(refname:short)" >actual &&
+	cat >expect <<-\EOF &&
+	local-one
+	local-two
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

