Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213303F39CB
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786013998; cv=none; b=MdF4qnU0iiRnbeiLIxdN5u9KR2b39cDB+WatxKg6XO4ZCrTRVp5LrmtYD+kDDftVGYOhfFxHidcMSjOpfJWRJ0W2EI65wXehcEOU/HQFYgRTlXWRHzhcT+Mp9ULHlzxK+3Ob2U6bK+mbde3hl1M3TrSxYuTN1Jcj8u6UueFjOX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786013998; c=relaxed/simple;
	bh=bdw/m3GdVULBaLWSYFZ4JcdX6BY+E8gwXb390oUqKxY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mhgHds54YvTVmnbAfUz0rREvcXYh8QYK07B5CQakr92f4iiFSbgliIgF3tTVbL88qK+hBhJTHXHP0AN+vLSTFHnlt+vpD5A2YxpLFep3dIOHEzYk++S3RJi1ZV3B5/26ZKmofrdTr0q1p615y4q3jp08s41yE4vcejljYY4M3oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yp0XYCP5; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yp0XYCP5"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66892c81725so3104619d50.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 03:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786013996; x=1786618796; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mbm0PEz7Ej1bLUyZgbo3sVcWtr9TiArWRtokJZ/O60E=;
        b=Yp0XYCP5SCHEGtw3xuNog9G9c587n6PwWSKajTUN5AOWAkwzH47h3DiFPOQUmZP7bA
         xXJk7g2YfOQF5jyMaXT/iNfb/DDqHooaRxpOfdPsYy2cDyKvpiy/LMmZumfxFr7sYqh4
         qtWHDMbVtDyJ5YRhpHQkeavSp+NkHRRKYKkqUrtckGG+fflnoWc2UGoWGKFZDGJQYLUr
         yl3mx5/w7lhwjgfV6mkkaKxFoeDiowqVtXD/mQI0bTn+HUqbusTZ3rJAgiUP3INOT/1b
         NAd5FR3XRif3yPnjWgvY6c5YrDALsKdOtr6KXGPFO+gCFo+/YnprXFCW/T+cykoV3h1L
         w7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786013996; x=1786618796;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mbm0PEz7Ej1bLUyZgbo3sVcWtr9TiArWRtokJZ/O60E=;
        b=SkdQVcP7bDUxkbLMkgOA1yAocZE4hkcvors9bUnIUJVLENYcPOJ21ksrFeCXJG/MRE
         /L6c4+k+9ZTwtsEXcrsXEIevcfkkzOHnb3FRFdfNVWB8UzEa7R3+BhaL0k+f0VvUE0QF
         pcC0NHOcWS0pCC0sqbMcHX6wT8PoyzE5mfoQ2jNn+SSOhcLlpF7V0LGYRUgtbva2yrCn
         oin3fN2xSxOoXDxscaSTztsnpnXmSsMueLgLLuVMmtIsZI2n31n18Zi6n2/VXCuXI/cp
         c8iX+Vj4W/zXeSt3XXHN477iK5Dz28uDErK9DJfTnDd7D2AytKpAHnMLGRzaud3KKI6W
         oMnA==
X-Gm-Message-State: AOJu0Yyd85xIC4c5iKuHyrU1Kvy/PLfk4glcNTs6O8xJrFr32G1Z9Sil
	/XBYo5V+OIbFjv/hig6wb4BwPnavaOsX6GtZ9IkVSwLtf1a/k5v9jzFCAGWv4Q==
X-Gm-Gg: AR+sD11djR22VPTyow5u4/YLTC8Lg/9gVMrPddjy6mvq9//vTPrRsbPMWkp1VKzQ8o8
	tCFiOgRyiQ0lAb8+wjp9zeTY0vznFFl9WXs5wlwlONtFePrr+E+4ZnTkqqp29lRgGgFZyDzZqz7
	1wZeXlEtRrzN/K9u9HMt3Xs1T3/LKfIfMDOtXPgvmSIAUATO9mqZV0+hfGsbpUjnB9JHsWo0qb7
	8wmj+I7nSOkK7BRK9PW0A5KSxUYa9NyvO439xSO7y5JOebndASXAsWLPJ4t7Sw1TR+waPCy/wmk
	Ot/YuKmMIqegpwoV25jNv5RCElIaQR80KGows55bqk/FhopZBhLwULM4ObaGnESkKeoV7lNfj2L
	zU0LmdCYdhWc6vOy6507yEY6B2PglNa2KWXMADzbBORUxgNN4IcmyB0vD4y3E4aEgTf2L6GSebH
	MCwwCtEMlweBqUjfwdPeKVbmAx+XwwyLOZFq87PVt5S0PCevp6VjYdpjg0+ih3CQsVEpCOTOa7/
	w==
X-Received: by 2002:a05:690e:1546:20b0:668:1315:291c with SMTP id 956f58d0204a3-6699a919fa3mr6357749d50.7.1786013996068;
        Thu, 06 Aug 2026 03:59:56 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.201.50])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66991642703sm4703308d50.17.2026.08.06.03.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:59:55 -0700 (PDT)
Message-Id: <f857577e0cedc11f8db614b4ab2bf9217652a312.1786013982.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v7.git.1786013982.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Aug 2026 10:59:34 +0000
Subject: [PATCH v7 03/10] t6600: add test cases for side-exhaustion edge cases
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
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Add test cases to t6600-test-reach.sh that exercise edge cases in the
side-exhaustion optimization for paint_down_to_common():

 - in_merge_bases_many:self: commit is both A and one of the X inputs
 - get_merge_bases_many:duplicate-twos: duplicate entries in X list
 - get_merge_bases_many:pending-stale: STALE transition on an
   already-painted commit (ps-* diamond topology)
 - get_merge_bases_many:infinity-both-sides: both tips outside the
   commit-graph with non-monotonic dates (pi-* topology)

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 t/t6600-test-reach.sh | 110 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 019fed9f5e..698b831a6e 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -85,6 +85,61 @@ test_expect_success 'setup' '
 	git branch -f skew-P2 "$skew_P2" &&
 	git tag skew-M2 "$skew_M2" &&
 
+	# Build a small side topology to exercise the (PARENT1|PARENT2) ->
+	# (PARENT1|PARENT2|STALE) transition in paint_down_to_common(); the
+	# 10x10 grid above does not exercise it because no merge-base candidate
+	# there is a descendant of another, so STALE never reaches a
+	# still-pending candidate.
+	#
+	#       ps-X
+	#       /|\
+	#      / | \
+	#   ps-Z ps-B ps-W
+	#     |  / \  |
+	#     | /   \ |
+	#     |/     \|
+	#   ps-T1   ps-T2
+	#
+	# where ps-T1=merge(ps-Z,ps-B), ps-T2=merge(ps-W,ps-B), so
+	# merge-base(ps-T1,ps-T2) = ps-B. During the walk, ps-X transitions
+	# to (PARENT1|PARENT2) via ps-Z and ps-W before ps-B is dequeued;
+	# then the STALE-walk from ps-B transitions ps-X to
+	# (PARENT1|PARENT2|STALE).
+	git checkout --orphan ps-orphan &&
+	test_commit ps-X &&
+	git checkout -b ps-B-br ps-X && test_commit ps-B &&
+	git checkout -b ps-Z-br ps-X && test_commit ps-Z &&
+	git checkout -b ps-W-br ps-X && test_commit ps-W &&
+	git checkout -b ps-T1 ps-Z &&
+	git merge --no-ff -m ps-T1 ps-B &&
+	git checkout -b ps-T2 ps-W &&
+	git merge --no-ff -m ps-T2 ps-B &&
+
+	# Build a side topology that lives entirely outside the half
+	# commit-graph and has non-monotonic commit dates, to exercise the
+	# INFINITY-gate in paint_down_to_common. With both tips outside
+	# the graph, generation is INFINITY and the queue falls back to
+	# commit-date order, which here is non-monotonic.
+	#
+	#   pi-X (date 500, PARENT1 tip) --> pi-P, pi-D
+	#   pi-D (date 480) --> pi-C
+	#   pi-C (date 200) --> pi-B
+	#   pi-B (date 100, PARENT2 tip) --> pi-P
+	#   pi-P (date 450, root)
+	#
+	# merge-base(pi-X, pi-B) = pi-B (it is an ancestor of pi-X and is
+	# itself one of the queried tips).
+	git checkout --orphan pi-orphan &&
+	test_commit --date "@450 +0000" pi-P &&
+	test_commit --date "@100 +0000" pi-B &&
+	test_commit --date "@200 +0000" pi-C &&
+	test_commit --date "@480 +0000" pi-D &&
+	GIT_AUTHOR_DATE="@500 +0000" GIT_COMMITTER_DATE="@500 +0000" \
+		git commit-tree -p pi-D -p pi-P -m pi-X pi-D^{tree} >pi-X-oid &&
+	pi_x="$(cat pi-X-oid)" &&
+	git branch -f pi-X-br "$pi_x" &&
+	git tag pi-X "$pi_x" &&
+
 	git commit-graph write --reachable &&
 	mv .git/objects/info/commit-graph commit-graph-full &&
 	chmod u+w commit-graph-full &&
@@ -182,6 +237,16 @@ test_expect_success 'in_merge_bases_many:miss-heuristic' '
 	test_all_modes in_merge_bases_many
 '
 
+test_expect_success 'in_merge_bases_many:self' '
+	cat >input <<-\EOF &&
+	A:commit-6-8
+	X:commit-5-9
+	X:commit-6-8
+	EOF
+	echo "in_merge_bases_many(A,X):1" >expect &&
+	test_all_modes in_merge_bases_many
+'
+
 test_expect_success 'is_descendant_of:hit' '
 	cat >input <<-\EOF &&
 	A:commit-5-7
@@ -219,6 +284,51 @@ test_expect_success 'get_merge_bases_many' '
 	test_all_modes get_merge_bases_many
 '
 
+test_expect_success 'get_merge_bases_many:duplicate-twos' '
+	cat >input <<-\EOF &&
+	A:commit-5-7
+	X:commit-4-8
+	X:commit-4-8
+	X:commit-6-6
+	X:commit-6-6
+	X:commit-8-3
+	EOF
+	{
+		echo "get_merge_bases_many(A,X):" &&
+		git rev-parse commit-5-6 \
+			      commit-4-7 | sort
+	} >expect &&
+	test_all_modes get_merge_bases_many
+'
+
+test_expect_success 'get_merge_bases_many:pending-stale' '
+	# Exercises the (PARENT1|PARENT2) -> (...|STALE) transition path in
+	# paint_down_to_common(). See the topology comment in the setup test.
+	cat >input <<-\EOF &&
+	A:ps-T1
+	X:ps-T2
+	EOF
+	{
+		echo "get_merge_bases_many(A,X):" &&
+		git rev-parse ps-B
+	} >expect &&
+	test_all_modes get_merge_bases_many
+'
+
+test_expect_success 'get_merge_bases_many:infinity-both-sides' '
+	# Exercises the push-time INFINITY-gate in paint_down_to_common(). See
+	# the pi-* topology comment in the setup test.
+	cat >input <<-\EOF &&
+	A:pi-X
+	X:pi-B
+	EOF
+	{
+		echo "get_merge_bases_many(A,X):" &&
+		git rev-parse pi-B
+	} >expect &&
+	test_all_modes get_merge_bases_many
+'
+
 test_expect_success 'reduce_heads' '
 	cat >input <<-\EOF &&
 	X:commit-1-10
-- 
gitgitgadget

