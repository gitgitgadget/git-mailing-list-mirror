Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0BED1F404
	for <e@80x24.org>; Sat, 15 Sep 2018 16:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeIOVih (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 17:38:37 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34320 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbeIOVig (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 17:38:36 -0400
Received: by mail-lf1-f66.google.com with SMTP id c29-v6so10284663lfj.1
        for <git@vger.kernel.org>; Sat, 15 Sep 2018 09:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gcbdnny+WnPsiMNB9jZq4tqjHE7OfGIzPvFq1iIkP18=;
        b=aLQB8pm0XNyXV5jc6SWdeXxvP4xZJRR/JPZFEK2j9KetHVC6OMJvBmAT1fsudC1ByC
         MStKIXw6YPg22QBm0rkG7EUUqjvkMO7Ug+e7S6zDVJFvlV65wD94ZANE4NNy3e9CsJrX
         BgMpttMpXCJ601qjJNhM0DOz0MQfurCmMHI1ohvv5hb9JL+1CoT3vI3oODw7zWjBsRmO
         x0SHyQG3XWptRMCYmJI/r/zyUCx7MtYxUaq1iKdqW/OrpWL5M7CDWoptGejzLrVPAVon
         Pe6/M2527pjhhbkN+QgVFlx/W3Ng+qANjx0/LV288pdcTWJ/bkF9oDfgJmrmFWhKJMTp
         N0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gcbdnny+WnPsiMNB9jZq4tqjHE7OfGIzPvFq1iIkP18=;
        b=lecZ4/dnoPvvmvkMfoM/phHUVQ6Jb3z/j+VoVg46okaL7nz0ptOetGyuFp5vLxEAAv
         9A1drneUUBFmAKubOM4mGl5+zRGokXMxlZAoaPn4VZR1EuJH9BT6R2/+4IUXxxBsl3jE
         W1DY72g6kExDhuld0hpBD+GGQhGDW4XX7I7pjpz0mGXg23x+eM27P5sfmT+Gd5a+gA2w
         1+RmC80bhZXz9T/PXODKq6m/i6pRboWjbG2B0IAf38C30tf0QeBTZ/WOKo/qwA1R5wpM
         AoejPnyJIINJn6tnmP83TgusuwfP0EPYqrwRxO40b5gQTrmyLC87+IdhreK79QAxi4z4
         xxNg==
X-Gm-Message-State: APzg51A5mdcPxwrVxiXNUeZzbCxyu0fNbaZlfoVkoVoMlPSWJhuw+5vc
        LDDkXFt72pGc3mfxX8+arCqZTsqF
X-Google-Smtp-Source: ANB0VdYRh9ArEQx8taaIkfZtkww66z4pPyB7+LP2JPaozUMbbepedL1fQaM4+9RxOscbZQVF6wVl5w==
X-Received: by 2002:a19:8f8c:: with SMTP id s12-v6mr11772993lfk.83.1537028343149;
        Sat, 15 Sep 2018 09:19:03 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i2-v6sm1934852lfa.78.2018.09.15.09.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 09:19:02 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 23/23] revision.c: reduce implicit dependency the_repository
Date:   Sat, 15 Sep 2018 18:17:59 +0200
Message-Id: <20180915161759.8272-24-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180915161759.8272-1-pclouds@gmail.com>
References: <20180909085418.31531-1-pclouds@gmail.com>
 <20180915161759.8272-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 list-objects.c |  8 +++++---
 revision.c     | 44 +++++++++++++++++++++++---------------------
 revision.h     |  2 +-
 3 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index c99c47ac18..0c2989d5ca 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -196,7 +196,7 @@ static void mark_edge_parents_uninteresting(struct commit *commit,
 		struct commit *parent = parents->item;
 		if (!(parent->object.flags & UNINTERESTING))
 			continue;
-		mark_tree_uninteresting(get_commit_tree(parent));
+		mark_tree_uninteresting(revs->repo, get_commit_tree(parent));
 		if (revs->edge_hint && !(parent->object.flags & SHOWN)) {
 			parent->object.flags |= SHOWN;
 			show_edge(parent);
@@ -213,7 +213,8 @@ void mark_edges_uninteresting(struct rev_info *revs, show_edge_fn show_edge)
 		struct commit *commit = list->item;
 
 		if (commit->object.flags & UNINTERESTING) {
-			mark_tree_uninteresting(get_commit_tree(commit));
+			mark_tree_uninteresting(revs->repo,
+						get_commit_tree(commit));
 			if (revs->edge_hint_aggressive && !(commit->object.flags & SHOWN)) {
 				commit->object.flags |= SHOWN;
 				show_edge(commit);
@@ -228,7 +229,8 @@ void mark_edges_uninteresting(struct rev_info *revs, show_edge_fn show_edge)
 			struct commit *commit = (struct commit *)obj;
 			if (obj->type != OBJ_COMMIT || !(obj->flags & UNINTERESTING))
 				continue;
-			mark_tree_uninteresting(get_commit_tree(commit));
+			mark_tree_uninteresting(revs->repo,
+						get_commit_tree(commit));
 			if (!(obj->flags & SHOWN)) {
 				obj->flags |= SHOWN;
 				show_edge(commit);
diff --git a/revision.c b/revision.c
index f8a801d5f6..28366eaccf 100644
--- a/revision.c
+++ b/revision.c
@@ -51,7 +51,8 @@ static void mark_blob_uninteresting(struct blob *blob)
 	blob->object.flags |= UNINTERESTING;
 }
 
-static void mark_tree_contents_uninteresting(struct tree *tree)
+static void mark_tree_contents_uninteresting(struct repository *r,
+					     struct tree *tree)
 {
 	struct tree_desc desc;
 	struct name_entry entry;
@@ -63,10 +64,10 @@ static void mark_tree_contents_uninteresting(struct tree *tree)
 	while (tree_entry(&desc, &entry)) {
 		switch (object_type(entry.mode)) {
 		case OBJ_TREE:
-			mark_tree_uninteresting(lookup_tree(the_repository, entry.oid));
+			mark_tree_uninteresting(r, lookup_tree(r, entry.oid));
 			break;
 		case OBJ_BLOB:
-			mark_blob_uninteresting(lookup_blob(the_repository, entry.oid));
+			mark_blob_uninteresting(lookup_blob(r, entry.oid));
 			break;
 		default:
 			/* Subproject commit - not in this repository */
@@ -81,7 +82,7 @@ static void mark_tree_contents_uninteresting(struct tree *tree)
 	free_tree_buffer(tree);
 }
 
-void mark_tree_uninteresting(struct tree *tree)
+void mark_tree_uninteresting(struct repository *r, struct tree *tree)
 {
 	struct object *obj;
 
@@ -92,7 +93,7 @@ void mark_tree_uninteresting(struct tree *tree)
 	if (obj->flags & UNINTERESTING)
 		return;
 	obj->flags |= UNINTERESTING;
-	mark_tree_contents_uninteresting(tree);
+	mark_tree_contents_uninteresting(r, tree);
 }
 
 struct commit_stack {
@@ -198,7 +199,7 @@ void add_head_to_pending(struct rev_info *revs)
 	struct object *obj;
 	if (get_oid("HEAD", &oid))
 		return;
-	obj = parse_object(the_repository, &oid);
+	obj = parse_object(revs->repo, &oid);
 	if (!obj)
 		return;
 	add_pending_object(revs, obj, "HEAD");
@@ -210,7 +211,7 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
 {
 	struct object *object;
 
-	object = parse_object(the_repository, oid);
+	object = parse_object(revs->repo, oid);
 	if (!object) {
 		if (revs->ignore_missing)
 			return object;
@@ -247,7 +248,7 @@ static struct commit *handle_commit(struct rev_info *revs,
 			add_pending_object(revs, object, tag->tag);
 		if (!tag->tagged)
 			die("bad tag");
-		object = parse_object(the_repository, &tag->tagged->oid);
+		object = parse_object(revs->repo, &tag->tagged->oid);
 		if (!object) {
 			if (revs->ignore_missing_links || (flags & UNINTERESTING))
 				return NULL;
@@ -297,7 +298,7 @@ static struct commit *handle_commit(struct rev_info *revs,
 		if (!revs->tree_objects)
 			return NULL;
 		if (flags & UNINTERESTING) {
-			mark_tree_contents_uninteresting(tree);
+			mark_tree_contents_uninteresting(revs->repo, tree);
 			return NULL;
 		}
 		add_pending_object_with_path(revs, object, name, mode, path);
@@ -1253,7 +1254,7 @@ static void handle_one_reflog_commit(struct object_id *oid, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
 	if (!is_null_oid(oid)) {
-		struct object *o = parse_object(the_repository, oid);
+		struct object *o = parse_object(cb->all_revs->repo, oid);
 		if (o) {
 			o->flags |= cb->all_flags;
 			/* ??? CMDLINEFLAGS ??? */
@@ -1312,7 +1313,7 @@ void add_reflogs_to_pending(struct rev_info *revs, unsigned flags)
 
 	cb.all_revs = revs;
 	cb.all_flags = flags;
-	cb.refs = get_main_ref_store(the_repository);
+	cb.refs = get_main_ref_store(revs->repo);
 	for_each_reflog(handle_one_reflog, &cb);
 
 	if (!revs->single_worktree)
@@ -1326,7 +1327,7 @@ static void add_cache_tree(struct cache_tree *it, struct rev_info *revs,
 	int i;
 
 	if (it->entry_count >= 0) {
-		struct tree *tree = lookup_tree(the_repository, &it->oid);
+		struct tree *tree = lookup_tree(revs->repo, &it->oid);
 		add_pending_object_with_path(revs, &tree->object, "",
 					     040000, path->buf);
 	}
@@ -1352,7 +1353,7 @@ static void do_add_index_objects_to_pending(struct rev_info *revs,
 		if (S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		blob = lookup_blob(the_repository, &ce->oid);
+		blob = lookup_blob(revs->repo, &ce->oid);
 		if (!blob)
 			die("unable to add index blob to traversal");
 		add_pending_object_with_path(revs, &blob->object, "",
@@ -1585,8 +1586,8 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
 		*dotdot = '\0';
 	}
 
-	a_obj = parse_object(the_repository, &a_oid);
-	b_obj = parse_object(the_repository, &b_oid);
+	a_obj = parse_object(revs->repo, &a_oid);
+	b_obj = parse_object(revs->repo, &b_oid);
 	if (!a_obj || !b_obj)
 		return dotdot_missing(arg, dotdot, revs, symmetric);
 
@@ -1599,8 +1600,8 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
 		struct commit *a, *b;
 		struct commit_list *exclude;
 
-		a = lookup_commit_reference(the_repository, &a_obj->oid);
-		b = lookup_commit_reference(the_repository, &b_obj->oid);
+		a = lookup_commit_reference(revs->repo, &a_obj->oid);
+		b = lookup_commit_reference(revs->repo, &b_obj->oid);
 		if (!a || !b)
 			return dotdot_missing(arg, dotdot, revs, symmetric);
 
@@ -2208,7 +2209,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 			BUG("--single-worktree cannot be used together with submodule");
 		refs = get_submodule_ref_store(submodule);
 	} else
-		refs = get_main_ref_store(the_repository);
+		refs = get_main_ref_store(revs->repo);
 
 	/*
 	 * NOTE!
@@ -2889,9 +2890,10 @@ void reset_revision_walk(void)
 static int mark_uninteresting(const struct object_id *oid,
 			      struct packed_git *pack,
 			      uint32_t pos,
-			      void *unused)
+			      void *cb)
 {
-	struct object *o = parse_object(the_repository, oid);
+	struct rev_info *revs = cb;
+	struct object *o = parse_object(revs->repo, oid);
 	o->flags |= UNINTERESTING | SEEN;
 	return 0;
 }
@@ -2924,7 +2926,7 @@ int prepare_revision_walk(struct rev_info *revs)
 		revs->treesame.name = "treesame";
 
 	if (revs->exclude_promisor_objects) {
-		for_each_packed_object(mark_uninteresting, NULL,
+		for_each_packed_object(mark_uninteresting, revs,
 				       FOR_EACH_OBJECT_PROMISOR_ONLY);
 	}
 
diff --git a/revision.h b/revision.h
index 01427c9eb4..7e62a65bad 100644
--- a/revision.h
+++ b/revision.h
@@ -280,7 +280,7 @@ void put_revision_mark(const struct rev_info *revs,
 		       const struct commit *commit);
 
 void mark_parents_uninteresting(struct commit *commit);
-void mark_tree_uninteresting(struct tree *tree);
+void mark_tree_uninteresting(struct repository *r, struct tree *tree);
 
 void show_object_with_name(FILE *, struct object *, const char *);
 
-- 
2.19.0.rc0.337.ge906d732e7

