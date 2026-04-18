Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35576DDA9
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 00:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776472357; cv=none; b=RtxM1ZKmnA5vmlbRCBcKP8s9OxlisjukMa9UNci1vlNZpP94LNMSJfePI8HtOmj+AQmfVQ//mVDQ8bGV7fLnitts1UdDMqKH0wf21j+mHKGSUyOgwDBRyAlxRk8nWjkp111BiQad8v1+uqazfruwF1gdTK4aDikq2BS32BUEfjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776472357; c=relaxed/simple;
	bh=uEw+VB3B2RKp2TtlRTfsoEcVRtmMxRrBXdmrgZf0ZQw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CVZsrq7iT9/fRtLt3UyZcePmzvDFcfBdRjq9Qo4Mi/hbxMAlXu2/USvKLvycdNNegeNZ3UxJh91yxguGcKDYDxN9Yuulm/sYWa+mdA1egUkh3WKmYb0/RIYgl/VXMO8y/ewQ2rhhSguIDlSKlCnSHoKNkIPhG46SuSTmnSqX/Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewimmMvB; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewimmMvB"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cfc5941028so167869785a.1
        for <git@vger.kernel.org>; Fri, 17 Apr 2026 17:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776472355; x=1777077155; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpJlQw/LSIfzFUpNFt48c7I4FPK4y9eDv8L3ATbYBvw=;
        b=ewimmMvB48+1d+ZUwUVhAtu9fajiZjVehHElUfkKIHs1H4X89tELxnLeozvTD7daM9
         r+3R+9PMokcAq0uLX4a1fvBC2oCW5jnpRjmiK+ms7nEzFSwUgyxYeAWjaNg7UBDs75Yt
         m8OT1vvsPNJTMLTPZC9SWf1cuX22JlTAv7MfHBjSTVwiXJXTUnZGxW9PbMdCBm7D/U/R
         bx1Ng2Q6Q1xeiROIksNrxrB7JLgUHOZZtGba4L34WUkId/bbhkB0GZ0niHAdDkJTKxZI
         CX8zuYPqdXvJTEzOQZ3kilFuwf1N3+CNbTI/jgnv+bj5JBIRpmAr4Vu+LV3GMwvus6ik
         Utqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776472355; x=1777077155;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MpJlQw/LSIfzFUpNFt48c7I4FPK4y9eDv8L3ATbYBvw=;
        b=OPO+/BY3X3uOMrTPx8ApmzVsq/3jX4Uuo4TytHDuCJEvlopVY47Ru9Waz2frg/CdQq
         L89pJxDDLp/SdnXjNIbueHf26nEr6hrt8+LK5jL6lGKfeBtyUJxN8zq5YnAjLF6lBGQn
         vuPcwguDcgBXPX/y1hFSVh+7ogXfduDgsOHVCa6JXqEAH1HHMXe9MLelRbaixnUA5LVb
         wW6g+mjYApjmKY912HMrvUk16Cx14XsGgHubG33GQ6JHN2ezm33Vt5k17D9pg1k/XZ6z
         chK9T0KJ+gl8aciAmlMwjLvyHqrmNgsCTJEfsHYidnpJZPLg9qBEIi/4I9f9jYcS5NCu
         eFsA==
X-Gm-Message-State: AOJu0YxvKwB8cMlxPwPWdCbU9G1JZpWYxHDU2Vap2Kpb3e1Xu5+TQG9z
	Py1yf3u3cbl90iffwYtDXDf/ByYgfGR0jtGsYtlu1nKdGHQ+Ct8GzMkyFkMZuQ==
X-Gm-Gg: AeBDietIdFV+T8qxUgrqPLM+ERZseCOLdoWK8Ni38077/4lflXcd1BS83YgiogBOY/c
	GUzAMwDqJLYhDE7yefW2fAEcgTXKZmsluXvBycX8gmQJ0T46PQpKflHy1VagKckcSjIsS1UU/ge
	dharVesmWFgGuK87pZsU7hdXWtnBrgoO07dmk09UKCcFXuSvMTfO7XlqKaoqDoBuFZQtuKIqKpf
	goJvfY50rp+5QoPZ+DGHWeRB3/8k5p4bx0bHDb9IAYSNM8qQxH+43TFZWemRe13uNPiUDa+qZZl
	hd85zFIlxxE1Jow9Li0+dI3Z34Vpg5TpzQY4yxrT3I1IGsbGFFDAM1oobnSOjc5cFaosJLKRf5m
	OJvtFlgcJxx2IlWnWs+lxRvcuiNYcH3r0EZ/IRQOKY0pWKK7P4pDM9YH/QVtQFQ1pn+QnxPf3sg
	Cb26IWOYQO2oE2Xr+K453JAv9HiA+f7TzKFTIz8z/2hZlg+g4LDQ==
X-Received: by 2002:a05:620a:4512:b0:8cd:8569:b945 with SMTP id af79cd13be357-8e78f0597d0mr725643085a.13.1776472354684;
        Fri, 17 Apr 2026 17:32:34 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.177.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d69ad48asm221439285a.19.2026.04.17.17.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 17:32:33 -0700 (PDT)
Message-Id: <a705852723fbe88e94ad3de1daba548dbce32211.1776472347.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2089.v2.git.1776472347.gitgitgadget@gmail.com>
References: <pull.2089.git.1776379694.gitgitgadget@gmail.com>
	<pull.2089.v2.git.1776472347.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 18 Apr 2026 00:32:26 +0000
Subject: [PATCH v2 2/3] builtin/log: prefetch necessary blobs for `git cherry`
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
 builtin/log.c     | 125 ++++++++++++++++++++++++++++++++++++++++++++++
 t/t3500-cherry.sh |  18 +++++++
 2 files changed, 143 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index 8c0939dd42..df19876be6 100644
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
@@ -2602,6 +2606,125 @@ static void print_commit(char sign, struct commit *commit, int verbose,
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
+		if (DIFF_FILE_VALID(p->one))
+			oidset_insert(blobs, &p->one->oid);
+		if (DIFF_FILE_VALID(p->two))
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
@@ -2673,6 +2796,8 @@ int cmd_cherry(int argc,
 		commit_list_insert(commit, &list);
 	}
 
+	prefetch_cherry_blobs(the_repository, list, &ids);
+
 	for (struct commit_list *l = list; l; l = l->next) {
 		char sign = '+';
 
diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
index 78c3eac54b..17507d9a28 100755
--- a/t/t3500-cherry.sh
+++ b/t/t3500-cherry.sh
@@ -78,4 +78,22 @@ test_expect_success 'cherry ignores whitespace' '
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
+		test_trace2_data promisor fetch_count 4 <trace.output
+	)
+'
+
 test_done
-- 
gitgitgadget

