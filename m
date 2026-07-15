Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0460D446BE8
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784140990; cv=none; b=NVX3c41OTkjMTIR7ipH+1yoN4LPlh2W9wrvVAdSIS0m9oEHK3uy/TiOPJnSWNGeBjwKbhcp27XmlfbbVN0V8FIYTfhGXXHur92K59R/o1dN71GSrgPDveSYeCvqjMp94r5C/AJWsfmVG+NXHD+ZPfaE9gZHli4Vl1ljre0HoPaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784140990; c=relaxed/simple;
	bh=J/650pACHADIBLBnfJH3CC7knXFRtnLQsxqWN1ll3ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQK/nDUPqq+MB/XOhNpxBK2PjvRim33vkw3Ciz3fT8fiFUK46v+zTxIhRfuN0UVFtdomOPRoDMC3otgQz+gVeEYPxsMYKijdbROkg8kAOO4KaMXKvO/ONxDvN9ji287LJZEWiO1dNfcQ6l+3BckXd3TZsA6WfMWEHRkCFZGfFBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7fPq2EA; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7fPq2EA"
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2ccc2e84048so33501625ad.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 11:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784140974; x=1784745774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z9nIDoxyTjGMMBLPHAhxR3cZKFyCD2auM75FH8eHbAI=;
        b=l7fPq2EAImo9NjYP3c0xeR/C13krdmMiENy8ZCwcHpnAcBQOYj+vJn4vRjwxuOejRt
         u1FYxA4blGX7tuN+D/+ERwgl2Gb+Jpu2hU0jmlIOaIj5/LghalKc4Ag+Fv2VzC+V4GsD
         uJIqnxcWdsFEGGcMppJPu2hcnMeSDlLHAvMbfPqZGDkLqcYLY/fackrfBHD+5Ydbb6j3
         v6IfBhSOllxvTITZ1d3yvXd+76sd5jDC/n8NkNDPtMxrBRTjnzZPRmrzGoEXou7WJakr
         ytAs/4Xem1BIbF761dl54hbdoYL+lRuYUrEiEAFFmPMqNZ1jWFqSgNltmPlAggahXsgD
         lZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784140974; x=1784745774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z9nIDoxyTjGMMBLPHAhxR3cZKFyCD2auM75FH8eHbAI=;
        b=chBy8koBTH1wIC6ST58IWDSPUxq4/Jafe+mtXvFLDd5ZiVmGR5L17zRqpzXw+wmiEs
         tpb9jzfxVAiSdtxPsEe2E6wx0W+dTi1niri8mBd8ChD8XYC/q0a8cz5SYtiiNrUkf4hc
         uKYlVZXiocXDL/dyku9UCUq2u6VQjMuMUhUuj9k5/cJTd7jNmp1yyF8Oe5PB3Hce/PMF
         fbRULxXtyM86xwKuP770VW372PlMIzoF3lp1g8+EXDTyEFy2vKZ9deNje9vjtG7su+mt
         dFNi3tQEmbxoNtnRAh+ztlQrwInnuSpZ7dutAihQ9tMPFRho07iQNJPcNorspCXGspl2
         K7qg==
X-Gm-Message-State: AOJu0YwkhUKiIIB76abkj/9gHCVDAFNCzFNmk91p3SF8E7bYmZR/iSrW
	jUaNynY9ZIgXaj9J3haxRBrFbKVji2Tyv5EYdZmJg6BIvigzr6iL8w9U
X-Gm-Gg: AfdE7cnznVxTPIgc4E67dhyu8AHt6gPfuWerWIIUVq/D5ZWcO1yYefwguAkOFgQKaNA
	2Xzhes4r0K9JAM9eaeEE0Z9y0UhtArHIUtsdB2gcWwNSd3XNhRsdPOuygRWYoaw0RjxW6hlbYjy
	SJa6DeWJYK53AHxOBc+6Cn/s9aCZunb/5bZMvQDdPnUnpnK/+dupPYiGFW56qmJRWTV3KnMC5Jf
	oNVPlt53MJPrGV3oBpSAdE0F3v5pNSlOszZ7qrTTYeqXC/iDHnAJZLmQO1qtT6hAzV7HgzZDZHi
	9wnPIm19bQ8LPNdYPkxmIsovHkfbwEk0cIs2bBlYndnCOKgeB2dUmTbyaVkL0DDLzH3azG38atM
	HnAD0DtTkUw+WHgwt/UO0RalTkUHVdPmoBAAhkxa97mI9UvEnIOi38SJNw55IfY1FlOuPHjbE5M
	ssJt+nRZVgofXy86+DcWhSyEvgeZAzocJmtvrUbrHYVhf85C7U/q74c/H/lSqcnu3F+jZu
X-Received: by 2002:a05:6a20:3ca1:b0:3b4:7eb0:47a1 with SMTP id adf61e73a8af0-3c356fe2120mr9288852637.19.1784140973951;
        Wed, 15 Jul 2026 11:42:53 -0700 (PDT)
Received: from localhost.localdomain ([45.117.66.213])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd4359166sm3301804c88.14.2026.07.15.11.42.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 11:42:53 -0700 (PDT)
From: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Subject: [PATCH v6] show-branch: convert per-branch flags to commit-slab
Date: Thu, 16 Jul 2026 00:12:41 +0530
Message-ID: <20260715184241.56635-1-gatlavishweshwarreddy26@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <xmqqy0fcnpee.fsf@gitster.g>
References: <xmqqy0fcnpee.fsf@gitster.g>
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
has_any_rev_flags(), or_rev_flag_bit(), test_rev_flag_bit(),
has_all_rev_flags(), has_only_rev_flag_bit() to encapsulate per-bit
slab access cleanly. Use has_only_rev_flag_bit() in show_independent()
to preserve the original semantics: a commit is independent only if
reachable from exactly one tip. Update all bit operations to use
UINT64_C(1) for correct 64-bit shifts.

Fix join_revs() to correctly propagate UNINTERESTING to parents: use
a local commit_is_merge_base variable to track whether the current
commit is a merge base, and propagate UNINTERESTING to its parents
without smudging the commit itself, matching the original behavior.

Update format strings from %d to %lu with unsigned long cast since
MAX_REVS is now size_t-based. Update documentation to reflect the
new limit of 64 branches. Add tests to verify show-branch works
correctly with more than 27 branches. Include revision.h for the
shared UNINTERESTING definition.

Signed-off-by: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
---

Thank you for the thorough review. Replies inline:

> In the original, a local 'flags' variable is made UNINTERESTING,
> which is then used in the 'while' loop below to inspect and
> propagate the UNINTERESTING (and other) bits to the parents,
> without smudging the current commit itself.

Correct. Fixed in v6 using a local commit_is_merge_base variable.
When the commit has all rev bits set, we propagate UNINTERESTING
to its parents via p->object.flags |= UNINTERESTING, but do not
touch the commit itself. The postprocess loop then handles marking
merge-base commits UNINTERESTING for display purposes.

> In the updated code, you do not paint these parents UNINTERESTING
> at all.

Fixed. Parents are now painted UNINTERESTING when commit_is_merge_base
is true, matching the original p->object.flags |= flags behavior.

> What is this change about? (blank line removal)

An accidental whitespace change with no semantic meaning. Restored
in v6.

> our CodingGuidelines document says we cannot portably use "%zu"
> yet. Can't we use an unsigned long or something more established?

Changed to %lu with explicit (unsigned long) cast throughout.

> "It cannot show more than 26 branches and commits", which needs
> updating. We should check if any existing tests need updating,
> and write a few new ones.

Updated documentation to say 64. Added three new tests in
t3202-show-branch.sh verifying show-branch works correctly with
30 branches, including --independent and --merge-base modes.

---
Changes in v6:
- Fix join_revs() UNINTERESTING propagation (Junio)
- Fix parent skip condition (Junio)
- Restore blank line before postprocess comment (Junio)
- %zu -> %lu with (unsigned long) cast (Junio)
- Update docs from 26 to 64 branches (Junio)
- Add tests for 30+ branches (Junio)

 Documentation/git-show-branch.adoc |   2 +-
 builtin/show-branch.c              | 199 ++++++++++++++++++-----------
 t/t3202-show-branch.sh             |  32 +++++
 3 files changed, 157 insertions(+), 76 deletions(-)

diff --git a/Documentation/git-show-branch.adoc b/Documentation/git-show-branch.adoc
index 7e86d54a24..fe65c0a95a 100644
--- a/Documentation/git-show-branch.adoc
+++ b/Documentation/git-show-branch.adoc
@@ -22,7 +22,7 @@ Shows the commit ancestry graph starting from the commits named
 with <rev>s or <glob>s (or all refs under refs/heads
 and/or refs/tags) semi-visually.
 
-It cannot show more than 26 branches and commits at a time.
+It cannot show more than 64 branches and commits at a time.
 
 It uses `showbranch.default` multi-valued configuration items if
 no <rev> or <glob> is given on the command line.
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index f02831b085..f7b52d6cb1 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -9,6 +9,7 @@
 #include "hex.h"
 #include "pretty.h"
 #include "refs.h"
+#include "revision.h"
 #include "color.h"
 #include "strvec.h"
 #include "object-name.h"
@@ -35,15 +36,12 @@ static enum git_colorbool showbranch_use_color = GIT_COLOR_UNKNOWN;
 static struct strvec default_args = STRVEC_INIT;
 
 /*
- * TODO: convert this use of commit->object.flags to commit-slab
- * instead to store a pointer to ref name directly. Then use the same
- * UNINTERESTING definition from revision.h here.
+ * TODO: store a pointer to ref name directly in the commit-slab
+ * instead, and use the UNINTERESTING definition from revision.h
+ * here once that is done.
  */
-#define UNINTERESTING	01
-
-#define REV_SHIFT	 2
-#define MAX_REVS	(FLAG_BITS - REV_SHIFT) /* should not exceed bits_per_int - REV_SHIFT */
-
+#define REV_SHIFT	 0
+#define MAX_REVS	(sizeof(uint64_t) * 8)
 #define DEFAULT_REFLOG	4
 
 static const char *get_color_code(int idx)
@@ -79,11 +77,72 @@ struct commit_name {
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
+
+static int has_only_rev_flag_bit(struct commit *commit, int branch)
+{
+	uint64_t *f = peek_rev_flags_ptr(commit);
+	int i;
+	if (!f)
+		return 0;
+	for (i = 0; i < flags_stride; i++) {
+		uint64_t expected = (i == branch / 64)
+				    ? (UINT64_C(1) << (branch % 64))
+				    : 0;
+		if (f[i] != expected)
+			return 0;
+	}
+	return 1;
+}
 
 /* Name the commit as nth generation ancestor of head_name;
  * we count only the first-parent relationship for naming purposes.
@@ -215,7 +274,7 @@ static void name_commits(struct commit_list *list,
 
 static int mark_seen(struct commit *commit, struct commit_list **seen_p)
 {
-	if (!commit->object.flags) {
+	if (!has_any_rev_flags(commit)) {
 		commit_list_insert(commit, seen_p);
 		return 1;
 	}
@@ -226,39 +285,43 @@ static void join_revs(struct prio_queue *queue,
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
-		parents = commit->parents;
-
-		while (parents) {
-			struct commit *p = parents->item;
-			int this_flag = p->object.flags;
-			parents = parents->next;
-			if ((this_flag & flags) == flags)
-				continue;
-			repo_parse_commit(the_repository, p);
-			if (mark_seen(p, seen_p) && !still_interesting)
-				extra--;
-			p->object.flags |= flags;
-			if (get_pending)
-				prio_queue_replace(queue, p);
-			else
-				prio_queue_put(queue, p);
-			get_pending = false;
+		{
+			int commit_is_merge_base = has_all_rev_flags(commit, num_rev);
+			parents = commit->parents;
+
+			while (parents) {
+				struct commit *p = parents->item;
+				parents = parents->next;
+				if (has_all_rev_flags(p, num_rev) &&
+				    (!commit_is_merge_base || (p->object.flags & UNINTERESTING)))
+					continue;
+				repo_parse_commit(the_repository, p);
+				if (mark_seen(p, seen_p) && !still_interesting)
+					extra--;
+				{
+					int _b;
+					for (_b = 0; _b < num_rev; _b++)
+						if (test_rev_flag_bit(commit, _b))
+							or_rev_flag_bit(p, _b);
+				}
+				if (commit_is_merge_base)
+					p->object.flags |= UNINTERESTING;
+				if (get_pending)
+					prio_queue_replace(queue, p);
+				else
+					prio_queue_put(queue, p);
+				get_pending = false;
+			}
 		}
 		if (get_pending)
 			prio_queue_get(queue);
@@ -278,7 +341,7 @@ static void join_revs(struct prio_queue *queue,
 			struct commit *c = s->item;
 			struct commit_list *parents;
 
-			if (((c->object.flags & all_revs) != all_revs) &&
+			if (!has_all_rev_flags(c, num_rev) &&
 			    !(c->object.flags & UNINTERESTING))
 				continue;
 
@@ -410,9 +473,9 @@ static int append_ref(const char *refname, const struct object_id *oid,
 				return 0;
 	}
 	if (MAX_REVS <= ref_name_cnt) {
-		warning(Q_("ignoring %s; cannot handle more than %d ref",
-			   "ignoring %s; cannot handle more than %d refs",
-			   MAX_REVS), refname, MAX_REVS);
+		warning(Q_("ignoring %s; cannot handle more than %lu ref",
+			   "ignoring %s; cannot handle more than %lu refs",
+			   MAX_REVS), refname, (unsigned long)MAX_REVS);
 		return 0;
 	}
 	ref_name[ref_name_cnt++] = xstrdup(refname);
@@ -511,15 +574,12 @@ static int rev_is_head(const char *head, const char *name)
 
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
@@ -528,17 +588,13 @@ static int show_merge_base(const struct commit_list *seen, int num_rev)
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
+		if (has_only_rev_flag_bit(commit, i))
 			puts(oid_to_hex(&commit->object.oid));
 		commit->object.flags |= UNINTERESTING;
 	}
@@ -603,13 +659,12 @@ static int omit_in_dense(struct commit *commit, struct commit **rev, int n)
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
@@ -648,10 +703,8 @@ int cmd_show_branch(int ac,
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
@@ -713,7 +766,8 @@ int cmd_show_branch(int ac,
 	const char **args_copy = NULL;
 	int ret;
 
-	init_commit_name_slab(&name_slab);
+	flags_stride = (MAX_REVS + 63) / 64;
+	init_commit_rev_flags_with_stride(&rev_flags_slab, flags_stride);
 
 	repo_config(the_repository, git_show_branch_config, NULL);
 
@@ -779,9 +833,9 @@ int cmd_show_branch(int ac,
 			die(_("--reflog option needs one branch name"));
 
 		if (MAX_REVS < reflog)
-			die(Q_("only %d entry can be shown at one time.",
-			       "only %d entries can be shown at one time.",
-			       MAX_REVS), MAX_REVS);
+			die(Q_("only %lu entry can be shown at one time.",
+			       "only %lu entries can be shown at one time.",
+			       MAX_REVS), (unsigned long)MAX_REVS);
 		if (!repo_dwim_ref(the_repository, *av, strlen(*av), &oid,
 				   &ref, 0))
 			die(_("no such ref %s"), *av);
@@ -870,12 +924,12 @@ int cmd_show_branch(int ac,
 
 	for (num_rev = 0; ref_name[num_rev]; num_rev++) {
 		struct object_id revkey;
-		unsigned int flag = 1u << (num_rev + REV_SHIFT);
+		int first_seen;
 
 		if (MAX_REVS <= num_rev)
-			die(Q_("cannot handle more than %d rev.",
-			       "cannot handle more than %d revs.",
-			       MAX_REVS), MAX_REVS);
+			die(Q_("cannot handle more than %lu rev.",
+			       "cannot handle more than %lu revs.",
+			       MAX_REVS), (unsigned long)MAX_REVS);
 		if (repo_get_oid(the_repository, ref_name[num_rev], &revkey))
 			die(_("'%s' is not a valid ref."), ref_name[num_rev]);
 		commit = lookup_commit_reference(the_repository, &revkey);
@@ -885,17 +939,15 @@ int cmd_show_branch(int ac,
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
@@ -908,7 +960,7 @@ int cmd_show_branch(int ac,
 	}
 
 	if (independent) {
-		ret = show_independent(rev, num_rev, rev_mask);
+		ret = show_independent(rev, num_rev);
 		goto out;
 	}
 
@@ -958,13 +1010,9 @@ int cmd_show_branch(int ac,
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
 
@@ -973,14 +1021,14 @@ int cmd_show_branch(int ac,
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
@@ -1010,6 +1058,7 @@ int cmd_show_branch(int ac,
 		free(reflog_msg[i]);
 	commit_list_free(seen);
 	clear_prio_queue(&queue);
+	clear_commit_rev_flags(&rev_flags_slab);
 	free(args_copy);
 	free(head);
 	return ret;
diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
index a1139f79e2..d04f642998 100755
--- a/t/t3202-show-branch.sh
+++ b/t/t3202-show-branch.sh
@@ -283,4 +283,36 @@ test_expect_success '--reflog handles missing reflog' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'show-branch with 30 branches succeeds' '
+	git checkout initial &&
+	for i in $(test_seq 11 30)
+	do
+		git checkout -b branch$i initial &&
+		test_commit --no-tag branch$i || return 1
+	done &&
+	git show-branch $(git for-each-ref \
+		--sort=version:refname \
+		--format="%(refname:strip=2)" \
+		"refs/heads/branch*") >actual &&
+	test_line_count -ge 30 actual
+'
+
+test_expect_success 'show-branch --independent with 30 branches' '
+	git show-branch --independent $(git for-each-ref \
+		--sort=version:refname \
+		--format="%(refname:strip=2)" \
+		"refs/heads/branch*") >actual &&
+	test_line_count -ge 30 actual
+'
+
+test_expect_success 'show-branch --merge-base with 30 branches' '
+	git rev-parse initial >expect &&
+	git show-branch --merge-base $(git for-each-ref \
+		--sort=version:refname \
+		--format="%(refname:strip=2)" \
+		"refs/heads/branch*") >actual &&
+	test_cmp expect actual
+'
+
+
 test_done
-- 
2.54.0

