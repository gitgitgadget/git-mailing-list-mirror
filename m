Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792702015;
	b=d6pt/GOqFt44Cx9q/vLyFkFRyn0IHl5IfngcvIFtdaXN70l6K0fZTS45abbwmIL1bV0y
	 pGU/e43Kp7cu2Bk+FhSodDceUL9K41EN2Rl4g2ZldSsVzksWIA4ifMNN6UYmIRR+liUWc
	 WfolEeBLo3WVaXSKEIlQdE8bEfrSXJTxxArAdXUfKdGDGLfXoER2RWcYI8v18V8v+XEt8
	 DKo21lOdGzy5kFC+3Wd5d28hfRpgr5HW8i29my8MMpXewcV2d88nvX8CoyV9fTtm/ELPW
	 vYUoMZ/yiPk8P2evecKhbzFGDj9vxhe7yCW0b5E+uwMnChSeZxQ5Yy76XWATi8+g2ng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792702015;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
	bh=5S3gicRCWwnaCRHPPxwAAUEm4rqOhg7aO3yA4C5vVvk=;
	b=VqjRvljCQOThY8+XsLiKs9/H06FSmnFP6Q3EOQPgwjOtcgxmNm6BjKSwWkzDLhN+gHhJ
	 cfmemaIGrDAsJI+DToaZat6VbdPrsQbN0aBErTxGWNj6yu0LSiGOTrj48FsIWYAa2H9Bh
	 k5wthSQ3Saf+D+GEyvUgBKis2L2Hn6shnizeyzBEF9IBfVzAbs3tHxrjCYmbfq14yIxJa
	 5AoGVneeakw5fJ0JnZHq23Y0kVE23dSg5GtsAAyZDSNcIQN7Z2pIMCHxEb45OtidXaTW3
	 hfgILqWccsuPuBLgV8RJmTt2IDIy/dF5FHqmsbzDFqCv71w/vdW8LUXLeEQybffT8kw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=vmiklos@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=kMbMjdUX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A69A606A31E
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 20:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A69A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=vmiklos@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=kMbMjdUX
ARC-Seal: i=1; a=rsa-sha256; t=1792702007; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IxG/tOQCwZQDuGcgN1QhgDWyjqDMCIYEuYzpZs7WGwrsSe2SNoDV/9Gc6MEZAqekz5t2fh0AdCDcijLV0A9C8S2YadBhDw3M9KYlPiyLvAvj2BzCLCxIqjKirJ2JporAAJ1qiybx6ZTFIdk7p7Bg1/jP+HueBdGE51jMy2RqcoQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792702007; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5S3gicRCWwnaCRHPPxwAAUEm4rqOhg7aO3yA4C5vVvk=; 
	b=N8jfNDmo9QTW9NRUjw9QY7d54doBempg8Ce30C67ITqoOKcT7qhQvK83G/chnrt5EDei3vz5AvJezSG0DBzFZ2lgBtOtXB7DyMgCdzP31eLP0CEvPn2Mmx7YwZQoHPFobrCtII6ezvKkiUaNrA7k5+dg4A0J4ULKCaKD0vdW7F8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792702006;
	s=zohomail; d=collabora.com; i=vmiklos@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=5S3gicRCWwnaCRHPPxwAAUEm4rqOhg7aO3yA4C5vVvk=;
	b=kMbMjdUXAPHX5X0x8MaZ59KcEU4vlPz+eQWGlAJKq8TkfyKACkc+VQ+HH1DeVLRy
	ThpC4jEm7ZH6KQKp/eP8OdSYexyyXBh5iUHwHlbD21wFoPKJNNqC0IjhxiS8dJrF8YO
	LZX7pvQ1wNcszCCxrhUwvCAggBBPwn/td9HFmB34=
Received: by smtp.zohomail.com with SMTPS id 1792702003365780.5556080506528;
	Thu, 22 Oct 2026 13:46:43 -0700 (PDT)
Date: Thu, 22 Oct 2026 22:46:39 +0200
From: Miklos Vajna <vmiklos@collabora.com>
To: gitster@pobox.com
Cc: szeder.dev@gmail.com, ps@pks.im, git@vger.kernel.org
Subject: [PATCH v3 3/4] log: simplify --follow following renames for
 non-linear history
Message-ID: <ba2dc35c77b95803f184e63cc9933e3765bd1417.1792701579.git.vmiklos@collabora.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1792701579.git.vmiklos@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/292.682.56
X-ZohoMailClient: External

Code added in 304812ed33 (log: improve --follow following renames for
non-linear history, 2026-06-22) implemented the feature by introducing a
new propagate_follow_pathspec_to_parent() function which adds a new call
to diff_tree_oid(). Also it introduces a new loop to record what path
each parent of a merge commit should use when following a path.

This was working, but fixing its performance would require adding even
more custom code, instead of just extending the existing code in
log_tree_diff().

Remove propagate_follow_pathspec_to_parent() and the loop calling it
for each parent. Instead, record the path to follow for each parent in
the parent loop of log_tree_diff(), right after diff_tree_oid() updated
the pathspec in case of a rename. Merges are not diffed by default, so
with --follow, run the same loop for them as well, but without showing
anything. With -c, --cc or --remerge-diff, show the merge diff after the
loop. This gets rid of the additional call to diff_tree_oid(). The
rework has no positive performance impact yet, it just simplifies the
code.

This also fixes 'git log -m --follow': -m diffs the merge against each
parent with rename following, so a rename found against the first parent
updated the followed path, and the second parent was then diffed with
the already renamed path. Also, propagate_follow_pathspec_to_parent()
started from that same updated path, so history was lost on the side of
the second parent. Now the path of the merge is restored before diffing
each parent. Add a test for this, which shows the full history of the
diamond case with -m.

Signed-off-by: Miklos Vajna <vmiklos@collabora.com>
---
 log-tree.c                  | 84 +++++++++++++++++--------------------
 t/t4219-log-follow-merge.sh | 16 +++++++
 2 files changed, 54 insertions(+), 46 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index b4c97b86f5..c5ac6c2bcb 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1153,33 +1153,6 @@ void release_follow_pathspec_slab(struct rev_info *opt)
 	FREE_AND_NULL(opt->follow_pathspec_slab);
 }
 
-/* Compute a path to follow in parent, if there is one */
-static void propagate_follow_pathspec_to_parent(struct rev_info *opt,
-						struct commit *commit,
-						struct commit *parent)
-{
-	struct diff_options diff_opts;
-	const char *path;
-
-	parse_commit_or_die(parent);
-	repo_diff_setup(opt->diffopt.repo, &diff_opts);
-	copy_pathspec(&diff_opts.pathspec, &opt->diffopt.pathspec);
-	diff_opts.flags.recursive = 1;
-	diff_opts.flags.follow_renames = 1;
-	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
-	diff_setup_done(&diff_opts);
-	diff_tree_oid(get_commit_tree_oid(parent),
-		      get_commit_tree_oid(commit),
-		      "", &diff_opts);
-
-	path = pathspec_single_path(&diff_opts.pathspec);
-	if (path)
-		remember_follow_pathspec(opt, parent, path);
-
-	diff_queue_clear(&diff_queued_diff);
-	diff_free(&diff_opts);
-}
-
 /* Show the remerge or combined diff of a merge commit */
 static int log_tree_merge_diff(struct rev_info *opt, struct commit *commit,
 			       struct commit_list *parents,
@@ -1208,10 +1181,12 @@ static int log_tree_merge_diff(struct rev_info *opt, struct commit *commit,
 static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log_info *log)
 {
 	int showed_log;
-	struct commit_list *parents;
+	struct commit_list *parents, *all_parents;
 	struct object_id *oid;
 	int is_merge;
 	int all_need_diff = opt->diff || opt->diffopt.flags.exit_with_status;
+	int follow_only = 0;
+	char *path = NULL;
 
 	if (!all_need_diff && !opt->merges_need_diff)
 		return 0;
@@ -1240,35 +1215,67 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 	}
 
 	if (is_merge) {
-		if (opt->remerge_diff || opt->combine_merges)
+		int merge_diff = opt->remerge_diff || opt->combine_merges;
+
+		if (merge_diff && !opt->diffopt.flags.follow_renames)
 			return log_tree_merge_diff(opt, commit, parents, oid);
-		if (opt->separate_merges) {
+		if (opt->separate_merges && !merge_diff) {
 			if (!opt->first_parent_merges) {
 				/* Show parent info for multiple diffs */
 				log->parent = parents->item;
 			}
+		} else if (opt->diffopt.flags.follow_renames) {
+			/* Diff only to find the path to follow in parents */
+			follow_only = 1;
 		} else
 			return 0;
 	}
 
+	if (opt->diffopt.flags.follow_renames)
+		path = xstrdup_or_null(
+			pathspec_single_path(&opt->diffopt.pathspec));
+
 	showed_log = 0;
+	all_parents = parents;
 	for (;;) {
 		struct commit *parent = parents->item;
 
 		parse_commit_or_die(parent);
 		diff_tree_oid(get_commit_tree_oid(parent),
 			      oid, "", &opt->diffopt);
-		log_tree_diff_flush(opt);
+		if (follow_only) {
+			diff_queue_clear(&diff_queued_diff);
+			opt->diffopt.found_follow = 0;
+		} else
+			log_tree_diff_flush(opt);
 
 		showed_log |= !opt->loginfo;
 
+		/* The diff updated the pathspec in case of a rename */
+		if (path)
+			remember_follow_pathspec(opt, parent,
+				pathspec_single_path(&opt->diffopt.pathspec));
+
 		/* Set up the log info for the next parent, if any.. */
 		parents = parents->next;
 		if (!parents || opt->first_parent_merges)
 			break;
+		if (path)
+			set_pathspec_to_single_path(&opt->diffopt.pathspec,
+						    path);
+		if (follow_only)
+			continue;
 		log->parent = parents->item;
 		opt->loginfo = log;
 	}
+	if (follow_only && (opt->remerge_diff || opt->combine_merges)) {
+		/* Show the merge diff with the path of this commit */
+		if (path)
+			set_pathspec_to_single_path(&opt->diffopt.pathspec,
+						    path);
+		showed_log = log_tree_merge_diff(opt, commit, all_parents, oid);
+	}
+	free(path);
 	return showed_log;
 }
 
@@ -1306,21 +1313,6 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 		fprintf(opt->diffopt.file, "\n%s\n", opt->break_bar);
 	if (shown)
 		show_diff_of_diff(opt);
-
-	/* Record what path each parent of this commit should use */
-	if (opt->diffopt.flags.follow_renames) {
-		struct commit_list *parents = get_saved_parents(opt, commit);
-		if (parents && parents->next) {
-			struct commit_list *p;
-			for (p = parents; p; p = p->next)
-				propagate_follow_pathspec_to_parent(opt, commit,
-								    p->item);
-		} else if (parents) {
-			remember_follow_pathspec(opt, parents->item,
-				pathspec_single_path(&opt->diffopt.pathspec));
-		}
-	}
-
 	opt->loginfo = NULL;
 	maybe_flush_or_die(opt->diffopt.file, "stdout");
 	opt->diffopt.no_free = no_free;
diff --git a/t/t4219-log-follow-merge.sh b/t/t4219-log-follow-merge.sh
index 9616ac64ed..c8474ed151 100755
--- a/t/t4219-log-follow-merge.sh
+++ b/t/t4219-log-follow-merge.sh
@@ -144,6 +144,22 @@ do
 	'
 done
 
+test_expect_success '--follow follows renames through a fork with -m' '
+	git -C diamond log --follow -m --pretty=tformat:%s path >log &&
+	grep "^[A-Z]: " log | sort >actual &&
+	cat >expect <<-\EOF &&
+	A: add path0
+	B: modify path0 on upper
+	C: modify path0 on lower
+	M: merge with rename to path
+	M: merge with rename to path
+	X: rename path0 to path1
+	Y: rename path0 to path2
+	Z: modify path
+	EOF
+	test_cmp expect actual
+'
+
 # Build a merge that takes the renamed path from the second parent, while the
 # first parent only has the old path. $2 decides which side is committed first,
 # which decides the walk order.
-- 
2.56.0

