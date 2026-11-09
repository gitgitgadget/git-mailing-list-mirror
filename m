Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794257683;
	b=snIbG/6zjm19iE7TCi1GZgc1sYEVoiGUeAy/gRHVPH4ISNGuXDOLg60cED87bgLUxWHa
	 UYd9Ii968nqn5LJoJIoneW2PbhAiyglOINp/+aqRj3vreQrIFondIG6JqHeBGq7suml/1
	 xfiHk2jTBZ/rQ4h9c0QglFlvv2jy5cmPuK7CDjP5zvZItDdINSRFcDcOMLtQFy9+Nk/jj
	 OvyBAR2Uv+nQJWJ/aKOaFbHx0TuCpZOzDu5s2DQrOkPGYwF2ySXEiXUUUlCscriTmaV7s
	 8+kJ0RwBHwBqvDM/sVlRlPb0lkGkqMboDh3oJhjOuHCHmvyAfhGJO1r3CH2tdQBzkbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257683;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Cst1EUctOev4HOwTGEmpJPGBlAZfRJ08kHAVt5EssL4=;
	b=Y+YIlY+hoM3jRBJ/5FEeDFucNoG1IbLI3OMMnh2c7Qcw01r46QzCCt8/B8GRtpQKfGGo
	 fy39HlqCJHtn/J63BT+CxkS3lwMfVrz6rJoQxD+ZAr7fFieNACfkjtknHOiFsE420eizR
	 r/4G6Hbnk1eG31jCUzNRPwxQkwOeKgWBOVShQ7jWlvvTZNdrlhR1IQpJNnLaKXj6YSCDk
	 EqCFQEEk0FlQjs18cS90a2EPk5g3QB8vba+j5VAk/9ZX9zJ3AH5+k6VLIcS+g1tGQrG8u
	 q9Zqtalxwsu5wZvaIzA4EggKxYk4oGFZ7yHFbalRjeqJtRhzfzZLqNe9cTEgH6m2jwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=brJO8ytl;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=aBU+llKl;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A09C606A330
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 20:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A09C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=brJO8ytl;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=aBU+llKl
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A7C8F1400196
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 15:54:42 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 09 Nov 2026 15:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794257682; x=
	1794344082; bh=Cst1EUctOev4HOwTGEmpJPGBlAZfRJ08kHAVt5EssL4=; b=b
	rJO8ytlq129r4/mjpgNypXylu/7XBqM+++qLnIsS+wX0SQIq+FgJhIEjjXJbbV+4
	qL63L4BvC0ELM2TmYD0+SRv1i1kmZwqUcogMNciGH38O9e3KJxZ9+HPYppPFUUQu
	eYynkp3+1PeKQk73UD57mlW4iF7PMo6BVR9EyGzQzhe6rPz1b2zQ3u1Q9bsz/0pe
	XV2SLD6W4+Q6CrHrZ8khFH8vNVnURS13l2O99R16E9FVdcZpDfm6L5gux/dTy699
	ckM0JUldA+VMnWnrn2SqMz8HFaHXQfGoeLSpbr4ruFoG/cLzaAFBMCgbLXFk1Hxa
	TMwzKf7ZVlONezB1xnZTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1794257682; x=1794344082; bh=Cst1EUctOev4HOwTGEmpJPGBlAZf
	RJ08kHAVt5EssL4=; b=aBU+llKldJI3+ijj4Eu8sJPdqxHysumyeja5nFu5QBhQ
	wPpNEb/VUYYsZVCBJZRETDGXQEK34y4RA4esVSXJagvbQvqye4atC8JlBj8PRgml
	/HofzSUXwv/hGfX89zRQREp05wewNk1dEiuyrNVxY6pTEi6mZIvGJoC7Isk2fdHa
	ncgnpmtvajkGgrXH6ewi5Sd1YNW8nCB9MeavdhtkauZERgXhOZdvK51362CSM9+A
	NoyTAi6CYTaGdp2lU+llvkpMoTJmHwWlDtx6r8WH+gmB5LD0T4dqIQhB3xY5Nuah
	IC9XnRRqqZ0LHehDtWStkjTU5+VLduQ0q/SrrUr4Qg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794257682; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:QjfY2HFS0tMxobOKFCFw4Z+4DHsGC0+CJLK7fbVgWT3qawr
	CG0pk6iQeeXnmIJNTp+cUslND6i/9+o70jwqhTL/4wcCGP5ZBYLQDyXPI9XT7985
	utSCprj/KWHugTGp37wyWl56dI3nE8+pV3mDFHL51p0Oyt5mSscS+BoPzS+Ma6+F
	1X+aKQgzIoT2i7CPYMr5QBf9nOVjljZ0jPMN9HFZoLEE6Ye4EmuHPNEHV/j/uPmV
	1cPTXvP32Zl6Mc55iHUCJzZu/kJgvuXEey/qppu0jwOlKtwVo9pM3M4J1v2NqsjW
	iBOcQjvx6s/wFqj7VhYXTB55ot2eKO8lnlEUVdA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:as/NHFH7WMLqidVim2W0TXI5tkh7tJSd4VxKYf7H/s4=:IzTyURIl17SNN8ySx1fqMuvElaXfzH18ofgpQkQxOHM=;
X-ME-Sender: <xms:EjPyajQYDQJidHBqhxxjT7Kt1nCfrT0PmzT0IhSSqszDYPlI3h6Y6w>
    <xme:EjPyaqyl1ePB7DcVs-5MxaH2mtLpiPG3ASXy12rcIFLIpW64olMwmROKHlvN7Fs63
    n3UDorKsK6guPbMMRzyDVcDLfdDxTO6O9r9xoDcGFNZ7d5H4No2vg>
X-ME-Received: <xmr:EjPyamcIqQtsbNQJd1KNl2ZOc5C69HaN6f9ybpeTb3Y7jnU6sCHLu9IOV33EkpGAN618IYQ0MCvMzSnOrTlMjHYdYsGC-uDDFdso>
X-ME-Proxy-Cause: dmFkZTGqpDG5vOQYYKwYqtAN6qPQdfFTNzfSlcGZ8WSRu+3vC+RN9gWCiiH4iY2RZMleiy
    CTc+UAzOBAbx7rKLpYPV4qaEpgLcK5DwmNeCMo5aXjhFs7mgpxOf4BUM7F3o/6Y+Piw8fS
    iq3l88m8VKmyukTAknxl+UPz+foi5fv47pT3myWnZrrF6sx3FyISE0kR6uh3JIkPraVjZO
    3rV+t49YGbnh+Nw1MkQywn8XgM1JrOaqaDvV5Ix6DLPW8AXe+gKWRV7A2yjdmohrGY1c3+
    78INLa5J1RtsPx9OWvq+4VeVJvo1vPuoO5NMOsRmu+4BfaCiIUqmAAKcleRTZo0cWPvxcS
    7Ozg3nQx5O4sXzlunCqO/BtUo7CvwAQV2cwCIA2XhwI1uHhkvgUXCOlruAbopJrRBh+B6E
    l+sHn0/3HCnaC96863e+mciwH8xsbR2aF7m/T49b91P+WJDex/MbAeM+tnMXhbfoBG3L/e
    nsdIvx1Z6YqF7AfWXsttnapZBccxPuUZNsMzJ3YbsFZ3BjjqKg+Ct2Mftu8QMBCXvh13kl
    7l+Zx17cmFkKJZL1SeV2pbuOYUsc9MX2dTSSVtlE1kfEfBqvQn19AdOB1vQL9UEfM55Z02
    ZpJ5ZVgv7e+0aqyGaZ2XaaRemtnRcF6ltJgbSaypjMnjTjtB/kLUkO44pQOQ
X-ME-Proxy: <xmx:EjPyauJmUw0gvNKLMJVx7_kINOSqVcT-C5pbAmxBdh9oztbSqFxvSw>
    <xmx:EjPyavFXEFk32OK7VPFL4DjVJVTW-Vp4bp_I4Xey3j8tY1uWR97ZMg>
    <xmx:EjPyagrju0iRrV3kB5RZpjo-n9Ud0_nhCh98aPbx-3SW2CZXvPaMSg>
    <xmx:EjPyagRax5pNB5cI6HV3LdK80-CBS3XXUFrZjOpUNuJ-OBbXMVz6MQ>
    <xmx:EjPyampQ9iTF7WybzroQX8aa7tKxGBAHN7i1oY6w0Pj90LlmeQOnCwak>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 15:54:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 2/2] unpack-trees: consistently use "struct index_state *istate"
Date: Mon,  9 Nov 2026 12:54:37 -0800
Message-ID: <20261109205438.369060-3-gitster@pobox.com>
X-Mailer: git-send-email 2.56.0-626-gaba6dc7e00
In-Reply-To: <20261109205438.369060-1-gitster@pobox.com>
References: <xmqqtsltbfdv.fsf@gitster.g>
 <20261109205438.369060-1-gitster@pobox.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some functions that call it index.  Make them consistent.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 unpack-trees.c | 94 +++++++++++++++++++++++++-------------------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index a1f7d8bd6a..0d00f6120a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -388,14 +388,14 @@ static int check_submodule_move_head(const struct cache_entry *ce,
  * (2) before checking out entries to the working tree if the gitmodules file
  *     has been marked for update.  This situation is specified by 'state' != NULL.
  */
-static void load_gitmodules_file(struct index_state *index,
+static void load_gitmodules_file(struct index_state *istate,
 				 struct checkout *state)
 {
-	int pos = index_name_pos(index, GITMODULES_FILE, strlen(GITMODULES_FILE));
-	struct repository *repo = unpack_repo(index, NULL);
+	int pos = index_name_pos(istate, GITMODULES_FILE, strlen(GITMODULES_FILE));
+	struct repository *repo = unpack_repo(istate, NULL);
 
 	if (pos >= 0) {
-		struct cache_entry *ce = index->cache[pos];
+		struct cache_entry *ce = istate->cache[pos];
 		if (!state && ce->ce_flags & CE_WT_REMOVE) {
 			repo_read_gitmodules(repo, 0);
 		} else if (state && (ce->ce_flags & CE_UPDATE)) {
@@ -407,16 +407,16 @@ static void load_gitmodules_file(struct index_state *index,
 }
 
 static struct progress *get_progress(struct unpack_trees_options *o,
-				     struct index_state *index)
+				     struct index_state *istate)
 {
 	unsigned cnt = 0, total = 0;
-	struct repository *repo = unpack_repo(index, o);
+	struct repository *repo = unpack_repo(istate, o);
 
 	if (!o->update || !o->verbose_update)
 		return NULL;
 
-	for (; cnt < index->cache_nr; cnt++) {
-		const struct cache_entry *ce = index->cache[cnt];
+	for (; cnt < istate->cache_nr; cnt++) {
+		const struct cache_entry *ce = istate->cache[cnt];
 		if (ce->ce_flags & (CE_UPDATE | CE_WT_REMOVE))
 			total++;
 	}
@@ -426,22 +426,22 @@ static struct progress *get_progress(struct unpack_trees_options *o,
 }
 
 static void setup_collided_checkout_detection(struct checkout *state,
-					      struct index_state *index)
+					      struct index_state *istate)
 {
 	int i;
 
 	state->clone = 1;
-	for (i = 0; i < index->cache_nr; i++)
-		index->cache[i]->ce_flags &= ~CE_MATCHED;
+	for (i = 0; i < istate->cache_nr; i++)
+		istate->cache[i]->ce_flags &= ~CE_MATCHED;
 }
 
-static void report_collided_checkout(struct index_state *index)
+static void report_collided_checkout(struct index_state *istate)
 {
 	struct string_list list = STRING_LIST_INIT_NODUP;
 	int i;
 
-	for (i = 0; i < index->cache_nr; i++) {
-		struct cache_entry *ce = index->cache[i];
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
 
 		if (!(ce->ce_flags & CE_MATCHED))
 			continue;
@@ -472,33 +472,33 @@ static int must_checkout(const struct cache_entry *ce,
 }
 
 static int check_updates(struct unpack_trees_options *o,
-			 struct index_state *index)
+			 struct index_state *istate)
 {
 	unsigned cnt = 0;
 	int errs = 0;
 	struct progress *progress;
 	struct checkout state = CHECKOUT_INIT;
 	int i, pc_workers, pc_threshold;
-	struct repository *repo = unpack_repo(index, o);
+	struct repository *repo = unpack_repo(istate, o);
 
 	trace_performance_enter();
 	state.super_prefix = o->super_prefix;
 	state.force = 1;
 	state.quiet = 1;
 	state.refresh_cache = 1;
-	state.istate = index;
+	state.istate = istate;
 	clone_checkout_metadata(&state.meta, &o->meta, NULL);
 
 	if (!o->update || o->dry_run) {
-		remove_marked_cache_entries(index, 0);
+		remove_marked_cache_entries(istate, 0);
 		trace_performance_leave("check_updates");
 		return 0;
 	}
 
 	if (o->clone)
-		setup_collided_checkout_detection(&state, index);
+		setup_collided_checkout_detection(&state, istate);
 
-	progress = get_progress(o, index);
+	progress = get_progress(o, istate);
 
 	/* Start with clean cache to avoid using any possibly outdated info. */
 	invalidate_lstat_cache();
@@ -506,10 +506,10 @@ static int check_updates(struct unpack_trees_options *o,
 	git_attr_set_direction(GIT_ATTR_CHECKOUT);
 
 	if (should_update_submodules())
-		load_gitmodules_file(index, NULL);
+		load_gitmodules_file(istate, NULL);
 
-	for (i = 0; i < index->cache_nr; i++) {
-		const struct cache_entry *ce = index->cache[i];
+	for (i = 0; i < istate->cache_nr; i++) {
+		const struct cache_entry *ce = istate->cache[i];
 
 		if (ce->ce_flags & CE_WT_REMOVE) {
 			display_progress(progress, ++cnt);
@@ -517,26 +517,26 @@ static int check_updates(struct unpack_trees_options *o,
 		}
 	}
 
-	remove_marked_cache_entries(index, 0);
+	remove_marked_cache_entries(istate, 0);
 	remove_scheduled_dirs();
 
 	if (should_update_submodules())
-		load_gitmodules_file(index, &state);
+		load_gitmodules_file(istate, &state);
 
 	if (repo_has_promisor_remote(repo))
 		/*
 		 * Prefetch the objects that are to be checked out in the loop
 		 * below.
 		 */
-		prefetch_cache_entries(index, must_checkout, NULL);
+		prefetch_cache_entries(istate, must_checkout, NULL);
 
 	get_parallel_checkout_configs(&pc_workers, &pc_threshold);
 
 	enable_delayed_checkout(&state);
 	if (pc_workers > 1)
 		init_parallel_checkout();
-	for (i = 0; i < index->cache_nr; i++) {
-		struct cache_entry *ce = index->cache[i];
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
 
 		if (must_checkout(ce, NULL)) {
 			size_t last_pc_queue_size = pc_queue_size();
@@ -559,7 +559,7 @@ static int check_updates(struct unpack_trees_options *o,
 	git_attr_set_direction(GIT_ATTR_CHECKIN);
 
 	if (o->clone)
-		report_collided_checkout(index);
+		report_collided_checkout(istate);
 
 	trace_performance_leave("check_updates");
 	return errs != 0;
@@ -676,19 +676,19 @@ static void mark_ce_used(struct cache_entry *ce, struct unpack_trees_options *o)
 	}
 }
 
-static void mark_all_ce_unused(struct index_state *index)
+static void mark_all_ce_unused(struct index_state *istate)
 {
 	int i;
-	for (i = 0; i < index->cache_nr; i++)
-		index->cache[i]->ce_flags &= ~(CE_UNPACKED | CE_ADDED | CE_NEW_SKIP_WORKTREE);
+	for (i = 0; i < istate->cache_nr; i++)
+		istate->cache[i]->ce_flags &= ~(CE_UNPACKED | CE_ADDED | CE_NEW_SKIP_WORKTREE);
 }
 
 static int locate_in_src_index(const struct cache_entry *ce,
 			       struct unpack_trees_options *o)
 {
-	struct index_state *index = o->src_index;
+	struct index_state *istate = o->src_index;
 	int len = ce_namelen(ce);
-	int pos = index_name_pos(index, ce->name, len);
+	int pos = index_name_pos(istate, ce->name, len);
 	if (pos < 0)
 		pos = -1 - pos;
 	return pos;
@@ -702,12 +702,12 @@ static int locate_in_src_index(const struct cache_entry *ce,
 static void mark_ce_used_same_name(struct cache_entry *ce,
 				   struct unpack_trees_options *o)
 {
-	struct index_state *index = o->src_index;
+	struct index_state *istate = o->src_index;
 	int len = ce_namelen(ce);
 	int pos;
 
-	for (pos = locate_in_src_index(ce, o); pos < index->cache_nr; pos++) {
-		struct cache_entry *next = index->cache[pos];
+	for (pos = locate_in_src_index(ce, o); pos < istate->cache_nr; pos++) {
+		struct cache_entry *next = istate->cache[pos];
 		if (len != ce_namelen(next) ||
 		    memcmp(ce->name, next->name, len))
 			break;
@@ -717,11 +717,11 @@ static void mark_ce_used_same_name(struct cache_entry *ce,
 
 static struct cache_entry *next_cache_entry(struct unpack_trees_options *o)
 {
-	const struct index_state *index = o->src_index;
+	const struct index_state *istate = o->src_index;
 	int pos = o->internal.cache_bottom;
 
-	while (pos < index->cache_nr) {
-		struct cache_entry *ce = index->cache[pos];
+	while (pos < istate->cache_nr) {
+		struct cache_entry *ce = istate->cache[pos];
 		if (!(ce->ce_flags & CE_UNPACKED)) {
 			o->internal.cache_bottom = pos;
 			return ce;
@@ -734,14 +734,14 @@ static struct cache_entry *next_cache_entry(struct unpack_trees_options *o)
 static void add_same_unmerged(const struct cache_entry *ce,
 			      struct unpack_trees_options *o)
 {
-	struct index_state *index = o->src_index;
+	struct index_state *istate = o->src_index;
 	int len = ce_namelen(ce);
-	int pos = index_name_pos(index, ce->name, len);
+	int pos = index_name_pos(istate, ce->name, len);
 
 	if (0 <= pos)
 		die("programming error in a caller of mark_ce_used_same_name");
-	for (pos = -pos - 1; pos < index->cache_nr; pos++) {
-		struct cache_entry *next = index->cache[pos];
+	for (pos = -pos - 1; pos < istate->cache_nr; pos++) {
+		struct cache_entry *next = istate->cache[pos];
 		if (len != ce_namelen(next) ||
 		    memcmp(ce->name, next->name, len))
 			break;
@@ -1333,11 +1333,11 @@ static int find_cache_pos(struct traverse_info *info,
 {
 	int pos;
 	struct unpack_trees_options *o = info->data;
-	struct index_state *index = o->src_index;
+	struct index_state *istate = o->src_index;
 	int pfxlen = info->pathlen;
 
-	for (pos = o->internal.cache_bottom; pos < index->cache_nr; pos++) {
-		const struct cache_entry *ce = index->cache[pos];
+	for (pos = o->internal.cache_bottom; pos < istate->cache_nr; pos++) {
+		const struct cache_entry *ce = istate->cache[pos];
 		const char *ce_name, *ce_slash;
 		int cmp, ce_len;
 
-- 
2.56.0-626-gaba6dc7e00

