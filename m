Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCD738D6A2
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783776477; cv=none; b=lt0EV0NzWrBZXaNvZCRJjurulSlT/aJJpD0eN/EMkpXMdhhiy4vhg64vvn0jplkx7NL0qMxzZPu7xicrYqoxH8t1KgjctGVM0ZshjduJO87ouWDILdqRtIfj6FBef9pZ+i+CGQgweqPGhrab4+f5qHJU6hsHad+CtKw5IWiqd7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783776477; c=relaxed/simple;
	bh=bdw/m3GdVULBaLWSYFZ4JcdX6BY+E8gwXb390oUqKxY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EhF6M2whPyGg7Siiu1qUcH0M64zAkY2y3yXwkGMB68G0VemZaFtTprcHyfk3SOuNCa8B2wWfJL+2uRmMrbd20ZP8x+rv1ZyrKVVWeZDxw9MoOxPeIGeDq1akGFwfMwDpIySRnSVeGC0xOHHEosucdjXq6P+yioE0H6XEB9XWhqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKRfSrWh; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKRfSrWh"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so722750a91.0
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 06:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783776476; x=1784381276; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mbm0PEz7Ej1bLUyZgbo3sVcWtr9TiArWRtokJZ/O60E=;
        b=cKRfSrWhyo7rdMlUNoN2Iw4BWHMaRf+xheOWicxz3jjKppt5bdnkjM2MqjJBLa+xcX
         ssaT2dTQ+DVjpg2dXt5yVyCTPuogrJFn+k+CPP3UJrcasOA7DSUGeAbgYJ9a1lRkJmMx
         RvLk17F8u7icaG9K1O9naq+PRmI7GOf3OHZLzqpauaRApRw4QuWNLWMEo3rheJbhWZQI
         c2rLb0PHpcC6yajQVRhSsPREMWGJGOZeka7asgMJPoIa5UEadCdubpKgDnG5BWnCIzA6
         BIrmeqwixKlCojIiQ4sWzIwes3bIDIdle7RxXs8v6FdbI8ujwVPZFZQ5+X+XapoVr2Dv
         +rVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783776476; x=1784381276;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mbm0PEz7Ej1bLUyZgbo3sVcWtr9TiArWRtokJZ/O60E=;
        b=rkiLZh3fZmO0ZWfIG9luH0EZhnLAX/XrFENZi2RIy6lZvVeH4QCUoYB5pSmv7D8mSE
         ZDNFbvrtnyEkE/kp0PZVoXV6zuONjt6NXkNnQraZEDsaITHWOCv4x6Q+WVLoXV/cHdmM
         yhuR0Y5kDwF1SF2bZuH9BjbhIBi4wGPpwdgVzxSge1e6zSCsiKtJZlS/Qcwm08KRfNdj
         snzc0s0nybooat7pkvYbky9ezHta4mFGt5Rw5S24HoVlxC2JEuRAynAUlqP+DzdB0EzR
         +4y4+qhu7QKtveuSLZxVvJ76vzKFEcpWe1a7B9kv+ucKhU56Pf0KVJXi5gw8W7FHd1wj
         Cwbg==
X-Gm-Message-State: AOJu0YwKqexwKLowAgOLSemzPPsS4L4SYCuIjN1sk24GY7YGgQGcxCih
	oi9yzACZqdLiEnaVsZ1XzmEywvo3AdrH/GXEvSKbuRTowx6Azea/0BqrdoVCrA==
X-Gm-Gg: AfdE7ckA80aNGhtt2N8yf1lRXY0PSihTXcf4Rfrice4fT3XTIFA7Lpy1Oe/VfujPQAW
	xWUX0AZe9eqiv1ikXC40qLyaGVEaK2VsNQZyYq4jBjoUsgDQqfo2cR0ACq4CWcxQiOgPB7UOIYu
	F9gGIkxVc3UpNEemopw9hSP/RQZ610wRHUj4rVpvDEjvQFwlCyyryYXhKFdJoTQ42K71RWvCxJh
	GcVUtQdjzmlkJb5ksJom0YkRFkxBB2+JjeEPiuATE/pYJ4gfpO4MGrIu35gblfsFGIF7VcYA2vm
	6qW9YkdaYiomgVzqWnVHfTpQK0Sk4YJ+82O1zywDRkUpyYX1wxTGC1F+h0BFryORMA64doBEIWI
	HDrqofcQEDdiV0XHVc9UHvbVcud08or6/Q6JoLCCLe+mSb9Op3L7GkkBHInO+Rjr0InqSUMK34L
	i3mtTLCJkx73NJrAw=
X-Received: by 2002:a17:90b:54c4:b0:381:dc88:7c09 with SMTP id 98e67ed59e1d1-38dc777c501mr2941458a91.33.1783776475553;
        Sat, 11 Jul 2026 06:27:55 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.76.184])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31189cd8234sm42595221eec.9.2026.07.11.06.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 06:27:54 -0700 (PDT)
Message-Id: <21ecf6dc34289994ddc5d4b5d814af1bfc2a50ae.1783776466.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v6.git.1783776466.gitgitgadget@gmail.com>
References: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
	<pull.2149.v6.git.1783776466.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 11 Jul 2026 13:27:38 +0000
Subject: [PATCH v6 03/10] t6600: add test cases for side-exhaustion edge cases
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

