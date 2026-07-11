Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827AC3C2B95
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 13:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783776484; cv=none; b=VOr5jNMEIZi3O3kQcAjbUHDU2602PDs3dL+fO4o5u4QmMaZIvIsd5KCTFMgG7VyAObsFBJvj8kwD+6RNSl2hpPH16M/USBLyN6XJRFkcRyTHy3qL0ivS3JCJkmTsMbQPCqZRfUvZICgDOE/Q9KHAx5ttT94yDXH3tNU0LW9uZA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783776484; c=relaxed/simple;
	bh=0+WssLuoWASFEKFDgScKEC/8Bx5eaTKNGaVYeytXCCI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ae1LLCw1O+yAeUMiz6YD/JYxhZbYTfGQekspCHLIB088UiCK3/il48d9GQ4K1BCa3mvvbk2zv/ukLanCtJyn4+fY4OEXLdDnj1xvZZvB+dSqH2kwolt/p9qbFI2j8GLxmFx2AqX2YFLuri/OJIoaao8xcQn7e4q9fs5oreUb220=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9ZV7gwr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9ZV7gwr"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so29304765ad.2
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 06:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783776482; x=1784381282; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PdAYApUwskKTp5isWyj7neMvs5zQhF7CkkSEcEPCito=;
        b=N9ZV7gwrNpH+cjQGxXD6c094ooWmR6j5O+UL52esZFooMkJo6sRRIWfB99oJ7oKe/L
         di5XbYgv77MhoRBnMO6TBoBXVjYE5mbsHbLIVn3hBf+e69OESszdbpcDK7BhBjG99MqT
         nIAGuUlq6i4s84MzS2tVbgqiNUy/esLtt6wo3DXWm0qhTWc9bV7Ti+sQPaXQ6AUbovYa
         0xeHQuiF/HRfC1aFSLzJ992OVDKeqi2/nQ1mGEJAhhlPjo+IUUqk2MBpLEApjAhepKdX
         Vw0Ucwq8DOrdf7Nj9KgURwFOGMB4Koh6y+koFtGqhGjn9OgEoFGu1xEPse45WpC4eSVz
         KYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783776482; x=1784381282;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PdAYApUwskKTp5isWyj7neMvs5zQhF7CkkSEcEPCito=;
        b=EJl7BRw14TuO38p4PI8PFU/vnxY4NycxkBRLtEZFd9Ni8NyDkccuwf+y8aNL4BlJUh
         Xe8jaN23gu5YlBfpPEsGdxyZzU2+aZ1kKf8aYettCrGk4NDDThTUoidaxAITCyWTDVAS
         6W8nXXpVHB1YkSzC7i+Nu0g4Gkx65U3HvcXc61pkLYrNkHbwk9aSWJkHgm2BxmxOt0D9
         r3XKai2qEsgWcQri+hLdzmmpnvcyZ7dRItGTFOiU/2GjAVVezPP8h0XbzZdpt6C6k5uy
         kaBDEPucH3msUNFddIYEstSW5yElOhge+wefRuQfDeke5zIKKP5LG1RaT4j/03WmkLqA
         qxwA==
X-Gm-Message-State: AOJu0YzHbP3TtFfkA7A0/ScNShHaIAUHtkUyjc3cKfrPnu5/NarmvaID
	0wdU3XFO/OzTJwkwym+gcAoplDeBgfbdQdckX8nxx7tnawkRO84ysP5kIWgXfg==
X-Gm-Gg: AfdE7cnyw1mf3juOjVjhKMEMliGym8loCwuL67TqRbzbNJBK8GWTGdv655WkY7+BwJQ
	TpbcSRPi3fExSr/KtbfEkNhjyNKfmYBcYIkzERMNpbmCb3RwepP+9BpjXufa8whK5KziRrCupR1
	8T0r3AyIx5C3f0mo9dEKGdyXe3GDtnorXhU1jR6xY8ltEDOpHfZMZ6qkZ6FyxBr61KpQtGMitXG
	D/bjhivZcR2NTMRRchO7RwZqAk63g6wOrvJXOW/vOTnB7YQFPI4lInMUoIcquFvI4uzys9mcDzN
	FmkcDXCESt5DRfHfBBAksB185ProLl/DXAF0tn+4YytaKSGNp9kB0zW9QjpTbQPlEaEJkpE1Tg3
	iNDVffizBJnYu5nZuoJwu/ZhpGdLJ9sHu1mABuxQW4vkC1PgA0Xtbwsj/rIJ0mPSS6L+L36WbVB
	cVndQbmgq8iUf/NSE=
X-Received: by 2002:a17:90b:4ed0:b0:37f:bfd6:8b40 with SMTP id 98e67ed59e1d1-38dc74c25d3mr2796735a91.5.1783776481822;
        Sat, 11 Jul 2026 06:28:01 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.76.184])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311a6115e61sm31872868eec.22.2026.07.11.06.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 06:28:00 -0700 (PDT)
Message-Id: <171b3cd3ae13f8dee724530b89f64c46ddbb3906.1783776466.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v6.git.1783776466.gitgitgadget@gmail.com>
References: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
	<pull.2149.v6.git.1783776466.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 11 Jul 2026 13:27:41 +0000
Subject: [PATCH v6 06/10] t6600: add clock-skew topologies and step counts for
 edge cases
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
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Add topologies and tests exercising paint_down_to_common() under
clock skew, where commit-date ordering (v1 commit-graph without
corrected commit dates) violates the topological invariant that
children are dequeued before parents:

 - se-*: side-exhaustion fires too early when one paint side fully
   drains from the queue while a low-date ancestor on the other
   side is still queued

 - se2-*: side-exhaustion returns a too-deep merge base because
   the correct (closer) base never receives both paint sides

Also add step counts to the edge-case tests from the previous
commit, a mixed finite/INFINITY generation topology exercising
the transition from INFINITY-generation commits to graph-backed
commits, and step counts for the grid-based merge-base test.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 t/t6600-test-reach.sh | 98 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 2 deletions(-)

diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 45aa26cd44..55aa220bb3 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -140,6 +140,48 @@ test_expect_success 'setup' '
 	git branch -f pi-X-br "$pi_x" &&
 	git tag pi-X "$pi_x" &&
 
+	# Clock-skew topology for side-exhaustion testing.
+	# D is the correct merge base but has a higher committer date
+	# than C (its child).  With date ordering, D would be dequeued
+	# before C, causing side-exhaustion to fire too early.
+	# Generation ordering prevents this by visiting children
+	# before parents regardless of dates.
+	#
+	#   se-A (date 7000) --> se-C (date 3000) --> se-D (date 5000) --> se-root (date 4000)
+	#   se-B (date 6000) --> se-D
+	#
+	se_root=$(skew_commit 4000 se-root) &&
+	se_D=$(skew_commit 5000 se-D -p "$se_root") &&
+	se_C=$(skew_commit 3000 se-C -p "$se_D") &&
+	se_A=$(skew_commit 7000 se-A -p "$se_C") &&
+	se_B=$(skew_commit 6000 se-B -p "$se_D") &&
+	git branch -f se-A "$se_A" &&
+	git branch -f se-B "$se_B" &&
+	git tag se-D "$se_D" &&
+
+	# Clock-skew topology with redundant ancestor for
+	# side-exhaustion testing.  MB1 is the correct merge base;
+	# MB2 is its parent.  A reaches MB2 via E (high date) and
+	# MB1 via C (low date).  B reaches MB1 via D.  With date
+	# ordering, side-exhaustion would fire before C is dequeued,
+	# missing MB1.  Generation ordering ensures both are found.
+	#
+	#   se2-A (date 8000) --> se2-C (date 2000) --> se2-MB1 (date 5000) --> se2-MB2 (date 4000) --> se2-root (date 1000)
+	#   se2-A              --> se2-E (date 6500) --> se2-MB2
+	#   se2-B (date 7000) --> se2-D (date 6000) --> se2-MB1
+	#
+	se2_root=$(skew_commit 1000 se2-root) &&
+	se2_MB2=$(skew_commit 4000 se2-MB2 -p "$se2_root") &&
+	se2_MB1=$(skew_commit 5000 se2-MB1 -p "$se2_MB2") &&
+	se2_C=$(skew_commit 2000 se2-C -p "$se2_MB1") &&
+	se2_D=$(skew_commit 6000 se2-D -p "$se2_MB1") &&
+	se2_E=$(skew_commit 6500 se2-E -p "$se2_MB2") &&
+	se2_A=$(skew_commit 8000 se2-A -p "$se2_C" -p "$se2_E") &&
+	se2_B=$(skew_commit 7000 se2-B -p "$se2_D") &&
+	git branch -f se2-A "$se2_A" &&
+	git branch -f se2-B "$se2_B" &&
+	git tag se2-MB1 "$se2_MB1" &&
+
 	git commit-graph write --reachable &&
 	mv .git/objects/info/commit-graph commit-graph-full &&
 	chmod u+w commit-graph-full &&
@@ -323,7 +365,8 @@ test_expect_success 'get_merge_bases_many:pending-stale' '
 		echo "get_merge_bases_many(A,X):" &&
 		git rev-parse ps-B
 	} >expect &&
-	test_all_modes get_merge_bases_many
+	test_all_modes get_merge_bases_many &&
+	test_paint_down_steps 6 6 6 6
 '
 
 test_expect_success 'get_merge_bases_many:infinity-both-sides' '
@@ -337,7 +380,34 @@ test_expect_success 'get_merge_bases_many:infinity-both-sides' '
 		echo "get_merge_bases_many(A,X):" &&
 		git rev-parse pi-B
 	} >expect &&
-	test_all_modes get_merge_bases_many
+	test_all_modes get_merge_bases_many &&
+	test_paint_down_steps 5 5 5 5
+'
+
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
+	test_all_modes get_merge_bases_many &&
+	test_paint_down_steps 3 3 3 3
 '
 
 test_expect_success 'merge-base --all commit-walk steps' '
@@ -347,6 +417,30 @@ test_expect_success 'merge-base --all commit-walk steps' '
 	test_paint_down_steps 81 80 81 81
 '
 
+test_expect_success 'merge-base --all with clock skew (side-exhaustion)' '
+	# Verify correct merge base under clock skew.  se-D (the
+	# merge base) has a higher date than its child se-C.
+	# Generation ordering ensures se-C is visited before se-D,
+	# so P1 paint propagates correctly and se-D is found.
+	>input &&
+	git rev-parse se-D >expect &&
+	run_all_modes git merge-base --all se-A se-B &&
+	test_paint_down_steps 6 4 6 6
+'
+
+test_expect_success 'merge-base --all with clock skew and redundant ancestor (side-exhaustion)' '
+	# Verify correct merge base when clock skew could cause a
+	# too-deep result.  MB1 is the correct merge base; MB2 is
+	# its ancestor.  A reaches MB2 via E (high date) and MB1
+	# via C (low date).  Generation ordering ensures C is
+	# visited before side-exhaustion fires, so MB1 is found
+	# and remove_redundant correctly discards MB2.
+	>input &&
+	git rev-parse se2-MB1 >expect &&
+	run_all_modes git merge-base --all se2-A se2-B &&
+	test_paint_down_steps 8 7 8 8
+'
+
 test_expect_success 'reduce_heads' '
 	cat >input <<-\EOF &&
 	X:commit-1-10
-- 
gitgitgadget

