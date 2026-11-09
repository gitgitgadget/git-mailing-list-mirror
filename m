Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794257682;
	b=DjBsN+bKXsoEDHSX3U6UalE/i3a1eg5AWUoMjo9KxclrTnp/bXcadyl9Afm2YpXWz8Wa
	 Ha0RtrH0DlScp/XBi76XCMTF+jvBZYmew6wnU6KOkCKXUM4oZ8e110CCRW8CIxspC4CAx
	 o35egwfz+2Og17709gLQ1b5GeFgyb6IrJpvgiOby61u+8iLIIOwTYiwGc1mFJbhukPyi4
	 YRr61+2SXN7LfbGoR2QxdYnF177CSzKZV4SZy8uAR4gzCKB2xqBwD1bMGluW+O/oAn4wj
	 mhu/pP/nTP0D1ZaW9+YZecPD0ERqqTleJMZ1Z7qiCvVBRdGjFO/JQvO2cU//7mpJhNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257682;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=t01Dm99GikzaokXpAqhFMEidn7GtUVv/pS017VyAvRk=;
	b=sGU6G919OTLE3AbjAnT4k0+EAPHnvcq3TNTcTQTGuF64+DDBdNRfnEqEk55hDoF6pJC8
	 j6OIvCU4bF4gISMNSTCEOspL218/A9+eAekZH9znls3ni4X1MokqrmW/x9WJvMI8e8bqg
	 6XZtbucV3cysz+OAx2q/W6LURUz1Y/1ldKV0JMGvZwqjNlu9MfClY4mRKDOP5C+sb5OX2
	 Wqsl40yzfjVg86MPxwPGtQpaM1My5BvKXFXEppUJCThKwHDTKrYMb2CxlsPxUw8hh0exY
	 9S6Kon9M8+zuQfXuqkpyETKCeI9Dnf5klTLK1nO5CyzAXriJwYcSQ08SioDErnhw5sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="CbYsL/jM";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=0yet24xy;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE52606A332
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 20:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FE52606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=CbYsL/jM;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=0yet24xy
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 51B851400017
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 15:54:41 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 09 Nov 2026 15:54:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794257681; x=
	1794344081; bh=t01Dm99GikzaokXpAqhFMEidn7GtUVv/pS017VyAvRk=; b=C
	bYsL/jMaqr0yN0ZCFoR+opQFoKMrKM9rhRNZUaPRoKQ47bRU09KeuU/FIlWdiklX
	A2am59qRraKwIxl7FSBIvCpBaAxXRiBu6fs0tl0Yp4xk3sR9LP5lSNdogTywdirt
	13SBitMle9NkDG18cLddNAgij8kDRb+rAendI/7bTMfTWb3uj+pcJ4y5lvW+TrsF
	wwGtW72Mvg9nZ0WwoWKHtP/c9noZo2HX4O+3f4/hUU6IcFegbym2VDX7DreT3PHx
	u89OXaGwwbR/qfWmMwqOPVjMi7wnFVOPu038r1Vb9Un0s/1VHv0CSzc4ObKbPq82
	z95NXl9FwQ1FD3k140fJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1794257681; x=1794344081; bh=t01Dm99GikzaokXpAqhFMEidn7Gt
	UVv/pS017VyAvRk=; b=0yet24xy/Gktqjm8zxbYRJJoLsejO7oxHali7WxOBgAQ
	ro4DqthUIBREqkvmhgnhvS0CVFkG5UMH5ojdNdzeMP9AirG2AH1fcYUzx7j44in9
	1BWJVzHGtqZ+T6paFkVmdkBB3EK1ybKIcLANBVOoym+rSQTmjm0GuMi6D0LQiEv4
	1qWBDWN7CjkX4fEBgFPcGVdGT3uAqx1Z8gpHyDWnVZtoCrM0gQegpxoGfVFD1IDB
	xynw4lbwdoccoyBqKlILJnCprhCaODlcowdovyDNkVA1gKdodbOo34MH4ZNp43tH
	bNhdoiGRC5VqVPRTu6rHkR5/OaCF3OYCcvCjefMZMw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794257681; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:gGXka+HCoUIDYT5seB5veOEl0SKAZ2zanUQl5Ld072KkUwg
	DZ+h3NHDmecdAGijWGuBRfVzptAv9QFxBpufAJ/J3CmnzxSsV+1V50NGb8sDfH60
	kFdpOwqs+FjjDnJ9OwNaqPeOc2a/A8ikww8k65j6R5s3/gsccHQT3CGMf5S+B7gF
	Jft0lsjvQtBY4AWHsDXvq9zaHK8TJlP8iMpD6oqlTL1f5oIQZ0U+9nAJOrl6KWx3
	iFTFg543nvbnBmbH9MidNA2kDuVnRvm21+I7oHPxsUa2fJ7gdY/Hrrlc2S+1eBTi
	cIXxnCiAbjRIZnS0SyLvN1Hd8ZT8P3qJLni1SDw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:XUwbS4WmnUZnRNDao8GxKKn+6mMWqSJizggrBci0QtE=:IXl7JP2rnkn7BJldKO8IoyY4Y+UpC/DvnpNX519xbds=;
X-ME-Sender: <xms:ETPyakG-I-H_7katKJ662NBJCCp8R2XqZY9my6FIE5vFE9tygYK0jA>
    <xme:ETPyajUHppMqwp5snC3Cis75Ao86gTY9mOrlS7CaqW9K2tGchb5JYE22293dOkm2j
    9YM9gCTMwFtZg5oIYAP6UNJ8D9JImjDCV4fdwoEztIgaEy3jMhCpg>
X-ME-Received: <xmr:ETPyarylT9d9FlrB3k5sPfOileclrJaRuAXq8PdHINEmC-gZ5RbIvlnU0DLkAXp3fWiV-2D7qD4RgCKX-6DAPl3iPU767CPiVTV_>
X-ME-Proxy-Cause: dmFkZTGqpDG5vOQYYKwYqtAN6qPQdfFTNzfSlcGZ8WSRu+3vC+RN9gWCiiH4iY2RZMleiy
    CTc+UAzOBAbx7rKLpYPV4qaEpgLcK5DwmNeCMo5aXjhFs7mgpxOf4BUM7F3o/6Y+Piw8fS
    iq3l88m8VKmyukTAknxl+UPz+foi5fv47pT3myWnZrrF6sx3FyISE0kR6uh3JIkPraVjZO
    3rV+t49YGbnh+Nw1MkQywn8XgM1JrOaqaDvV5Ix6DLPW8AXe+gKWRV7A2yjdmohrGY1c3+
    78INLa5J1RtsPx9OWvq+4VeVJvo1vPuoO5NMOsRmu+4BfaCiIUqmAAKcleRTZo0cWPvxsT
    DIh1MW+Nf7T1JHKG/XfhpU+385JMrtSsUTNuScmC1DYFQWBVyFe/6AyJ83w/0HfTfjqADn
    Gip4DqnuURaKbdfXPyHkx6l1uQIOAw1qJK8IrkPQyxE3eg7en8Tf3Q94I9TW9o96AAhkRN
    XFuXCwnYuabzgvMXQp+rJdrQkOGaLGGfhzON89cev8IGoFqHVmtX432I3pvP2/3j6jhbSo
    j7sbSEWroyhEmCvY/Gf8UlWfruRD67kE01VPtm5bIxsAHDTb1RmMkuJXq/izxkRUNT4Fc6
    RUrlOah1x1Fuw4PhBPYawq/U0g6KdRfZR6Fc9/LAe2fzTWsbf9NwIc8TnRrQ
X-ME-Proxy: <xmx:ETPyahPC-jSgTsLK6_tE7cDdbwCHv8S6AkMP4HUPGHJadnrUz2_MpQ>
    <xmx:ETPyas4xbCb_gD55ZbAZX8rrbGQ7tooEFxrQqqESrdteA71iCZ3H2g>
    <xmx:ETPyaiM0ULxbuJeuN438l_GbH9ifFhxXIHkmW-JzH2okq7WJ_TPzuw>
    <xmx:ETPyaqlX1oIyeiPEio1kKCusdld_1JN0hBFv4uOJssqSC6wm4ci7Tg>
    <xmx:ETPyavcAYlC0CK122G-0oxvL9asLCjEF5B3Kqn2uENB4i-K5UAZZPk6Q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 15:54:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 1/2] unpack-trees: lose USE_THE_REPOSITORY
Date: Mon,  9 Nov 2026 12:54:36 -0800
Message-ID: <20261109205438.369060-2-gitster@pobox.com>
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
 unpack-trees.c | 92 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 74 insertions(+), 18 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 1802809ad3..a1f7d8bd6a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -82,6 +81,54 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_WARNING_TYPES] = {
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
+}
+
 static const char *super_prefixed(const char *path, const char *super_prefix)
 {
 	/*
@@ -345,15 +392,16 @@ static void load_gitmodules_file(struct index_state *index,
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
@@ -362,6 +410,7 @@ static struct progress *get_progress(struct unpack_trees_options *o,
 				     struct index_state *index)
 {
 	unsigned cnt = 0, total = 0;
+	struct repository *repo = unpack_repo(index, o);
 
 	if (!o->update || !o->verbose_update)
 		return NULL;
@@ -372,7 +421,7 @@ static struct progress *get_progress(struct unpack_trees_options *o,
 			total++;
 	}
 
-	return start_delayed_progress(the_repository,
+	return start_delayed_progress(repo,
 				      _("Updating files"), total);
 }
 
@@ -430,6 +479,7 @@ static int check_updates(struct unpack_trees_options *o,
 	struct progress *progress;
 	struct checkout state = CHECKOUT_INIT;
 	int i, pc_workers, pc_threshold;
+	struct repository *repo = unpack_repo(index, o);
 
 	trace_performance_enter();
 	state.super_prefix = o->super_prefix;
@@ -473,7 +523,7 @@ static int check_updates(struct unpack_trees_options *o,
 	if (should_update_submodules())
 		load_gitmodules_file(index, &state);
 
-	if (repo_has_promisor_remote(the_repository))
+	if (repo_has_promisor_remote(repo))
 		/*
 		 * Prefetch the objects that are to be checked out in the loop
 		 * below.
@@ -879,6 +929,7 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 	struct traverse_info newinfo;
 	struct name_entry *p;
 	int nr_entries;
+	struct repository *repo = unpack_repo(NULL, o);
 
 	nr_entries = all_trees_same_as_cache_tree(n, dirmask, names, info);
 	if (nr_entries > 0) {
@@ -940,7 +991,7 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 			const struct object_id *oid = NULL;
 			if (dirmask & 1)
 				oid = &names[i].oid;
-			buf[nr_buf++] = fill_tree_descriptor(the_repository, t + i, oid);
+			buf[nr_buf++] = fill_tree_descriptor(repo, t + i, oid);
 		}
 	}
 
@@ -1773,24 +1824,25 @@ static int clear_ce_flags(struct index_state *istate,
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
@@ -1885,13 +1937,13 @@ static int verify_absent(const struct cache_entry *,
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
@@ -1936,7 +1988,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		populate_from_existing_patterns(o, &pl);
 	}
 
-	index_state_init(&o->internal.result, o->src_index->repo);
+	index_state_init(&o->internal.result, repo);
 	o->internal.result.initialized = 1;
 	o->internal.result.timestamp.sec = o->src_index->timestamp.sec;
 	o->internal.result.timestamp.nsec = o->src_index->timestamp.nsec;
@@ -2080,7 +2132,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		move_index_extensions(&o->internal.result, o->src_index);
 		if (!ret) {
 			if (git_env_bool("GIT_TEST_CHECK_CACHE_TREE", 0) &&
-			    cache_tree_verify(the_repository,
+			    cache_tree_verify(repo,
 					      &o->internal.result) < 0) {
 				ret = -1;
 				goto done;
@@ -2136,10 +2188,11 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o,
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
@@ -2332,10 +2385,11 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
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
@@ -2423,6 +2477,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 			      struct unpack_trees_options *o)
 {
 	const struct cache_entry *result;
+	struct repository *repo = unpack_repo(NULL, o);
 
 	/*
 	 * It may be that the 'lstat()' succeeded even though
@@ -2431,7 +2486,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 	 *
 	 * Ignore that lstat() if it matches.
 	 */
-	if (repo_ignore_case(the_repository) && icase_exists(o, name, len, st))
+	if (repo_ignore_case(repo) && icase_exists(o, name, len, st))
 		return 0;
 
 	if (o->internal.dir &&
@@ -2651,6 +2706,7 @@ static int merged_sparse_dir(const struct cache_entry * const *src, int n,
 	void * tree_bufs[MAX_UNPACK_TREES + 1];
 	struct traverse_info info;
 	int i, ret;
+	struct repository *repo = unpack_repo(NULL, o);
 
 	/*
 	 * Create the tree traversal information for traversing into *only* the
@@ -2664,7 +2720,7 @@ static int merged_sparse_dir(const struct cache_entry * const *src, int n,
 
 	/* Get the tree descriptors of the sparse directory in each of the merging trees */
 	for (i = 0; i < n; i++)
-		tree_bufs[i] = fill_tree_descriptor(o->src_index->repo, &t[i],
+		tree_bufs[i] = fill_tree_descriptor(repo, &t[i],
 						    src[i] && !is_null_oid(&src[i]->oid) ? &src[i]->oid : NULL);
 
 	ret = traverse_trees(o->src_index, n, t, &info);
-- 
2.56.0-626-gaba6dc7e00

