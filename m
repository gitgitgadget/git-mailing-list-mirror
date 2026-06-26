Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A665B3F58D9
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782479295; cv=none; b=X+mVQPtmAKNcPaRsNBHs7mq+EZh/A54fF2FHnJ6j1mP+UMsgy/oQLN4K1la3KGRGw1RZJa0J4qGP7kMt27sHH9rIt2LM4O4Hof16nTJ+wKynFEkyWwlOBm9ovC4BJKJhVrAOrTl0bEcmMezWqdvR8OcJGT2QWx6fnbNql7alYA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782479295; c=relaxed/simple;
	bh=JSq9v1NIIKhiIW2skLG8FLvJHF33L2lqLpln09PPpb8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=un/8QGE/XZXhiF/kki57UGGfK9kVrnQepflGA5+QwSsC3myHusMqIdkQn2b0aO3JU60mY1/Vb8xc9Yd93Jf6wMwJ+2ThOtiddph44lmsT39gR7EMdmp0BIRxPkqFs1V2pEwLLkh0EP4VPv0xEUk3yfo2MaUc+jvJmv1Ag40meT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzJwvvRV; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzJwvvRV"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-929a7eedde8so92162785a.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 06:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782479292; x=1783084092; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjGbfVKb6/pTT2Iv+JCTMPtKFPUMQ5q9NPynWZP+qR0=;
        b=IzJwvvRVwdDsfShjfdpxePP6c5wBoZFlCYKHotzTzHQc4AFkpWH19/hnaZregJSXr/
         vUqPZltGuswxt8xtnkXUHTg2EseR6GsP7WFIkfhJCbOt8P2Xf49WF9oMv2v3eMr5kBEl
         B+ZN5W0yAlJz0qCmzAqzdfgRtqaGZmTzQkh6+cRs/6qPOR7GhN02nLgcte31y8IflbfA
         f0rsrMoG6h0sWl1BawTYU4ImxpJPyxURtT1vLXI6WqvM2axyC7Rb6+yVceeplAbH41ur
         QeLzGMVgeRSzxMCJ+lY3fQcGdqNd6Q0VnhQ7BhSA4wqBiI5S7xARpUQqnm7W3JhPRNGF
         1DVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782479293; x=1783084093;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rjGbfVKb6/pTT2Iv+JCTMPtKFPUMQ5q9NPynWZP+qR0=;
        b=ahCZUmB+1yxDKNEC2CohsTEBRLTx5yXRqWZ1d12REX4xtF0fFlOHEucUwHYw2FKwxr
         neD6MP4OakH0o26dzpoZBsGsg48NTFhoE6DuzLsO718jTAdOD7d/HAtYApGbamceuMXZ
         J4QvsUMBqMb31UMq4wyVqC73lC81re4drGY1TWss6YMX2HFS5LWy5jnhauP2FLqEBnSe
         yDPRJ24pmCqJIJQzB5Pbp76oYy5slXmQPeJNRwmobSdSRWVIFZSBPIhC/5PfKW46qtyv
         HMLoxb9Ss8fwfjToe9Xa9WTe7zSxxTaZ4yDOyK8zHQJZwCl4GjlU/a6/7xXqku6i8b4t
         +DPg==
X-Gm-Message-State: AOJu0Yz3l6pgwsbLLQaZNBDFWKcmt2uibxf8siOTN5YQoH/kqDtYexZ+
	z6grcitp6kMopwtM6Xa/BbtpR9O2GnsO0Qcp9HIQ76VxlA1yizHom4RoikZlaKwp
X-Gm-Gg: AfdE7cm4vLpZk/+U9yzp6yQxV9ScgYjaR+TybCkm41Dte5CVi6YqRPA36s4J+ro1Hs5
	+opwhov0gX/eQvFlTdPgapqVeTxYflCq2TEnH7TkwlbtFzQoFy03IwPwjdNZvrlkKm41BZjxcK0
	aD9+Gt0FSoiBMJLUJszaM7Qu4sUKjffliEeKd1/TFx5a1mUrzbPyw3/agEvPiyeJgOULNilrYBQ
	UxVfj/5bm6p5GWYwD1c+4wkvTEEvl0p6yoBXs92uBx1DPpFGhVH6hZtERfm2eZ+nZ0DQRhp7SIg
	lA/CE48CJILuyr14k2rj3poXmIe3ETVEOn8zYehfVEvshXpNqc8DeQmTwDn6Qd5LPsjCj8m655w
	hC6MnPJ3S7+e/VCwQvUGI45B7CV7bMksts38ff3UZvXN9lPK2kq95EdffKiVdYNqJO634/EECMC
	0ejPPc7e0u7MfMVQ==
X-Received: by 2002:a05:620a:a195:20b0:92b:4ce5:6390 with SMTP id af79cd13be357-92b4ce57573mr35986185a.25.1782479292557;
        Fri, 26 Jun 2026 06:08:12 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.47.115])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fe040904sm1156300185a.20.2026.06.26.06.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:08:11 -0700 (PDT)
Message-Id: <2592264cda543c96c4479bb4ba6368c0121e4207.1782479286.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
References: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
	<pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jun 2026 13:08:01 +0000
Subject: [PATCH v3 4/8] commit-reach: add trace2 instrumentation to
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

