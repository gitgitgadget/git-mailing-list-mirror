Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAD22DEA8C
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 18:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053837; cv=none; b=lKl5aq88urzytyF9aLhGlopflmhZdD7ZlAO9Aq+sTtqMo1fiDqwkyhPsu+/L6SCpRg1IDzd+o/zKvGMjElb1fftleUyLugEEONjz4mRmm8vwBZBOl67cNChfPfQMwYiPXFoappSWhNmDNPtXKdtvHTnHaU/MGwj9tsqBBHRvYHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053837; c=relaxed/simple;
	bh=5VshsMO+gmCybepeU1hQOAWR64YQUxI31Z3sOCqDKBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uHCNuXLoerTe5e1OAHe+nSb2ObSxYoKSloCnUgJ7c37b2593hKkSS2gPHfLc+QIuigYFxREB3ECWV4jKMfQ6066GufxEA7w81dPew5cBOaCrVaSr6XBeJ5CkXSLfjgxYO7IFp9HiYCuXU2o+z+kCcb+Ul2Gm3rJBCw6PHR+Vjj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmubTUtD; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmubTUtD"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-381191ea2adso2967289a91.1
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 11:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784053835; x=1784658635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SUyK9HIfF+hQQRFLupIC7lzuB9kefpXIX0EC+ifITy0=;
        b=AmubTUtD564rBoKi0ZRdk4IFbL2hgjZ+GC2YsQdYtAr+tidvDwaOYt7eZPIt6h0A2i
         WekopLV+kWXrMFNVUYXPDUewiMk8K5MeFNmvBLCyo+vc3msvmYEAY4MC9X07Sj3CNapw
         DHAk+HPz1PtVRsyPkQqYGPOy+TFlDsQbpWkhZiTjS5sdM5xB5unH0I8ybJcPSbOjKsXs
         0gx2seyHI4+1k8UdPSxOToI+//2bCshNYuC3jXolGZXAJD0Mc6CkJZWo9gFpIpn+yHrI
         +5lfpTUGSxSx/jqYRGB5YzbOAimNzYkUCjTo6hXefBUS1MR200RgQlypEi7EMNwvAel+
         mU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053835; x=1784658635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SUyK9HIfF+hQQRFLupIC7lzuB9kefpXIX0EC+ifITy0=;
        b=YAkXWtymS8VL4wGfN9h2olG8VX2eiL3zI24kOOU1T1/BpbCMGVa2jOjMygUlWhURQC
         XSCJofn4QpZyvujfks4z/jNsFycatUnCF0oA8IDsytVK9VMV+g/lRDCGu+qNU37qoykx
         trAxbWdqpEC70yYoT/l2o2/sWODBbFqOEhSS2XP1riYXsvZDaY56NjnVT/+iOFEMIGKr
         B0B7eQVISzwaacCoy4tovOz7DTyrEIEXYi3MeNnTwkhkYa0zMaEMyNXRafpi5fqXVuN4
         VYFhb1+N+qmSlEYF899owX6o+sHT3hx1jFMsCTioPTjqBGDm+3ew1ByMNl+r2XpTM+Rv
         swAg==
X-Gm-Message-State: AOJu0YxJPYCXXocN3hbWrr59jfbV3geTiDumo10qugFynLH7lZ/ASg8l
	su29FkOhEaxlYeO0RUJgZ95Ca2kPbzii/WchCNhekHtPl6fL4LD6jrdLENpJMa10CT0=
X-Gm-Gg: AfdE7cmwLZt0pZCl8BeTelELuH5TSclgJ+HY6uvvBTcP7wVncBqy5jcS2mK53p+Hyrb
	AzUtvrGVFJsR1bby3xcYkXzg6Hdq9sP6z/hMyIBsJkWXLXmMw3+GHMjyukyb0sIB9CxCPgiFwnT
	C5kvMGYfaeDPh1sziIiqHm81EWgiD6sPNr375AZllKvj529fqyKSsx65RMFQp0rRnicuSnb2tFv
	Gm4N3XSIFRdvEeySnlbd8FHa69dFSaMEaeoH1mZuB5+Kg76D9cIsn1ouYs+2qKvNQZXIS0A4LHr
	iQzTljNZME6UkRrMQZodUU4wG0dCDdz8f9JF4SAJZWqad6fCFSDVT+xJOOhdAwyxooAowTrf7SM
	7drhCtLfgPdByWRII0KlkzclbEaG4o2mv/PWKkvyAVfX29o+BBg6k/TsgavSbD4Oa+hDxSzsnDM
	XQ9n/rFF4uwOSxSfjKR0p6ULOGI5NDdEjj4exb6ziLQtw4RgBS32W/UbDFOQ==
X-Received: by 2002:a05:6a21:32a2:b0:3bf:6c05:a4 with SMTP id adf61e73a8af0-3c34d86fd8bmr6155757637.51.1784053835169;
        Tue, 14 Jul 2026 11:30:35 -0700 (PDT)
Received: from localhost.localdomain ([45.117.66.213])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm149121131c88.14.2026.07.14.11.30.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 11:30:34 -0700 (PDT)
From: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
To: git@vger.kernel.org
Cc: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Subject: [PATCH] show-branch: convert object.flags usage to a commit-slab
Date: Wed, 15 Jul 2026 00:00:28 +0530
Message-ID: <20260714183028.67857-1-gatlavishweshwarreddy26@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

show-branch uses commit->object.flags to store two kinds of
per-commit data: the UNINTERESTING bit to mark commits that are
ancestors of all given revisions, and per-branch reachability
bits (one bit per branch, starting at REV_SHIFT) to track which
branches can reach each commit.

Using the shared object.flags field for this purpose is fragile.
The field is shared across the entire Git codebase and other
subsystems use it for their own bookkeeping. Storing show-branch
specific data there risks conflicts with other users of the same
field.

Convert this usage to a dedicated commit-slab named
commit_rev_flags, which is the canonical way to associate
per-commit data in Git without polluting the shared object flags.
Add helper functions get_rev_flags() and or_rev_flags() to
encapsulate slab access cleanly, and initialize and clear the
slab in cmd_show_branch() to avoid memory leaks.

Signed-off-by: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
---
 builtin/show-branch.c | 62 +++++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index f02831b085..ad3a85fafa 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -34,13 +34,11 @@ static enum git_colorbool showbranch_use_color = GIT_COLOR_UNKNOWN;
 
 static struct strvec default_args = STRVEC_INIT;
 
-/*
- * TODO: convert this use of commit->object.flags to commit-slab
- * instead to store a pointer to ref name directly. Then use the same
- * UNINTERESTING definition from revision.h here.
- */
 #define UNINTERESTING	01
 
+static unsigned int get_rev_flags(struct commit *commit);
+static void or_rev_flags(struct commit *commit, unsigned int flags);
+
 #define REV_SHIFT	 2
 #define MAX_REVS	(FLAG_BITS - REV_SHIFT) /* should not exceed bits_per_int - REV_SHIFT */
 
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
 
+define_commit_slab(commit_rev_flags, unsigned int);
+static struct commit_rev_flags rev_flags_slab;
+
 static struct commit_name *commit_to_name(struct commit *commit)
 {
 	return *commit_name_slab_at(&name_slab, commit);
 }
 
+static unsigned int get_rev_flags(struct commit *commit)
+{
+	unsigned int *f = commit_rev_flags_peek(&rev_flags_slab, commit);
+	return f ? *f : 0;
+}
+
+static void or_rev_flags(struct commit *commit, unsigned int flags)
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
@@ -234,7 +246,7 @@ static void join_revs(struct prio_queue *queue,
 		int still_interesting = !!interesting(queue);
 		struct commit *commit = prio_queue_peek(queue);
 		bool get_pending = true;
-		int flags = commit->object.flags & all_mask;
+		int flags = get_rev_flags(commit) & all_mask;
 
 		if (!still_interesting && extra <= 0)
 			break;
@@ -246,14 +258,14 @@ static void join_revs(struct prio_queue *queue,
 
 		while (parents) {
 			struct commit *p = parents->item;
-			int this_flag = p->object.flags;
+			int this_flag = get_rev_flags(p);
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
@@ -517,12 +529,14 @@ static int show_merge_base(const struct commit_list *seen, int num_rev)
 
 	for (const struct commit_list *s = seen; s; s = s->next) {
 		struct commit *commit = s->item;
-		int flags = commit->object.flags & all_mask;
+		int flags = get_rev_flags(commit) & all_mask;
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
@@ -538,9 +552,9 @@ static int show_independent(struct commit **rev,
 		struct commit *commit = rev[i];
 		unsigned int flag = rev_mask[i];
 
-		if (commit->object.flags == flag)
+		if (get_rev_flags(commit) == flag)
 			puts(oid_to_hex(&commit->object.oid));
-		commit->object.flags |= UNINTERESTING;
+		or_rev_flags(commit, UNINTERESTING);
 	}
 	return 0;
 }
@@ -607,7 +621,7 @@ static int omit_in_dense(struct commit *commit, struct commit **rev, int n)
 	for (i = 0; i < n; i++)
 		if (rev[i] == commit)
 			return 0;
-	flag = commit->object.flags;
+	flag = get_rev_flags(commit);
 	for (i = count = 0; i < n; i++) {
 		if (flag & (1u << (i + REV_SHIFT)))
 			count++;
@@ -714,6 +728,7 @@ int cmd_show_branch(int ac,
 	int ret;
 
 	init_commit_name_slab(&name_slab);
+	init_commit_rev_flags(&rev_flags_slab);
 
 	repo_config(the_repository, git_show_branch_config, NULL);
 
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
@@ -963,7 +978,7 @@ int cmd_show_branch(int ac,
 
 	for (struct commit_list *l = seen; l; l = l->next) {
 		struct commit *commit = l->item;
-		int this_flag = commit->object.flags;
+		int this_flag = get_rev_flags(commit);
 		int is_merge_point = ((this_flag & all_revs) == all_revs);
 
 		shown_merge_point |= is_merge_point;
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

