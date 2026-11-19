Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116170;
	b=EYvCWDGG9H89FPlsxI55+dqbLYQYz92+wPLzS3B0wcqUa0R7Qp/n9KYCr2vo1n/g7XcF
	 oH+/b5LyCocfxgvmm25NtoEViEyV0EVNrT4RPHLBPcrYa35CzX2sVoaDKo2MbZ/2GPEp3
	 G/nt0QktM8yhFBnwdykqnALxw8jMrZUjqP82FmJ4Yw8Rx+MK+dtJVn7rT9atNeDLjnLxk
	 CEUfvCziJ8A5rbvnaIpbYPZbKdk55a8LdeQIjzCdQbZkbx08tkGzeVfmq0EXMp4N9cLjE
	 0Ca61h0YbzRaYn5K3cEnhfxiz1QBbWgfZhIvriLOx5TuO5H2FacT6KLdGUGZF6Ewz7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=94F3OYzmE0JfOUKYGJ7pnee6eUXE3VVXMPlH/5bvHnY=;
	b=p0qlNI4Ww47NWWn2Lc/DOjXK39ApIIAjTVjfZ/fHHaUdGXJ0XPwKz+OqNxo/IVNteN5X
	 ltIhfCQ2aFV/t2UF3SwFokbe34TzMcKcSUu+ffgED9qXiUDdAKs472VWhHORM723Co165
	 T7hn3fRDOZyIHI+EtooQvxpSAAU52LqaELxvB7dmgoTG6Q07NpZhilrlUfESdM4Cn5Qc6
	 Lh4zhLbmPJZI8JXbxDvJLNiY420bMELu6krcmdV4zPmo6ZlMrraO/zZNWWrwP2xlTBcmc
	 aAfVl5KEpf/R1S7YZL177WwHWBiHVTHQAHl7Q7czzG+MNt8HnLVysDXfW5QpJCYrzVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OZDFoQV3;
	arc=none smtp.remote-ip=209.85.128.69
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFED606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 19:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AFED606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OZDFoQV3
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4b9fde3044dso340035e9.0
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116169; x=1795720969; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=94F3OYzmE0JfOUKYGJ7pnee6eUXE3VVXMPlH/5bvHnY=;
        b=OZDFoQV3Se7cqnFlpEHPpQ1gXZFq4EVtX0Xu76Ut8fmBQZPPGzCcyHEXCFMtWU+KcI
         Wa9X0RVwzhjaQQCyg70zbUFBeVSUVbPra07nzxYYB3wmxB1vKmECYWoQu2Aetob+ySLn
         z+ubEpwqjiexlI9Zbw2Z1sYegpxgoB5Lh6y9wAv/U7ZNG0XrBbBtDcSCtTp6fymLkmzW
         AMWQL3nvosY5qeBK5EoJRMoIyaVYK4Djp11tpVgn1KhRkGCh16z1uGDNxMfkOKkjMhZi
         tDirLAomIYMLExifTOpy5sP8F4ZMmUKIUFC2cLbcHJYS6C8sMeo1YAcVyDfPi2HSgjCK
         13ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116169; x=1795720969;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=94F3OYzmE0JfOUKYGJ7pnee6eUXE3VVXMPlH/5bvHnY=;
        b=HI1IrLF1CCcAi9rcgLPf+2BSdRstz54o1mEKRtEIQ2i+CV580tGN4r/jnL8OOoFbf3
         gIZROQcTod64CaKWsOq7s/Gc7AIBeforLTESX0Auq7jnaDfpeitMj+N1/XVjYc59aqZw
         uu3cECnrHUu1wv0+ss5JobeOC10xXtaH2589dPurvtJcQaTgVn/q+RcWxkQdiwKO1Aig
         zQafeXCapLG+6r4yDJfEa/UBc57VdI1mtk7gcl7oUobQpub4G3OCEFluzVO+ZaESLiyZ
         1PLXx7lHOlv/PqPcUGWNXgSXA2VrmBKKxXoELGPEWLJFGUFwJr2FkeZZfMUY22tzxRiO
         GG7A==
X-Gm-Message-State: APuU4Z/FN3buasJHZsumW3XODMpCLT13D3LMEU0YDGapY+X+TDQsgt78
	E2MKrIsdcNNeqpis61wCDF2+Fn7kjYUW7/wkSa2V0jRtfqEHtef4uAng/MXsTUj9hGiVpk+LVqH
	axXorjwMqKjFH/SaA9/CwGqc+VPiY7VC46ec0FuImuqqALMsDid6AAkChfPt8hjsbhep+lXERkL
	zn3FgMvUsc6nWT3qOVMIvllg==
X-Received: from wmwb7-n1.prod.google.com ([2002:a05:600d:4447:10b0:4a1:a2ef:38dc])
 (user=dmnk job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4e43:b0:4bb:5bf3:8ee9
 with SMTP id 5b1f17b1804b1-4bb8893c2d4mr11563315e9.31.1795116168601; Thu, 19
 Nov 2026 11:22:48 -0800 (PST)
Date: Thu, 19 Nov 2026 20:22:47 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119192247.2671852-1-dmnk@google.com>
Subject: [PATCH] graph: do not fuse merge parents into left columns
From: Dominik Maier <dmnk@google.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Pablo Sabater <pabloosabaterr@gmail.com>, 
	Caspar Duregger <caspar.duregger@gmail.com>, dmnk+artist@google.com, 
	Dominik Maier <dmnk@google.com>
Content-Type: text/plain; charset="UTF-8"

In graph_insert_into_new_columns(), the branch that coalesces a column
into graph->mapping[graph->width - 2] and resets graph->edges_added = -1
is intended for existing columns to the right of a merge commit
(idx < 0) so that two adjacent edges can join immediately as "|\|".

When a merge commit itself is skewed left (merge_layout == 0), its first
parent does not advance graph->width, leaving graph->width - 2 pointing
at the column immediately to the left of the merge commit. If the second
parent of a 4+-parent octopus merge matches that column while idx >= 0,
it overwrites graph->mapping[graph->width - 2] without advancing
graph->width and resets graph->edges_added = -1. Subsequent parents are
placed one slot too far left, leaving the last dashed-parent slot in
graph->mapping[] at -1 and indexing graph->new_columns[-1] in
graph_draw_octopus_merge().

Restrict the right-neighbor edge fusion to existing non-merge columns
(idx < 0) and guard against negative mapping indices in
graph_draw_octopus_merge().

Signed-off-by: Dominik Maier <dmnk@google.com>
---
 graph.c                      |  5 ++++-
 t/t4215-log-skewed-merges.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/graph.c b/graph.c
index 95eef3a95e..a40834a639 100644
--- a/graph.c
+++ b/graph.c
@@ -685,7 +685,8 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
 		mapping_idx = graph->width + (graph->merge_layout - 1) * shift;
 		graph->width += 2 * graph->merge_layout;
 
-	} else if (graph->edges_added > 0 && i == graph->mapping[graph->width - 2]) {
+	} else if (idx < 0 && graph->edges_added > 0 &&
+		   i == graph->mapping[graph->width - 2]) {
 		/*
 		 * If some columns have been added by a merge, but this commit
 		 * was found in the last existing column, then adjust the
@@ -1317,6 +1318,8 @@ static void graph_draw_octopus_merge(struct git_graph *graph, struct graph_line
 
 	for (i = 0; i < dashed_parents; i++) {
 		j = graph->mapping[(graph->commit_index + i + 2) * 2];
+		if (j < 0)
+			BUG("octopus merge mapping uninitialized");
 		col = &graph->new_columns[j];
 
 		graph_line_write_column(line, col, '-');
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index eebab71039..632c7d2c97 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -509,4 +509,35 @@ test_expect_success 'log --graph --graph-lane-limit=7 check if it shows all 3 pa
 	EOF
 '
 
+test_expect_success 'log --graph left-skewed 4-parent octopus merge joining adjacent left column' '
+	git checkout --orphan 8_p &&
+	test_commit 8_root &&
+	git checkout -b 8_pA 8_p && test_commit 8_A &&
+	git checkout -b 8_pB 8_p && test_commit 8_B &&
+	git checkout -b 8_pC 8_p && test_commit 8_C &&
+	git checkout -b 8_pD 8_p && test_commit 8_D &&
+	git checkout -b 8_M 8_pA &&
+	git merge --no-ff 8_pB 8_pC 8_pD -m 8_M &&
+	git checkout 8_pB && test_commit 8_B2 &&
+	git checkout -b 8_TOP 8_pA &&
+	git merge --no-ff 8_pB 8_M -m 8_TOP &&
+
+	lib_test_check_graph --date-order 8_TOP <<-\EOF
+	*-.   8_TOP
+	|\ \
+	| * | 8_B2
+	| | *-.   8_M
+	| |/|\ \
+	|/|/ / /
+	| | | * 8_D
+	| | * | 8_C
+	| | |/
+	| * / 8_B
+	| |/
+	* / 8_A
+	|/
+	* 8_root
+	EOF
+'
+
 test_done
-- 
2.56.1.750.gf70dc682cf-goog

