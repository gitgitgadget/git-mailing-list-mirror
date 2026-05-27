Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE42B37F00A
	for <git@vger.kernel.org>; Wed, 27 May 2026 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779897010; cv=none; b=IZFcO+p0POKNem0nrnREyH4kt3zpnpmT12F/I9L29CdCb95+LYIP1p9S76BZD5wG+B4/WcWwy0EH+Z11zKaHeIj1JdtuJeWVaDc9XBv3Akby4lni4wlsReAJH94nlX+ip+DG6cpuGOPEyAubZigPvMDX3k0GgtoUm1xK/88RELQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779897010; c=relaxed/simple;
	bh=XG6wLB4YMDu8fahSkyO54nh4TqPykCgqUMgWOumiOkk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rVgHT27ScYCM89n+wz4PQs133xidV2ECoNPhuHEK85reglyMwty7dJrxC2/LL+ksf6cI/ksEXwZGTnaFOyUBRN34hPL73bRJzdooOof7+Db3ovFULDtURJcZuHeMSjL9XxYzzfVL5N7Rc+Vndu/2chspLZsm4TOP3Mr4kdz5k10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auVGBUsL; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auVGBUsL"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-914bf787977so404081985a.2
        for <git@vger.kernel.org>; Wed, 27 May 2026 08:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779897008; x=1780501808; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcq6nQ2oB79OAoUL1MGNJJx0QuRuv7JzXBNuOnVNN0I=;
        b=auVGBUsLAKHUpjTk9Wqo3webkJWGsAAu/1VNlOUWUIWnK0HHP0aqv1YcA78cVuwbCf
         nMh0VXBRfjb8Tfbk5+fN9fRBf4qG1k361sym6Uoq2K/BWLvG7Y+ZswF/jwD5GivyH7cn
         gIEAl29NG4nzq8ApwC4VcTy1jc8tM1JRHrQz4gYWWm+PZyw0oP7SnodDSe96pn9li2+c
         GZ9vhLkxhjNsndMl0Xsl36pP7UG2l9eVzhtWlsue7wUikXcCZ52JoEGd3XKDa/3VdvYI
         LYsBjVS75HCN1Fqm/lM50Fn2N5fOg1FRNs5tu3lfdPhJIOQRnD5aH8DIafSeQT+M3MmX
         RQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779897008; x=1780501808;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zcq6nQ2oB79OAoUL1MGNJJx0QuRuv7JzXBNuOnVNN0I=;
        b=Vwj+K0O7xcvzauM5UXjAdpQlQk1xKBC6tLdTtU/LkvNhy9n+1UmdwA9w2tNGB8CFVr
         kgWlVy5khaGPFbMPPDu28DrIHoNtpIbGVGDa1nHYXINTEVbgYVejDAdErcek2ITXSgo1
         7jMJcGFUZ12QiUW4mjLLy6zTkj5S8D3y9jQLuR3qQ6l5CaF0HlRERnVITOS/92IgEhmt
         roXrJRuhWxzw5hF0zENh/kCVNtLgUU661QKBEJJGw9YaLZCVILzS1Pl5DehkYOZqoUZ+
         T9cxcEQ7eA/u896JTiL7tpZ+yUIbhwIjTrhlfcMfK4zjHiwdTKpcbCC5vKS7DowQ/M1B
         n4Mg==
X-Gm-Message-State: AOJu0YyxW2Kz93of9CPBwiXAN9eyclVkjPz3KDol4dHKIccu9s247xco
	BZr1Us2UnprMawi27sngBSmSG/2B+eDyMvUXmx7oi/QIZSUiBLbcrxv9O521Jg==
X-Gm-Gg: Acq92OGNl3H1QwsPl8SPuxqz/BWxj5kY0Z6sxFoB0vE4mI6vsuQchZGKFtpOhnCTKHe
	zgjl3c07x8seEmxPoZLSOliRvhRk+8Llk+6yrZSK/JfZucX6SyusFtNwYYxxIpYVlPQhqRgxQBr
	2g8ReYpNJmyGj/fTlEAVdyAwWrtigndrsVQjzHszjBOwiHw3H8WBdSFu2bUmeYZ7KiTH7meisXT
	bvyy2l0L91G1sXvED9YPISup0rfNphM+xUXfKY631YV8JNH7fqOnHuIKLkm+X3o6uGzLH02qIAB
	cXxDBhpn2RyTO59QqLGNeQLLRFlGAXvy/bRrI61iYEIB1aPxEhLyO/4sh+Ji0ywOYPhK6WxWuWi
	vdO7ieF9we4shIyJqVRrrr7cX2CPJUEbf/S1HODIMTBqx8AnsIz0CUeJTgsgBbQSD1zX8TY/NVq
	/zg94caj0WSrySupnf12gL0cNxx5I=
X-Received: by 2002:a05:620a:2794:b0:90f:fdb3:b752 with SMTP id af79cd13be357-914b4934c7cmr3380062285a.17.1779897007557;
        Wed, 27 May 2026 08:50:07 -0700 (PDT)
Received: from [127.0.0.1] ([135.119.239.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f86fffddsm494365785a.12.2026.05.27.08.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 08:50:07 -0700 (PDT)
Message-Id: <c0e78707f1e0fa97e96bcd6522648699f593590a.1779897003.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2127.git.1779897003.gitgitgadget@gmail.com>
References: <pull.2127.git.1779897003.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 27 May 2026 15:50:02 +0000
Subject: [PATCH 3/3] revision: use priority queue for non-limited streaming
 walks
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

The streaming (non-limited) walk in get_revision_1() inserts newly
discovered parent commits into a date-sorted queue via
commit_list_insert_by_date(), which scans the linked list to find the
insertion point -- O(w) per insert, where w is the width of the active
walk frontier.  Replace this with an O(log w) priority queue.

Add a commit_queue field to rev_info alongside the existing commits
linked list.  The two representations are mutually exclusive: setup
and external callers that need list access use the linked list, then
get_revision_1() lazily drains it into the priority queue on first
call.  Add a REV_WALK_NO_WALK enum value to distinguish the no_walk
case (which still uses the commit list) from the streaming case.

The conversion function rev_info_commit_list_to_queue() is public so
callers that know they will iterate can convert early.

Combined with the limit_list() priority queue change already in
master, this eliminates all O(w) sorted linked-list insertion from
the revision walk machinery.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 commit.c   | 13 -------------
 commit.h   |  2 --
 revision.c | 55 +++++++++++++++++++++++++++++-------------------------
 revision.h | 12 +++++++++++-
 4 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/commit.c b/commit.c
index e3e7352e69..5112c7b2af 100644
--- a/commit.c
+++ b/commit.c
@@ -729,19 +729,6 @@ void commit_list_free(struct commit_list *list)
 		pop_commit(&list);
 }
 
-struct commit_list * commit_list_insert_by_date(struct commit *item, struct commit_list **list)
-{
-	struct commit_list **pp = list;
-	struct commit_list *p;
-	while ((p = *pp) != NULL) {
-		if (p->item->date < item->date) {
-			break;
-		}
-		pp = &p->next;
-	}
-	return commit_list_insert(item, pp);
-}
-
 static int commit_list_compare_by_date(const struct commit_list *a,
 				       const struct commit_list *b)
 {
diff --git a/commit.h b/commit.h
index 58150045af..385492fbb1 100644
--- a/commit.h
+++ b/commit.h
@@ -191,8 +191,6 @@ int commit_list_contains(struct commit *item,
 struct commit_list **commit_list_append(struct commit *commit,
 					struct commit_list **next);
 unsigned commit_list_count(const struct commit_list *l);
-struct commit_list *commit_list_insert_by_date(struct commit *item,
-				    struct commit_list **list);
 void commit_list_sort_by_date(struct commit_list **list);
 
 /* Shallow copy of the input list */
diff --git a/revision.c b/revision.c
index 9d0fc696d0..4bb3b16e43 100644
--- a/revision.c
+++ b/revision.c
@@ -1116,7 +1116,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 }
 
 static int process_parents(struct rev_info *revs, struct commit *commit,
-			   struct commit_list **list, struct prio_queue *queue)
+			   struct prio_queue *queue)
 {
 	struct commit_list *parent = commit->parents;
 	unsigned pass_flags;
@@ -1158,8 +1158,6 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 			if (p->object.flags & SEEN)
 				continue;
 			p->object.flags |= (SEEN | NOT_USER_GIVEN);
-			if (list)
-				commit_list_insert_by_date(p, list);
 			if (queue)
 				prio_queue_put(queue, p);
 			if (revs->exclude_first_parent_only)
@@ -1207,8 +1205,6 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 		p->object.flags |= pass_flags | CHILD_VISITED;
 		if (!(p->object.flags & SEEN)) {
 			p->object.flags |= (SEEN | NOT_USER_GIVEN);
-			if (list)
-				commit_list_insert_by_date(p, list);
 			if (queue)
 				prio_queue_put(queue, p);
 		}
@@ -1470,7 +1466,7 @@ static int limit_list(struct rev_info *revs)
 
 		if (revs->max_age != -1 && (commit->date < revs->max_age))
 			obj->flags |= UNINTERESTING;
-		if (process_parents(revs, commit, NULL, &queue) < 0) {
+		if (process_parents(revs, commit, &queue) < 0) {
 			clear_prio_queue(&queue);
 			return -1;
 		}
@@ -3257,6 +3253,7 @@ static void free_void_commit_list(void *list)
 void release_revisions(struct rev_info *revs)
 {
 	commit_list_free(revs->commits);
+	clear_prio_queue(&revs->commit_queue);
 	commit_list_free(revs->ancestry_path_bottoms);
 	release_display_notes(&revs->notes_opt);
 	object_array_clear(&revs->pending);
@@ -3726,7 +3723,7 @@ static void explore_walk_step(struct rev_info *revs)
 	if (revs->max_age != -1 && (c->date < revs->max_age))
 		c->object.flags |= UNINTERESTING;
 
-	if (process_parents(revs, c, NULL, NULL) < 0)
+	if (process_parents(revs, c, NULL) < 0)
 		return;
 
 	if (c->object.flags & UNINTERESTING)
@@ -3902,7 +3899,7 @@ static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
 {
 	struct commit_list *p;
 	struct topo_walk_info *info = revs->topo_walk_info;
-	if (process_parents(revs, commit, NULL, NULL) < 0) {
+	if (process_parents(revs, commit, NULL) < 0) {
 		if (!revs->ignore_missing_links)
 			die("Failed to traverse parents of commit %s",
 			    oid_to_hex(&commit->object.oid));
@@ -3938,6 +3935,13 @@ static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
 	}
 }
 
+void rev_info_commit_list_to_queue(struct rev_info *revs)
+{
+	while (revs->commits)
+		prio_queue_put(&revs->commit_queue, pop_commit(&revs->commits));
+}
+
+
 int prepare_revision_walk(struct rev_info *revs)
 {
 	int i;
@@ -4006,7 +4010,7 @@ static enum rewrite_result rewrite_one_1(struct rev_info *revs,
 	for (;;) {
 		struct commit *p = *pp;
 		if (!revs->limited)
-			if (process_parents(revs, p, NULL, queue) < 0)
+			if (process_parents(revs, p, queue) < 0)
 				return rewrite_one_error;
 		if (p->object.flags & UNINTERESTING)
 			return rewrite_one_ok;
@@ -4020,27 +4024,18 @@ static enum rewrite_result rewrite_one_1(struct rev_info *revs,
 	}
 }
 
-static void merge_queue_into_list(struct prio_queue *q, struct commit_list **list)
+static void merge_queue_into_prio_queue(struct prio_queue *from,
+					struct prio_queue *to)
 {
-	while (q->nr) {
-		struct commit *item = prio_queue_peek(q);
-		struct commit_list *p = *list;
-
-		if (p && p->item->date >= item->date)
-			list = &p->next;
-		else {
-			p = commit_list_insert(item, list);
-			list = &p->next; /* skip newly added item */
-			prio_queue_get(q); /* pop item */
-		}
-	}
+	while (from->nr)
+		prio_queue_put(to, prio_queue_get(from));
 }
 
 static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp)
 {
 	struct prio_queue queue = { compare_commits_by_commit_date };
 	enum rewrite_result ret = rewrite_one_1(revs, pp, &queue);
-	merge_queue_into_list(&queue, &revs->commits);
+	merge_queue_into_prio_queue(&queue, &revs->commit_queue);
 	clear_prio_queue(&queue);
 	return ret;
 }
@@ -4331,6 +4326,7 @@ enum rev_walk_mode {
 	REV_WALK_REFLOG,
 	REV_WALK_TOPO,
 	REV_WALK_LIMITED,
+	REV_WALK_NO_WALK,
 	REV_WALK_STREAMING,
 };
 
@@ -4342,6 +4338,8 @@ static enum rev_walk_mode get_walk_mode(struct rev_info *revs)
 		return REV_WALK_TOPO;
 	if (revs->limited)
 		return REV_WALK_LIMITED;
+	if (revs->no_walk)
+		return REV_WALK_NO_WALK;
 	return REV_WALK_STREAMING;
 }
 
@@ -4349,6 +4347,9 @@ static struct commit *get_revision_1(struct rev_info *revs)
 {
 	enum rev_walk_mode mode = get_walk_mode(revs);
 
+	if (mode == REV_WALK_STREAMING && revs->commits)
+		rev_info_commit_list_to_queue(revs);
+
 	while (1) {
 		struct commit *commit;
 
@@ -4360,9 +4361,12 @@ static struct commit *get_revision_1(struct rev_info *revs)
 			commit = next_topo_commit(revs);
 			break;
 		case REV_WALK_LIMITED:
-		case REV_WALK_STREAMING:
+		case REV_WALK_NO_WALK:
 			commit = pop_commit(&revs->commits);
 			break;
+		case REV_WALK_STREAMING:
+			commit = prio_queue_get(&revs->commit_queue);
+			break;
 		}
 
 		if (!commit)
@@ -4390,12 +4394,13 @@ static struct commit *get_revision_1(struct rev_info *revs)
 			break;
 		case REV_WALK_STREAMING:
 			if (process_parents(revs, commit,
-					    &revs->commits, NULL) < 0) {
+					    &revs->commit_queue) < 0) {
 				if (!revs->ignore_missing_links)
 					die("Failed to traverse parents of commit %s",
 					    oid_to_hex(&commit->object.oid));
 			}
 			break;
+		case REV_WALK_NO_WALK:
 		case REV_WALK_LIMITED:
 			break;
 		}
diff --git a/revision.h b/revision.h
index 584f1338b5..04982a3d47 100644
--- a/revision.h
+++ b/revision.h
@@ -12,6 +12,7 @@
 #include "decorate.h"
 #include "ident.h"
 #include "list-objects-filter-options.h"
+#include "prio-queue.h"
 #include "strvec.h"
 
 /**
@@ -122,8 +123,14 @@ struct oidset;
 struct topo_walk_info;
 
 struct rev_info {
-	/* Starting list */
+	/*
+	 * Work queue of commits, stored as either a linked list or a
+	 * priority queue, but never both at the same time.
+	 * rev_info_commit_list_to_queue() converts list to queue.
+	 */
 	struct commit_list *commits;
+	struct prio_queue commit_queue;
+
 	struct object_array pending;
 	struct repository *repo;
 
@@ -400,6 +407,7 @@ struct rev_info {
  * uninitialized.
  */
 #define REV_INFO_INIT { \
+	.commit_queue = { .compare = compare_commits_by_commit_date }, \
 	.abbrev = DEFAULT_ABBREV, \
 	.simplify_history = 1, \
 	.pruning.flags.recursive = 1, \
@@ -478,6 +486,8 @@ void reset_revision_walk(void);
  */
 int prepare_revision_walk(struct rev_info *revs);
 
+/* Drain the commits linked list into the priority queue. */
+void rev_info_commit_list_to_queue(struct rev_info *revs);
 /**
  * Takes a pointer to a `rev_info` structure and iterates over it, returning a
  * `struct commit *` each time you call it. The end of the revision list is
-- 
gitgitgadget
