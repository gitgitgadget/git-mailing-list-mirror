Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793390938;
	b=wrHjBDkqUxxT+9/iiz8vZB894I6xROOkSGoBoMj2fgzgc46ckBTon+C9X+Wh4IprtfGK
	 LsQhKlkLh3ZdZhuIzPKjkypXEkEuORMZGREIvI27xnPR5tl/YQSaR6ii3ngbA3SNCTMec
	 lIG0BRPBN0guOt4sfciR003ODXIeXnnmA9tgaSAQ/+uTFxxHI8aMmgkvmpgQhuxp1NiNB
	 T5FdXqr1258j4jySmEhJqh469rjwL6TKON7Wz+VWXpq8bvCZrzLgx5J41ya6ZhUasYe74
	 6UTWPBa6dn231RbmeyGk868Kfw1nYlEU0WILRY+/Q//xJDbH2clyTJJEYNcjOffWdxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793390938;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
	bh=+PwNrjJt3nT2KwvIcpjD6BBRBE41iCV9F5rdKcTOudw=;
	b=RmzmciKOeenNfG8GSoKkcaMRWrcObY+0T5npmivlvYR4xm7IBag0mFY1RE2XP+23HDlv
	 mPXx2TX6PPVm2zkY3AqagVWe3WgVFFgxeOHhAzjufR2LukCAdKQuVJZOs4Ooz9oP8QdO3
	 mqrewA5i1Z2mfFOVqRA1NdRWJYiSdyrbeYmVe7w/r1VuWSS0KMMei4jIrCuEaQEOFLyg+
	 OHjtp4GXvlnHqh52t3cKkpyH+b6XDUPn70ZLlx/ulTlUKE8bw1uW7VNFq5cXnAkQ31cIR
	 rLBoLl3DNlKfhetD+HciL7OH9Nn3Suumst/1L2F0iOFj4EiQJyZzXikY8EP+gdhOu+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=PxpnLNxV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5DD606A31C
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 20:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA5DD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=PxpnLNxV
ARC-Seal: i=1; a=rsa-sha256; t=1793390930; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cSZU9UN3OZwXoRg2FjgEpCMyXpJ0QxRcwsMbHTkO+t0UgrY5AwVZG5ReK+gCRKfugfzmeJ7pP9pPIKBsEE8R51dShHepkPi6qFuG7fq6kif6HQYmJCH4lSaJj0CJV0I0RDktZHW7Hm0SQEzDaYS1CqpdP2shKoWN8Zr0ykIc+SA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793390930; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+PwNrjJt3nT2KwvIcpjD6BBRBE41iCV9F5rdKcTOudw=; 
	b=Vmapnk8o7k8FFwiH5eUKBQ6WdR4XV6DlhzUC0YNLiwJqpT4IVL+h27dC/IlnPztZyclvZDo8i2RV9EJmxw7ygrkPkjaWsM+8P3oK7U3PVwArvFZwtmtMjrlUQP8lxzPoMJbTMOcg2tKYHXUSw4V2u6n23tEPtrlJMP39IUMvV2A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: a=rsa-sha256; b=PxpnLNxVma75CeuBE4axxH8HmQdTpxlJfA0ZIdWRyB3z6c53ppkg1Wl1XX+urw2vZ13oM/JhSbh03uUqZyNVOIJmFJSt8IwFYihtQgCDIGYyGEW1+pUPkjmFIzlEpiEkYqh2wSUhUQdOX4dhOBJgVI/H5GcJMwgF5HQ8nUKVahU=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=+PwNrjJt3nT2KwvIcpjD6BBRBE41iCV9F5rdKcTOudw=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179339092792725.043137035101267;
	Fri, 30 Oct 2026 13:08:47 -0700 (PDT)
Date: Fri, 30 Oct 2026 21:08:43 +0100
From: Miklos Vajna <vmiklos@collabora.com>
To: gitster@pobox.com
Cc: szeder.dev@gmail.com, ps@pks.im, git@vger.kernel.org
Subject: [PATCH v4 4/6] log: simplify --follow following renames for
 non-linear history
Message-ID: <b903152bc4bd977e4f4eeec9476d8faa2114b7b2.1793298331.git.vmiklos@collabora.com>
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
In-Reply-To: <cover.1793298331.git.vmiklos@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.7.7.1.5.4/291.452.71
X-ZohoMailClient: External

Code added in 304812ed33 (log: improve --follow following renames for
non-linear history, 2026-06-22) implemented the feature by introducing a
new propagate_follow_pathspec_to_parent() function which adds a new call
to diff_tree_oid(). Also it introduces a new loop to record what path
each parent of a merge commit should use when following a path.

This was working, but it caused a performance regression: e.g. 'git log
--stat --follow -- include/linux/rsc_table.h' in linux.git went from 28s
to 6m43s. The new code diffs each merge against each of its parents with
rename detection, which is expensive when a parent doesn't have the
followed path yet. Fixing this would require adding even more custom
code, instead of just extending the existing code in log_tree_diff(). So
first simplify the code here, and fix the performance regression in a
follow-up commit.

Remove propagate_follow_pathspec_to_parent() and the loop calling it
for each parent. Instead, record the path to follow for each parent in
the parent loop of log_tree_diff(), right after diff_tree_oid() updated
the pathspec in case of a rename. Merges are not diffed by default, so
with --follow, run the same loop for them as well, but without showing
anything. With -c, --cc or --remerge-diff, show the merge diff after the
loop. With --diff-merges=first-parent, keep diffing the other parents
silently, unless the walk only follows first parents. This gets rid of
the additional call to diff_tree_oid(). The rework has no positive
performance impact yet, it just simplifies the code.

The previous commit restores the path of the merge before diffing each
parent, and also after the loop, for
propagate_follow_pathspec_to_parent(). Keep restoring it between
parents, but not after the loop, since there is no later propagation
anymore.

Signed-off-by: Miklos Vajna <vmiklos@collabora.com>
---
 log-tree.c | 96 +++++++++++++++++++++++-------------------------------
 1 file changed, 41 insertions(+), 55 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index befc5c8b22..0aa27fb210 100644
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
@@ -1208,10 +1181,11 @@ static int log_tree_merge_diff(struct rev_info *opt, struct commit *commit,
 static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log_info *log)
 {
 	int showed_log;
-	struct commit_list *parents;
+	struct commit_list *parents, *all_parents;
 	struct object_id *oid;
 	int is_merge;
 	int all_need_diff = opt->diff || opt->diffopt.flags.exit_with_status;
+	int follow_only = 0;
 	char *path = NULL;
 
 	if (!all_need_diff && !opt->merges_need_diff)
@@ -1241,46 +1215,73 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
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
 
-	if (is_merge && opt->diffopt.flags.follow_renames)
+	if (opt->diffopt.flags.follow_renames)
 		path = xstrdup_or_null(
 			pathspec_single_path(&opt->diffopt.pathspec));
 
 	showed_log = 0;
+	all_parents = parents;
 	for (;;) {
 		struct commit *parent = parents->item;
 
-		/* Diff each parent with the path of the merge */
-		if (path)
-			set_pathspec_to_single_path(&opt->diffopt.pathspec,
-						    path);
 		parse_commit_or_die(parent);
 		diff_tree_oid(get_commit_tree_oid(parent),
 			      oid, "", &opt->diffopt);
-		log_tree_diff_flush(opt);
+		if (follow_only) {
+			diff_queue_clear(&diff_queued_diff);
+			opt->diffopt.found_follow = 0;
+		} else {
+			log_tree_diff_flush(opt);
+		}
 
 		showed_log |= !opt->loginfo;
 
+		/* The diff updated the pathspec in case of a rename */
+		if (path)
+			remember_follow_pathspec(opt, parent,
+				pathspec_single_path(&opt->diffopt.pathspec));
+
 		/* Set up the log info for the next parent, if any.. */
 		parents = parents->next;
-		if (!parents || opt->first_parent_merges)
+		if (!parents)
 			break;
+		if (opt->first_parent_merges) {
+			if (!path || opt->first_parent_only)
+				break;
+			/* Only find the path to follow in the other parents */
+			follow_only = 1;
+		}
+		if (path)
+			set_pathspec_to_single_path(&opt->diffopt.pathspec,
+						    path);
+		if (follow_only)
+			continue;
 		log->parent = parents->item;
 		opt->loginfo = log;
 	}
-	/* Propagate to parents starting from the path of the merge, too */
-	if (path)
-		set_pathspec_to_single_path(&opt->diffopt.pathspec, path);
+	if (follow_only && (opt->remerge_diff || opt->combine_merges)) {
+		/* Show the merge diff with the path of this commit */
+		if (path)
+			set_pathspec_to_single_path(&opt->diffopt.pathspec,
+						    path);
+		showed_log = log_tree_merge_diff(opt, commit, all_parents, oid);
+	}
 	free(path);
 	return showed_log;
 }
@@ -1319,21 +1320,6 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
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
-- 
2.56.0

