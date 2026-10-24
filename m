Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792860800;
	b=KALaUdx7J8ODDDxzGqcsvQdbas5ISxoiZ3FxqTPmEuQLRT1/0T0OF6IFzwxKaUMJRlot
	 QZi28PpcyybKB+st4tK5oKDETKn5azokC3/5vkx2Lj9l/wsPMw/ueCSGBWUUzbSYMpW4/
	 D+aOmA++wlcXvSu33HOFMfQkfjztvYrRMjgTDDnFRdOeMVZmEUpasmwGMMO9M1D05dLPe
	 Okbb6VieJp68QpBvuy6nAA/ItDyxW1/adJ4lKLOpfCQvyW+PUPseFCmprQ7UtxDAsumsm
	 c7/1HbZ2Njttnf9ZpqXqYFEef7joxkgar+XrxuAiX2oYx+Poogd6oE7O99/vQX7CWEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792860800;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lXhs0u4/puYpftXv/eZWS2lxlIYB4Bmxy2bnUs7RaJ8=;
	b=OyeN9FYurSHJhyHry6m1gW5F7mANp998+WyNJIiYOa5YSva84Mi4Oasv8JUWfi2o6/Af
	 ZnZvBbgRojDJ7ImzIScFpWJWMmVaMZI7LytSTk9528da2CV8IMEridLUiyIugwrTkzZqk
	 Py3iqR1xNXqyUn6exZZF9Ar1o+U26GG1FUrS9hWLEclxRNOs6veM5pClLRbVLdFn5XULv
	 cA2DyNFC3U+69jQrc9wdppWLYdk8ENjzNodkHZGpl8pEYUh6CH9WL7uCepvWWdIBMqceX
	 UTCEB/P9pb20kweDP1ipChFOy7+5vknwl/OM6oyeYkpgnZgR3uW/iRjyH7BKPw2XJ3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=iWzZeM8W;
	arc=none smtp.remote-ip=74.125.231.130
Received: from mail-oo2-f2.google.com (mail-oo2-f2.google.com [74.125.231.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A803606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 16:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A803606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=iWzZeM8W
Received: by mail-oo2-f2.google.com with SMTP id 006d021491bc7-705f006c508so800990eaf.0
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 09:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1792860799; x=1793465599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lXhs0u4/puYpftXv/eZWS2lxlIYB4Bmxy2bnUs7RaJ8=;
        b=iWzZeM8WI4vIdlwqxzNBlVBOeKMm21JsqojfUa/gKt0launk6zscBHdiwTfzZ8imlK
         rIB0NEmAv/kS63CuvVLyOtZCbQAKPL0ccMpy/jriIGRN3d3KLKyV0IVcjVOiBu07c8ud
         TYvYiQ3zNkmUyTPzSmDNX0oqNDy5YaLetv0dEe7HGTCTP42fux4ipb7PywO4NX5wKeE3
         ISgxtVU9SnxhmpFJMmW6kcGTp98/XuQ/a4Mn/9CtcOe0znENyEkas+PRbtkUyNXnQX5H
         e1CltK66jHae8ppQm0TZoT3HO8NQ92z6xjp8jBjKXZyysmBfW2px0PNc0XwKENHdkso0
         /6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792860799; x=1793465599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lXhs0u4/puYpftXv/eZWS2lxlIYB4Bmxy2bnUs7RaJ8=;
        b=mR5/Y9SaSPSvtuMZ41ZzbbhY7uAQcI5Ilg1DOqAew4Os6pJm8K4j4MEm3H7zafYLz9
         RbZglvQ+hoL7ayxq/KeKlHvZzazdivMNQsZbnj0TiFe1Nc7KH7nSm01VCvwDndEvL2UP
         sS7P1VqxM031od/YhUKSOGniADTUhcId1CqqjRXKc4TbpEwbEa3OnkkfG/V9L3DQIJvH
         pHwornOwF5HF8oEs7qo5FxmiC5UsiBLOfeYTPGxL1KbtAmaovG0/4aWsmc2KK0Hn59hC
         zEQjoVJylFi1RML5L20pa+9l/FgLtbuI+GokGxl01BIsBypFostAgvVs+951THpiSkku
         wR8w==
X-Gm-Message-State: AFq9FYIh9Lnh9OixrZbJMQvPHHYQ/7FJ5rjYdf9V6IVX+ZYGBebl9/QK
	Bltu7IZBEYAedGaBGJS0hq1tJ1A2Ho1VCCpwuA2WDFWRiwg+ZO/j7WpDzvRVLL6gpufPLtGBD0D
	+M9+1obqlNhtMfJiZpFa4TXQSI8lFBo7Pgw+IMa3RrS2z/wLTzs3dYq8BpzcY8gZPxzxodMensR
	Dywt75c1lwG7cl4TAF2k9wJsPvHWVV0PaUGdMteZ8nLROC1NEzaZshFAJ+3e+H4U6B3t9zZ7tPE
	unGIZxCi2kKVs8vl9yLwD/lPmb7IwHXqAHKzJoQCWzpruOA
X-Gm-Gg: AYBFou0zD8LKTBe7CQ3u3D79jFvIvImEnbqL0heBMSZimE1WjR3mbZCre8Os0pditjn
	frPAurlwOWh8cgrkD8Ia3Bk7rq9Jz/cfvFCVl3dVIPUGQrta7HoJC5oDcf93PYvzcT+XbCyY8eL
	tOvflgr8e6cttHtLPnwyIsBQdzoVQ/HXRsI5spF+Y5Ma2UiUKw7V1LeUrxP0E738S/l/i/kpsSc
	r3LTyBUVCz131+gYuvqHW1PamXXvbVO+KlxB2v/5mEbp9C5tN12WqzUge3or6BXxoAMMXTJUn+e
	nFw4UW835qdpMZRGj7jQXDpXoAk0MeUAc3OJJeLnjEEm6Y30kGC298rMGUR4FaYHQuF/4++r6C5
	1hupwB7iFpW6Xfw9RG3iw6Rt/sQrHPCcOJnso1YjpjoYUX+t4iintxvaXvCrk/2oQ41PPguZ8Fn
	V71GATML8rgt6OPiFIB7XJYgV+3ARNoBTpGvKkaWy10l0oY4DH7GBybzLRON7OGGq3s1ycJ15Ak
	JFwQF4nR4vCJDBExnDODu3SFPLtn2Ba5g+pWoDFVXfCgmE00/oQJJ5B/tn+lIZCySqlE92SXlV/
	SNlQmBooSKD1z9uH7Q0ZdJwkMoApoKvkiSbmam9pu5KAMr3B043j6S6OWYq15GI5X96HvIHXtAV
	1Yp4ICvZjJ5GgQUCELI3g9n7Vded7ot2DWRvRlCqhigdvoNdcKfba57b5BcWWY6DUYYvyWKg7OX
	Z5mK9s4+vMky8KHd0xhT42AfdtMvd+DcgzosJIGOMiHq5LgwHAd3tgJXw+4erGCh/CtWCfZgU=
X-Received: by 2002:a05:6820:8591:20b0:703:8835:5fd6 with SMTP id 006d021491bc7-70ba0b60887mr852853eaf.13.1792860798705;
        Sat, 24 Oct 2026 09:53:18 -0700 (PDT)
Received: from remus.wildebeest-stargazer.ts.net ([69.43.66.31])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a8430ec935sm1417650fac.4.2026.10.24.09.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 09:53:17 -0700 (PDT)
From: Jasper Mayone <me@jaspermayone.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	sunshine@sunshineco.com,
	haraldnordgren@gmail.com,
	ben.knoble@gmail.com,
	Jasper Mayone <me@jaspermayone.com>
Subject: [PATCH v2] worktree list: add --branch to select worktrees by branch
Date: Sat, 24 Oct 2026 12:53:11 -0400
Message-ID: <20261024165311.57387-1-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAPig+cTZEcn_5TG0iMVJJym8Zhu1KYP+y9Oc1J=JJgDYSzNSdg@mail.gmail.com>
References: <CAPig+cTZEcn_5TG0iMVJJym8Zhu1KYP+y9Oc1J=JJgDYSzNSdg@mail.gmail.com>
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

There is no direct way to ask which worktree has a given branch
checked out. "git worktree list --porcelain" prints the branch of
every worktree, so a script has to parse the whole list and match the
"branch" lines itself.

Teach "git worktree list" a "--branch=<branch>" option that lists
only the worktrees that have <branch> checked out. It can be given
more than once. A worktree that is rebasing or bisecting a branch
counts as having it checked out, as it does for "git branch -d" and
"git worktree add". <branch> is a branch name, or a full name under
refs/heads/.

This keeps the choice of branches in "git branch", which already has
--merged, --contains, --points-at and patterns. For example, to list
the worktrees whose branch is merged into origin/main:

    git worktree list \
	$(git branch --format='--branch=%(refname)' --merged origin/main)

The --format is needed because the default output of "git branch"
marks the current branch with "*" and the branches checked out in
other worktrees with "+". It uses the full name because
%(refname:short) gives "heads/topic" when a tag is also called
"topic".

Each worktree's branch is found once and looked up in a set of the
requested branches, so feeding it every branch of a large repository
stays cheap.

A detached worktree has no branch, so it is never listed.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jasper Mayone <me@jaspermayone.com>
---
Changes since the RFC [1]:

 * Junio pointed out that --merged and --no-merged narrow the problem
   to one workflow, and suggested selecting worktrees by branch
   instead, with "git branch" doing the choosing. Eric had the same
   reaction. This version does that and drops --merged, --no-merged
   and the reachability code.

 * Junio's example piped "git branch" through sed. Its default output
   prefixes the current branch with "*" and branches checked out in
   other worktrees with "+", which are the branches this is for, so
   the words come out as "--branch=+" and "topic". The documented form
   uses --format='--branch=%(refname)'. The full name also avoids
   "heads/topic" from %(refname:short) when a tag has the same name.

 * <branch> is an exact name, not a pattern, because "git branch"
   already has --list <pattern>, --merged, --contains and friends.
   An invalid name dies, as for "git branch -d". A valid name that no
   worktree has checked out lists nothing.

 * Eric, a "git worktree foreach" would be nice, and it could select
   worktrees with this same --branch. I left it out of this patch.

[1] https://lore.kernel.org/git/20261021173350.67854-1-me@jaspermayone.com/

 Documentation/git-worktree.adoc |  21 ++++-
 builtin/worktree.c              |  79 ++++++++++++++++++-
 t/t2402-worktree-list.sh        | 131 ++++++++++++++++++++++++++++++++
 3 files changed, 228 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
index e6e77252ab..4db11eab88 100644
--- a/Documentation/git-worktree.adoc
+++ b/Documentation/git-worktree.adoc
@@ -11,7 +11,7 @@ SYNOPSIS
 [synopsis]
 git worktree add [-f] [--detach] [--checkout] [--lock [--reason <string>]]
 		 [--orphan] [(-b | -B) <new-branch>] <path> [<commit-ish>]
-git worktree list [-v | --porcelain [-z]]
+git worktree list [-v | --porcelain [-z]] [--branch=<branch>...]
 git worktree lock [--reason <string>] <worktree>
 git worktree move <worktree> <new-path>
 git worktree prune [-n] [-v] [--expire <expire>]
@@ -114,6 +114,9 @@ whether the worktree is bare, the revision currently checked out, the
 branch currently checked out (or "detached HEAD" if none), "locked" if
 the worktree is locked, "prunable" if the worktree can be pruned by the
 `prune` command.
++
+With `--branch`, only the worktrees that have one of the given branches
+checked out are listed.
 
 `lock`::
 
@@ -268,6 +271,22 @@ mismatch, even if the links are correct.
 	to parse the output when a worktree path contains a newline
 	character.
 
+`--branch=<branch>`::
+	With `list`, only list worktrees that have _<branch>_ checked
+	out, including a worktree that is rebasing or bisecting
+	_<branch>_. _<branch>_ is a branch name, such as `topic` or
+	`@{-1}`, or a full name under `refs/heads/`. The option can be
+	given more than once to list the worktrees of several branches.
+	A detached worktree is never listed.
++
+Use linkgit:git-branch[1] to choose the branches. For example, to list
+the worktrees whose branch is merged into `origin/main`:
++
+------------
+$ git worktree list \
+	$(git branch --format='--branch=%(refname)' --merged origin/main)
+------------
+
 `-q`::
 `--quiet`::
 	With `add`, suppress feedback messages.
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 77ecd0f71f..1d7db5f7fc 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -15,6 +15,7 @@
 #include "object-name.h"
 #include "parse-options.h"
 #include "path.h"
+#include "strmap.h"
 #include "strvec.h"
 #include "branch.h"
 #include "read-cache-ll.h"
@@ -26,6 +27,7 @@
 #include "submodule.h"
 #include "utf8.h"
 #include "worktree.h"
+#include "wt-status.h"
 #include "quote.h"
 
 #define BUILTIN_WORKTREE_ADD_USAGE \
@@ -33,7 +35,7 @@
 	   "                 [--orphan] [(-b | -B) <new-branch>] <path> [<commit-ish>]")
 
 #define BUILTIN_WORKTREE_LIST_USAGE \
-	N_("git worktree list [-v | --porcelain [-z]]")
+	N_("git worktree list [-v | --porcelain [-z]] [--branch=<branch>...]")
 #define BUILTIN_WORKTREE_LOCK_USAGE \
 	N_("git worktree lock [--reason <string>] <worktree>")
 #define BUILTIN_WORKTREE_MOVE_USAGE \
@@ -1125,11 +1127,78 @@ static void pathsort(struct worktree **wt)
 	QSORT(wt, n, pathcmp);
 }
 
+/*
+ * Return the full name of the branch that "wt" has checked out, or
+ * NULL. A worktree that is rebasing or bisecting a branch has it
+ * checked out, too, as for is_shared_symref().
+ */
+static char *checked_out_branch(const struct worktree *wt)
+{
+	struct wt_status_state state = { 0 };
+	char *ref = NULL;
+
+	if (wt->is_bare)
+		return NULL;
+	if (!wt->is_detached)
+		return xstrdup_or_null(wt->head_ref);
+
+	if (wt_status_check_rebase(wt, &state) &&
+	    (state.rebase_in_progress || state.rebase_interactive_in_progress) &&
+	    state.branch)
+		ref = xstrfmt("refs/heads/%s", state.branch);
+	else if (wt_status_check_bisect(wt, &state) && state.bisecting_from)
+		ref = xstrfmt("refs/heads/%s", state.bisecting_from);
+	wt_status_state_free_buffers(&state);
+	return ref;
+}
+
+/*
+ * Keep only the worktrees that have one of the "--branch" branches
+ * checked out. A branch is given by its name, or by its full name
+ * under refs/heads/.
+ */
+static void filter_by_branch(struct repository *repo, struct worktree **wt,
+			     const struct string_list *branches)
+{
+	struct strset refnames = STRSET_INIT;
+	struct string_list_item *item;
+	struct strbuf ref = STRBUF_INIT;
+	size_t kept = 0;
+
+	for_each_string_list_item(item, branches) {
+		strbuf_reset(&ref);
+		if (starts_with(item->string, "refs/heads/")) {
+			strbuf_addstr(&ref, item->string);
+			if (check_refname_format(ref.buf, 0))
+				die(_("'%s' is not a valid branch name"),
+				    item->string);
+		} else if (check_branch_ref(repo, &ref, item->string)) {
+			die(_("'%s' is not a valid branch name"), item->string);
+		}
+		strset_add(&refnames, ref.buf);
+	}
+
+	for (size_t i = 0; wt[i]; i++) {
+		char *branch = checked_out_branch(wt[i]);
+
+		if (branch && strset_contains(&refnames, branch))
+			wt[kept++] = wt[i];
+		else
+			free_worktree(wt[i]);
+		free(branch);
+	}
+	wt[kept] = NULL;
+
+	strbuf_release(&ref);
+	strset_clear(&refnames);
+}
+
 static int list(int ac, const char **av, const char *prefix,
-		struct repository *repo UNUSED)
+		struct repository *repo)
 {
 	int porcelain = 0;
 	int line_terminator = '\n';
+	struct string_list branches = STRING_LIST_INIT_DUP;
 
 	struct option options[] = {
 		OPT_BOOL(0, "porcelain", &porcelain, N_("machine-readable output")),
@@ -1138,6 +1207,8 @@ static int list(int ac, const char **av, const char *prefix,
 				N_("add 'prunable' annotation to missing worktrees older than <time>")),
 		OPT_SET_INT('z', NULL, &line_terminator,
 			    N_("terminate records with a NUL character"), '\0'),
+		OPT_STRING_LIST(0, "branch", &branches, N_("branch"),
+				N_("only show worktrees that have <branch> checked out")),
 		OPT_END()
 	};
 
@@ -1157,6 +1228,9 @@ static int list(int ac, const char **av, const char *prefix,
 		/* sort worktrees by path but keep main worktree at top */
 		pathsort(worktrees + 1);
 
+		if (branches.nr)
+			filter_by_branch(repo, worktrees, &branches);
+
 		if (!porcelain)
 			measure_widths(worktrees, &abbrev,
 				       &display, &path_maxwidth);
@@ -1174,6 +1248,7 @@ static int list(int ac, const char **av, const char *prefix,
 		free(display);
 		free_worktrees(worktrees);
 	}
+	string_list_clear(&branches, 0);
 	return 0;
 }
 
diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index eeaf800d74..ea08bf79fa 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -318,4 +318,135 @@ test_expect_success 'worktree path when called in .git directory' '
 	test_cmp list1 list2
 '
 
+test_expect_success 'setup for "list --branch"' '
+	git init by-branch &&
+	(
+		cd by-branch &&
+		test_commit base &&
+		git branch topic-a &&
+		git branch topic-b &&
+		git branch unused &&
+		git worktree add ../wt-a topic-a &&
+		git worktree add ../wt-b topic-b &&
+		git worktree add --detach ../wt-detached main &&
+		git -C ../wt-a commit --allow-empty -m a &&
+		git -C ../wt-b commit --allow-empty -m b &&
+		git merge --ff-only topic-a
+	)
+'
+
+list_paths () {
+	git -C by-branch worktree list --porcelain "$@" >out &&
+	sed -n "s/^worktree //p" out >actual
+}
+
+test_expect_success '"list --branch" shows the worktree of that branch' '
+	list_paths --branch=topic-a &&
+	echo "$(pwd)/wt-a" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '"list --branch" can be repeated' '
+	list_paths --branch=topic-b --branch=main --branch=topic-a &&
+	cat >expect <<-EOF &&
+	$(pwd)/by-branch
+	$(pwd)/wt-a
+	$(pwd)/wt-b
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '"list --branch" with a branch that is not checked out' '
+	list_paths --branch=unused --branch=no-such-branch &&
+	test_must_be_empty actual
+'
+
+test_expect_success '"list --branch" never shows a detached worktree' '
+	list_paths --branch=main &&
+	echo "$(pwd)/by-branch" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '"list --branch" rejects an invalid branch name' '
+	test_must_fail git -C by-branch worktree list --branch=-bad 2>err &&
+	test_grep "is not a valid branch name" err
+'
+
+test_expect_success '"list --branch" keeps the normal output format' '
+	git -C by-branch worktree list --branch=topic-a >out &&
+	sed "s/  */ /g" <out >actual &&
+	echo "$(pwd)/wt-a $(git -C by-branch rev-parse --short topic-a) [topic-a]" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '"list --branch" works with -z' '
+	git -C by-branch worktree list --porcelain -z --branch=topic-b >out &&
+	tr "\0" "\n" <out >actual &&
+	cat >expect <<-EOF &&
+	worktree $(pwd)/wt-b
+	HEAD $(git -C by-branch rev-parse topic-b)
+	branch refs/heads/topic-b
+
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '"list --branch" shows a worktree bisecting that branch' '
+	test_when_finished "git -C wt-b bisect reset && git -C wt-b reset --hard HEAD~2" &&
+	git -C wt-b commit --allow-empty -m b1 &&
+	git -C wt-b commit --allow-empty -m b2 &&
+	git -C wt-b bisect start topic-b topic-b~2 &&
+	test_must_fail git -C wt-b symbolic-ref -q HEAD &&
+	list_paths --branch=topic-b &&
+	echo "$(pwd)/wt-b" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '"list --branch" shows a worktree rebasing that branch' '
+	test_when_finished "git -C wt-b rebase --abort" &&
+	test_must_fail git -C wt-b rebase -f -x false base &&
+	test_must_fail git -C wt-b symbolic-ref -q HEAD &&
+	list_paths --branch=topic-b &&
+	echo "$(pwd)/wt-b" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '"list --branch" accepts a full branch name' '
+	list_paths --branch=refs/heads/topic-a &&
+	echo "$(pwd)/wt-a" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '"list --branch" with a tag of the same name' '
+	test_when_finished "git -C by-branch tag -d topic-a" &&
+	git -C by-branch tag topic-a base &&
+	list_paths --branch=topic-a &&
+	echo "$(pwd)/wt-a" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '"list --branch" shows unborn and prunable worktrees' '
+	test_when_finished "rm -rf wt-unborn wt-gone && git -C by-branch worktree prune" &&
+	git -C by-branch worktree add --orphan -b unborn ../wt-unborn &&
+	git -C by-branch branch gone &&
+	git -C by-branch worktree add ../wt-gone gone &&
+	rm -rf wt-gone &&
+	git -C by-branch worktree list -v --branch=unborn --branch=gone >out &&
+	test_grep "^$(pwd)/wt-unborn .*\[unborn\]$" out &&
+	test_grep "^$(pwd)/wt-gone .*\[gone\]$" out &&
+	test_grep "prunable: gitdir file points to non-existent location" out
+'
+
+test_expect_success '"list --branch" with "git branch --merged"' '
+	git -C by-branch worktree list --porcelain \
+		$(git -C by-branch branch --format="--branch=%(refname)" \
+			--merged main) >out &&
+	sed -n "s/^worktree //p" out >actual &&
+	cat >expect <<-EOF &&
+	$(pwd)/by-branch
+	$(pwd)/wt-a
+	EOF
+	test_cmp expect actual
+'
+
 test_done

base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
-- 
2.56.0

