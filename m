Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792759857;
	b=hxEVIkhXegulZhmhWple+Rl8y/Efpu+eCPpCgRnRl+zY8nrmnayE74qPtxvVc/HgTe2m
	 h6EaKmxLJHVfI+ONr6WmGvGL4jc2gXZ74wk77Msszsynvg9GIwXq/pBWOhz2OtHNB6Gb7
	 uZkJgS/AmJzh8I9VV8HB3w/qsUSpO/KlXndaNX0dJg39BVRPc2tos2N6vehDE+tashEny
	 dPXe6FWLSQecqohB1aL56ENl3kM30NfpJNxPCOB3rd8oInWS1SuHyTGdYhrJMvfxzYURK
	 3yC7vrzByfVAAfYk81ctiOLIDqcrdpd/ekHmS7t0VodZBUxv5nh0oMZziXkn92hQfRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759857;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=+r+gQA68DjT0ISBvYoKQHl9eV9PtzyPxwVnfBTozP/Q=;
	b=D6Fy2TDvgeHqjuBrz6Cd/QBjyHm9UhEguyCpjoAR3SX15xvl9dHXTyiWCK3pdpdyK2nz
	 K3Kb3aQd+1NiW4uBmCl/eeCp8cV9u+dMQjQqHhJhGkjP8wkWFvdov+uDgmCdBcfQMJu+a
	 3PzSO9dCdvcIMS3gu2uyIrc9v9h5n628C5WfTRRpuWc/HdXSAjwF+29ntdXMQgnqPFYiM
	 2NhtTtCSOE/gctOpXe9CsavYB89Zr/xNANAU2ieEyaktMjh1r+4STSlvtvAY//+wVi84U
	 1q2cDs8vIyRqbHia9IjnH2tAjimheSbxLkhyjQ0/dFMIVWwXBbsK4y8Ffb2ptQv4KNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b="HCgVd/T1";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ypDPc4Ak;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D45C606A31F
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 12:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D45C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=HCgVd/T1;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ypDPc4Ak
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D1E0F1D00120
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:50:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 23 Oct 2026 08:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792759856;
	 x=1792846256; bh=+r+gQA68DjT0ISBvYoKQHl9eV9PtzyPxwVnfBTozP/Q=; b=
	HCgVd/T1NB1G4sveethhY2rdU65RhvPFy4UWO2qldtlYiV/CTGTy6Fyl8jiR/q58
	zTHF9pkOwXUxs+yMOqSZI4WR69CBZXB5la8Mn+jVJtR2XQhJxMSw6nC4TnlSg5gh
	jZus0sFdCm/biGDPm9eabmP+E/QMXX9kMEaFx1/lRtFoWsOlKovxHY1bZevDeX9H
	PlF1p2BBb5xLnFAQbqPK/u27QBwjTdx4VxJGZu8wzNAd8/pd2L6s201K0545sFm8
	k2TR82InsrqiLE4TofKySgjV86JVBoVskRwaIM8d1LR60LXQrDJIWQu8Vyo0hLmU
	2efnCvgLOpX6MIqEfjcDtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792759856; x=
	1792846256; bh=+r+gQA68DjT0ISBvYoKQHl9eV9PtzyPxwVnfBTozP/Q=; b=y
	pDPc4AkTQxvF5F8bMq7St+/FNq+EXZOrD8Mu10QbjOFjUxjU/eitIbTDM7S77qmh
	vO1SdTLF8Wx9qqZfCbVe8U1zSM9KHNMOQPLuBxggDCknCyKpXF9Mp0PLRU+8ikG6
	QGTKMM2PN+PUigqNzI3R8oo35Vit/8CkorusYlHB62uI+ZcqipZw3eTztNce5INb
	KD04vAzA4JxdfMHEArAjHyx0TYALfhWYQE+LlUYlZgEF1Cvp4Za/Nzw+JyW5mY6B
	+hHPLED0Sgg8hsJDl3W9MdoFZMqCxfKDmM7gfpuGdZrkGjQvjAT1yBwbnkhHNoqj
	1/NiDU0nJZq3Fytm4cEAg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792759856; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:b6o46cYDH9yc+bpfy22qV7XKXKCh0i9gWT7gD5qYAYGMy7F
	6jLqMkhL0m3Gm+j6sZl6L/wfbbcstr9kJdajQMdCdpXqmDBjLpPTv1zOcw032UbY
	XSrE3E+ttJ2VTNQVU4st65E60E8LhhrlgYQlKBv8e7GZnIkLWvryH3icj/0Dm2vg
	YEZSg4uIo447ZKBR4o+9Gq1IVTuiS9tKoZlauY5XUzmg+jCYMCpZP6bXEtKoKPXN
	l+4iMQ8Msi2ckCosb4US7P3L5xPstTRXqg7PXet/qo74Oen1RdxU9DurWDHyHp2Z
	dZ5+3FXq4TkOTK5m6NyAxmIN4otvKxdtm2G8plA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:23w3oYD7HRUof60qGcJ3PrcTvDQfbK8YOb2gh08dmDg=:AWEoDLxAvjDDSM9qbCa3T8OZCq8EdPQGMmDy99/FT5Q=;
X-ME-Sender: <xms:MFjbao1SkNgPCmcWN982jtL3XM_kOWsilkCWdLGhA15feJSrYkRKew>
    <xme:MFjbaqDoOeZSK_e1p8JxZyMFR0mU_ZlLmujnIO7Op5cdxnnU0QYiTt0DcSDiUXOlu
    4l12-J3nxNzFzXSsQq26vlSiZG9s7bc565_JFb1cbvTxyX5hj2G-xrT>
X-ME-Received: <xmr:MFjbamg3Sr11ROWCWXE_DZ8rPy2ul263HZXrOU2mSRfK0ky9rorCDHiMIzQNWSk6Hz0mVg>
X-ME-Proxy-Cause: dmFkZTEZWmY0Qmse88D2CTZhoi8Qx0ylXXKu6tAIs+BgXtqVGgxd/BqeTscGyUMn+xFilD
    dbRwCxMug0rRp6s2RoHecdj9ea5hmWM3L0vQAhPjkBlnRMmj4SG+wUEhQrwSSuqtYxqSMC
    m0DRlT9dFvfAw6sGkgKQCvfsTOB64d/ziRgeOvb//JwOSbc/YIHWTXEF+8OhqYrYvtRrzq
    zE7xBm+kNci6V80J9kphE1a+aIP4j5lXX++BQuYnY6ASX3lpSXvU862yeG9TYukAXi3HGA
    UpXkLszIvdbN24fmOyyIJRzRCJfv7/ZJ3cqGbKu2PvQsXxJGlHHRMZ823g3aWBbaY1FNKp
    Y5MVQ0pKLBfo3DtjsKBlAonWkFNRMejx6196/fBhgVyQVQLMghH848UB0ieuLvWbQSJ6x5
    9x36IQWyfaOVG18J2kgAxev6CICVlptxXXO5mRJbLbJOiOFZCE34nXfh4qyL1fU4aLyj9x
    H70RLH7YJFW3Brmcvfkpe0spCWYKQYQEtdkXQYpUaG+B8U6rlOSMq3dRI3BleyMkyF+Nfq
    LzW8vncTTGKz5h1um7eb8rx6F4Dyp8o+oAG3R0XOQju9V/qQy9zPcXnwEx9I/IjRP6MELs
    ukLteoMWMKlDiD4QbAaKGU1THTPnQTUY0Srer6pVXRtFevYJhyih/8OYCdtQ
X-ME-Proxy: <xmx:MFjbam-ItvIk6mN8grmsqxsA9_LEv1UiTR3eFbnrVH8WwQoX4k_hCQ>
    <xmx:MFjbaq_GxP8eT1O24t8dBIDa84tOqFyJKcPmFfaEOwdiWQ1W2u2bCg>
    <xmx:MFjbanC_SF5ijrvVolW7LlYq5tRZahj40CsA21E5ieMjrousorvPAA>
    <xmx:MFjbaiwsNyvgeYpCZoz2SRPrDt-2BHFccU6YK5jSEnn0lTin5dtThg>
    <xmx:MFjbaqHRqeHuQXvEstVzmp4m4cjXdW1cnmxwjs60ZVAjDc2NtGp8KGor>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 23 Oct 2026 08:50:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e19fd7bf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 23 Oct 2026 12:50:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 23 Oct 2026 14:50:24 +0200
Subject: [PATCH 7/7] rerere: get rid of global rerere cache state
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
Message-Id: <20261023-pks-rerere-wo-the-repository-v1-7-b6ac0c2e4b81@pks.im>
References: <20261023-pks-rerere-wo-the-repository-v1-0-b6ac0c2e4b81@pks.im>
In-Reply-To: <20261023-pks-rerere-wo-the-repository-v1-0-b6ac0c2e4b81@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The rerere cache state is tracked via a global variable. On the one hand
this ties it to one specific repository. On the other hand it has the
consequence that the cache may be leaking state across multiple calls
into the rerere subsystem.

Refactor the subsystem to instead pass around the rerere cache state
explicitly and make callers responsible for setting it up and then
clearing it again.

For now, all callers are updated to do so ad-hoc. This of course means
that state that we could carry over across multiple calls would have to
be set up multiple times. But that doesn't really matter much right now
anyway, as the number of times we call those functions is bounded.

Note that `rerere_gc_needed()` is the only caller where we explicitly
don't set up the rerere cache state. This is intentional and matches the
previous status quo, where we didn't honor "rerere.enabled", either. The
function only needs access to `struct rerere_cache::dirs` anyway though,
so it's fine to partially initialize it, only.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c |  15 ++++--
 rerere.c         | 138 +++++++++++++++++++++++++++++++++----------------------
 rerere.h         |   9 +++-
 3 files changed, 102 insertions(+), 60 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index e900e302c3..2c17f02f56 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -106,11 +106,15 @@ int cmd_rerere(int argc,
 		rerere_gc(the_repository, &merge_rr,
 			  skip_locked ? RERERE_NOWAIT : 0);
 	else if (!strcmp(argv[0], "status")) {
-		if (setup_rerere(the_repository, &merge_rr,
-				 flags | RERERE_READONLY) < 0)
+		struct rerere_cache cache;
+
+		if (rerere_cache_setup(&cache, the_repository, &merge_rr,
+				       flags | RERERE_READONLY) < 0)
 			return 0;
 		for (size_t i = 0; i < merge_rr.nr; i++)
 			printf("%s\n", merge_rr.items[i].string);
+
+		rerere_cache_release(&cache);
 	} else if (!strcmp(argv[0], "remaining")) {
 		rerere_remaining(the_repository, &merge_rr);
 		for (size_t i = 0; i < merge_rr.nr; i++) {
@@ -123,8 +127,10 @@ int cmd_rerere(int argc,
 		}
 	} else if (!strcmp(argv[0], "diff")) {
 		struct strbuf buf = STRBUF_INIT;
-		if (setup_rerere(the_repository, &merge_rr,
-				 flags | RERERE_READONLY) < 0)
+		struct rerere_cache cache;
+
+		if (rerere_cache_setup(&cache, the_repository, &merge_rr,
+				      flags | RERERE_READONLY) < 0)
 			return 0;
 		for (size_t i = 0; i < merge_rr.nr; i++) {
 			const char *path = merge_rr.items[i].string;
@@ -135,6 +141,7 @@ int cmd_rerere(int argc,
 				    rerere_path(the_repository, &buf, id, NULL));
 		}
 
+		rerere_cache_release(&cache);
 		strbuf_release(&buf);
 	} else
 		usage_with_options(rerere_usage, options);
diff --git a/rerere.c b/rerere.c
index 23bcb8bc31..e089761208 100644
--- a/rerere.c
+++ b/rerere.c
@@ -21,10 +21,6 @@
 #include "odb.h"
 #include "strmap.h"
 
-static struct rerere_cache cache = {
-	.dirs = STRMAP_INIT,
-};
-
 #define RESOLVED 0
 #define PUNTED 1
 #define THREE_STAGED 2
@@ -38,17 +34,19 @@ struct rerere_dir {
 	char name[FLEX_ARRAY];
 };
 
-static void free_rerere_dirs(void)
+void rerere_cache_release(struct rerere_cache *cache)
 {
 	struct hashmap_iter iter;
 	struct strmap_entry *ent;
 
-	strmap_for_each_entry(&cache.dirs, &iter, ent) {
+	strmap_for_each_entry(&cache->dirs, &iter, ent) {
 		struct rerere_dir *rr_dir = ent->value;
 		free(rr_dir->status);
 		free(rr_dir);
 	}
-	strmap_clear(&cache.dirs, 0);
+	strmap_clear(&cache->dirs, 0);
+
+	rollback_lock_file(&cache->write_lock);
 }
 
 static void free_rerere_id(struct string_list_item *item)
@@ -121,13 +119,13 @@ static int is_rr_file(const char *name, const char *filename, int *variant)
 	return 1;
 }
 
-static void scan_rerere_dir(struct repository *r, struct rerere_dir *rr_dir)
+static void scan_rerere_dir(struct rerere_cache *cache, struct rerere_dir *rr_dir)
 {
 	struct dirent *de;
 	char *path;
 	DIR *dir;
 
-	path = repo_git_path(r, "rr-cache/%s", rr_dir->name);
+	path = repo_git_path(cache->repo, "rr-cache/%s", rr_dir->name);
 	dir = opendir(path);
 	free(path);
 	if (!dir)
@@ -146,19 +144,20 @@ static void scan_rerere_dir(struct repository *r, struct rerere_dir *rr_dir)
 	closedir(dir);
 }
 
-static struct rerere_dir *find_rerere_dir(struct repository *r, const char *hex)
+static struct rerere_dir *find_rerere_dir(struct rerere_cache *cache,
+					  const char *hex)
 {
 	struct rerere_dir *rr_dir;
 
-	rr_dir = strmap_get(&cache.dirs, hex);
+	rr_dir = strmap_get(&cache->dirs, hex);
 	if (!rr_dir) {
 		FLEX_ALLOC_STR(rr_dir, name, hex);
 		rr_dir->status = NULL;
 		rr_dir->status_nr = 0;
 		rr_dir->status_alloc = 0;
-		strmap_put(&cache.dirs, hex, rr_dir);
+		strmap_put(&cache->dirs, hex, rr_dir);
 
-		scan_rerere_dir(r, rr_dir);
+		scan_rerere_dir(cache, rr_dir);
 	}
 	return rr_dir;
 }
@@ -173,17 +172,18 @@ static int has_rerere_resolution(const struct rerere_id *id)
 	return ((id->collection->status[variant] & both) == both);
 }
 
-static struct rerere_id *new_rerere_id_hex(struct repository *r, char *hex)
+static struct rerere_id *new_rerere_id_hex(struct rerere_cache *cache,
+					   char *hex)
 {
 	struct rerere_id *id = xmalloc(sizeof(*id));
-	id->collection = find_rerere_dir(r, hex);
+	id->collection = find_rerere_dir(cache, hex);
 	id->variant = -1; /* not known yet */
 	return id;
 }
 
-static struct rerere_id *new_rerere_id(struct repository *r, unsigned char *hash)
+static struct rerere_id *new_rerere_id(struct rerere_cache *cache, unsigned char *hash)
 {
-	return new_rerere_id_hex(r, hash_to_hex_algop(hash, r->hash_algo));
+	return new_rerere_id_hex(cache, hash_to_hex_algop(hash, cache->repo->hash_algo));
 }
 
 /*
@@ -193,10 +193,10 @@ static struct rerere_id *new_rerere_id(struct repository *r, unsigned char *hash
  * work on (i.e. what is left by the previous invocation of "git
  * rerere" during the current conflict resolution session).
  */
-static void read_rr(struct repository *r, struct string_list *rr)
+static void read_rr(struct rerere_cache *cache, struct string_list *rr)
 {
 	struct strbuf buf = STRBUF_INIT;
-	FILE *in = fopen_or_warn(git_path_merge_rr(r), "r");
+	FILE *in = fopen_or_warn(git_path_merge_rr(cache->repo), "r");
 
 	if (!in)
 		return;
@@ -205,11 +205,11 @@ static void read_rr(struct repository *r, struct string_list *rr)
 		unsigned char hash[GIT_MAX_RAWSZ];
 		struct rerere_id *id;
 		int variant;
-		const unsigned hexsz = r->hash_algo->hexsz;
+		const unsigned hexsz = cache->repo->hash_algo->hexsz;
 
 		/* There has to be the hash, tab, path and then NUL */
 		if (buf.len < hexsz + 2 ||
-		    get_hash_hex_algop(buf.buf, hash, r->hash_algo))
+		    get_hash_hex_algop(buf.buf, hash, cache->repo->hash_algo))
 			die(_("corrupt MERGE_RR"));
 
 		if (buf.buf[hexsz] != '.') {
@@ -224,7 +224,7 @@ static void read_rr(struct repository *r, struct string_list *rr)
 		if (*(path++) != '\t')
 			die(_("corrupt MERGE_RR"));
 		buf.buf[hexsz] = '\0';
-		id = new_rerere_id_hex(r, buf.buf);
+		id = new_rerere_id_hex(cache, buf.buf);
 		id->variant = variant;
 		/*
 		 * make sure id->collection->status has enough space
@@ -237,7 +237,8 @@ static void read_rr(struct repository *r, struct string_list *rr)
 	fclose(in);
 }
 
-static int write_rr(struct string_list *rr, int out_fd)
+static int write_rr(struct rerere_cache *cache,
+		    struct string_list *rr, int out_fd)
 {
 	int i;
 	for (i = 0; i < rr->nr; i++) {
@@ -264,7 +265,7 @@ static int write_rr(struct string_list *rr, int out_fd)
 
 		strbuf_release(&buf);
 	}
-	if (commit_lock_file(&cache.write_lock) != 0)
+	if (commit_lock_file(&cache->write_lock) != 0)
 		die(_("unable to write rerere record"));
 	return 0;
 }
@@ -564,12 +565,15 @@ static int find_conflict(struct repository *r, struct string_list *conflict)
  */
 int rerere_remaining(struct repository *r, struct string_list *merge_rr)
 {
-	int i;
+	struct rerere_cache cache;
+	int ret, i;
 
-	if (setup_rerere(r, merge_rr, RERERE_READONLY))
+	if (rerere_cache_setup(&cache, r, merge_rr, RERERE_READONLY))
 		return 0;
-	if (repo_read_index(r) < 0)
-		return error(_("index file corrupt"));
+	if (repo_read_index(r) < 0) {
+		ret = error(_("index file corrupt"));
+		goto out;
+	}
 
 	for (i = 0; i < r->index->cache_nr;) {
 		int conflict_type;
@@ -586,7 +590,12 @@ int rerere_remaining(struct repository *r, struct string_list *merge_rr)
 			}
 		}
 	}
-	return 0;
+
+	ret = 0;
+
+out:
+	rerere_cache_release(&cache);
+	return ret;
 }
 
 /*
@@ -714,10 +723,11 @@ static void remove_variant(struct repository *r, struct rerere_id *id)
  * only have the preimage for that conflict, in which case the result
  * needs to be recorded as a resolution in a postimage file.
  */
-static void do_rerere_one_path(struct index_state *istate,
+static void do_rerere_one_path(struct rerere_cache *cache,
 			       struct string_list_item *rr_item,
 			       struct string_list *update)
 {
+	struct index_state *istate = cache->repo->index;
 	const char *path = rr_item->string;
 	struct rerere_id *id = rr_item->util;
 	struct rerere_dir *rr_dir = id->collection;
@@ -779,7 +789,7 @@ static void do_rerere_one_path(struct index_state *istate,
 		if (0 <= id->variant && id->variant != variant)
 			remove_variant(istate->repo, id);
 
-		if (cache.autoupdate)
+		if (cache->autoupdate)
 			string_list_insert(update, path);
 		else
 			fprintf_ln(stderr,
@@ -810,12 +820,13 @@ static void do_rerere_one_path(struct index_state *istate,
 	strbuf_release(&buf);
 }
 
-static int do_plain_rerere(struct repository *r,
+static int do_plain_rerere(struct rerere_cache *cache,
 			   struct string_list *rr, int fd)
 {
 	struct string_list conflict = STRING_LIST_INIT_DUP;
 	struct string_list update = STRING_LIST_INIT_DUP;
 	struct strbuf buf = STRBUF_INIT;
+	struct repository *r = cache->repo;
 	int i;
 
 	find_conflict(r, &conflict);
@@ -845,7 +856,7 @@ static int do_plain_rerere(struct repository *r,
 		if (ret < 1)
 			continue;
 
-		id = new_rerere_id(r, hash);
+		id = new_rerere_id(cache, hash);
 		string_list_insert(rr, path)->util = id;
 
 		/* Ensure that the directory exists. */
@@ -853,7 +864,7 @@ static int do_plain_rerere(struct repository *r,
 	}
 
 	for (i = 0; i < rr->nr; i++)
-		do_rerere_one_path(r->index, &rr->items[i], &update);
+		do_rerere_one_path(cache, &rr->items[i], &update);
 
 	if (update.nr)
 		update_paths(r, &update);
@@ -861,7 +872,7 @@ static int do_plain_rerere(struct repository *r,
 	string_list_clear(&conflict, 0);
 	string_list_clear(&update, 0);
 	strbuf_release(&buf);
-	return write_rr(rr, fd);
+	return write_rr(cache, rr, fd);
 }
 
 static int is_rerere_enabled(struct repository *r)
@@ -894,7 +905,10 @@ static int is_rerere_enabled(struct repository *r)
 	return r->rerere_cache_enabled;
 }
 
-int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
+int rerere_cache_setup(struct rerere_cache *cache,
+		       struct repository *r,
+		       struct string_list *merge_rr,
+		       int flags)
 {
 	int lock_timeout_ms = 1000;
 	int fd;
@@ -902,11 +916,14 @@ int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
 	if (!is_rerere_enabled(r))
 		return -1;
 
-	repo_config_get_bool(r, "rerere.autoupdate", &cache.autoupdate);
+	memset(cache, 0, sizeof(*cache));
+	cache->repo = r;
+	strmap_init(&cache->dirs);
+	repo_config_get_bool(r, "rerere.autoupdate", &cache->autoupdate);
 	repo_config_get_int(r, "rerere.locktimeout", &lock_timeout_ms);
 
 	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
-		cache.autoupdate = !!(flags & RERERE_AUTOUPDATE);
+		cache->autoupdate = !!(flags & RERERE_AUTOUPDATE);
 	if ((flags & RERERE_READONLY) && (flags & RERERE_NOWAIT))
 		BUG("RERERE_NOWAIT does not apply with RERERE_READONLY");
 	if (flags & RERERE_READONLY) {
@@ -924,13 +941,13 @@ int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
 		 * "git rerere gc" while it prunes rr-cache, so by default
 		 * wait for it instead of dying right away.
 		 */
-		fd = repo_hold_lock_file_for_update_timeout(r, &cache.write_lock,
+		fd = repo_hold_lock_file_for_update_timeout(r, &cache->write_lock,
 							    git_path_merge_rr(r),
 							    lock_flags, lock_timeout_ms);
 		if (fd < 0)
 			return -1;
 	}
-	read_rr(r, merge_rr);
+	read_rr(cache, merge_rr);
 	return fd;
 }
 
@@ -942,13 +959,15 @@ int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
 int repo_rerere(struct repository *r, int flags)
 {
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
+	struct rerere_cache cache;
 	int fd, status;
 
-	fd = setup_rerere(r, &merge_rr, flags);
+	fd = rerere_cache_setup(&cache, r, &merge_rr, flags);
 	if (fd < 0)
 		return 0;
-	status = do_plain_rerere(r, &merge_rr, fd);
-	free_rerere_dirs();
+	status = do_plain_rerere(&cache, &merge_rr, fd);
+
+	rerere_cache_release(&cache);
 	string_list_clear(&merge_rr, 1);
 	return status;
 }
@@ -1057,10 +1076,11 @@ static int handle_cache(struct index_state *istate,
 	return has_conflicts;
 }
 
-static int rerere_forget_one_path(struct index_state *istate,
+static int rerere_forget_one_path(struct rerere_cache *cache,
 				  const char *path,
 				  struct string_list *rr)
 {
+	struct index_state *istate = cache->repo->index;
 	const char *filename;
 	struct rerere_id *id;
 	unsigned char hash[GIT_MAX_RAWSZ];
@@ -1077,7 +1097,7 @@ static int rerere_forget_one_path(struct index_state *istate,
 		return error(_("could not parse conflict hunks in '%s'"), path);
 
 	/* Nuke the recorded resolution for the conflict */
-	id = new_rerere_id(istate->repo, hash);
+	id = new_rerere_id(cache, hash);
 
 	for (id->variant = 0;
 	     id->variant < id->collection->status_nr;
@@ -1145,11 +1165,12 @@ int rerere_forget(struct repository *r, struct pathspec *pathspec)
 	int i, fd, ret;
 	struct string_list conflict = STRING_LIST_INIT_DUP;
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
+	struct rerere_cache cache;
 
 	if (repo_read_index(r) < 0)
 		return error(_("index file corrupt"));
 
-	fd = setup_rerere(r, &merge_rr, RERERE_NOAUTOUPDATE);
+	fd = rerere_cache_setup(&cache, r, &merge_rr, RERERE_NOAUTOUPDATE);
 	if (fd < 0)
 		return 0;
 
@@ -1165,13 +1186,14 @@ int rerere_forget(struct repository *r, struct pathspec *pathspec)
 		if (!match_pathspec(r->index, pathspec, it->string,
 				    strlen(it->string), 0, NULL, 0))
 			continue;
-		rerere_forget_one_path(r->index, it->string, &merge_rr);
+		rerere_forget_one_path(&cache, it->string, &merge_rr);
 	}
 
-	ret = write_rr(&merge_rr, fd);
+	ret = write_rr(&cache, &merge_rr, fd);
 
 	string_list_clear(&conflict, 0);
 	string_list_clear(&merge_rr, 1);
+	rerere_cache_release(&cache);
 	return ret;
 }
 
@@ -1267,6 +1289,10 @@ static int is_rr_cache_dirname(struct repository *r, const char *path)
 
 bool rerere_gc_needed(struct repository *r, size_t limit)
 {
+	struct rerere_cache cache = {
+		.repo = r,
+		.dirs = STRMAP_INIT,
+	};
 	timestamp_t cutoff_resolve, cutoff_noresolve;
 	struct strbuf buf = STRBUF_INIT;
 	bool needed = false;
@@ -1292,7 +1318,7 @@ bool rerere_gc_needed(struct repository *r, size_t limit)
 		    !is_rr_cache_dirname(r, e->d_name))
 			continue;
 
-		id.collection = find_rerere_dir(r, e->d_name);
+		id.collection = find_rerere_dir(&cache, e->d_name);
 		for (id.variant = 0;
 		     id.variant < id.collection->status_nr;
 		     id.variant++) {
@@ -1310,13 +1336,14 @@ bool rerere_gc_needed(struct repository *r, size_t limit)
 out:
 	if (dir)
 		closedir(dir);
-	free_rerere_dirs();
+	rerere_cache_release(&cache);
 	strbuf_release(&buf);
 	return needed;
 }
 
 void rerere_gc(struct repository *r, struct string_list *rr, int flags)
 {
+	struct rerere_cache cache;
 	struct string_list to_remove = STRING_LIST_INIT_DUP;
 	DIR *dir;
 	struct dirent *e;
@@ -1325,7 +1352,7 @@ void rerere_gc(struct repository *r, struct string_list *rr, int flags)
 	timestamp_t cutoff_resolve;
 	struct strbuf buf = STRBUF_INIT;
 
-	if (setup_rerere(r, rr, flags) < 0)
+	if (rerere_cache_setup(&cache, r, rr, flags) < 0)
 		return;
 
 	rerere_gc_cutoffs(r, &cutoff_resolve, &cutoff_noresolve);
@@ -1342,7 +1369,7 @@ void rerere_gc(struct repository *r, struct string_list *rr, int flags)
 		if (!is_rr_cache_dirname(r, e->d_name))
 			continue; /* or should we remove e->d_name? */
 
-		rr_dir = find_rerere_dir(r, e->d_name);
+		rr_dir = find_rerere_dir(&cache, e->d_name);
 
 		now_empty = 1;
 		for (id.variant = 0, id.collection = rr_dir;
@@ -1363,7 +1390,7 @@ void rerere_gc(struct repository *r, struct string_list *rr, int flags)
 					    "rr-cache/%s", to_remove.items[i].string));
 
 	string_list_clear(&to_remove, 0);
-	rollback_lock_file(&cache.write_lock);
+	rerere_cache_release(&cache);
 	strbuf_release(&buf);
 }
 
@@ -1376,9 +1403,10 @@ void rerere_gc(struct repository *r, struct string_list *rr, int flags)
  */
 void rerere_clear(struct repository *r, struct string_list *merge_rr)
 {
+	struct rerere_cache cache;
 	int i;
 
-	if (setup_rerere(r, merge_rr, 0) < 0)
+	if (rerere_cache_setup(&cache, r, merge_rr, 0) < 0)
 		return;
 
 	for (i = 0; i < merge_rr->nr; i++) {
@@ -1393,5 +1421,5 @@ void rerere_clear(struct repository *r, struct string_list *merge_rr)
 		strbuf_release(&buf);
 	}
 	unlink_or_warn(git_path_merge_rr(r));
-	rollback_lock_file(&cache.write_lock);
+	rerere_cache_release(&cache);
 }
diff --git a/rerere.h b/rerere.h
index 570667d866..d3cbd10e13 100644
--- a/rerere.h
+++ b/rerere.h
@@ -23,6 +23,8 @@ struct repository;
 extern void *RERERE_RESOLVED;
 
 struct rerere_cache {
+	struct repository *repo;
+
 	/* Automatically update cleanly resolved paths to the index. */
 	int autoupdate;
 
@@ -37,7 +39,12 @@ struct rerere_id {
 	int variant;
 };
 
-int setup_rerere(struct repository *,struct string_list *, int);
+int rerere_cache_setup(struct rerere_cache *cache,
+		       struct repository *r,
+		       struct string_list *merge_rr,
+		       int flags);
+void rerere_cache_release(struct rerere_cache *cache);
+
 int repo_rerere(struct repository *, int);
 /*
  * Given the conflict ID and the name of a "file" used for replaying

-- 
2.56.0.307.g5fe7bd680c.dirty

