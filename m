Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF003F23D7
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782479293; cv=none; b=ZbtJUsumvJLB+xI0Q8OKcWk1nlqD+pLV5Z7rMdoyiTKV+Q5VCK+32EeiDgIgJAK058KWq4Vw55TNCXtRI8qyPdqF9TeaUprlpXk/mK19k0OVlJTLDi3RBmR/WoJPbm9RZwDj2JcGTVaznAExQThYF0i+AhWH40/NRnHIh2vuYjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782479293; c=relaxed/simple;
	bh=O/jFhhQAvZl6kF2mI7b0UmvH9wKo5GsFXphU3ScIF5o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LN2yMNlj9h0KLrHGDZNXkaTnEcDUsYdUVw2bteuBhnukXKEGPTpnBNpJILwmyLEoKJ2SDkJ4cUX5VdaK0Cb+/9RQ9tjB6KZV7D9W3SIy7iXfxzNZxNT2bqwjZ2yfiOvnTY6878RZu09fqP0T3gbWXrKVrZWzpo82fO4W7u7rzew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKYdFkFK; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKYdFkFK"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-9157ec935c5so140425685a.2
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 06:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782479291; x=1783084091; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4CEdaL3wXcEP1AlcWsuZJDb3C13fQEZwrdmqLsOhBo=;
        b=IKYdFkFKhmVfOVbR+RHgpc9fSvIv2fUSUOWC8q/dQliG8r2tPXlklDIgfwWmHXzJYU
         iUwVuOqwGcEcMPs6IPLYv5QNDml7M8O5fGLSmyz7uqsalMkVLzlKC7NIotTOK3VeS9A4
         0/eUfV92XsxkCs+iPUohZpW1Obqip8dUOjVNEsJjkiwsmMbuQYLu+2Lr5VsgrbVzHGtd
         2hzskprWEhdPkEy+EKoA0IS2huU00eyVxJIG+zUef/VEipsDda6/tSA0KSve/2fWwPt0
         XuxHfpt0ggBmtLUysXHobrZX70aIso0A/6dk8jlDpIvtb8gW8tuOw1hv9vy11R3SCZxC
         eDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782479291; x=1783084091;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y4CEdaL3wXcEP1AlcWsuZJDb3C13fQEZwrdmqLsOhBo=;
        b=HgJvEUhJL1svPJ/jcnPRQAVSg8XKiq1nfKoAsqo1MASJ8L2r2G9uP9RL9501UrdHFz
         Zy2X4etuz4U5FBI9ZOe5xqaAG/JXhFWg9MoTuoAejPhEJCQOq/HEckDHdJiOjon/3Hd9
         EYP4bCMOEb48gKFKoGnOjRMXXBlLGe7prYZhBlpBU1mgvnAZC1HSdSGAKZ/+7nC5wGkY
         wIqADC9YfCbOJLXpIs1LIWA4ZgSN6fmJZD2p44oz5oHhM7HMSNGs6tkRx+8s0f52muxo
         DYx9XqsG/kcmVKkR1AF2K99NZ2tqjs1Ney5xgfEMk2V2bd2DbVVi4S+TcpEtC9nr8u+o
         KHlA==
X-Gm-Message-State: AOJu0YyGiCk7hmkItKcsRH7FKDwoM72EdGcpAPosNuqkKjxUnkb7pSMa
	neSABgMFa//p7lke5PBqIkDDDVQaeLTWR2kUIGAWioYO7+7NV1hgmPKcNjt+kg==
X-Gm-Gg: AfdE7ckmyyO8798mbU4FmKk9MWyY4cMX95n5eX0xg3iX5N5DHMzET7HfdhuyfX6Ls0k
	EmVioeCLZ8eybRawEaxtfnCrBD0S32Lm3zlkY78vmhlKHmTw4NmzPCzBuaQx1CCZVnniasiiUEA
	SWPcCcvUSr9DkhCf0QXuKpu34OlbID4YPBXUttyxX67GuE0X0huVGLthnDucQBrCNNeAu4ulx4o
	7higO5Y64z9KcIGDNQVVu7kWc0Ky6iCfWzV/huxiRLlj024d3B++KyElHl9U4oWuhguaTGb3QX7
	n0r1CZF8dTXylMsU7n6FyhytV6yORXEbjTMK/NFNAAAlTf/wcgXua5XFXbxFBFqyzf2/02Sbtv6
	cqwvQHFvdZetnvZ8ZOfjLTzxZVlh585jzF0kAxh4Tk1gCNcEJaVwKvRbrM8aesZfnHaCmwlLMiy
	2Piir0KPUXNri+2g==
X-Received: by 2002:a05:620a:2a05:b0:915:8f76:8002 with SMTP id af79cd13be357-9293ddadd93mr1070659985a.42.1782479290584;
        Fri, 26 Jun 2026 06:08:10 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.47.115])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926004ac1acsm1138689585a.32.2026.06.26.06.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:08:10 -0700 (PDT)
Message-Id: <14b0d86b93c1c9e733e16b1d4786b227f3651c55.1782479286.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
References: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
	<pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jun 2026 13:08:00 +0000
Subject: [PATCH v3 3/8] t6099, t6600: add side-exhaustion regression tests
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

