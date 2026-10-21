Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585730;
	b=vwHjmlacXsJwjLicJCwjypemKrVDeCN1hEN3qKC3hegFUdoM4UuokTrmhAH+Ul6CpRKs
	 qDw/QncbqqlFOWIwktnGuARWhoq59PqPEIV2xZ0cbp7cNysq4A0IdoQFZnFcyUdmL6wKo
	 BOK14nN6/w426nApJ/trDjDNrbQ6UwGTOJcppnFiYKPly2VGTHfeGc50/FCF/KJ+Lr6pU
	 kLfG7FL58cEUBvC4dl9e4P4YJdq7bIJNt1P9syMDzxQ9DskNwjqmhGJkDy/+SOqJEwEpL
	 XtXYOzq44NCxYzyQMJY6AEw9qOVetUALbFMi47gC+uQQ5oDEo+H4gHlF/yJJLOdvQkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=LtWPKsk0jQ8Xb273wE6fZJoa83FbII21hacma6xpTBA=;
	b=vd7/2dAtcOjSpdUkxNkStejXQQz3R0Sat/CWU+mnWf9nBl/0rTplliSAjSilY6gd8rNK
	 4yT9rLBumdkhiy81Tda9JoFYw9+E2BD5m/kBHcws33oICsqgjnmsJIHt6lKQnQE6AAVaR
	 M29D59N1rzn++fJazpnYatDN83KWNhehad/rsCMoHIy7zE6saQ8YvwyijLfmezc6jlGgK
	 Wd4QlBhR17n9u/07ZmVAjPxY5+xLQaqGIo+/qM4S/G6hv93D7BnOHCfAonwJBNMtrfXv1
	 nYMDXFFQVsYtfkYgZV1fklSifF9T8t12tXb1LRUMtq59qfPb8wRSpCpRZZZJyn5WvPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d257oslS;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB0A606A31A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 12:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCB0A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d257oslS
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53639b8903bso8353211cf.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 05:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792585729; x=1793190529; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LtWPKsk0jQ8Xb273wE6fZJoa83FbII21hacma6xpTBA=;
        b=d257oslSRtK0CA9GOgBM9aH+4biZzRvidXsRqzs/c7XMJwMSKdnZE8IrZXSEHbW+cC
         vXCuxe1JUu5jRr3GCehNp9FOQ114jbJckcTdLZooLISPRCWNY+dOTqrFtfQO1O/mWkk2
         Sfua7ueyek2IICBNpFi22/UViUPSSHO5oQgTgb7toVYQdqsP3zwMY+K5qfdl0jHqKcF0
         BJ6V9F7XO2ZkeuKw3JgfmNx0+pQYXeITyJ01cc/G8W4P79DdwrFPD0jAjx8+mPh6/dsp
         FKFREyIAMh3qgYzhlMkB+Q3D6a7NfofXcb6XdwGCFIMcxTbqc3cuCO2sqz20Hs4mMG92
         JvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585729; x=1793190529;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LtWPKsk0jQ8Xb273wE6fZJoa83FbII21hacma6xpTBA=;
        b=FjLEAL+wi8KA+A374y0MTPMjTqEKn8HR6Timo3LiNolpBY9kMuD24Sw+ixyEzcrJ6y
         AHzsri40aVO4u8IkFIEXV4Spm1hsraKIsL4jWqgHYbifX6nOhQBUo02ByzB/mpME1B+8
         v/fHXADKC1itkkMXH9ZZNwxlAz3IsnnoT48qtBXBLgRvCYvL3urMm/TA0ACmvuuMisSN
         yAKMo8Y/z6JMHUug0agH8FndA4MRMCG8sfRALikoGfYsP38/DOzRUY2x41klsHBn9BW/
         NkClWCQIS5MDFLvWZb/Nh8nOjGJtRhM1C9cQCH3UbWcWty83b+Hu4pJ9G3rTqVWB4ZNK
         ns9A==
X-Gm-Message-State: AFq9FYJ0wk0hyLVGM8A9JOsgm2ZjkIobArF+GeSZSTCTVNufupY0t+vw
	xbKnpQ76DUyIvRtJfOkRy2ex3d+sCfK5MqJQQzufHf7X7JTnW4HdfV1j5WfoKsvR
X-Gm-Gg: AYBFou0KrkSRNEyhtIoVGeQ4RroM9SKQeagDVyjWPc/wL1xhFh9Xz9m0Nbt+XtA5zq3
	PInPuRUhgFg4VKnReRfxjQCf1GuqplhEFLkhLCe3+LxLTvs2KI13JfBeckfoF1Sm3Z9a3SWc3yI
	LEFDndyL0YJ80aTGpUchLeFTvm9opGivGj+zX2u3DXGEBUEpqoE1OhvBXfBqtOwqNjx5AqaacH1
	mtolm5vpr7ryMHRpiJu4vbNGJQXRrUG/JxPkOVlP2omUwOmCNjoAYd4a0bCyRN4bf9ZHN3KKGlf
	4bTsY6Ub1TN9iWPBD/RkYhpPcBR3WLM5Vdwv+r+e+YBrwZMfpfUpkKNjh7muHl25n1dftljaQvw
	wG4n8erLzoNpfuuehfHezaKpUoJGlT1YhpEFKUqdMHe/QK2WAPSF4I9u50eWZy0K/c9/wzHXD/F
	u5SiZlpYo6J856PtEAUY1Yx5audrDP1cJDD4dzxC8TmEQx3Jk/kkbvfjwxi6lWK5UFZx1m25dSd
	eGTIn8ZhbGVAFburRdjJ9raBI5+kwjCnekwrPlXWAeJSfYbtRgWDvgQFQ==
X-Received: by 2002:a05:622a:406:b0:535:a5f7:d596 with SMTP id d75a77b69052e-536871cf46fmr75382771cf.37.1792585726710;
        Wed, 21 Oct 2026 05:28:46 -0700 (PDT)
Received: from [127.0.0.1] ([20.115.95.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53698be9657sm18342341cf.28.2026.10.21.05.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:28:42 -0700 (PDT)
Message-Id: <2befb182dc7c551d0d6ae0d8803fe717b7b58c61.1792585717.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v3.git.git.1792585717.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v3.git.git.1792585717.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 12:28:37 +0000
Subject: [PATCH v3 3/3] branch: add --squashed to find squash merged branches
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Jasper Mayone <me@jaspermayone.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A branch that upstream integrated with

    git merge --squash topic
    git commit

after upstream had also changed the files the branch touches is still
kept by "git branch --delete-merged". The squash commit has neither the
branch's version of those files nor the fork point's, so the previous
check cannot see that the work landed. This happens all the time on
hosting services, where the "Squash and merge" button on GitHub lands
pull requests this way while the main branch keeps moving. A rebase
merge onto such changes looks the same.

Add --squashed, which for each such file merges the branch's version
into the upstream one and treats the change as landed when that leaves
the upstream version unchanged. This has to read the files, so it is
slower, and in a partial clone it may download blobs. It is therefore
only done when asked for.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc | 11 +++-
 builtin/branch.c              | 96 ++++++++++++++++++++++++++++-------
 t/t3200-branch.sh             | 55 ++++++++++++++++++++
 3 files changed, 144 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 3d6549b977..3b414be171 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -25,7 +25,7 @@ git branch (-m|-M) [<old-branch>] <new-branch>
 git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
-git branch [--dry-run] (--delete-merged <pattern>)... [<branch-pattern>...]
+git branch [--dry-run] [--squashed] (--delete-merged <pattern>)... [<branch-pattern>...]
 
 DESCRIPTION
 -----------
@@ -244,6 +244,15 @@ remove it anyway.
 	sanity-checking a wide pattern like `'origin/*'` before
 	committing to the deletion.
 
+`--squashed`::
+	With `--delete-merged`, also delete a branch that was squash or
+	rebase merged after upstream changed the same files. Upstream
+	then has neither the branch's version of those files nor the fork
+	point's, so the branch's version is merged into upstream's, and
+	the file counts as landed when that leaves upstream's version
+	unchanged. This reads those files, so it takes longer and may
+	download blobs in a partial clone.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 2a2e370401..9ac4dcb162 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -33,8 +33,10 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "hex.h"
+#include "merge-ll.h"
 #include "revision.h"
 #include "tree-walk.h"
+#include "xdiff-interface.h"
 
 static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged] [(--forked <branch>)...]"),
@@ -207,6 +209,7 @@ enum delete_branch_flags {
 	DELETE_BRANCH_SKIP_UNMERGED = (1 << 2),
 	DELETE_BRANCH_NO_HEAD_FALLBACK = (1 << 3),
 	DELETE_BRANCH_DRY_RUN = (1 << 4),
+	DELETE_BRANCH_SQUASHED = (1 << 5),
 };
 
 static int check_branch_commit(const char *branchname, const char *refname,
@@ -850,10 +853,17 @@ static int branch_pushes_to_upstream(struct branch *branch,
 	return ret;
 }
 
+enum change_state {
+	CHANGE_MISSING,
+	CHANGE_LANDED,
+	CHANGE_NEEDS_MERGE,
+};
+
 struct branch_change {
 	char *path;
-	struct object_id branch_oid;
+	struct object_id base_oid, branch_oid, upstream_oid;
 	unsigned short branch_mode;
+	enum change_state state;
 };
 
 struct landing_search {
@@ -885,6 +895,8 @@ static void collect_branch_changes(struct landing_search *search,
 			   search->changes_alloc);
 		change = &search->changes[search->changes_nr++];
 		change->path = xstrdup(p->two->path);
+		oidcpy(&change->base_oid, DIFF_FILE_VALID(p->one) ?
+		       &p->one->oid : null_oid(the_hash_algo));
 		oidcpy(&change->branch_oid, DIFF_FILE_VALID(p->two) ?
 		       &p->two->oid : null_oid(the_hash_algo));
 		change->branch_mode = p->two->mode;
@@ -892,25 +904,67 @@ static void collect_branch_changes(struct landing_search *search,
 	diff_flush(&opt);
 }
 
-static int change_landed(const struct branch_change *change,
-			 struct commit *commit)
+static int merge_keeps_upstream(const struct branch_change *change)
+{
+	mmfile_t base, upstream, branch;
+	mmfile_t result = { 0 };
+	int ret;
+
+	read_mmblob(&base, the_repository->objects, &change->base_oid);
+	read_mmblob(&upstream, the_repository->objects, &change->upstream_oid);
+	read_mmblob(&branch, the_repository->objects, &change->branch_oid);
+	ret = ll_merge(&result, change->path, &base, "base",
+		       &upstream, "upstream", &branch, "branch",
+		       the_repository->index, NULL) == LL_MERGE_OK &&
+	      result.size == upstream.size &&
+	      !memcmp(result.ptr, upstream.ptr, upstream.size);
+
+	free(base.ptr);
+	free(upstream.ptr);
+	free(branch.ptr);
+	free(result.ptr);
+	return ret;
+}
+
+static enum change_state change_state_at(struct branch_change *change,
+					 struct commit *commit)
 {
-	struct object_id oid;
 	unsigned short mode;
 
 	if (get_tree_entry(the_repository, get_commit_tree_oid(commit),
-			   change->path, &oid, &mode))
-		return is_null_oid(&change->branch_oid);
-	return oideq(&oid, &change->branch_oid) &&
-	       mode == change->branch_mode;
+			   change->path, &change->upstream_oid, &mode))
+		return is_null_oid(&change->branch_oid) ?
+			CHANGE_LANDED : CHANGE_MISSING;
+	if (oideq(&change->upstream_oid, &change->branch_oid))
+		return mode == change->branch_mode ?
+			CHANGE_LANDED : CHANGE_MISSING;
+	if (is_null_oid(&change->base_oid) ||
+	    is_null_oid(&change->branch_oid) ||
+	    oideq(&change->upstream_oid, &change->base_oid) ||
+	    mode != change->branch_mode || !S_ISREG(mode))
+		return CHANGE_MISSING;
+	return CHANGE_NEEDS_MERGE;
 }
 
 static int changes_landed(struct landing_search *search,
-			  struct commit *commit)
+			  struct commit *commit, unsigned int flags)
 {
-	for (size_t i = 0; i < search->changes_nr; i++)
-		if (!change_landed(&search->changes[i], commit))
+	for (size_t i = 0; i < search->changes_nr; i++) {
+		struct branch_change *change = &search->changes[i];
+
+		change->state = change_state_at(change, commit);
+		if (change->state == CHANGE_MISSING ||
+		    (change->state == CHANGE_NEEDS_MERGE &&
+		     !(flags & DELETE_BRANCH_SQUASHED)))
 			return 0;
+	}
+	for (size_t i = 0; i < search->changes_nr; i++) {
+		struct branch_change *change = &search->changes[i];
+
+		if (change->state == CHANGE_NEEDS_MERGE &&
+		    !merge_keeps_upstream(change))
+			return 0;
+	}
 	return 1;
 }
 
@@ -961,7 +1015,8 @@ static int touches_changes(struct string_list *paths,
 
 static struct commit *find_landed_commit(struct landing_search *search,
 					 struct changed_paths *cache,
-					 struct diff_options *opt)
+					 struct diff_options *opt,
+					 unsigned int flags)
 {
 	struct commit *commit, *landed = NULL;
 	struct strvec args = STRVEC_INIT;
@@ -978,7 +1033,7 @@ static struct commit *find_landed_commit(struct landing_search *search,
 	while (!landed && (commit = get_revision(&revs)))
 		if (touches_changes(changed_paths_of(cache, opt, commit),
 				    search) &&
-		    changes_landed(search, commit))
+		    changes_landed(search, commit, flags))
 			landed = commit;
 	release_revisions(&revs);
 	clear_commit_marks(search->upstream, ALL_REV_FLAGS);
@@ -989,7 +1044,8 @@ static struct commit *find_landed_commit(struct landing_search *search,
 
 static void find_landed_commits(struct landing_search *searches,
 				size_t searches_nr,
-				struct strmap *landed_commits)
+				struct strmap *landed_commits,
+				unsigned int flags)
 {
 	struct changed_paths cache;
 	struct diff_options opt;
@@ -1018,7 +1074,7 @@ static void find_landed_commits(struct landing_search *searches,
 
 		if (!searches[i].changes_nr)
 			continue;
-		landed = find_landed_commit(&searches[i], &cache, &opt);
+		landed = find_landed_commit(&searches[i], &cache, &opt, flags);
 		if (landed)
 			strmap_put(landed_commits, searches[i].branch_name,
 				   landed);
@@ -1113,7 +1169,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 			strset_add(&deletable_branch_names, branch_name);
 	}
 
-	find_landed_commits(searches, searches_nr, &landed_commits);
+	find_landed_commits(searches, searches_nr, &landed_commits, flags);
 	for (size_t i = 0; i < searches_nr; i++) {
 		const char *branch_name = searches[i].branch_name;
 
@@ -1221,6 +1277,7 @@ int cmd_branch(int argc,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	struct strvec delete_merged = STRVEC_INIT;
 	int dry_run = 0;
+	int squashed = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -1279,6 +1336,8 @@ int cmd_branch(int argc,
 			PARSE_OPT_NONEG, parse_opt_strvec),
 		OPT_BOOL(0, "dry-run", &dry_run,
 			N_("with --delete-merged, only print which branches would be deleted")),
+		OPT_BOOL(0, "squashed", &squashed,
+			N_("with --delete-merged, also find branches merged after upstream changed their files")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -1343,6 +1402,8 @@ int cmd_branch(int argc,
 
 	if (dry_run && !delete_merged.nr)
 		die(_("--dry-run requires --delete-merged"));
+	if (squashed && !delete_merged.nr)
+		die(_("--squashed requires --delete-merged"));
 
 	if (recurse_submodules_explicit) {
 		if (!submodule_propagate_branches)
@@ -1385,7 +1446,8 @@ int cmd_branch(int argc,
 	} else if (delete_merged.nr) {
 		ret = delete_merged_branches(&delete_merged, argv,
 					     (quiet ? DELETE_BRANCH_QUIET : 0) |
-					     (dry_run ? DELETE_BRANCH_DRY_RUN : 0));
+					     (dry_run ? DELETE_BRANCH_DRY_RUN : 0) |
+					     (squashed ? DELETE_BRANCH_SQUASHED : 0));
 		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 5ba19a34e2..f3980106fa 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -2089,6 +2089,56 @@ test_expect_success '--delete-merged deletes a squash merged branch that was rev
 	)
 '
 
+test_expect_success '--delete-merged --squashed deletes a squash merged branch after upstream changed the same file' '
+	(
+		cd upstream &&
+		git checkout next &&
+		test_write_lines 1 2 3 4 5 6 7 8 9 10 >shared &&
+		git add shared &&
+		git commit -m "add shared" &&
+		git checkout main
+	) &&
+	setup_repo_for_delete_merged &&
+	(
+		cd repo &&
+		git checkout -b edits-shared --track origin/next &&
+		test_write_lines 1 two 3 4 5 6 7 8 9 10 >shared &&
+		git commit -a -m "edit line 2" &&
+		git push origin edits-shared &&
+		git checkout --detach
+	) &&
+	(
+		cd upstream &&
+		git checkout next &&
+		test_write_lines 1 2 3 4 five 6 7 8 9 10 >shared &&
+		git commit -a -m "edit line 5" &&
+		git checkout main
+	) &&
+	squash_merge_upstream edits-shared &&
+	squash=$(git -C upstream rev-parse --short next) &&
+	(
+		cd repo &&
+		git fetch origin &&
+		sha=$(git rev-parse --short edits-shared) &&
+
+		git branch --delete-merged origin/next >actual 2>&1 &&
+		test_must_be_empty actual &&
+		check_branches <<-\EOF &&
+		edits-shared
+		main
+		EOF
+
+		git branch --delete-merged origin/next --squashed \
+			>actual 2>&1 &&
+		echo "Deleted branch edits-shared (was $sha, landed as $squash)." >expect &&
+		test_cmp expect actual &&
+
+		check_branches <<-\EOF
+		main
+		EOF
+	)
+'
+
 test_expect_success '--delete-merged reports a merge plainly next to an unmerged branch' '
 	setup_repo_for_delete_merged &&
 	push_topic a-unmerged unmerged-work &&
@@ -2310,6 +2360,11 @@ test_expect_success "branch -d still deletes a deleteMerged=false branch" '
 	)
 '
 
+test_expect_success '--squashed without --delete-merged is rejected' '
+	test_must_fail git -C forked branch --squashed 2>err &&
+	test_grep "requires --delete-merged" err
+'
+
 test_expect_success '--dry-run without --delete-merged is rejected' '
 	test_must_fail git -C forked branch --dry-run 2>err &&
 	test_grep "requires --delete-merged" err
-- 
gitgitgadget
