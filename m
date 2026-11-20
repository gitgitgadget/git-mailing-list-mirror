Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177385;
	b=vMzJ1nusxeES/4mXSW5cY2ysn5HPy5wLIYq+k0ADEVuFOiLfPQk56k/JEhnE04ojMHK6
	 7zD2XH33bdjiUzW5JGkgoEh8kl5wui4WfUQ0/twh9MZyUmDCOjhAI4o7+Hflm2ZLlrtYe
	 K8K5g8rSWWzaIIH2g758wwFguUqSF3TwJYYUUbN436bzS52bjzjmBBozFDPKouUr00L0z
	 p+0copIyeHeTv3wYBoZ4Q3Wt3VgMy3xZYqT4Lt4ChMFVscNnqsbzfuLvp1aRvpQXAZR6F
	 Js/WB06SPFhNfR7Np5767Y2H0Yb3HI7fYN90DXkvSVUocpED7NCLzD99BSaVZuSAy+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177385;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=1BiEir0dzB3eBtKagF00mv8L8Gmm2g+DDrkuldjPgJs=;
	b=kl0PJlZfRCVGKHFpVvXTokk8H3nVI77gMIMd0wsSM2lNYQWWzGQ0uVqkH1an3CV2CUaM
	 WtARIAp0+JF7TMBO9pmoEmVlF+70YAusaqkW5ZL1vCk88JqOMBuDrJRZasL7Y9wpqIHgI
	 gJhsKE/OQQZC8+WLopQKr0pEyC034cDqC/IhWf7crfLBP74rSxTalu3M8SMhbUJQgs2Tw
	 RIo3Yze9mfRpgiSVvnGzCF0k9vvhaQhRtYckbs32qPEkya3offHIjAS9qe47XelcgFln1
	 jytX5om38yaUGq2W/K3nv2Ill2VbWJMNGxKIxIxDLBGxQpFbJ7HOa4HKo2c3D6Z8DUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=pklLbE0c;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3ZPVJKxM;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D659D606A320
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 12:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D659D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=pklLbE0c;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3ZPVJKxM
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E9255140023E
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 07:23:03 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 20 Nov 2026 07:23:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795177383;
	 x=1795263783; bh=1BiEir0dzB3eBtKagF00mv8L8Gmm2g+DDrkuldjPgJs=; b=
	pklLbE0cZnjD1jeGsO/l50BZqiUQcXrmiXSo7/ugVQKo6o48PNi3FwzKJ3XrFJ9w
	alOkxEMhDXMmUszJjOnQKoBrEhjTZZ2LWOnFJLeQGxDXgZrR5evDfFd32lAeBJmu
	OC3QvmyZIZHqRQup5RI4wHcXnH1fJyFZ+6DFo4DX8/4Gb5T/EKi4h9PGJghUMX8w
	hYElTM7Xau5jYwGLIhV0dxOgg1/OHjcOusQB/l1nIietaPMANxVpC7CRlN5DZkMG
	lAjxxMg1IfOxQv1CP1FauYdzwB/Wj5jhreLEENR508Euhq7Kubh1KbFeyPfKdIBw
	C7UBD6s7GZkh6eE9ufZO2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795177383; x=
	1795263783; bh=1BiEir0dzB3eBtKagF00mv8L8Gmm2g+DDrkuldjPgJs=; b=3
	ZPVJKxM6n14vfmc86+TKz0Yp4wE5Du/wLvDZHndrvHZMk2Z/CpGALDW61OAkFR2y
	EePidyM6MIjA3j10PgCXAs1pJK3MaNxsOVHArrqjSo2l6JEpRIeYF1QQPElHxqYc
	Mh0M9uMf2ITTuarKvnqEVQzo7BzZbEzjq6pheg3d8vXwY4MDnt2t4i2IflrAhKBk
	izzu2LFDzPJfEuhf1fm69XeaIOsS/TtbP8ZzfQ3XHjCL1tO020/24MyjrIrThhAT
	63LFSsLeizcWhuqQRcJAsc9edYoQTpPTOdlbJ1FlsF4jXGRVvBMa+hvMbD+qJXOw
	e7r7uFxhhFSmJyiFCTiFQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795177383; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:M3n0xkDGiPcHXFIXm1UYzYsSvT4e3TCvIsACVDcICa0MJvu
	Ef8VlrHfGZjr1EC+X047H7HTLnGLpx/W/PDkfqePKwISlUWTnMwxdTZ3JuLO7rT9
	qQ4YwoWClJjabb/aI17jr2R96tY2ybnMK7R+w+gfmrMWb10AjPTLvzLtvdMABoJO
	DudkfcQCO7rnkbnkB6Bh8xYjvZfFcwGpleL2+hz9Reegc/UhbukTt9kiCg36/C/E
	a09JtXDeHNNLUnv9PD5xW6jdRNc7q4o0BcRADmOPqgjMYM15p5GcEFb/sbd3xOv2
	hQ5jO9t8R82cwdJEwhsKqhiQgUKzbGpv92vJTWQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:a4yt29sEWzVJcdJgQ8XGaqnYDG1Innwq9ZRUAStzfuE=:HZrWD68zsu+KFTLAZ4GARwxKUTQcJo7kwzLP2A6FRtQ=;
X-ME-Sender: <xms:pzsAa61HPOOlJsepNts6VireXIInirBFatA0f5Hu3ImKlr8DkivgYw>
    <xme:pzsAazGSH9uVE00c3CEBZW6vyL5hFH94Q1tKuh6fgRaJzktDu_IBNfmO5rCgVa1rz
    QErYeU2hO3Rfz95GmMNfs8DzVxuHZFcCTFhVUQEj9n21zviMC9SmY4>
X-ME-Received: <xmr:pzsAawg7PiG3DZklU14p5DsLrfYDqtW6PqHjSvCjC6-MKWMQjSrhFKV7-TnTVBy5qVWVCng>
X-ME-Proxy-Cause: dmFkZTE30M4DhJ6BlHACvgSE3qTozkDJYeVV5N8aECYztHKd+6E8X7EyVKhmUcqZHARQ9G
    ej74kFF9SXDEsQnJvo5KV9xr56t6d7cAr5SC+cvGFgXtwIVM9RNry7YbsVmEwl8iGhUGYE
    i94KEexOvxUB3Xpfp+LqNlCW8iaxnYw1nOhKDw6IvPJZNp69jwBY818qCib3BngrmnpnJ5
    7GRESSQDlu2eh2zQMkObV8nXZWnGxLSicwIhnsgfCcv0yqz5g4qu0XlVibB6OGdKMoRGc/
    hDCA+IMYG5jWIBgOpjbR8IU1dmxYNUIQnl75V1QWBKAUdVL/kuH07PjlVt3ejjqggP1kFZ
    Op370qGxjxw78NJRjJvvlcQDriachmKrGd2OqO9a6f/4t85TCEjwkBTFDKC6vbL1cssXaw
    T+Z9H7SlPuPXTuTZCSv3r/jk+gHWqJRRzh4jEVhwbvMB9MvggJph0vwZ5Ut/Q8BR/tvmaZ
    gFXBTXKeEejklfTH54ceS9ar0Xj4lMlAMk0rIG1yP2l8hqezDyJ3YMyMqaAtTawJfrUhn6
    wM8SlAlJSKaQS4zCxBbt+5lvns+cJvAQRcbvV1BS4KylJ+/g0iTqAx/mvlCEzx/IXWbW2e
    8e0e7QqlhHavbbUIksVH8o4uHVCdFa2lrVSUtfpCjxsQW+9VDiwIzq35ScyA
X-ME-Proxy: <xmx:pzsAa2-bwpN4xrJevQZWZgP8o9oE8oh6TpzlmKoa2mZ2Q5iivnHWiQ>
    <xmx:pzsAa_plnDe9daEk0X4C63NZu3XTGFvSGT5zkjzsQNC1y_VN5tVePQ>
    <xmx:pzsAa9_yRZ2CjZM-5onzVZc6QcM6ObHtsl99In7TGxXrYp4QnYg1wQ>
    <xmx:pzsAa7V1JfL6ak6iJFiMBC1YXttnqTzt2szlST4sRf7Dx3eSl9c0sg>
    <xmx:pzsAa2Owd7oYn-89-D-FaolGDqXQWckR-HoBv_uJ2dpwylLGn02VmB6l>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 07:23:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 461138cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Nov 2026 12:23:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Nov 2026 13:22:49 +0100
Subject: [PATCH v2 1/7] commit-graph: verify all trailer hashes against the
 chain file
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-pks-odb-pluggable-commit-graphs-v2-1-31f2341a9932@pks.im>
References: <20261120-pks-odb-pluggable-commit-graphs-v2-0-31f2341a9932@pks.im>
In-Reply-To: <20261120-pks-odb-pluggable-commit-graphs-v2-0-31f2341a9932@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Since 118bd570029 (commit-graph: add base graphs chunk, 2019-06-18) we
verify that the hashes in the commit-graph-chain file match the trailer
hashes of the respective layers. That check is performed in
`add_graph_to_chain()`, which is responsible for linking a layer onto a
base layer.

The fact that we perform the validation when linking means that the
check of trailer hashes is delayed: we only verify the hash of layer N
when linking layer N+1 onto it. That of course doesn't make sense, as we
will then happily use a layer with a mismatching hash while dropping all
layers built on top of that. What we should do though is to cut the
commit graph chain at the first mismatching layer.

Furthermore, this also means that we never verify the trailer hash of
the topmost layer: there is nothing to link onto that layer, and hence
we never verify it.

Fix this by verifying each layer directly after loading it.

Note that this breaks two tests, which both implicitly rely on this old
behaviour. Adapt those so that we observe the expected error and add two
more tests which verify that we detect invalid trailer hashes in the
lowest and topmost layers.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c                | 20 ++++++++++----------
 t/t5324-split-commit-graph.sh | 43 +++++++++++++++++++++++++++++++++++--------
 2 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index da65cd3deb9..0c75939910d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -580,8 +580,6 @@ static int add_graph_to_chain(struct commit_graph *g,
 			      struct object_id *oids,
 			      int n)
 {
-	struct commit_graph *cur_g = chain;
-
 	if (n && !g->chunk_base_graphs) {
 		warning(_("commit-graph has no base graphs chunk"));
 		return 0;
@@ -595,15 +593,11 @@ static int add_graph_to_chain(struct commit_graph *g,
 	while (n) {
 		n--;
 
-		if (!cur_g ||
-		    !oideq(&oids[n], &cur_g->oid) ||
-		    !hasheq(oids[n].hash, g->chunk_base_graphs + st_mult(g->hash_algo->rawsz, n),
+		if (!hasheq(oids[n].hash, g->chunk_base_graphs + st_mult(g->hash_algo->rawsz, n),
 			    g->hash_algo)) {
 			warning(_("commit-graph chain does not match"));
 			return 0;
 		}
-
-		cur_g = cur_g->base_graph;
 	}
 
 	if (chain) {
@@ -682,13 +676,19 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
 			free(graph_name);
 
 			if (g) {
-				if (add_graph_to_chain(g, graph_chain, oids, i)) {
+				/*
+				 * Verify that the loaded commit graph's
+				 * trailer matches the chain file.
+				 */
+				if (!oideq(&g->oid, &oids[i])) {
+					warning(_("commit-graph chain does not match"));
+				} else if (add_graph_to_chain(g, graph_chain, oids, i)) {
 					graph_chain = g;
 					valid = 1;
-				} else {
-					commit_graph_free(g);
 				}
 
+				if (!valid)
+					commit_graph_free(g);
 				break;
 			}
 		}
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index bf7ba0e5580..aea89f42fa1 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -16,9 +16,6 @@ test_expect_success 'setup repo' '
 	infodir="$objdir/info" &&
 	graphdir="$infodir/commit-graphs" &&
 	test_oid_cache <<-EOM
-	shallow sha1:2132
-	shallow sha256:2436
-
 	base sha1:1408
 	base sha256:1528
 
@@ -275,13 +272,17 @@ corrupt_file() {
 	printf "$data" | dd of="$file" bs=1 seek="$pos" conv=notrunc
 }
 
-test_expect_success 'verify hashes along chain, even in shallow' '
+corrupt_trailer() {
+	corrupt_file "$1" $(($(test_file_size "$1") - 7)) "corrupt"
+}
+
+test_expect_success PERL_TEST_HELPERS 'verify hashes along chain, even in shallow' '
 	git clone --no-hardlinks . verify &&
 	(
 		cd verify &&
 		git commit-graph verify &&
-		base_file=$graphdir/graph-$(head -n 1 $graphdir/commit-graph-chain).graph &&
-		corrupt_file "$base_file" $(test_oid shallow) "\01" &&
+		tip_file=$graphdir/graph-$(tail -n 1 $graphdir/commit-graph-chain).graph &&
+		corrupt_chunk_file "$tip_file" OIDL 0 ff &&
 		test_must_fail git commit-graph verify --shallow 2>test_err &&
 		grep -v "^+" test_err >err &&
 		test_grep "incorrect checksum" err
@@ -341,6 +342,32 @@ test_expect_success 'warn on base graph chunk incorrect' '
 	)
 '
 
+test_expect_success 'tip layer trailer must match chain file' '
+	git clone --no-hardlinks . tip-trailer &&
+	(
+		cd tip-trailer &&
+		test_line_count = 2 $graphdir/commit-graph-chain &&
+		tip_file=$graphdir/graph-$(tail -n 1 $graphdir/commit-graph-chain).graph &&
+		corrupt_trailer "$tip_file" &&
+		git -c core.commitGraph=false log >expect &&
+		git -c core.commitGraph=true log >actual 2>err &&
+		test_cmp expect actual &&
+		test_grep "commit-graph chain does not match" err
+	)
+'
+
+test_expect_success 'base layer trailer must match chain file' '
+	git clone --no-hardlinks . base-trailer &&
+	(
+		cd base-trailer &&
+		test_line_count = 2 $graphdir/commit-graph-chain &&
+		base_file=$graphdir/graph-$(head -n 1 $graphdir/commit-graph-chain).graph &&
+		corrupt_trailer "$base_file" &&
+		test_must_fail test-tool read-graph 2>err &&
+		test_grep "commit-graph chain does not match" err
+	)
+'
+
 test_expect_success 'verify after commit-graph-chain corruption (base)' '
 	git clone --no-hardlinks . verify-chain-base &&
 	(
@@ -383,7 +410,7 @@ test_expect_success 'verify notices too-short chain file' '
 	)
 '
 
-test_expect_success 'verify across alternates' '
+test_expect_success PERL_TEST_HELPERS 'verify across alternates' '
 	git clone --no-hardlinks . verify-alt &&
 	(
 		cd verify-alt &&
@@ -394,7 +421,7 @@ test_expect_success 'verify across alternates' '
 		test_commit extra &&
 		git commit-graph write --reachable --split &&
 		tip_file=$graphdir/graph-$(tail -n 1 $graphdir/commit-graph-chain).graph &&
-		corrupt_file "$tip_file" 1500 "\01" &&
+		corrupt_chunk_file "$tip_file" OIDL 0 ff &&
 		test_must_fail git commit-graph verify --shallow 2>test_err &&
 		grep -v "^+" test_err >err &&
 		test_grep "incorrect checksum" err

-- 
2.56.1.831.g720f3f5937.dirty

