Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA81238AC8E
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 01:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784080340; cv=none; b=tpxuYP32I7Vb1eqIuH+iUOiMOqQXmoeSIeuC7l411nU0Fw1d30oQd0DlJOI9nEsdBQD9I8CTNBrWW0ITsv33TLp5fiTu9AJ0LdFPJEmOtHWnpo0oLOPkhmlHwXuZv4n9vCMz0xTChCBRwV0nb8m0iTCdXyqOJS67r9L4uU+Si24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784080340; c=relaxed/simple;
	bh=fB0ldps/5XlhN+8YiZiGa+kasYD+dbC7NBUEomLYEdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojwfWZXFQwxBL+Fs115qZiLMVoWZDVUI+wURy/CUqmfpyzHa+xXdnzqbKUe+xvfZUnVc1T1DHd2xpj7XvoMUCcAqfCIg2xRsFb2hXxW6MhEQC0eFRqDtWwPUgtNp07BFiy4LkEP17qM8YvqhOkIrPMOhcc6GdAe2EpXR+I/4Qmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtVDsa0Y; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtVDsa0Y"
Received: by mail-pj2-f0.google.com with SMTP id 98e67ed59e1d1-380f4166f80so926870a91.1
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 18:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784080325; x=1784685125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4fHyGbVRtQXGp2zA/A9Mixr1GUFccuNZ39HwvUr14wU=;
        b=VtVDsa0Y/o/3CqjazivjVIWX/MFDgLuFegYJKQyAUhTQ7GLLTpjqO99LXRK0rjfFhR
         0RU6jxUzPOayG/OE2FDKAnykoBybEVAquhcXDywQN3ACVN1zJ76dc7xZMgcoCLmC41ZB
         rxhjwdp62yB97oMJnF4P/7VYhglAvih9eiSQ8HOikBIn6SU6C78yRSqLPyAG6te6t6b8
         wTK1Mvt2sUqLvYzqJjMB1WxfPnGRnyhCEbg3ACsRH5SQ1IO7HuCkJy2e/WfsvFtJN8NC
         El0C/9kuUYw/jifa1+9ONNLKpMCe1zXZuhqSXosFqWKa9J7XxRaXh+p0soBFGjtSCGlC
         mffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784080325; x=1784685125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4fHyGbVRtQXGp2zA/A9Mixr1GUFccuNZ39HwvUr14wU=;
        b=NL4B15DhJCml1qt3eq/VwS2t3Cs7H31WGf9vVMrMjomuHYEVcNq9aogfWTWXfD5Np3
         zKhY+eY65OyRF4L9KTE2+ZfX0gXElEfFrtD0R4buEyL7XnQbrxn8vOpRvZs3jmA5pVYd
         FtuCEQ+f5PwCQn/+JPvMUWe1ddMTnHadKoE34OVfGcL9T/3S64Nmr7QXHPuamMtlHOW2
         O5655933+uTf9DUxazD95pc57SAbvuf6ApBh2rhzb9kqjMkaRdK+Pb2jIoGXfchhYuJ+
         mLUf0cLCB/dcTMxhgzrRvYXjY49uX+DqCnQb5PXLkQdI5sRf1dmzspImsUKyoODd+sTW
         x+LA==
X-Gm-Message-State: AOJu0YxbKGKNVJL+xRWbgQRJH9LueR4Zfp4sWrY+RBb07UizZ294tobn
	1zeW38+NS73o75o4S6UxbU8iQdgqUcU3oqg8U3wcuLhQDlYuxd4MEhhhbgeCC5fRnYM=
X-Gm-Gg: AfdE7cmGskGBet8e1utxt7fgwNa3lpJf55Zto+SIjArJn4CqJ7Ii/4RVpPbgeKLvswo
	nzww1QqIKkrflGGe/ZESo3idR02+KLr2DcXLAuHRap6HX2tcBYkwIF8RDRR4Ez+buWRc65AK5u8
	kbrkoMckxljO5HDK0/F87VgjTdIhpr2w1LXKI9g21bauEx7vvisP6cp3MbXnlnxYjeqRjXe6g+w
	tQ3nikOOMwfXlwOTf7B/3fmp18hY3wfgla61gV5QwfcIKrawsZyOedcjWtyTpwFMd/T6LaBXYdB
	sQedGjO7M6nW9x4uuYqcHC9B7gzsIFwpBwjwP6LVNIDP2Dp8tXSxmnQG2zi6z/AthUsW6IrkWKs
	fAEdUbTxHQd5ZqowKldhtL1lkQj6D1G61BEs9x+hzwL52C/ouokotaEjMbU+O/7TcDY85GeME8n
	WZ/qnny9djGWH7RbgEuXthho/IRnsllG6jI5IVWPCdsNbaJZciMKBQ0PnyIw==
X-Received: by 2002:a05:6a21:a346:b0:3bf:9e25:1a19 with SMTP id adf61e73a8af0-3c1108c014dmr17550726637.52.1784080325096;
        Tue, 14 Jul 2026 18:52:05 -0700 (PDT)
Received: from localhost.localdomain ([45.117.66.213])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a583bcsm91343313eec.19.2026.07.14.18.52.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 18:52:04 -0700 (PDT)
From: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
To: git@vger.kernel.org
Cc: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Subject: [PATCH v3] show-branch: convert per-branch flags to commit-slab
Date: Wed, 15 Jul 2026 07:17:22 +0530
Message-ID: <20260715015158.48559-1-gatlavishweshwarreddy26@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714220042.GC4095533@coredump.intra.peff.net>
References: <20260714220042.GC4095533@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

show-branch uses commit->object.flags to store per-branch
reachability bits, one bit per branch starting at REV_SHIFT.
The flags word has only a fixed number of available bits, limiting
the number of branches that can be shown simultaneously to MAX_REVS.

Convert the per-branch bits to a dedicated commit-slab using uint64_t
as the element type, initialized with a stride via
init_commit_rev_flags_with_stride(). Keep the UNINTERESTING bit in
object.flags where it belongs, as it is used for revision walking and
does not need to be in the per-branch slab. With UNINTERESTING removed
from the slab, REV_SHIFT becomes 0 and all 64 bits of uint64_t are
available for branch tracking, lifting MAX_REVS from 27 to 64 branches.

Add helper functions get_rev_flags_ptr(), peek_rev_flags_ptr(),
has_any_rev_flags(), or_rev_flag_bit(), test_rev_flag_bit(), and
has_all_rev_flags() to encapsulate per-bit slab access cleanly.
Update all bit operations to use UINT64_C(1) for correct 64-bit shifts.
Initialize and clear the slab in cmd_show_branch().

Signed-off-by: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
---

Changes in v3:
- Keep UNINTERESTING in object.flags as suggested by Junio
- Slab stores only per-branch bits with REV_SHIFT=0
- All 64 bits of uint64_t available for branches, MAX_REVS=64
- Fix uint64_t flag in omit_in_dense() (was int)
- Fix indentation in show_merge_base()
- Replace all_mask/all_revs with has_all_rev_flags() helper
- Use UINT64_C(1) for all bit shifts

In response to Junio:
- UNINTERESTING kept in object.flags; slab is per-branch bits only

In response to Jeff King:
- init_commit_rev_flags_with_stride() is used as foundation.
  Current stride=1 gives 64 branches. Dynamic stride for >64
  branches can be added as a follow-up.

 builtin/show-branch.c | 143 ++++++++++++++++++++++++------------------
 1 file changed, 83 insertions(+), 60 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index f02831b085..70436007ec 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -34,16 +34,9 @@ static enum git_colorbool showbranch_use_color = GIT_COLOR_UNKNOWN;

 static struct strvec default_args = STRVEC_INIT;

-/*
- * TODO: convert this use of commit->object.flags to commit-slab
- * instead to store a pointer to ref name directly. Then use the same
- * UNINTERESTING definition from revision.h here.
- */
 #define UNINTERESTING	01
-
-#define REV_SHIFT	 2
-#define MAX_REVS	(FLAG_BITS - REV_SHIFT) /* should not exceed bits_per_int - REV_SHIFT */
-
+#define REV_SHIFT	 0
+#define MAX_REVS	(sizeof(uint64_t) * 8)
 #define DEFAULT_REFLOG	4

 static const char *get_color_code(int idx)
@@ -79,11 +72,56 @@ struct commit_name {
 define_commit_slab(commit_name_slab, struct commit_name *);
 static struct commit_name_slab name_slab;

+define_commit_slab(commit_rev_flags, uint64_t);
+static struct commit_rev_flags rev_flags_slab;
+static int flags_stride; /* number of uint64_t words per commit */
+
 static struct commit_name *commit_to_name(struct commit *commit)
 {
 	return *commit_name_slab_at(&name_slab, commit);
 }

+static uint64_t *get_rev_flags_ptr(struct commit *commit)
+{
+	return commit_rev_flags_at(&rev_flags_slab, commit);
+}
+
+static uint64_t *peek_rev_flags_ptr(struct commit *commit)
+{
+	return commit_rev_flags_peek(&rev_flags_slab, commit);
+}
+
+static int has_any_rev_flags(struct commit *commit)
+{
+	uint64_t *f = peek_rev_flags_ptr(commit);
+	int i;
+	if (!f)
+		return 0;
+	for (i = 0; i < flags_stride; i++)
+		if (f[i])
+			return 1;
+	return 0;
+}
+
+static void or_rev_flag_bit(struct commit *commit, int branch)
+{
+	get_rev_flags_ptr(commit)[branch / 64] |= UINT64_C(1) << (branch % 64);
+}
+
+static int test_rev_flag_bit(struct commit *commit, int branch)
+{
+	uint64_t *f = peek_rev_flags_ptr(commit);
+	return f && !!(f[branch / 64] & (UINT64_C(1) << (branch % 64)));
+}
+
+static int has_all_rev_flags(struct commit *commit, int num_rev)
+{
+	int i;
+	for (i = 0; i < num_rev; i++)
+		if (!test_rev_flag_bit(commit, i))
+			return 0;
+	return 1;
+}

 /* Name the commit as nth generation ancestor of head_name;
  * we count only the first-parent relationship for naming purposes.
@@ -215,7 +253,7 @@ static void name_commits(struct commit_list *list,

 static int mark_seen(struct commit *commit, struct commit_list **seen_p)
 {
-	if (!commit->object.flags) {
+	if (!has_any_rev_flags(commit)) {
 		commit_list_insert(commit, seen_p);
 		return 1;
 	}
@@ -226,34 +264,34 @@ static void join_revs(struct prio_queue *queue,
 		      struct commit_list **seen_p,
 		      int num_rev, int extra)
 {
-	int all_mask = ((1u << (REV_SHIFT + num_rev)) - 1);
-	int all_revs = all_mask & ~((1u << REV_SHIFT) - 1);
-
 	while (queue->nr) {
 		struct commit_list *parents;
 		int still_interesting = !!interesting(queue);
 		struct commit *commit = prio_queue_peek(queue);
 		bool get_pending = true;
-		int flags = commit->object.flags & all_mask;

 		if (!still_interesting && extra <= 0)
 			break;

 		mark_seen(commit, seen_p);
-		if ((flags & all_revs) == all_revs)
-			flags |= UNINTERESTING;
+		if (has_all_rev_flags(commit, num_rev))
+			commit->object.flags |= UNINTERESTING;
 		parents = commit->parents;

 		while (parents) {
 			struct commit *p = parents->item;
-			int this_flag = p->object.flags;
 			parents = parents->next;
-			if ((this_flag & flags) == flags)
+			if (has_all_rev_flags(p, num_rev))
 				continue;
 			repo_parse_commit(the_repository, p);
 			if (mark_seen(p, seen_p) && !still_interesting)
 				extra--;
-			p->object.flags |= flags;
+			{
+				int _b;
+				for (_b = 0; _b < num_rev; _b++)
+					if (test_rev_flag_bit(commit, _b))
+						or_rev_flag_bit(p, _b);
+			}
 			if (get_pending)
 				prio_queue_replace(queue, p);
 			else
@@ -263,7 +301,6 @@ static void join_revs(struct prio_queue *queue,
 		if (get_pending)
 			prio_queue_get(queue);
 	}
-
 	/*
 	 * Postprocess to complete well-poisoning.
 	 *
@@ -278,7 +315,7 @@ static void join_revs(struct prio_queue *queue,
 			struct commit *c = s->item;
 			struct commit_list *parents;

-			if (((c->object.flags & all_revs) != all_revs) &&
+			if (!has_all_rev_flags(c, num_rev) &&
 			    !(c->object.flags & UNINTERESTING))
 				continue;

@@ -410,8 +447,8 @@ static int append_ref(const char *refname, const struct object_id *oid,
 				return 0;
 	}
 	if (MAX_REVS <= ref_name_cnt) {
-		warning(Q_("ignoring %s; cannot handle more than %d ref",
-			   "ignoring %s; cannot handle more than %d refs",
+		warning(Q_("ignoring %s; cannot handle more than %zu ref",
+			   "ignoring %s; cannot handle more than %zu refs",
 			   MAX_REVS), refname, MAX_REVS);
 		return 0;
 	}
@@ -511,15 +548,12 @@ static int rev_is_head(const char *head, const char *name)

 static int show_merge_base(const struct commit_list *seen, int num_rev)
 {
-	int all_mask = ((1u << (REV_SHIFT + num_rev)) - 1);
-	int all_revs = all_mask & ~((1u << REV_SHIFT) - 1);
 	int exit_status = 1;

 	for (const struct commit_list *s = seen; s; s = s->next) {
 		struct commit *commit = s->item;
-		int flags = commit->object.flags & all_mask;
-		if (!(flags & UNINTERESTING) &&
-		    ((flags & all_revs) == all_revs)) {
+		if (!(commit->object.flags & UNINTERESTING) &&
+			has_all_rev_flags(commit, num_rev)) {
 			puts(oid_to_hex(&commit->object.oid));
 			exit_status = 0;
 			commit->object.flags |= UNINTERESTING;
@@ -528,17 +562,13 @@ static int show_merge_base(const struct commit_list *seen, int num_rev)
 	return exit_status;
 }

-static int show_independent(struct commit **rev,
-			    int num_rev,
-			    unsigned int *rev_mask)
+static int show_independent(struct commit **rev, int num_rev)
 {
 	int i;

 	for (i = 0; i < num_rev; i++) {
 		struct commit *commit = rev[i];
-		unsigned int flag = rev_mask[i];
-
-		if (commit->object.flags == flag)
+		if (test_rev_flag_bit(commit, i))
 			puts(oid_to_hex(&commit->object.oid));
 		commit->object.flags |= UNINTERESTING;
 	}
@@ -603,13 +633,12 @@ static int omit_in_dense(struct commit *commit, struct commit **rev, int n)
 	 * Otherwise, if it is a merge that is reachable from only one
 	 * tip, it is not that interesting.
 	 */
-	int i, flag, count;
+	int i, count;
 	for (i = 0; i < n; i++)
 		if (rev[i] == commit)
 			return 0;
-	flag = commit->object.flags;
 	for (i = count = 0; i < n; i++) {
-		if (flag & (1u << (i + REV_SHIFT)))
+		if (test_rev_flag_bit(commit, i))
 			count++;
 	}
 	if (count == 1)
@@ -648,10 +677,8 @@ int cmd_show_branch(int ac,
 	char *reflog_msg[MAX_REVS] = {0};
 	struct commit_list *seen = NULL;
 	struct prio_queue queue = { compare_commits_by_commit_date };
-	unsigned int rev_mask[MAX_REVS];
 	int num_rev, i, extra = 0;
 	int all_heads = 0, all_remotes = 0;
-	int all_mask, all_revs;
 	enum rev_sort_order sort_order = REV_SORT_IN_GRAPH_ORDER;
 	char *head;
 	struct object_id head_oid;
@@ -713,7 +740,8 @@ int cmd_show_branch(int ac,
 	const char **args_copy = NULL;
 	int ret;

-	init_commit_name_slab(&name_slab);
+	flags_stride = (MAX_REVS + 63) / 64;
+	init_commit_rev_flags_with_stride(&rev_flags_slab, flags_stride);

 	repo_config(the_repository, git_show_branch_config, NULL);

@@ -779,8 +807,8 @@ int cmd_show_branch(int ac,
 			die(_("--reflog option needs one branch name"));

 		if (MAX_REVS < reflog)
-			die(Q_("only %d entry can be shown at one time.",
-			       "only %d entries can be shown at one time.",
+			die(Q_("only %zu entry can be shown at one time.",
+			       "only %zu entries can be shown at one time.",
 			       MAX_REVS), MAX_REVS);
 		if (!repo_dwim_ref(the_repository, *av, strlen(*av), &oid,
 				   &ref, 0))
@@ -870,11 +898,11 @@ int cmd_show_branch(int ac,

 	for (num_rev = 0; ref_name[num_rev]; num_rev++) {
 		struct object_id revkey;
-		unsigned int flag = 1u << (num_rev + REV_SHIFT);
+		int first_seen;

 		if (MAX_REVS <= num_rev)
-			die(Q_("cannot handle more than %d rev.",
-			       "cannot handle more than %d revs.",
+			die(Q_("cannot handle more than %zu rev.",
+			       "cannot handle more than %zu revs.",
 			       MAX_REVS), MAX_REVS);
 		if (repo_get_oid(the_repository, ref_name[num_rev], &revkey))
 			die(_("'%s' is not a valid ref."), ref_name[num_rev]);
@@ -885,17 +913,15 @@ int cmd_show_branch(int ac,
 		repo_parse_commit(the_repository, commit);
 		mark_seen(commit, &seen);

-		/* rev#0 uses bit REV_SHIFT, rev#1 uses bit REV_SHIFT+1,
-		 * and so on.  REV_SHIFT bits from bit 0 are used for
-		 * internal bookkeeping.
+		/* rev#0 uses bit 0, rev#1 uses bit 1,
+		 * and so on.  All bits are available for branch tracking.
 		 */
-		commit->object.flags |= flag;
-		if (commit->object.flags == flag)
+		first_seen = !has_any_rev_flags(commit);
+		or_rev_flag_bit(commit, num_rev);
+		if (first_seen)
 			prio_queue_put(&queue, commit);
 		rev[num_rev] = commit;
 	}
-	for (i = 0; i < num_rev; i++)
-		rev_mask[i] = rev[i]->object.flags;

 	if (0 <= extra)
 		join_revs(&queue, &seen, num_rev, extra);
@@ -908,7 +934,7 @@ int cmd_show_branch(int ac,
 	}

 	if (independent) {
-		ret = show_independent(rev, num_rev, rev_mask);
+		ret = show_independent(rev, num_rev);
 		goto out;
 	}

@@ -958,13 +984,9 @@ int cmd_show_branch(int ac,
 	if (!sha1_name && !no_name)
 		name_commits(seen, rev, ref_name, num_rev);

-	all_mask = ((1u << (REV_SHIFT + num_rev)) - 1);
-	all_revs = all_mask & ~((1u << REV_SHIFT) - 1);
-
 	for (struct commit_list *l = seen; l; l = l->next) {
 		struct commit *commit = l->item;
-		int this_flag = commit->object.flags;
-		int is_merge_point = ((this_flag & all_revs) == all_revs);
+		int is_merge_point = has_all_rev_flags(commit, num_rev);

 		shown_merge_point |= is_merge_point;

@@ -973,14 +995,14 @@ int cmd_show_branch(int ac,
 					  commit->parents->next);
 			if (topics &&
 			    !is_merge_point &&
-			    (this_flag & (1u << REV_SHIFT)))
+			    test_rev_flag_bit(commit, 0))
 				continue;
 			if (!sparse && is_merge &&
 			    omit_in_dense(commit, rev, num_rev))
 				continue;
 			for (i = 0; i < num_rev; i++) {
 				int mark;
-				if (!(this_flag & (1u << (i + REV_SHIFT))))
+				if (!test_rev_flag_bit(commit, i))
 					mark = ' ';
 				else if (is_merge)
 					mark = '-';
@@ -1010,6 +1032,7 @@ int cmd_show_branch(int ac,
 		free(reflog_msg[i]);
 	commit_list_free(seen);
 	clear_prio_queue(&queue);
+	clear_commit_rev_flags(&rev_flags_slab);
 	free(args_copy);
 	free(head);
 	return ret;
--
2.54.0

