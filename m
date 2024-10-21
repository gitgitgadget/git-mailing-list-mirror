Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467AD1E767D
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504701; cv=none; b=F/lb2lHMGczjs+aKt5AFrbYMDIlUxXc5v4/Kq3nzAbzntnkH2qSGPJiyyOivprs/d39qgreMsXzJkxqTUEWwLG4U2XlyM8nXk/7dXk3z6xsAoi85ltrHRI/Xr2qbN8/wo+L0K8ZQPXFGp+uVbp5QKmcHcEHuMktGLbpqQt+G9cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504701; c=relaxed/simple;
	bh=iEXb1i80hXTriYJBU1CPMsLk+70WIQAOZrDdxArRBvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7c38/I8ggDo7xp5vVQvLALCSrrC5+s98OuraE4w6yCbEka9MisTAbNfWBM/stKwyXRohn2RRCprl2RgxlU+dN3UKp42dUcHMBDrXwtM3k8DxBwF6kVOeVTzYEuymtrMA/l1w0xqYnyy9FHlpucMNhCbOSd2OZJctUfYDkgwCIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRzdj1vi; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRzdj1vi"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a1b71d7ffso686821566b.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 02:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729504697; x=1730109497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pv3c4hZ8ZiDnAWqzt6ufoyHv4NvBi3U/UoTGVmnspoo=;
        b=PRzdj1viB95hdM4tWXIbEIb/gcAbE5TpqnwiQmr6LPO16Slct+yVyP78LrX72R6wJ6
         JqCYc+CYiby5ij6fIlRPHxcck8qH+o/wfGH3mojC8vTGBO5Lelpg/oVAD3mvbDFPtDO6
         RRBL+JQathh6dazUb1Y/3xtOGmrzsSCMHto+c4Ozbz0X27zBMYGo6TiHGI+/pux1gtk+
         LBUTs1HTal5gSLMdSw8aZvaP1xlrU/ojdXAFAHjyvYXMacyqqecaj8eZNux3qDzZjWW4
         ZhfWk/nWX2bPW2F4wOjNX7ndjzlM0aSJiVfn99PMxNocKvuZ/Dp6obWB09xuFea34gDj
         RR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504697; x=1730109497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pv3c4hZ8ZiDnAWqzt6ufoyHv4NvBi3U/UoTGVmnspoo=;
        b=FyGqiPGFuQqRbvNmIEVCvXraNzjUO+B9mTEJEvJdyxC3de14okbAN+hlSkeT+SlTOc
         /bZ4aOhFdLwwCIeBZ/NubM8kzmWUdT63RLCRtSEPCXfTTrGBoIO1pAHPNtQaO/dyY66j
         B76Bm3pNq2/UFOEekZb0OAMy4926PldIj6G8/Db04uOt3t3hoTp1Ia32PWbgUsigE+bm
         kZpFPq7q8Ibw4wdksuPa0zmYx1eCLf65GC/DV1TAui65WbEWcIIFRaJq8IajfmVe8rNC
         gX5nxbgzV9UlCpCWD8v+Qmk3Bx9zDZMf42hPf4Pel+SBU70UNW7bfAIvBU0WjzJrfYPX
         aOpA==
X-Gm-Message-State: AOJu0Yx3BPvM++JLVbe3Xffr8FcU2V9+hg49b4Q4BcjQ3lX3XFdjv1ei
	Qb9o33wJ4OC+ZBpe1AzFwT43gfVqvIJkXXNX882/eLhF/n1wMbVSjkMGQxPW
X-Google-Smtp-Source: AGHT+IFYTOJv+htNnQiam0U9itcEeHnYczzXmGNHK09mpEsoM03Eipv1RKGmCsApwb3RuvkL9xBCcw==
X-Received: by 2002:a17:907:7f8c:b0:a9a:24a2:180b with SMTP id a640c23a62f3a-a9a69cda11emr1002735566b.57.1729504697228;
        Mon, 21 Oct 2024 02:58:17 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d631dsm187122266b.17.2024.10.21.02.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:58:16 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH 14/20] packfile: pass down repository to `is_promisor_object`
Date: Mon, 21 Oct 2024 11:57:57 +0200
Message-ID: <355db54690d157216cc9f8e2c7d63e46c2812523.1729504641.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729504640.git.karthik.188@gmail.com>
References: <cover.1729504640.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function `is_promisor_object` currently relies on the global
variable `the_repository`. To eliminate global variable usage in
`packfile.c`, we should progressively shift the dependency on
the_repository to higher layers. Let's remove its usage from this
function and any related ones.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fsck.c         | 10 +++++-----
 builtin/pack-objects.c |  3 ++-
 builtin/rev-list.c     |  2 +-
 fsck.c                 |  2 +-
 list-objects.c         |  4 ++--
 packfile.c             |  6 +++---
 packfile.h             |  2 +-
 promisor-remote.c      |  2 +-
 revision.c             |  6 +++---
 tag.c                  |  2 +-
 10 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index ccf6a8eab2..9c4e0622b5 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -150,7 +150,7 @@ static int mark_object(struct object *obj, enum object_type type,
 		return 0;
 	obj->flags |= REACHABLE;
 
-	if (is_promisor_object(&obj->oid))
+	if (is_promisor_object(the_repository, &obj->oid))
 		/*
 		 * Further recursion does not need to be performed on this
 		 * object since it is a promisor object (so it does not need to
@@ -270,7 +270,7 @@ static void check_reachable_object(struct object *obj)
 	 * do a full fsck
 	 */
 	if (!(obj->flags & HAS_OBJ)) {
-		if (is_promisor_object(&obj->oid))
+		if (is_promisor_object(the_repository, &obj->oid))
 			return;
 		if (has_object_pack(the_repository, &obj->oid))
 			return; /* it is in pack - forget about it */
@@ -491,7 +491,7 @@ static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
 						     refname, timestamp);
 			obj->flags |= USED;
 			mark_object_reachable(obj);
-		} else if (!is_promisor_object(oid)) {
+		} else if (!is_promisor_object(the_repository, oid)) {
 			error(_("%s: invalid reflog entry %s"),
 			      refname, oid_to_hex(oid));
 			errors_found |= ERROR_REACHABLE;
@@ -534,7 +534,7 @@ static int fsck_handle_ref(const char *refname, const char *referent UNUSED, con
 
 	obj = parse_object(the_repository, oid);
 	if (!obj) {
-		if (is_promisor_object(oid)) {
+		if (is_promisor_object(the_repository, oid)) {
 			/*
 			 * Increment default_refs anyway, because this is a
 			 * valid ref.
@@ -1017,7 +1017,7 @@ int cmd_fsck(int argc,
 							   &oid);
 
 			if (!obj || !(obj->flags & HAS_OBJ)) {
-				if (is_promisor_object(&oid))
+				if (is_promisor_object(the_repository, &oid))
 					continue;
 				error(_("%s: object missing"), oid_to_hex(&oid));
 				errors_found |= ERROR_OBJECT;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4b91dc0add..16e7f5d4ec 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3859,7 +3859,8 @@ static void show_object__ma_allow_promisor(struct object *obj, const char *name,
 	 * Quietly ignore EXPECTED missing objects.  This avoids problems with
 	 * staging them now and getting an odd error later.
 	 */
-	if (!has_object(the_repository, &obj->oid, 0) && is_promisor_object(&obj->oid))
+	if (!has_object(the_repository, &obj->oid, 0) &&
+	    is_promisor_object(the_repository, &obj->oid))
 		return;
 
 	show_object(obj, name, data);
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index f62bcbf2b1..43c42621e3 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -121,7 +121,7 @@ static inline void finish_object__ma(struct object *obj)
 		return;
 
 	case MA_ALLOW_PROMISOR:
-		if (is_promisor_object(&obj->oid))
+		if (is_promisor_object(the_repository, &obj->oid))
 			return;
 		die("unexpected missing %s object '%s'",
 		    type_name(obj->type), oid_to_hex(&obj->oid));
diff --git a/fsck.c b/fsck.c
index 3756f52459..87ce999a49 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1295,7 +1295,7 @@ static int fsck_blobs(struct oidset *blobs_found, struct oidset *blobs_done,
 
 		buf = repo_read_object_file(the_repository, oid, &type, &size);
 		if (!buf) {
-			if (is_promisor_object(oid))
+			if (is_promisor_object(the_repository, oid))
 				continue;
 			ret |= report(options,
 				      oid, OBJ_BLOB, msg_missing,
diff --git a/list-objects.c b/list-objects.c
index 31236a8dc9..51c8c380d3 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -75,7 +75,7 @@ static void process_blob(struct traversal_context *ctx,
 	 */
 	if (ctx->revs->exclude_promisor_objects &&
 	    !repo_has_object_file(the_repository, &obj->oid) &&
-	    is_promisor_object(&obj->oid))
+	    is_promisor_object(the_repository, &obj->oid))
 		return;
 
 	pathlen = path->len;
@@ -180,7 +180,7 @@ static void process_tree(struct traversal_context *ctx,
 		 * an incomplete list of missing objects.
 		 */
 		if (revs->exclude_promisor_objects &&
-		    is_promisor_object(&obj->oid))
+		    is_promisor_object(the_repository, &obj->oid))
 			return;
 
 		if (!revs->do_not_die_on_missing_objects)
diff --git a/packfile.c b/packfile.c
index aea8e9f429..1867c2d844 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2292,14 +2292,14 @@ static int add_promisor_object(const struct object_id *oid,
 	return 0;
 }
 
-int is_promisor_object(const struct object_id *oid)
+int is_promisor_object(struct repository *repo, const struct object_id *oid)
 {
 	static struct oidset promisor_objects;
 	static int promisor_objects_prepared;
 
 	if (!promisor_objects_prepared) {
-		if (repo_has_promisor_remote(the_repository)) {
-			for_each_packed_object(the_repository,
+		if (repo_has_promisor_remote(repo)) {
+			for_each_packed_object(repo,
 					       add_promisor_object,
 					       &promisor_objects,
 					       FOR_EACH_OBJECT_PROMISOR_ONLY |
diff --git a/packfile.h b/packfile.h
index ec4aff63b4..afec4bbd74 100644
--- a/packfile.h
+++ b/packfile.h
@@ -210,7 +210,7 @@ int has_pack_index(struct repository *repo, const unsigned char *sha1);
  * Return 1 if an object in a promisor packfile is or refers to the given
  * object, 0 otherwise.
  */
-int is_promisor_object(const struct object_id *oid);
+int is_promisor_object(struct repository *repo, const struct object_id *oid);
 
 /*
  * Expose a function for fuzz testing.
diff --git a/promisor-remote.c b/promisor-remote.c
index 9345ae3db2..c714f4f007 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -283,7 +283,7 @@ void promisor_remote_get_direct(struct repository *repo,
 	}
 
 	for (i = 0; i < remaining_nr; i++) {
-		if (is_promisor_object(&remaining_oids[i]))
+		if (is_promisor_object(repo, &remaining_oids[i]))
 			die(_("could not fetch %s from promisor remote"),
 			    oid_to_hex(&remaining_oids[i]));
 	}
diff --git a/revision.c b/revision.c
index d7913d7608..df1037dcaa 100644
--- a/revision.c
+++ b/revision.c
@@ -390,7 +390,7 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
 	if (!object) {
 		if (revs->ignore_missing)
 			return NULL;
-		if (revs->exclude_promisor_objects && is_promisor_object(oid))
+		if (revs->exclude_promisor_objects && is_promisor_object(revs->repo, oid))
 			return NULL;
 		if (revs->do_not_die_on_missing_objects) {
 			oidset_insert(&revs->missing_commits, oid);
@@ -432,7 +432,7 @@ static struct commit *handle_commit(struct rev_info *revs,
 			if (revs->ignore_missing_links || (flags & UNINTERESTING))
 				return NULL;
 			if (revs->exclude_promisor_objects &&
-			    is_promisor_object(&tag->tagged->oid))
+			    is_promisor_object(revs->repo, &tag->tagged->oid))
 				return NULL;
 			if (revs->do_not_die_on_missing_objects && oid) {
 				oidset_insert(&revs->missing_commits, oid);
@@ -1211,7 +1211,7 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 			     revs->do_not_die_on_missing_objects;
 		if (repo_parse_commit_gently(revs->repo, p, gently) < 0) {
 			if (revs->exclude_promisor_objects &&
-			    is_promisor_object(&p->object.oid)) {
+			    is_promisor_object(revs->repo, &p->object.oid)) {
 				if (revs->first_parent_only)
 					break;
 				continue;
diff --git a/tag.c b/tag.c
index d24170e340..beef9571b5 100644
--- a/tag.c
+++ b/tag.c
@@ -84,7 +84,7 @@ struct object *deref_tag(struct repository *r, struct object *o, const char *war
 			o = NULL;
 		}
 	if (!o && warn) {
-		if (last_oid && is_promisor_object(last_oid))
+		if (last_oid && is_promisor_object(r, last_oid))
 			return NULL;
 		if (!warnlen)
 			warnlen = strlen(warn);
-- 
2.47.0

