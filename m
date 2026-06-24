Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0782D94B5
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 12:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782303263; cv=none; b=nWvwm+jK5VEobiZ3Knw2bqfC6BnpueG3g2Fq1odVt0SA8pCUqVTviALOe7mOSk6qE7WlMOWURU7BPzPY33PSyHP49OnTRZ/bSKJqQwQADoV1Ks9mkhFLkKH7LyjWH6znpjn9wFNFUNOnTNE/yij5wEnOA+DEXwN7PI7in+7AQAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782303263; c=relaxed/simple;
	bh=O/jFhhQAvZl6kF2mI7b0UmvH9wKo5GsFXphU3ScIF5o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=exDkCQ6DYYgu7MLG38apYHUO5wKUoDPpXP+0zTcRQIVZvYxH3lbeS1Zph1a3La4wEwHgN5CRM9jt4FBOI7rB6LX3yrgYklapiiODFC5+WMwpuz5Fbx/blX5tfV34HuSdVxozNiqGEM174Wj8snMR+WekXpfFkMzIYvyo4W+QOlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8y0udPH; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8y0udPH"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-519f6a10d9bso5968101cf.3
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 05:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782303261; x=1782908061; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4CEdaL3wXcEP1AlcWsuZJDb3C13fQEZwrdmqLsOhBo=;
        b=Q8y0udPHnteDCKXaUw4HVwwWzK5BRnyeXixY1xOnmCG03E1BKtVB/xgpUtdtpVvV9A
         pXULq4XPUBt4FjnqaoJ1633AKLCDtd3R6AGKU2Jfmkgpe9ZrSW/k6It3KkbUfJhkjc3K
         88sriG858vs1yT/lnq3qnk3quzcyggPtrOHuHct5p030n7Nj3CK3jJNNTbMmYG212y7V
         GSXglG+qGa9wXONFdyQC7mnKB0oMrEPFWw0t0XvXLbLL3f1lYiKK3NEY9c5jb0Cqk6Kk
         XxqbTX2p/yQSv/3tMovQhnEnPIgnrhkUEnQ+qyzjcNkKGRwXGhLqPJiBuxT509kOi5ny
         6u8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782303261; x=1782908061;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y4CEdaL3wXcEP1AlcWsuZJDb3C13fQEZwrdmqLsOhBo=;
        b=CnapmzC7AkaGPs2GbN3Dg2iVTvy/DZCg4R4ZOYDB/Gu1TvXGzaSz/eStjBMRA5jz0k
         /km3dqAHidAEg1pM/viEPNg4Fx/rDOW5uEQPXVWDQ9WQLU+Bnsyx+dkqR9wtwoaf1fXN
         FVAInxYiCRSBCzSqKxGvHIhjf7hyNq6YxL+gbgyaK1SZRsTzeeAS+bvEiJA/zV5csZWy
         UUfROdlDS3G4dkS4kPu+7aVtK3wycGJ6ndSBuLEUJ7sM0gKwUdZlk7UsCxdY9iQ8aaVa
         60sqOeCTvTslPh4Z6IIm3ZsNNGgVyfmeRloK8jruroe+Gd8PRBJ7W/cVzjC58S2EB4kT
         v4kQ==
X-Gm-Message-State: AOJu0Yz84DDXLxN2gTx7LmjrK+UJp9mWvplDHs5AM9LQ3eX9NMuNznVF
	wSL/K9UYmONG+wnQaHpJI3NtBHnnibzVhW7EVo6zDx+AIQYm/O4CpPeHvQSlCNZd
X-Gm-Gg: AfdE7ck4YrIGo194YcI5/bBNBFrNurum+EdmkygXQx6oa6T/Iy5uNeWhSfl969OFX1q
	mqeXwb1v9ylzDfCr9secewEaHvFfSGVwEGlID2ONK8C2sljChWWIV2URdia8junFYoeeLvbWLdE
	+lVCzrdv5v5JkAvGE+WvoOZze5qEVTfGzsQiqUe5xt/HLVX/3b1dDAxrQsJP/sGCMKR+eqf89oY
	ICySbJwt/4f2qHHuwrVTOpAogz+6No1XHB84InkymsJCpiOgmgHa1fP53Vbz+WDIQzgJ0T4hV+F
	tglHz7B2McYO+IS4J/tB1KGcBb/B4zT+TCwXMrJj+Kmx092ABM6DHZPZBRPsPaIRkZ3xiV1c91g
	HQJ4aJDQ1af9i7rhfE7pt5aX1TlsjRZA87E6QRn/StrfkBzCFA6sOMmmsEW0osaJm8qAVXeAIL6
	WJuVGzSqNvi/mq3Fs=
X-Received: by 2002:ac8:58d4:0:b0:517:899b:7f76 with SMTP id d75a77b69052e-51a61ed61bbmr40691651cf.35.1782303260987;
        Wed, 24 Jun 2026 05:14:20 -0700 (PDT)
Received: from [127.0.0.1] ([40.116.92.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a51ae79e9sm45808841cf.25.2026.06.24.05.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 05:14:20 -0700 (PDT)
Message-Id: <90f09ecb5cd2141621d8f203189b976a20f6128b.1782303254.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jun 2026 12:14:09 +0000
Subject: [PATCH v2 3/7] t6099, t6600: add side-exhaustion regression tests
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Add t6099 to test the case where multiple merge-base candidates exist
and one is an ancestor of another. This exercises the side-exhaustion
optimization in paint_down_to_common together with the
remove_redundant safety net in get_merge_bases_many_0.

Add a mixed finite/INFINITY test to t6600 where one tip is outside
the commit-graph (INFINITY generation) and the other is inside.
This exercises the region transition: the walk starts in the
INFINITY region where side-exhaustion is disabled, then crosses
into the finite region where it can fire.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 t/meson.build                         |  1 +
 t/t6099-merge-base-side-exhaustion.sh | 82 +++++++++++++++++++++++++++
 t/t6600-test-reach.sh                 | 25 ++++++++
 3 files changed, 108 insertions(+)
 create mode 100755 t/t6099-merge-base-side-exhaustion.sh

diff --git a/t/meson.build b/t/meson.build
index 3219264fe7..ee6ebdffb9 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -786,6 +786,7 @@ integration_tests = [
   't6041-bisect-submodule.sh',
   't6050-replace.sh',
   't6060-merge-index.sh',
+  't6099-merge-base-side-exhaustion.sh',
   't6100-rev-list-in-order.sh',
   't6101-rev-parse-parents.sh',
   't6102-rev-list-unexpected-objects.sh',
diff --git a/t/t6099-merge-base-side-exhaustion.sh b/t/t6099-merge-base-side-exhaustion.sh
new file mode 100755
index 0000000000..4f1e0d50ef
--- /dev/null
+++ b/t/t6099-merge-base-side-exhaustion.sh
@@ -0,0 +1,82 @@
+#!/bin/sh
+
+test_description='merge-base with ancestor among merge-base candidates
+
+Test that merge-base --all correctly handles cases where
+multiple merge-base candidates exist and one is an ancestor
+of another. The side-exhaustion optimization in
+paint_down_to_common may exit before STALE propagation
+removes the ancestor, but remove_redundant catches it.
+
+Graph shape (parents are below children):
+
+   A ----------- X
+   |\           /|
+   | B---------/ |
+   | |           |
+   e2 \         f2
+   |   |         |
+   e1 d1        f1
+    \  |        /
+     \ |       /
+      \|      /
+       C
+
+A and X are the two tips.
+B and C are both reachable from A and X.
+B reaches C through d1.
+Only B should appear in merge-base --all output.
+'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success 'setup ancestor merge-base candidate' '
+	test_commit C &&
+
+	git checkout -b d-chain HEAD &&
+	test_commit d1 &&
+	test_commit B &&
+
+	git checkout -b e-path C &&
+	test_commit e1 &&
+	test_commit e2 &&
+
+	git checkout -b f-path C &&
+	test_commit f1 &&
+	test_commit f2 &&
+
+	git checkout -b branch-A e-path &&
+	test_merge A B &&
+
+	git checkout -b branch-X f-path &&
+	test_merge X B &&
+
+	git commit-graph write --reachable
+'
+
+test_expect_success 'merge-base --all excludes ancestor candidate' '
+	git rev-parse B >expected &&
+	git merge-base --all A X >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'merge-base (single) finds shallowest' '
+	git rev-parse B >expected &&
+	git merge-base A X >actual &&
+	test_cmp expected actual
+'
+
+# Without commit-graph: generation numbers are INFINITY,
+# side-exhaustion optimization does not fire.
+test_expect_success 'merge-base --all without commit-graph' '
+	rm -f .git/objects/info/commit-graph &&
+	git rev-parse B >expected &&
+	git merge-base --all A X >actual &&
+	test_cmp expected actual
+'
+
+test_done
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index c2e091aad1..4b771b4c58 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -294,6 +294,31 @@ test_expect_success 'get_merge_bases_many:infinity-both-sides' '
 	test_all_modes get_merge_bases_many
 '
 
+test_expect_success 'setup mixed finite/INFINITY topology' '
+	# Create a commit outside all saved commit-graph files so it always
+	# has INFINITY generation, while its parent (ps-X) is in the graph
+	# with a finite generation. Use the ps-* orphan topology so we do
+	# not pollute the grid-based rev-list tests.
+	git checkout ps-X &&
+	test_env GIT_TEST_COMMIT_GRAPH= test_commit pm-INF
+'
+
+test_expect_success 'get_merge_bases_many:mixed-finite-infinity' '
+	# One tip (pm-INF) is outside the commit-graph with INFINITY
+	# generation; the other (ps-B) is in the graph with finite
+	# generation. The walk starts in the INFINITY region and crosses
+	# into the finite region where side-exhaustion can fire.
+	cat >input <<-\EOF &&
+	A:pm-INF
+	X:ps-B
+	EOF
+	{
+		echo "get_merge_bases_many(A,X):" &&
+		git rev-parse ps-X
+	} >expect &&
+	test_all_modes get_merge_bases_many
+'
+
 test_expect_success 'reduce_heads' '
 	cat >input <<-\EOF &&
 	X:commit-1-10
-- 
gitgitgadget

