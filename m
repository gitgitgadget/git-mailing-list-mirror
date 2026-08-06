Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726BD442B15
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786014004; cv=none; b=tbwK8t9zvYHyBGPpKghKmM5B0fjdP0lazeEi5GM5/Gx153BspJMQFcIi/p2OGe+utA+fDFRDjcjwixfAR4zk7FVv142q0yXoG7awayXYf1/eNVn+1HCmROOuwv+nFK/U7veVzgnU97wyWd9724AEWQAkbcFGLpTyOBGJyKmOzB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786014004; c=relaxed/simple;
	bh=0+WssLuoWASFEKFDgScKEC/8Bx5eaTKNGaVYeytXCCI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=L3Ev3+xgXnzlsNhXL/zKlSdwT9Iq4R7mjRoOyA06HoNzJzaQuKEgC8pdAejF2vGtzyGYVsC9lxFDxOiq7vzPL3iS1EnSUbvaGFAVHTWMaN/zOfrj3jTROVjfC87SC/pDGJp4Mt0OtMKRKV1x8A01QCiit/MaNwn5wI9oqvJ0AmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S65wX595; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S65wX595"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81e9d8f3289so31475317b3.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 04:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786014002; x=1786618802; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PdAYApUwskKTp5isWyj7neMvs5zQhF7CkkSEcEPCito=;
        b=S65wX595MyHWnKT2rIlRKpM1XSpsh5polrj3m4FYvVxZZJ655V3xSDxSuLLqfMk0AT
         4Kg4GMz41++IcBgv5bM1OgTa7offBssBbgakQiURYIQuK2E+LSYD1kcP7oIY1+hjDc3a
         S87q3weDU3D1b+fn8M/E4cpelOhFP2mLFEDiMWkmGmnGdAEIgRIOjcA1u+pgy8q79CJk
         vth3bqOL/ibqTQ79jU0L1BTHpPry+V5LyFhHi9Ksn1y8k5t6e5qpt6QQWVJUhH0ZCvXp
         +l9fjCLkP6ZcCbLO37G2VgU/y0RiUxCbF6z9OoMBBDxFe1o93Af5v/0r9sjd+oL9oTTg
         l8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786014002; x=1786618802;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PdAYApUwskKTp5isWyj7neMvs5zQhF7CkkSEcEPCito=;
        b=jDYjuAG89J8Clxpqa8xG9NWkMPjletwbFRymp+G5do26rwGXuztd8H6H19Nx74vbTw
         YixkFvMsQKHoUJBxxFuPkeLukgVLqHB95ByItcQ+EL31udMAnPCQMt6by5CoIh1Bq32Y
         bsrp9JpfGwBFsGxtjOrxVtaG2MakjXCkbqC/cmPzLGlwIiCdGSfrqqPH2QY6CsfG/4K+
         Evs2KHSrFaLCUdbL29x1nS7mbjUFGIzUHC+6vseDzpksxE2OlNQU+kw7285p0v6oM9EZ
         lnSOR3xzfaQkCvmUnYuYm1e54xUOuPf0Nfj5Xlc2CWEcAAndozjD8kX4whNqvIIpJ5uK
         Iuow==
X-Gm-Message-State: AOJu0Yw4CEs9S8wEaee1IUBSIZixc2S30kFnfxsijyl303WLe4MvLPlQ
	+Aow0+EoqoiCWvcxRgk/AyuOx6GlMkz4pfdea++st4cHCje+HRwBa1dr1FRXiA==
X-Gm-Gg: AR+sD13nb5/OHH1YzrfXtwTYFa/vWKkEOKIZPmfodDTcEnuGcq0LxV5TwEvXPShWYeh
	9Ul0LbaPYxXVq1Fa6zAKHJrl9idbLV6C1IzjrRN4HW560IMB4t9Whscis9v8yNcbG6L/s1zkOJW
	B36Cp7F+0+CvSVGx2XrHa77iRAU8TkgxsLjxnpbSrp2CPrC9BbiRwfX4GsAZIUUXTIssaQuIjeT
	2pvRTEpELdCbdvCeGth9MqH4I3pX6dXPb3+CMekfURkNCQBtZAQapNlzwNlU/+Eb9BxsMw9wa/w
	UBT2f5/3L8OEfMsfYVHwNpnmPFzjfv5Vh1fvCUuKtPYEG0ue8Bqa98QxuEXdgZB6tPrKWxY17j2
	DHQlDQJvapnOQru38nu9rW7o6Wr08CHShZPX0Dk/y17lNcOCsfdacR3xUxiUrQvQQ/b6scWsd8a
	EoD0ceAfEzt2+gcaQ5lP62hzlw+z3NLWXZpzvh/MWzvsObxUm6s5v0UDq8NenmJVI=
X-Received: by 2002:a05:690c:6601:b0:81f:49e1:1f03 with SMTP id 00721157ae682-820229bedf0mr79591587b3.31.1786014002271;
        Thu, 06 Aug 2026 04:00:02 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.201.50])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-820131d8bdasm36483527b3.10.2026.08.06.04.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 04:00:01 -0700 (PDT)
Message-Id: <75d58639fc89f4f789b1b7befe8f0968bd841be0.1786013982.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v7.git.1786013982.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Aug 2026 10:59:37 +0000
Subject: [PATCH v7 06/10] t6600: add clock-skew topologies and step counts for
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

