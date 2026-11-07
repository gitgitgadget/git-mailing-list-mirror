Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794014815;
	b=tyWErgSnHSKBR+KlbmboHTi3WBL6DfuGnfG1YzG97jgMUSFy33pGCrQVuge6YOq16NqS
	 doicFzyCpYt238lXzkkxv+SuG/yW2adWu7yRVUnHcVHTqqax9mDHwAg36zC5z1F8htnrA
	 boO09Z0ciXj/9f2QpKJN50lB4qr3HOg2GYkrtQXuTBpmruLBxkCBwXoV6GMx+QA3kYz9W
	 I9GaxOotpMrWHfY78S0EUSV66AkoBDvAU6lfebqkY/zQjL+v7QoLZgD2ckjGc2QazE0oH
	 /4obYBqhYto275HiyDFSJXfukLlgDDjI2g5Wh/MuutV3UG2VRu8csnlI7AqM3R4bdIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794014815;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type;
	bh=B5BBe1DlxhXbEMsz2XEjbLZfrflOpHaMikhu4BjAl/8=;
	b=anfjDD91UZMEXmSlP85+b+PDGWbODevgMtP/eEu6q/OqtPRLLj6UUZVFb1xfp8DqdZXE
	 Pg/i4r7N1Wm8CLM0cmvN40Fig5mleIW/2DItasBdderJnXML/owCA0iEYDp353++tju2H
	 4iq6t2rEdAjFmyPkaNywdZ1NbLJo3Pa75NzRRqgC7FXR9qFbpaLTX02TbzAtcZZFORHwJ
	 KOoJhJe4pKMLdblw+RI5J2ipPFgI/nJHa1Wyq/6CL+BgmvA9nMW1gWXELvDvaShvIzjWs
	 7mRBTnXAcSUQ8mzyJRhU+nUPP7USD6N5yCuit0cU4CdmWtq6SF7lhIOR+26jSoRKLzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Nh3pPMjE;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fT+PblJT;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D86606A32E
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 01:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08D86606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Nh3pPMjE;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fT+PblJT
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9B25F14000DA
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 20:26:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 06 Nov 2026 20:26:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1794014813; x=1794101213; bh=B5BBe1DlxhXbEMsz2XEjbLZfrflOpHaM
	ikhu4BjAl/8=; b=Nh3pPMjEuAyGQ+JHRHOc8pvLe7D4SQLFvGP/hJofvuWiVNR/
	quPQ4EBcp/sZsbJdUNe0NvmWB8Eh0vKXCFDc9991fpNR7YRN5fFAHbAwLxYSYtSi
	Kwi3V+DH8ToDscZEmctv07TJUOKHayC2bLgA/A6Qq6hlaC+AytCPmLB0EEmxn10l
	M02BWy5h4FMFuv11OIiaGAbEbTsEQ479QOCkD1GgBvjZNHvwBtPDiUhfVn9SmKgT
	+jS+rVyHxgbdZq6bRQYotV4RMW0ul6QB6+mhTKnhOIfNDu6gctYV4CgQS3j0i4Ob
	XvS+IXg//qv3TeoJlY9JQcARGtiZ8A+Kbxm0Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794014813; x=
	1794101213; bh=B5BBe1DlxhXbEMsz2XEjbLZfrflOpHaMikhu4BjAl/8=; b=f
	T+PblJTnAaAHhXNcPWYwjorpku3f84ZJT/3amUrNODTaXy6J8fR0OerZjYW3Sgsd
	ojRFLz1OJDQu2Nn2rr/PkT+SfMfv6O00Oa8+C11HPSRzmvlSB/vP/igZJW1Llwfw
	HhEcA5/L57b9QbJ33N3SpSDlKfKC01DlIbmD+c3RfWA6QQkn5ZALX7JnK/uCErx/
	tW4PuNTvlrYNw9Ewjf+tJgq1xBhuFGLhT6i/j7d8rN2FRZAF+jAM1ICzDWihoHwb
	zWMFk/Ht2DcexFcA0h1L90MWRTJXrTwQvVmSVzLRQsMMfF6UyP35e2PbskX/CLxu
	l2Fl4aNvOampRDDvof1iQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794014813; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:bndXvoMHn7pbbImw7wlW5RKcDAnGnyOQswcxkH7poVPeAYv
	ASUGN/2XklTvwaUNnMzr3h6rBdEYFo45IIf7JrtUYTdKJqt8WowubT+Ud1p111t4
	LyjT0tWaHqQHNw9hL/KKj2aUMyHz0U/x4nmCGFHN6GBbNwciTj5PKTMBUwdan6lx
	8PywMCiJflTf7k9jRdcI9B07QazK3S0L9o9a4lppZQ1YHl9os/ytiL1qkx+N7DBn
	feiP5+0aLb5Cn+Y+nkcBCkLBrDBeKyz74FlYAb5AqpAEWkYrfg4CEp3pOcib2CnD
	XQmckRIRZS4FuO++M47mNDvJEkyMEJ3AmDjT0Nw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=content-type,date,feedback-id,from,message-id,mime-version,
	subject,to,user-agent;
Message-Instance: m=1; h=sha256:TkTApYMeN2NfCgvsJpE64JgruNCS6/qCocpgrdb5zLE=:D7xMoGc9k4BLTlKxMCh1xEp2GjSnaLy1cSJcUcPjHRw=;
X-ME-Sender: <xms:XX7uahdA84S6E0hsRtXkfVSGxOcGc_gn0_Rvk1ApC9w1PNgzop5qHg>
    <xme:XX7ualOT7gZPdvfXZPIhNNur2bLi2TjwyF__KQ91b8KsjnXfcRoxcSoYDhTZNUMmk
    nhBFpj7iZDhpi8HRrJVD3Z8qR2Ie0fxwom9XQGNiMtT6VPxsWDPmU0>
X-ME-Received: <xmr:XX7uaoJCvko-BecAK5bcdC6rzB1cRY7wrksfSdIHeqApYVf-4YN_Pkh9Pssq99SZCpBZSxFm3fWDV5WB-MuyxBfR33vgIW7J2Usd>
X-ME-Proxy-Cause: dmFkZTGA8QhNoA4/DzBktk0Tzp+qtF6u1G7MyrBlXHj1uaIgHKuWkrlQ1f799oBVPW9jD5
    A2rCiCkURyOBL/ZEP7Q5QDTI+TIcpIRyhSTYKk6WSPzmjI2ZZvLFyIHk+/tA7zn3rH6EiM
    r4c9oO3Layn+TrwXHgPNCRXDHNKb7CPxK5CP+RbcGUOtXuGxyq2XpArDYkFH3gtwnAmBVo
    t55SteCyglO3HoxS23mKGRg64TlOAwPgVk99XHtkh/LNWAc9br/C3Nc3sb6iJL5tBnW8o9
    KtxEK7Cj+vwdYK9TZ/xYEZBRS7fyeewWSXZmvwb4p0MmDtfPionw304yh4RrcmkBnMBOiU
    I3/l0LVb4LLRr+Xr2t+BEYk8Kpv5pC5eWA1qPh0Wf/cJ3eXF2bRXIeOWdyTlfK6/mLOESG
    hVQ/SUEMVfIv32Dcbs5eBbtuAvCrE9jv5w5ADUFpu4fTiY/rTuTphDyjYwYyXo52X7O+Ra
    sHuOaOXaeU+e2M2J1Vk9xK8dZW62Uak+0sucuuf+bpkvAInrhIeJb2oDusVg1JvHDfJVv4
    6DEEQIOdy6L1WpqIzVqiHZvhVMgFNcHwWTo127lD64q0dXMj1cIJo9Rv7ZsuEqK6jj0vpB
    netLO1ROS5Ugb5RPR6BWWIEkTwnVFWe/wJTJnskgTIWtW4VyGSrWuqmKmloQ
X-ME-Proxy: <xmx:XX7uamFmdfarpGYQHt_MJ-AADdmOe4Lrx3TodPq4SQ21fb3sfWSLzA>
    <xmx:XX7uagQ7KtPwcYFB924MYPD87vACHe-tQ1MmweY1AzJbe0D0GzdHlQ>
    <xmx:XX7uaiGkSFeGwWpb3mA6v6ku-4OuIlDhwgp2i3eFSOBdSrTk289gOw>
    <xmx:XX7uas86ZDWFbQeR32JHVEU9JTsHhYqSvPpPMXmmNkljEvIfuQVWdQ>
    <xmx:XX7uas0lNSFbsYIB1PMRahnww1ZuaNERqdzwdAope9O2uuVAM_SLA0f3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 20:26:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/2] unpack-trees: lose USE_THE_REPOSITORY
Date: Fri, 06 Nov 2026 17:26:52 -0800
Message-ID: <xmqqtsltbfdv.fsf@gitster.g>
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

This file defines a set of fairly low level functions to implement
merge and checkout behaviour, many of which depended on and can only
work with the_repository.

Two key data structures passed around in the code paths, "struct
unpack_trees_options" and "struct index_state", both have a pointer
to the repository instance, and we can use it to make it work on an
arbitrary repository, not just the_repository.

In any correctly written clients of this library file, the
repository instance that is pointed at by these two structs MUST be
the same one.  For now, make sure that is the case (and otherwise
BUG out) by introducing a unpack_repo() helper function that takes
these two structures (when available) and returns the repository.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I wrote this change when I ranted in

   https://lore.kernel.org/git/xmqq33tdcuub.fsf@gitster.g/

   on 'seen', and "git checkout -m --detach master" was sufficient
   to build and start a new branch based on 'master' and there
   wasn't any need for adjustment.  All tests seem to pass.

 unpack-trees.c | 94 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 76 insertions(+), 18 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index d6a859420f..79341d7fa6 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -82,6 +81,56 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_WARNING_TYPES] = {
 	  ? ((o)->internal.msgs[(type)])      \
 	  : (unpack_plumbing_errors[(type)]) )
 
+
+/*
+ * Some functions in these code paths get unpack_trees_options, which
+ * has up to two istates, and some get an istate.  These istates can
+ * be used to find the repository to be used for this operation.
+ *
+ * As these are all working on the same repository, they must match.
+ * For now, with a super paranoid check, make sure all potential
+ * sources of the information match before using it.
+ *
+ * Once this proves working well, we could just use the first one we
+ * find in a production setting.
+ */
+static struct repository *unpack_repo(struct index_state *istate,
+				      struct unpack_trees_options *o)
+{
+	struct repository *repo = NULL;
+	const char *camefrom = NULL;
+
+	if (istate) {
+		if (!istate->repo)
+			BUG("istate->repo == NULL");
+		repo = istate->repo;
+		camefrom = "istate->repo";
+	}
+	if (o) {
+		if (o->src_index) {
+			if (!o->src_index->repo)
+				BUG("o->src_index->repo == NULL");
+			if (repo && repo != o->src_index->repo)
+				BUG("%s != o->src_index->repo", camefrom);
+			repo = o->src_index->repo;
+			camefrom = "o->src_index->repo";
+		}
+
+		if (o->dst_index) {
+			if (!o->dst_index->repo)
+				BUG("o->dst_index->repo == NULL");
+			if (repo && repo != o->dst_index->repo)
+				BUG("%s != o->dst_index->repo", camefrom);
+			repo = o->dst_index->repo;
+		}
+	}
+	if (!repo)
+		BUG("no repository for unpack_trees()?");
+	return repo;
+
+}
+
+
 static const char *super_prefixed(const char *path, const char *super_prefix)
 {
 	/*
@@ -345,15 +394,16 @@ static void load_gitmodules_file(struct index_state *index,
 				 struct checkout *state)
 {
 	int pos = index_name_pos(index, GITMODULES_FILE, strlen(GITMODULES_FILE));
+	struct repository *repo = unpack_repo(index, NULL);
 
 	if (pos >= 0) {
 		struct cache_entry *ce = index->cache[pos];
 		if (!state && ce->ce_flags & CE_WT_REMOVE) {
-			repo_read_gitmodules(the_repository, 0);
+			repo_read_gitmodules(repo, 0);
 		} else if (state && (ce->ce_flags & CE_UPDATE)) {
-			submodule_free(the_repository);
+			submodule_free(repo);
 			checkout_entry(ce, state, NULL, NULL);
-			repo_read_gitmodules(the_repository, 0);
+			repo_read_gitmodules(repo, 0);
 		}
 	}
 }
@@ -362,6 +412,7 @@ static struct progress *get_progress(struct unpack_trees_options *o,
 				     struct index_state *index)
 {
 	unsigned cnt = 0, total = 0;
+	struct repository *repo = unpack_repo(index, o);
 
 	if (!o->update || !o->verbose_update)
 		return NULL;
@@ -372,7 +423,7 @@ static struct progress *get_progress(struct unpack_trees_options *o,
 			total++;
 	}
 
-	return start_delayed_progress(the_repository,
+	return start_delayed_progress(repo,
 				      _("Updating files"), total);
 }
 
@@ -430,6 +481,7 @@ static int check_updates(struct unpack_trees_options *o,
 	struct progress *progress;
 	struct checkout state = CHECKOUT_INIT;
 	int i, pc_workers, pc_threshold;
+	struct repository *repo = unpack_repo(index, o);
 
 	trace_performance_enter();
 	state.super_prefix = o->super_prefix;
@@ -473,7 +525,7 @@ static int check_updates(struct unpack_trees_options *o,
 	if (should_update_submodules())
 		load_gitmodules_file(index, &state);
 
-	if (repo_has_promisor_remote(the_repository))
+	if (repo_has_promisor_remote(repo))
 		/*
 		 * Prefetch the objects that are to be checked out in the loop
 		 * below.
@@ -879,6 +931,7 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 	struct traverse_info newinfo;
 	struct name_entry *p;
 	int nr_entries;
+	struct repository *repo = unpack_repo(NULL, o);
 
 	nr_entries = all_trees_same_as_cache_tree(n, dirmask, names, info);
 	if (nr_entries > 0) {
@@ -940,7 +993,7 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 			const struct object_id *oid = NULL;
 			if (dirmask & 1)
 				oid = &names[i].oid;
-			buf[nr_buf++] = fill_tree_descriptor(the_repository, t + i, oid);
+			buf[nr_buf++] = fill_tree_descriptor(repo, t + i, oid);
 		}
 	}
 
@@ -1773,24 +1826,25 @@ static int clear_ce_flags(struct index_state *istate,
 	static struct strbuf prefix = STRBUF_INIT;
 	char label[100];
 	int rval;
+	struct repository *repo = unpack_repo(istate, NULL);
 
 	strbuf_reset(&prefix);
 	if (show_progress)
 		istate->progress = start_delayed_progress(
-					the_repository,
+					repo,
 					_("Updating index flags"),
 					istate->cache_nr);
 
 	xsnprintf(label, sizeof(label), "clear_ce_flags(0x%08lx,0x%08lx)",
 		  (unsigned long)select_mask, (unsigned long)clear_mask);
-	trace2_region_enter("unpack_trees", label, istate->repo);
+	trace2_region_enter("unpack_trees", label, repo);
 	rval = clear_ce_flags_1(istate,
 				istate->cache,
 				istate->cache_nr,
 				&prefix,
 				select_mask, clear_mask,
 				pl, 0, 0);
-	trace2_region_leave("unpack_trees", label, istate->repo);
+	trace2_region_leave("unpack_trees", label, repo);
 
 	stop_progress(&istate->progress);
 	return rval;
@@ -1885,13 +1939,13 @@ static int verify_absent(const struct cache_entry *,
  */
 int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options *o)
 {
-	struct repository *repo = o->src_index->repo;
+	struct repository *repo = unpack_repo(NULL, o);
 	int i, ret;
 	static struct cache_entry *dfc;
 	struct pattern_list pl;
 	int free_pattern_list = 0;
 	struct dir_struct dir = DIR_INIT;
-	struct repo_config_values *cfg = repo_config_values(the_repository);
+	struct repo_config_values *cfg = repo_config_values(repo);
 
 	if (o->reset == UNPACK_RESET_INVALID)
 		BUG("o->reset had a value of 1; should be UNPACK_TREES_*_UNTRACKED");
@@ -1936,7 +1990,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		populate_from_existing_patterns(o, &pl);
 	}
 
-	index_state_init(&o->internal.result, o->src_index->repo);
+	index_state_init(&o->internal.result, repo);
 	o->internal.result.initialized = 1;
 	o->internal.result.timestamp.sec = o->src_index->timestamp.sec;
 	o->internal.result.timestamp.nsec = o->src_index->timestamp.nsec;
@@ -2081,7 +2135,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		move_index_extensions(&o->internal.result, o->src_index);
 		if (!ret) {
 			if (git_env_bool("GIT_TEST_CHECK_CACHE_TREE", 0) &&
-			    cache_tree_verify(the_repository,
+			    cache_tree_verify(repo,
 					      &o->internal.result) < 0) {
 				ret = -1;
 				goto done;
@@ -2137,10 +2191,11 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o,
 	int i;
 	unsigned old_show_all_errors;
 	int free_pattern_list = 0;
+	struct repository *repo = unpack_repo(NULL, o);
 
 	old_show_all_errors = o->internal.show_all_errors;
 	o->internal.show_all_errors = 1;
-	index_state_init(&o->internal.result, o->src_index->repo);
+	index_state_init(&o->internal.result, repo);
 
 	/* Sanity checks */
 	if (!o->update || o->index_only || o->skip_sparse_checkout)
@@ -2333,10 +2388,11 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	struct dir_struct d;
 	char *pathbuf;
 	int cnt = 0;
+	struct repository *repo = unpack_repo(NULL, o);
 
 	if (S_ISGITLINK(ce->ce_mode)) {
 		struct object_id oid;
-		int sub_head = repo_resolve_gitlink_ref(the_repository, ce->name,
+		int sub_head = repo_resolve_gitlink_ref(repo, ce->name,
 							"HEAD", &oid);
 		/*
 		 * If we are not going to update the submodule, then
@@ -2424,6 +2480,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 			      struct unpack_trees_options *o)
 {
 	const struct cache_entry *result;
+	struct repository *repo = unpack_repo(NULL, o);
 
 	/*
 	 * It may be that the 'lstat()' succeeded even though
@@ -2432,7 +2489,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 	 *
 	 * Ignore that lstat() if it matches.
 	 */
-	if (repo_ignore_case(the_repository) && icase_exists(o, name, len, st))
+	if (repo_ignore_case(repo) && icase_exists(o, name, len, st))
 		return 0;
 
 	if (o->internal.dir &&
@@ -2652,6 +2709,7 @@ static int merged_sparse_dir(const struct cache_entry * const *src, int n,
 	void * tree_bufs[MAX_UNPACK_TREES + 1];
 	struct traverse_info info;
 	int i, ret;
+	struct repository *repo = unpack_repo(NULL, o);
 
 	/*
 	 * Create the tree traversal information for traversing into *only* the
@@ -2665,7 +2723,7 @@ static int merged_sparse_dir(const struct cache_entry * const *src, int n,
 
 	/* Get the tree descriptors of the sparse directory in each of the merging trees */
 	for (i = 0; i < n; i++)
-		tree_bufs[i] = fill_tree_descriptor(o->src_index->repo, &t[i],
+		tree_bufs[i] = fill_tree_descriptor(repo, &t[i],
 						    src[i] && !is_null_oid(&src[i]->oid) ? &src[i]->oid : NULL);
 
 	ret = traverse_trees(o->src_index, n, t, &info);
-- 
2.56.0-599-geab4b2c7f0

