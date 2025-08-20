Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB98279DCD
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755715204; cv=none; b=khQXEe7xlnws2h9UUOmgEkNjWVixZNfGWcQREOg1ZjI0FvS0E9N8x1pDYp+UD6qMoVF3gsxuPtKOGhMTTPVrMNvZXZbSF+iJz6jFCYVj2la6ROLTRiCJ4Z1vgq4Rwu40mNGIZqy9acOBronz13HS+qaNIcnIudWuNEoI08njwS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755715204; c=relaxed/simple;
	bh=Vq5F4RmEumjvKE0ID3Ng7KFzMCgowK4+Wij2BXllYnI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uNEyK0JQetzlrVqbZW1bwaEzOnEgbiw0AaM2djUYcVLGv13osKo8ZR7r9LlrqPYDSoBgORww7ODkM75TE6IRhhcCHleez90DWh3OY5L98ZR+fA0N8lBBJmpbqsO3bdIT/I37o1cOZEhAY3MrgRQmLouF+GiqIxoWBpSzDZI99Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXiJ8JXr; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXiJ8JXr"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b00f23eso1166405e9.0
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 11:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755715200; x=1756320000; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FyQIcATPbM+XyVKfKEiCSoerS/xJQAj9cFgCMxc5NU=;
        b=cXiJ8JXre/wG++rpWA6NF+YURmahtHnRhl8kgcdt30cTsF+2/L3kLYt07Fup99H5Ut
         FARJrBzpKm6P33qLH/1PR9f5EP0RP1Q3W34u5d95EvxmygHuHGFDkBRtDwupOO+qoVME
         xDCk8/SJvAL9w/gQ4XvU+NPi/3SL/NfkHDDmBxQ163xQLSsxPdpYlsSrivTVwoZRmLXi
         f7li1I3fdNAgE/+GNPsSoOeyRzga9qm/6m6DLfhB7Ovy+s2FmJHWgPjTMsvEkg7Q8nKj
         HUcRjrpasiAW2d1w27uDgqOdyEoGiJxKPTkkEzg8AU+UmbBYId4tVGrdTQ/5gs7lnzxH
         V+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755715200; x=1756320000;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FyQIcATPbM+XyVKfKEiCSoerS/xJQAj9cFgCMxc5NU=;
        b=V3tSF8OIQz9ibY1bfjRM1AAHxsPal3dG+gqw26uyONAlhddFd9ohi8mNb8ZkcXHnRZ
         anpu07HggYvoWkGLIx2UPv8kn6kIer1Wd3qUiSqdOKI7Oq1hT1swseylHRTG/BR/X8A+
         ZxY7mCfcvapG7juNgSpOysvYy7pYRYbURVQVISseQU/yBBqtYXLpeT8aA0b9g7TU82sY
         q/EZ9j6EBwvZn9MckMyFo97v14R/FMtE+9Rq9XXN8LNvYvrMj4xoHFbIQh2RvSsyrrEk
         tTAVpOm/78Mqhq8e+1YbJ+zCFqy//HI/DmOLMW+XB56EMmd2GGowtIk99hlhPwD0DruL
         BorA==
X-Gm-Message-State: AOJu0YxOil5STCycl5PlQPL75v5RYvAuEgnajgLaOfjhnYgSRKyzYTeD
	T5Uv9bTRcuuuWLAVQilMDhiit8Aghy5F4xXtC8NGrpkeKa0r+MHT2FgNUyrNDg==
X-Gm-Gg: ASbGncuYyrnzfhRvMmM07bkZaJe6fxAbYjyvNkUIHc1TEqzjE55PU2ydqkrLrUGbuOc
	nLD6GLSTmykEi2LE/0Pylm1jsukos58MiKq8dEV7H0H0M+u9tuOxm0S4bGXPe++MlQjYjGrm0sr
	uNy4dgkm0OsNwi89LNE1thm5GCHjfA8yq4XuCIIWKX24ScE0oyQICfPy1O/41uDCWzWLEetVwCW
	wb+8g4EILqhEmDz9Tfye3OtL8pxlWplf6ImFZkYr6IB0d6P47dryiR2WPMC9KTgqJMogWxmM5kK
	eTPbr/DaRd6utiTJ9KsuUIURP+31EXfN6ePMiii29yMTccxBp0wvk459P9nqUOijfk0z/LVkxC1
	Ce5oJyoW2FitSx9c5LdwrO8uwBfsLAIkO5irkAA==
X-Google-Smtp-Source: AGHT+IE22D++Q/DSlCjKkchKvznG1XtGjervru/geoMaRFcrYTSuBreGS7nyqoW/Pvjmm0dvJ72gDg==
X-Received: by 2002:a05:600c:4586:b0:453:78f:fa9f with SMTP id 5b1f17b1804b1-45b479b5545mr32840895e9.11.1755715200047;
        Wed, 20 Aug 2025 11:40:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b47c28644sm48907395e9.5.2025.08.20.11.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 11:39:59 -0700 (PDT)
Message-Id: <dd458e043548a8ed33070657cc98128efb606847.1755715196.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1956.git.1755715196.gitgitgadget@gmail.com>
References: <pull.1956.git.1755715196.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 20 Aug 2025 18:39:56 +0000
Subject: [PATCH 3/3] path-walk: create initializer for path lists
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
