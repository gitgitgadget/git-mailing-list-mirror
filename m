Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCFB3B4EA7
	for <git@vger.kernel.org>; Wed, 13 May 2026 21:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778707155; cv=none; b=uc9GAbLFpNeDkQqEPF2cavYWY+BdlwnLHvWZGYavoChql1g3/MooLnGhbEWFe4l7ZGco5ETJF41FvVPd8wUCNrd/Y8sEpiEgQgxHQ7PxYDifsM4yEiP65lqhePeOvGkASYJ9QW/i87ZpWJgVcjZcuWgzMKDFvO2GZnDs1SbYHOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778707155; c=relaxed/simple;
	bh=XkNjU+pCNlfY65TaG/FzK4vUuCXg/XrpMfbRA3j4E2Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SVi0sU82JP+KeQq6OMpR7KMEOMULkF1gpteToPsc53G4I1EB7vV0mbxuWtJpscVc7+PeiBT+B0e8C0P7crsl6pj4cHrK2Dp0yppw6JYVZywD3ozec3z0l3HnEuPrMM6YFIvJfMiuauoGFfmLL4lJLY8xgttBNeDuawHqfF6gLYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2RobM+O; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2RobM+O"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso5172319eec.0
        for <git@vger.kernel.org>; Wed, 13 May 2026 14:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778707150; x=1779311950; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFY7rIPiM7vSkyB2dj3w8/HqGiKhZS7PSPC3Ypc5rPY=;
        b=e2RobM+Ox6QoFhhNPjs2tbNB5c0zVOP+Bz9+YjzlGXJfYeOC0ynTI7zTdFQo4jK6y3
         EFfpy/m3Ubkd28qfBjvjacAE1D24u3PuLuWGI2AUZxviP17FKMMocJxuGonpqs3cZxZZ
         pPITYH27o+l9ZFIiN7RY1gPHnR05gCR1Q4neZ/oqZRuzpC4W8KmCgaEflJleTZn9oOHF
         mjXXh67ww/CPu+GDi7PjPTnNomfZAjiyl/bbJgG0W5iU136C+o5ZmTvlaQRHkGHmeid1
         eGRdPIW1WMKw/V1L9XOENVd1ivFh0NtyAatX7e3qL9F1wz2U+ijs9ECiUYDGmBRxjQFl
         +kqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778707150; x=1779311950;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZFY7rIPiM7vSkyB2dj3w8/HqGiKhZS7PSPC3Ypc5rPY=;
        b=PyJCef7JKhlanBsJoNYyRk8xtbQXWRuFfGiAgw5RlVrRiZ5ejVYxYspAVmIPu/e4cx
         zuh51IlHg/7Qr9ycRXciX3Ijn3iNBfzIfVgq+37hklPJtb9z7FLZHMdvhIGuKmCq2j8f
         K2hgKWR9sTAvHRnuwynUDuRKYvyiwYLDuvZTVSWYfcx+aesKxIBKmHqqOX5PRabpL1Te
         3oR3bNnMo0zDHawoa2CdNDD40QTsb0Ro8S5Pw1OizHMOq9p6ocwqdg7IYuN4tr2evs15
         SQgD08qLfb0/DLtREWNbhEPQrXwl66j77PQofvfZuoXKqNsNOmoxUUml/gLJi7ONP764
         AeTw==
X-Gm-Message-State: AOJu0Ywnv2eNjsk95dpDBWpR+unNKE9bsdiiXD76b12KgH+KhpD48VU6
	wmBMXeypO4tU+NdDzxbkJXLQWbN1k5SeIgHqx7xlGFaC+01pcr1b1asYhiLbHRwU
X-Gm-Gg: Acq92OFlll6z7VUHnFIt94V4gRyjjd+CVoNLsBuqTN8vRMSl93LYCuMohlfZr0w8ffX
	IDhXUbY0WzoUmO3ixdE+T2D2LGQDdFl2UAvrIKxyJbNQeVJ6o5hd/3IMDJY8kFCbtPHN7tLBeIs
	oDf4Oxnvmk1dy8YjojAGr/sGI0XC5GxCpk6hyFiyCxOKDwWg6pma3b5qDFnE1VIIPmCi43Yco1M
	Mqo9fxwxEZ7TZXiY6F93lbErp2YnrcdGW/iRlIU5G4HrE5iwCNNRExvdgXMkDhzh3MGS/Yeg7jE
	wMUUXHjZzXx/FCc8nDLRjpvIgCx47qlOsRWKgrG6t+kfEUsi2lXRHrBMyL+FRhULIJZqdIhEWFs
	lEZEHh0/N5vBbpIBbeqrFdGaJB1kChVOINHf1yl/Qg3KyhpvFs6Qj0ziphyKwbAhcz7+fyRBCtx
	sQPxZ7UKQ0F91cKcbnoPnOsFHQQQ==
X-Received: by 2002:a05:7301:19a2:b0:2f0:c593:986a with SMTP id 5a478bee46e88-3025b5d3dcdmr789808eec.0.1778707149929;
        Wed, 13 May 2026 14:19:09 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.77.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6f6sm601663eec.17.2026.05.13.14.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 14:19:09 -0700 (PDT)
Message-Id: <133c1b156cc8b2e5d0c46b3b44066ebcddaffe64.1778707135.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
References: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
	<pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 May 2026 21:18:49 +0000
Subject: [PATCH v4 07/13] path-walk: support blob size limit filter
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

