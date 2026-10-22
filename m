Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792702039;
	b=NoTRU6+krxKx6lwHiGDGIH13sy2o4DchRVv6QAYZzz6L46OM1IOvMag4+NS0zbNS7O0v
	 ABrqXkV/JWqM2thWnvU//LfSRBM+4TOLmb4P65gXx00IZO9Trcm8z68i7xFZ5EEBtvYxc
	 3EK3Kur7hOh64tO4c5CMn9MRhWGCCcJ+KHKSviMY1cxfCrQDRXXS2CairiCjyKDRJmFCe
	 gxqoiJDMeA8Oe3IISRRa8KjJNXUuxqf0nmUysrcB0Bux/Ipb74PRDCTlpthsytC1daOWp
	 V9J9DPD6T+MbYN0KKoVGOSbK0/jdxGUYNGvC/2spo8h4A2PXYNZXrZIYKbjuRhSqxfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792702039;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Zoho-Virus-Status:
	 X-Zoho-AV-Stamp:X-ZohoMailClient;
	bh=wY+ZrEdoPtdggqit9VVIBvzmhgHlniQvMfPXwLee/R4=;
	b=zzdGTJSHlW1EIweYl1WVB8zk5GicwvG8LSdToK1r+KQBL8sLJULPh8Hz4LWetOhJuFph
	 J3sX9UdrzyKME9miA4g9aDuiuh8MtqlrtRoSQ3Z9Rwm21paZQgpZrfWqkopHMpzsdALoD
	 vQk68Aieq2iX5n0GtvYL0B3QsG0ldobgh+QhWgA0X2uIQQNIGiip8mcCJyxLu2uGPQ8VH
	 YXSWOvzELSlNtS/qvkFMK+e5/nrrfkBElwZrUSSJwzaztC3uIS1QHiI4/rv7OBiUstDs3
	 lq1z9Ic6uk3wKVY4THsvxraFc4kosKhcMCc1IDC4sHa9wt3bce+k3XGMRM4aghAkCvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=vmiklos@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=UxeR2gOW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5A0606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 20:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C5A0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=vmiklos@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=UxeR2gOW
ARC-Seal: i=1; a=rsa-sha256; t=1792702033; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WYtBu7x3cl+LT22qXSVtFX0M+0aaTufE7X8ayZoqZoQBR4W5lKnWp1z/CVlZC+cM/HgHdhsiVGFUpsSCBQa6xjqPqY8QPTDcnZbZP0NnvTiSis2RjzO6sYKkStmosU7aY2CzFwvJNhaDNy9344Xo90pDrZEzYYt4SRpOtZpGdxU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792702033; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wY+ZrEdoPtdggqit9VVIBvzmhgHlniQvMfPXwLee/R4=; 
	b=F+xA2eVABioegBMinDhoXvKaaRducBjwEaMDalNPkGpAYwYmOJIeX8Mtrncf92z6ErD4y9/t4Id7nkMFu2ngbEVwB3VoOW1iwyFS52wR0Jsg+XfcRMlY0loLfaAG65LvbO1w/VhPKCV+iwaxSbpAqy2IdpscJuHM7VCLAyREcr4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792702032;
	s=zohomail; d=collabora.com; i=vmiklos@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=wY+ZrEdoPtdggqit9VVIBvzmhgHlniQvMfPXwLee/R4=;
	b=UxeR2gOW9BbwqWtRGE09czntrIUPLHcelnXFe66/bIrrf1XpDEZoa4sa3aFo4QhA
	8MfouLufvSjaqy5ATEstz8e/zOMo1lwB+Mcw2x/PXtrGjQSTFUI9he54FW1NLXmmEW5
	kKU8SYuJZvsPdR8TpzQmDwBIo8asiMJ0dc3wAvZQ=
Received: by smtp.zohomail.com with SMTPS id 1792702030581592.9832686815462;
	Thu, 22 Oct 2026 13:47:10 -0700 (PDT)
Date: Thu, 22 Oct 2026 22:47:06 +0200
From: Miklos Vajna <vmiklos@collabora.com>
To: gitster@pobox.com
Cc: szeder.dev@gmail.com, ps@pks.im, git@vger.kernel.org
Subject: [PATCH v3 4/4] log: speed up --follow following renames for
 non-linear history
Message-ID: <6f249099cf214f83d31bc04980bc2e9dfd861bba.1792701579.git.vmiklos@collabora.com>
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
In-Reply-To: <cover.1792701579.git.vmiklos@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/292.682.56
X-ZohoMailClient: External

Test the performance of 'git log --stat --follow --
include/linux/rsc_table.h' on linux.git, it used to take about 28
seconds, and since commit 304812ed33 (log: improve --follow following
renames for non-linear history, 2026-06-22), it takes 6m43s.

What happens is that log_tree_diff() diffs each merge against all of its
parents with rename following. diff_tree_oid() only does the expensive
rename detection when the path is added relative to a parent, but that
is common for merges, e.g. when a branch forked before the path was
created merges mainline, and this slows down 'git log --follow'.

Fix the problem by diffing the merge against its parents in two passes:
- First pass: diff against the parents without rename following. If the
  path is unchanged against a parent, then just follow that history in
  all parents.
  - Except when an other parent doesn't have the path, the merge has it
    and a merge base of the two parents also has it, i.e. the path was
    renamed or removed on that side: still do the rename following
    against such a parent, otherwise the history on that side would be
    lost. The merge base is only computed in this rare case, and
    back-merges where the path was created after the other side forked
    still skip the expensive rename detection.
- Second pass: only do the rename following against each parent if the
  path changed relative to all parents.
Given that this way a parent may be asked to follow a path that it
doesn't have, also adjust remember_follow_pathspec(): if children
disagree on what should be the path for a commit, then prefer the path
that exists in that commit.

Now the above use case takes 36s, somewhat close to the original cost.

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Miklos Vajna <vmiklos@collabora.com>
---
 log-tree.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 89 insertions(+), 4 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index c5ac6c2bcb..d5ce58d91d 100644
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
@@ -1110,6 +1111,17 @@ static void set_pathspec_to_single_path(struct pathspec *ps, const char *path)
 		       PATHSPEC_LITERAL_PATH, "", paths);
 }
 
+static int commit_has_path(struct rev_info *opt, struct commit *c,
+			   const char *path)
+{
+	struct object_id oid;
+	unsigned short mode;
+
+	parse_commit_or_die(c);
+	return !get_tree_entry(opt->diffopt.repo, get_commit_tree_oid(c), path,
+			       &oid, &mode);
+}
+
 static void remember_follow_pathspec(struct rev_info *opt,
 				     struct commit *c, const char *path)
 {
@@ -1122,8 +1134,12 @@ static void remember_follow_pathspec(struct rev_info *opt,
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
@@ -1153,6 +1169,29 @@ void release_follow_pathspec_slab(struct rev_info *opt)
 	FREE_AND_NULL(opt->follow_pathspec_slab);
 }
 
+/*
+ * When the path in a merge is the same as in 'same', does the path still need
+ * renames to be followed in 'parent'? Only if the merge has the path, 'parent'
+ * doesn't have it, but its fork point with 'same' had it, e.g. 'parent'
+ * renamed the path.
+ */
+static int follow_needs_renames(struct rev_info *opt, struct commit *parent,
+				struct commit *same, const char *path)
+{
+	struct commit_list *bases = NULL, *base;
+	int ret = 0;
+
+	if (commit_has_path(opt, parent, path) ||
+	    !commit_has_path(opt, same, path))
+		return 0;
+	if (repo_get_merge_bases(opt->diffopt.repo, parent, same, &bases) < 0)
+		exit(128);
+	for (base = bases; base && !ret; base = base->next)
+		ret = commit_has_path(opt, base->item, path);
+	commit_list_free(bases);
+	return ret;
+}
+
 /* Show the remerge or combined diff of a merge commit */
 static int log_tree_merge_diff(struct rev_info *opt, struct commit *commit,
 			       struct commit_list *parents,
@@ -1181,7 +1220,7 @@ static int log_tree_merge_diff(struct rev_info *opt, struct commit *commit,
 static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log_info *log)
 {
 	int showed_log;
-	struct commit_list *parents, *all_parents;
+	struct commit_list *parents, *all_parents, *rename_parents = NULL;
 	struct object_id *oid;
 	int is_merge;
 	int all_need_diff = opt->diff || opt->diffopt.flags.exit_with_status;
@@ -1235,15 +1274,25 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 		path = xstrdup_or_null(
 			pathspec_single_path(&opt->diffopt.pathspec));
 
+	if (follow_only) {
+		/*
+		 * First look for a parent where the path is unchanged, without
+		 * the expensive rename detection.
+		 */
+		opt->diffopt.flags.follow_renames = 0;
+	}
+
 	showed_log = 0;
 	all_parents = parents;
 	for (;;) {
 		struct commit *parent = parents->item;
+		int changed = 1;
 
 		parse_commit_or_die(parent);
 		diff_tree_oid(get_commit_tree_oid(parent),
 			      oid, "", &opt->diffopt);
 		if (follow_only) {
+			changed = diff_queued_diff.nr;
 			diff_queue_clear(&diff_queued_diff);
 			opt->diffopt.found_follow = 0;
 		} else
@@ -1251,13 +1300,46 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 
 		showed_log |= !opt->loginfo;
 
+		if (!changed) {
+			/*
+			 * Same as in this parent, follow that history, but
+			 * still look for renames in parents that had the path
+			 * at the fork point.
+			 */
+			struct commit_list **tail = &rename_parents;
+
+			for (parents = all_parents; parents;
+			     parents = parents->next) {
+				if (parents->item != parent &&
+				    follow_needs_renames(opt, parents->item,
+							 parent, path))
+					tail = &commit_list_insert(parents->item,
+								   tail)->next;
+				else
+					remember_follow_pathspec(opt,
+								 parents->item,
+								 path);
+			}
+			if (!rename_parents)
+				break;
+			opt->diffopt.flags.follow_renames = 1;
+			parents = rename_parents;
+			continue;
+		}
+
 		/* The diff updated the pathspec in case of a rename */
-		if (path)
+		if (path && opt->diffopt.flags.follow_renames)
 			remember_follow_pathspec(opt, parent,
 				pathspec_single_path(&opt->diffopt.pathspec));
 
 		/* Set up the log info for the next parent, if any.. */
 		parents = parents->next;
+		if (!parents && follow_only &&
+		    !opt->diffopt.flags.follow_renames) {
+			/* The path changed in all parents, look for renames. */
+			opt->diffopt.flags.follow_renames = 1;
+			parents = all_parents;
+		}
 		if (!parents || opt->first_parent_merges)
 			break;
 		if (path)
@@ -1268,6 +1350,8 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 		log->parent = parents->item;
 		opt->loginfo = log;
 	}
+	if (follow_only)
+		opt->diffopt.flags.follow_renames = 1;
 	if (follow_only && (opt->remerge_diff || opt->combine_merges)) {
 		/* Show the merge diff with the path of this commit */
 		if (path)
@@ -1275,6 +1359,7 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 						    path);
 		showed_log = log_tree_merge_diff(opt, commit, all_parents, oid);
 	}
+	commit_list_free(rename_parents);
 	free(path);
 	return showed_log;
 }
-- 
2.56.0

