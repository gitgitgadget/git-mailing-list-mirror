Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794211591;
	b=ZOhmJXyQgoR+h7yhkrPdjtIku4rYgB/KSs7KqkeV+3fx1KUr83DqpHj0FacbQyUH8gyf
	 EOnF3i6YTp2tsm8KRPugAxwNcpTzKccqWgWZPmbXCiDKesJY74Nb70vYrEg1qQ+Dq6Yuk
	 1/p3QzKwyOX8WQoVl0c3uz/22CaNElNyyhWRhjQqT/l/XThE65U5ue++SVxeClneVwWzf
	 kYtL/Vx8QtiT8nYVSvTgffeFUVeI8yEolEoST8TqUcw9m5sv6bCkC3Pl8LYCrUfiCulqw
	 xZNea4o2nSUH2Mkc4XXc4StlMf04mo5jrYpUjEBGdQLdg8KEQqCd+ScR5VIWxOx6fIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211591;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Zoho-Virus-Status:
	 X-Zoho-AV-Stamp:X-ZohoMailClient;
	bh=iglFCJHNMsUrPnXdUICcfJX66XW4g5MjuJmW3CDv3bg=;
	b=Kb6192tQuHcmp7kV9fitUWlsWQ+ErAembrGmIJz97YC44QUqNXmd/b6r6RTQCfI/102/
	 WylxjfE/q/Msb0o9S+FNmoMvBBOSa17f9o8lozAKDlwdAWw011UrGFf3JgAIpNS08sL98
	 RrjVQgsiy1hwxFtUWBGL/4f/mTIAv+VOezs5V5NtZxa0wx4r6BKCxjsFI6QTpF3Mpotau
	 KVst+3iZjCEdAW8DKv/5rA3IBCnhFe09S8P1EQw7efR3rRPB+4fh89b8Pp6G+LFmwKbLW
	 eXvFORLM3AcmZyognNmrbTtTqkSiCzFLS8w3CelsCNufiGwNwpFMozFqV1DTpR7C67w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=SeBgtrxs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.108
Received: from sender6-pp-e108.zoho.com (sender6-pp-e108.zoho.com [165.173.180.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0481606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 08:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0481606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=SeBgtrxs
ARC-Seal: i=1; a=rsa-sha256; t=1794211583; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ef3sNEq/RCwiz4+rs9iMf1lg5jJf0PtW+jWRZJgdkFVwkWfqGbSgTKeetqjb4ZcuIKUyNBQSrOjuRRmT7KJj4mFspDyUdI9HORxxA2KkTw/UhG+sXvG343lwA1AbdeNA4JF8zCznxXqKOhjBjM+EzxdRwWp/EaYEKeULP0erZBY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794211583; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iglFCJHNMsUrPnXdUICcfJX66XW4g5MjuJmW3CDv3bg=; 
	b=eZAXOmxTs4Wm98kdMbeFlCe8oyeYt0WzTvTc9QhpGxlyEmWEVVz1PzAxy+kPYB06TTbiTEvzQHEjnUapeRw4gXWgvutqUNszkek/ayul/4o4hDp0CtHKkQ/T9MsrtMsFv+4F+QPSIe1djtQbpxYQOAJBTtH0PmqgnL5UN9aWWYM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: a=rsa-sha256; b=SeBgtrxsTBSYFOr/6r8HMvjB6QMl5qXHauqHkZlRLa4xsTYf6ybJe2ggvlqkAMAWC7jDXrV9c1S+X2GHEpWxzG4qNXCrXibYjea6c0iD46ytRoUJMki824sB2gOvijy92268DN8WCfHIwL8vz02EhXmig1nlaeit9I/ggm6uygY=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=iglFCJHNMsUrPnXdUICcfJX66XW4g5MjuJmW3CDv3bg=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794211582485640.5767364516466;
	Mon, 9 Nov 2026 00:06:22 -0800 (PST)
Date: Mon, 9 Nov 2026 09:06:18 +0100
From: Miklos Vajna <vmiklos@collabora.com>
To: gitster@pobox.com
Cc: szeder.dev@gmail.com, ps@pks.im, git@vger.kernel.org
Subject: [PATCH v5 5/5] log: speed up --follow following renames for
 non-linear history
Message-ID: <ddcac2115e901994ae24351e81f1f487567ffa82.1794078554.git.vmiklos@collabora.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1794078554.git.vmiklos@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.182.33
X-ZohoMailClient: External

Test the performance of 'git log --stat --follow --
include/linux/rsc_table.h' on linux.git: since commit 304812ed33 (log:
improve --follow following renames for non-linear history, 2026-06-22),
it takes 6m43s, while it took about 28 seconds before.

What happens is that log_tree_diff() diffs each merge against all of its
parents with rename following. diff_tree_oid() only does the expensive
rename detection when the path is added relative to a parent, but that
is common for merges, e.g. when a branch forked before the path was
created merges mainline, and this slows down 'git log --follow'.

Fix the problem by first diffing the merge against its parents without
rename following, to find a parent where the path is unchanged. If there
is such a parent, then skip the diff against the other parents and just
follow the same path there. The exception is a parent that doesn't have
the path, but still needs renames to be followed:
- The merge base has the path, i.e. that side renamed or removed it, or
  there is no merge base, e.g. a subtree merge of unrelated histories.
- The merge base doesn't have the path, but the parent changed a file
  since then, and the merge dropped that change. A copy detection also
  finds that file as the source of the path, i.e. the other side renamed
  or copied the path from that file.
If the path changed relative to all parents, then diff against them with
rename following, as before. Given that this way a parent may be asked
to follow a path that it doesn't have, also adjust
remember_follow_pathspec(): if children disagree on what should be the
path for a commit, then prefer the path that exists in that commit.

Now the above use case takes 42s, somewhat close to the original cost.

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Miklos Vajna <vmiklos@collabora.com>
---
 log-tree.c | 159 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 155 insertions(+), 4 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 0aa27fb210..1dc02822f1 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -31,6 +31,7 @@
 #include "range-diff.h"
 #include "strmap.h"
 #include "tree.h"
+#include "tree-walk.h"
 #include "wildmatch.h"
 #include "write-or-die.h"
 #include "pager.h"
@@ -1110,6 +1111,22 @@ static void set_pathspec_to_single_path(struct pathspec *ps, const char *path)
 		       PATHSPEC_LITERAL_PATH, "", paths);
 }
 
+static int tree_has_path(struct rev_info *opt, struct object_id *tree,
+			 const char *path)
+{
+	struct object_id oid;
+	unsigned short mode;
+
+	return !get_tree_entry(opt->diffopt.repo, tree, path, &oid, &mode);
+}
+
+static int commit_has_path(struct rev_info *opt, struct commit *c,
+			   const char *path)
+{
+	parse_commit_or_die(c);
+	return tree_has_path(opt, get_commit_tree_oid(c), path);
+}
+
 static void remember_follow_pathspec(struct rev_info *opt,
 				     struct commit *c, const char *path)
 {
@@ -1122,8 +1139,12 @@ static void remember_follow_pathspec(struct rev_info *opt,
 		init_follow_pathspec_slab(opt->follow_pathspec_slab);
 	}
 	slot = follow_pathspec_slab_at(opt->follow_pathspec_slab, c);
-	if (*slot && !strcmp(*slot, path))
-		return;
+	/* If children of 'c' disagree on the path, prefer the one 'c' has. */
+	if (*slot) {
+		if (!strcmp(*slot, path) || commit_has_path(opt, c, *slot) ||
+		    !commit_has_path(opt, c, path))
+			return;
+	}
 	free(*slot);
 	*slot = xstrdup(path);
 }
@@ -1153,6 +1174,127 @@ void release_follow_pathspec_slab(struct rev_info *opt)
 	FREE_AND_NULL(opt->follow_pathspec_slab);
 }
 
+/* Find a parent where 'path' is the same as in the merge. */
+static struct commit *follow_same_parent(struct rev_info *opt,
+					 struct commit_list *parents,
+					 struct object_id *merge_tree)
+{
+	struct commit *same = NULL;
+
+	opt->diffopt.flags.follow_renames = 0;
+	for (; parents && !same; parents = parents->next) {
+		parse_commit_or_die(parents->item);
+		diff_tree_oid(get_commit_tree_oid(parents->item), merge_tree,
+			      "", &opt->diffopt);
+		if (!diff_queued_diff.nr)
+			same = parents->item;
+		diff_queue_clear(&diff_queued_diff);
+	}
+	opt->diffopt.flags.follow_renames = 1;
+	return same;
+}
+
+/*
+ * Did 'parent' change a file since 'base', but the merge tree dropped that
+ * change? I.e. the merge doesn't have the file or it's the same as in 'same'.
+ */
+static int follow_parent_changed_dropped_file(struct rev_info *opt,
+					      struct commit *base,
+					      struct commit *parent,
+					      struct commit *same,
+					      struct object_id *merge_tree)
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
+		struct object_id merge_oid, same_oid;
+		unsigned short mode;
+
+		if (!DIFF_FILE_VALID(p->two))
+			continue;
+		if (get_tree_entry(opt->diffopt.repo, merge_tree, p->two->path,
+				   &merge_oid, &mode))
+			ret = 1;
+		else
+			ret = !oideq(&merge_oid, &p->two->oid) &&
+			      !get_tree_entry(opt->diffopt.repo,
+					      get_commit_tree_oid(same),
+					      p->two->path, &same_oid, &mode) &&
+			      oideq(&merge_oid, &same_oid);
+	}
+	diff_queue_clear(&diff_queued_diff);
+	diff_free(&diff_opts);
+	return ret;
+}
+
+/* Is 'path' in the merge tree renamed or copied from a file of 'parent'? */
+static int follow_has_rename_source(struct rev_info *opt,
+				    struct commit *parent,
+				    struct object_id *merge_tree,
+				    const char *path)
+{
+	struct diff_options diff_opts;
+	int i, ret = 0;
+
+	repo_diff_setup(opt->diffopt.repo, &diff_opts);
+	diff_opts.flags.recursive = 1;
+	diff_opts.detect_rename = DIFF_DETECT_COPY;
+	diff_opts.rename_score = opt->diffopt.rename_score;
+	diff_opts.single_follow = path;
+	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_setup_done(&diff_opts);
+	diff_tree_oid(get_commit_tree_oid(parent), merge_tree, "", &diff_opts);
+	diffcore_std(&diff_opts);
+	for (i = 0; i < diff_queued_diff.nr && !ret; i++) {
+		struct diff_filepair *p = diff_queued_diff.queue[i];
+
+		ret = (p->status == DIFF_STATUS_RENAMED ||
+		       p->status == DIFF_STATUS_COPIED) &&
+		      !strcmp(p->two->path, path);
+	}
+	diff_queue_clear(&diff_queued_diff);
+	diff_free(&diff_opts);
+	return ret;
+}
+
+/*
+ * When the path in a merge tree is the same as in 'same', does the path still
+ * need renames to be followed in 'parent'?
+ */
+static int follow_needs_renames(struct rev_info *opt, struct commit *parent,
+				struct commit *same,
+				struct object_id *merge_tree, const char *path)
+{
+	struct commit_list *bases = NULL, *base;
+	int ret = 0, changed_dropped = 0;
+
+	if (parent == same || commit_has_path(opt, parent, path) ||
+	    !commit_has_path(opt, same, path))
+		return 0;
+	if (repo_get_merge_bases(opt->diffopt.repo, parent, same, &bases) < 0)
+		exit(128);
+	/* Unrelated histories, e.g. a subtree merge */
+	ret = !bases;
+	for (base = bases; base && !ret; base = base->next) {
+		ret = commit_has_path(opt, base->item, path);
+		if (!ret && !changed_dropped)
+			changed_dropped = follow_parent_changed_dropped_file(
+				opt, base->item, parent, same, merge_tree);
+	}
+	commit_list_free(bases);
+	if (!ret && changed_dropped)
+		ret = follow_has_rename_source(opt, parent, merge_tree, path);
+	return ret;
+}
+
 /* Show the remerge or combined diff of a merge commit */
 static int log_tree_merge_diff(struct rev_info *opt, struct commit *commit,
 			       struct commit_list *parents,
@@ -1187,6 +1329,7 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 	int all_need_diff = opt->diff || opt->diffopt.flags.exit_with_status;
 	int follow_only = 0;
 	char *path = NULL;
+	struct commit *same = NULL;
 
 	if (!all_need_diff && !opt->merges_need_diff)
 		return 0;
@@ -1234,6 +1377,8 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 	if (opt->diffopt.flags.follow_renames)
 		path = xstrdup_or_null(
 			pathspec_single_path(&opt->diffopt.pathspec));
+	if (path && is_merge && (follow_only || opt->first_parent_merges))
+		same = follow_same_parent(opt, parents, oid);
 
 	showed_log = 0;
 	all_parents = parents;
@@ -1241,8 +1386,14 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 		struct commit *parent = parents->item;
 
 		parse_commit_or_die(parent);
-		diff_tree_oid(get_commit_tree_oid(parent),
-			      oid, "", &opt->diffopt);
+		/*
+		 * Same as in a parent: follow the path as-is, unless renames
+		 * still need to be followed in this parent.
+		 */
+		if (!follow_only || !same ||
+		    follow_needs_renames(opt, parent, same, oid, path))
+			diff_tree_oid(get_commit_tree_oid(parent),
+				      oid, "", &opt->diffopt);
 		if (follow_only) {
 			diff_queue_clear(&diff_queued_diff);
 			opt->diffopt.found_follow = 0;
-- 
2.51.0

