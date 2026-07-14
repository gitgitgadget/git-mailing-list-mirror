Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0196041D632
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 20:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059422; cv=none; b=tcXxlzfLvPcCduTlzI+i82KZF78vd35RhkEXSXgsXgavu2YumqrvDuKNjEij5vPhkainhQ/HSiB+Y9HxuK+heg117fCLBtbINErr0NErdex4SHKg66nXUpmaSurMSPEpATzFaavIIy67PUmJe+f90a+5QUZ5NB3nPOLBln+BFHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059422; c=relaxed/simple;
	bh=8WtgHnnzeeMKVm16IiYV5lvgFJBdDd9LdzEIL0G2Er0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7r3vJ941S/0k67iTOm1lLCS3fTfpIY7zjn8XawcdNYLxdRI4eBMzz+S9aftJqgF/huZeqabq/uQgk9zj+Qn4LGx4kfvwFuQ3wU+CWj4rNtkCW6WEhcEqG3IVp7H1e584QlnOStVvD5pFuWbawxXlSiohcfOuFkjmPmRuHhEvgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXi8oHnu; arc=none smtp.client-ip=74.125.227.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXi8oHnu"
Received: by mail-pj2-f9.google.com with SMTP id 98e67ed59e1d1-38dc7618a1dso1038552a91.0
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 13:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784059412; x=1784664212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GQ8FGnV3cxRx8pDnvChWybu6d6E3KWnlyNPmEpNONEo=;
        b=MXi8oHnu/+rGiwaZu+zJvqIBjDDnHICnuwaiFLnEqGVmwX2GImX5ID+cM3b3oeVoXa
         rTm/KgxWbVFjz1qZ4rDN/46oymp1RV7cytyiXdsuoB1ZGiYo8CPrxIcWWmOm+JVGLClc
         vns6URD01xq0ZdfDquFvT885HER+nkE85w4c4P4835gipaXPekiLSInhSy9IKXsvFwYC
         kVDfyCDF8lvm4JSSihiHTsh9xe8HmzzUTqEgjFBdzGMGzaDNJWMdVz/8x8q9lORrutcV
         ewH+LYI3oAvY1nUR41gLv+ev6kHHbG0cicWjGO1fuanzsqi+jCbH6TyW48KK8HLhxp8D
         Nm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784059412; x=1784664212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GQ8FGnV3cxRx8pDnvChWybu6d6E3KWnlyNPmEpNONEo=;
        b=I08uCvkqjsBStdQKMyOs5BqO+U+lseedwM+IFi0X8HkU6MjEexsusQHgT8Afd8IFzt
         5zmSGeRa3LedRf5px+WqlDpjUIg2kk8TuH6FxFn5OP4dyXLlynoKbfFfkoC7RcJ0cbjP
         yaMlprAdiVfoJY9sl/YhQKVsJc/tIfBXojb5K9f3tN1HgCgklHYXP7VlVT1IMun1mAVG
         d+EKJ78GdInP2Rcki5WznVzyapevLLFLUo8HB5czpmrqvNER0mfLHcMQoWP+RFyKoJrj
         AdE8RcuLo4XZejx+gPpL6gTGExirgxBJuVEwW/lkLWFqS4MTkcAJWEXJUPwBJ1Fa4TVc
         fE0w==
X-Gm-Message-State: AOJu0YzyT9u21BhMpe56UgUohZwZvRTwE7OO65yCIkIO5CO6Iivk3YrX
	BG/nihd8QRgrVpE/BSkRnvsHeavBDHnNCM2/+T4TaovcCQoznulxxepSSDranydrqTY=
X-Gm-Gg: AfdE7cmqVvyItXsGBz7A2MCEJdIoDHSvmsuJ3Pfc91NTfyjGqcKLrrvr6/ffXxDhTrM
	dd9gKSDxUnysvUJj/aBRkcUPUrB++S9Wp1+BLnNkOWP7uYwVQU5+X6JIYHxMOK4A8HsK5h/78YN
	7lB91X8CcuHVZYWmvkfKzaAuV0E/qrDlJOn5ymTihLgf0r3V7HYkL0oQv4pBxc+GyrST1a7mbOm
	Lr47lhmWNq3zgOm+BqWT8F7nwsvTN86H5VS0+Svu/SNfADGWK3IRKOZ2vIXjWD9NNDbpkCAkBgU
	C3J9g923/iByyx3MdgLx/kMJR0Uz8Mt8Faq5E7BRJFyFluA3aegseehjxLvt7SMtI1r6O32TFt7
	W66x0cmPmNtgqQNRHTBQ1rVO7aYKhx987lAtzEZLnwtFc+C6AoyXihnghZHsvQUcNLook85QsKw
	XI7eQROPz49lO5pwhrIqbgsXFjvQzSFdtrVnZfsr2P97ZoTxsWQuj2YozoYQ==
X-Received: by 2002:a17:90b:5443:b0:37f:9ce1:cda6 with SMTP id 98e67ed59e1d1-38dc7735b02mr15074532a91.28.1784059411560;
        Tue, 14 Jul 2026 13:03:31 -0700 (PDT)
Received: from localhost.localdomain ([45.117.66.213])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174839f89sm82525840eec.10.2026.07.14.13.03.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 13:03:31 -0700 (PDT)
From: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
To: git@vger.kernel.org
Cc: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Subject: [PATCH v2] show-branch: convert object.flags to commit-slab with uint64_t
Date: Wed, 15 Jul 2026 01:31:22 +0530
Message-ID: <20260714200237.70509-1-gatlavishweshwarreddy26@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714183028.67857-1-gatlavishweshwarreddy26@gmail.com>
References: <20260714183028.67857-1-gatlavishweshwarreddy26@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

show-branch uses commit->object.flags to store per-commit data:
the UNINTERESTING bit and per-branch reachability bits. Using the
shared object.flags field for this purpose is fragile as it
conflicts with other users of the same field, and limits the
number of branches that can be shown to MAX_REVS (27).

Convert this usage to a dedicated commit-slab using uint64_t as
the element type. This is the canonical way to associate per-commit
data in Git without polluting the shared object flags. Using
uint64_t instead of unsigned int lifts the MAX_REVS limitation
from 27 to 62 branches, as suggested in prior review discussions.

Add helper functions get_rev_flags() and or_rev_flags() to
encapsulate slab access cleanly. Update all bit operations to use
UINT64_C(1) instead of 1u to ensure correct 64-bit shifts.
Initialize and clear the slab in cmd_show_branch() to avoid
memory leaks.

Signed-off-by: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
---

Changes in v2:

- Use uint64_t instead of unsigned int for the slab element type.
  This lifts MAX_REVS from 27 to 62 branches since uint64_t provides
  64 bits instead of the 32 bits available in unsigned int.
- Update all bit shift operations from 1u to UINT64_C(1) to ensure
  correct 64-bit shifts without undefined behavior.
- Update printf format specifiers from %d to %zu for MAX_REVS since
  sizeof() expressions produce size_t, not int.

I noticed the prior RFC by Meet Soni (Feb 2025, Message-ID:
<20250217055024.3978-1-meetsoni3017@gmail.com>) which Junio C Hamano
and Jeff King reviewed. That patch did the basic conversion but did
not lift the MAX_REVS limitation. This v2 addresses Junio's feedback
where he suggested "using a slab whose element is still a bag of bits
that is wider than object.flags word is the most straight-forward way
to lift MAX_REVS limitation." We use uint64_t as that wider element.

 builtin/show-branch.c | 106 ++++++++++++++++++++++++------------------
 1 file changed, 61 insertions(+), 45 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index f02831b085..625e456411 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -34,15 +34,13 @@ static enum git_colorbool showbranch_use_color = GIT_COLOR_UNKNOWN;

 static struct strvec default_args = STRVEC_INIT;

-/*
- * TODO: convert this use of commit->object.flags to commit-slab
- * instead to store a pointer to ref name directly. Then use the same
- * UNINTERESTING definition from revision.h here.
- */
 #define UNINTERESTING	01

+static uint64_t get_rev_flags(struct commit *commit);
+static void or_rev_flags(struct commit *commit, uint64_t flags);
+
 #define REV_SHIFT	 2
-#define MAX_REVS	(FLAG_BITS - REV_SHIFT) /* should not exceed bits_per_int - REV_SHIFT */
+#define MAX_REVS	(sizeof(uint64_t) * 8 - REV_SHIFT)

 #define DEFAULT_REFLOG	4

@@ -64,7 +62,7 @@ static struct commit *interesting(struct prio_queue *queue)
 {
 	for (size_t i = 0; i < queue->nr; i++) {
 		struct commit *commit = queue->array[i].data;
-		if (commit->object.flags & UNINTERESTING)
+		if (get_rev_flags(commit) & UNINTERESTING)
 			continue;
 		return commit;
 	}
@@ -79,11 +77,25 @@ struct commit_name {
 define_commit_slab(commit_name_slab, struct commit_name *);
 static struct commit_name_slab name_slab;

+define_commit_slab(commit_rev_flags, uint64_t);
+static struct commit_rev_flags rev_flags_slab;
+
 static struct commit_name *commit_to_name(struct commit *commit)
 {
 	return *commit_name_slab_at(&name_slab, commit);
 }

+static uint64_t get_rev_flags(struct commit *commit)
+{
+	uint64_t *f = commit_rev_flags_peek(&rev_flags_slab, commit);
+	return f ? *f : 0;
+}
+
+static void or_rev_flags(struct commit *commit, uint64_t flags)
+{
+	*commit_rev_flags_at(&rev_flags_slab, commit) |= flags;
+}
+

 /* Name the commit as nth generation ancestor of head_name;
  * we count only the first-parent relationship for naming purposes.
@@ -215,7 +227,7 @@ static void name_commits(struct commit_list *list,

 static int mark_seen(struct commit *commit, struct commit_list **seen_p)
 {
-	if (!commit->object.flags) {
+	if (!get_rev_flags(commit)) {
 		commit_list_insert(commit, seen_p);
 		return 1;
 	}
@@ -226,15 +238,15 @@ static void join_revs(struct prio_queue *queue,
 		      struct commit_list **seen_p,
 		      int num_rev, int extra)
 {
-	int all_mask = ((1u << (REV_SHIFT + num_rev)) - 1);
-	int all_revs = all_mask & ~((1u << REV_SHIFT) - 1);
+	uint64_t all_mask = ((UINT64_C(1) << (REV_SHIFT + num_rev)) - 1);
+	uint64_t all_revs = all_mask & ~((UINT64_C(1) << REV_SHIFT) - 1);

 	while (queue->nr) {
 		struct commit_list *parents;
 		int still_interesting = !!interesting(queue);
 		struct commit *commit = prio_queue_peek(queue);
 		bool get_pending = true;
-		int flags = commit->object.flags & all_mask;
+		uint64_t flags = get_rev_flags(commit) & all_mask;

 		if (!still_interesting && extra <= 0)
 			break;
@@ -246,14 +258,14 @@ static void join_revs(struct prio_queue *queue,

 		while (parents) {
 			struct commit *p = parents->item;
-			int this_flag = p->object.flags;
+			uint64_t this_flag = get_rev_flags(p);
 			parents = parents->next;
 			if ((this_flag & flags) == flags)
 				continue;
 			repo_parse_commit(the_repository, p);
 			if (mark_seen(p, seen_p) && !still_interesting)
 				extra--;
-			p->object.flags |= flags;
+			or_rev_flags(p, flags);
 			if (get_pending)
 				prio_queue_replace(queue, p);
 			else
@@ -278,8 +290,8 @@ static void join_revs(struct prio_queue *queue,
 			struct commit *c = s->item;
 			struct commit_list *parents;

-			if (((c->object.flags & all_revs) != all_revs) &&
-			    !(c->object.flags & UNINTERESTING))
+			if (((get_rev_flags(c) & all_revs) != all_revs) &&
+			    !(get_rev_flags(c) & UNINTERESTING))
 				continue;

 			/* The current commit is either a merge base or
@@ -292,8 +304,8 @@ static void join_revs(struct prio_queue *queue,
 			while (parents) {
 				struct commit *p = parents->item;
 				parents = parents->next;
-				if (!(p->object.flags & UNINTERESTING)) {
-					p->object.flags |= UNINTERESTING;
+				if (!(get_rev_flags(p) & UNINTERESTING)) {
+					or_rev_flags(p, UNINTERESTING);
 					changed = 1;
 				}
 			}
@@ -410,8 +422,8 @@ static int append_ref(const char *refname, const struct object_id *oid,
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
@@ -511,18 +523,20 @@ static int rev_is_head(const char *head, const char *name)

 static int show_merge_base(const struct commit_list *seen, int num_rev)
 {
-	int all_mask = ((1u << (REV_SHIFT + num_rev)) - 1);
-	int all_revs = all_mask & ~((1u << REV_SHIFT) - 1);
+	uint64_t all_mask = ((UINT64_C(1) << (REV_SHIFT + num_rev)) - 1);
+	uint64_t all_revs = all_mask & ~((UINT64_C(1) << REV_SHIFT) - 1);
 	int exit_status = 1;

 	for (const struct commit_list *s = seen; s; s = s->next) {
 		struct commit *commit = s->item;
-		int flags = commit->object.flags & all_mask;
+		uint64_t flags = get_rev_flags(commit) & all_mask;
 		if (!(flags & UNINTERESTING) &&
 		    ((flags & all_revs) == all_revs)) {
 			puts(oid_to_hex(&commit->object.oid));
 			exit_status = 0;
-			commit->object.flags |= UNINTERESTING;
+
+or_rev_flags(commit, UNINTERESTING);
+
 		}
 	}
 	return exit_status;
@@ -530,17 +544,17 @@ static int show_merge_base(const struct commit_list *seen, int num_rev)

 static int show_independent(struct commit **rev,
 			    int num_rev,
-			    unsigned int *rev_mask)
+			    uint64_t *rev_mask)
 {
 	int i;

 	for (i = 0; i < num_rev; i++) {
 		struct commit *commit = rev[i];
-		unsigned int flag = rev_mask[i];
+		uint64_t flag = rev_mask[i];

-		if (commit->object.flags == flag)
+		if (get_rev_flags(commit) == flag)
 			puts(oid_to_hex(&commit->object.oid));
-		commit->object.flags |= UNINTERESTING;
+		or_rev_flags(commit, UNINTERESTING);
 	}
 	return 0;
 }
@@ -607,9 +621,9 @@ static int omit_in_dense(struct commit *commit, struct commit **rev, int n)
 	for (i = 0; i < n; i++)
 		if (rev[i] == commit)
 			return 0;
-	flag = commit->object.flags;
+	flag = get_rev_flags(commit);
 	for (i = count = 0; i < n; i++) {
-		if (flag & (1u << (i + REV_SHIFT)))
+		if (flag & (UINT64_C(1) << (i + REV_SHIFT)))
 			count++;
 	}
 	if (count == 1)
@@ -648,10 +662,10 @@ int cmd_show_branch(int ac,
 	char *reflog_msg[MAX_REVS] = {0};
 	struct commit_list *seen = NULL;
 	struct prio_queue queue = { compare_commits_by_commit_date };
-	unsigned int rev_mask[MAX_REVS];
+	uint64_t rev_mask[MAX_REVS];
 	int num_rev, i, extra = 0;
 	int all_heads = 0, all_remotes = 0;
-	int all_mask, all_revs;
+	uint64_t all_mask, all_revs;
 	enum rev_sort_order sort_order = REV_SORT_IN_GRAPH_ORDER;
 	char *head;
 	struct object_id head_oid;
@@ -714,6 +728,7 @@ int cmd_show_branch(int ac,
 	int ret;

 	init_commit_name_slab(&name_slab);
+	init_commit_rev_flags(&rev_flags_slab);

 	repo_config(the_repository, git_show_branch_config, NULL);

@@ -759,7 +774,7 @@ int cmd_show_branch(int ac,
 		struct object_id oid;
 		char *ref;
 		int base = 0;
-		unsigned int flags = 0;
+		uint64_t flags = 0;

 		if (ac == 0) {
 			static const char *fake_av[2];
@@ -779,8 +794,8 @@ int cmd_show_branch(int ac,
 			die(_("--reflog option needs one branch name"));

 		if (MAX_REVS < reflog)
-			die(Q_("only %d entry can be shown at one time.",
-			       "only %d entries can be shown at one time.",
+			die(Q_("only %zu entry can be shown at one time.",
+			       "only %zu entries can be shown at one time.",
 			       MAX_REVS), MAX_REVS);
 		if (!repo_dwim_ref(the_repository, *av, strlen(*av), &oid,
 				   &ref, 0))
@@ -870,11 +885,11 @@ int cmd_show_branch(int ac,

 	for (num_rev = 0; ref_name[num_rev]; num_rev++) {
 		struct object_id revkey;
-		unsigned int flag = 1u << (num_rev + REV_SHIFT);
+		uint64_t flag = UINT64_C(1) << (num_rev + REV_SHIFT);

 		if (MAX_REVS <= num_rev)
-			die(Q_("cannot handle more than %d rev.",
-			       "cannot handle more than %d revs.",
+			die(Q_("cannot handle more than %zu rev.",
+			       "cannot handle more than %zu revs.",
 			       MAX_REVS), MAX_REVS);
 		if (repo_get_oid(the_repository, ref_name[num_rev], &revkey))
 			die(_("'%s' is not a valid ref."), ref_name[num_rev]);
@@ -889,13 +904,13 @@ int cmd_show_branch(int ac,
 		 * and so on.  REV_SHIFT bits from bit 0 are used for
 		 * internal bookkeeping.
 		 */
-		commit->object.flags |= flag;
-		if (commit->object.flags == flag)
+		or_rev_flags(commit, flag);
+		if (get_rev_flags(commit) == flag)
 			prio_queue_put(&queue, commit);
 		rev[num_rev] = commit;
 	}
 	for (i = 0; i < num_rev; i++)
-		rev_mask[i] = rev[i]->object.flags;
+		rev_mask[i] = get_rev_flags(rev[i]);

 	if (0 <= extra)
 		join_revs(&queue, &seen, num_rev, extra);
@@ -958,12 +973,12 @@ int cmd_show_branch(int ac,
 	if (!sha1_name && !no_name)
 		name_commits(seen, rev, ref_name, num_rev);

-	all_mask = ((1u << (REV_SHIFT + num_rev)) - 1);
-	all_revs = all_mask & ~((1u << REV_SHIFT) - 1);
+	all_mask = ((UINT64_C(1) << (REV_SHIFT + num_rev)) - 1);
+	all_revs = all_mask & ~((UINT64_C(1) << REV_SHIFT) - 1);

 	for (struct commit_list *l = seen; l; l = l->next) {
 		struct commit *commit = l->item;
-		int this_flag = commit->object.flags;
+		uint64_t this_flag = get_rev_flags(commit);
 		int is_merge_point = ((this_flag & all_revs) == all_revs);

 		shown_merge_point |= is_merge_point;
@@ -973,14 +988,14 @@ int cmd_show_branch(int ac,
 					  commit->parents->next);
 			if (topics &&
 			    !is_merge_point &&
-			    (this_flag & (1u << REV_SHIFT)))
+			    (this_flag & (UINT64_C(1) << REV_SHIFT)))
 				continue;
 			if (!sparse && is_merge &&
 			    omit_in_dense(commit, rev, num_rev))
 				continue;
 			for (i = 0; i < num_rev; i++) {
 				int mark;
-				if (!(this_flag & (1u << (i + REV_SHIFT))))
+				if (!(this_flag & (UINT64_C(1) << (i + REV_SHIFT))))
 					mark = ' ';
 				else if (is_merge)
 					mark = '-';
@@ -1010,6 +1025,7 @@ int cmd_show_branch(int ac,
 		free(reflog_msg[i]);
 	commit_list_free(seen);
 	clear_prio_queue(&queue);
+	clear_commit_rev_flags(&rev_flags_slab);
 	free(args_copy);
 	free(head);
 	return ret;
--
2.54.0

