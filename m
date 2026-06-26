Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEB478F2F
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 19:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782500561; cv=none; b=AEeRYkoNuqrGm/EGUPAeDcdZt1tHw9BI2r0CzfPm/DGfaU8ASBY+lsWz2DpE+EkT52kE5Uo3/2PEYxWJN5J+Cr63WjQDYSnY4A8GWc0Gvc1gKA2iYKz60nOziwpx3LVt3Wh4PxkenuE55piux4m/OGeiH4wKAwRlWjyAImtVhcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782500561; c=relaxed/simple;
	bh=aOEdQ8sPj1oyDx295xjzz2zQhCJuzt4E0uyd+jFb6E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddAY9lW6PGDTkQOo/iR8X8YMs/9DNJxom0z/OemB5AzoOT0G/oGmoQRIf/0rjv8xEftvfUImkBxFaqkXViawTJLc+7hquffjIO+5NZACAxbWJ65QIB5e/xF0AnONwg5pIuDWezzSgVZy06Gou3K0w35K9XqGbVKDMYI8fJioOJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=jgXdQ7vA; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="jgXdQ7vA"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-80cd342a796so1525367b3.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 12:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1782500559; x=1783105359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Uj954sF6AyNErRfWx+J4CZQ7B9lc70C34RbcLcLReI=;
        b=jgXdQ7vAki/5drH9gIvZk2x3G36z/EQaqyuLhovONjp9wQXmLbDBuh/AN31FXa62P0
         iBxrCg5MJscqyQlLa4GiGbTsD6dM2GKgLHMQoU1/AelGfEY4vn7Tt5DxmNZte+hgg/kt
         Zm6pXrq/XQkvzIK3X1hetqLgTRK+3UA04d0LqnMDeyrDrRNYPT78i0bSfpf78AxTcktH
         mSMtaSf1PTo7ggSpAit06WMrIr9vs7thboFhoZweKN/hUNcW3YTe3eEzHo8h840f7s91
         DbVBfbjJf243E7H4l/01ushDRrzSKmdHVa5RQkMgVySqfL/uCZ+wtDzxnxqUIm/mJ4tE
         oThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782500559; x=1783105359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Uj954sF6AyNErRfWx+J4CZQ7B9lc70C34RbcLcLReI=;
        b=GPN4meLUZ5o35u+mtC2CfLpX+f5vnFvpwgTY6vFH6hJHLJQLnF+n6B6n99M+UvMmJc
         Yiwy1k7wtRPsBwQQdZ+kyAcgkyDFeSWcuAI4Bx9jmpaQZ2EG7OgcDevuWNe4d3QqgRIJ
         zWqzqvhonG5hlAGozuT+etEhmFaplRFupduHpLd6HXtoDqgKb/W9aROTLzsz28Q6NLsX
         m4SukNGoHbwGfyximBdBewXNjxy3KY9gJA5lSfjdM5SRrpTKaQbqMERn7OH/JyVzzqnk
         RyPrMm4eX+ETjLKjyNTwVbSmer+mt00tW94ucAmcuqUp0R1vS20wlrR7qvh8wqKPlv9z
         E6CQ==
X-Gm-Message-State: AOJu0Yxrqi7/VdTVx0SOvyy4GT/EMS/L0Bfdy2w0GbU1TCkGqXlVxwzD
	BbLn/TipSuGi6jc/fZfk8eflo0jBT83CiOp475peXiqpxAs/gEKD4uiRmWsCcBf3pIiPy8BbcEo
	eceZd++M7XAOW
X-Gm-Gg: AfdE7cmF8SBxVBDJ8skVlVIsdvHvVo+mHw3f3GejLz+AxsCDuDpA5lTabRgzxxzj///
	p/Q+3xap9nZbUHAKp07WYjkL1XJ085CR0nHalnyWBMdBEFVRBUalttey4GMPZGKtvCJdAeb//FQ
	kMGupAeCRodM9ArRbdDwTYNMNodtK6YS0DVk4cJAzNlGge9OVp0z9d3ZJPtJs3h+T7esgx3qFqN
	WBhWwpI1ZYhyGjad0LcqeB6yOGCn5xVpX3xbN8d6Dt5MYjoGv4Gl51Y7AqZU8PmefG1zWjrPp4y
	sZaVWRQfgtt25mxpOYyvsod/uiyiMsPAonN/qNidzEl2y51WGVA48lNAKePsOE1lj9xBoEMMpYx
	xXRoo+NnRw4Hv7klAMD9yyeApr/VdLH3FzqeXwob+/GRB2z0nXG3pc5c5+9ojZHLKyAfm6fuSr4
	wCxLC38Rf154HAMhS7n2IC+H+y+kXio++azg6n43AGek92IxUGfM71BCkfN2RBKYpwjMvHmp5c1
	v8t3Z1+B/9LSCgzJYunkkLfGIwFgzZym9kv9NQjwzlB4kVuXI+/hzwCqrFFVRicLxpjsD0I1f2d
	S3GrDlrVclxEtiKU
X-Received: by 2002:a05:690c:4b12:b0:7d0:6155:480d with SMTP id 00721157ae682-80a678089dfmr79186987b3.5.1782500558628;
        Fri, 26 Jun 2026 12:02:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-802606a918bsm88722597b3.43.2026.06.26.12.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 12:02:38 -0700 (PDT)
Date: Fri, 26 Jun 2026 15:02:37 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [RFC PATCH 08/10] pack-objects: introduce
 '--stdin-packs=follow-reachable'
Message-ID: <e3d2e46443d0b32ce29215563dde04ebcf850679.1782500507.git.me@ttaylorr.com>
References: <cover.1782500507.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1782500507.git.me@ttaylorr.com>

Introduce a new '--stdin-packs=follow-reachable' mode. Like
'--stdin-packs=follow', this mode recognizes the '!' (excluded-open)
pack prefix and halts at '^' (excluded-closed) packs.

Unlike 'follow', which eagerly includes all objects from listed packs
and then walks reachability to rescue additional objects, the new
'follow-reachable' mode uses reference tips as its traversal starting
points and only includes objects that are both reachable AND belong to
an included pack (or are reachable from a commit or tag in one):

 - Objects in included packs: added to the output if reachable.

 - Objects reachable from included-pack commits but in unknown packs:
   added to the output (rescued).

 - Objects in excluded-open ('!') packs: not included, but the traversal
   continues through them.

 - Objects in excluded-closed ('^') packs: not included, and the
   traversal halts.

The implementation uses a two-phase approach:

 1. In the first phase, commits and tags in included packs (and loose,
    when --unpacked is given) are marked with a flag bit
    (IN_INCLUDED_PACK). A commit-only walk from ref tips then identifies
    which marked objects are reachable, halting at excluded-closed
    packs.

 2. In the second phase, every reachable marked object (from the
    previous step) becomes a tip for a full object traversal whose
    `show_object_pack_hint()` and `show_commit_pack_hint()` callbacks
    add discovered objects (obeying the usual constraints imposed by
    `want_object_in_pack()`).

When '--unpacked' is given, reachable loose objects are included in the
output while unreachable loose objects are left alone. This is achieved
by marking loose commits and tags with IN_INCLUDED_PACK during the first
phase, so the pre-walk discovers them naturally.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-pack-objects.adoc |  17 +++
 builtin/pack-objects.c              | 185 +++++++++++++++++++++++--
 t/t5331-pack-objects-stdin.sh       | 201 ++++++++++++++++++++++++++++
 3 files changed, 393 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index 8a27aa19fd3..d7b2e39e76c 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -113,6 +113,23 @@ This mode is useful, for example, to resurrect once-unreachable
 objects found in cruft packs to generate packs which are closed under
 reachability up to the boundary set by the excluded packs.
 +
+When `mode` is "follow-reachable", the same pack prefixes are recognized
+as in "follow" (`!` for excluded-open, `^` for excluded-closed). However,
+instead of including all objects from included packs, only objects that
+are reachable from reference tips AND belong to an included pack (or are
+reachable from a commit in one) are included. Objects in excluded-open
+packs are traversed but not included; objects in excluded-closed packs
+halt the traversal.
++
+This mode is designed for geometric repacking with cruft packs, where
+the output pack should contain only reachable objects so that unreachable
+ones can be collected separately.
++
+When `--unpacked` is given alongside `--stdin-packs=follow-reachable`,
+reachable loose objects are also included in the output pack, while
+unreachable loose objects are left alone. This includes both loose
+commits and annotated tag objects.
++
 Incompatible with `--revs`, or options that imply `--revs` (such as
 `--all`), with the exception of `--unpacked`, which is compatible.
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 29e43abb51e..5d96757b645 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -290,6 +290,7 @@ enum stdin_packs_mode {
 	STDIN_PACKS_MODE_NONE,
 	STDIN_PACKS_MODE_STANDARD,
 	STDIN_PACKS_MODE_FOLLOW,
+	STDIN_PACKS_MODE_FOLLOW_REACHABLE,
 };
 
 /**
@@ -3835,7 +3836,8 @@ static void show_object_pack_hint(struct object *object, const char *name,
 				  void *data)
 {
 	enum stdin_packs_mode mode = *(enum stdin_packs_mode *)data;
-	if (mode == STDIN_PACKS_MODE_FOLLOW) {
+	if (mode == STDIN_PACKS_MODE_FOLLOW ||
+	    mode == STDIN_PACKS_MODE_FOLLOW_REACHABLE) {
 		if (object->type == OBJ_BLOB &&
 		    !odb_has_object(the_repository->objects, &object->oid, 0))
 			return;
@@ -3866,7 +3868,8 @@ static void show_commit_pack_hint(struct commit *commit, void *data)
 {
 	enum stdin_packs_mode mode = *(enum stdin_packs_mode *)data;
 
-	if (mode == STDIN_PACKS_MODE_FOLLOW) {
+	if (mode == STDIN_PACKS_MODE_FOLLOW ||
+	    mode == STDIN_PACKS_MODE_FOLLOW_REACHABLE) {
 		show_object_pack_hint((struct object *)commit, "", data);
 		return;
 	}
@@ -3933,6 +3936,156 @@ static int stdin_packs_include_check(struct commit *commit, void *data)
 	return stdin_packs_include_check_obj((struct object *)commit, data);
 }
 
+/*
+ * Flag bit set on commits that belong to an included pack during
+ * '--stdin-packs=follow-reachable'. Used by the pre-walk to
+ * identify which reachable commits should be tips for the main
+ * object traversal.
+ */
+#define IN_INCLUDED_PACK (1u<<11)
+
+static int mark_included_pack_tip(const struct object_id *oid,
+				  struct packed_git *p,
+				  uint32_t pos,
+				  void *data)
+{
+	struct rev_info *main_revs = data;
+	off_t ofs = nth_packed_object_offset(p, pos);
+	enum object_type type;
+	struct object_info oi = OBJECT_INFO_INIT;
+	struct object *obj;
+
+	oi.typep = &type;
+	if (packed_object_info(p, ofs, &oi) < 0)
+		return 0;
+	if (type != OBJ_COMMIT && type != OBJ_TAG)
+		return 0;
+
+	obj = parse_object(the_repository, oid);
+	if (!obj)
+		return 0;
+
+	obj->flags |= IN_INCLUDED_PACK;
+
+	if (type == OBJ_TAG && main_revs)
+		add_pending_object(main_revs, obj, "");
+	return 0;
+}
+
+static int mark_loose_object_tip(const struct object_id *oid,
+				 struct object_info *oi UNUSED,
+				 void *data)
+{
+	struct rev_info *main_revs = data;
+	struct object *obj;
+	enum object_type type;
+
+	type = odb_read_object_info(the_repository->objects, oid, NULL);
+	if (type != OBJ_COMMIT && type != OBJ_TAG)
+		return 0;
+
+	obj = parse_object(the_repository, oid);
+	if (!obj)
+		return 0;
+
+	obj->flags |= IN_INCLUDED_PACK;
+
+	if (type == OBJ_TAG && main_revs)
+		add_pending_object(main_revs, obj, "");
+
+	return 0;
+}
+
+static int add_ref_to_pending(const struct reference *ref, void *cb_data)
+{
+	struct rev_info *revs = cb_data;
+	struct object *object;
+
+	object = parse_object(the_repository, ref->oid);
+	if (!object)
+		return 0;
+
+	add_pending_object(revs, object, "");
+	return 0;
+}
+
+static void stdin_packs_add_reachable_pack_entries(struct string_list *keys,
+						   struct rev_info *revs,
+						   int rev_list_unpacked)
+{
+	struct rev_info pre_walk;
+	struct commit *commit;
+	struct string_list_item *item;
+
+	/*
+	 * Phase 1: mark commits in included packs, then walk from
+	 * ref tips to discover which of them are reachable. The walk
+	 * halts at excluded-closed packs (via no_kept_objects) and
+	 * continues through excluded-open ones.
+	 *
+	 * Also set include_check on the outer revs so that phase 2
+	 * (the main object traversal) halts at closed packs.
+	 */
+	revs->include_check = stdin_packs_include_check;
+	revs->include_check_obj = stdin_packs_include_check_obj;
+
+	for_each_string_list_item(item, keys) {
+		struct stdin_pack_info *info = item->util;
+		if (info->kind & STDIN_PACK_INCLUDE)
+			for_each_object_in_pack(info->p,
+						mark_included_pack_tip,
+						revs,
+						ODB_FOR_EACH_OBJECT_PACK_ORDER);
+	}
+
+	if (rev_list_unpacked) {
+		/*
+		 * With '--stdin-packs=follow-reachable', specifying
+		 * '--unpacked' instructs pack-objects to pack any loose
+		 * objects which are reachable.
+		 *
+		 * Pretend as if all loose objects are in an included
+		 * pack in order to make them eligible for packing.
+		 */
+		struct odb_source *source = revs->repo->objects->sources;
+		for (; source; source = source->next) {
+			struct odb_source_files *files = odb_source_files_downcast(source);
+			struct odb_for_each_object_options opts = { 0 };
+			if (local)
+				opts.flags |= ODB_FOR_EACH_OBJECT_LOCAL_ONLY;
+
+			odb_source_for_each_object(&files->loose->base, NULL,
+						   mark_loose_object_tip,
+						   revs, &opts);
+		}
+	}
+
+	repo_init_revisions(the_repository, &pre_walk, NULL);
+	pre_walk.no_kept_objects = 1;
+	pre_walk.keep_pack_cache_flags |= KEPT_PACK_IN_CORE;
+	pre_walk.ignore_missing_links = 1;
+
+	refs_for_each_ref(get_main_ref_store(the_repository),
+			  add_ref_to_pending, &pre_walk);
+
+	if (prepare_revision_walk(&pre_walk))
+		die(_("revision walk setup failed"));
+
+	/*
+	 * Phase 2 tips: every reachable commit that is in an
+	 * included pack becomes a starting point for the main
+	 * object traversal.
+	 */
+	while ((commit = get_revision(&pre_walk)) != NULL) {
+		if (commit->object.flags & IN_INCLUDED_PACK)
+			add_pending_oid(revs, NULL,
+					&commit->object.oid, 0);
+	}
+
+	reset_revision_walk();
+	release_revisions(&pre_walk);
+}
+
 static void stdin_packs_add_all_pack_entries(struct string_list *keys,
 					     struct rev_info *revs)
 {
@@ -3962,7 +4115,9 @@ static void stdin_packs_add_all_pack_entries(struct string_list *keys,
 }
 
 static void stdin_packs_add_pack_entries(struct strmap *packs,
-					 struct rev_info *revs)
+					 struct rev_info *revs,
+					 enum stdin_packs_mode mode,
+					 int rev_list_unpacked)
 {
 	struct string_list keys = STRING_LIST_INIT_NODUP;
 	struct hashmap_iter iter;
@@ -3983,13 +4138,18 @@ static void stdin_packs_add_pack_entries(struct strmap *packs,
 	 */
 	QSORT(keys.items, keys.nr, pack_mtime_cmp);
 
-	stdin_packs_add_all_pack_entries(&keys, revs);
+	if (mode == STDIN_PACKS_MODE_FOLLOW_REACHABLE)
+		stdin_packs_add_reachable_pack_entries(&keys, revs,
+						       rev_list_unpacked);
+	else
+		stdin_packs_add_all_pack_entries(&keys, revs);
 
 	string_list_clear(&keys, 0);
 }
 
 static void stdin_packs_read_input(struct rev_info *revs,
-				   enum stdin_packs_mode mode)
+				   enum stdin_packs_mode mode,
+				   int rev_list_unpacked)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strmap packs = STRMAP_INIT;
@@ -4004,7 +4164,9 @@ static void stdin_packs_read_input(struct rev_info *revs,
 			continue;
 		else if (*key == '^')
 			kind = STDIN_PACK_EXCLUDE_CLOSED;
-		else if (*key == '!' && mode == STDIN_PACKS_MODE_FOLLOW)
+		else if (*key == '!' &&
+			 (mode == STDIN_PACKS_MODE_FOLLOW ||
+			  mode == STDIN_PACKS_MODE_FOLLOW_REACHABLE))
 			kind = STDIN_PACK_EXCLUDE_OPEN;
 
 		if (kind != STDIN_PACK_INCLUDE)
@@ -4069,7 +4231,7 @@ static void stdin_packs_read_input(struct rev_info *revs,
 		info->p = p;
 	}
 
-	stdin_packs_add_pack_entries(&packs, revs);
+	stdin_packs_add_pack_entries(&packs, revs, mode, rev_list_unpacked);
 
 	strbuf_release(&buf);
 	strmap_clear(&packs, 1);
@@ -4109,7 +4271,8 @@ static void read_stdin_packs(enum stdin_packs_mode mode, int rev_list_unpacked)
 
 	/* avoids adding objects in excluded packs */
 	ignore_packed_keep_in_core = 1;
-	if (mode == STDIN_PACKS_MODE_FOLLOW) {
+	if (mode == STDIN_PACKS_MODE_FOLLOW ||
+	    mode == STDIN_PACKS_MODE_FOLLOW_REACHABLE) {
 		/*
 		 * In '--stdin-packs=follow' mode, additionally ignore
 		 * objects in excluded-open packs to prevent them from
@@ -4117,8 +4280,8 @@ static void read_stdin_packs(enum stdin_packs_mode mode, int rev_list_unpacked)
 		 */
 		ignore_packed_keep_in_core_open = 1;
 	}
-	stdin_packs_read_input(&revs, mode);
-	if (rev_list_unpacked)
+	stdin_packs_read_input(&revs, mode, rev_list_unpacked);
+	if (rev_list_unpacked && mode != STDIN_PACKS_MODE_FOLLOW_REACHABLE)
 		add_unreachable_loose_objects(&revs);
 
 	if (prepare_revision_walk(&revs))
@@ -5027,6 +5190,8 @@ static int parse_stdin_packs_mode(const struct option *opt, const char *arg,
 		*mode = STDIN_PACKS_MODE_STANDARD;
 	else if (!strcmp(arg, "follow"))
 		*mode = STDIN_PACKS_MODE_FOLLOW;
+	else if (!strcmp(arg, "follow-reachable"))
+		*mode = STDIN_PACKS_MODE_FOLLOW_REACHABLE;
 	else
 		die(_("invalid value for '%s': '%s'"), opt->long_name, arg);
 
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
index c74b5861af3..443d855291a 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -520,4 +520,205 @@ test_expect_success '--stdin-packs with !-delimited pack without follow' '
 	)
 '
 
+test_expect_success '--stdin-packs=follow-reachable excludes unreachable objects' '
+	test_when_finished "rm -fr repo" &&
+
+	git init repo &&
+	(
+		cd repo &&
+		git config set maintenance.auto false &&
+
+		git branch -M main &&
+
+		# Create the following commit structure:
+		#
+		#   A <-- B <-- C     (main)
+		#         ^
+		#          \
+		#           U         (unreachable, no ref)
+		test_commit A &&
+		test_commit B &&
+		test_commit U &&
+		U_TIP="$(git rev-parse HEAD)" &&
+		git reset --hard HEAD^ &&
+		git tag -d U &&
+		git reflog expire --all --expire=all &&
+
+		test_commit C &&
+
+		A="$(echo A | git pack-objects --revs $packdir/pack)" &&
+		B="$(echo A..B | git pack-objects --revs $packdir/pack)" &&
+		C="$(echo B..C | git pack-objects --revs $packdir/pack)" &&
+		U="$(echo "$U_TIP" | git pack-objects $packdir/pack)" &&
+
+		git prune-packed &&
+
+		# Include packs A and C, exclude B as open (since B
+		# may not have closure), leave U as unknown.
+		#
+		# With follow-reachable:
+		#  - objects from A and C are included (reachable from
+		#    main, through excluded-open B, and in included
+		#    packs)
+		#  - objects from B are excluded (excluded-open)
+		#  - objects from U are NOT included (not reachable
+		#    from any ref, even though the pack exists)
+		P=$(git pack-objects --stdin-packs=follow-reachable \
+			$packdir/pack <<-EOF
+		pack-$A.pack
+		!pack-$B.pack
+		pack-$C.pack
+		EOF
+		) &&
+
+		objects_in_packs $A $C >expect &&
+		objects_in_packs $P >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--stdin-packs=follow-reachable with open-excluded packs' '
+	test_when_finished "rm -fr repo" &&
+
+	git init repo &&
+	(
+		cd repo &&
+		git config set maintenance.auto false &&
+
+		git branch -M main &&
+
+		# Create the following commit structure:
+		#
+		#   A <-- B <-- C <-- D    (main)
+		#
+		# Pack each commit separately, then use follow-reachable
+		# with B excluded-open and A excluded-closed. Since B is
+		# open, the traversal continues through it, but since A
+		# is closed, it halts there.
+		test_commit A &&
+		test_commit B &&
+		test_commit C &&
+		test_commit D &&
+
+		A="$(echo A | git pack-objects --revs $packdir/pack)" &&
+		B="$(echo A..B | git pack-objects --revs $packdir/pack)" &&
+		C="$(echo B..C | git pack-objects --revs $packdir/pack)" &&
+		D="$(echo C..D | git pack-objects --revs $packdir/pack)" &&
+
+		git prune-packed &&
+
+		# Include C and D, B excluded-open, A excluded-closed.
+		#
+		# The traversal starts at main (D), walks:
+		#  D (included) -> C (included) -> B (open, continue
+		#  but do not include) -> A (closed, halt).
+		#
+		# Objects from C and D are in the output (reachable,
+		# included). B.t is also rescued (reachable via
+		# C^{tree} or similar). A and its objects are NOT
+		# (behind the closed boundary).
+		P=$(git pack-objects --stdin-packs=follow-reachable \
+			$packdir/pack <<-EOF
+		pack-$C.pack
+		pack-$D.pack
+		!pack-$B.pack
+		^pack-$A.pack
+		EOF
+		) &&
+
+		objects_in_packs $C $D >expect &&
+		objects_in_packs $P >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--stdin-packs=follow-reachable with --unpacked and loose objects' '
+	test_when_finished "rm -fr repo" &&
+
+	git init repo &&
+	(
+		cd repo &&
+		git config set maintenance.auto false &&
+
+		git branch -M main &&
+
+		test_commit A &&
+		test_commit B &&
+
+		A="$(echo A | git pack-objects --revs $packdir/pack)" &&
+		B="$(echo A..B | git pack-objects --revs $packdir/pack)" &&
+
+		git prune-packed &&
+
+		# Create a reachable loose commit on top of B.
+		test_commit C &&
+
+		# Create an unreachable loose object.
+		unreachable="$(echo "unreachable" | git hash-object -w --stdin)" &&
+
+		# Include A and B, no excluded packs. With --unpacked,
+		# the reachable loose objects from C should be included
+		# in the output but the unreachable blob should not.
+		P=$(git pack-objects --stdin-packs=follow-reachable \
+			--unpacked $packdir/pack <<-EOF
+		pack-$A.pack
+		pack-$B.pack
+		EOF
+		) &&
+
+		# The output should contain objects from A, B, and C.
+		{
+			objects_in_packs $A $B &&
+			git rev-list --objects --no-object-names B..C
+		} >expect.raw &&
+		sort expect.raw >expect &&
+
+		objects_in_packs $P >actual &&
+
+		# The unreachable blob should NOT be in the output.
+		! grep $unreachable actual &&
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--stdin-packs=follow-reachable with --unpacked and loose annotated tag' '
+	test_when_finished "rm -fr repo" &&
+
+	git init repo &&
+	(
+		cd repo &&
+		git config set maintenance.auto false &&
+
+		git branch -M main &&
+
+		test_commit A &&
+
+		A="$(echo A | git pack-objects --revs $packdir/pack)" &&
+
+		git prune-packed &&
+
+		# Create a loose annotated tag pointing at A.
+		git tag -a -m "annotated" annotated-tag A &&
+		tag_oid="$(git rev-parse annotated-tag)" &&
+
+		P=$(git pack-objects --stdin-packs=follow-reachable \
+			--unpacked $packdir/pack <<-EOF
+		pack-$A.pack
+		EOF
+		) &&
+
+		# The output should contain objects from A plus the
+		# loose annotated tag object.
+		{
+			objects_in_packs $A &&
+			echo $tag_oid
+		} >expect.raw &&
+		sort expect.raw >expect &&
+
+		objects_in_packs $P >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.55.0.rc2.10.g29e31820dce

