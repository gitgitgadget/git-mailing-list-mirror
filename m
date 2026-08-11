Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1964E429816
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440545; cv=none; b=Aqb7zzp5IUkeYSB82Vdo7jX/UmjzpRHeoWQWsFaM+pomX4eOBlVgeTyRinBiZJQacSROgCFYAmFuO1YvqUkspmYAjJsWesk9f2UHnAs0rB6irVI/nFPCpUNYZqS0PsN+IO+c0PpD2Bvq2LtJ+O/Qx5BENgGw6KaO8piSaMkc508=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440545; c=relaxed/simple;
	bh=dhimGDUEOGl20fhsNcxks2IppoTbk8BpnJZXXRsdD2o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dKKBHbzfZXWeg/sQ998rG2lPEBjZrJOvEkG2msS3xjWz8fwMpsRnWV7VeuQhK62wHJuBn4COgU4YyWEE7yjlr4nCGG5Q2becHHW3BU2XyPkZ5d5MueR9yqrqNSz7I9kt//lPPUaXSxlTlP1PZi/SBE/P4EMXGXpidUc5VZDxxcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Et+BuTxm; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Et+BuTxm"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e041ea211so3283781a91.0
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 02:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786440542; x=1787045342; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ChwOUK+N9dCU68efrhi+nmXxTAHvjCr3KHqXfPLhXaA=;
        b=Et+BuTxm/E7Hxli5tQ84eMUrwBF+nyYvj6x6DdkdHUQTyAuLrg+u2TA+B5mUCvNen0
         pj5WkHBzv2KL/Q+fkQ8xDMjvx2YpGC6FKrH1VCPC1vXyE0FugIw/tfF56UKoNUi4bCtc
         Jnmpcok3C0PX0dlhFGMCAni5u2erqhculKXtuFzkIWhBEKZXFeSLXAXQ1Po1ikW7m39y
         k7KWp3+PJrEcwrbyL40v2wVPp04OWnZ503qJF2ONlVXpYlV/wROS95qdXC7+432Y8eeS
         jeOFBWeeS61gLuZYQpwJLbdvdf8eJq9ZYS6mPs1UfACuyHhdzTlW3mtEjBBFhfOLF0gr
         ic7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786440542; x=1787045342;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ChwOUK+N9dCU68efrhi+nmXxTAHvjCr3KHqXfPLhXaA=;
        b=Bg45W8A4ftpiwZt9rb1o2O5k1K9YpztD6ngx4Gb1LuAaz9XjIt98yDbWY3dL7D9r8y
         rs2ttMDJaIr2J+UjbRYayLNy+hnQcPPFyeOD+pPYhPq/FY0pinigbXEklOunh1maiNjU
         UUcU9AbV08jD/UpUaL+HXZgkvVEdfPsoRrodCQt/8hKJeH4YGIFhPJ6wcmJMzGFjAnOg
         0iRbV0xUCIjBpJGq1ztfdI70QlRjhaOhQdUKx/1zkgR2MKf4dlr2yn4iaqQ72QyYSq2n
         wYKDepobGEd8Z67CvvA4OPk54pdYOP+WJpm4KkVxKpUtq0sI9cATyJ53b3yUyruAUS/8
         FGYw==
X-Gm-Message-State: AOJu0Yx4IEvtmChbxptA5lVC4R5HjwyzMsKxGvK/nIeX5Ouo5fdBNw9N
	IvRSqqIaAzXFl3RrkOHePXvrAEpQwLx/seda4pVXzTaPRknnvFaOTAscwl3AKjKv
X-Gm-Gg: AR+sD10adMri9tvn3iaTxQgvt5a7cFedYwcQBOe3ip2X94br0fIGYsV2Gyph+MMVWnc
	KabNAZZO4564Kf7rN1zvFZEUYFLHqTcGgA6VJZjkICTfFiiEhPnO3UeMVcur0ZkSBZcAKLZAzHE
	7BTOE4mFAQTezvE1pMfu2F9KNQhstz+2mMmZBjJhLnSDQR2Zr646BI+C+ITHL53kUp1Mb7Gn6aT
	iIh06Pe1pgIpdqtrYOhq1SphR1wx97Bm2J/Zm75ihD7Mup/Cq3VJtp7+Az4N3sDvLBGjwRpiFpe
	mV1iWtcRVbYKPT4IQfXlEq3EB5i438zphh4xEaFo/HIQdkfgke0irRgUhwZ00hL9CVu0aHIzxji
	/C99ea6b6xv/vyTuEmBHp0HyzK2da4/EFtTlaCegWCXiDHsfcUiKqMZ0PVENOwxpDIcNOW55WIZ
	3t6nImJGxahU5LvdQ9l6RWR5e6LERKE845wFtq5YnsY9zsp4bTJwMnQlmfRMfmDO53DE+qQnYwq
	A==
X-Received: by 2002:a17:90b:4f89:b0:38e:6bd7:fbbf with SMTP id 98e67ed59e1d1-392ec72f865mr1964755a91.20.1786440542246;
        Tue, 11 Aug 2026 02:29:02 -0700 (PDT)
Received: from [127.0.0.1] ([4.155.196.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d5195a4dsm3129872a91.4.2026.08.11.02.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:29:01 -0700 (PDT)
Message-Id: <e40c759756f9ff9263c1832b901cdbfbb7140e67.1786440533.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v8.git.1786440533.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v8.git.1786440533.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Aug 2026 09:28:48 +0000
Subject: [PATCH v8 06/10] t6600: add clock-skew topologies and step counts for
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
Cc: Kristofer Karlsson <krka@spotify.com>,
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
 t/t6600-test-reach.sh | 93 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 2 deletions(-)

diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index c0ac90680e..2a6c7c656e 100755
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
@@ -347,6 +417,25 @@ test_expect_success 'merge-base --all commit-walk steps' '
 	test_paint_down_steps 81 80 81 81
 '
 
+test_expect_success 'merge-base --all with clock skew (side-exhaustion)' '
+	# Verify that the merge base is computed correctly even
+	# when commits have non-monotonic commit dates.
+	>input &&
+	git rev-parse se-D >expect &&
+	run_all_modes git merge-base --all se-A se-B &&
+	test_paint_down_steps 6 4 6 6
+'
+
+test_expect_success 'merge-base --all with clock skew and redundant ancestor (side-exhaustion)' '
+	# Verify that the correct merge base is found even when
+	# non-monotonic commit dates could cause a redundant
+	# ancestor to be visited first.
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

