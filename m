Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD38436AB44
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 09:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780477486; cv=none; b=HUFESMdQm2gKtwTExdw03xapHrlfPnf/8MWgQVjSgZmC0dJQaxG8PMpsjEcrAR6PuI5D/DM1zbQPYgURolpgaruU+4XFbiC8TklpJ9YBCNqpPlOFp+a4KwyEH/YyZjCn9UyV2cczZyzbeCbSiXGVvp6QVUJDYRG6WArurM+cuBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780477486; c=relaxed/simple;
	bh=vaaRPrGBrzuroUy6aLhgYpuz5e0T+Z4BaA0zEu/i9U4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=g8dZeHeb3ThUw3XAgjQnjggF+GxfHhkQVRgqB1SJSFbIreak1/NBE4vGQJ7O0jpfudyEJuYjmj3ac/45T7Of+CMwTIdrX+9d5b3EnQAX/1D63QHthn+jX/1I6o6bN4Do2RWmbSFUYB06329EDYzoyc5ZzgrDXd63xuhJ41N5aZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTuM+O5I; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTuM+O5I"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-307263ad0cbso3765218eec.0
        for <git@vger.kernel.org>; Wed, 03 Jun 2026 02:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780477484; x=1781082284; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsJP2sjSoP2bJddqxyWhqYfPHqDr364XcQs2zJY6t/U=;
        b=MTuM+O5IhfsgORlIEs59pcjVppQOQkjsOqZIT4Qt/5scljOVgChVNj0Oaz7CEtop3L
         1l0p4zlPsmaDQwX3nmmdJV8BE4roXseaxbCdsFi/Uyx5aEPTCy79Zf2RAwOb6v8hStAz
         r6CmTMP5L2utPE2JN9y+u6p8XbRCdu5FoHV8kpSJPHW6yJckZt6xcHpUTgvLu3z5P1vp
         eKOe+FoHlrGIs/YAn14ABVB7NDv/adO/pE4LTH+uMFcDVWMRlQdUquoFba14RXmN9Cvh
         pHR9uaodUkvhvgBgnqwb97croxuOprfwUvGzjWBiiajE3Re5bcfJzbYi5ZqKU7n9PZWG
         lekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780477484; x=1781082284;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IsJP2sjSoP2bJddqxyWhqYfPHqDr364XcQs2zJY6t/U=;
        b=Bmq1N8/g9b6AooWKE5tmuX2Ev7bQBsQxVj2ZT/Ikw4Vnv4wAku0M4YTbSTrrPQJt3W
         otaRvn5xfrI2oPzMOMEttcHdxPyZ/320eJf1q1Oam+mo/kl7cuorM89k6psB2fBoTOnO
         VBDiwA7odI3gwWc+7OKi8fOlq8jxrXtL2MZ9xt7wF4oRkUzSnNYoPoNCdv5JZbeaWjEj
         tSHMja8xzyI/tpKFRWcl6ZQX19m3cuG/Z0zQTfLkSD5/nDsaSRcxXrMbtl4mlviuJHxT
         mmm32bXCpWDY72xiO4VXPwp60XqJ2rzqmG3x90koHb1q+xw52jOi3LTVxPHyHHVoFwuR
         U7/w==
X-Gm-Message-State: AOJu0Yw9yBvz7Ude0klOm3ygkAFHkp1xgP1rdqdfwFaPYvWRbzFvtHex
	rHegsOSev7m8aMYuuEwwRUZbw8usw9sH1Pcihh2IKCV3W2AXUmy3QfQs7P3LbsQO
X-Gm-Gg: Acq92OFrTINpleupDHjltdfW9IMyxm0aoy8e0tBZJrmDJkheOObjEhhpRohC0ioaPY4
	T+ikyGUhqitSRmmpP2OM+nvXuEaaCj8+/HMyv0uAXvWR+sYVZow7c6EqW5k5GLF3QF73rgKsw8z
	wTKAKTNAff2Xg5NTTbr4UvrWRpW7yg/CsB0RwgzR+BPdKIGJvv758W2SQoFrjErPyycHmxoWVbG
	cAR8Fp1BDqQefqteUAcXvEOyUgzbUImsvtdXStvpESKFeO3unpawtqEYqb5pwuVdNAMyPmBMaY+
	wK6JibGLbET8xBPZXmwDyuXnSy/6F1g4urTLSZfQ6NeRWsk+pruKFu7eHJEkdkpx+BLuvGqbn26
	LiOuDQH7GgdZDiQYhABQEHaeojgC31eRXm4pCqXJu39F72uJEZVY3MXGj7gYsqTysfQ2F4CNkc/
	jTjmFHQIyHyK4bOkvWP3nsOSj/Wv1UPDLcNydYTg==
X-Received: by 2002:a05:7300:dc8c:b0:2d9:db50:c6a5 with SMTP id 5a478bee46e88-3074f83a230mr1360210eec.0.1780477483671;
        Wed, 03 Jun 2026 02:04:43 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.228.214])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dcad34esm2752300eec.11.2026.06.03.02.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 02:04:43 -0700 (PDT)
Message-Id: <8834c424fbd27800636fe21ae73e9cdce75b558a.1780477479.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v12.git.git.1780477479.gitgitgadget@gmail.com>
References: <pull.2285.v11.git.git.1779449498.gitgitgadget@gmail.com>
	<pull.2285.v12.git.git.1780477479.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 03 Jun 2026 09:04:34 +0000
Subject: [PATCH v12 1/6] branch: add --forked filter for --list mode
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

Add a --forked option to "git branch" list mode that keeps only
branches whose configured upstream matches <branch>. The argument
can be a ref (e.g. "origin/main", "master") or a shell-style
glob (e.g. "origin/*"). The option can be repeated to widen the
filter.

Because it is a filter on list mode, --forked composes with the
existing list-mode filters, so

    git branch --merged origin/main --forked 'origin/*'

lists branches forked from origin that have already been
integrated into origin/main, and --no-merged inverts the question.

This is the building block for --prune-merged, which deletes the
listed branches once they have landed on their upstream.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |   7 ++
 builtin/branch.c              | 147 +++++++++++++++++++++++++++++++++-
 ref-filter.c                  |  10 +--
 ref-filter.h                  |   2 +
 t/t3200-branch.sh             |  92 +++++++++++++++++++++
 5 files changed, 249 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index c0afddc424..8002d7f38c 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -14,6 +14,7 @@ git branch [--color[=<when>] | --no-color] [--show-current]
 	   [--merged [<commit>]] [--no-merged [<commit>]]
 	   [--contains [<commit>]] [--no-contains [<commit>]]
 	   [--points-at <object>] [--format=<format>]
+	   [(--forked <branch>)...]
 	   [(-r|--remotes) | (-a|--all)]
 	   [--list] [<pattern>...]
 git branch [--track[=(direct|inherit)] | --no-track] [-f]
@@ -199,6 +200,12 @@ This option is only applicable in non-verbose mode.
 	Print the name of the current branch. In detached `HEAD` state,
 	nothing is printed.
 
+`--forked <branch>`::
+	List only branches whose configured upstream matches
+	_<branch>_. The argument can be a ref (e.g. `origin/main`,
+	`master`) or a shell-style glob (e.g. `'origin/*'`). The
+	option can be repeated to widen the filter.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 1572a4f9ef..12711b29cf 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -28,9 +28,10 @@
 #include "help.h"
 #include "advice.h"
 #include "commit-reach.h"
+#include "wildmatch.h"
 
 static const char * const builtin_branch_usage[] = {
-	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged]"),
+	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged] [(--forked <branch>)...]"),
 	N_("git branch [<options>] [-f] [--recurse-submodules] <branch-name> [<start-point>]"),
 	N_("git branch [<options>] [-l] [<pattern>...]"),
 	N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
@@ -442,8 +443,12 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
 	return strbuf_detach(&fmt, NULL);
 }
 
+static void filter_array_by_forked(struct ref_array *array,
+				   const struct string_list *upstreams);
+
 static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sorting,
-			   struct ref_format *format, struct string_list *output)
+			   struct ref_format *format, struct string_list *output,
+			   const struct string_list *forked_upstreams)
 {
 	int i;
 	struct ref_array array;
@@ -463,6 +468,9 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 
 	filter_refs(&array, filter, filter->kind);
 
+	if (forked_upstreams->nr)
+		filter_array_by_forked(&array, forked_upstreams);
+
 	if (filter->verbose)
 		maxwidth = calc_maxwidth(&array, strlen(remote_prefix));
 
@@ -673,6 +681,131 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	free_worktrees(worktrees);
 }
 
+struct upstream_pattern {
+	char *name;
+	int is_wildcard;
+};
+
+static void upstream_pattern_list_clear(struct upstream_pattern *items,
+					size_t nr)
+{
+	size_t i;
+	for (i = 0; i < nr; i++)
+		free(items[i].name);
+	free(items);
+}
+
+static const char *short_upstream_name(const char *full_ref)
+{
+	const char *short_name = full_ref;
+	(void)(skip_prefix(short_name, "refs/heads/", &short_name) ||
+	       skip_prefix(short_name, "refs/remotes/", &short_name));
+	return short_name;
+}
+
+static int parse_one_forked_arg(const char *arg, struct upstream_pattern *out)
+{
+	struct object_id oid;
+	char *full_ref = NULL;
+
+	if (has_glob_specials(arg)) {
+		out->name = xstrdup(arg);
+		out->is_wildcard = 1;
+		return 0;
+	}
+
+	if (repo_dwim_ref(the_repository, arg, strlen(arg), &oid,
+			  &full_ref, 0) == 1 &&
+	    (starts_with(full_ref, "refs/heads/") ||
+	     starts_with(full_ref, "refs/remotes/"))) {
+		out->name = xstrdup(short_upstream_name(full_ref));
+		out->is_wildcard = 0;
+		free(full_ref);
+		return 0;
+	}
+	free(full_ref);
+	return -1;
+}
+
+static void parse_forked_args(const struct string_list *args,
+			      struct upstream_pattern **patterns_out,
+			      size_t *nr_out)
+{
+	struct upstream_pattern *patterns;
+	size_t i;
+
+	ALLOC_ARRAY(patterns, args->nr);
+	for (i = 0; i < args->nr; i++) {
+		const char *arg = args->items[i].string;
+		if (parse_one_forked_arg(arg, &patterns[i]) < 0) {
+			upstream_pattern_list_clear(patterns, i);
+			die(_("'%s' is not a valid branch or pattern"), arg);
+		}
+	}
+	*patterns_out = patterns;
+	*nr_out = args->nr;
+}
+
+static int upstream_matches(const char *short_upstream,
+			    const struct upstream_pattern *patterns,
+			    size_t nr)
+{
+	size_t i;
+
+	for (i = 0; i < nr; i++) {
+		const struct upstream_pattern *p = &patterns[i];
+		if (p->is_wildcard) {
+			if (!wildmatch(p->name, short_upstream, WM_PATHNAME))
+				return 1;
+		} else if (!strcmp(p->name, short_upstream)) {
+			return 1;
+		}
+	}
+	return 0;
+}
+
+static int branch_upstream_matches(const char *full_refname,
+				   const struct upstream_pattern *patterns,
+				   size_t nr_patterns)
+{
+	const char *short_name;
+	struct branch *branch;
+	const char *upstream;
+
+	if (!skip_prefix(full_refname, "refs/heads/", &short_name))
+		return 0;
+	branch = branch_get(short_name);
+	if (!branch)
+		return 0;
+	upstream = branch_get_upstream(branch, NULL);
+	if (!upstream)
+		return 0;
+	return upstream_matches(short_upstream_name(upstream),
+				patterns, nr_patterns);
+}
+
+static void filter_array_by_forked(struct ref_array *array,
+				   const struct string_list *upstreams)
+{
+	struct upstream_pattern *patterns = NULL;
+	size_t nr_patterns = 0;
+	int i, kept = 0;
+
+	parse_forked_args(upstreams, &patterns, &nr_patterns);
+
+	for (i = 0; i < array->nr; i++) {
+		struct ref_array_item *item = array->items[i];
+		if (branch_upstream_matches(item->refname,
+					    patterns, nr_patterns))
+			array->items[kept++] = item;
+		else
+			free_ref_array_item(item);
+	}
+	array->nr = kept;
+
+	upstream_pattern_list_clear(patterns, nr_patterns);
+}
+
 static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
 
 static int edit_branch_description(const char *branch_name)
@@ -714,6 +847,7 @@ int cmd_branch(int argc,
 	/* possible actions */
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
+	struct string_list forked_upstreams = STRING_LIST_INIT_DUP;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -767,6 +901,8 @@ int cmd_branch(int argc,
 		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
+		OPT_STRING_LIST(0, "forked", &forked_upstreams, N_("branch"),
+			N_("list local branches whose upstream matches <branch> (repeatable)")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -815,7 +951,8 @@ int cmd_branch(int argc,
 		list = 1;
 
 	if (filter.with_commit || filter.no_commit ||
-	    filter.reachable_from || filter.unreachable_from || filter.points_at.nr)
+	    filter.reachable_from || filter.unreachable_from ||
+	    filter.points_at.nr || forked_upstreams.nr)
 		list = 1;
 
 	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
@@ -880,7 +1017,8 @@ int cmd_branch(int argc,
 		ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
 		ref_sorting_set_sort_flags_all(
 			sorting, REF_SORTING_DETACHED_HEAD_FIRST, 1);
-		print_ref_list(&filter, sorting, &format, &output);
+		print_ref_list(&filter, sorting, &format, &output,
+			       &forked_upstreams);
 		print_columns(&output, colopts, NULL);
 		string_list_clear(&output, 0);
 		ref_sorting_release(sorting);
@@ -1020,5 +1158,6 @@ int cmd_branch(int argc,
 
 out:
 	string_list_clear(&sorting_options, 0);
+	string_list_clear(&forked_upstreams, 0);
 	return ret;
 }
diff --git a/ref-filter.c b/ref-filter.c
index 1da4c0e60d..65e7bc6785 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -3035,7 +3035,7 @@ static int filter_one(const struct reference *ref, void *cb_data)
 }
 
 /*  Free memory allocated for a ref_array_item */
-static void free_array_item(struct ref_array_item *item)
+void free_ref_array_item(struct ref_array_item *item)
 {
 	free((char *)item->symref);
 	if (item->value) {
@@ -3078,7 +3078,7 @@ static int filter_and_format_one(const struct reference *ref, void *cb_data)
 
 	strbuf_release(&output);
 	strbuf_release(&err);
-	free_array_item(item);
+	free_ref_array_item(item);
 
 	/*
 	 * Increment the running count of refs that match the filter. If
@@ -3098,7 +3098,7 @@ void ref_array_clear(struct ref_array *array)
 	int i;
 
 	for (i = 0; i < array->nr; i++)
-		free_array_item(array->items[i]);
+		free_ref_array_item(array->items[i]);
 	FREE_AND_NULL(array->items);
 	array->nr = array->alloc = 0;
 
@@ -3171,7 +3171,7 @@ static void reach_filter(struct ref_array *array,
 		if (is_merged == include_reached)
 			array->items[array->nr++] = array->items[i];
 		else
-			free_array_item(item);
+			free_ref_array_item(item);
 	}
 
 	clear_commit_marks_many(old_nr, to_clear, ALL_REV_FLAGS);
@@ -3667,7 +3667,7 @@ void pretty_print_ref(const char *name, const struct object_id *oid,
 
 	strbuf_release(&err);
 	strbuf_release(&output);
-	free_array_item(ref_item);
+	free_ref_array_item(ref_item);
 }
 
 static int parse_sorting_atom(const char *atom)
diff --git a/ref-filter.h b/ref-filter.h
index 120221b47f..3883b9dc62 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -155,6 +155,8 @@ void filter_and_format_refs(struct ref_filter *filter, unsigned int type,
 			    struct ref_format *format);
 /*  Clear all memory allocated to ref_array */
 void ref_array_clear(struct ref_array *array);
+/*  Free a single item from a ref_array */
+void free_ref_array_item(struct ref_array_item *item);
 /*  Used to verify if the given format is correct and to parse out the used atoms */
 int verify_ref_format(struct ref_format *format);
 /*  Sort the given ref_array as per the ref_sorting provided */
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index e7829c2c4b..4e7deddc04 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1717,4 +1717,96 @@ test_expect_success 'errors if given a bad branch name' '
 	test_cmp expect actual
 '
 
+test_expect_success '--forked: setup' '
+	test_create_repo forked-upstream &&
+	test_commit -C forked-upstream base &&
+	git -C forked-upstream branch one base &&
+	git -C forked-upstream branch two base &&
+
+	test_create_repo forked-other &&
+	test_commit -C forked-other other-base &&
+	git -C forked-other branch foreign other-base &&
+
+	git clone forked-upstream forked &&
+	git -C forked remote add other ../forked-other &&
+	git -C forked fetch other &&
+	git -C forked branch local-base &&
+	git -C forked branch --track local-one origin/one &&
+	git -C forked branch --track local-two origin/two &&
+	git -C forked branch --track local-foreign other/foreign &&
+	git -C forked branch detached &&
+	git -C forked branch --track local-trunk local-base
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
+	echo local-trunk >expect &&
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
+	local-trunk
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
+	test_when_finished "git -C forked checkout detached" &&
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
 test_done
-- 
gitgitgadget

