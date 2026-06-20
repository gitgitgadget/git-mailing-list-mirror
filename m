Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4C434574B
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 10:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781951833; cv=none; b=t9aYW5PioQTjWex+p0sAH6vDyh0kuZh1Y6J/7/96cTpvpDsS+KG7m6Ddv6y/9KOM5MexZE3Pah14JYXF4rT2tTj8ykJ+0kgxT/8xAxdFxIMDNpE+Av6DS6H1+O219r7qf7PO6SndphkPk7FovDXl5D5aXIbK8tYIFbl+d0w+4Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781951833; c=relaxed/simple;
	bh=bfjsBZoXajkEouDjj7m30QftWTYV1s3u0zWVbpJPdOA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=O0h9LrYbIWbxYJr7NWQ7XVy8CYupgVNzflMz4fDt54dVkVULb4+tWxrAuikvihSxUdcCDseYCjrd5GkoSpQ65cexj4bArsC3OGmP7t/6fCZ0iZjuQPYKMl19xAlSOfyb0GjZmugNBItEigNGqlmwGicBRy1Irz/SM1Pbmv5Yvs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0//s5w9; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0//s5w9"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-30bc871ecdfso3533419eec.1
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 03:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781951831; x=1782556631; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GutegurUc9SvGURSyRcrCif3dSnRX0TmkZwh5fxKWFc=;
        b=i0//s5w9DkQsiK8Q+KIKrqx3hbVMdDWBj2Cyl7NxZnxjp70bzq+HIuFlof/qMhKvwG
         R+aPjuzhwgoD3J6a9wLWV1tXY+ISV4gYmU0PCgBM8/C8FagmoXxKMThzdVFbxIJC/yML
         H36Kv08Kao/+SnQFnIGUPUiZvQl99Xi9b03/Gb+MqAYA6RGZCdHqGHMuh+LuuR9nrLGp
         u2DGqrADDbwVs6n4IgbeGKQ6eS3Bipn8RbMtUivVhn5P+vw28dWEovpcBM3BHOHKtkkZ
         SXhE46liyNDbnkNYlgyei25Mpi5Kxvq57OGPwzfGMXvVsHdbiR738KT5R5crwy3XNmvW
         0aPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781951831; x=1782556631;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GutegurUc9SvGURSyRcrCif3dSnRX0TmkZwh5fxKWFc=;
        b=Z+QZ5NG8RUcdfaORHRjbWEftSJa1YvREa9PDlJnngQEYs0ml3Uh0e2+nnk5/lOKiTA
         reHnsWkNWgEk5xPFt1fhLMEl83ES5egn01qcUhrctBZlPIeXB4zCHrEgWm+P9DCgkMSc
         rNUBugn7lUvCmzi+gV/GhZRoLY2sncYOS+hEIWS9C6eIS7XMu1d0ffEFTuDzMs2nJQh9
         aWBdQo1w2udTpRbhYxIFx8ZiftgjvpFWKuACoQQtkULdFPFTd6RlXQA+xm/hIRz7s15E
         BSZXzBSU2QO+gjSSvxs7qpm5JTexKhDSdmGu7OrAFeBt+VHcpCgeoBd2YHCYoN9AHDlh
         m20A==
X-Gm-Message-State: AOJu0Yy2fzB5EH5AkzaVdbdtw1eNbDKkyQ5ULwClG/J8pMcTHQyR5iTe
	GOP2xwksX3Lyg0CCx2JzIToyN0Gn4HbrZ+2H11+5YoiqAclmFB6mtHynObIF72if
X-Gm-Gg: AfdE7cmRdlmt6XDAEfQOUrujOemNgSMzds0ujXBnNmHL3yE9ZM1LmQ6RdlqWgJT/9W0
	WyRM9r+lSndchWbe0FJS7IKZ2KD7sLAXqRIcvDzp6O5WLjmBB4jFdNVzAoMpDeXi62DfdWHiNzf
	DejjpjV6CBaLcEcJA07fSj4Ez0u+3IiX5eDOV76dWwHGkiIpPb3hNhibXVUiYzavnzCUh+gQByO
	g9l2jHfSsc6Ekj5OvNjb1AiqxBPumYjpZqa+cHcZ/w06YCTtbAjWy3b/cXfh3d0hFlUZlpnFx37
	b3ZEq5bBVbo8VOzU8/luM81fG+oeOkojafaq2Vw6J22DBpuM0wmiFy5PevCtbIQMrt9nq+sjCvK
	SLm47yRNQwE+Q+uzVna1aVrnZDhjs7YjNQG+7KV0aBRKNMdSrh/xvouhSpyHFRhli3Zdl7EKrcu
	Yble2l6QJSnLIpWwum
X-Received: by 2002:a05:7301:38a4:b0:30a:e531:3153 with SMTP id 5a478bee46e88-30c06e34807mr4855577eec.14.1781951830741;
        Sat, 20 Jun 2026 03:37:10 -0700 (PDT)
Received: from [127.0.0.1] ([172.185.54.243])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bdffa83sm4309077eec.23.2026.06.20.03.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 03:37:10 -0700 (PDT)
Message-Id: <91372b975fbe102538c05c7d2cdae356539d1bbd.1781951820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 20 Jun 2026 10:36:57 +0000
Subject: [PATCH/RFC 4/6] t6600: add test cases for side-exhaustion edge cases
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
 t/t6600-test-reach.sh | 111 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index b5b314e570..775c077c87 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -49,6 +49,62 @@ test_expect_success 'setup' '
 			git tag -a -m "$x-$i" tag-$x-$i commit-$x-$i || return 1
 		done
 	done &&
+
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
+	# merge-base(ps-T1,ps-T2) = ps-B.  During the walk, ps-X transitions
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
+	# INFINITY-gate in paint_down_to_common.  With both tips outside
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
@@ -146,6 +202,16 @@ test_expect_success 'in_merge_bases_many:miss-heuristic' '
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
@@ -183,6 +249,51 @@ test_expect_success 'get_merge_bases_many' '
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
+	# paint_down_to_common().  See the topology comment in the setup test.
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
+	# Exercises the push-time INFINITY-gate in paint_down_to_common().  See
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

