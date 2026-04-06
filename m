Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA6E221F1F
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775482057; cv=none; b=qttWdlSg1K9rrRU4Oz0MmQZG64Il7rGY89iFTHrHw/InjwoesH0LPmrS7dazixGdcm1RuStKFS8wFDR/q/fOemGIhXkSYuD+tpZv0Gl7JXdtny9IcpZCm3lDZh+clBeetAS6HmIGwSz2gczltqz8IVur6x1MtoLfjWTtJKIagjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775482057; c=relaxed/simple;
	bh=RUfsKTkn6jBEnQSpTU7IXI+wzTB487bhXFrwP6tGwZs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=G7Qk4cdS5UKCAnxbQyq7vPZGFq85JrP3yKy9NQjt8gKOziZKd7pU7v/lSAzXz0vuDoGMUoT43A1fiJewGHwWlzoaW6NsD73Ob7SpX0DoDmn6spwhIPs+mtyKaiLYyuMlaC9QE4a4CziGkBat7zY2p5yAg3Ggr7DuDezad3gadB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVoo/bFb; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVoo/bFb"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8a58057d7baso61830526d6.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 06:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775482055; x=1776086855; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1hKjjcnWESRBjqrX2YuRpZaaLYeUmsdo46b3bJjtWs=;
        b=CVoo/bFbpInEccoIVUvGEQftKkYRVHefMVBfdLss6s162wowEd/jG3XHNPCSXnuTZs
         7fGvzMYFo+cBRv0JuH44RyeQZiAzn91W489caA9Fe+mKRIDodDITZQR77QDwcRrrbN69
         6fcvSflsBbRxdqxXoUbZjiJ776oMk4C5cRxQyGBzIPgwB40CbHkFwuSv5GsYqkrpqiI/
         SutUtXLpsKk+T9emr8LE9HWyN9J/vxe9RL6XXv8xDRwe2KnK9F3FFqIXA3UIZKo56flq
         G94BOHDqXaa73FrKRj2LC1Q8c8ZJT76KZPoR8WfuBljA2hmqdsinkngGhObTney6h1yX
         IIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775482055; x=1776086855;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O1hKjjcnWESRBjqrX2YuRpZaaLYeUmsdo46b3bJjtWs=;
        b=AHO35zNP6XMMvpx/+1gEY8nru3QK1kqaWoIvpz1C5iuYt55pwFnZqwkM68n1w2Tsp7
         8g2ua/e7VP0ayXEhxKKkG0gCrFkc5QzAk0a1/l1E3SSDhiFv6Q8JPu+3KRkci66/2Nyf
         ajH3WufYNompqrJ91WoIUlwESLcLwelxbkNc40Qef4pWTIAyuJY9Gatiu5zBq6nR7F16
         EFrxL3dRDEcU0HTf0QoLJIb2kj+zpdHSnup5ncI4yN1X/xA/z/C5JPI1RzWsMRpJbHJj
         2k6Z1QMW5dhEdIEwTMNpXgK06+xivURA6WlVMtvj08oJtQr/U2uDlysv3kUSmvHfOHhl
         2Jrg==
X-Gm-Message-State: AOJu0YyhCq1Kl6XqV4gVnPtCd4aYrIVitvvX+kqSJHpgO84UDa12IO/U
	xIomlMUHcRsPxDDmZZ5nM19IJ4a9kwF5knnf/v1ct6MU0ZIOWs4kfz+PN9hLCuL3
X-Gm-Gg: AeBDietRVcqAMVjUSLRR1iHrkJeuJDWcH3y7QtZJ17vcg9QUsoNz3XfWJSpliMgtYv9
	kVDDqZmri+zahNFLtNgde5ftcOnKWmUtOt/Gk7+d2zLYnqSP4Pg6umJsLQoMZOV4gmEwc2FyWth
	y2S9fKy9ooMvgrD34fR25j1RmmCIk/x0X9kv5pJ4PXi4gZW35qrS13msbEQXUzS+Uc80CB/K8gb
	hIOhymFr/yX5CJmdZjqg2eg3LuZY775u9kXrcDlnBa04o/VCCjyS9ogpoR3TuFajwf+RQ4rAb9x
	fECKbTq+3xILgj1eRZXTf65zHQLCOJXo0nlY1F++IOayOcrBTFOBNqMVfoTaqF2IewDyX5i7cAZ
	Zl3WwPO7l7/LoB99JqbwQm2aBF6a9CTThQqqYh0NpgnOZylV5S/BqzSsOgtqUwBQHcg0afijjE2
	HoZl6Y518xiQQwHE/ScCbmFUVnq3A=
X-Received: by 2002:a05:6214:2b0c:b0:89c:5c84:36 with SMTP id 6a1803df08f44-8a7025b7036mr209449796d6.14.1775482054543;
        Mon, 06 Apr 2026 06:27:34 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.251.100])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5933333d0sm138462326d6.1.2026.04.06.06.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 06:27:33 -0700 (PDT)
Message-Id: <0bdb88c85eabfa88b97c83a8f20f76cb8ed0489d.1775482048.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2082.git.1775482048.gitgitgadget@gmail.com>
References: <pull.2082.git.1775482048.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Apr 2026 13:27:28 +0000
Subject: [PATCH 3/3] rev-list: use reduce_heads() for --maximal-only
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
Cc: gitster@pobox.com,
    j6t@kdbg.org,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The 'git rev-list --maximal-only' option filters the output to only
independent commits. A commit is independent if it is not reachable from
other listed commits. Currently this is implemented by doing a full
revision walk and marking parents with CHILD_VISITED to skip non-maximal
commits.

The 'git merge-base --independent' command computes the same result
using reduce_heads(), which uses the more efficient remove_redundant()
algorithm. This is significantly faster because it avoids walking the
entire commit graph.

Add a fast path in rev-list that detects when --maximal-only is the only
interesting option and all input commits are positive (no revision
ranges). In this case, use reduce_heads() directly instead of doing a
full revision walk.

In order to preserve the rest of the output filtering, this computation
is done opportunistically in a new prepare_maximal_independent() method
when possible. If successful, it populates revs->commits with the list
of independent commits and set revs->no_walk to prevent any other walk
from occurring. This allows us to have any custom output be handled
using the existing output code hidden inside
traverse_commit_list_filtered(). A new test is added to demonstrate that
this output is preserved.

The fast path is only used when no other flags complicate the walk or
output format: no UNINTERESTING commits, no limiting options (max-count,
age filters, path filters, grep filters), no output formatting beyond
plain OIDs, and no object listing flags.

Running the p6011 performance test for my copy of git.git, I see the
following improvement with this change:

  Test                                     HEAD~1  HEAD
  ------------------------------------------------------------
  6011.2: merge-base --independent          0.03   0.03 +0.0%
  6011.3: rev-list --maximal-only           0.06   0.03 -50.0%
  6011.4: rev-list --maximal-only --since   0.06   0.06 +0.0%

And for a fresh clone of the Linux kernel repository, I see:

  Test                                     HEAD~1  HEAD
  ------------------------------------------------------------
  6011.2: merge-base --independent          0.00   0.00 =
  6011.3: rev-list --maximal-only           0.70   0.00 -100.0%
  6011.4: rev-list --maximal-only --since   0.70   0.70 +0.0%

In both cases, the performance is indeed matching the behavior of 'git
merge-base --independent', as expected.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/rev-list.c       | 59 ++++++++++++++++++++++++++++++++++++++++
 t/t6000-rev-list-misc.sh | 31 +++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 854d82ece3..8f63003709 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -25,6 +25,7 @@
 #include "oidset.h"
 #include "oidmap.h"
 #include "packfile.h"
+#include "commit-reach.h"
 #include "quote.h"
 #include "strbuf.h"
 
@@ -633,6 +634,61 @@ static int try_bitmap_disk_usage(struct rev_info *revs,
 	return 0;
 }
 
+/*
+ * If revs->maximal_only is set and no other walk modifiers are provided,
+ * run a faster computation to filter the independent commits and prepare
+ * them for output. Set revs->no_walk to prevent later walking.
+ *
+ * If this algorithm doesn't apply, then no changes are made to revs.
+ */
+static void prepare_maximal_independent(struct rev_info *revs)
+{
+	struct commit_list *c;
+
+	if (!revs->maximal_only)
+		return;
+
+	for (c = revs->commits; c; c = c->next) {
+		if (c->item->object.flags & UNINTERESTING)
+			return;
+	}
+
+	if (revs->limited ||
+	    revs->topo_order ||
+	    revs->first_parent_only ||
+	    revs->reverse ||
+	    revs->max_count >= 0 ||
+	    revs->skip_count >= 0 ||
+	    revs->min_age != (timestamp_t)-1 ||
+	    revs->max_age != (timestamp_t)-1 ||
+	    revs->min_parents > 0 ||
+	    revs->max_parents >= 0 ||
+	    revs->prune_data.nr ||
+	    revs->count ||
+	    revs->left_right ||
+	    revs->boundary ||
+	    revs->tag_objects ||
+	    revs->tree_objects ||
+	    revs->blob_objects ||
+	    revs->filter.choice ||
+	    revs->reflog_info ||
+	    revs->diff ||
+	    revs->grep_filter.pattern_list ||
+	    revs->grep_filter.header_list ||
+	    revs->verbose_header ||
+	    revs->print_parents ||
+	    revs->edge_hint ||
+	    revs->unpacked ||
+	    revs->no_kept_objects ||
+	    revs->line_level_traverse)
+		return;
+
+	reduce_heads_replace(&revs->commits);
+
+	/* Modify 'revs' to only output this commit list. */
+	revs->no_walk = 1;
+}
+
 int cmd_rev_list(int argc,
 		 const char **argv,
 		 const char *prefix,
@@ -875,6 +931,9 @@ int cmd_rev_list(int argc,
 
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
+
+	prepare_maximal_independent(&revs);
+
 	if (revs.tree_objects)
 		mark_edges_uninteresting(&revs, show_edge, 0);
 
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index d0a2a86610..a95ba576fa 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -263,4 +263,35 @@ test_expect_success 'rev-list --boundary incompatible with --maximal-only' '
 	test_grep "cannot be used together" err
 '
 
+test_expect_success 'rev-list --maximal-only and --pretty' '
+	test_when_finished rm -rf repo &&
+
+	git init repo &&
+	test_commit -C repo 1 &&
+	oid1=$(git -C repo rev-parse HEAD) &&
+	test_commit -C repo 2 &&
+	oid2=$(git -C repo rev-parse HEAD) &&
+	git -C repo checkout --detach HEAD~1 &&
+	test_commit -C repo 3 &&
+	oid3=$(git -C repo rev-parse HEAD) &&
+
+	cat >expect <<-EOF &&
+	commit $oid3
+	$oid3
+	commit $oid2
+	$oid2
+	EOF
+
+	git -C repo rev-list --pretty="%H" --maximal-only $oid1 $oid2 $oid3 >out &&
+	test_cmp expect out &&
+
+	cat >expect <<-EOF &&
+	$oid3
+	$oid2
+	EOF
+
+	git -C repo log --pretty="%H" --maximal-only $oid1 $oid2 $oid3 >out &&
+	test_cmp expect out
+'
+
 test_done
-- 
gitgitgadget
