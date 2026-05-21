Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08F233A9DA
	for <git@vger.kernel.org>; Thu, 21 May 2026 22:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779403212; cv=none; b=dc/f4hFv9KlcroBJtUD3ct9On6s0YmAeUPviiAy/uK/sq2s169idoDIQoy0AusZPueBnvNSaI+NGTKCNOq9IMk0p6MWQDHHAo3sKwqpVR3G3JSVkNPnuk7WV9CQt7sSLBBC5cqQqTCGDZuUVQFanILnh/0lDTIq/8dbI97BsmBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779403212; c=relaxed/simple;
	bh=FaO1yn1OLv2f1YuA6g3jcmYGuXwOQ9WEj2onkeyHbiA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZVbDITIIgnKBTqnMzMlOiGaM8bVrikMXtqdJdGnX07KFyiaWM9xnaYgMyaoNwzZWFEraaUkxaLDDwVmrXVoR8JMmnvx9lzMCdotB/7HIMNh66sTbbOBR4w+IHyjziKpZvm7ttE2Knrxh3xGBQOn5U59zTBz/403zahbq/Eq5L24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ichtLWWl; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ichtLWWl"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-134ac81c445so6778756c88.1
        for <git@vger.kernel.org>; Thu, 21 May 2026 15:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779403210; x=1780008010; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3fKukNeJNUX6VXXWXh34fY+zwzdcgex4iY+hJ+RWKQ=;
        b=ichtLWWlTxvsF7rFIrAmfoyjsTSi7Yszy+HnwqOKyVzwo8npWeYOFB1/MRey92Ccf1
         OCQCVUG3Px6g3OkfKnvJD1fCujUgmHgWuBZMXGvrXMyrzsV4yR9XVxuEjtFvh2VfOCr+
         fMUsYQBKcExB6DK5CaO5zTgHXTMKKGNqLrOyBw0iBtTvPzotbSHxLFKD3RThioqqxPU5
         XQV/nA3yGkHdjuD9lpPZOftjLmRoijVjY2obieFWUp5JoDboCA5l3gOtVPLi/NxR0/K7
         wWlGpCiKBXnVaucrbB3T/sf/K86A0mINgopTQQO62kJwniYtugVIuh67Ka4/PNhKjeGY
         Td0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779403210; x=1780008010;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A3fKukNeJNUX6VXXWXh34fY+zwzdcgex4iY+hJ+RWKQ=;
        b=kgig3zvKTrLrlm08h90CBMyBK4ladXNTZEN5zz6WFO7DHL6sqyxCnId25/1bVx2Dt+
         SRIoIrJ769eDTdjU3/nilPL3e+FCWCgPmo84BbMNv130M7nsyY3f+NrZagZAdoacnCCC
         Pl6UzB6bf4hVacTUKgzuQBH27gIYfZFQqdZWRpnzRI9cTr5PAboze15yoYasoWGUkLkN
         YDn80wBWNZ7FMKz62+rd6rC21QjMagCJYOLYUB3+k72meHXzk4mr0gbQgu/YcdOX9N3b
         qx6DJ0wV+f/AVGxKjiJCGuwpQPP/HlVhzK5IectM4+z+Bk3BvW9fF9bZAg6v4ST2aCL9
         54sQ==
X-Gm-Message-State: AOJu0YyepgYadvyLdsRoGrs37pH7wc1CHEKRlEYAhG7ZFpW7KPEnVpwO
	dwbJS5lPcFM9bd1ptb825plpkT9wNFQAHj1iZcEkZZPU6+7/MIH8kChEx2UJQg==
X-Gm-Gg: Acq92OH25I4OliGh+toIMOBdpATbi6zgN0wtOfapneIVTJXiytJwqvXB8z4+vdj6Rd1
	f/NGxj/A5U5iMieLg0Ztu9fWT6JOpGNtjZGANlW1BRqeqQ1ACGR3ZRjAejsKYuhWOxNWJjXsQBg
	Nc4djdJfBujgAH6SfPQRQzYskTmBPMr5CGL5+jHSdijpTAZnE0O9U4zdPYR0hoamBPTDq8CEjWT
	RNDcj1DuI0P8dKwUE8sHIvIVRFoPslSHs3Sd4J6fPB/XXKNyOqF1FEkBF6ilgYSL9snXl7GCkAn
	Qy4jVqcPxMWKx6m8wNF979kCNOfAcvuh5pmZGkpWQUP2NZoNd9K2W6bG/gbsDhtv9lLu/FfrD9D
	ilh09kIdQzz57TMsKs01kZm4GwV3a1FK9j35ZFdxrJOnK6aj7rSEDN3DrNCTIla6Nd2Kgvz08rI
	7vTj5snQhwEtUnxkkFZDR+Toi9JSXRsdVvfSV/Hit1m1dC7Mg=
X-Received: by 2002:a05:7022:f313:b0:12d:b7e5:a67b with SMTP id a92af1059eb24-1365f81e628mr294931c88.14.1779403209911;
        Thu, 21 May 2026 15:40:09 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.62.244])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13662755b25sm344478c88.9.2026.05.21.15.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 15:40:09 -0700 (PDT)
Message-Id: <718e28c7e0120a826385189213cccec1f0fce1af.1779403204.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v10.git.git.1779403204.gitgitgadget@gmail.com>
References: <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
	<pull.2285.v10.git.git.1779403204.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 21 May 2026 22:40:02 +0000
Subject: [PATCH v10 2/4] branch: add --prune-merged <branch>
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

	git branch --prune-merged <branch>...

deletes the local branches that --forked <branch> would list,
but only those whose tip is reachable from their configured
upstream: the work has already landed on the upstream the
branch tracks, so the local copy is no longer needed.

The following branches are always preserved:

* the currently checked-out branch in any worktree;
* any local branch whose name matches the default branch of
  any configured remote (the target of
  refs/remotes/<remote>/HEAD) -- typically 'main' or
  'master';
* any branch whose upstream no longer resolves locally.

Reachability is read from whatever branch.<name>.merge
resolves to locally, which is usually a remote-tracking ref
but may also be a local branch. When the upstream is a
remote-tracking ref, the natural workflow is

	git fetch <remote>
	git branch --prune-merged <upstream-pattern>

so the upstream reflects the current state before pruning.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  21 +++++
 builtin/branch.c              |  93 ++++++++++++++++++++++-
 t/t3200-branch.sh             | 139 ++++++++++++++++++++++++++++++++++
 3 files changed, 249 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 3a421f6663..a7c0e29e94 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -25,6 +25,7 @@ git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
 git branch --forked <branch>...
+git branch --prune-merged <branch>...
 
 DESCRIPTION
 -----------
@@ -206,6 +207,26 @@ This option is only applicable in non-verbose mode.
 	a ref (e.g. `origin/master`, `master`) or a shell-style
 	glob (e.g. `'origin/*'`). Multiple arguments are unioned.
 
+`--prune-merged`::
+	Delete the local branches that `--forked` would list for
+	the same _<branch>_ arguments, but only those whose tip is
+	reachable from their configured upstream.
++
+For arguments that refer to remote-tracking branches, run
+`git fetch` first so reachability is checked against the
+current upstream state; refs are read locally.
++
+The following branches are always preserved:
++
+--
+* the currently checked-out branch in any worktree;
+* any local branch whose name matches the default branch of
+  any configured remote (the target of
+  `refs/remotes/<remote>/HEAD`) -- typically `main` or
+  `master`;
+* any branch whose upstream no longer resolves locally.
+--
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 1e24c95a69..29d38e9060 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -21,6 +21,7 @@
 #include "branch.h"
 #include "path.h"
 #include "string-list.h"
+#include "strvec.h"
 #include "column.h"
 #include "utf8.h"
 #include "ref-filter.h"
@@ -40,6 +41,7 @@ static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--points-at]"),
 	N_("git branch [<options>] [-r | -a] [--format]"),
 	N_("git branch [<options>] --forked <branch>..."),
+	N_("git branch [<options>] --prune-merged <branch>..."),
 	NULL
 };
 
@@ -172,8 +174,8 @@ static int branch_merged(int kind, const char *name,
 	 * any of the following code, but during the transition period,
 	 * a gentle reminder is in order.
 	 */
-	if (head_rev != reference_rev) {
-		int expect = head_rev ? repo_in_merge_bases(the_repository, rev, head_rev) : 0;
+	if (head_rev && head_rev != reference_rev) {
+		int expect = repo_in_merge_bases(the_repository, rev, head_rev);
 		if (expect < 0)
 			exit(128);
 		if (expect == merged)
@@ -748,6 +750,25 @@ static int collect_forked_branch(const struct reference *ref, void *cb_data)
 	return 0;
 }
 
+static int collect_default_branch_name(struct remote *remote, void *cb_data)
+{
+	struct string_list *protected = cb_data;
+	struct ref_store *refs = get_main_ref_store(the_repository);
+	struct strbuf head = STRBUF_INIT;
+	const char *target;
+
+	strbuf_addf(&head, "refs/remotes/%s/HEAD", remote->name);
+	target = refs_resolve_ref_unsafe(refs, head.buf,
+					 RESOLVE_REF_NO_RECURSE, NULL, NULL);
+	if (target) {
+		const char *leaf = strrchr(target, '/');
+		if (leaf)
+			string_list_insert(protected, leaf + 1);
+	}
+	strbuf_release(&head);
+	return 0;
+}
+
 static void collect_forked_set(int argc, const char **argv,
 			       struct string_list *out)
 {
@@ -781,6 +802,63 @@ static int list_forked_branches(int argc, const char **argv)
 	return 0;
 }
 
+static int prune_merged_branches(int argc, const char **argv, int quiet)
+{
+	struct ref_store *refs = get_main_ref_store(the_repository);
+	struct string_list candidates = STRING_LIST_INIT_DUP;
+	struct string_list protected_default_names = STRING_LIST_INIT_DUP;
+	struct strvec deletable = STRVEC_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list_item *item;
+	int n_not_merged = 0;
+	int ret = 0;
+
+	if (!argc)
+		die(_("--prune-merged requires at least one <branch>"));
+
+	collect_forked_set(argc, argv, &candidates);
+	for_each_remote(collect_default_branch_name, &protected_default_names);
+
+	for_each_string_list_item(item, &candidates) {
+		const char *short_name = item->string;
+		const char *upstream = item->util;
+
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "refs/heads/%s", short_name);
+		if (branch_checked_out(buf.buf))
+			continue;
+
+		if (string_list_has_string(&protected_default_names,
+					   short_name))
+			continue;
+
+		if (!refs_ref_exists(refs, upstream))
+			continue;
+
+		strvec_push(&deletable, short_name);
+	}
+	strbuf_release(&buf);
+
+	if (deletable.nr)
+		ret = delete_branches(deletable.nr, deletable.v,
+				      0, FILTER_REFS_BRANCHES, quiet,
+				      1, &n_not_merged);
+
+	if (n_not_merged && !quiet)
+		fprintf(stderr,
+			Q_("Skipped %d branch that is not fully merged; "
+			   "delete it with 'git branch -D' if you are sure.\n",
+			   "Skipped %d branches that are not fully merged; "
+			   "delete them with 'git branch -D' if you are sure.\n",
+			   n_not_merged),
+			n_not_merged);
+
+	strvec_clear(&deletable);
+	string_list_clear(&candidates, 1);
+	string_list_clear(&protected_default_names, 0);
+	return ret;
+}
+
 static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
 
 static int edit_branch_description(const char *branch_name)
@@ -823,6 +901,7 @@ int cmd_branch(int argc,
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	int forked = 0;
+	int prune_merged = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -878,6 +957,8 @@ int cmd_branch(int argc,
 			 N_("edit the description for the branch")),
 		OPT_BOOL(0, "forked", &forked,
 			N_("list local branches whose upstream matches the given <branch>...")),
+		OPT_BOOL(0, "prune-merged", &prune_merged,
+			N_("delete local branches whose upstream matches the given <branch>... and that are merged into it")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -922,7 +1003,8 @@ int cmd_branch(int argc,
 			     0);
 
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
-	    !show_current && !unset_upstream && !forked && argc == 0)
+	    !show_current && !unset_upstream && !forked && !prune_merged &&
+	    argc == 0)
 		list = 1;
 
 	if (filter.with_commit || filter.no_commit ||
@@ -931,7 +1013,7 @@ int cmd_branch(int argc,
 
 	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
 			    !!show_current + !!list + !!edit_description +
-			    !!unset_upstream + !!forked;
+			    !!unset_upstream + !!forked + !!prune_merged;
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
@@ -975,6 +1057,9 @@ int cmd_branch(int argc,
 	} else if (forked) {
 		ret = list_forked_branches(argc, argv);
 		goto out;
+	} else if (prune_merged) {
+		ret = prune_merged_branches(argc, argv, quiet);
+		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
 		ret = 0;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 45455cb8ce..c8589cd3a6 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1798,4 +1798,143 @@ test_expect_success '--forked requires at least one <branch>' '
 	test_grep "at least one <branch>" err
 '
 
+test_expect_success '--prune-merged: setup' '
+	test_create_repo pm-upstream &&
+	test_commit -C pm-upstream base &&
+	git -C pm-upstream checkout -b next &&
+	test_commit -C pm-upstream one-commit &&
+	test_commit -C pm-upstream two-commit &&
+	git -C pm-upstream branch one HEAD~ &&
+	git -C pm-upstream branch two HEAD &&
+	git -C pm-upstream branch wip main &&
+	git -C pm-upstream checkout main
+'
+
+test_expect_success '--prune-merged deletes branches integrated into upstream' '
+	test_when_finished "rm -rf pm-merged" &&
+	git clone pm-upstream pm-merged &&
+	git -C pm-merged branch one one-commit &&
+	git -C pm-merged branch --set-upstream-to=origin/next one &&
+	git -C pm-merged branch two two-commit &&
+	git -C pm-merged branch --set-upstream-to=origin/next two &&
+
+	git -C pm-merged branch --prune-merged "origin/*" &&
+
+	test_must_fail git -C pm-merged rev-parse --verify refs/heads/one &&
+	test_must_fail git -C pm-merged rev-parse --verify refs/heads/two
+'
+
+test_expect_success '--prune-merged with a literal upstream argument' '
+	test_when_finished "rm -rf pm-literal" &&
+	git clone pm-upstream pm-literal &&
+	git -C pm-literal branch one one-commit &&
+	git -C pm-literal branch --set-upstream-to=origin/next one &&
+	git -C pm-literal branch keepme one-commit &&
+	git -C pm-literal branch --set-upstream-to=origin/main keepme &&
+
+	git -C pm-literal branch --prune-merged origin/next &&
+
+	test_must_fail git -C pm-literal rev-parse --verify refs/heads/one &&
+	git -C pm-literal rev-parse --verify refs/heads/keepme
+'
+
+test_expect_success '--prune-merged unions multiple <branch> arguments' '
+	test_when_finished "rm -rf pm-union" &&
+	git clone pm-upstream pm-union &&
+	git -C pm-union branch one one-commit &&
+	git -C pm-union branch --set-upstream-to=origin/next one &&
+	git -C pm-union branch two base &&
+	git -C pm-union branch --set-upstream-to=origin/main two &&
+
+	git -C pm-union branch --prune-merged origin/next origin/main &&
+
+	test_must_fail git -C pm-union rev-parse --verify refs/heads/one &&
+	test_must_fail git -C pm-union rev-parse --verify refs/heads/two
+'
+
+test_expect_success '--prune-merged with a local-branch argument' '
+	test_create_repo pm-local &&
+	test_when_finished "rm -rf pm-local" &&
+	test_commit -C pm-local base &&
+	git -C pm-local branch topic base &&
+	git -C pm-local config branch.topic.remote . &&
+	git -C pm-local config branch.topic.merge refs/heads/main &&
+	git -C pm-local checkout --detach &&
+
+	git -C pm-local branch --prune-merged main &&
+
+	test_must_fail git -C pm-local rev-parse --verify refs/heads/topic &&
+	git -C pm-local rev-parse --verify refs/heads/main
+'
+
+test_expect_success '--prune-merged spares branches with un-integrated commits' '
+	test_when_finished "rm -rf pm-unmerged" &&
+	git clone pm-upstream pm-unmerged &&
+	git -C pm-unmerged checkout -b wip origin/wip &&
+	git -C pm-unmerged branch --set-upstream-to=origin/next wip &&
+	test_commit -C pm-unmerged local-only &&
+	git -C pm-unmerged checkout - &&
+
+	git -C pm-unmerged branch --prune-merged "origin/*" 2>err &&
+	test_grep "not fully merged" err &&
+	test_grep "Skipped 1 branch" err &&
+	test_grep "git branch -D" err &&
+	test_grep ! "If you are sure you want to delete it" err &&
+	git -C pm-unmerged rev-parse --verify refs/heads/wip
+'
+
+test_expect_success '--prune-merged skips branches whose upstream is gone' '
+	test_when_finished "rm -rf pm-upstream-gone" &&
+	git clone pm-upstream pm-upstream-gone &&
+	git -C pm-upstream-gone branch one one-commit &&
+	git -C pm-upstream-gone branch --set-upstream-to=origin/next one &&
+
+	git -C pm-upstream-gone update-ref -d refs/remotes/origin/next &&
+	git -C pm-upstream-gone branch --prune-merged "origin/*" &&
+
+	git -C pm-upstream-gone rev-parse --verify refs/heads/one
+'
+
+test_expect_success '--prune-merged never deletes the checked-out branch' '
+	test_when_finished "rm -rf pm-head" &&
+	git clone pm-upstream pm-head &&
+	git -C pm-head checkout -b one one-commit &&
+	git -C pm-head branch --set-upstream-to=origin/next one &&
+
+	git -C pm-head branch --prune-merged "origin/*" &&
+
+	git -C pm-head rev-parse --verify refs/heads/one
+'
+
+test_expect_success '--prune-merged spares the local default branch' '
+	test_when_finished "rm -rf pm-default" &&
+	git clone pm-upstream pm-default &&
+	git -C pm-default checkout --detach &&
+	git -C pm-default branch --prune-merged "origin/*" &&
+	git -C pm-default rev-parse --verify refs/heads/main
+'
+
+test_expect_success '--prune-merged protects the default branch by name only' '
+	test_when_finished "rm -rf pm-default-alias" &&
+	git clone pm-upstream pm-default-alias &&
+	git -C pm-default-alias branch --track trunk origin/main &&
+	git -C pm-default-alias checkout --detach &&
+	git -C pm-default-alias branch --prune-merged "origin/*" &&
+	git -C pm-default-alias rev-parse --verify refs/heads/main &&
+	test_must_fail git -C pm-default-alias rev-parse --verify refs/heads/trunk
+'
+
+test_expect_success '--prune-merged with literal arg also protects default-name' '
+	test_when_finished "rm -rf pm-literal-default" &&
+	git clone pm-upstream pm-literal-default &&
+	git -C pm-literal-default checkout --detach &&
+	git -C pm-literal-default branch --prune-merged origin/main &&
+	git -C pm-literal-default rev-parse --verify refs/heads/main
+'
+
+test_expect_success '--prune-merged requires at least one <branch>' '
+	test_must_fail git -C pm-upstream branch --prune-merged 2>err &&
+	test_grep "at least one <branch>" err
+'
+
 test_done
-- 
gitgitgadget

