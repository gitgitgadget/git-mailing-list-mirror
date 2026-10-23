Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792759852;
	b=OQmFgwapn8zQltwVA0ZkbofLbbobeCIEz20q+ufG1RGohm9vTGObKowqjoR64SvUNtw6
	 jiT0O/w5F517bokSFNZf/CH/EWy03yvkLWwQch65+Ro5fLAE/BsweQZZa9RrY21J7oI6A
	 BIkyETnYm0AwJCyYxCRJ0iJ39Pno92t8QwMsW9rw/HwWrNm3X354X4SxT2lGBVT3EcqeT
	 +UBPrp6PJQqMh37wTU5RLCzL9lzGX8gzqmZb4QvYqJow3t34tRjVrgPzOusWi/6hrcWa/
	 HqhXFo86tVVxkI5haZ4kcal8DiZIG6FHDsSt+fdNubMvO0DA16oxx/gTH9ofXiRgitA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759852;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=cS8YrSHKHw5KBusXGrjVurB+9u+xcJmT5myKaPFryl4=;
	b=LEdPMIPJVT9KpIkdIhHSzVQcx1IX3UavWHX0UPrEYT7qGzdVaOWTS1LivRfxZglsIoz6
	 oBeCU6/84LK7oHFW4OJtgjRjBZX6aYpFp/LHVcYnSDfHsz0dt8HSy8Pcm5Wi125URWxcd
	 loIN/c7R5N+VN06abgJNVvN8zcu8+QZ7gsuHjGwXJrP6pIWNcRASoFw9AevW+zrIIXQ+X
	 o2rcjHCUPiRxiI5St+NWQO6QDgW6+4yUBQy68JHXc00AbzwqWZ8+ojhBXnzJlRJfugJUt
	 aI0P43mcWQdvTvhZWgHg/ABKScPrTIHHELLXRjZN7lFOhfxwIqMBxhfLG+PbuwQ6uqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b="LZ7RK/cH";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=O5pL45Js;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52BF606A328
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 12:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B52BF606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=LZ7RK/cH;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=O5pL45Js
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 09A0A1D00154
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:50:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 23 Oct 2026 08:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792759850;
	 x=1792846250; bh=cS8YrSHKHw5KBusXGrjVurB+9u+xcJmT5myKaPFryl4=; b=
	LZ7RK/cHY70qkZAbNvRPXb1Dladkhc9QgWhGcPbFzH03ND7DtGsljEheP7nlcJ+J
	uiUhYN4vr1mSWkUvDOTYTbTpy8t9WhzJUzNOrEG3yP7nu4qxrkjFBbjUaHZbcUU2
	0hJqXpmwnyAQGtTynJY9CWUi+izf4G0P7FWfGDEHUMyu5co/Jhmy8rZyFOitI6ny
	8jvlSgJK9rCz3d6yTRDQRrb14UrBMZPtb6vVSwGI7+RDBRethjsT6yBaG64emQUv
	2ArcYfX+HO32ywHgScquDT/iY6WNZz0snwpemtl5KVqbob7UZf4Jw40/wy2yqjWm
	U761zPq6grjKrgnj6727cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792759850; x=
	1792846250; bh=cS8YrSHKHw5KBusXGrjVurB+9u+xcJmT5myKaPFryl4=; b=O
	5pL45JsiAwKm204WO4va+Dsyx6SeMZxSmLgzdevmM7XxjeM0KPlcY1+2sZRVDD5f
	TZ9FzASfYvLqYAaIFHdh9naU2J8dgSKotH40m93EgNzN2CtuVs9K7kNdYi4ZPPZy
	yoSURLt6UWnN5dRSptBzA3kSxE7Lo3x/vf+BVw33Jsi4EWS29RO4sjfqqKwlXQw4
	ks1RJq9jMJlR4czTSHYSf+6hUpIRTD9hmqeTAWkZpvgRIFoYSGABufgG8YWQ9730
	SLYe04eOem9dvWuW03IzdG+l5RIHfYGGMnwqM5RuVs/KUmta5vuBU2mBZ4G/tl61
	QAj8LAlHUFEA6TCluPlzQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792759850; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:FkzAr4qEgdliahO80ydG0FqlusfPsRhDF5NQRiOUHEU/RFa
	9lwgRpWM55obmvsvFkr9N/1XEYJeiNSJTqPpxO0DMuvaBnuZ1MPyxi28cARuxT1k
	rvGZYEnXdUqYgB5nshADIO9xrpOv48ZR+aHJ5EJ401v6B2yEgYkvGmiIe9vDdvGg
	I0za6UKczj09K+VU8WzuNwIXNHaN6NhYXRnArRsQIAr6JK8tcxB3V61k5FBLT+wC
	BpvWwEg7wiSGSM9lZ8kncHxfFfal9OVlcw0lQA76CwGKRNsnbt3aM2JnGMOPaOla
	E00i6wx5jIKeMBGURbJr75UI2HhTkGJl7XX8Lrw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:rXdtjOSEDmTXG98of8mfkBTjefmSOx+u4dqGJH63mjE=:mjlymnNEklf5/IWG/eUtFpwiupa+qS7uvWd1x0WmeAM=;
X-ME-Sender: <xms:KljbagSKwv_LiN_xZXp5q2PQwgjCBDbBl7JyUZg7Mer4Mq2xr500sA>
    <xme:KljbaktwJAgVQ6Q5eGTdh-uN_MUsr8UvpB-Hoc0RoKKXiO9CxRX51FWAZqLm0_7IB
    BrXjOHUQzyOoXfOhE9OgNLpBsw5J9pJRIBLQR4bu8gpSWS5vZLU>
X-ME-Received: <xmr:KljbajedrT9ejmDSA9dqvRPbWBQwQR3UrEh_Ov0_lZ_mG95rw7G6xuLUABPZR0N0HYKGvQ>
X-ME-Proxy-Cause: dmFkZTGqNuAd1/xXSkVpjRGwpg8ruCWl6SmqOphFYTWvsnIwKxkcEYhnMN2aeMunw78weI
    hd3WZPzhRTxd3w/shofImYxiwLdJ0byPH6NZx/1Cn2ueSoP/lmw8nDe013bC/eIEbp9Snb
    6yo16Dcj5aY0LE0tZwWYQ/lJ8H93jdbTIkZy/xVdf4BYvhi1Sh2VWHoopSIJlhN7evHEE9
    HMRPknYvfUUkrGNA+VvBsjBQwm9t/3En9rtyVpnQZUVWETWV7HHQtzJS+YNZ33BrW6ong7
    t4EF79vc+lyYhgbrBnt+bMwq3ZpiLhOl3NHQTApCD7jBa2nV7FteS8HSCEptRNT5AjJ9Fs
    1+KgnIVnBJaNqC7E4LBp6eZDmN+B3TNAG1L6+BdoTwyPkEsD48ypL4iVreMcvlAQSDDUwf
    2ULuj3suTSOr+fh9i2EKZS9HHwMZUOTXWG+UjJZKvtoDNEdhZ9lGqpxjDpqKJdvGmG7xYo
    WZ6KyVqYGMR8EXpf3XXXIiAnjE3jzCEk2HE4JJJskIothl6j5JZRP749FokBCK69niHxpP
    5SWjoQQC9QgjBTIJRmJw/39b+cZXK9tjNnsL69u+TNZunwWq54eDy0bSDkOFCWxuG+dfZc
    BStEoFzQA4XCcDlm5Ysf7n8U78NWgQdXNeMDtnK3O45rMa6307+JB9gVUN+A
X-ME-Proxy: <xmx:KljbapLbVCGgzCbhkvCKkvjYewDWAjDAZ51G89zvQj3AWGuWXVEuxA>
    <xmx:KljbapaeIxZeRQaXHZ18A3Lgyj2msGijlb_iQ9kbleR_QXBTgyGSPA>
    <xmx:Kljbass2mHUwywDoenoikCCZg0JaFC4pa7spEiLw4U1h-DNTPCOt2g>
    <xmx:Kljbauu_LG8HfXc7kdRxm6q9QVVCNDis0tp2SHw27-Yl6uJ90HD3HA>
    <xmx:KljbaoQzX8CmsgiSDe-zz09-m7sf8B2wpA8SciPSjg_q14HWegmSY04y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 23 Oct 2026 08:50:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 57e0420f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 23 Oct 2026 12:50:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 23 Oct 2026 14:50:22 +0200
Subject: [PATCH 5/7] rerere: stop using `the_repository`
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
Message-Id: <20261023-pks-rerere-wo-the-repository-v1-5-b6ac0c2e4b81@pks.im>
References: <20261023-pks-rerere-wo-the-repository-v1-0-b6ac0c2e4b81@pks.im>
In-Reply-To: <20261023-pks-rerere-wo-the-repository-v1-0-b6ac0c2e4b81@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

There's only a couple of trivial function calls left that implicitly
make us depend on `the_repository`. Refactor those to instead use their
variants that allow us to make the dependency explicit.

Note that this requires us to make `get_hash_hex_algop()` public.

With these changes, "rerere.c" no longer depends on `the_repository`, so
drop `USE_THE_REPOSITORY_VARIABLE`. Despite that, we still carry some
global state in this file that will tie a specific rerere cache to the
first repository used to populate it. This will be fixed in subsequent
commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 hex.c    |  4 ++--
 hex.h    |  3 +++
 rerere.c | 14 +++++++-------
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/hex.c b/hex.c
index f02832140d..4b7793bb8a 100644
--- a/hex.c
+++ b/hex.c
@@ -5,8 +5,8 @@
 #include "hex.h"
 #include "strbuf.h"
 
-static int get_hash_hex_algop(const char *hex, unsigned char *hash,
-			      const struct git_hash_algo *algop)
+int get_hash_hex_algop(const char *hex, unsigned char *hash,
+		       const struct git_hash_algo *algop)
 {
 	for (size_t i = 0; i < algop->rawsz; i++) {
 		int val = hex2chr(hex);
diff --git a/hex.h b/hex.h
index f15c7e2220..50a0088065 100644
--- a/hex.h
+++ b/hex.h
@@ -59,6 +59,9 @@ int parse_oid_hex_algop_impl(const char *hex, struct object_id *oid, const char
 int get_oid_hex_any(const char *hex, struct object_id *oid);
 int parse_oid_hex_any(const char *hex, struct object_id *oid, const char **end);
 
+int get_hash_hex_algop(const char *hex, unsigned char *hash,
+		       const struct git_hash_algo *algop);
+
 #ifdef USE_THE_REPOSITORY_VARIABLE
 
 /* Like get_oid_hex_algop, but for `the_hash_algo`. */
diff --git a/rerere.c b/rerere.c
index 8fa921fc8f..366797ab7e 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -188,7 +187,7 @@ static struct rerere_id *new_rerere_id_hex(struct repository *r, char *hex)
 
 static struct rerere_id *new_rerere_id(struct repository *r, unsigned char *hash)
 {
-	return new_rerere_id_hex(r, hash_to_hex(hash));
+	return new_rerere_id_hex(r, hash_to_hex_algop(hash, r->hash_algo));
 }
 
 /*
@@ -213,7 +212,8 @@ static void read_rr(struct repository *r, struct string_list *rr)
 		const unsigned hexsz = r->hash_algo->hexsz;
 
 		/* There has to be the hash, tab, path and then NUL */
-		if (buf.len < hexsz + 2 || get_hash_hex(buf.buf, hash))
+		if (buf.len < hexsz + 2 ||
+		    get_hash_hex_algop(buf.buf, hash, r->hash_algo))
 			die(_("corrupt MERGE_RR"));
 
 		if (buf.buf[hexsz] != '.') {
@@ -1264,11 +1264,11 @@ static void prune_one(struct repository *r, struct rerere_id *id,
 }
 
 /* Does the basename in "path" look plausibly like an rr-cache entry? */
-static int is_rr_cache_dirname(const char *path)
+static int is_rr_cache_dirname(struct repository *r, const char *path)
 {
 	struct object_id oid;
 	const char *end;
-	return !parse_oid_hex(path, &oid, &end) && !*end;
+	return !parse_oid_hex_algop(path, &oid, &end, r->hash_algo) && !*end;
 }
 
 bool rerere_gc_needed(struct repository *r, size_t limit)
@@ -1295,7 +1295,7 @@ bool rerere_gc_needed(struct repository *r, size_t limit)
 		 * use for estimating the number of loose objects.
 		 */
 		if (!starts_with(e->d_name, "17") ||
-		    !is_rr_cache_dirname(e->d_name))
+		    !is_rr_cache_dirname(r, e->d_name))
 			continue;
 
 		id.collection = find_rerere_dir(r, e->d_name);
@@ -1345,7 +1345,7 @@ void rerere_gc(struct repository *r, struct string_list *rr, int flags)
 		struct rerere_id id;
 		int now_empty;
 
-		if (!is_rr_cache_dirname(e->d_name))
+		if (!is_rr_cache_dirname(r, e->d_name))
 			continue; /* or should we remove e->d_name? */
 
 		rr_dir = find_rerere_dir(r, e->d_name);

-- 
2.56.0.307.g5fe7bd680c.dirty

