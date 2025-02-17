Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BD4433A8
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 05:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739771480; cv=none; b=u6LEcWkAPXQmrTZC+7kmqLZW0ysVGzuSlRKNwxXkMfcFSYPIp2Gqbq5phyFUUKz8AV2XbHU5/g4x+G0QkSEWQPXq1QGk/C9snV+TVLsTBB9WzmRXjD+HIZ1c9P+QYxNNNtmsuEahB8UXreJMbeEvRELVbCUYrT38WLOuzGTbTLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739771480; c=relaxed/simple;
	bh=Bb+Lai5fS+l+FPgWCNJih5b2RHu5Y06n7/tgbIjHudQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ol73n0hReV7qMTZA1q4LJaip1PmFMMbWcDlYHt0BdFygUpye7sayGpbzV7OE31lIXwFSWhxB1g11KFHQwK/goDqsSo52Mj+pQHM1Grki7OMmumBHJ/q6muNvXJ4FFmITtslo/Rc1YG2oF3mtc7P1RKJpfE1aslKMvPrZbI5Kvcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHsymLf1; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHsymLf1"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-221206dbd7eso13251535ad.2
        for <git@vger.kernel.org>; Sun, 16 Feb 2025 21:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739771476; x=1740376276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y+aydtn3a9EVG77+hXjYVaj9Ia5xZvx4o3oLyE01W80=;
        b=NHsymLf1QlSsM3ksajNRoH8Dfekb3VrVYZP734NRxLnnW+nDa6D221U1CiMlcGKggm
         sOLyTOu3B70DNRRw2EDrwe0SpFUcoq88Z+ATscIZNygGY2C3WhvkiCFGPMSXZK8rAyrg
         sZJ619B1B4il5zfuWtojAGDk6MW3WvSM6jn/lpZ+H6a4itbTIWKRgzW3VeOxKTRwtaVJ
         SkKNA8T6E03HraZMEeVTHGQqO9t//wT7w1gVoVNSvHAsGxnrOANH4jFYmk8BXFf9xY0t
         UTgb9xWblvPk7DhwxOT2xqqFKDRrRu0D3GmWy9JNAPbKL7wNDeb0zMQ+UR88lMtp3tAD
         kdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739771476; x=1740376276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+aydtn3a9EVG77+hXjYVaj9Ia5xZvx4o3oLyE01W80=;
        b=tWHnZOj+272PVq+Ff5x08+WezCl2Qtv69o11dKePuam9/PsccahQT3kpWAzOLWDduH
         Dmq8psmpwBBdZG1RI+TIgta8a/rIQjOshvVOLpDbDmGKzn7qPy5zTwQ8m+AkWj2HGrE/
         SjxTLhJbghJbVUxS2AyXQklmQ5b8+aXCAb52060/8/BydScp3WK8v851WWWRrME3lRjh
         LLoLY7B3b8T/5mN2lQxyuZgzn5OVMiPryZGJZLXEvXnpD2afzJ1JEnuOLfLY8i02e4QF
         774uY79wmlDPIlPSGi2+KUFAv/j3568q5bmaMsJPnvawihDeMpY7oWOh1n9tEoz1W/Ht
         t5DA==
X-Gm-Message-State: AOJu0YxGxSeVJmJ0sO6+Rdp7WAzqvO7a2/GsOdA9GFntYbd1OtlG6jUz
	gqVu+9WF2GoxzWPUCcZG1VgFAjlXJ5D4sXK6scP6CnJo5pwIed8RDH4I835P
X-Gm-Gg: ASbGncs4rVXwgwSpNlDylBTQUWwLYP4MIsmWVOaLKO5jr7eGLdId6/8vPC76CUHorIv
	RuGWl0d94iCbVUl8tiDEUu4k3io7lIJZ60qZAszLro4MiKaYzs91hN9AFdNPat2SzTovJWcfePd
	ZdTCvgOTXRZNmRbRvCXU8na/qOupDfZa/36qarQDKyw0g3mDORFZJztqL4cl/DyLn6jD9LabGP7
	eG96SCV7rvWQpUgkorNIXlsDt6ReIqEcctvV+6O3GVynT12p4o+qjpZE7e0ku0Hem2/IjjsOp3H
	GjvGssmKSUvKwA==
X-Google-Smtp-Source: AGHT+IGOPYZXhJdgkrd4U6olSbZOTjFfB9/y4NQb4/WB02qhJvRi5Ks0hSxS45fCR8qivsgZNMJytw==
X-Received: by 2002:a17:903:22c7:b0:21f:f29:a421 with SMTP id d9443c01a7336-22103ef3000mr154390085ad.10.1739771475811;
        Sun, 16 Feb 2025 21:51:15 -0800 (PST)
Received: from meet.. ([103.240.170.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22105174c73sm31626165ad.216.2025.02.16.21.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 21:51:15 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: Meet Soni <meetsoni3017@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Calvin Wan <calvinwan@google.com>,
	Elijah Newren <newren@gmail.com>
Subject: [GSoC][RFC PATCH] show-branch: use commit-slab for flag storage
Date: Mon, 17 Feb 2025 11:20:49 +0530
Message-Id: <20250217055049.9217-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace direct accesses to commit->object.flags with the commit-slab
mechanism. Introduce `get_commit_flags()` and `set_commit_flags()` to
retrieve and update flags, respectively, and include `revision.h` so that
the canonical UNINTERESTING definition is used.

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
I'm not entirely sure what the TODO comment meant by storing a pointer to
the "ref name" directly, so I've assumed that the intent was to store
flags (of type int) directly in the commit-slab instead of commit->object.

I've tested these changes using:
 - test suite -- they passed.
 - github ci result -- https://github.com/inosmeet/git/actions/runs/13355488433

The review from Junio that led to this TODO comment [1]:
> Another place we could use commit-slab in this program, which I
> think is a more interesting application, is to use it to store a
> bitmask with runtime-computed width to replace those object->flags
> bits, which will allow us to lift the MAX_REVS limitation.

Ultimately, I'm interested in implementing this change and would appreciate
some guidance. Specifically, does this mean I should define the commit-slab
using a struct containing both an int and a size, instead of just an int?

[1]: https://lore.kernel.org/git/xmqq36yud9bp.fsf@gitster-ct.c.googlers.com/

 builtin/show-branch.c | 59 +++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 25 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index fce6b404e9..909a22990d 100644
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
@@ -33,18 +34,25 @@ static int showbranch_use_color = -1;
 
 static struct strvec default_args = STRVEC_INIT;
 
-/*
- * TODO: convert this use of commit->object.flags to commit-slab
- * instead to store a pointer to ref name directly. Then use the same
- * UNINTERESTING definition from revision.h here.
- */
-#define UNINTERESTING	01
-
 #define REV_SHIFT	 2
 #define MAX_REVS	(FLAG_BITS - REV_SHIFT) /* should not exceed bits_per_int - REV_SHIFT */
 
 #define DEFAULT_REFLOG	4
 
+define_commit_slab(commit_flags, int);
+static struct commit_flags commit_flags;
+
+static int get_commit_flags(struct commit *commit)
+{
+	int *result = commit_flags_peek(&commit_flags, commit);
+	return result ? *result : 0;
+}
+
+static void set_commit_flags(struct commit *commit, int flags)
+{
+	*commit_flags_at(&commit_flags, commit) = flags;
+}
+
 static const char *get_color_code(int idx)
 {
 	if (want_color(showbranch_use_color))
@@ -64,7 +72,7 @@ static struct commit *interesting(struct commit_list *list)
 	while (list) {
 		struct commit *commit = list->item;
 		list = list->next;
-		if (commit->object.flags & UNINTERESTING)
+		if (get_commit_flags(commit) & UNINTERESTING)
 			continue;
 		return commit;
 	}
@@ -215,7 +223,7 @@ static void name_commits(struct commit_list *list,
 
 static int mark_seen(struct commit *commit, struct commit_list **seen_p)
 {
-	if (!commit->object.flags) {
+	if (!get_commit_flags(commit)) {
 		commit_list_insert(commit, seen_p);
 		return 1;
 	}
@@ -233,7 +241,7 @@ static void join_revs(struct commit_list **list_p,
 		struct commit_list *parents;
 		int still_interesting = !!interesting(*list_p);
 		struct commit *commit = pop_commit(list_p);
-		int flags = commit->object.flags & all_mask;
+		int flags = get_commit_flags(commit) & all_mask;
 
 		if (!still_interesting && extra <= 0)
 			break;
@@ -245,14 +253,14 @@ static void join_revs(struct commit_list **list_p,
 
 		while (parents) {
 			struct commit *p = parents->item;
-			int this_flag = p->object.flags;
+			int this_flag = get_commit_flags(p);
 			parents = parents->next;
 			if ((this_flag & flags) == flags)
 				continue;
 			repo_parse_commit(the_repository, p);
 			if (mark_seen(p, seen_p) && !still_interesting)
 				extra--;
-			p->object.flags |= flags;
+			set_commit_flags(p, get_commit_flags(p) | flags);
 			commit_list_insert_by_date(p, list_p);
 		}
 	}
@@ -271,8 +279,8 @@ static void join_revs(struct commit_list **list_p,
 			struct commit *c = s->item;
 			struct commit_list *parents;
 
-			if (((c->object.flags & all_revs) != all_revs) &&
-			    !(c->object.flags & UNINTERESTING))
+			if (((get_commit_flags(c) & all_revs) != all_revs) &&
+			    !(get_commit_flags(c) & UNINTERESTING))
 				continue;
 
 			/* The current commit is either a merge base or
@@ -285,8 +293,8 @@ static void join_revs(struct commit_list **list_p,
 			while (parents) {
 				struct commit *p = parents->item;
 				parents = parents->next;
-				if (!(p->object.flags & UNINTERESTING)) {
-					p->object.flags |= UNINTERESTING;
+				if (!(get_commit_flags(p) & UNINTERESTING)) {
+					set_commit_flags(p, get_commit_flags(p) | UNINTERESTING);
 					changed = 1;
 				}
 			}
@@ -513,12 +521,12 @@ static int show_merge_base(const struct commit_list *seen, int num_rev)
 
 	for (const struct commit_list *s = seen; s; s = s->next) {
 		struct commit *commit = s->item;
-		int flags = commit->object.flags & all_mask;
+		int flags = get_commit_flags(commit) & all_mask;
 		if (!(flags & UNINTERESTING) &&
 		    ((flags & all_revs) == all_revs)) {
 			puts(oid_to_hex(&commit->object.oid));
 			exit_status = 0;
-			commit->object.flags |= UNINTERESTING;
+			set_commit_flags(commit, get_commit_flags(commit) | UNINTERESTING);
 		}
 	}
 	return exit_status;
@@ -534,9 +542,9 @@ static int show_independent(struct commit **rev,
 		struct commit *commit = rev[i];
 		unsigned int flag = rev_mask[i];
 
-		if (commit->object.flags == flag)
+		if (get_commit_flags(commit) == flag)
 			puts(oid_to_hex(&commit->object.oid));
-		commit->object.flags |= UNINTERESTING;
+		set_commit_flags(commit, get_commit_flags(commit) | UNINTERESTING);
 	}
 	return 0;
 }
@@ -603,7 +611,7 @@ static int omit_in_dense(struct commit *commit, struct commit **rev, int n)
 	for (i = 0; i < n; i++)
 		if (rev[i] == commit)
 			return 0;
-	flag = commit->object.flags;
+	flag = get_commit_flags(commit);
 	for (i = count = 0; i < n; i++) {
 		if (flag & (1u << (i + REV_SHIFT)))
 			count++;
@@ -702,6 +710,7 @@ int cmd_show_branch(int ac,
 	int ret;
 
 	init_commit_name_slab(&name_slab);
+	init_commit_flags(&commit_flags);
 
 	git_config(git_show_branch_config, NULL);
 
@@ -877,13 +886,13 @@ int cmd_show_branch(int ac,
 		 * and so on.  REV_SHIFT bits from bit 0 are used for
 		 * internal bookkeeping.
 		 */
-		commit->object.flags |= flag;
-		if (commit->object.flags == flag)
+		set_commit_flags(commit, get_commit_flags(commit) | flag);
+		if (get_commit_flags(commit) == flag)
 			commit_list_insert_by_date(commit, &list);
 		rev[num_rev] = commit;
 	}
 	for (i = 0; i < num_rev; i++)
-		rev_mask[i] = rev[i]->object.flags;
+		rev_mask[i] = get_commit_flags(rev[i]);
 
 	if (0 <= extra)
 		join_revs(&list, &seen, num_rev, extra);
@@ -951,7 +960,7 @@ int cmd_show_branch(int ac,
 
 	for (struct commit_list *l = seen; l; l = l->next) {
 		struct commit *commit = l->item;
-		int this_flag = commit->object.flags;
+		int this_flag = get_commit_flags(commit);
 		int is_merge_point = ((this_flag & all_revs) == all_revs);
 
 		shown_merge_point |= is_merge_point;

base-commit: e2067b49ecaef9b7f51a17ce251f9207f72ef52d
-- 
2.34.1

