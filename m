Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED83379EDA
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782479292; cv=none; b=p7dYNSexKM5td9neJqHJNrntjrZyJnDM2roJtTwCzsqgn/c+PAKQ7Lt2+spr5/oEQNPMLJ7zU5985rqoabviyFWHXqRg3gLzBUr+LXswVlGnzMb0WRue0I36+0XifOT/WXv67ePbeIy39Gndf1kjmpnsyV3cErK8l8m4Gv2VsIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782479292; c=relaxed/simple;
	bh=XhvYtf9Pt/7N7kxFXohFRXlI729ga1e3YtTJkIGhVbc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=e0Q3sbqlymIhucgPnwxtmzkBcnhb8gftFF0DnS1ILo/+J8C83IpTvrC+bU1NyE7iXGf5bw9t9P1kuF/pQ+dkO0iGzxvJNskvsd4WO0ldNumIbmcOCoUCnrKIXnqyoSsMCattslnO0t5ebxr5GeE4x4IE2ul92FS2pyJldFyP/j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buJDFDqq; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buJDFDqq"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-517dc520840so9982971cf.3
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 06:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782479290; x=1783084090; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okJxHmSjcn7bS5AFBkhOwnk9bTFJsGBQonzoKjBeB1k=;
        b=buJDFDqqd3HUMfkEkf/RoL4UtlhjMQSFwWgIq6K5itY+NfgAQLqTs9NEQSdUQWmJWi
         w0ix8OtJ45/qVaIKHzwtCcXvU7pLG4J5l30YtEhQQGgZPziJW6jNzTtuShOqJfj0d0K+
         6I1mrMWIGLe833aTrpMgMgWqb/3xUbjt2BRGAJXt/rFb8AUH+2JaI9x1/poQlGX6//fa
         r++x02zQdFq8e5DwTYR0N2TT3TxyTp5zTkomulFP9b0vhCqGyGNHSrcx6VBWcR+B050J
         xLLq04bwEFAAeKUttPWzKtJl4CdbFtUl6ggSRf94kiGC0bNuXqe9wVWuH9Y9IZ+q64sy
         TJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782479290; x=1783084090;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=okJxHmSjcn7bS5AFBkhOwnk9bTFJsGBQonzoKjBeB1k=;
        b=VqsSskYh0tKGVRCxcf8hR9bpNsqWcBkn+LllsEcjkzvkCQOWe3wjf6MaNImcuyE+cf
         5E58QWN4kL5I1mLy3+KSTxYsLe4HHZXdBasEDgCk4Da/AQfNZR+S/ac802Z4gDwmMa2x
         05PCaOMOrheSPPn8RVzxVICO+54du/RHd6RQK3/qKjC2lCcZ/tvm3o80c2FnPy7gEVQg
         B7XsL8N9BM/ccbCfOiHgAXpssmOdk3fIpebxbQmpvZ3wrSeODnh/ZABNSgffC+dz+ne+
         0ooSuS9ewkCSHDbPmgE4eRTHInuT0toQf2jDHyhXLdgOdQ7fYfgEttuAFOsGDpikJ+fF
         xmpw==
X-Gm-Message-State: AOJu0YwvkMKsV4Uox5G/nTlap7Jgawdbb749EhAkdu4h1KoI2ldp858L
	foD72gtkqw802Svn1yAR6Vj9A64BPQPUU3coZqgD8AuJ8W+tba5Ozuma3l1NcWSd
X-Gm-Gg: AfdE7cn3J5pW6Zc4T2dXJJ7mWpEY2je1mGjTi58n/O+iaHPI647gJaiD+0+NwtBFKQb
	w4urFHh0rop3DESkB0sdI4+Fy8XHpKfd8z3FSy9N75RVUDN6O0TFll4lu19NZTjara9Wi6zibqN
	h2f6luvnjuIFa4HDX3bl/WaA7/W6+u56LCvmNzlkbLab57J073gomMhZ8kSXCveb0rQjOgMOFKi
	zzn812mjUR2ls3kItMEWY/O9ZHJv46trfXtgHZLJ27xA8jTJvo1w4LGgVfeVDeHbgogtlPFWKZZ
	2QhMLootlvR3SiNrDtu+7s5kywIxTzp8GrSLLSQ3wRx/98EOvaiXT3n9nhntEpJYn4c/toxwbHn
	kAhsMp1o2y1F8OBJWWTrMKYc6346nYgM1FfOVBC8UzDV6xrHnvgpPjtr3M65yYdrsCftWIwt4yi
	FoXbMs9+VExrgXzQ==
X-Received: by 2002:ac8:5995:0:b0:517:9570:c1bd with SMTP id d75a77b69052e-51a7272879fmr91839861cf.25.1782479289591;
        Fri, 26 Jun 2026 06:08:09 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.47.115])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a51b0cc9csm94507351cf.31.2026.06.26.06.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:08:09 -0700 (PDT)
Message-Id: <9efc08485081a60614ecf99b5a37ce0a54d76e82.1782479286.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
References: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
	<pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jun 2026 13:07:59 +0000
Subject: [PATCH v3 2/8] t6600: add test cases for side-exhaustion edge cases
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

