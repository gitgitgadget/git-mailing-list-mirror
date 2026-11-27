Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795800780;
	b=lXVQRlmAwch+RRzGjkMEOSegY7eSVCJBRBC9YuN4CFQr22eWaBtje0bWugQQFVjK2JTI
	 TMim+F3t5IKLkPSTZRyl/6TlBTQoEXHLnPd9fDIgSQ3Hgq5QXEnMTBs5fmrfiY/tkYtgT
	 7ZCgA8IZY374VThYLFjlmdqHcIVKIcQBT8VdhVxpmP7itQYonZdD9blVrEiUL2CD8up7J
	 x4yvZBIUD0LSIqJ3n9cxM09AhqBy+GzPxTCvzMebqFnqueW0fFkk2cIk80IOkqLkIaoSx
	 dYzJiqmsJwt4jRtQUVgQLs4SxFM5eC0kPojLu1FWmAtzKwvE1970J9niBEik6YVOVkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795800780;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UxvsbRDQoKwm1eeaTGnKsDKmPB0xQT5/8mcXqoI67O4=;
	b=PjasicbRZ/XgVqycIm/2S2/r6/3ZA2hmb69UvHQDsvuO7qmrT6GbC20y09vvMKG3vU6A
	 h8w2HSUnUmRIAPqAEaItUChulkUQgWE26kxkO6Nk9ZwO5FEsL5iiUpUB84UonkOsm6srq
	 vAZzarWL7wWvCVaq2NVumcTFTFu1fA9IUexMiqZESnx2vYHNxQw4L44mCb21FphsGyK13
	 3HNnd04KyzEYN1TuLotzBQ1zAyHZ4KAZ47An5p9U+DjJi8hQ8uvVX7cX8uMmIvyi6Ls44
	 OtHnJB590OIk92uSmz+busBcrexVhz3n8n6E6iQINdpctZ3pjgQdZT+LabrmxXs2S1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bD9MSAMt;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E35606A31C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 17:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8E35606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bD9MSAMt
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1aefd1bf74aso4707221c88.1
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 09:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795800779; x=1796405579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UxvsbRDQoKwm1eeaTGnKsDKmPB0xQT5/8mcXqoI67O4=;
        b=bD9MSAMt5B8a0E4DAhKrKt6haX1hg1j+nm7yzS/y7kzINpo+WPl6uJOINyAvN+KZwx
         OxDRKiYWsHareSZUfNb20J3G+Mlv+bOcUwwdQVSiyOxdwcaOoTFGTKeooX4Io8gbh/uD
         1+H7Bp/3fJLd2kRR9OEarSH9we1Y32fEtoQXA+9hi4SFrpay3k2ReHZiufRNQl8FD96P
         S6USQr2GMMx9efLcJwEwZ7DODL5Y3lV+hbJmgj0p3TDaUpa0kWJ2jk0ynM/Ukzg7qg1c
         njnoDtcwj+J5TPgrjYwTbnBxsTVaSnhxHk8CAzm9hEWLxv8FUE8zRLj8pW2yxHVlL7yV
         aENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795800779; x=1796405579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UxvsbRDQoKwm1eeaTGnKsDKmPB0xQT5/8mcXqoI67O4=;
        b=i+q1eW/OLBxzIepxOYnY8DqLoHZ2oWBL6lyj8LVbd7NboJeip4hnNWvR1+E0MTdeuw
         B+QVMfLtJ1zWpRtrqU8sauNnTyDOlshJRZvlpq542HNXVQ9/j2rKLWkeVggs2xhkA5o+
         ltesUyaqs3DdDUjQN6YrDzC30vnBKDnZ3rtNTBINqSCke9XT9P6RD8jKZ6ffYpgKQ840
         OmKgSimHgZc3+c8XVLCWlSzwasKgtPHIYglTINe21VL6KCOHxaUnbTGMhAzZaQ6S7g6m
         lla3W81ydx2arVUFycRTKXiPd3lXwfSy4ZmwWioPdP0rKLVtoXYfzKudD0q1BYBNcDiR
         zcOA==
X-Gm-Message-State: APuU4Z8TL1o0Z3BIwapPshImiRdR+fKw4g7c4Z3fE5YpVtAJ1ykMzDLp
	B6mwkHmRbxtKsLcl2oY4ukVTLa/7PB7KVZ3DSrF29ASdzMCsyjdeH6MnLIbQmNkUZz0=
X-Gm-Gg: AZFdTZc8SbF8JMesFTSPrWmk+rjdz10p6VFLINWYYoyMzIebmH6sWuPY9FX8+bzLYc0
	pM764nEOcohVUKAMvyGDyOc6sr1zEProK+NSkzPzDgMcXJEs4294nlWsPoCsoQ2n0N5HcT1L2zc
	4VF/lGK0I8WLX0EIgcZzYMvy96Ma8SST0SWR74wrvg+0PyHuFFuDqxxdHfnm7dO/FjnCEGOAjrj
	oJgx0J6ZIWN+/jSmaK8OeCTEEKwSFGSR282xpbak7pBkopHbusJ/ezXnhyz0B6cAACorrBv9/Yd
	3oHJ8w8bQzAabJjhSS/fYz0OQd8dH1vC6ad8hnKD7yyNYeSw9FZQQt2l/OMUWOdUIIqlZUudwES
	u8of/wIKK9yZLqUDvSNofEMR56N5p0vUzFs+vLp9sT8bW1XvF9wRFmVaMRUZrQba6WrIw525liB
	m8erH635VdPfaczKK2KzGlZ2bDOqU72vnkp0/vEeW14RIFMiqk6x91c/rQnXhJ+TSjgTQ9S0+OY
	I3IVQw0t6hDfEz9D5JC3l90F6GJQ/bhJgC0pKDXeFwCzbs4ys8IRAHmm+lLCuQ8E83YrCDTgS9h
	QihemElXP1DjFDUphCM3Krx8bwf82uzR1T2c93bOaJCpcQvSwRxkLR+/IBW3Y2yBYtJml8/iBsi
	N6B11DmG+it38vS1q14ew
X-Received: by 2002:a05:7022:f90b:b0:1b2:6d4d:9d8a with SMTP id a92af1059eb24-1b56f36d5fbmr15994249c88.2.1795800778645;
        Fri, 27 Nov 2026 09:32:58 -0800 (PST)
Received: from localhost.localdomain ([223.190.84.94])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55681301asm58548162c88.8.2026.11.27.09.32.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Nov 2026 09:32:58 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Toon Claes <toon@iotcl.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Nikita Bobko <nikita@nbobko.com>
Subject: [PATCH v2] history: refuse to rewrite branches used by other worktrees
Date: Fri, 27 Nov 2026 23:02:52 +0530
Message-ID: <20261127173252.7794-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123103911.98860-1-aniketgupta3001@gmail.com>
References: <20261123103911.98860-1-aniketgupta3001@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default "git history" rewrites every local branch that descends from
the commit it changes. If another worktree has such a branch checked
out, the branch moves but the index and working tree of that worktree
stay behind, so it shows the rewrite as staged changes. If the current
worktree is in the middle of rebasing the branch, "git rebase
--continue" later fails because the branch is not where the rebase
expects it.

"git branch -f" refuses to move such branches and "git rebase
--update-refs" skips them. Do the same here: before replaying anything
look for local branches that contain the commit and are used by a
worktree and refuse to go on if there is one. Use branch_checked_out()
so that a branch that is being rebased or bisected, in any worktree,
counts as used. Updating clean worktrees would be another way, but
refusing is simpler. Refuse with --dry-run as well because it will show
what a real run will do.

The branch that the current worktree has checked out is fine, since the
command already takes care of the index and working tree of that
worktree: "drop" updates them, "reword", "split" and "squash" keep the
tree of the tip, and "fixup" takes the staged changes. A bare repository
has no such worktree, and branch_checked_out() records only one worktree
per branch, so ask the other worktrees whether they use the branch
instead of skipping it by name. --update-refs=head refuses in the same
cases.

Refuse to rewrite HEAD while a rebase is in progress, with either
--update-refs mode, since "git rebase --abort" would throw the result
away.

Mention --update-refs=head, which leaves the other branches alone, with
the existing advice.historyUpdateRefs hint.

Reported-by: Toon Claes <toon@iotcl.com>
Reported-by: Nikita Bobko <nikita@nbobko.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Aniket Gupta <aniketgupta3001@gmail.com>
---
Changes in v2:

 - Check the branch of the current worktree against the other
   worktrees instead of skipping it by name. This fixes a bare
   repository and a branch that two worktrees have checked out (Junio,
   Phillip).
 - Find the branches with the decorations of the revision walk instead
   of a second walk (Phillip).
 - Refuse to rewrite HEAD while a rebase is in progress (Phillip).
 - Reword the log message and advice.adoc.

 Documentation/config/advice.adoc |   7 +-
 Documentation/git-history.adoc   |   7 +
 builtin/history.c                | 144 ++++++++++++++++-
 t/t3450-history.sh               | 265 +++++++++++++++++++++++++++++++
 4 files changed, 413 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/advice.adoc b/Documentation/config/advice.adoc
index 3d91c90eda..65f3ff0e02 100644
--- a/Documentation/config/advice.adoc
+++ b/Documentation/config/advice.adoc
@@ -60,9 +60,10 @@ all advice messages.
 		Shown when the user tries to delete a not fully merged
 		branch without the force option set.
 	historyUpdateRefs::
-		Shown when `git history squash` refuses because a local branch
-		cannot be rewritten as a descendant of the squashed commit, to
-		tell the user about `--update-refs=head`.
+		Shown when `git history` refuses to run because a local branch is
+		used by another worktree, or, for `squash`, because it cannot be
+		rewritten as a descendant of the squashed commit, to tell the
+		user about `--update-refs=head`.
 	ignoredHook::
 		Shown when a hook is ignored because the hook is not
 		set as executable.
diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 1fcc30150a..243817d28a 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -215,6 +215,13 @@ empty.
 	`branches`, all local branches that point to commits which are
 	descendants of the original commit will be rewritten. With `head`, only
 	the current `HEAD` reference will be rewritten. Defaults to `branches`.
++
+A branch that is used by another worktree, or that the current worktree is
+in the middle of rebasing or bisecting, cannot be rewritten, as the index and
+working tree of that worktree would not match the rewritten branch. With
+`branches` the command refuses in that case, so use `head` to rewrite only
+the current branch. The command refuses to rewrite `HEAD` while a rebase
+is in progress in the current worktree.
 
 EXAMPLES
 --------
diff --git a/builtin/history.c b/builtin/history.c
index 43ba76f5a1..d0a3287c1d 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -2,6 +2,7 @@
 
 #include "builtin.h"
 #include "advice.h"
+#include "branch.h"
 #include "cache-tree.h"
 #include "commit.h"
 #include "commit-reach.h"
@@ -11,6 +12,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
+#include "log-tree.h"
 #include "merge-ort.h"
 #include "oidmap.h"
 #include "parse-options.h"
@@ -27,6 +29,7 @@
 #include "tree.h"
 #include "tree-walk.h"
 #include "unpack-trees.h"
+#include "worktree.h"
 #include "wt-status.h"
 
 #define GIT_HISTORY_DROP_USAGE \
@@ -260,15 +263,100 @@ static int parse_ref_action(const struct option *opt, const char *value, int uns
 	return 0;
 }
 
-static int revwalk_contains_merges(struct repository *repo,
-				   const struct strvec *revwalk_args)
+/*
+ * Return the path of the worktree that uses "refname", if rewriting it would
+ * leave the index and working tree of that worktree behind. The branch that
+ * the current worktree has checked out is fine, unless another worktree has
+ * it checked out as well.
+ */
+static char *branch_used_elsewhere(struct repository *repo,
+				   const char *refname,
+				   const char *head_target)
+{
+	char *path = NULL;
+
+	if (head_target && !strcmp(refname, head_target)) {
+		struct worktree **worktrees = get_worktrees(repo);
+
+		for (int i = 0; worktrees[i]; i++) {
+			if (!worktrees[i]->is_current &&
+			    is_shared_symref(worktrees[i], "HEAD", refname)) {
+				path = xstrdup(worktrees[i]->path);
+				break;
+			}
+		}
+		free_worktrees(worktrees);
+	} else {
+		const char *checked_out = branch_checked_out(refname);
+
+		if (checked_out)
+			path = xstrdup(checked_out);
+	}
+
+	return path;
+}
+
+/* "git rebase --abort" would throw away a rewrite of the detached HEAD. */
+static bool rebase_in_progress(struct repository *repo)
+{
+	struct worktree **worktrees = get_worktrees(repo);
+	struct wt_status_state state = { 0 };
+	bool ret = false;
+
+	for (int i = 0; worktrees[i]; i++) {
+		if (worktrees[i]->is_current) {
+			wt_status_check_rebase(worktrees[i], &state);
+			ret = state.rebase_in_progress ||
+			      state.rebase_interactive_in_progress;
+			break;
+		}
+	}
+
+	wt_status_state_free_buffers(&state);
+	free_worktrees(worktrees);
+	return ret;
+}
+
+static void collect_used_branches(struct repository *repo,
+				  const struct commit *commit,
+				  const char *head_target,
+				  struct string_list *used,
+				  bool *rewrites_head)
 {
+	const struct name_decoration *decoration;
+
+	for (decoration = get_name_decoration(&commit->object);
+	     decoration;
+	     decoration = decoration->next) {
+		char *path;
+
+		if (decoration->type == DECORATION_REF_HEAD)
+			*rewrites_head = true;
+		if (decoration->type != DECORATION_REF_LOCAL)
+			continue;
+		path = branch_used_elsewhere(repo, decoration->name, head_target);
+		if (path)
+			string_list_append(used, decoration->name)->util = path;
+	}
+}
+
+static int validate_revwalk(struct repository *repo,
+			    enum ref_action action,
+			    struct commit *original,
+			    const struct strvec *revwalk_args)
+{
+	struct string_list used = STRING_LIST_INIT_DUP;
 	struct strvec args = STRVEC_INIT;
 	struct rev_info revs;
+	struct commit *commit;
+	bool rewrites_head = action == REF_ACTION_HEAD;
+	char *head_target;
 	int ret;
 
+	head_target = refs_resolve_refdup(get_main_ref_store(repo), "HEAD",
+					  0, NULL, NULL);
+
 	strvec_pushv(&args, revwalk_args->v);
-	strvec_push(&args, "--min-parents=2");
 
 	repo_init_revisions(repo, &revs, NULL);
 
@@ -281,17 +369,59 @@ static int revwalk_contains_merges(struct repository *repo,
 		goto out;
 	}
 
-	if (get_revision(&revs)) {
-		ret = error(_("replaying merge commits is not supported yet!"));
+	if (action == REF_ACTION_BRANCHES)
+		collect_used_branches(repo, original, head_target, &used,
+				      &rewrites_head);
+
+	while ((commit = get_revision(&revs))) {
+		if (commit->parents && commit->parents->next) {
+			ret = error(_("replaying merge commits is not supported yet!"));
+			goto out;
+		}
+		if (action == REF_ACTION_BRANCHES)
+			collect_used_branches(repo, commit, head_target, &used,
+					      &rewrites_head);
+	}
+
+	if (action == REF_ACTION_HEAD && head_target &&
+	    starts_with(head_target, "refs/heads/")) {
+		char *path = branch_used_elsewhere(repo, head_target, head_target);
+		if (path)
+			string_list_append(&used, head_target)->util = path;
+	}
+
+	if (used.nr) {
+		string_list_sort(&used);
+		for (size_t i = 0; i < used.nr; i++) {
+			const char *branch;
+
+			if (!skip_prefix(used.items[i].string, "refs/heads/", &branch))
+				BUG("branch decoration without refs/heads/ prefix");
+			error(_("cannot rewrite branch '%s' used by worktree at '%s'"),
+			      branch, (const char *)used.items[i].util);
+		}
+		if (action == REF_ACTION_BRANCHES)
+			advise_if_enabled(ADVICE_HISTORY_UPDATE_REFS,
+					  _("Use --update-refs=head to rewrite only "
+					    "the current branch and leave such branches "
+					    "untouched."));
+		ret = -1;
+		goto out;
+	}
+
+	if (rewrites_head && rebase_in_progress(repo)) {
+		ret = error(_("cannot rewrite HEAD while a rebase is in progress"));
 		goto out;
 	}
 
-	reset_revision_walk();
 	ret = 0;
 
 out:
+	reset_revision_walk();
 	release_revisions(&revs);
+	string_list_clear(&used, 1);
 	strvec_clear(&args);
+	free(head_target);
 	return ret;
 }
 
@@ -354,7 +484,7 @@ static int setup_revwalk(struct repository *repo,
 		strvec_push(&args, "HEAD");
 	}
 
-	ret = revwalk_contains_merges(repo, &args);
+	ret = validate_revwalk(repo, action, original, &args);
 	if (ret < 0)
 		goto out;
 
diff --git a/t/t3450-history.sh b/t/t3450-history.sh
index f513463b92..03bd375ef8 100755
--- a/t/t3450-history.sh
+++ b/t/t3450-history.sh
@@ -14,4 +14,269 @@ test_expect_success 'raises an error with unknown argument' '
 	test_grep "unknown subcommand: .garbage." err
 '
 
+test_expect_success 'refuses to rewrite a branch checked out in another worktree' '
+	test_when_finished "rm -rf repo wt" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		git worktree add ../wt -b other &&
+
+		git refs list >refs-expect &&
+		test_must_fail git history drop second 2>err &&
+		test_grep "^error: cannot rewrite branch .other. used by worktree at .*wt" err &&
+		test_grep "^hint: .* --update-refs=head" err &&
+		test_grep ! "branch .main." err &&
+		test_must_fail git history drop --dry-run second >out 2>err &&
+		test_grep "^error: cannot rewrite branch .other. used by worktree at" err &&
+		test_must_be_empty out &&
+		git refs list >refs-actual &&
+		test_cmp refs-expect refs-actual
+	)
+'
+
+test_expect_success 'advice.historyUpdateRefs silences the hint for checked out branches' '
+	test_when_finished "rm -rf repo wt" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		git worktree add ../wt -b other &&
+
+		test_must_fail git -c advice.historyUpdateRefs=false \
+			history drop second 2>err &&
+		test_grep "^error: cannot rewrite branch .other. used by worktree at" err &&
+		test_grep ! "hint:" err
+	)
+'
+
+test_expect_success '--update-refs=head leaves branches of other worktrees alone' '
+	test_when_finished "rm -rf repo wt" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		git worktree add ../wt -b other &&
+		git rev-parse other >other-expect &&
+
+		git history drop --update-refs=head second &&
+
+		git rev-parse other >other-actual &&
+		test_cmp other-expect other-actual &&
+		git log --format=%s main >actual &&
+		test_write_lines third first >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'rewrites the branch of the current worktree' '
+	test_when_finished "rm -rf repo wt" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit first &&
+		git worktree add ../wt -b other &&
+		test_commit -C ../wt second &&
+		test_commit -C ../wt third &&
+
+		git -C ../wt history drop second &&
+
+		git log --format=%s other >actual &&
+		test_write_lines third first >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'refuses to rewrite a branch that is being rebased' '
+	test_when_finished "rm -rf repo" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		test_must_fail git rebase -x false first &&
+
+		git refs list >refs-expect &&
+		test_must_fail git history drop second 2>err &&
+		test_grep "^error: cannot rewrite branch .main. used by worktree at" err &&
+		git refs list >refs-actual &&
+		test_cmp refs-expect refs-actual &&
+
+		git rebase --abort
+	)
+'
+
+test_expect_success 'refuses to rewrite a branch that is being bisected' '
+	test_when_finished "rm -rf repo wt" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		git worktree add ../wt -b other &&
+		git -C ../wt bisect start HEAD first &&
+
+		test_must_fail git history drop second 2>err &&
+		test_grep "^error: cannot rewrite branch .other. used by worktree at" err
+	)
+'
+
+test_expect_success 'refuses to rewrite HEAD while a rebase is in progress' '
+	test_when_finished "rm -rf repo" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit base &&
+		git checkout -b topic &&
+		test_commit topic-one &&
+		test_commit topic-two &&
+		git checkout main &&
+		test_commit main-new &&
+		git checkout topic &&
+		git rev-parse topic >orig &&
+		test_must_fail git rebase -x false main &&
+		git rev-parse HEAD >head-expect &&
+
+		test_must_fail git history drop HEAD~1 2>err &&
+		test_grep "^error: cannot rewrite HEAD while a rebase is in progress" err &&
+		test_must_fail git history drop --update-refs=head HEAD 2>err &&
+		test_grep "^error: cannot rewrite HEAD while a rebase is in progress" err &&
+		git rev-parse HEAD >head-actual &&
+		test_cmp head-expect head-actual &&
+
+		git rebase --abort &&
+		git rev-parse topic >actual &&
+		test_cmp orig actual
+	)
+'
+
+test_expect_success 'rewrites commits unrelated to HEAD while a rebase is in progress' '
+	test_when_finished "rm -rf repo" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit base &&
+		git checkout -b other &&
+		test_commit other-one &&
+		test_commit other-two &&
+		git checkout -b topic base &&
+		test_commit topic-one &&
+		git checkout main &&
+		test_commit main-new &&
+		git checkout topic &&
+		test_must_fail git rebase -x false main &&
+		git rev-parse HEAD >head-expect &&
+
+		git history drop other-one &&
+		git log --format=%s other >actual &&
+		test_write_lines other-two base >expect &&
+		test_cmp expect actual &&
+		git rev-parse HEAD >head-actual &&
+		test_cmp head-expect head-actual &&
+		git rebase --abort
+	)
+'
+
+test_expect_success 'refuses to rewrite the branch a bare repository names in HEAD when a worktree uses it' '
+	test_when_finished "rm -rf repo repo.git wt" &&
+	git init repo --initial-branch=main &&
+	test_commit -C repo first &&
+	test_commit -C repo second &&
+	test_commit -C repo third &&
+	git clone --bare repo repo.git &&
+	git -C repo.git worktree add ../wt main &&
+
+	git -C repo.git refs list >refs-expect &&
+	test_must_fail git -C repo.git history drop second 2>err &&
+	test_grep "^error: cannot rewrite branch .main. used by worktree at .*wt" err &&
+	test_must_fail git -C repo.git history drop --update-refs=head second 2>err &&
+	test_grep "^error: cannot rewrite branch .main. used by worktree at .*wt" err &&
+	git -C repo.git refs list >refs-actual &&
+	test_cmp refs-expect refs-actual
+'
+
+test_expect_success 'refuses to rewrite a branch that two worktrees have checked out' '
+	test_when_finished "rm -rf repo wt" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		git worktree add --force ../wt main &&
+
+		git refs list >refs-expect &&
+		test_must_fail git history drop second 2>err &&
+		test_grep "^error: cannot rewrite branch .main. used by worktree at .*wt" err &&
+		test_must_fail git -C ../wt history drop second 2>err &&
+		test_grep "^error: cannot rewrite branch .main. used by worktree at .*repo" err &&
+		test_must_fail git history drop --update-refs=head second 2>err &&
+		test_grep "^error: cannot rewrite branch .main. used by worktree at .*wt" err &&
+		test_grep ! "^hint:" err &&
+		git refs list >refs-actual &&
+		test_cmp refs-expect refs-actual
+	)
+'
+
+test_expect_success 'refuses to rewrite the commit that a branch of another worktree points at' '
+	test_when_finished "rm -rf repo wt" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		git worktree add ../wt -b other second &&
+
+		git refs list >refs-expect &&
+		test_must_fail git history reword second 2>err &&
+		test_grep "^error: cannot rewrite branch .other. used by worktree at .*wt" err &&
+		test_grep ! "branch .main." err &&
+		git refs list >refs-actual &&
+		test_cmp refs-expect refs-actual
+	)
+'
+
+test_expect_success 'every subcommand refuses before it does anything' '
+	test_when_finished "rm -rf repo wt" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		test_commit fourth &&
+		git worktree add ../wt -b other &&
+		echo changed >first.t &&
+		git add first.t &&
+		write_script fail-editor <<-\EOF &&
+		>editor-ran
+		exit 1
+		EOF
+		test_set_editor "$(pwd)/fail-editor" &&
+
+		git refs list >refs-expect &&
+		git diff --cached >index-expect &&
+		for cmd in "drop second" "reword second" "split second" \
+			   "fixup second" "squash first..third"
+		do
+			test_must_fail git history $cmd </dev/null 2>err &&
+			test_grep "^error: cannot rewrite branch .other. used by worktree at" err &&
+			test_path_is_missing editor-ran &&
+			git refs list >refs-actual &&
+			test_cmp refs-expect refs-actual &&
+			git diff --cached >index-actual &&
+			test_cmp index-expect index-actual || return 1
+		done
+	)
+'
+
 test_done
-- 
2.54.0 (Apple Git-157)

