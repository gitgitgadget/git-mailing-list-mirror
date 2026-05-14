Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13A233E355
	for <git@vger.kernel.org>; Thu, 14 May 2026 16:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778775936; cv=none; b=Rau/NKOAlU1DxV4WxjskMIbtYO8fXcFLYSfqekx3hv5xA/YQZChsV8lbFKgoWrpkkR1GlIcQP5YecffMwzFQ/KP5gFdikW3+FKpM4UUjPIQ1xq68lrnVEq96xvAQMtFFPUyNXHYdUpC0DrnsV84rNPPjjUiDq3SAw+q+CdjsF8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778775936; c=relaxed/simple;
	bh=bn71+8rLW9BXb1C1orNeXDP3HhMJYkpySMNIwuD/+Ww=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Oaxe/I1gSYQgW3T0vv/M9KomwdJE9O6G2iTNTefJlIouq+uhGIwcM+nnzhUtg5zEbauBXh2VNkot5CcJebIG93Ie5dSE+JALIBuoal3PF7186wBNiu6VVSUyOyoDaga+OynO79+iouKw+5QgvvAzdJ/iEnmn8bNzua5qDo2N0l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q1fvq45F; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1fvq45F"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36643b96b99so5952439a91.0
        for <git@vger.kernel.org>; Thu, 14 May 2026 09:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778775934; x=1779380734; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGGmqRtBf0dcXGRIZ3NjBu1USNSPjvGZ4jlaR9rQ8Cw=;
        b=q1fvq45Fd+RAzRUcrmBANRqZJlE3xmDiuw45g0JyT3PKGG8Wry2SpcWXUneOTDA2VN
         uGA0Iy4pwC0qfBwVh6Xjef+CRiPh+GlSqoTMSXLfCvCsNw3kJ+N42afPBt0qRpZXn/Mc
         bfbOrAysVeVa0QHhJNybFF1qWS2EnW0jKkSJm3e5gjh+P++8fmreA88V+CZwl8WuI3cV
         OAFncJfmJwAilvniyGIpheaJq8U0rhTd72VtMyKZCOhT75a5czfmazF7NejuP6QSHgyT
         dwkqF29xJ2+qWWSZSSwE9xb6Yb1shE9hMVazfF7AyyspKI4pdIyzfapVOmELXJ0A6x8O
         NYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778775934; x=1779380734;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OGGmqRtBf0dcXGRIZ3NjBu1USNSPjvGZ4jlaR9rQ8Cw=;
        b=OmhO/5VbFqzwG+GYVwhK7LqVeigGTBSXhMVhnY0HsP/SS76xMgmxMAARDBdytqOt7J
         5BsyO+quH6Ia+Cu1zo1R3f+T45lqKEuSq+KByj2j5yK3RBtYo/++YIsHMaq8DJtfA/2z
         leSanu9jLoy/FaAbcng/4gwXU1CYHhVTDBeB7JmnhJmTg/xWNU1IZMGXAJVx8Vj7V8mn
         JKzPRwC29MpOSzSzXJBcpDbjgyFs5QQHXlyK8qkf8Ewq2lOe7UZKiDuS7cl4tsKENsmK
         tLlf24FHrs4zavPX4ZCfzL/QdMnmqY1yDLs47vC772RZFYWGjeA2AaOANlZp77+M2mWf
         xuNg==
X-Gm-Message-State: AOJu0YydiGl12FhhXozwszRomRSNuBhBVeinVhh74T7FSYQF8X5KspwN
	nNyxAsITRJgU3TSKcu31XA02bS5d+lJTqZ0/yvBVz7fLJNoJlbe6UBhZ0kU/fQ==
X-Gm-Gg: Acq92OHi65yFzmfdw7oG5ztC+I4pV3mIAWg7wKVb/i6A/a+SMWIP6+/CYsSZf0btqgh
	LerDrtyfxl3/r9YL7Yz796pR3LRBNhbELnFAXnp7ZpKyFbOvLSwJ9D3B2L1FRNrtjX0CxZl0q2T
	VoYt3t9agGJeYZkj8U8Qagxt6L4YiZd+y5fjTIBzJrmJpvVfqYa0Nj2hMvq2tAJSnK7aqRlP37z
	qa+KFRWKRKtpV9BCuwpVA3QHaMBA8ZxjPm1dXZ9EF07jdHy+Hd+/qVJY+ZfENzlyY2bYvLnt9XU
	Q+8Px5rMYbL0+iOivokZ4N5A/rysRcjDJVfIUoaBsT62yf+sJr2Je87ayyCwR6tJUXgdqXCaHR7
	02mGX1I1v0z6m9H110EV0GkjKYyIhIKZO7/zu5N3ehFQE7WLO12RYy12NXmny9oMyxral96FxSa
	sMtabhS4By+Cs+FIsmD60c9Vtw
X-Received: by 2002:a17:90b:5486:b0:35f:c729:de9b with SMTP id 98e67ed59e1d1-36951cabdd1mr75259a91.20.1778775933929;
        Thu, 14 May 2026 09:25:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.66.174.86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951434f55sm114932a91.9.2026.05.14.09.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:25:33 -0700 (PDT)
Message-Id: <c0655e5d41012d6d11caa018d6f4b222426f2c7b.1778775928.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2089.v3.git.1778775928.gitgitgadget@gmail.com>
References: <pull.2089.v2.git.1776472347.gitgitgadget@gmail.com>
	<pull.2089.v3.git.1778775928.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 14 May 2026 16:25:27 +0000
Subject: [PATCH v3 3/4] builtin/log: prefetch necessary blobs for `git cherry`
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
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

In partial clones, `git cherry` fetches necessary blobs on-demand one
at a time, which can be very slow.  We would like to prefetch all
necessary blobs upfront.  To do so, we need to be able to first figure
out which blobs are needed.

`git cherry` does its work in a two-phase approach: first computing
header-only IDs (based on file paths and modes), then falling back to
full content-based IDs only when header-only IDs collide -- or, more
accurately, whenever the oidhash() of the header-only object_ids
collide.

patch-ids.c handles this by creating an ids->patches hashmap that has
all the data we need, but the problem is that any attempt to query the
hashmap will invoke the patch_id_neq() function on any colliding objects,
which causes the on-demand fetching.

Insert a new prefetch_cherry_blobs() function before checking for
collisions.  Use a temporary replacement on the ids->patches.cmpfn
in order to enumerate the blobs that would be needed without yet
fetching them, and then fetch them all at once, then restore the old
ids->patches.cmpfn.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/log.c     | 131 ++++++++++++++++++++++++++++++++++++++++++++++
 t/t3500-cherry.sh |  27 ++++++++++
 2 files changed, 158 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index 8c0939dd42..e464b30af4 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -21,10 +21,12 @@
 #include "color.h"
 #include "commit.h"
 #include "diff.h"
+#include "diffcore.h"
 #include "diff-merges.h"
 #include "revision.h"
 #include "log-tree.h"
 #include "oid-array.h"
+#include "oidset.h"
 #include "tag.h"
 #include "reflog-walk.h"
 #include "patch-ids.h"
@@ -43,9 +45,11 @@
 #include "utf8.h"
 
 #include "commit-reach.h"
+#include "promisor-remote.h"
 #include "range-diff.h"
 #include "tmp-objdir.h"
 #include "tree.h"
+#include "userdiff.h"
 #include "write-or-die.h"
 
 #define MAIL_DEFAULT_WRAP 72
@@ -2602,6 +2606,131 @@ static void print_commit(char sign, struct commit *commit, int verbose,
 	}
 }
 
+/*
+ * Enumerate blob OIDs from a single commit's diff, inserting them into blobs.
+ * Skips files whose userdiff driver explicitly declares binary status
+ * (drv->binary > 0), since patch-ID uses oid_to_hex() for those and
+ * never reads blob content.  Use userdiff_find_by_path() since
+ * diff_filespec_load_driver() is static in diff.c.
+ *
+ * Clean up with diff_queue_clear() (from diffcore.h).
+ */
+static void collect_diff_blob_oids(struct commit *commit,
+				   struct diff_options *opts,
+				   struct oidset *blobs)
+{
+	struct diff_queue_struct *q;
+
+	/*
+	 * Merge commits are filtered out by patch_id_defined() in patch-ids.c,
+	 * so we'll never be called with one.
+	 */
+	assert(!commit->parents || !commit->parents->next);
+
+	if (commit->parents)
+		diff_tree_oid(&commit->parents->item->object.oid,
+			      &commit->object.oid, "", opts);
+	else
+		diff_root_tree_oid(&commit->object.oid, "", opts);
+	diffcore_std(opts);
+
+	q = &diff_queued_diff;
+	for (int i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		struct userdiff_driver *drv;
+
+		/* Skip binary files */
+		drv = userdiff_find_by_path(opts->repo->index, p->one->path);
+		if (drv && drv->binary > 0)
+			continue;
+
+		if (DIFF_FILE_VALID(p->one) &&
+		    odb_read_object_info_extended(opts->repo->objects,
+						  &p->one->oid, NULL,
+						  OBJECT_INFO_FOR_PREFETCH))
+			oidset_insert(blobs, &p->one->oid);
+		if (DIFF_FILE_VALID(p->two) &&
+		    odb_read_object_info_extended(opts->repo->objects,
+						  &p->two->oid, NULL,
+						  OBJECT_INFO_FOR_PREFETCH))
+			oidset_insert(blobs, &p->two->oid);
+	}
+	diff_queue_clear(q);
+}
+
+static int always_match(const void *cmp_data UNUSED,
+			const struct hashmap_entry *entry1 UNUSED,
+			const struct hashmap_entry *entry2 UNUSED,
+			const void *keydata UNUSED)
+{
+	return 0;
+}
+
+/*
+ * Prefetch blobs for git cherry in partial clones.
+ *
+ * Called between the revision walk (which builds the head-side
+ * commit list) and the has_commit_patch_id() comparison loop.
+ *
+ * Uses a cmpfn-swap trick to avoid reading blobs: temporarily
+ * replaces the hashmap's comparison function with a trivial
+ * always-match function, so hashmap_get()/hashmap_get_next() match
+ * any entry with the same oidhash bucket.  These are the set of oids
+ * that would trigger patch_id_neq() during normal lookup and cause
+ * blobs to be read on demand, and we want to prefetch them all at
+ * once instead.
+ */
+static void prefetch_cherry_blobs(struct repository *repo,
+				  struct commit_list *list,
+				  struct patch_ids *ids)
+{
+	struct oidset blobs = OIDSET_INIT;
+	hashmap_cmp_fn original_cmpfn;
+
+	/* Exit if we're not in a partial clone */
+	if (!repo_has_promisor_remote(repo))
+		return;
+
+	/* Save original cmpfn, replace with always_match */
+	original_cmpfn = ids->patches.cmpfn;
+	ids->patches.cmpfn = always_match;
+
+	/* Find header-only collisions, gather blobs from those commits */
+	for (struct commit_list *l = list; l; l = l->next) {
+		struct commit *c = l->item;
+		bool match_found = false;
+		for (struct patch_id *cur = patch_id_iter_first(c, ids);
+		     cur;
+		     cur = patch_id_iter_next(cur, ids)) {
+			match_found = true;
+			collect_diff_blob_oids(cur->commit, &ids->diffopts,
+					       &blobs);
+		}
+		if (match_found)
+			collect_diff_blob_oids(c, &ids->diffopts, &blobs);
+	}
+
+	/* Restore original cmpfn */
+	ids->patches.cmpfn = original_cmpfn;
+
+	/* If we have any blobs to fetch, fetch them */
+	if (oidset_size(&blobs)) {
+		struct oid_array to_fetch = OID_ARRAY_INIT;
+		struct oidset_iter iter;
+		const struct object_id *oid;
+
+		oidset_iter_init(&blobs, &iter);
+		while ((oid = oidset_iter_next(&iter)))
+			oid_array_append(&to_fetch, oid);
+
+		promisor_remote_get_direct(repo, to_fetch.oid, to_fetch.nr);
+
+		oid_array_clear(&to_fetch);
+	}
+
+	oidset_clear(&blobs);
+}
+
 int cmd_cherry(int argc,
 	       const char **argv,
 	       const char *prefix,
@@ -2673,6 +2802,8 @@ int cmd_cherry(int argc,
 		commit_list_insert(commit, &list);
 	}
 
+	prefetch_cherry_blobs(the_repository, list, &ids);
+
 	for (struct commit_list *l = list; l; l = l->next) {
 		char sign = '+';
 
diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
index 78c3eac54b..3e66827d76 100755
--- a/t/t3500-cherry.sh
+++ b/t/t3500-cherry.sh
@@ -78,4 +78,31 @@ test_expect_success 'cherry ignores whitespace' '
 	test_cmp expect actual
 '
 
+# Reuse the expect file from the previous test, in a partial clone
+test_expect_success 'cherry in partial clone does bulk prefetch' '
+	test_config uploadpack.allowfilter 1 &&
+	test_config uploadpack.allowanysha1inwant 1 &&
+	test_when_finished "rm -rf copy" &&
+
+	git clone --bare --filter=blob:none file://"$(pwd)" copy &&
+	(
+		cd copy &&
+		GIT_TRACE2_EVENT="$(pwd)/trace.output" git cherry upstream-with-space feature-without-space >actual &&
+		test_cmp ../expect actual &&
+
+		grep "child_start.*fetch.negotiationAlgorithm" trace.output >fetches &&
+		test_line_count = 1 fetches &&
+		test_trace2_data promisor fetch_count 4 <trace.output &&
+
+		# A second invocation should not refetch any blobs, since
+		# the prefetch is expected to filter out OIDs that are
+		# already present locally.
+		GIT_TRACE2_EVENT="$(pwd)/trace2.output" git cherry upstream-with-space feature-without-space >actual &&
+		test_cmp ../expect actual &&
+
+		! grep "child_start.*fetch.negotiationAlgorithm" trace2.output &&
+		! grep "\"key\":\"fetch_count\"" trace2.output
+	)
+'
+
 test_done
-- 
gitgitgadget

