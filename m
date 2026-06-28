Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78AA3A4513
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 12:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782649558; cv=none; b=O2qsskRMmck/LlyVKMrpnuZUCAvvkpJtfmyBVtKLb40smAAMFHVvjzhTX0bdIG4PU1Qq7I4HlqVZACufO269GX64+vvttOiMu3MWfat5jTNHpXbLynbi8CqU9jRffItmQHZfnP3fwWfgLxko861qEM2jxjNqvOdrdzUqWBLScik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782649558; c=relaxed/simple;
	bh=XhvYtf9Pt/7N7kxFXohFRXlI729ga1e3YtTJkIGhVbc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cNgkprmjyedx8pv5wVLfcdFuDojv/DoYWZYGCpxzfptRglWDqrkkVSkac6Z/Nh0grno0bl8onCMU7atr5CG+e78uS7g+cACkvwnv4TTZLQdueKanL1uG0YsYepchCw9iQvfyBvsKot/1OYbpjtEbT7OdQQe2qTaAqFWLO4a4Zns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wr/G1oyc; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr/G1oyc"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51a84669e39so14614691cf.3
        for <git@vger.kernel.org>; Sun, 28 Jun 2026 05:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782649556; x=1783254356; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okJxHmSjcn7bS5AFBkhOwnk9bTFJsGBQonzoKjBeB1k=;
        b=Wr/G1oyce4wckzgW+PCTVSFb1XdhBEgaxv/hTMHsPUYdN5UkIqp013sUBdgVu3yWdB
         fL1lG4u/CzMTv/YfkscJjnfNHE3XSfDLPLkhBnyKWikk4K781pt+FD3uPgwSGErGUIdR
         1yRwkMIN48J4xY+pQOnzHfGXFsIJXKxWDkja97zYklg/bz+ylbXtUqzoqgLvCidA4qXS
         YIQXF4NDlCoDSyt966kzBGWbzW5ZaaVw1Dfup5m4VaLdQ46UgQDj28mSs2xzsK2RO1xV
         6BUI+3VxNsMjc8lanZDkPtaaGOGXsBPl3p/VbVk0s+EqFiOahsPd2+dJpvcqQQzPo3C+
         vabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782649556; x=1783254356;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=okJxHmSjcn7bS5AFBkhOwnk9bTFJsGBQonzoKjBeB1k=;
        b=Tyf2a/R1TFLztUyboxjWiyfFLC5HpYIyG8lQxLdLfmJ52qhGdoJPC63mRMtaIzFpJU
         XyU87VWZySnTzuBdn0qyu0TLfL71bldA1Ds3IIPuzvikVXHeXM01by1JXXfy0VjB/3iV
         9V03Ii4EFXfpaUJt4xm2VNy7uVBapXlD4Fuy9QueNRgDZk4HW576Ch06eyN6DtkaLnMV
         T1Ee9ub0PNkvAi3Y6ZGx5EuOgf9gC28SOI6B1Ljh+ULmBjyItjZBXN5yt7L6QJtGHRJ6
         YKqJCJaFYqXxmjm+I1rU8YDOx91QYIZ3pt/gasXjmiIxZlc5eoxAVFvYfNUDb5k+d/IA
         vjFw==
X-Gm-Message-State: AOJu0YwJAX6L3Scx+RKCUs7JdR7F0eNkUnFgCxLm1BkH5PEW5uxusSZF
	oju1cM5/4WSRnDc6BrypGHDS6vCIDLncQih/YULwKERSSVDLiQc+eu6VKaiszg==
X-Gm-Gg: AfdE7ckvMlXoNhTq+m7RWnWoE7r+t3XeLIbmzVY2S1bcoJFbHu54sVZp+uCYFvTsCYg
	+IJ/Hu1Erro2dwyFhKa3zZTNF2iVidmYUX6oHxwHwLOohJsr3knKorsFogsmJz/qQ5b+4t/p/CJ
	SR5RHkqqgT3LUwwTbYvYkVsil8YjMDCoPxAJdP+vHof1YDUol0VcnVldCsD4q2Pn/E6m5OKhow+
	z51mZ+yBIW/xF1LvaswvRcMusnhNjDZ+B3kH3KlT3rOHRH1sayBdDfD3rq/JU/QZHs7/UG+yrRL
	DB/qlBTtARBr37pHYSQvDO+sYPSpSlJhcryhR38yLbArzjH7//CPPYe5rnKwZTHnBdVhoXFRn97
	j2/9FipcUUI1mxSEXKd2F9T5/B6CgjtsoMEuBP30SR+DavZi87UsBB+CD063qb3ke8e3e2fiSbQ
	la3J4GYM1TmB977fn/
X-Received: by 2002:ac8:7f94:0:b0:516:ea2d:7c5a with SMTP id d75a77b69052e-51a8b1e501bmr99040561cf.41.1782649555683;
        Sun, 28 Jun 2026 05:25:55 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.135.114])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a876c888bsm51592821cf.9.2026.06.28.05.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 05:25:54 -0700 (PDT)
Message-Id: <1a0154b406343ba7e43bc60da45c4a5deadc7e30.1782649547.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
References: <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
	<pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Jun 2026 12:25:40 +0000
Subject: [PATCH v4 2/8] t6600: add test cases for side-exhaustion edge cases
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
index b5b314e570..c2e091aad1 100755
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

