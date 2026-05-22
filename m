Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7130C3E5A39
	for <git@vger.kernel.org>; Fri, 22 May 2026 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779449513; cv=none; b=H1UH4QXFi/X99wdpQ6jpeFqHK0+gk3+esVeRTWTP/Q7OzjOEMhzfO9HmjK9nsZYz9JN1/9/4DRj86vPAOZzid45ICkTKtgKrt2AUhz3xhqs820jzbKUTRxZbaSdPuQLvm4MLWwGHjqjrqWNGzs+nr6fIDATcKNUz5qzgWjjUMoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779449513; c=relaxed/simple;
	bh=rdZovhW98Tr1omfa2xE7XGHO8+teILy6HEOfQmlrvoU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cLfObOd2UZbX7dd/DbVYpWiExAKWUhSdjs8MFJg6WmgSfvhYdg++PgpILFORR/lRYKwMIktzUZngZ6gMm9WvZj0N9ygAuzJ3PS1azmDKEGxM2y8xP0wiRyN9B912qKsyMa7pvAd/v4UidXTfnlwXYnE6hNG3ETQr+Rh2aXeEShY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSQe0WHa; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSQe0WHa"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5165195c8b0so79721861cf.0
        for <git@vger.kernel.org>; Fri, 22 May 2026 04:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779449502; x=1780054302; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2XNRF8mrENkSftqBTiHoSZcJGXBOHNX+J5tREf7KGQ=;
        b=hSQe0WHaHy9tv44xIso2YOsCFkHlRmjtHmTKucUgQ8j7NJ9rGG83rEBlfP4Mg08al2
         FziFuMHwgLyK7faf0B7txVGAJ8G3Fd6iwYAQa3/gENFfm0C4NsJn8ArwcppG+/fOyMED
         Pctmj5u37IriTC7z0Vl2dN4PPHj9GCxtaAGkFmTBvq5Xn2SBbnv17jdVdoyT4GiD3MKx
         bdxlJwrz1uq5I3yPw0kNvhDWdteY1whUPTuMKhykM/+QZkHsjOZISSst9zCo3G3TWopc
         YHz3lb97k73Q+/ce6mooLlpVmcnBFbaLv0z8/fpq4FmTBq0RsU38VUYdn9Z0BweJ6TfB
         ASMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779449502; x=1780054302;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V2XNRF8mrENkSftqBTiHoSZcJGXBOHNX+J5tREf7KGQ=;
        b=lx3SSUawVqEUH7BubCoWTnMqYY6PKw0rGZdj6qFksm0czNRem8AfqyTcfXQTBQXsjm
         8B8180Gm8UhV5Pu8McNwMrROVUFY+ys0Do9JqNO0QDls//69sB5rC6GJ6HqDwPMtZUxU
         bZkGHUxU/K6UG+hT68HpapW2q4USago6oE2VUwSR3cp+YQz1WDLJH3SA1C9yXwWjCcz+
         rpRU20My7HIPs5soxbsXsPG3b94L9eYE4/PikLyONu99bNiDaWBGnua7zUHbSaI5FwP1
         lkEPVwYpnmPzmdndu9qKTUu2N14RvCS6KGJpuXuEiuRLsOiQqTSCcg9qewsmYeH4ZzvT
         1NZw==
X-Gm-Message-State: AOJu0Yxd5Qt8+n5+/1FyBtDOVgszHwS0o5J3Vc5nhJVWHHs+JPPpqOGq
	KyIA2C8S3PMY5ZRjEIa6P/hFHfAuw5M+vB8ikfHHww2cewmG5+sUQI+dTd5z4Z52
X-Gm-Gg: Acq92OFzOhiLQndZCfbhZL+GRv3RvJ0rYEsnAwtynOAsnYOti44lbi7GzpGoz2Je4Gv
	GaJ5WafVNtz4ZU7Gaumqb5lOOUPTkbfSpjvKJnZ/Ef8+OmPlWYpVZ55TFqCi3iD5Wy6ryMVC45T
	hBN++0fAf+VewWYjXSupmfN9Cb64oV7fxAVPKrNcvypQTTFrYzSd7H0XW68OQ4/p1DobIJRRKwI
	sZq0TOnS07zWjhsG74IfzuuPiec1wJeWgPO3cwbK9KATMS4cz2rlau3kZ/4rAoRazRMGt+rzwsC
	3BZet5AT+XI4G9ltwJGVgO/Z/kqYCzDJaSwYKOxTHuqKj2goKR1CYO6JQ8f5a12A9O+39DZoqIO
	cLDa7q/ApWUwT8KENiQHZphgzim3sGoDANnYVwiwqIf+10M3YQeYeUTKzFLqFKxMQz8SYD84WoC
	tSoSUAPTHaZ6xUTzPuqBWjCyAszw==
X-Received: by 2002:ac8:58d4:0:b0:50d:8bf2:45cd with SMTP id d75a77b69052e-516d45920bdmr43749191cf.34.1779449501800;
        Fri, 22 May 2026 04:31:41 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.47.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8d27abbsm11003861cf.31.2026.05.22.04.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 04:31:41 -0700 (PDT)
Message-Id: <b9fddd124afc55ad05bd4c85b060cad5e4833cc8.1779449498.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v11.git.git.1779449498.gitgitgadget@gmail.com>
References: <pull.2285.v10.git.git.1779403204.gitgitgadget@gmail.com>
	<pull.2285.v11.git.git.1779449498.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 11:31:33 +0000
Subject: [PATCH v11 1/6] branch: add --forked <branch>
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

List local branches whose configured upstream
(branch.<name>.merge resolved against branch.<name>.remote)
matches any of the given <branch> arguments.

Each <branch> is interpreted against the local repository, not
against any specific remote:

  * a literal upstream short name, e.g. "origin/main" or "master"
    for a branch whose upstream is local;
  * a wildmatch pattern, e.g. "origin/*";
  * a bare configured-remote name, e.g. "origin", which resolves
    to whatever refs/remotes/origin/HEAD points at, matching how
    "git checkout -b topic origin" picks a starting point.

The literal-vs-wildcard distinction is settled at parse time so
the per-branch matching loop calls wildmatch() only for genuine
wildcards. Multiple <branch> arguments are unioned. Output is
sorted by branch name.

This is the building block for --prune-merged, which deletes the
listed branches once they have landed on their upstream.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  13 +++
 builtin/branch.c              | 168 +++++++++++++++++++++++++++++++++-
 t/t3200-branch.sh             |  90 ++++++++++++++++++
 3 files changed, 269 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index c0afddc424..a37d3a12cb 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -24,6 +24,7 @@ git branch (-m|-M) [<old-branch>] <new-branch>
 git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
+git branch --forked <branch>...
 
 DESCRIPTION
 -----------
@@ -199,6 +200,18 @@ This option is only applicable in non-verbose mode.
 	Print the name of the current branch. In detached `HEAD` state,
 	nothing is printed.
 
+`--forked`::
+	List local branches whose configured upstream
+	(`branch.<name>.merge` resolved against `branch.<name>.remote`)
+	matches any of the given _<branch>_ arguments.
++
+Each _<branch>_ is interpreted against the local repository: a literal
+upstream like `origin/main` or a local branch like `master`, or a
+wildmatch pattern like `'origin/*'`.  A bare configured-remote name
+(e.g. `origin`) resolves to the target of `refs/remotes/<remote>/HEAD`,
+to match the way `git checkout -b topic origin` picks a starting
+point.  Multiple _<branch>_ arguments are unioned.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 1572a4f9ef..2d34ad34dc 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -28,6 +28,7 @@
 #include "help.h"
 #include "advice.h"
 #include "commit-reach.h"
+#include "wildmatch.h"
 
 static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged]"),
@@ -38,6 +39,7 @@ static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
 	N_("git branch [<options>] [-r | -a] [--points-at]"),
 	N_("git branch [<options>] [-r | -a] [--format]"),
+	N_("git branch [<options>] --forked <branch>..."),
 	NULL
 };
 
@@ -673,6 +675,162 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
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
+	struct ref_store *refs = get_main_ref_store(the_repository);
+	struct remote *remote;
+	struct object_id oid;
+	char *full_ref = NULL;
+	struct strbuf head_ref = STRBUF_INIT;
+	const char *resolved;
+
+	if (has_glob_specials(arg)) {
+		out->name = xstrdup(arg);
+		out->is_wildcard = 1;
+		return 0;
+	}
+
+	remote = remote_get(arg);
+	if (remote && remote_is_configured(remote, 0)) {
+		strbuf_addf(&head_ref, "refs/remotes/%s/HEAD", remote->name);
+		resolved = refs_resolve_ref_unsafe(refs, head_ref.buf,
+						   RESOLVE_REF_NO_RECURSE,
+						   NULL, NULL);
+		if (resolved && starts_with(resolved, "refs/remotes/")) {
+			out->name = xstrdup(short_upstream_name(resolved));
+			out->is_wildcard = 0;
+			strbuf_release(&head_ref);
+			return 0;
+		}
+		strbuf_release(&head_ref);
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
+static void parse_forked_args(int argc, const char **argv,
+			      struct upstream_pattern **patterns_out,
+			      size_t *nr_out)
+{
+	struct upstream_pattern *patterns;
+	int i;
+
+	ALLOC_ARRAY(patterns, argc);
+	for (i = 0; i < argc; i++) {
+		if (parse_one_forked_arg(argv[i], &patterns[i]) < 0) {
+			upstream_pattern_list_clear(patterns, i);
+			die(_("'%s' is not a valid branch or pattern"),
+			    argv[i]);
+		}
+	}
+	*patterns_out = patterns;
+	*nr_out = argc;
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
+struct forked_cb {
+	const struct upstream_pattern *patterns;
+	size_t nr_patterns;
+	struct string_list *out;
+};
+
+static int collect_forked_branch(const struct reference *ref, void *cb_data)
+{
+	struct forked_cb *cb = cb_data;
+	struct branch *branch;
+	const char *upstream;
+
+	if (ref->flags & REF_ISSYMREF)
+		return 0;
+	branch = branch_get(ref->name);
+	if (!branch)
+		return 0;
+	upstream = branch_get_upstream(branch, NULL);
+	if (!upstream)
+		return 0;
+	if (upstream_matches(short_upstream_name(upstream),
+			     cb->patterns, cb->nr_patterns))
+		string_list_append(cb->out, ref->name);
+	return 0;
+}
+
+static int list_forked_branches(int argc, const char **argv)
+{
+	struct upstream_pattern *patterns = NULL;
+	size_t nr_patterns = 0;
+	struct string_list out = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+	struct forked_cb cb;
+
+	if (!argc)
+		die(_("--forked requires at least one <branch>"));
+
+	parse_forked_args(argc, argv, &patterns, &nr_patterns);
+	cb.patterns = patterns;
+	cb.nr_patterns = nr_patterns;
+	cb.out = &out;
+
+	refs_for_each_branch_ref(get_main_ref_store(the_repository),
+				 collect_forked_branch, &cb);
+
+	string_list_sort(&out);
+	for_each_string_list_item(item, &out)
+		puts(item->string);
+
+	upstream_pattern_list_clear(patterns, nr_patterns);
+	string_list_clear(&out, 0);
+	return 0;
+}
+
 static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
 
 static int edit_branch_description(const char *branch_name)
@@ -714,6 +872,7 @@ int cmd_branch(int argc,
 	/* possible actions */
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
+	int forked = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -767,6 +926,8 @@ int cmd_branch(int argc,
 		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
+		OPT_BOOL(0, "forked", &forked,
+			N_("list local branches whose upstream matches the given <branch>...")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -811,7 +972,7 @@ int cmd_branch(int argc,
 			     0);
 
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
-	    !show_current && !unset_upstream && argc == 0)
+	    !show_current && !unset_upstream && !forked && argc == 0)
 		list = 1;
 
 	if (filter.with_commit || filter.no_commit ||
@@ -820,7 +981,7 @@ int cmd_branch(int argc,
 
 	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
 			    !!show_current + !!list + !!edit_description +
-			    !!unset_upstream;
+			    !!unset_upstream + !!forked;
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
@@ -860,6 +1021,9 @@ int cmd_branch(int argc,
 			die(_("branch name required"));
 		ret = delete_branches(argc, argv, delete > 1, filter.kind, quiet);
 		goto out;
+	} else if (forked) {
+		ret = list_forked_branches(argc, argv);
+		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
 		ret = 0;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index e7829c2c4b..013ddfb65d 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1717,4 +1717,94 @@ test_expect_success 'errors if given a bad branch name' '
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
+test_expect_success '--forked <upstream-tracking-branch> lists matching branches' '
+	git -C forked branch --forked origin/one >actual &&
+	echo local-one >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--forked <glob> matches by wildmatch' '
+	git -C forked branch --forked "origin/*" >actual &&
+	cat >expect <<-\EOF &&
+	local-one
+	local-two
+	main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--forked <local-branch> matches branches with local upstream' '
+	git -C forked branch --forked local-base >actual &&
+	echo local-trunk >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--forked <remote> resolves via refs/remotes/<remote>/HEAD' '
+	test_when_finished "git -C forked symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/main" &&
+	git -C forked symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/one &&
+	git -C forked branch --forked origin >actual &&
+	echo local-one >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--forked unions multiple <branch> arguments' '
+	git -C forked branch --forked origin/one other/foreign >actual &&
+	cat >expect <<-\EOF &&
+	local-foreign
+	local-one
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--forked combines literal and glob arguments' '
+	git -C forked branch --forked local-base "other/*" >actual &&
+	cat >expect <<-\EOF &&
+	local-foreign
+	local-trunk
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--forked "*/*" covers every remote-tracking upstream' '
+	git -C forked branch --forked "*/*" >actual &&
+	cat >expect <<-\EOF &&
+	local-foreign
+	local-one
+	local-two
+	main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--forked rejects unknown branch/pattern' '
+	test_must_fail git -C forked branch --forked nope 2>err &&
+	test_grep "not a valid branch or pattern" err
+'
+
+test_expect_success '--forked requires at least one <branch>' '
+	test_must_fail git -C forked branch --forked 2>err &&
+	test_grep "at least one <branch>" err
+'
+
 test_done
-- 
gitgitgadget

