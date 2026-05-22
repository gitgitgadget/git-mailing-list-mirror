Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA8A37206F
	for <git@vger.kernel.org>; Fri, 22 May 2026 18:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779474289; cv=none; b=ZULhMm5Mh+je46llKW3HVTXae1yhTHgeWo0EiAFfWWmMR+K212/bzOWkN5jjTWPHpaWyPMMLgd397lX+fBsdAqxOoGJlI7aHy08oTSim97Pb0K0SRnSs3muSuxXCIfERogPc9RNWybFsvX93MdsIpWZ06T8f43xQvkduw0hA1ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779474289; c=relaxed/simple;
	bh=XkNjU+pCNlfY65TaG/FzK4vUuCXg/XrpMfbRA3j4E2Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aQAFNHeqq3rbJ1yV9MZxOHoWZfy68lYpHmWp5VKe1rXODsPylO50HXtTxqQ6UbGhKV8mIUDF9Njwq9CEoDF90DZ3BkAEvKzO5NbaTghy2etDDFbNVkItgWSj8nTEKsdk4CX2i2Hg65YUYeLr7Os7PeJbPLB1fk0loSwEclmC/jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mk96hneB; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mk96hneB"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5164dafcf97so76111651cf.2
        for <git@vger.kernel.org>; Fri, 22 May 2026 11:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779474287; x=1780079087; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFY7rIPiM7vSkyB2dj3w8/HqGiKhZS7PSPC3Ypc5rPY=;
        b=mk96hneBTImiUniypljLTLuuTr1SWgXNltq7r5VevXvaWEaqEXaRy99E1ghD3S8U/g
         GxK+rjGgL1dAvyaQSiMj97HaB1OhN73KrTPbdJEW0xa/M3J6Fa9Lx5sYw2DgJCIYWbGV
         6Vny4m445DlOk8+awl3zMixB7kKiFOXms/A29RGgQvoCo+IJurqmtU6w+HuWIgF3V/d1
         xNWfxOL214Mh1Y/QK2a3y7sCtPz70wKLFVmBv8erc8h+awuaTVXV6WnOPtUWXCtAeFkU
         ow9NjFHTAnSO9lEipK0sOYfAGatk1SRN/WOa4fqRHSgd7j1qzWLg1aiZLIlUVeMs1h+t
         0wAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779474287; x=1780079087;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZFY7rIPiM7vSkyB2dj3w8/HqGiKhZS7PSPC3Ypc5rPY=;
        b=hOl1fngGYVh+Sw7PXhiAeLi95NgEoO5jwq3xX8PRGEVqsTEztWEncem896Rll5NQQh
         MM+76psiDeoXWE8ocn3t1pv/o2vEam9R1cBVNwI9OEEa/JvTGvqRV7uA/j2OVtn25KP7
         3hE3/SQTRAYOI1jSrkM3KF6jKgbeRq6U9NWF2KfwWsc+VpcpcZUa63TF5S9xiTlmBh9K
         cZdLhDe7ee3mpFhGgocATs17iJW3edF0K/Tl2k+Kzsv3yDrjRDyKovvJiBCG+nEywOb5
         a/sJljX9eBCGa30gHJy3E7diXEeMWItHDzNNsw5oba3QZBD0Z8nwSyoTOQ+VXnlFQKNV
         mGzw==
X-Gm-Message-State: AOJu0YxsYd/CS0T2cnb7K/MEoiOKQuW9zQ3VcCV+ikvGeqCCNo8VIF81
	kpYqN5BDoTNVwmWZeqP0KLYtqkEoxpBfHP57zql2x6wrVZ3ZOVeWxdUu/Y6RvFJP
X-Gm-Gg: Acq92OFhO2rCH7pI2nj5p3H55DOJtrNNnh2R4KRtlkutB8xE0uLGR8ebpKhkZatkWdM
	ykAA/PhRnNlHlRuqgWzHQP+Cc0QMqf/c+cgZAuva+tlCJjdsiLmVI47jtOXptWvJX64LdO1mD8s
	SEm+PVhsunBjO56VO+Jwe9+rNOU3zsu2x9VaFwXyAJ+WbnvWlG2Yeby3kl+M9oJSXkKFlo75yqp
	Clvfz8WbpGj8oosrpTSc2Q+pb4Pw/D7xpyWerC7nf8IABm0wqjREldA2GbmIMHnOzF0cX/YYXz4
	eOwaEkKav1XHtHbtUVKRDR2yqCWpgr8ilgCzZaS7SpDc1kutGNTh9rMWOXtNv9S5MbhQ2tvbatP
	Z+qrdqD0ioIZG5UCMT1QLiaQkRWkOEuWnkP8jEScnx18Lelzm2qDiNL7mbHrNyxTn8u0708hcNJ
	ss/7mrMmPUjnOaFPkLY9lcmIyTcmM=
X-Received: by 2002:a05:622a:4296:b0:50f:bb01:9867 with SMTP id d75a77b69052e-516d4481b4cmr63311561cf.25.1779474286477;
        Fri, 22 May 2026 11:24:46 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.123.243])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8b24cecsm24201411cf.9.2026.05.22.11.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 11:24:46 -0700 (PDT)
Message-Id: <3884d4737feb2c81d734aea979317e4cd5d64490.1779474277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v5.git.1779474277.gitgitgadget@gmail.com>
References: <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
	<pull.2101.v5.git.1779474277.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 18:24:31 +0000
Subject: [PATCH v5 07/13] path-walk: support blob size limit filter
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
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Extend the path-walk API to handle the 'blob:limit=<size>' object
filter natively. This filter omits blobs whose size is equal to or
greater than the given limit, matching the semantics used by the
list-objects-filter machinery.

When revs->filter.choice is LOFC_BLOB_LIMIT, the prepare_filters()
method stores the limit value in info->blob_limit and clears the filter
from revs. If the limit is zero, this degenerates to blob:none (all
blobs excluded), so info->blobs is set to 0 instead.

During walk_path(), blob batches are filtered before being delivered to
the callback: each blob's size is checked via odb_read_object_info(),
and only blobs strictly smaller than the limit are included. Blobs whose
size cannot be determined (e.g. missing in a partial clone) are
conservatively included, matching the existing filter behavior. Empty
batches after filtering are skipped entirely.

The check for inclusion in the path batch looks a little strange at
first glance. We use odb_read_object_info() to read the object's size.
Based on all of the assumptions to this point, this _should_ return
OBJ_BLOB. Since we are focused on the size filter, we use a
short-circuited OR (||) to skip the size check if that method returns a
different object type.

Notice that this inspection of object sizes requires the content to be
present in the repository. The odb_read_object_info() call will download
a missing blob on-demand. This means that the use of the path-walk API
within 'git backfill' would not operate nicely with this filter type.
The intention of that command is to download missing blobs in batches.
Downloading objects one-by-one would go against the point. Update the
validation in 'git backfill' to add its own compatibility check on top
of path_walk_filter_compatible().

Add tests for blob:limit=0 (equivalent to blob:none) and blob:limit=3
(which exercises partial filtering within a batch where some blobs are
kept and others are excluded).

Co-authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-pack-objects.adoc |  2 +-
 builtin/backfill.c                  |  2 +
 path-walk.c                         | 41 +++++++++++++--
 path-walk.h                         |  7 +++
 t/t5620-backfill.sh                 |  2 +-
 t/t6601-path-walk.sh                | 82 +++++++++++++++++++++++++++++
 6 files changed, 130 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index 2994faf988..85ae48b699 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -404,7 +404,7 @@ will be automatically changed to version `1`.
 +
 Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
 ignored in the presence of `--path-walk`. The `--path-walk` option
-supports the `--filter=<spec>` form `blob:none`.
+supports the `--filter=<spec>` forms `blob:none` and `blob:limit=<n>`.
 
 
 DELTA ISLANDS
diff --git a/builtin/backfill.c b/builtin/backfill.c
index b80f9ebe69..5254a42711 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -98,6 +98,8 @@ static void reject_unsupported_rev_list_options(struct rev_info *revs)
 		    "--diff-merges");
 	if (!path_walk_filter_compatible(&revs->filter))
 		die(_("cannot backfill with these filter options"));
+	if (revs->filter.blob_limit_value)
+		die(_("cannot backfill with blob size limits"));
 }
 
 static int do_backfill(struct backfill_context *ctx)
diff --git a/path-walk.c b/path-walk.c
index bd81508163..04b924d4de 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -10,6 +10,7 @@
 #include "hex.h"
 #include "list-objects.h"
 #include "list-objects-filter-options.h"
+#include "odb.h"
 #include "object.h"
 #include "oid-array.h"
 #include "path.h"
@@ -327,13 +328,35 @@ static int walk_path(struct path_walk_context *ctx,
 	/*
 	 * Evaluate function pointer on this data, if requested.
 	 * Ignore object type filters for tagged objects (path starts
-	 * with `/`).
+	 * with `/`), first for blobs and then other types.
 	 */
-	if ((list->type == OBJ_TREE && (ctx->info->trees || path_is_for_direct_objects(path))) ||
-	    (list->type == OBJ_BLOB && (ctx->info->blobs || path_is_for_direct_objects(path))) ||
-	    (list->type == OBJ_TAG && ctx->info->tags))
+	if (list->type == OBJ_BLOB &&
+	    ctx->info->blob_limit &&
+	    !path_is_for_direct_objects(path)) {
+		struct oid_array filtered = OID_ARRAY_INIT;
+
+		for (size_t i = 0; i < list->oids.nr; i++) {
+			unsigned long size;
+
+			if (odb_read_object_info(ctx->repo->objects,
+						 &list->oids.oid[i],
+						 &size) != OBJ_BLOB ||
+				size < ctx->info->blob_limit)
+				oid_array_append(&filtered,
+						 &list->oids.oid[i]);
+		}
+
+		if (filtered.nr)
+			ret = ctx->info->path_fn(path, &filtered, list->type,
+						 ctx->info->path_fn_data);
+		oid_array_clear(&filtered);
+	} else if (path_is_for_direct_objects(path) ||
+		   (list->type == OBJ_TREE && ctx->info->trees) ||
+		   (list->type == OBJ_BLOB && ctx->info->blobs) ||
+		   (list->type == OBJ_TAG && ctx->info->tags)) {
 		ret = ctx->info->path_fn(path, &list->oids, list->type,
 					ctx->info->path_fn_data);
+	}
 
 	/* Expand data for children. */
 	if (list->type == OBJ_TREE) {
@@ -510,6 +533,16 @@ static int prepare_filters(struct path_walk_info *info,
 		}
 		return 1;
 
+	case LOFC_BLOB_LIMIT:
+		if (info) {
+			if (!options->blob_limit_value)
+				info->blobs = 0;
+			else
+				info->blob_limit = options->blob_limit_value;
+			list_objects_filter_release(options);
+		}
+		return 1;
+
 	default:
 		error(_("object filter '%s' not supported by the path-walk API"),
 		      list_objects_filter_spec(options));
diff --git a/path-walk.h b/path-walk.h
index a1736ecb2b..60ceb65433 100644
--- a/path-walk.h
+++ b/path-walk.h
@@ -47,6 +47,13 @@ struct path_walk_info {
 	int blobs;
 	int tags;
 
+	/**
+	 * If non-zero, specifies a maximum blob size. Blobs with a
+	 * size equal to or greater than this limit will not be
+	 * emitted unless included in 'pending'.
+	 */
+	unsigned long blob_limit;
+
 	/**
 	 * When 'prune_all_uninteresting' is set and a path has all objects
 	 * marked as UNINTERESTING, then the path-walk will not visit those
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index ede89f8c33..d2ea68e065 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -20,7 +20,7 @@ test_expect_success 'backfill rejects incompatible filter options' '
 	test_grep "cannot backfill with these filter options" err &&
 
 	test_must_fail git backfill --objects --filter=blob:limit=10m 2>err &&
-	test_grep "cannot backfill with these filter options" err
+	test_grep "cannot backfill with blob size limits" err
 '
 
 # We create objects in the 'src' repo.
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index b0ee31ee2d..45f366d738 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -477,4 +477,86 @@ test_expect_success 'topic only, blob:none filter' '
 	test_cmp_sorted expect out
 '
 
+test_expect_success 'all, blob:limit=0 filter' '
+	test-tool path-walk --filter=blob:limit=0 -- --all >out &&
+
+	cat >expect <<-EOF &&
+	0:commit::$(git rev-parse topic)
+	0:commit::$(git rev-parse base)
+	0:commit::$(git rev-parse base~1)
+	0:commit::$(git rev-parse base~2)
+	1:tag:/tags:$(git rev-parse refs/tags/first)
+	1:tag:/tags:$(git rev-parse refs/tags/second.1)
+	1:tag:/tags:$(git rev-parse refs/tags/second.2)
+	1:tag:/tags:$(git rev-parse refs/tags/third)
+	1:tag:/tags:$(git rev-parse refs/tags/fourth)
+	1:tag:/tags:$(git rev-parse refs/tags/tree-tag)
+	1:tag:/tags:$(git rev-parse refs/tags/blob-tag)
+	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag^{})
+	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
+	3:tree::$(git rev-parse topic^{tree})
+	3:tree::$(git rev-parse base^{tree})
+	3:tree::$(git rev-parse base~1^{tree})
+	3:tree::$(git rev-parse base~2^{tree})
+	3:tree::$(git rev-parse refs/tags/tree-tag^{})
+	3:tree::$(git rev-parse refs/tags/tree-tag2^{})
+	4:tree:a/:$(git rev-parse base:a)
+	5:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
+	6:tree:left/:$(git rev-parse base:left)
+	6:tree:left/:$(git rev-parse base~2:left)
+	7:tree:right/:$(git rev-parse topic:right)
+	7:tree:right/:$(git rev-parse base~1:right)
+	7:tree:right/:$(git rev-parse base~2:right)
+	blobs:2
+	commits:4
+	tags:7
+	trees:13
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'all, blob:limit=3 filter' '
+	test-tool path-walk --filter=blob:limit=3 -- --all >out &&
+
+	cat >expect <<-EOF &&
+	0:commit::$(git rev-parse topic)
+	0:commit::$(git rev-parse base)
+	0:commit::$(git rev-parse base~1)
+	0:commit::$(git rev-parse base~2)
+	1:tag:/tags:$(git rev-parse refs/tags/first)
+	1:tag:/tags:$(git rev-parse refs/tags/second.1)
+	1:tag:/tags:$(git rev-parse refs/tags/second.2)
+	1:tag:/tags:$(git rev-parse refs/tags/third)
+	1:tag:/tags:$(git rev-parse refs/tags/fourth)
+	1:tag:/tags:$(git rev-parse refs/tags/tree-tag)
+	1:tag:/tags:$(git rev-parse refs/tags/blob-tag)
+	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag^{})
+	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
+	3:tree::$(git rev-parse topic^{tree})
+	3:tree::$(git rev-parse base^{tree})
+	3:tree::$(git rev-parse base~1^{tree})
+	3:tree::$(git rev-parse base~2^{tree})
+	3:tree::$(git rev-parse refs/tags/tree-tag^{})
+	3:tree::$(git rev-parse refs/tags/tree-tag2^{})
+	4:blob:a:$(git rev-parse base~2:a)
+	5:tree:a/:$(git rev-parse base:a)
+	6:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
+	7:tree:left/:$(git rev-parse base:left)
+	7:tree:left/:$(git rev-parse base~2:left)
+	8:blob:left/b:$(git rev-parse base~2:left/b)
+	9:tree:right/:$(git rev-parse topic:right)
+	9:tree:right/:$(git rev-parse base~1:right)
+	9:tree:right/:$(git rev-parse base~2:right)
+	10:blob:right/c:$(git rev-parse base~2:right/c)
+	11:blob:right/d:$(git rev-parse base~1:right/d)
+	blobs:6
+	commits:4
+	tags:7
+	trees:13
+	EOF
+
+	test_cmp_sorted expect out
+'
+
 test_done
-- 
gitgitgadget

