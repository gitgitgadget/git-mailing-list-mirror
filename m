Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0858350A10
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782649562; cv=none; b=kcd3WKaK+WZJiwFxyhPtc3UHzc31W++vtWEpNI60XPQasbzLgKBSqgJ4LxFz/mzxmJScet3vSyU65qw4D7jRsmmtDD7Vh5K4mZ0uSU7B8cu4r/iBIXEIhYpcSNcg/8z06i5pKteUqmwwQacv9tADqxdHt9FJEooFWH7HAYofKFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782649562; c=relaxed/simple;
	bh=JSq9v1NIIKhiIW2skLG8FLvJHF33L2lqLpln09PPpb8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=R4GVsxbMN9nzWo9TpxKpmfu/V8aV4GrciS9kDGOHt3vuVa2vE/Hy6KOepflmqNCz4CaCM35HCXcq3YE0Nya2st7P29Sa9gGrUAXLuxMlSmbXHzz8Tp8jSLlWnINxXXVOzOII5PKmm+5uCzkNrX0uRC7/42BIPCl6m3/y4Bsp9Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rLxONfxi; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLxONfxi"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e45d3658dso28282885a.3
        for <git@vger.kernel.org>; Sun, 28 Jun 2026 05:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782649560; x=1783254360; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjGbfVKb6/pTT2Iv+JCTMPtKFPUMQ5q9NPynWZP+qR0=;
        b=rLxONfxilL4GWlqhznoxNgp1+M9ad5FWQlFlfl+PYc2ebPVnvlmpwaSJ1bCd/6P1OD
         /vGERtjaZrPgR5f0G0+iPYCWCE53ghSobpVQEARb/x5hH69Sujh0kPjr7oHJUteKhi1l
         sx+t4c7+JAycxNB4rkDXYGksyh7AQhonQtuW65g4Cd6iE8Qje0BvURJ5HH6YnbhoDzXh
         9spAsRJBLSk9XzPiIu0rAxQ62BDmYhfISMhIGTjoJbbMjgR8U1Wqo1iK/tzPGGkVHrpK
         xiTacPiYHs4BDIlfSNNX8PyLOYBoCoYiG8ZuSRIZw75krIrNZ/EYXdj0kDBOM8glPzQ8
         GgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782649560; x=1783254360;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rjGbfVKb6/pTT2Iv+JCTMPtKFPUMQ5q9NPynWZP+qR0=;
        b=rx6nfUGbhbcsfQrLQdr7bJbZioHUMExItQB9zmf7g7l+JmxLQVOoNqcx+NW8joqh4y
         0vmGXaHCh72A4NV8ACrEUj41OfQDx7hQebS6gbPOFk2T2eC6gKuLW0CQimOEzopAJI7n
         6w4fC7dOLCwDsFhKgtNcjqAnb9ngXH8om494fQZD38zv/rrCw8nqbJUNGZdxykTTcCSg
         gWtUwbT98MOK4Yw18KWsf5QqDJdBsU/48CNnt1R8ZsC0B37GgA/QosYHQo5dDd1mRe5m
         Lc/Z0TrIgO0j7reVYCyekX1U8rSqH2I+6MvbEAH6SeRjcEI99cwv00AVH30ybdUpJDJJ
         /mRw==
X-Gm-Message-State: AOJu0YxyxSul3X1BntpzEVME3x1UveCtQ8s4aAQmhW+krKeTk6WsrzJo
	2XO0D2qX1G/cn79I3f+0qSFz1BrWqkQVLnPrSMTHdpaFsLaZPyqscexYYnFOtg==
X-Gm-Gg: AfdE7ck0r4jGOvy6/AXBteSv/4++FchBjnbTiIIMjLx9ADaGs3cY/CaDipwqzfBve59
	cAiYjr13FrTVj7AoTgLr0fsZf41/aqJDa/fm1SWbXRGKORl5QlTC+JxOyIMc+RoVl/TcuIAhNqc
	hFP5rJU9zlsaLF/wxmY00ulnKlU8rNGvndaZep4xgDg7s0NsV+q8w6LouVo5PkGGJ8EnvT48X7p
	LmDSk1oAiDAPhBH7DUAwXljE1RfSBwCBISC7cEIQiO9rBMCue26EpvrRqBzP2cluW+NVOEseGXn
	M48QlMNamI6OUuHLZty7XBUmysF5evvwZ9Mp6+tUr50MLQLwc6rmao+PcUb1/O+ocX3b5ZNxXn1
	JBV9r2u78kVmgU2od+QfIdD+S2p0LRuOHYfFL9B2jQTNeZPCGQH4IvBrcn5eMIP++OJF5DX62y2
	groHWHTpjY+thpamT6
X-Received: by 2002:a05:620a:470c:b0:927:620f:d0b0 with SMTP id af79cd13be357-9293bf2a5a9mr1914558585a.22.1782649559635;
        Sun, 28 Jun 2026 05:25:59 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.135.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e44f35c08sm302672685a.29.2026.06.28.05.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 05:25:58 -0700 (PDT)
Message-Id: <df3b090a2bf43737cb9b6ac9b4e769a658250bb5.1782649547.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
References: <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
	<pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Jun 2026 12:25:42 +0000
Subject: [PATCH v4 4/8] commit-reach: add trace2 instrumentation to
 paint_down_to_common()
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

Add a step counter and trace2_data_intmax() call so that the number
of commits visited during the paint walk is observable via
GIT_TRACE2_EVENT. This provides a way to measure the impact of
future optimizations without relying on wall-clock benchmarks alone.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 commit-reach.c        |  5 ++++
 t/t6600-test-reach.sh | 53 ++++++++++++++++++++++++++++++-------------
 2 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index a9483759e0..f6a438550b 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -11,6 +11,7 @@
 #include "tag.h"
 #include "commit-reach.h"
 #include "ewah/ewok.h"
+#include "trace2.h"
 
 /* Remember to update object flag allocation in object.h */
 #define PARENT1		(1u<<16)
@@ -112,6 +113,7 @@ static int paint_down_to_common(struct repository *r,
 		{ compare_commits_by_gen_then_commit_date }
 	};
 	int i;
+	int steps = 0;
 	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
 	struct commit_list **tail = result;
 
@@ -135,6 +137,7 @@ static int paint_down_to_common(struct repository *r,
 		struct commit_list *parents;
 		int flags;
 		timestamp_t generation = commit_graph_generation(commit);
+		steps++;
 
 		if (min_generation && generation > last_gen)
 			BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
@@ -190,6 +193,8 @@ static int paint_down_to_common(struct repository *r,
 	}
 
 	clear_nonstale_queue(&queue);
+	trace2_data_intmax("paint_down_to_common", r,
+			   "steps", steps);
 	commit_list_sort_by_date(result);
 	return 0;
 }
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 4b771b4c58..b3a31b80ac 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -118,24 +118,34 @@ test_expect_success 'setup' '
 '
 
 run_all_modes () {
-	test_when_finished rm -rf .git/objects/info/commit-graph &&
-	"$@" <input >actual &&
-	test_cmp expect actual &&
-	cp commit-graph-full .git/objects/info/commit-graph &&
-	"$@" <input >actual &&
-	test_cmp expect actual &&
-	cp commit-graph-half .git/objects/info/commit-graph &&
-	"$@" <input >actual &&
-	test_cmp expect actual &&
-	cp commit-graph-no-gdat .git/objects/info/commit-graph &&
-	"$@" <input >actual &&
-	test_cmp expect actual
+	graph=.git/objects/info/commit-graph &&
+	test_when_finished rm -rf "$graph" "${graph}s" &&
+	rm -f trace-mode-*.txt &&
+
+	for mode in none full half no-gdat
+	do
+		rm -rf "$graph" "${graph}s" &&
+		cp "commit-graph-${mode}" "$graph" 2>/dev/null ||
+		true &&
+		GIT_TRACE2_EVENT="$(pwd)/trace-mode-${mode}.txt" \
+			"$@" <input >actual &&
+		test_cmp expect actual || return 1
+	done
 }
 
 test_all_modes () {
 	run_all_modes test-tool reach "$@"
 }
 
+test_paint_down_steps () {
+	for mode in none full half no-gdat
+	do
+		test_trace2_data paint_down_to_common steps "$1" \
+			<"trace-mode-${mode}.txt" || return 1
+		shift
+	done
+}
+
 test_expect_success 'ref_newer:miss' '
 	cat >input <<-\EOF &&
 	A:commit-5-7
@@ -209,7 +219,8 @@ test_expect_success 'in_merge_bases_many:self' '
 	X:commit-6-8
 	EOF
 	echo "in_merge_bases_many(A,X):1" >expect &&
-	test_all_modes in_merge_bases_many
+	test_all_modes in_merge_bases_many &&
+	test_paint_down_steps 45 2 25 3
 '
 
 test_expect_success 'is_descendant_of:hit' '
@@ -277,7 +288,8 @@ test_expect_success 'get_merge_bases_many:pending-stale' '
 		echo "get_merge_bases_many(A,X):" &&
 		git rev-parse ps-B
 	} >expect &&
-	test_all_modes get_merge_bases_many
+	test_all_modes get_merge_bases_many &&
+	test_paint_down_steps 6 6 6 6
 '
 
 test_expect_success 'get_merge_bases_many:infinity-both-sides' '
@@ -291,7 +303,8 @@ test_expect_success 'get_merge_bases_many:infinity-both-sides' '
 		echo "get_merge_bases_many(A,X):" &&
 		git rev-parse pi-B
 	} >expect &&
-	test_all_modes get_merge_bases_many
+	test_all_modes get_merge_bases_many &&
+	test_paint_down_steps 5 5 5 5
 '
 
 test_expect_success 'setup mixed finite/INFINITY topology' '
@@ -316,7 +329,15 @@ test_expect_success 'get_merge_bases_many:mixed-finite-infinity' '
 		echo "get_merge_bases_many(A,X):" &&
 		git rev-parse ps-X
 	} >expect &&
-	test_all_modes get_merge_bases_many
+	test_all_modes get_merge_bases_many &&
+	test_paint_down_steps 3 3 3 3
+'
+
+test_expect_success 'merge-base --all commit-walk steps' '
+	>input &&
+	git rev-parse commit-9-1 >expect &&
+	run_all_modes git merge-base --all commit-9-9 commit-9-1 &&
+	test_paint_down_steps 81 80 81 81
 '
 
 test_expect_success 'reduce_heads' '
-- 
gitgitgadget

