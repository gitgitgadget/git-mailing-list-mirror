Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663741EA7C9
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 12:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126205; cv=none; b=IoQOAkVKQjBQH3W7Pp/2h95qBcnjVL9RttOL9FBVp6QYmaWFJFoe0NQ9J3o8S5sYcduvR7ocNQLlomSDDKfAezLUHWnI+MkWpeikuUqbOArdp9yI+6wKlAv25F0AuzZDpjlf3CksiYpjimhOq2w4wZEh2ORcHL3jh6il+ijrOaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126205; c=relaxed/simple;
	bh=Vq5F4RmEumjvKE0ID3Ng7KFzMCgowK4+Wij2BXllYnI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LvZXO8JK120+NmFI6YAdcH/I3NkzXgGTO/u8+w6EyT78czZBdt/PJF+328IBhBLD0IoDwcnjdH6q+m262NIy34JvwWQMXqedlfvhMsxgwvaxlzoXEXGG2XQk23cWDytVNDnYEiJaBE5KXq1HtUNUUEr4NXd1Rn4ZtPf1NAA4rKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+3PWlWz; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+3PWlWz"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b55ed86b9so12938045e9.0
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 05:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756126201; x=1756731001; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FyQIcATPbM+XyVKfKEiCSoerS/xJQAj9cFgCMxc5NU=;
        b=W+3PWlWzfGAnWM/KfEF1XKsBJyUoimRuTQGKBVSd6zwGL4S/MMUF07DUPc1vUczrLJ
         BRZI35XcR8ADPV5/ZnaNySJW/AjwrZ69lSlcKzHxpOpHUPi/bRjMyRZYFQTagw/R0SBY
         ytCjKcqyjNjPICLBGVRUhQJ/oMBCJd1bseNsr2Evgt+ZiqeUhhxNQGy4hxFdDQjy15Fg
         fFG0gYyEElgKmJkAW0diEU/itxCmfO/zfi7EGvix9YI9bQjEnP44vcksOQyDx4rMrK8H
         J85UKBwuLmobe1j1p+GZbXIAOLLNQ8uJj6IyC5jdEdADJP/wLEdXBEmhohc61NILt3xR
         CgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756126201; x=1756731001;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FyQIcATPbM+XyVKfKEiCSoerS/xJQAj9cFgCMxc5NU=;
        b=Qki+YZ9u1ow+QW5qyxtIKJV48mS1v0XooeKmsn4DakKVjLiALIxZKZ0lWZbaioW1VA
         Jhrk4FEMmnUpkn5Q8HPFwuwk0x5RFHPVDDgY5Pbf/22KwyxQyNsFsAPN72lR0YkovuJE
         6o42v2CnpaIoQm2OiNweTe6GZvkpaFmnZTYqjksoifDR0jM3xrOyYYeWMVmx7KJaYGOB
         k8DrEQAcjge9u6+9ikc/9YjNtBUT4l+j/lXuoW2Fsxr2H7hk3eXHlFnx5MGK4ZJ52jso
         Ktz1gh926ezEQV5PBRLBuaIGYBYUyD9Q04Q4GZd+d4XR0RgqlOjkM+dm/5wannpPavuQ
         HlSw==
X-Gm-Message-State: AOJu0Yx6ToeLHr6ketDrJwDltH4C1Vc0VKxjae+Pl5Lz9+5SkCyfN+ku
	87utRRpZ5xqlLqwVdkzg5sMJS20U/7TUypcgrjiZ1x98q8XWZU/P4Qw8/vQJGEnT
X-Gm-Gg: ASbGncunDXRsnQoS4nHgR398HjPI+ROWpx6UJq3rlDQ5UJgkDGnoBoeLygkAXo53UQX
	ShhwBA7r/reKo3JCQ74DDazbCwG9zhCEXY0Z39+Ot2OYpjFMWrnx2Tq6GMetSxRynRn592TPNL7
	R04ZY6eCfJAC8uDpUPH0ukpCsyaDFSFx/Q7wLpW4mIbRYDy/YEER2JtNHEjmGYtx+Gac2pImwSM
	VEuuQlMtxl44P6Ilq6hrAAgTfckIV/Ip+MfI9YdI5Dre6Tdypm9Y4J5lU+sZ+CNdWrjwjfxJ/R+
	9yAJ6nCxetmDaS9EQL/GFp7ibJx3wQaucyNwg68Le6JINRBw1gyg3E/ulfalwm3hgYVNUGkIzMh
	puXve2bV/2M/AuKsbBML6ZyE=
X-Google-Smtp-Source: AGHT+IFuQAKngrcfcaiN17GkhPRRDTxIHBbm3GE+H1qIF74D09mp9ASg4oMQLqmsHDQZXj4N+taxtQ==
X-Received: by 2002:a05:600c:3551:b0:459:d6a6:77c with SMTP id 5b1f17b1804b1-45b604654ebmr31327825e9.33.1756126201204;
        Mon, 25 Aug 2025 05:50:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4ba390sm11958730f8f.12.2025.08.25.05.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 05:50:00 -0700 (PDT)
Message-Id: <fc2c171f52d94022709bc86110711a3a9ae10a6a.1756126198.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1956.v2.git.1756126197.gitgitgadget@gmail.com>
References: <pull.1956.git.1755715196.gitgitgadget@gmail.com>
	<pull.1956.v2.git.1756126197.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 Aug 2025 12:49:57 +0000
Subject: [PATCH v2 2/2] path-walk: create initializer for path lists
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The previous change fixed a bug in 'git repack -adf --path-walk' that
was due to an update to how path lists are initialized and missing some
important cases when processing the pending objects.

This change takes the three critical places where path lists are
initialized and combines them into a static method. This simplifies the
callers somewhat while also helping to avoid a missed update in the
future.

The other places where a path list (struct type_and_oid_list) is
initialized is for the following "fixed" lists:

 * Tag objects.
 * Commit objects.
 * Root trees.
 * Tagged trees.
 * Tagged blobs.

These lists are created and consumed in different ways, with only the
root trees being passed into the logic that cares about the
"maybe_interesting" bit. It is appropriate to keep these uses separate.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 path-walk.c | 57 +++++++++++++++++++++++------------------------------
 1 file changed, 25 insertions(+), 32 deletions(-)

diff --git a/path-walk.c b/path-walk.c
index 1215ed398f4f..f1ceed99e94c 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -105,6 +105,24 @@ static void push_to_stack(struct path_walk_context *ctx,
 	prio_queue_put(&ctx->path_stack, xstrdup(path));
 }
 
+static void add_path_to_list(struct path_walk_context *ctx,
+			     const char *path,
+			     enum object_type type,
+			     struct object_id *oid,
+			     int interesting)
+{
+	struct type_and_oid_list *list = strmap_get(&ctx->paths_to_lists, path);
+
+	if (!list) {
+		CALLOC_ARRAY(list, 1);
+		list->type = type;
+		strmap_put(&ctx->paths_to_lists, path, list);
+	}
+
+	list->maybe_interesting |= interesting;
+	oid_array_append(&list->oids, oid);
+}
+
 static int add_tree_entries(struct path_walk_context *ctx,
 			    const char *base_path,
 			    struct object_id *oid)
@@ -129,7 +147,6 @@ static int add_tree_entries(struct path_walk_context *ctx,
 
 	init_tree_desc(&desc, &tree->object.oid, tree->buffer, tree->size);
 	while (tree_entry(&desc, &entry)) {
-		struct type_and_oid_list *list;
 		struct object *o;
 		/* Not actually true, but we will ignore submodules later. */
 		enum object_type type = S_ISDIR(entry.mode) ? OBJ_TREE : OBJ_BLOB;
@@ -190,17 +207,10 @@ static int add_tree_entries(struct path_walk_context *ctx,
 				continue;
 		}
 
-		if (!(list = strmap_get(&ctx->paths_to_lists, path.buf))) {
-			CALLOC_ARRAY(list, 1);
-			list->type = type;
-			strmap_put(&ctx->paths_to_lists, path.buf, list);
-		}
-		push_to_stack(ctx, path.buf);
-
-		if (!(o->flags & UNINTERESTING))
-			list->maybe_interesting = 1;
+		add_path_to_list(ctx, path.buf, type, &entry.oid,
+				 !(o->flags & UNINTERESTING));
 
-		oid_array_append(&list->oids, &entry.oid);
+		push_to_stack(ctx, path.buf);
 	}
 
 	free_tree_buffer(tree);
@@ -377,16 +387,9 @@ static int setup_pending_objects(struct path_walk_info *info,
 			if (!info->trees)
 				continue;
 			if (pending->path) {
-				struct type_and_oid_list *list;
 				char *path = *pending->path ? xstrfmt("%s/", pending->path)
 							    : xstrdup("");
-				if (!(list = strmap_get(&ctx->paths_to_lists, path))) {
-					CALLOC_ARRAY(list, 1);
-					list->type = OBJ_TREE;
-					strmap_put(&ctx->paths_to_lists, path, list);
-				}
-				list->maybe_interesting = 1;
-				oid_array_append(&list->oids, &obj->oid);
+				add_path_to_list(ctx, path, OBJ_TREE, &obj->oid, 1);
 				free(path);
 			} else {
 				/* assume a root tree, such as a lightweight tag. */
@@ -397,20 +400,10 @@ static int setup_pending_objects(struct path_walk_info *info,
 		case OBJ_BLOB:
 			if (!info->blobs)
 				continue;
-			if (pending->path) {
-				struct type_and_oid_list *list;
-				char *path = pending->path;
-				if (!(list = strmap_get(&ctx->paths_to_lists, path))) {
-					CALLOC_ARRAY(list, 1);
-					list->type = OBJ_BLOB;
-					strmap_put(&ctx->paths_to_lists, path, list);
-				}
-				list->maybe_interesting = 1;
-				oid_array_append(&list->oids, &obj->oid);
-			} else {
-				/* assume a root tree, such as a lightweight tag. */
+			if (pending->path)
+				add_path_to_list(ctx, pending->path, OBJ_BLOB, &obj->oid, 1);
+			else
 				oid_array_append(&tagged_blobs->oids, &obj->oid);
-			}
 			break;
 
 		case OBJ_COMMIT:
-- 
gitgitgadget
