Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176167;
	b=ZsFESW4VEdqb4tWGcO7TvCvUkdVmM+G4AZb7VUz7MHRFo8nNd2n9nElmHgGdvDtyum0S
	 reRYTOai6PPo76CQ8RdBHwhzrOIhX+5I6NHb8BpuY/2JCj64mJ2igOlhDamIp8+ETz7Q0
	 9cOlDAdJpxlcA8esaSabY0SPj3lMoHI4s2DSoGYwRCA2smDubqkJMJ2pbxxOtmKNSQpqv
	 pEbI8F/bw81BP9UCwzCa73TJFDP4Qm2zsEhGADLLMCilHM26T2Q44yhbr6pKmWelxvKwp
	 rEg3wkI7KtmhFe7jE3ruhM/ZdBOIFQ3HFFfOFqDEm/fbnj9UDeaBJO4K3iCPej/pFbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176167;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=a56PniWzpqttCZux2ccGtn4TyN33CmYzmTikLTx8Rkg=;
	b=V8eFki6xs9TlS9adqZbL547FZmR7ARGXDtISmJA8YQ+i4X19DUHUWHVLwJXdUeu9+LNP
	 yfgGWcn1EzjzzFYyJcDCBI6dduO6VqIMHINLISILv/7xjYiQzeQqe01W7yPlXZauMQL0x
	 SBpJ8uDAoLdbQqF2lDa55xjKoXf+yfS+0tBvzmnyx08dIthRob7IRcMtKLaxk0kGvO7+1
	 JZG63Xw6rsioYenNh866R/AxkvtKlsgqFK7QTre42sngUeiUee9cNw6UNdUsswnV7UO1G
	 d8KCn7miZfhrDASq/XG22ZA1q3iNnUEdRvQ8ZmZ81SiyEc1U7O9cfpIvP8jvHx6SYRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=0OzxU2aB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LHSeFvaQ;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBB0606A320
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 12:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EBB0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=0OzxU2aB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LHSeFvaQ
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 6D8EAEC089C
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 07:02:45 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 20 Nov 2026 07:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795176165;
	 x=1795262565; bh=a56PniWzpqttCZux2ccGtn4TyN33CmYzmTikLTx8Rkg=; b=
	0OzxU2aBQitL9QnuhNb0mNpInd5tYVo7tQmn1/eIwwRRxIYTOLIqf0OHde32oozJ
	T/0QK173x447KHa0ungg/Kl7s73Qt2q1BJ9nple7SoMnVTcxXGqJf3EEdfs5liwh
	6w9aqWpwKvjoj5t9Ov71KtYj8et9iz6Gl4F7yXyaUAbS0so7qUOfhogwhgZnBtXq
	XkR68kPMK90YOJvEx9FwIMgtkBA9J/EXr0hZd/FdcJ9HeLWkz32dEkyvTEd92kfy
	lx0SuE8URaiW2OHMxIZOqWH1Ag7fH25xZj1qiedwmCsdNceVHYnlIlgvgwkMXJPG
	+iCg5TnbVgPohdffmIDcWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795176165; x=
	1795262565; bh=a56PniWzpqttCZux2ccGtn4TyN33CmYzmTikLTx8Rkg=; b=L
	HSeFvaQ3yjpo34tV3mNhfFB3sNmadTaZFsPO0o2saEiP+2oTISHG8rQCKoBYCysV
	RXXKW7ePf5uD2wLXrG9ctuwWHM+MrSamwot0BeCxDND1Ow6ZguPllgUuji1mdx5/
	NHdqZe+KQBvBeUXOwbum5L1/5GV71v0Lny6p5IjmjAPWP4wDZa0+ScnkL2jYT/wt
	on3qopXOpp4DhvsojQwZJNoDGkgTKrDFlsIn3cq0uoqJT7XPz4h9DFbXqe2L34HU
	wuG/zvUD5KaPNkP6BoMQg9puaW9i6ah5DMlMffHOCFmY7urj33ccB+XHiRjmywyX
	n1B2jW3ZMhm+cqmrkD1Ng==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795176165; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:PUuPJfDyE7oELt9CuVc7wspVhE//LFtv1eN4a3a2JeGE59H
	uMKv8rAEUcU0pUukLEKOhBjiq3jl/c9bpUt/ZFJr2uFBZzFahJCf18rQ9hbGeX5G
	NFoja9AMhReVKQ5emUF2rmfkj5JIh7M6XgrI6/wOGvpbP4nJlHhk5SRoysMWz/P7
	KOuF2Vpld/8Ouc8CREthZRKtumF97eLRA+KT0JiWjxBLkdBwgOuS4XsfyEvUZPj8
	0qeUPgCHMY9ZIVFS/CTn6xuDgtckCLkaKbpepTyPCCeRa29nu569ZNxLAlqNbMXM
	49Gnb3b5CES/pwOnrJg/vWHK1c6uRxsv6M0XCYg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:E7YEW6ar+6l3sJ9136IOxTtSbsjZkY49iNLp262of2w=:fuCigIYZxP1p1tnZ+aPEgW8PvfSiSCIlGJhmOttVkPA=;
X-ME-Sender: <xms:5TYAa6JWQwjdhX8G1XStEaJ_3oSKi2-5nWntU7d4_JxlNlbyGbQGhg>
    <xme:5TYAa5GDeQTB35YgnRjiL1pkO3pREX_fXxoEajUZI-25hXe4uNfv1lqeThoALbc03
    Ec5E63WxvH-sS479G1x1Gf-EHYAvJCMe1NPdWz_MWRE4YmezNIZQto>
X-ME-Received: <xmr:5TYAawW2v5dbb2q-fkOOV0HAknyW02gqmKOPXP4mfzvltbzebICVOCDAOFfpi2LQzDWVeAM>
X-ME-Proxy-Cause: dmFkZTFHAgmJztTcDCPyZJnL0iP1g6Zd/dTY2NGGsR5DFH4R/k8g3YLCCs9nh03P2/jR+/
    nfvb6c/cNdoi4u9fBHNZ0O45HWkv2L1oRwgJpwbJeqPxx1+Lo7mwIuXmOIk49F0b0HS95c
    nMXl2G7WctB3PEQjznjVyXTWzdw2TjT0qh5dnSmn6Ew8CulHgHa6v/sZMa0Ww6JiOVe+xf
    X1NnJNPxDQB0JxNWH8WENe9OeVk/vQXei5Lm3iifJn1OWeyiChV136Vh0O8YpXn9lfm57K
    FRI5qXk1xUTe8xAVDkS/C+2ZxnSLXnCUOfn1JI7lC/rONuO8ou4ULl9DTxpKXTZ5NJs4ct
    3Gylho9JjpTyqZmoilpQUQ92ebte07qzSGWT8tj42Qn9tIWQAtq6spyVBYq1AIxDE5kAhU
    QBqVz7vzHD8qvcigx7mWfN54hWvMLO2n4UNH48JwtjH1cXhel68Qh0j8UYO/cqQJ6UEmED
    Sw4Kd+hoyXxPtppF0u2Y+ZwrCX27ObS9rzgO+z8QGjanerQsRPsnTgvk0w3d0bruaGXUUt
    wav0bN4FkC8KyWYFtM4/g9u72DdWsBDym+6zcIq0VqJnWMWcCDBx7gPevqiWM4nGHmyZEU
    1WMfleIx4Cd4WXPEXAr9Cg+ofgpsniE369rWNR0DzGmIz6mJeThU5jsbp9ag
X-ME-Proxy: <xmx:5TYAa0h_OmVgYifoO548gt9l223AD06--LyjuZMBktgP_fBo29pqbg>
    <xmx:5TYAaxTXxw9RT6UletObR_GiAXRfbo3pvU2WNlxOQil3kBYnUsnfQA>
    <xmx:5TYAa3F4baMaEW0rQ22IgzXcO4Flg2lZVtHuP-quW6F_dSl3YLaobA>
    <xmx:5TYAa5nX_AQ2wqFL-CClW1z8SKkQnDSlT5wvPvlbWfCoAfC3imOy6w>
    <xmx:5TYAa7owbTcZCRNTv_KqWwR53mHA9k4qKeZiNBmCgyxfxoiOp07zvpK1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 20 Nov 2026 07:02:44 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c94f9fc6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 20 Nov 2026 12:02:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Nov 2026 13:02:29 +0100
Subject: [PATCH 2/6] packfile: rename lifecycle functions
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
Message-Id: <20261120-pks-packfile-global-statistics-v1-2-19beb83b145f@pks.im>
References: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
In-Reply-To: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The packfile subsystem is kind of the wild west when it comes to
function naming. None of the functions have proper subsystem prefixes
and the naming of `struct packed_git` feels like a relict from the past.

Ideally we'd modernize all of that, but that would lead to a huge amount
of churn. Instead, let's improve the subsystem one step at a time and
rename lifecycle-related functions to match modern best practices.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/count-objects.c  |  2 +-
 builtin/fast-import.c    |  4 ++--
 builtin/index-pack.c     |  8 ++++----
 builtin/pack-objects.c   |  2 +-
 builtin/pack-redundant.c |  2 +-
 commit-graph.c           | 10 +++++-----
 connected.c              |  6 +++---
 http-push.c              |  2 +-
 http-walker.c            |  4 ++--
 http.c                   |  2 +-
 midx-write.c             | 18 +++++++++---------
 midx.c                   |  6 +++---
 odb/source-packed.c      | 12 ++++++------
 pack-check.c             |  2 +-
 pack-mtimes.c            |  2 +-
 pack-revindex.c          |  4 ++--
 packfile.c               | 46 +++++++++++++++++++++++-----------------------
 packfile.h               | 29 +++++++++++++++--------------
 repack-geometry.c        |  2 +-
 repack-midx.c            |  2 +-
 t/helper/test-bitmap.c   |  2 +-
 21 files changed, 84 insertions(+), 83 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 3f7b20fde53..09922ae4a70 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -132,7 +132,7 @@ int cmd_count_objects(int argc,
 		repo_for_each_pack(the_repository, p) {
 			if (!p->pack_local)
 				continue;
-			if (open_pack_index(p))
+			if (packfile_open_index(p))
 				continue;
 			packed += p->num_objects;
 			size_pack += p->pack_size + p->index_size;
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 14e75149415..5f034d39a71 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -906,7 +906,7 @@ static void end_packfile(void)
 		struct branch *b;
 		struct tag *t;
 
-		close_pack_windows(pack_data);
+		packfile_close_windows(pack_data);
 		finalize_hashfile(pack_file, cur_pack_oid.hash, FSYNC_COMPONENT_PACK, 0);
 		fixup_pack_header_footer(the_hash_algo, pack_data->pack_fd,
 					 pack_data->hash, pack_data->pack_name,
@@ -1273,7 +1273,7 @@ static void *gfi_unpack_entry(
 		 * and updating the packfile length ensures we can read
 		 * the newly written data.
 		 */
-		close_pack_windows(p);
+		packfile_close_windows(p);
 		hashflush(pack_file);
 
 		/* We have to offer rawsz bytes additional on the end of
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 0264c18c5f8..71048a5a8af 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1741,12 +1741,12 @@ static void read_v2_anomalous_offsets(struct packed_git *p,
 
 static void read_idx_option(struct pack_idx_option *opts, const char *pack_name)
 {
-	struct packed_git *p = add_packed_git(the_repository, pack_name,
-					      strlen(pack_name), 1);
+	struct packed_git *p = packfile_from_idx(the_repository, pack_name,
+						 strlen(pack_name), 1);
 
 	if (!p)
 		die(_("Cannot open existing pack file '%s'"), pack_name);
-	if (open_pack_index(p))
+	if (packfile_open_index(p))
 		die(_("Cannot open existing pack idx file for '%s'"), pack_name);
 
 	/* Read the attributes from the existing idx file */
@@ -1762,7 +1762,7 @@ static void read_idx_option(struct pack_idx_option *opts, const char *pack_name)
 	 * know we haven't installed this pack (hence we never have
 	 * read anything from it).
 	 */
-	close_pack_index(p);
+	packfile_close_index(p);
 	free(p);
 }
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 87c3102e622..9c375811937 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4724,7 +4724,7 @@ static void loosen_unused_packed_objects(void)
 		if (!p->pack_local || p->pack_keep || p->pack_keep_in_core)
 			continue;
 
-		if (open_pack_index(p))
+		if (packfile_open_index(p))
 			die(_("cannot open pack index"));
 
 		for (i = 0; i < p->num_objects; i++) {
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 86749bb7e77..1b437bb6565 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -546,7 +546,7 @@ static struct pack_list * add_pack(struct packed_git *p)
 	l.pack = p;
 	llist_init(&l.remaining_objects);
 
-	if (open_pack_index(p)) {
+	if (packfile_open_index(p)) {
 		llist_free(l.remaining_objects);
 		return NULL;
 	}
diff --git a/commit-graph.c b/commit-graph.c
index da65cd3deb9..c3b04e8c1f4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1950,21 +1950,21 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 	for (i = 0; i < pack_indexes->nr; i++) {
 		struct packed_git *p;
 
-		p = add_packed_git(ctx->r, pack_indexes->items[i].string,
-				   strlen(pack_indexes->items[i].string), 1);
+		p = packfile_from_idx(ctx->r, pack_indexes->items[i].string,
+				      strlen(pack_indexes->items[i].string), 1);
 		if (!p) {
 			ret = error(_("error adding pack %s"), pack_indexes->items[i].string);
 			goto cleanup;
 		}
-		if (open_pack_index(p)) {
+		if (packfile_open_index(p)) {
 			ret = error(_("error opening index for %s"), pack_indexes->items[i].string);
-			close_pack(p);
+			packfile_close(p);
 			free(p);
 			goto cleanup;
 		}
 		for_each_object_in_pack(p, add_packed_commits, ctx,
 					ODB_FOR_EACH_OBJECT_PACK_ORDER);
-		close_pack(p);
+		packfile_close(p);
 		free(p);
 	}
 
diff --git a/connected.c b/connected.c
index bfb771e4695..fbacff734b6 100644
--- a/connected.c
+++ b/connected.c
@@ -207,8 +207,8 @@ int check_connected(struct repository *repo,
 		strbuf_add(&idx_file, transport->pack_lockfiles.items[0].string,
 			   base_len);
 		strbuf_addstr(&idx_file, ".idx");
-		new_pack = add_packed_git(repo, idx_file.buf,
-					  idx_file.len, 1);
+		new_pack = packfile_from_idx(repo, idx_file.buf,
+					     idx_file.len, 1);
 		strbuf_release(&idx_file);
 	}
 
@@ -239,7 +239,7 @@ int check_connected(struct repository *repo,
 
 	sigchain_pop(SIGPIPE);
 	if (new_pack) {
-		close_pack(new_pack);
+		packfile_close(new_pack);
 		free(new_pack);
 	}
 	return finish_command(&rev_list) || err;
diff --git a/http-push.c b/http-push.c
index b8f3faaed95..d5335c023c8 100644
--- a/http-push.c
+++ b/http-push.c
@@ -318,7 +318,7 @@ static void start_fetch_packed(struct transfer_request *request)
 		release_request(request);
 		return;
 	}
-	close_pack_index(target);
+	packfile_close_index(target);
 	request->target = target;
 
 	fprintf(stderr,	"Fetching pack %s\n",
diff --git a/http-walker.c b/http-walker.c
index 4f50dd9b8d0..de43d9cf673 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -435,7 +435,7 @@ static int http_fetch_pack(struct walker *walker, struct alt_base *repo,
 	target = packfile_list_find_oid(repo->packs.head, oid);
 	if (!target)
 		return -1;
-	close_pack_index(target);
+	packfile_close_index(target);
 
 	if (walker->get_verbosely) {
 		fprintf(stderr, "Getting pack %s\n",
@@ -588,7 +588,7 @@ static void cleanup(struct walker *walker)
 			alt_next = alt->next;
 
 			for (e = alt->packs.head; e; e = e->next) {
-				close_pack(e->pack);
+				packfile_close(e->pack);
 				free(e->pack);
 			}
 			packfile_list_clear(&alt->packs);
diff --git a/http.c b/http.c
index d79678d01f0..e86bebdffb2 100644
--- a/http.c
+++ b/http.c
@@ -2658,7 +2658,7 @@ static int fetch_and_setup_pack_index(struct packfile_list *packs,
 
 	ret = verify_pack_index(new_pack);
 
-	close_pack_index(new_pack);
+	packfile_close_index(new_pack);
 	free(tmp_idx);
 	if (ret) {
 		free(new_pack);
diff --git a/midx-write.c b/midx-write.c
index 3038bbfad26..d5be4e40843 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -172,17 +172,17 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 			return;
 
 		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
-		p = add_packed_git(ctx->repo, full_path, full_path_len, 0);
+		p = packfile_from_idx(ctx->repo, full_path, full_path_len, 0);
 		if (!p) {
 			warning(_("failed to add packfile '%s'"),
 				full_path);
 			return;
 		}
 
-		if (open_pack_index(p)) {
+		if (packfile_open_index(p)) {
 			warning(_("failed to open pack-index '%s'"),
 				full_path);
-			close_pack(p);
+			packfile_close(p);
 			free(p);
 			return;
 		}
@@ -1464,7 +1464,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 		 * Ignore failures as they can be expected and are not
 		 * fatal during this selection time.
 		 */
-		open_pack_index(oldest);
+		packfile_open_index(oldest);
 
 		if (opts->packs_to_drop && opts->packs_to_drop->nr)
 			BUG("cannot write a MIDX bitmap during expiration");
@@ -1480,7 +1480,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 
 			if (!oldest->num_objects || p->mtime < oldest->mtime) {
 				oldest = p;
-				open_pack_index(oldest);
+				packfile_open_index(oldest);
 				ctx.preferred_pack_idx = i;
 			}
 		}
@@ -1505,7 +1505,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	if (ctx.preferred_pack_idx != NO_PREFERRED_PACK) {
 		struct packed_git *preferred = ctx.info[ctx.preferred_pack_idx].p;
 
-		if (open_pack_index(preferred))
+		if (packfile_open_index(preferred))
 			die(_("failed to open preferred pack %s"),
 			    ctx.info[ctx.preferred_pack_idx].pack_name);
 
@@ -1828,7 +1828,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 cleanup:
 	for (size_t i = 0; i < ctx.nr; i++) {
 		if (ctx.info[i].p) {
-			close_pack(ctx.info[i].p);
+			packfile_close(ctx.info[i].p);
 			free(ctx.info[i].p);
 		}
 		free(ctx.info[i].pack_name);
@@ -1944,7 +1944,7 @@ int expire_midx_packs(struct odb_source_packed *source, unsigned flags)
 			continue;
 
 		pack_name = xstrdup(m->packs[i]->pack_name);
-		close_pack(m->packs[i]);
+		packfile_close(m->packs[i]);
 
 		string_list_insert(&packs_to_drop, m->pack_names[i]);
 		unlink_pack_path(pack_name, 0);
@@ -2000,7 +2000,7 @@ static int want_included_pack(struct multi_pack_index *m,
 		return 0;
 	if (p->is_cruft)
 		return 0;
-	if (open_pack_index(p) || !p->num_objects)
+	if (packfile_open_index(p) || !p->num_objects)
 		return 0;
 	return 1;
 }
diff --git a/midx.c b/midx.c
index 2d4feeeadeb..d2b8a3a4a5e 100644
--- a/midx.c
+++ b/midx.c
@@ -1023,8 +1023,8 @@ int verify_midx_file(struct odb_source_packed *source, unsigned flags)
 			uint32_t pack_int_id = pairs[i-1].pack_int_id;
 			struct packed_git *p = nth_midxed_pack(m, pack_int_id);
 
-			close_pack_fd(p);
-			close_pack_index(p);
+			packfile_close_fd(p);
+			packfile_close_index(p);
 		}
 
 		nth_midxed_object_oid(&oid, m, pairs[i].pos);
@@ -1035,7 +1035,7 @@ int verify_midx_file(struct odb_source_packed *source, unsigned flags)
 			continue;
 		}
 
-		if (open_pack_index(e.p)) {
+		if (packfile_open_index(e.p)) {
 			midx_report(_("failed to load pack-index for packfile %s"),
 				    e.p->pack_name);
 			break;
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 7fcbbb4fe9e..87e2dcdf52e 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -351,7 +351,7 @@ static int odb_source_packed_for_each_prefixed_object(
 		if (should_exclude_pack(e->pack, opts->flags))
 			continue;
 
-		if (open_pack_index(e->pack)) {
+		if (packfile_open_index(e->pack)) {
 			pack_errors = true;
 			continue;
 		}
@@ -459,7 +459,7 @@ static int odb_source_packed_for_each_object(struct odb_source *source,
 		if (bitmap && bitmap_index_contains_pack(bitmap, p))
 			continue;
 
-		if (open_pack_index(p)) {
+		if (packfile_open_index(p)) {
 			pack_errors = 1;
 			continue;
 		}
@@ -498,7 +498,7 @@ static int odb_source_packed_count_objects(struct odb_source *source,
 	for (e = packfile_store_get_packs(packed); e; e = e->next) {
 		if (e->pack->multi_pack_index)
 			continue;
-		if (open_pack_index(e->pack)) {
+		if (packfile_open_index(e->pack)) {
 			ret = -1;
 			goto out;
 		}
@@ -615,7 +615,7 @@ static int odb_source_packed_find_abbrev_len(struct odb_source *source,
 	for (e = packfile_store_get_packs(packed); e; e = e->next) {
 		if (e->pack->multi_pack_index)
 			continue;
-		if (open_pack_index(e->pack) || !e->pack->num_objects)
+		if (packfile_open_index(e->pack) || !e->pack->num_objects)
 			continue;
 
 		find_abbrev_len_for_pack(e->pack, oid, min_len, &min_len);
@@ -847,7 +847,7 @@ static void odb_source_packed_close(struct odb_source *source)
 	for (struct packfile_list_entry *e = packed->packs.head; e; e = e->next) {
 		if (e->pack->do_not_close)
 			BUG("want to close pack marked 'do-not-close'");
-		close_pack(e->pack);
+		packfile_close(e->pack);
 	}
 	if (packed->midx)
 		close_midx(packed->midx);
@@ -880,7 +880,7 @@ static int verify_packs(struct odb_source_packed *source,
 
 	if (opts->flags & ODB_FSCK_PROGRESS) {
 		for (e = packfile_store_get_packs(source); e; e = e->next) {
-			if (open_pack_index(e->pack))
+			if (packfile_open_index(e->pack))
 				continue;
 			total += e->pack->num_objects;
 		}
diff --git a/pack-check.c b/pack-check.c
index 605811b7b09..e6663bb8e16 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -184,7 +184,7 @@ int verify_pack_index(struct packed_git *p)
 {
 	int err = 0;
 
-	if (open_pack_index(p))
+	if (packfile_open_index(p))
 		return error("packfile %s index not opened", p->pack_name);
 
 	/* Verify SHA1 sum of the index file */
diff --git a/pack-mtimes.c b/pack-mtimes.c
index 8e1f2dec0ef..8ce9c808e7f 100644
--- a/pack-mtimes.c
+++ b/pack-mtimes.c
@@ -106,7 +106,7 @@ int load_pack_mtimes(struct packed_git *p)
 	if (p->mtimes_map)
 		return ret; /* already loaded */
 
-	ret = open_pack_index(p);
+	ret = packfile_open_index(p);
 	if (ret < 0)
 		goto cleanup;
 
diff --git a/pack-revindex.c b/pack-revindex.c
index 62387ae6320..5de5e4064ba 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -176,7 +176,7 @@ static int create_pack_revindex_in_memory(struct packed_git *p)
 	if (git_env_bool(GIT_TEST_REV_INDEX_DIE_IN_MEMORY, 0))
 		die("dying as requested by '%s'",
 		    GIT_TEST_REV_INDEX_DIE_IN_MEMORY);
-	if (open_pack_index(p))
+	if (packfile_open_index(p))
 		return -1;
 	create_pack_revindex(p);
 	return 0;
@@ -281,7 +281,7 @@ int load_pack_revindex_from_disk(struct packed_git *p)
 	if (p->revindex_data)
 		return 0;
 
-	if (open_pack_index(p))
+	if (packfile_open_index(p))
 		return -1;
 
 	revindex_name = pack_revindex_filename(p);
diff --git a/packfile.c b/packfile.c
index 5aa9b009174..95a97c302c7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -155,7 +155,7 @@ int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 	return 0;
 }
 
-int open_pack_index(struct packed_git *p)
+int packfile_open_index(struct packed_git *p)
 {
 	char *idx_name;
 	size_t len;
@@ -177,7 +177,7 @@ uint32_t get_pack_fanout(struct packed_git *p, uint32_t value)
 	const uint32_t *level1_ofs = p->index_data;
 
 	if (!level1_ofs) {
-		if (open_pack_index(p))
+		if (packfile_open_index(p))
 			return 0;
 		level1_ofs = p->index_data;
 	}
@@ -189,7 +189,7 @@ uint32_t get_pack_fanout(struct packed_git *p, uint32_t value)
 	return ntohl(level1_ofs[value]);
 }
 
-static struct packed_git *alloc_packed_git(struct repository *r, int extra)
+static struct packed_git *packfile_new(struct repository *r, int extra)
 {
 	struct packed_git *p = xmalloc(st_add(sizeof(*p), extra));
 	memset(p, 0, sizeof(*p));
@@ -211,7 +211,7 @@ struct packed_git *parse_pack_index(struct repository *r, unsigned char *sha1,
 {
 	char *path = pack_path_from_idx(idx_path);
 	size_t alloc = st_add(strlen(path), 1);
-	struct packed_git *p = alloc_packed_git(r, alloc);
+	struct packed_git *p = packfile_new(r, alloc);
 
 	memcpy(p->pack_name, path, alloc); /* includes NUL */
 	free(path);
@@ -268,7 +268,7 @@ static int unuse_one_window(struct object_database *odb)
 	return 0;
 }
 
-void close_pack_windows(struct packed_git *p)
+void packfile_close_windows(struct packed_git *p)
 {
 	while (p->windows) {
 		struct pack_window *w = p->windows;
@@ -283,7 +283,7 @@ void close_pack_windows(struct packed_git *p)
 	}
 }
 
-int close_pack_fd(struct packed_git *p)
+int packfile_close_fd(struct packed_git *p)
 {
 	if (p->pack_fd < 0)
 		return 0;
@@ -295,7 +295,7 @@ int close_pack_fd(struct packed_git *p)
 	return 1;
 }
 
-void close_pack_index(struct packed_git *p)
+void packfile_close_index(struct packed_git *p)
 {
 	if (p->index_data) {
 		munmap((void *)p->index_data, p->index_size);
@@ -424,7 +424,7 @@ static int close_one_pack(struct repository *r)
 	}
 
 	if (lru_p)
-		return close_pack_fd(lru_p);
+		return packfile_close_fd(lru_p);
 
 	return 0;
 }
@@ -493,7 +493,7 @@ static int open_packed_git_1(struct packed_git *p)
 	ssize_t read_result;
 	const unsigned hashsz = p->repo->hash_algo->rawsz;
 
-	if (open_pack_index(p))
+	if (packfile_open_index(p))
 		return error("packfile %s index unavailable", p->pack_name);
 
 	if (!pack_max_fds) {
@@ -557,7 +557,7 @@ static int open_packed_git(struct packed_git *p)
 {
 	if (!open_packed_git_1(p))
 		return 0;
-	close_pack_fd(p);
+	packfile_close_fd(p);
 	return -1;
 }
 
@@ -634,7 +634,7 @@ unsigned char *use_pack(struct packed_git *p,
 					  p->pack_name, mmap_os_err());
 			if (!win->offset && win->len == p->pack_size
 				&& !p->do_not_close)
-				close_pack_fd(p);
+				packfile_close_fd(p);
 			win->next = p->windows;
 			p->windows = win;
 		}
@@ -659,8 +659,8 @@ void unuse_pack(struct pack_window **w_cursor)
 	}
 }
 
-struct packed_git *add_packed_git(struct repository *r, const char *path,
-				  size_t path_len, int local)
+struct packed_git *packfile_from_idx(struct repository *r, const char *path,
+				     size_t path_len, int local)
 {
 	struct stat st;
 	size_t alloc;
@@ -679,7 +679,7 @@ struct packed_git *add_packed_git(struct repository *r, const char *path,
 	 * the use xsnprintf double-checks that)
 	 */
 	alloc = st_add3(path_len, strlen(".promisor"), 1);
-	p = alloc_packed_git(r, alloc);
+	p = packfile_new(r, alloc);
 	memcpy(p->pack_name, path, path_len);
 
 	/*
@@ -753,8 +753,8 @@ struct packed_git *packfile_store_load_pack(struct odb_source_packed *store,
 
 	p = strmap_get(&store->packs_by_path, key.buf);
 	if (!p) {
-		p = add_packed_git(store->base.odb->repo, idx_path,
-				   strlen(idx_path), local);
+		p = packfile_from_idx(store->base.odb->repo, idx_path,
+				      strlen(idx_path), local);
 		if (p)
 			packfile_store_add_pack(store, p);
 	}
@@ -875,7 +875,7 @@ size_t get_size_from_delta(struct packed_git *p,
 		 * counter is incremented before window reading and checked
 		 * before window disposal.
 		 *
-		 * Other worrying sections could be the call to close_pack_fd(),
+		 * Other worrying sections could be the call to packfile_close_fd(),
 		 * which can close packs even with in-use windows, and to
 		 * odb_reprepare(). Regarding the former, mmap doc says:
 		 * "closing the file descriptor does not unmap the region". And
@@ -1227,11 +1227,11 @@ static void delta_base_cache_evict_entry(struct packed_git *p)
 	}
 }
 
-void close_pack(struct packed_git *p)
+void packfile_close(struct packed_git *p)
 {
-	close_pack_windows(p);
-	close_pack_fd(p);
-	close_pack_index(p);
+	packfile_close_windows(p);
+	packfile_close_fd(p);
+	packfile_close_index(p);
 	close_pack_revindex(p);
 	close_pack_mtimes(p);
 	oidset_clear(&p->bad_objects);
@@ -1725,7 +1725,7 @@ int nth_packed_object_id(struct object_id *oid,
 	const unsigned char *index = p->index_data;
 	const unsigned int hashsz = p->repo->hash_algo->rawsz;
 	if (!index) {
-		if (open_pack_index(p))
+		if (packfile_open_index(p))
 			return -1;
 		index = p->index_data;
 	}
@@ -1783,7 +1783,7 @@ off_t find_pack_entry_one(const struct object_id *oid,
 	uint32_t result;
 
 	if (!index) {
-		if (open_pack_index(p))
+		if (packfile_open_index(p))
 			return 0;
 	}
 
diff --git a/packfile.h b/packfile.h
index bab9931d00e..f817bc69e29 100644
--- a/packfile.h
+++ b/packfile.h
@@ -180,7 +180,7 @@ const char *pack_basename(struct packed_git *p);
  * You probably don't want to use this function! It skips most of the normal
  * sanity checks (including whether we even have the matching .pack file),
  * and does not add the resulting packed_git struct to the internal list of
- * packs. You probably want add_packed_git() instead.
+ * packs. You probably want packfile_from_idx() instead.
  */
 struct packed_git *parse_pack_index(struct repository *r, unsigned char *sha1,
 				    const char *idx_path);
@@ -217,32 +217,33 @@ int for_each_object_in_pack(struct packed_git *p,
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
+uint32_t get_pack_fanout(struct packed_git *p, uint32_t value);
+
+struct object_database;
+
+struct packed_git *packfile_from_idx(struct repository *r, const char *path,
+				     size_t path_len, int local);
+
 /*
  * mmap the index file for the specified packfile (if it is not
  * already mmapped).  Return 0 on success.
  */
-int open_pack_index(struct packed_git *);
+int packfile_open_index(struct packed_git *);
+
+void packfile_close(struct packed_git *);
+int packfile_close_fd(struct packed_git *p);
+void packfile_close_windows(struct packed_git *);
 
 /*
  * munmap the index file for the specified packfile (if it is
  * currently mmapped).
  */
-void close_pack_index(struct packed_git *);
-
-int close_pack_fd(struct packed_git *p);
-
-uint32_t get_pack_fanout(struct packed_git *p, uint32_t value);
-
-struct object_database;
+void packfile_close_index(struct packed_git *);
 
 unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t,
 			size_t *);
-void close_pack_windows(struct packed_git *);
-void close_pack(struct packed_git *);
 void unuse_pack(struct pack_window **);
 void clear_delta_base_cache(void);
-struct packed_git *add_packed_git(struct repository *r, const char *path,
-				  size_t path_len, int local);
 
 /*
  * Unlink the .pack and associated extension files.
@@ -345,7 +346,7 @@ int is_promisor_object(struct repository *r, const struct object_id *oid);
  *
  * This function should not be used directly. It is exposed here only so that we
  * have a convenient entry-point for fuzz testing. For real uses, you should
- * probably use open_pack_index() instead.
+ * probably use packfile_open_index() instead.
  */
 int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 	     size_t idx_size, struct packed_git *p);
diff --git a/repack-geometry.c b/repack-geometry.c
index b541c34af5f..671a3dfe6a3 100644
--- a/repack-geometry.c
+++ b/repack-geometry.c
@@ -9,7 +9,7 @@
 
 static uint32_t pack_geometry_weight(struct packed_git *p)
 {
-	if (open_pack_index(p))
+	if (packfile_open_index(p))
 		die(_("cannot open index for %s"), p->pack_name);
 	return p->num_objects;
 }
diff --git a/repack-midx.c b/repack-midx.c
index 72810034733..7051a0d0637 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -576,7 +576,7 @@ static int midx_compaction_step_include_packs(struct midx_compaction_step *step,
 		strbuf_reset(&path);
 		strbuf_addf(&path, "%s/%s", opts->packdir, item->string);
 		p = packfile_store_load_pack(files->dirs->packed, path.buf, 1);
-		if (!p || open_pack_index(p)) {
+		if (!p || packfile_open_index(p)) {
 			ret = error(_("cannot open index for %s"), path.buf);
 			goto out;
 		}
diff --git a/t/helper/test-bitmap.c b/t/helper/test-bitmap.c
index 8547ef67e24..e3a3c8ff5cc 100644
--- a/t/helper/test-bitmap.c
+++ b/t/helper/test-bitmap.c
@@ -87,7 +87,7 @@ static int bitmap_write(const char *basename)
 	if (!p)
 		die("could not find pack '%s'", basename);
 
-	if (open_pack_index(p))
+	if (packfile_open_index(p))
 		die("cannot open pack index for '%s'", p->pack_name);
 
 	prepare_packing_data(the_repository, &packed);

-- 
2.56.1.831.g720f3f5937.dirty

