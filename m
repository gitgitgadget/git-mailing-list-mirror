Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30217279DC9
	for <git@vger.kernel.org>; Sat,  2 May 2026 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777731367; cv=none; b=D+Rh5JDmnYnGH1K0QXRvPN3lxJXGW+A4BY1I4WJW0D48xpGUeW7Ysr0xMEoFSs6nZKOcV5Jk4AVOI1+GxjHKVTzP9UNqvNSXHgQWAdsSl1Ff1ihtUmWYV5QV+XXoBvkA/vUi4UBZIx/2gISDL9WbsNzs/NworPqsonOF1SFLKx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777731367; c=relaxed/simple;
	bh=PZwKOM6EUrv03bWk3q6ZWrWuiKGW6KA3COrIyWbea1A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ix9lJs7cDgUr148xvRTbp9u8tVMmOuNFrsvj/SXRa5Bm5EcmEdsGSSD+nv4nqq0miABnFnieW2i71j5ek0aUNGqkZ78g7Q6fz++okHSnTlizHUaX8vcsijlPHrZLcyCBhZUEb4BhzPe1+od6Jq3W6JSc98bx2O5ul69c0vVee28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jz5gh4GB; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz5gh4GB"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ef38cf04f0so602481eec.1
        for <git@vger.kernel.org>; Sat, 02 May 2026 07:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777731365; x=1778336165; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuecbIUow3UYm8ljBo8LwXr+LuS20qevXS8yPYXlqEY=;
        b=Jz5gh4GB1iN4jq/QWXfRF0pLPLNc7Rpj0YdDQBzhI669O7et8qR+2IgQ9Q1S4zwTNq
         QXxadwsZ6jyGWqVXoyTLwVkzgsyzZHo1AbeiaoJTV0GvCdWNOaTGu3mrNbVnOq5bf1/u
         z+/MltXnn1QscIosyPNabd06qURObwLCFpqbxAq9ALH1zjsoMu9i07+/D+nOsUdQREbh
         NhSt1bq73I20VoZEbUK5S8rkp6tMVzjvuck318pLZFmoqv6AJZgvnSMgFdSDX+lYLGkT
         JgBL2clbgF1CgW8ikn1PylN1dg23BGPnleil46Ydyyy/eZkXwZMPZSrJuU6asToEqmxq
         W7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777731365; x=1778336165;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vuecbIUow3UYm8ljBo8LwXr+LuS20qevXS8yPYXlqEY=;
        b=PuK9f8kJwITo1UVhzjwxdoRVWaQTWbKtapLLPAoJw3Ml4YmV6TNOahUiPwtuT2b5y6
         YXdsdr/SdBVngfNUse+eilAdhtRrTqBm3MPmpJP2HDy5KiNL8EQkpOkeU5hmXkkX7urL
         ef/EUi0ijQWUJ1WPqsvj1UZEOeIPNCY73o9Ip9JSXqtuZiKSwxGYtTgNU0MVLxeP6/lZ
         YIQPmqG0/edZbTeOqYeR+WAZARQqtIWyLtEWgJSOm+sz4z70vUhsJR0z8fPxOu8Fsb2Q
         NvwEDLzxx5DwbXrMgzrq/9ztBUrDXK2YmNg1s5CRHNBLWpD5m86rrIFM64rNwfFF/+f4
         rvvw==
X-Gm-Message-State: AOJu0YySQcvfHYj9BU5uhbm8HcjOnKv4kGWPF9dG519KTaP3tTQiQPoS
	xV42sdcJLB199CC7BdR5pK63IXovUlQsIOwpZ9Ai+IEIyM9+0M2DBMyemNb7Dk9v
X-Gm-Gg: AeBDieu4GT8EvJR4K75/6b6eKARBu8CnJ/MAuij+atOoiBlYYOacH7CMlvnXUHoLzsh
	RN6dULRRl9pAasQNDEVH2Gl+pX+Bsm54l1Bvck6rPMU7//qEMGPhJnkjNDmvBrhIZ2GZO0ze+A+
	0yRiXqLn9gtzy6wSfiJOoK7NiCveuqYsOmfAfydj6vogDeQjHUNRgZoIyC0fqMCpOJHuXfVicun
	IFlUt+s0cUypOMtSwYOzMJQQlqf3Ob94bXCCMVyHK1PojRZowXjndDlFdyH94HTbe9B4XpVHIb3
	jDoq9NmnVDgNY/9Kyn9DWo5rKyob8RmWX/lNSnrAN5G2FS8zcN410fcD9FgXub+2o5hsUGLh6PN
	GI9E3O3xjar2y4+0+O0iMXbnolZP4iyvGts25WynK77GFwWwY2M14xen+o9at8jCG10zhDnGzmR
	hUQqGhezUKIYIJSMw0BQKDvLgigoJIm1f8V7TcSS6c5AUBWiI=
X-Received: by 2002:a05:693c:2c0c:b0:2ed:e17:d50f with SMTP id 5a478bee46e88-2efbaba1e72mr1524977eec.34.1777731364785;
        Sat, 02 May 2026 07:16:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.87.216.119])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38e71ccesm10152618eec.10.2026.05.02.07.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 07:16:04 -0700 (PDT)
Message-Id: <2e786160bdc283617de5b4c901c76773f1ed3a41.1777731354.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
References: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 02 May 2026 14:15:52 +0000
Subject: [PATCH 5/7] path-walk: support blob size limit filter
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

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/backfill.c   |  2 ++
 path-walk.c          | 38 +++++++++++++++++++--
 path-walk.h          |  8 +++++
 t/t5620-backfill.sh  |  2 +-
 t/t6601-path-walk.sh | 78 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 124 insertions(+), 4 deletions(-)

diff --git a/builtin/backfill.c b/builtin/backfill.c
index 51eaa42169..7ef9dc305e 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -146,6 +146,8 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 		die(_("unrecognized argument: %s"), argv[1]);
 	if (!path_walk_filter_compatible(&ctx.revs.filter))
 		die(_("cannot backfill with these filter options"));
+	if (ctx.revs.filter.blob_limit_value)
+		die(_("cannot backfill with blob size limits"));
 
 	repo_config(repo, git_default_config, NULL);
 
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
index 3580e10b9c..3c8a75192a 100755
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

