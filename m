Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793390838;
	b=EhO5PNmdTBdI2VIwUkK1+btnIwuPisq8M4aMKOQMcRNHUk8LEZYkfusoeov7Jirc1D8O
	 T0oUCwCpa5jKZ6Jppm6MwF0aMr792Wpx2YfOuQbQlPIc2g++Lx5EZNamULtsFKwZQ/F/k
	 oTS8Glf8lCyxJvpKoegc/PzKErMTABkopxaUa6SVnMSJWtdvYS0EREu3tzbVv3bChf8Nw
	 eQRN36kWro1KQL/waK+ivHzC/3P/rx0HYl/QQvcX0Mj6GjQWpdc3xHO9naKAcNzFwRidH
	 +M5gh2eyS+2Ag5hCdBUhRxOkzwxHWewB0bMhdyx/OwxnUibKR2GUSSlxofossD2YO9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793390838;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
	bh=krkUOFCfC4H7KoMGBnYia7532fuInjFi6CWvZA2H84E=;
	b=3xMIvaZ9ipfU9+a7v1CNshxlFexupjuLO/P98jd/OntMasN2ZMStQQ2PlJKbaIRlSia6
	 A/EspIM4kp4U6Pq+XfF6vZXV7RQ+a9BkUGMMPlZizKICquf2qV1R/bV95QVNxaTPHjmiC
	 CKrE6wj98r0DoQKfchq1BiS7YldA6JqB/8/OZwhselYyqIW5BpGTuuqxqMLle2otV7T3L
	 l24RYzbsBb4iO7mDxbK3u7uU92R5KXhxodr/vJxlkxz8W5N/s36ZEKZa6iMokrf9u4n/D
	 jP/HSrmXk1joTQ5ZBqLDj/ErqeVI3VoUcUoy0TNTB1VBxSxsQ2BdvdwLN9mQ5+EEZkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=bUmFH+97;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7E3606A31C
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 20:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF7E3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=bUmFH+97
ARC-Seal: i=1; a=rsa-sha256; t=1793390828; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RBPPPRvKZpyTyhe1J5KI8Euh6BGoRN5yEneb1ROpiB9/yWafliYnVeahhl6C1s2G1lc9v0ImaSy/9mEZG6F66yTBfuVEHd2cC8uxXRe8ur9uVY4cpNq8i2zvtpvzCji8ehEcWTyWmyAtacUa293VtnQwhV2ybRCb//X/X8IfYOg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793390828; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=krkUOFCfC4H7KoMGBnYia7532fuInjFi6CWvZA2H84E=; 
	b=UgBN4NxMZqX3H6E95sjHAadbcycGe81oO2VUG/l1ziBR5yihdUZOLHYAuqLQexo0BEBwCK7X9Fu6QOux7t+1o+yxJHWmbejNEne03yw+e0rRicEdApRU2Eg41Bj5/sw06X89Y0at8Di3FRbyK6aATLzuOKxaziNar/qmCsTZNKY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: a=rsa-sha256; b=bUmFH+97kivyV3Wq0dc++v/ACj1tdZPPWCU/Pu0oEt7zVrU1UmF0YTXchvaCRf5PUcc/pxnzj7EkKSl74hg6J/zk4QpqMSFcWfPyWo7M4u4sWS75DZIEX8WZJ2/CAlZ8QrDRIK7uOV0p0SolkEHnPy4DuVhUC4S+NftIFyJb/Cg=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=krkUOFCfC4H7KoMGBnYia7532fuInjFi6CWvZA2H84E=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793390825280690.1501719504074;
	Fri, 30 Oct 2026 13:07:05 -0700 (PDT)
Date: Fri, 30 Oct 2026 21:07:00 +0100
From: Miklos Vajna <vmiklos@collabora.com>
To: gitster@pobox.com
Cc: szeder.dev@gmail.com, ps@pks.im, git@vger.kernel.org
Subject: [PATCH v4 0/6] log: speed up --follow following renames for
 non-linear history
Message-ID: <cover.1793298331.git.vmiklos@collabora.com>
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
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/293.370.16
X-ZohoMailClient: External

Hi Patrick,

Thanks for the reviews of v3. Changes in v4:

- The -m --follow fix is now a separate patch (3/6), so the simplify
  patch (4/6) no longer changes behavior. The two bugs you pointed out
  in the old commit message have one cause: the followed path is not
  restored between the parents of a merge. So 3/6 fixes both. The
  commit message of 4/6 now says upfront that 304812ed33 (log: improve
  --follow following renames for non-linear history, 2026-06-22) caused
  a performance regression.

- Fixed the brace style nit in the simplify patch.

- Patch 6/6 fixes the case you found, where the speedup lost history:
  one side of the merge renamed the path, and the other side, whose
  version the merge dropped, edited the old name. It uses your test.
  I kept it separate from the speedup patch, which is complicated
  enough already. With the extra check, the linux.git case still takes
  about 37s.

- I also noticed that the simplify patch lost history with
  --diff-merges=first-parent, which diffs merges only against their
  first parent, but still walks all parents. Fixed that and added a
  test for it to 1/6.

Thanks,

Miklos

Miklos Vajna (6):
  t4219: test more --follow cases across merges
  log: extract showing the remerge/combined diff of a merge commit
  log: fix -m --follow losing the history of later parents
  log: simplify --follow following renames for non-linear history
  log: speed up --follow following renames for non-linear history
  log: fix --follow following an edit on a side the merge did not take

 log-tree.c                  | 265 +++++++++++++++++++++++++++++-------
 t/t4219-log-follow-merge.sh | 171 +++++++++++++++++++++++
 2 files changed, 388 insertions(+), 48 deletions(-)

Interdiff against v3:
diff --git a/log-tree.c b/log-tree.c
index d5ce58d91d..c2c3473f25 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1111,15 +1111,20 @@ static void set_pathspec_to_single_path(struct pathspec *ps, const char *path)
 		       PATHSPEC_LITERAL_PATH, "", paths);
 }
 
-static int commit_has_path(struct rev_info *opt, struct commit *c,
-			   const char *path)
+static int tree_has_path(struct rev_info *opt, struct object_id *tree,
+			 const char *path)
 {
 	struct object_id oid;
 	unsigned short mode;
 
+	return !get_tree_entry(opt->diffopt.repo, tree, path, &oid, &mode);
+}
+
+static int commit_has_path(struct rev_info *opt, struct commit *c,
+			   const char *path)
+{
 	parse_commit_or_die(c);
-	return !get_tree_entry(opt->diffopt.repo, get_commit_tree_oid(c), path,
-			       &oid, &mode);
+	return tree_has_path(opt, get_commit_tree_oid(c), path);
 }
 
 static void remember_follow_pathspec(struct rev_info *opt,
@@ -1169,26 +1174,97 @@ void release_follow_pathspec_slab(struct rev_info *opt)
 	FREE_AND_NULL(opt->follow_pathspec_slab);
 }
 
+/*
+ * Did 'parent' change a file since 'base' that the merge (with tree 'oid') no
+ * longer has? Only such a file can be the source of a rename on the other side
+ * of the merge that still needs to be followed in 'parent'.
+ */
+static int follow_parent_changed_dropped_file(struct rev_info *opt,
+					      struct commit *base,
+					      struct commit *parent,
+					      struct object_id *oid)
+{
+	struct diff_options diff_opts;
+	int i, ret = 0;
+
+	repo_diff_setup(opt->diffopt.repo, &diff_opts);
+	diff_opts.flags.recursive = 1;
+	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_setup_done(&diff_opts);
+	diff_tree_oid(get_commit_tree_oid(base), get_commit_tree_oid(parent),
+		      "", &diff_opts);
+	for (i = 0; i < diff_queued_diff.nr && !ret; i++) {
+		struct diff_filepair *p = diff_queued_diff.queue[i];
+
+		ret = DIFF_FILE_VALID(p->two) &&
+		      !tree_has_path(opt, oid, p->two->path);
+	}
+	diff_queue_clear(&diff_queued_diff);
+	diff_free(&diff_opts);
+	return ret;
+}
+
+/*
+ * Is 'path' in the merge (with tree 'oid') renamed from a file of 'parent'?
+ * Only look at the files that the merge deleted, not at all files of 'parent'
+ * like --follow does.
+ */
+static int follow_has_rename_source(struct rev_info *opt,
+				    struct commit *parent,
+				    struct object_id *oid, const char *path)
+{
+	struct diff_options diff_opts;
+	int i, ret = 0;
+
+	repo_diff_setup(opt->diffopt.repo, &diff_opts);
+	diff_opts.flags.recursive = 1;
+	diff_opts.detect_rename = DIFF_DETECT_RENAME;
+	diff_opts.rename_score = opt->diffopt.rename_score;
+	diff_opts.single_follow = path;
+	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_setup_done(&diff_opts);
+	diff_tree_oid(get_commit_tree_oid(parent), oid, "", &diff_opts);
+	diffcore_std(&diff_opts);
+	for (i = 0; i < diff_queued_diff.nr && !ret; i++) {
+		struct diff_filepair *p = diff_queued_diff.queue[i];
+
+		ret = p->status == DIFF_STATUS_RENAMED &&
+		      !strcmp(p->two->path, path);
+	}
+	diff_queue_clear(&diff_queued_diff);
+	diff_free(&diff_opts);
+	return ret;
+}
+
 /*
  * When the path in a merge is the same as in 'same', does the path still need
  * renames to be followed in 'parent'? Only if the merge has the path, 'parent'
- * doesn't have it, but its fork point with 'same' had it, e.g. 'parent'
- * renamed the path.
+ * doesn't have it, and either:
+ *
+ * - its fork point with 'same' had it, e.g. 'parent' renamed the path, or
+ * - 'same' renamed the path from a file that 'parent' changed.
  */
 static int follow_needs_renames(struct rev_info *opt, struct commit *parent,
-				struct commit *same, const char *path)
+				struct commit *same, struct object_id *oid,
+				const char *path)
 {
 	struct commit_list *bases = NULL, *base;
-	int ret = 0;
+	int ret = 0, changed_dropped = 0;
 
 	if (commit_has_path(opt, parent, path) ||
 	    !commit_has_path(opt, same, path))
 		return 0;
 	if (repo_get_merge_bases(opt->diffopt.repo, parent, same, &bases) < 0)
 		exit(128);
-	for (base = bases; base && !ret; base = base->next)
+	for (base = bases; base && !ret; base = base->next) {
 		ret = commit_has_path(opt, base->item, path);
+		if (!ret && !changed_dropped)
+			changed_dropped = follow_parent_changed_dropped_file(
+				opt, base->item, parent, oid);
+	}
 	commit_list_free(bases);
+	if (!ret && changed_dropped)
+		ret = follow_has_rename_source(opt, parent, oid, path);
 	return ret;
 }
 
@@ -1295,8 +1371,9 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 			changed = diff_queued_diff.nr;
 			diff_queue_clear(&diff_queued_diff);
 			opt->diffopt.found_follow = 0;
-		} else
+		} else {
 			log_tree_diff_flush(opt);
+		}
 
 		showed_log |= !opt->loginfo;
 
@@ -1312,7 +1389,7 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 			     parents = parents->next) {
 				if (parents->item != parent &&
 				    follow_needs_renames(opt, parents->item,
-							 parent, path))
+							 parent, oid, path))
 					tail = &commit_list_insert(parents->item,
 								   tail)->next;
 				else
@@ -1340,8 +1417,15 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 			opt->diffopt.flags.follow_renames = 1;
 			parents = all_parents;
 		}
-		if (!parents || opt->first_parent_merges)
+		if (!parents)
 			break;
+		if (opt->first_parent_merges && !follow_only) {
+			if (!path || opt->first_parent_only)
+				break;
+			/* Only find the path to follow in the other parents */
+			follow_only = 1;
+			opt->diffopt.flags.follow_renames = 0;
+		}
 		if (path)
 			set_pathspec_to_single_path(&opt->diffopt.pathspec,
 						    path);
diff --git a/t/t4219-log-follow-merge.sh b/t/t4219-log-follow-merge.sh
index c8474ed151..a85fb78ca2 100755
--- a/t/t4219-log-follow-merge.sh
+++ b/t/t4219-log-follow-merge.sh
@@ -254,4 +254,47 @@ test_expect_success '--follow follows a rename on the side the merge did not tak
 	test_cmp expect actual
 '
 
+test_expect_success '--follow with --diff-merges=first-parent follows all parents' '
+	git -C keep log --follow --diff-merges=first-parent --no-patch \
+		--pretty=tformat:%s F >actual &&
+	cat >expect <<-\EOF &&
+	B2: update G
+	B1: rename F to G
+	A1: update F in place
+	O: add F
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup merge keeping the renamed path, other side edited the old one' '
+	git init keep-renamed &&
+	printf "line 1\nline 2\nline 3\nline 4\nline 5\n" >keep-renamed/F &&
+	git -C keep-renamed add F &&
+	test_tick &&
+	git -C keep-renamed commit -m "O: add F" &&
+	git -C keep-renamed branch B &&
+	git -C keep-renamed mv F G &&
+	test_tick &&
+	git -C keep-renamed commit -m "A1: rename F to G on master" &&
+
+	git -C keep-renamed checkout B &&
+	printf "line 1\nline 2\nline 3\nline 4 T\nline 5\n" >keep-renamed/F &&
+	test_tick &&
+	git -C keep-renamed commit -am "B2: update F on B" &&
+
+	git -C keep-renamed checkout master &&
+	test_tick &&
+	git -C keep-renamed merge -s ours -m "M: merge B, keep G, drop F" B
+'
+
+test_expect_success '--follow follows an edit on the side the merge did not take' '
+	git -C keep-renamed log --follow --pretty=tformat:%s G >actual &&
+	cat >expect <<-\EOF &&
+	B2: update F on B
+	A1: rename F to G on master
+	O: add F
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.56.0

