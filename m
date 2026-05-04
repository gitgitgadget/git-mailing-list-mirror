Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684D13115AE
	for <git@vger.kernel.org>; Mon,  4 May 2026 20:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777926091; cv=none; b=GZex56LMUEpQB4XycJqSd1vQmcAEDjxIrR1O8G3LxKTGUDGT9TZSHN4kyUCXzoft4F7pbcUg9Ut+oqadS1Yfzcryy2xMIn0rlZ47OYhvoMgTb4npvR97DucmKPc2fgiAVeUn+Fq2gSmKbqJPmdm5BZwhZPZ+10eEDShKuxY2Ah0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777926091; c=relaxed/simple;
	bh=qIVy91gUd9u22rhdnb4T3ekn+0ekzjO66lExvdGyCk4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=A2OtOxYIgw8Dci22vSBblLT2TOtp2gXZ9XdF1BXJdIpAozCtoRhbGV7cjJonJ6C0rAfAG+1o5ndMISdjyjy3TJKP7tUUgrTGYR7G018m4wTBefkigKfgzP5QPTrxlPUit0Cfu0qHeFTOr7Y9TmdF9eQZjvTIQOKWd9QFUi7VQSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjsWzaWS; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjsWzaWS"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-902deb2412fso83138285a.3
        for <git@vger.kernel.org>; Mon, 04 May 2026 13:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777926088; x=1778530888; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXQpoDva4AsesYCSswR1Y5BZ2/93QyZwip+qEOwwuuM=;
        b=EjsWzaWSXUYosv7FJ+Ibvt2PDpgph9MqKDBJ35+GLasEB3ewsnQ3XsZsLSFRvufW7Z
         dI2Qu74eP5asllaTi85XBPYmADB1xEZsx886uMxXjjYavEjJZOoA8bhCWB63sDRaSUNc
         MLw3WrkmdlTaItCwEZL494Sc/YbXae5nxqC0lAyELj526o4Hw65I2JkvwFr08FytskI8
         olm8QKFdijxSFAFkKsLNiyQG8WffiYPiY5p1bIKg1c876GLif7dSgKZM/Bh71EIIEW/v
         loIcOb52lGpBnPB7rXMAiOLCXQEOFfeGDcRkMuXALHvVHCj2Fs619yGgR5AesL5VrnuF
         3C6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777926088; x=1778530888;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fXQpoDva4AsesYCSswR1Y5BZ2/93QyZwip+qEOwwuuM=;
        b=QqJwoNH2gdBlaysr5s0buO3tguZwoXc60zdSsr9SaOUvPNLaXhCTix9RzK2aBDNJRJ
         w9JV4ukT4Wfe1t3ejrO8hV5OYX/UtUhCxpBaTUS4WEPIWdtlUFYpv/Nl0YkLum1UQgaa
         m6FTPWdrDCBpMnxXZ0gp75UgjjU3ACJJeWxnz+yW6K7BrJbDk8CebMQMT+IvJFojgPLy
         P5SWBveh8DELgA46HQKdjU+tnx/v8f7BUrs8GOnuWI8xivjxBF7slLNTkRrBZTmf9fpQ
         nC6draQRRXS2yRFFO/NCtZX3BU7AJ06zpjgVjlBwtpDphLbebE80JmXNrk3XQ79mZvw0
         MToA==
X-Gm-Message-State: AOJu0YyG2YjrKNJh+FpjcJF+Ry5MrIQeOKknytvkuzpUiMo5zPcLgPvR
	SjpOhztQfShsxhOG12fl1s3M47KzasSNXoGey742bzNTXzaov6ihN/WYKM+J1w==
X-Gm-Gg: AeBDiesih+x9DhvhFg2nJZZTZIZSLoRFwW4SLAtiJ09WgWvP95JX4w4/9EAxg9rdEiM
	fGkPzj2iheh87DQk7RfmMhRzhbf2Q8CNH+hAnlXhYNoNABGF2Md9BOiJMRFts5TY+zffnVAKslS
	X9cBaIOFZsnFf0S2ZvgcTPGTRabH7AgSftSESymilLS8lvQZiUWRsRXEo2QLRn+Q3e/XGoKBa3j
	MIb7gF6ss4yBwH7MksX7uF/Y1+YbJL1JtIj1Mqis0dr7S8/uMhA2VP3V3IqEQaIex5SYrJM/rtF
	ULDA0yE8fuIlcEuot/7/aqs+mH8UP4cDlx9WsctbvGKIygrLvedONd0F47VhlYPtxsrOgKLYkpD
	3Vy/5mFilL+Btp1EkAp22I1HWUHTglOo0+fZ1G+VtP0OFrcc/CKz4/zl7Qdg+Myg7TVQ5dgazTl
	BLpAxzv/gyU8ovjRrWN1toS04RWXcI2uA/JjbT
X-Received: by 2002:a05:620a:28d4:b0:8cd:8efb:b7d9 with SMTP id af79cd13be357-8fd178639e8mr1715521485a.28.1777926087796;
        Mon, 04 May 2026 13:21:27 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c9229c8sm1244170185a.36.2026.05.04.13.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:21:27 -0700 (PDT)
Message-Id: <d309345fece6fe293b392197b717b947b48590fc.1777926079.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
References: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
	<pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 20:21:14 +0000
Subject: [PATCH v2 05/10] path-walk: support blob size limit filter
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
 path-walk.c                         | 38 ++++++++++++--
 path-walk.h                         |  8 +++
 t/t5620-backfill.sh                 |  2 +-
 t/t6601-path-walk.sh                | 78 +++++++++++++++++++++++++++++
 6 files changed, 125 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index 917045d5c3..3821bf7e22 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -404,7 +404,7 @@ will be automatically changed to version `1`.
 +
 Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
 ignored in the presence of `--path-walk`. Whe `--path-walk` option
-supports the `--filter=<spec>` form `blob:none`.
+supports the `--filter=<spec>` form `blob:none` and `blob:limit=<n>`.
 
 
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
index a4dd197c37..0e7dab7a6a 100644
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
@@ -315,9 +316,29 @@ static int walk_path(struct path_walk_context *ctx,
 	/* Evaluate function pointer on this data, if requested. */
 	if ((list->type == OBJ_TREE && ctx->info->trees) ||
 	    (list->type == OBJ_BLOB && ctx->info->blobs) ||
-	    (list->type == OBJ_TAG && ctx->info->tags))
-		ret = ctx->info->path_fn(path, &list->oids, list->type,
-					ctx->info->path_fn_data);
+	    (list->type == OBJ_TAG && ctx->info->tags)) {
+		struct oid_array *oids = &list->oids;
+		struct oid_array filtered = OID_ARRAY_INIT;
+
+		if (list->type == OBJ_BLOB && ctx->info->blob_limit) {
+			for (size_t i = 0; i < list->oids.nr; i++) {
+				unsigned long size;
+
+				if (odb_read_object_info(ctx->repo->objects,
+							 &list->oids.oid[i],
+							 &size) != OBJ_BLOB ||
+				    size < ctx->info->blob_limit)
+					oid_array_append(&filtered,
+							 &list->oids.oid[i]);
+			}
+			oids = &filtered;
+		}
+
+		if (oids->nr)
+			ret = ctx->info->path_fn(path, oids, list->type,
+						 ctx->info->path_fn_data);
+		oid_array_clear(&filtered);
+	}
 
 	/* Expand data for children. */
 	if (list->type == OBJ_TREE) {
@@ -500,6 +521,17 @@ static int prepare_filters(struct path_walk_info *info,
 		}
 		return 1;
 
+	case LOFC_BLOB_LIMIT:
+		if (info) {
+			if (!options->blob_limit_value) {
+				info->blobs = 0;
+			} else {
+				info->blob_limit = options->blob_limit_value;
+			}
+			list_objects_filter_release(options);
+		}
+		return 1;
+
 	default:
 		error(_("object filter '%s' not supported by the path-walk API"),
 		      list_objects_filter_spec(options));
diff --git a/path-walk.h b/path-walk.h
index be8d27b398..bcb81b70a1 100644
--- a/path-walk.h
+++ b/path-walk.h
@@ -42,6 +42,14 @@ struct path_walk_info {
 	int blobs;
 	int tags;
 
+	/**
+	 * If non-zero, specifies a maximum blob size. Blobs with a
+	 * size equal to or greater than this limit will be omitted
+	 * from the walk. Blobs smaller than the limit (or blobs
+	 * whose size cannot be determined) are still visited.
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
index 94df309987..d9be7b9cd2 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -475,4 +475,82 @@ test_expect_success 'topic only, blob:none filter' '
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
+	2:tree::$(git rev-parse topic^{tree})
+	2:tree::$(git rev-parse base^{tree})
+	2:tree::$(git rev-parse base~1^{tree})
+	2:tree::$(git rev-parse base~2^{tree})
+	2:tree::$(git rev-parse refs/tags/tree-tag^{})
+	2:tree::$(git rev-parse refs/tags/tree-tag2^{})
+	3:tree:a/:$(git rev-parse base:a)
+	4:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
+	5:tree:left/:$(git rev-parse base:left)
+	5:tree:left/:$(git rev-parse base~2:left)
+	6:tree:right/:$(git rev-parse topic:right)
+	6:tree:right/:$(git rev-parse base~1:right)
+	6:tree:right/:$(git rev-parse base~2:right)
+	blobs:0
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
+	2:tree::$(git rev-parse topic^{tree})
+	2:tree::$(git rev-parse base^{tree})
+	2:tree::$(git rev-parse base~1^{tree})
+	2:tree::$(git rev-parse base~2^{tree})
+	2:tree::$(git rev-parse refs/tags/tree-tag^{})
+	2:tree::$(git rev-parse refs/tags/tree-tag2^{})
+	3:blob:a:$(git rev-parse base~2:a)
+	4:tree:a/:$(git rev-parse base:a)
+	5:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
+	6:tree:left/:$(git rev-parse base:left)
+	6:tree:left/:$(git rev-parse base~2:left)
+	7:blob:left/b:$(git rev-parse base~2:left/b)
+	8:tree:right/:$(git rev-parse topic:right)
+	8:tree:right/:$(git rev-parse base~1:right)
+	8:tree:right/:$(git rev-parse base~2:right)
+	9:blob:right/c:$(git rev-parse base~2:right/c)
+	10:blob:right/d:$(git rev-parse base~1:right/d)
+	blobs:4
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

