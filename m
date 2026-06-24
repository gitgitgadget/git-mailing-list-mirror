Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AE335F8C5
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782303262; cv=none; b=AsYYWRTanBYzHG/9qjRBUto2vnZvJDXLlSErL+cIjazgeFd/NKCRBaYTLkjJI75JsO+efgLZr00xZFjIeC59KPHQkwRVePgbY9ss3hnBX4A5WqaPhjCG0flO+xMk9luPnwzIBwBlldZWVhsHjq984hwLq21zrq9w49VGjVViQYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782303262; c=relaxed/simple;
	bh=XhvYtf9Pt/7N7kxFXohFRXlI729ga1e3YtTJkIGhVbc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uPy9WSZVXrUM7h+6V3YEzH1BBkl8YX70bMZ/HB/LJ30bMDe9Mh5LmwgdbFzWy7XxGFUI+8PgR3o3rLUgt+AW7ysETlF6Vv6NwBu1nxyo8RWK3IxSa5hX9M1C877rhlZZvSoIWwzQsYBYXXIMP7+oVeGtgFphNYjvSyIIH30mnJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSmPRWy0; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSmPRWy0"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92120eb916aso91256685a.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 05:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782303260; x=1782908060; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okJxHmSjcn7bS5AFBkhOwnk9bTFJsGBQonzoKjBeB1k=;
        b=JSmPRWy0fKJo7KUjRGBktmWkbfKNGU9DDzgoYRj9ChbrIU70Xg6Hhqo7dpekcGQ1PG
         VrvcJILin8H1Z1yD5fh+ulhOpMU/qC1zhS6cbjnpTcIju3461U5gsx/SrMokcLrrEkHB
         mmt8Z7f9sZQAhnfFMyrYlHm3jSwuuPn4GeyB4iFoNjCesgaB5rYsZzDiu0rgCYXmHPuK
         IjfVbXU+fKT4oEfvgRnh44eJpoGtJ+f8J9S/DuHnUnWSR3opE50sJV9j5rb500+Hs2rE
         LWnplauMhhx46O/Zj2Gok6fojXdQGa3PwjIuV+QyOG9AflRh/i4CSG9oFwgxE1gRZYIl
         Vpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782303260; x=1782908060;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=okJxHmSjcn7bS5AFBkhOwnk9bTFJsGBQonzoKjBeB1k=;
        b=C+99lgzg8qga3VXWEKYXepEHHWAYl7C5JhlnYsf/CnJUny/QnXJzhFuAIyK1JTCEGm
         rw7UIVFXipkqsJgwxsosLO/s9t+CExqkpxnwTXDEU8RrPnLuWXBcJnPZIWeIDatpw8x/
         gacWXLfNjGJh7IltKcSGyQtVgbnqzu2IOxQiGR3Rzq8Mo+SA5i2DURlbFPtmwHq7Au/J
         YKShIREC2LK38ZQu0dWbsu3tOnaO7/QmUUX5xPrd1JP3oZxBRtGH8M7or65xvU9okD/+
         7IQMkGxelbjxrSKSMf9vLTbWSL24rorW3YUC2Y9WUQ9TI5OUUD+wDvMxz6y1SoLbNCb5
         FQrQ==
X-Gm-Message-State: AOJu0YxZB/KY+WfknBBJ9k7oRfdCy4489UDWiSGh2jYZskLyUxZjctFZ
	mdaAy+RcNZyWEowJ8NuJDu0p16/ZRY8qfbw/0TFPnYazxc+rdgZfmFr/HRWY7WvN
X-Gm-Gg: AfdE7ckALpp3VF7qlP7CqMXxT/tZngvsRA1+to44HG+0bPZ922vTdFnV34yXzZlhTYv
	t2h3FN3afGVKlGivigZDXv7uF0THPwU0EjckpZ4kXLCYzV3IX6HPIkxRLcDxIlNV7TuVmbdsN97
	/iBNuAuJhGBZX6ncvNDJreQXEPzpHKx6q2rVcjWsW8loxL9KK41ajM/0CsBMCB5pVbXM349jsOv
	2LsICOO1HdaWqhlq8RyS+nm8x4cye/ssGP8X/dUJLS0xA3TvzluVDc7SQG9FCJqFPBhq7SX31+I
	VS/ZjF+y0hI7K0X07uRLBHiCMQDUWUhDL4FaGIibcxQ2nZprJfNt2zJGSfcSqCRLecth/jPz+6Q
	mO4/hX7ZMJt8z/OrAZNuqE+n73Sw4+nBb6KKoy1r59oNrc4tK34J48DsEvrOP3JVRoBbjefYwGW
	WsAJNbv3cEsTl8pI8=
X-Received: by 2002:a05:620a:269b:b0:915:8502:f7fe with SMTP id af79cd13be357-9277e54cc81mr470570485a.15.1782303259548;
        Wed, 24 Jun 2026 05:14:19 -0700 (PDT)
Received: from [127.0.0.1] ([40.116.92.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fd391b22sm538247185a.2.2026.06.24.05.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 05:14:18 -0700 (PDT)
Message-Id: <6151b8e0a3989a51e6d9717e0ceac439f26f1c1d.1782303254.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jun 2026 12:14:08 +0000
Subject: [PATCH v2 2/7] t6600: add test cases for side-exhaustion edge cases
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

