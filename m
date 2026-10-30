Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793391029;
	b=mCHfnytUDWKjz+e7DBo90zP5v34dnrlwQfej+ol4tqARakq9SFsv+zJpCNWTz/TJnNAB
	 WszLsnEDthBx4BdCksbYa5+0OuFNuzyh+F/xN5BlF3miCCeoBINX0F0fDmmvATNFkcdmU
	 OWfJ4uMea1rhgxrMs6qPsRJUYPxEoDiDnbqL5+zx46wvRXMiLfZISL2sOAa8j6+yPJPrN
	 0oJEK5+rWx6ceSqD5qCHiGN9UOFLy7p4WL79twe6erN2rwWLgJGBpI8rinMqBmfevBJkE
	 8S7nnZgS5f0v93IYIMxKqPDw4BqulR5oFJOrbf8MH7aM5iyYVkKGSAjKGShzpb0XBEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793391029;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
	bh=6PtfeTXsJVwTSiTLixur2HnME17FNzOIT81qAYhCEqQ=;
	b=2cbyZcgw1xOVtBUE2aX59rW7pwxKm8rfuJNUDPnHFjnu/nEI+So971vCWxAxoXqZ/hOi
	 1SJDC6OqaamXZNqKu9ok8zL48kiZJ4fqq6koBpERUoK1r9NWSZr0ewHXqftOEEGOIAm3Y
	 LQcaudsR0zk5b0Iui5nQjsTaO4ocPRvHyDKivkxxsi9ygN8EUlLeS2pFw1pcNh5+Vh21A
	 pMLfAoZbv5xEbfmU9GY1eKlM1ClR73H0WRke6LAHpKmQdlYd7wnPrLi2/faulSBJ1Ntev
	 s6iM7jTzw4BthvdUUc9M7zQYyI21M3Wxns7EFw8VMegtahBqRm0qgB1iGER+Dm+WVvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=WZlAv36i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D269606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 20:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D269606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=WZlAv36i
ARC-Seal: i=1; a=rsa-sha256; t=1793391020; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=d0oQgeXKtya4Kz8cf/ko3GZujQjatkPPfmLs90kroRlgObmyNfdCj6ihkMuW4mnZ+E4K7NsvXHRd/8+3VwfYixZ1LPRSB+0KwUH10dq5EL9p8RImt1fDARPSZy9JM45o55x0kmFZEROUx+kvT7QOagq//txZOlW1gk1e3YQ8mhg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793391020; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6PtfeTXsJVwTSiTLixur2HnME17FNzOIT81qAYhCEqQ=; 
	b=kuyrQVxFvGJPh/togSMABtNIUYkVx0N0omhwYQbwzZmxYUdGAHU/oyupRswi07U7sueGchc+eFmb7j4HnTyKDq5+AHhXN5M9F/laTMHA6rqSIl0B/fOwvY8gtDtGfsutFCkcSHQ5jdNsiS35+0TMZG6aF0rkyzqj3mYsPsgPo3Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: a=rsa-sha256; b=WZlAv36iJKi//6jkCxvD4sgjZGxCMt6QpcGInAD9SDju59gBWDnePnw8mujHBtoCjxJMkBGH9CbLgZdP+xXKsWuB3ZAWx8t8lUg9ugqGlr68UUnc/altlgh7IbMFm90BEWZ83PqCNxgfzlYqSTSMGjnRPz4HvTHkrhszQtxItrg=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=6PtfeTXsJVwTSiTLixur2HnME17FNzOIT81qAYhCEqQ=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793391018088704.8541088389551;
	Fri, 30 Oct 2026 13:10:18 -0700 (PDT)
Date: Fri, 30 Oct 2026 21:10:14 +0100
From: Miklos Vajna <vmiklos@collabora.com>
To: gitster@pobox.com
Cc: szeder.dev@gmail.com, ps@pks.im, git@vger.kernel.org
Subject: [PATCH v4 6/6] log: fix --follow following an edit on a side the
 merge did not take
Message-ID: <7be8cfb3ba58a4d4dc040fb2f229524599524b78.1793298331.git.vmiklos@collabora.com>
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
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/293.370.16
X-ZohoMailClient: External

Take a history where F is renamed to G on master, F is edited on a side
branch, and the side branch is merged with '-s ours', so the merge keeps
G and drops F. Here 'git log --follow G' doesn't show the edit of F on
the side branch, while it did before the previous commit.

The problem is that follow_needs_renames() only searches for renames in
a parent without the path if the merge base still has the path, which
covers the case when the parent renamed the path. Here the other side
of the merge did the rename, so the merge base only has the old name.
The parent is then told to follow G, which it doesn't have, and the
history of F on its side is lost. Searching for renames in each parent
that lacks the path would fix this, but that is the expensive search
that the previous commit avoids, e.g. 148 merges hit this case for
include/linux/rsc_table.h in linux.git.

Fix the problem by also searching for renames when the merge base
doesn't have the path, but the parent changed a file since the merge
base that the merge no longer has: only such a file can be the old name
of the path that still needs to be followed in the parent. This check
is cheap, since it only diffs the changes of the side branch, and it
rules out 146 of the 148 merges in linux.git. Then do a plain rename
detection from the parent to the merge, which only looks at the files
deleted by the merge, not at all files of the parent like --follow does.

Reported-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Miklos Vajna <vmiklos@collabora.com>
---
 log-tree.c                  | 96 +++++++++++++++++++++++++++++++++----
 t/t4219-log-follow-merge.sh | 31 ++++++++++++
 2 files changed, 117 insertions(+), 10 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 0dc71be61e..c2c3473f25 100644
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
 
@@ -1313,7 +1389,7 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 			     parents = parents->next) {
 				if (parents->item != parent &&
 				    follow_needs_renames(opt, parents->item,
-							 parent, path))
+							 parent, oid, path))
 					tail = &commit_list_insert(parents->item,
 								   tail)->next;
 				else
diff --git a/t/t4219-log-follow-merge.sh b/t/t4219-log-follow-merge.sh
index 36204ae2bf..a85fb78ca2 100755
--- a/t/t4219-log-follow-merge.sh
+++ b/t/t4219-log-follow-merge.sh
@@ -266,4 +266,35 @@ test_expect_success '--follow with --diff-merges=first-parent follows all parent
 	test_cmp expect actual
 '
 
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

