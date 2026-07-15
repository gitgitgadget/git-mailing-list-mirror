Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963BA3BCD2F
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 19:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784143799; cv=none; b=iATjpF5EKxJKoCCIEXuzPV+sez3I001iDxuBB+ft/FI6mWsIgqGfn64NIm9xJ7SqL974eVo4HI13+cYlDg4dwcFRsDtwHJnqe1szKFvpFDslP1v4M6WMwV0cz38vAkLd4/jVWdARZZff1JJdJUhbUNsirfHSD+foIpYcoEwnORI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784143799; c=relaxed/simple;
	bh=P8m5vBTOR7SgiRhixoL+W0OppzSRcjOQi32Tvcmore8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Oz9e4LY5NvY9z/SBMkoNkbiPUuxHSV1ln5JClcWJJvcPAm8gud6FsJiyLyZ5r+bRoP5hvGyYnbutnNcPpWKggokmFODE1S1sNUAxzYJeKHe//UL/R10Gw/TbORtoooRBarduK5zqXvFivEkWx9P1ck4geHL20EyFrRdFI7rheDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r32byx3m; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r32byx3m"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-9305a2121a1so232621585a.2
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 12:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784143795; x=1784748595; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=saFk/FuXcdyD9A9g23LNo2Qglz/p7cMAojxfoAjmLxM=;
        b=r32byx3mU48+sZwjMrW2mY8AVguq31zghIwMB7wTYWd/A/A37AybRe/dIyX1P5pk8I
         U1gx+qYxj00vFrZ3p35/R53QkJd+Y9+d/w3B15PIRpsdCgp7u0YRHEKNflov5mO9jq9J
         4e54j+dm+ulznMwPwusTPVQ3LZbP9ewR+NkbBQVe33N/PN3U0f0q8Sjhq5MW/W54dCBV
         fzQppA+c9s5EBHLva1LGy0k0QhEDxaMTw60a5nxSNZ4VLMLx5FZs95k8dBcOzRDlY769
         2/4i2Twz2GgtJOB4xaxRTWYR994NCAzf41P3H7m7COLA0YBSKfBBEtZG+Fk7NVuMpCla
         GyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784143795; x=1784748595;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=saFk/FuXcdyD9A9g23LNo2Qglz/p7cMAojxfoAjmLxM=;
        b=hbfP3uPExzbJ8d4wBd8ZGw27ha/TDFLGr/cm/Ir0rdW4/674EkpCpP5wm1ku1wV1hI
         3Jl9qPR71jzhi/PPojcfJAkP1nd7IV68LTUN54yunw4xyFdpsc7jgXYsK7YEd6pGWZRp
         LrouBaHG5VYYdbKBYuYhorEWBsdFb1cbsGaCT7t944SLKTqXz01RZQoRaC53wKWxsPET
         N2lU8gLV356wMd/bTQPkYYdur5Uz6SYwxvYPozLZDIAJAtGd72Br5MEZLsJYQx2rZwBr
         b+yNAkipY0UCRTJMWBItzg+irpdUW7Ty2BvW0R2UhxEsT7RpQ00PF9CAb7yhcPvreTXt
         tymQ==
X-Gm-Message-State: AOJu0YxlcZli1Z2mOtZvEhf71i9T2wE/ejpmOxnVRyrRa5WmhIx6B8zz
	fWaDW9+Wtridg6Rv2YezWkQj+r9pxEHaUVDPowv96c/4K+JzNZZXLSSeMbzF3/4E
X-Gm-Gg: AfdE7cnpzkf0mYv+NFGCy7BltBD/6+FjwjfNFPYNp6MDAyFeeNzt/5hPjtskFeESC3C
	tv3uagI/UAo3/T01yyJJczm34yuSzW9kDOiW4DKDaeR6RN1dh0tTCW/hn0GsAxzRERKv8S8DaqE
	knFPp8xyX3fvbv1PuYs95y1MHQlPjZT1D874GJIaHsoA54WGJiwGgR4iPQH4HCPOjrabR8hJgr8
	ytMRPhA8MxHIOe1I32Key2MJdLq+XIZAC1qW9FYNWV3oXaHTREsnORECgi7OIE6aEcL6skhg/SK
	RONMtpg5URbmnFZ+YH/KD8RMDsxLIs+WNYuiyo0ecITaq3q4QYhmyjEwSjLDfQmVBM/wfIVIuQU
	blvnmOYWXB7IOVfAvqz2WdXls3u+CQyKVDB5M3khU+iWcc/HO9WEMxBLMldbeJNZeqiXm/RuhBc
	B/4lWA3x9O1k9dft0p8UBQD4F6pCU=
X-Received: by 2002:a05:620a:450f:b0:92d:54f4:dfd1 with SMTP id af79cd13be357-93096375aedmr477708185a.54.1784143794713;
        Wed, 15 Jul 2026 12:29:54 -0700 (PDT)
Received: from [127.0.0.1] ([20.172.192.245])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cfcb0dsm1844996185a.25.2026.07.15.12.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 12:29:54 -0700 (PDT)
Message-Id: <pull.2169.git.1784143793613.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Jul 2026 19:29:52 +0000
Subject: [PATCH] revision: make get_commit_action() a pure predicate
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
Cc: SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

get_commit_action() reads as a predicate that decides whether a commit
is shown or ignored, but for a line-level log without parent rewriting
it also calls line_log_process_ranges_arbitrary_commit(), which
mutates the tracked line ranges.  That hidden side effect makes it unsafe
to evaluate ahead of the walk, the way a lookahead would.

get_commit_action() was split out of simplify_commit() in beb5af43a6
(graph API: fix bug in graph_is_interesting(), 2009-08-18) as the
show/ignore decision minus the parent rewriting, so the graph renderer
could reuse it; line-level log later routed its filtering through it as
well, in 3cb9d2b6 (line-log: more responsive, incremental 'git log -L',
2020-05-11).  Besides simplify_commit(), the walk driver,
graph_is_interesting() is its only other caller, and it runs only under
--graph, which sets rewrite_parents and therefore want_ancestry(); the
"-L without ancestry" branch that holds the side effect never fires
there, so it is dormant today.

The line-level processing folds a commit's tracked ranges onto its
parents, which must happen even for a commit that get_commit_action()
filters from the output, or the ranges never reach the parents.  Move it
to simplify_commit() and run it before get_commit_action(), gated by
get_commit_action()'s leading checks (already shown, uninteresting, and
the like) so a commit ignored by those is not folded, as before; factor
those checks out as commit_early_ignore().  get_commit_action() is then
side-effect free.

commit_early_ignore() runs twice on the -L path, once for that gate and
once inside get_commit_action(), but it reads only object flags and pack
membership, disjoint from the TREESAME flag the fold sets, so the repeat
is harmless.

Add a "line-log-peek" subcommand to the revision-walking test helper
that evaluates get_commit_action() on a commit the walk has not reached
yet, plus a t4211 check that the call leaves the commit's flags
unchanged.  The flags are compared rather than the commit list because
add_line_range() merges ranges by union, which is idempotent, so the
side effect never changed which commits a linear -L history shows.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
    revision: make get_commit_action() a pure predicate

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2169%2Fmmontalbo%2Fmm%2Fline-log-tidy-proto-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2169/mmontalbo/mm/line-log-tidy-proto-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2169

 revision.c                       | 70 ++++++++++++++++++++------------
 t/helper/test-revision-walking.c | 63 ++++++++++++++++++++++++++++
 t/t4211-line-log.sh              | 20 +++++++++
 3 files changed, 127 insertions(+), 26 deletions(-)

diff --git a/revision.c b/revision.c
index 0c95edef59..5d650affc0 100644
--- a/revision.c
+++ b/revision.c
@@ -4175,37 +4175,39 @@ static timestamp_t comparison_date(const struct rev_info *revs,
 		commit->date;
 }
 
-enum commit_action get_commit_action(struct rev_info *revs, struct commit *commit)
+/*
+ * Whether the commit is ignored by the cheap checks that read only its
+ * traversal flags and pack membership (e.g. already shown, or marked
+ * uninteresting), before any check that examines the commit's date,
+ * parents, message, or diff.
+ */
+static int commit_early_ignore(struct rev_info *revs, struct commit *commit)
 {
 	if (commit->object.flags & SHOWN)
-		return commit_ignore;
+		return 1;
 	if (revs->maximal_only && (commit->object.flags & CHILD_VISITED))
-		return commit_ignore;
+		return 1;
 	if (revs->unpacked && has_object_pack(revs->repo, &commit->object.oid))
-		return commit_ignore;
-	if (revs->no_kept_objects) {
-		if (has_object_kept_pack(revs->repo, &commit->object.oid,
-					 revs->keep_pack_cache_flags))
-			return commit_ignore;
-	}
+		return 1;
+	if (revs->no_kept_objects &&
+	    has_object_kept_pack(revs->repo, &commit->object.oid,
+				 revs->keep_pack_cache_flags))
+		return 1;
 	if (commit->object.flags & UNINTERESTING)
+		return 1;
+	return 0;
+}
+
+/*
+ * Decide whether this commit is shown or ignored.  Keep it a pure
+ * predicate: callers such as the commit graph depend on it having no
+ * side effects, so per-commit mutations (such as -L range tracking)
+ * belong in the caller, simplify_commit(), not here.
+ */
+enum commit_action get_commit_action(struct rev_info *revs, struct commit *commit)
+{
+	if (commit_early_ignore(revs, commit))
 		return commit_ignore;
-	if (revs->line_level_traverse && !want_ancestry(revs)) {
-		/*
-		 * In case of line-level log with parent rewriting
-		 * prepare_revision_walk() already took care of all line-level
-		 * log filtering, and there is nothing left to do here.
-		 *
-		 * If parent rewriting was not requested, then this is the
-		 * place to perform the line-level log filtering.  Notably,
-		 * this check, though expensive, must come before the other,
-		 * cheaper filtering conditions, because the tracked line
-		 * ranges must be adjusted even when the commit will end up
-		 * being ignored based on other conditions.
-		 */
-		if (!line_log_process_ranges_arbitrary_commit(revs, commit))
-			return commit_ignore;
-	}
 	if (revs->min_age != -1 &&
 	    comparison_date(revs, commit) > revs->min_age)
 			return commit_ignore;
@@ -4314,7 +4316,23 @@ struct commit_list *get_saved_parents(struct rev_info *revs, const struct commit
 
 enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
 {
-	enum commit_action action = get_commit_action(revs, commit);
+	enum commit_action action;
+
+	/*
+	 * For a line-level log without parent rewriting, fold each commit's
+	 * ranges as the walk reaches it (parent rewriting does this eagerly in
+	 * prepare_revision_walk()).  Fold before get_commit_action() so the
+	 * ranges carry across a commit that a later, cheaper check ignores;
+	 * the commit_early_ignore() guard skips a commit get_commit_action()
+	 * would ignore outright.
+	 */
+	if (revs->line_level_traverse && !want_ancestry(revs) &&
+	    !commit_early_ignore(revs, commit)) {
+		if (!line_log_process_ranges_arbitrary_commit(revs, commit))
+			return commit_ignore;
+	}
+
+	action = get_commit_action(revs, commit);
 
 	if (action == commit_show &&
 	    revs->prune && revs->dense && want_ancestry(revs)) {
diff --git a/t/helper/test-revision-walking.c b/t/helper/test-revision-walking.c
index 70051eeaf8..24d7f29417 100644
--- a/t/helper/test-revision-walking.c
+++ b/t/helper/test-revision-walking.c
@@ -13,9 +13,12 @@
 #include "test-tool.h"
 #include "commit.h"
 #include "diff.h"
+#include "line-log.h"
+#include "object-name.h"
 #include "repository.h"
 #include "revision.h"
 #include "setup.h"
+#include "string-list.h"
 
 static void print_commit(struct commit *commit)
 {
@@ -51,6 +54,60 @@ static int run_revision_walk(void)
 	return got_revision;
 }
 
+/*
+ * Check that get_commit_action() is a pure predicate by evaluating it on a
+ * commit the walk has not reached yet.  No git command makes that out-of-order
+ * call, so this probe does it deliberately, and reports whether the call
+ * mutated the peeked commit: a pure get_commit_action() leaves it untouched.
+ * We compare the commit's flags rather than the emitted commit list because
+ * range merges are idempotent, so a side effect would not change which commits
+ * are shown.  Only meaningful for a plain "-L" walk with no parent rewriting.
+ */
+static int line_log_peek(const char **argv)
+{
+	struct repository *repo = the_repository;
+	struct rev_info rev;
+	struct string_list range_args = STRING_LIST_INIT_DUP;
+	struct object_id oid;
+	struct commit *peek;
+	const char *rev_argv[3];
+	unsigned before, after;
+
+	if (repo_get_oid(repo, argv[0], &oid))
+		die("bad peek commit: %s", argv[0]);
+	peek = lookup_commit_reference(repo, &oid);
+	if (!peek || repo_parse_commit(repo, peek))
+		die("cannot parse peek commit: %s", argv[0]);
+
+	repo_init_revisions(repo, &rev, NULL);
+	rev.diffopt.flags.recursive = 1;
+	rev.line_level_traverse = 1;
+	string_list_append(&range_args, argv[1]);
+
+	rev_argv[0] = "line-log-peek";
+	rev_argv[1] = argv[2];
+	rev_argv[2] = NULL;
+	setup_revisions(2, rev_argv, &rev, NULL);
+
+	line_log_init(&rev, NULL, &range_args);
+
+	if (rev.rewrite_parents || rev.children.name)
+		die("line-log-peek requires a non-ancestry (-L, no --graph) walk");
+
+	if (prepare_revision_walk(&rev))
+		die("prepare_revision_walk failed");
+
+	before = peek->object.flags;
+	get_commit_action(&rev, peek);
+	after = peek->object.flags;
+
+	printf("mutated %d\n", before != after);
+
+	release_revisions(&rev);
+	string_list_clear(&range_args, 0);
+	return 0;
+}
+
 int cmd__revision_walking(int argc, const char **argv)
 {
 	if (argc < 2)
@@ -69,6 +126,12 @@ int cmd__revision_walking(int argc, const char **argv)
 		return 0;
 	}
 
+	if (!strcmp(argv[1], "line-log-peek")) {
+		if (argc != 5)
+			die("usage: test-tool revision-walking line-log-peek <peek-commit> <start,end:file> <rev>");
+		return line_log_peek(argv + 2);
+	}
+
 	fprintf(stderr, "check usage\n");
 	return 1;
 }
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index ca4eb7bbc7..f4a7d8ab61 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -781,4 +781,24 @@ test_expect_success '--summary shows new file on root commit' '
 	test_grep "create mode 100644 file.c" actual
 '
 
+test_expect_success 'get_commit_action() does not mutate a not-yet-walked commit' '
+	git init peek &&
+	(
+		cd peek &&
+		test_write_lines 1 2 3 4 5 >f.c &&
+		git add f.c && test_tick && git commit -m base &&
+		test_write_lines 1 two 3 4 5 >f.c &&
+		test_tick && git commit -am change &&
+
+		# Peek HEAD^, which the walk has not reached (the out-of-order
+		# call a lookahead makes), and confirm get_commit_action() leaves
+		# it untouched.  A side effect is invisible in the commit list
+		# (range merges are idempotent), so the helper reports whether the
+		# call mutated the peeked commit at all.
+		echo "mutated 0" >expect &&
+		test-tool revision-walking line-log-peek HEAD^ 1,3:f.c HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done

base-commit: f60db8d575adb79761d363e026fb49bddf330c73
-- 
gitgitgadget
