Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794014953;
	b=YhDTOJq4GBteq7oaL0GDtY0mpmZk3s3gAf8ItmcfpDcD631vNsZ2+2aEnk95ruL1+bUp
	 nmEeSZ68TJBA3xcbLAy6IL0dSbZagjspm6kVvPP5YeurlTvak3lqaQJCNwxBtHAb50OZz
	 2fFEikZ3xalfu8oyGOr7/AlM8DP1vVsCOtFmBotxj98SlVr85H92jDVzEr9dulDOMM6qQ
	 OFbsjhssHl8KNkZnC6IlMT+S+gqtl8ctoluyScbGFxS7roZv0TkchFHcxmjPjg5qL8wMo
	 v96x5Yo5g7YXl5kPo/qyuNBb4JNpR40kYx50pOB8dKlyPb49krbrRhSKTw/AqExy/Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794014953;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=1h8dS/0H49IaoVrbE0VrEGuHTrfpU7nJcCyl84u6+bk=;
	b=2o4zdo75iYm+U1nTKKxNb9SAr6AFgwka+mwpqjzpx4TuIK+MAVRkG2noc1WKqFkCz/WD
	 ZEkw/WCvo9M7UEEIkJ8SZFWTcae8VwJf04AeT82K9G9uX7SVD3rGMNCA1sBmb3MvLJ5nB
	 3P+LYotgnSa4Fh1B3LQ6SB7Cj5Dz9L7Pl6BTuByFPa8W7yWzTkYLCeB5tZCsDLbLOj3Xy
	 TbWYmw8zspLEAeJMzlIpWq7tOKqn0AvCi/IWGFOhgeKDugkuitMHKeqTbQas5QMDq+pTT
	 07lHMrV3RW7v+ZaQmYgIr0Ss/dO47aCAI3Ejkt/Fakqglk0SE0Q/aU8F0NcOKKzIUOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=C9qf+jJl;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LO2O2bH0;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3552E606A326
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 01:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3552E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=C9qf+jJl;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LO2O2bH0
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 62BA0EC0114
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 20:29:11 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 06 Nov 2026 20:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794014951; x=1794101351; bh=1h8dS/0H49
	IaoVrbE0VrEGuHTrfpU7nJcCyl84u6+bk=; b=C9qf+jJle9w+lTTkDIsxu0YKk1
	QPBri8Km03U9uN9SIMk2IxCe476wxtOHl/FNPJq2Y0L1q74uZlG+w8OMVgoIoIkz
	X60+2LbBShiFd3Le+B8GThhQCodxLbMdkWLKZTRZFL6REA1zBZqyaSPJnF6MWqvO
	4MgM9LCY0FB18STZP3XTEvL8fv/IoZVBiOJf76w/9zFw95n5XD31R85m16SNWR/L
	E2QEtc9o0ztL64nujNVCqTTpuaHYnAhmmq8gKzwCIXNfmS4x21s0dK3KKfUs7eKb
	Eb5hki8VxTX//0dt47UAi/IMayEUPMBDSvwJJoqXDLABZfC7jzqv9NOLmdGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794014951; x=1794101351; bh=1h8dS/0H49IaoVrbE0VrEGuHTrfpU7nJcCy
	l84u6+bk=; b=LO2O2bH0zEpVfaEq5dDbjAzmzpQ6sJctoD4w1BM317DmAWKGsLq
	Yr2xXfypSqNx4ZjNDM7ZSwZxn5abf9cA/CIhvgdM4adzRVI4lGrmhxNkYwP/64lt
	uqzE1pDvzhXYWyy+f4vkftnSm+EM5Hfn0mgVoX45yHeq1bsgjoAq0uYjfKxHQvvY
	91GZVgA7+PiH8p3HoDOjPZl5PQb7EgzhZg6AL4Xrz1LLMzh30Phnu5wFqI+tSEFt
	i7tCoqc/5MwCEz+TsUg+b0t8VprkqkYPM0GcCzKGrn/E0gIHXX9TsjqL+QzVznh2
	oVuMdVoeN3HQByYpbKqyxuzrRCSyjt2ajMA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794014951; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:iPbQcWUeB2xtH0GI4N1amVYSxYxolqRYOVBIWyLGhwm+YsT
	ydFESJRyYpkDD4CoG18zz6Toge0nWDSPqcR8jXFq+ibo7ZhjhoCHaWqvLOiOXquS
	kVF0h1itSyoH99VfoWY2sIStLLxvUnV9PZ+N5adi4X6LmUwmh9ots7nHE3Sp+VBl
	KWL91eKm2es5fZZRQrTKa2iYFMR0M0t1I5IO0mduIMAY28ZvWvkI9pwCMr9l+77v
	s/nLtqWcQMtasL1WvZBz7M2U7O9AxnQ0Hf27/giX6aZ2hClLkqWDyNWYymSO0ws7
	cmaB1PlVK+fOmvvCb63tozZaJ7Zw6wc8d5XJIaA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:UahsYsYXOUp/S8SFsBylIO0qG1i3cW0C3+79acHOEcI=:j/dHKqEddOIBrGaONxzdiKQEuNLdkidVzrQ+rySYvg0=;
X-ME-Sender: <xms:537ualAP1HylvENJJnT1AjCDNj7SN0nDiXrEDtEywE_bvV4s0H5FqA>
    <xme:537uapgEYAIy6rAR89C8TFpFPKBPO0MbuxGmx4G-SumarhRBUFm8cxao2gns_HRZQ
    mF5RiqZjd2012hGB5wRmG-frOmYLUYgF4NCvo6042twZlzHq3mVY3I>
X-ME-Received: <xmr:537uauN6a4eKjeT5X3l3dALVdvNjvBMKPV9EWCrNYCJ_2dF0hsEOnpaK7-sm939UkiL90pp5i6Vo4HmYfc4_us3MG8rZCNW2khZv>
X-ME-Proxy-Cause: dmFkZTEf/y25S+X4KOGtatb0KQ0nZwuQMpdBDK2X1CVAxp8fxQ0CASSIDfTxXNZ1sL+Iub
    E685dplKbRVqAWDf8IjGUoaQCdbMpffr/vumX3mwDtick/+Dje5sRI6iVJWFBExO9a/V+b
    8My/AoQCfBvGJImYgbIXIqvWwUFio2j4fjfe0kUjTcglpjciVeLW2Ed4KKM2QZ+FrBTh/d
    164EyCKsrj/MS/bATbDZsKABm+HAux/xDJ2oYqFU/GkpVUpxU5lNwLBwizxnJyKuaNDXSm
    8+7sruXZAyZFZsopYWGRh/YrRkxqi86iWgJOKls0H0AVivSryGMOtv9tvCCeb2+cIAdQJg
    BnHJcuhM/O/A0wg4RCavXJ8uIEtM5SJjUv3Vzr7l7CxxCVyE4dXFfbht2EhZPTtf57KnYE
    Pm9wqgCYxy0VCQFVstsMkJSiFKfKEhLGx04Hgzn2PbxKv1OEp8Yqi6JXJI5XfyE5G5ELV7
    l+z/oGXx93cMNxkd1JQVdEsCCE1lc3l2RQEnG39B2QXa7AA5d4mp3wF92dMMvfy+C2BFZ2
    e4UpRwN/E3dlGFTcQdQN4qKmvbGkMPEXn8ZcS+mSxf6TLyfIAXrBRv4JnMIsWD1KCDRMDI
    5+QcmO5R9Fn2kcZNQh/E06pXVXtqeyRyXvi3dFTlr4BEIlsQ+p3rJP8Ycy7w
X-ME-Proxy: <xmx:537uaq6NSYRuuzsvC5aKuDsDUFZUy6Ksj4s-xodZdNEco19Ec90lPA>
    <xmx:537uas0kytJXlpq1gjS7a3cq8bOBrsRNguaLNfYINlCAe84ri3Z8rw>
    <xmx:537uarbEta0OaRDT5aEmzpvSAq6GYp2g3BQbdqce6ID_a4g69U8pfA>
    <xmx:537uakD4fExA7TW_bJPy-MKxQ2Pojol3LVwWTdo6IsuI0sOb0JL8PQ>
    <xmx:537uaoYFc2ubYwaamL5Mut1iaGL3uHSddCfORyM83IgjOCJ_x-zAmgvA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 20:29:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/2] unpack-trees: consistently use "struct index_state
 *istate"
In-Reply-To: <xmqqtsltbfdv.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	06 Nov 2026 17:26:52 -0800")
References: <xmqqtsltbfdv.fsf@gitster.g>
Date: Fri, 06 Nov 2026 17:29:10 -0800
Message-ID: <xmqqpkwhbfa1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

There are some functions that call it index.  Make them consistent.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This change is not necessary for functioning of anything, but
   while writing the previous patch, the inconsistency was
   irritating enough.

 unpack-trees.c | 94 +++++++++++++++++++++++++-------------------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 79341d7fa6..eedc1ce7a5 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -390,14 +390,14 @@ static int check_submodule_move_head(const struct cache_entry *ce,
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
@@ -409,16 +409,16 @@ static void load_gitmodules_file(struct index_state *index,
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
@@ -428,22 +428,22 @@ static struct progress *get_progress(struct unpack_trees_options *o,
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
@@ -474,33 +474,33 @@ static int must_checkout(const struct cache_entry *ce,
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
@@ -508,10 +508,10 @@ static int check_updates(struct unpack_trees_options *o,
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
@@ -519,26 +519,26 @@ static int check_updates(struct unpack_trees_options *o,
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
@@ -561,7 +561,7 @@ static int check_updates(struct unpack_trees_options *o,
 	git_attr_set_direction(GIT_ATTR_CHECKIN);
 
 	if (o->clone)
-		report_collided_checkout(index);
+		report_collided_checkout(istate);
 
 	trace_performance_leave("check_updates");
 	return errs != 0;
@@ -678,19 +678,19 @@ static void mark_ce_used(struct cache_entry *ce, struct unpack_trees_options *o)
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
@@ -704,12 +704,12 @@ static int locate_in_src_index(const struct cache_entry *ce,
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
@@ -719,11 +719,11 @@ static void mark_ce_used_same_name(struct cache_entry *ce,
 
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
@@ -736,14 +736,14 @@ static struct cache_entry *next_cache_entry(struct unpack_trees_options *o)
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
@@ -1335,11 +1335,11 @@ static int find_cache_pos(struct traverse_info *info,
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
2.56.0-599-geab4b2c7f0

