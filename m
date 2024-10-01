Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C51819F43D
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 09:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775728; cv=none; b=Wo7LtxScv51QVHsFFZlYyG187RiM4crkuYQYniKUZzHMO/5qFDXxdRxWHL4qLFx+trqak/Z76VrXqJQSlX+m3pqq4Lqw/UJGmZUquCOY8Mu2AQG3ZMvzeUuW7mqhhNVRsORd4PUFdUde4A6cTAoeH71v7NGY+zJURuDT3wklAoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775728; c=relaxed/simple;
	bh=qxU0Xmm3CMMGs5WTlWr/DpDEk6fwVujl5k+Xkzvwp3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWj/fGrfJ0gvQaMgd/4nRpiW8B1lLRUDTuh6M5qv6v91Q1M56dkhunRcn+V5Yht7/cqy5oMGNhh89sVJgfTcwB+R8yZoCOxz/qjAxqxpwMs2hote0br1wbWppxgPTSoXPQP4sFzbVGlW86c3cybFZeIu3fILwkBoxaNmORUAzsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=haoj4GrN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IXR26nMD; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="haoj4GrN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IXR26nMD"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 896B21140BC8;
	Tue,  1 Oct 2024 05:42:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 01 Oct 2024 05:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727775725; x=1727862125; bh=ntLRfyLoj/
	jtFPMVcZ5YzVO9pb1iRg2Bwsm5QmFS4gw=; b=haoj4GrN1CH56wb7SyNN9Kh3h2
	Kr928vjWJF4q7xGlYTjRpkUMm0Rg7GY1LSICIDfCZPNbz3nnwsdihezlNyybkw+M
	4cC5kvl+GF69RdFKgxoX5GzYPfrW66gESpaj5yPMw8b9ehFTD32EzRqzOgSlgaJP
	st94sS8KvgSMcdM1hjzkbgwHMixUgmDZ0SHnINCkDmNZYHdOFs3SB4GjVHNppeui
	ns4i2h9rENEpxTZLDRWRIbSLZxxY21ExTixIcUfG9wg5/eSk8Dtxw454CcqsAIMu
	KuFNQTSj2my2XOfNXVoEZ0hWKXn1GdMJ+PHtV3inCTqxNBlWJ5+NYzUgtSUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727775725; x=1727862125; bh=ntLRfyLoj/jtFPMVcZ5YzVO9pb1i
	Rg2Bwsm5QmFS4gw=; b=IXR26nMDVuPX3h0rO+Z/61X2LsdAwSIlXhTigWNzWKS/
	HW0zfBuPhkziFFAfEmZBbBFqeukrFVoQMUVxzhdyu63s5CDeXfL/oNZuAOLMvK0E
	KViqgR/i3gayy/PO8GWBjQtHMEIbDi/b6MuPPMBSuWThxQX3lt2c2FRCzzPuVIOJ
	850QvxdzMVzbv9yctIBiEeEnKxiNwtDLBiqs5m+1hI4XR4IWm8J8kdCRKeDWeGd1
	XwD0eeY91DDz11N2gOm1GkPlPVk2md2Np7CJbvtcKISGIqzo/bSQKEUmyMrpphBF
	82von+b4GH4NbIrJgml6ot/Ta8tlIrcfHrYgQqgwKw==
X-ME-Sender: <xms:7cP7ZrOmxf7W017BXqf0-YDzFlz0SYDXmc6wt9TuYlMg9_WpCXDGAQ>
    <xme:7cP7Zl_o5jyJX2NOGM8eyMrXH0ynG12mYTgumQD7lmFMNfq-W-ablfDReHFKDoY2c
    YulZl9BdWgW5qbKYA>
X-ME-Received: <xmr:7cP7ZqSiCvST_k9UDK629LfEeuxcv-jkWus2p4k_uMHeSi4wHoqiVSUfLa98RoWebO5g2nw6-cTBcgKv1BnoZgT06bGmtk-k25ZytcFsxx9qHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepvdehvdegledtvdekkedtieekjeduteekuddvhffgleff
    gfdtieekgefgffeihfdtnecuffhomhgrihhnpehvrghlvddrthgrrhhgvghtpdhuphgurg
    htvgdrvghmrghilhdpuhhpuggrthgvrdhnrghmvgdpuhhpuggrthgvrdhnvgifnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvthhhohhmshhonh
    esvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggs
    rdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7cP7ZvsDuuL4x1yW9GOBfR1vUz0QAAlq7gzjhfMC-fs2Nq8EpVG-Dw>
    <xmx:7cP7Zjf4bjqu_6UMnuxU_myVuF9VyjkcPdRvQL0Fh8_rYY-m9dXpCg>
    <xmx:7cP7Zr2125kWrNzGalcbJtViJWieR6DKixK5m9sOaApi9DWD-1mVYg>
    <xmx:7cP7Zv_ArcouHUc3wQhJY1vkRGw5VPIYOIcLtPuXSiePWR4SdtHMBA>
    <xmx:7cP7Zq7QEKboHi9Yk1OFatJtXMIK0_e8JcotnZktQikSo8JCV1C2i4B7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 05:42:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 769dc9d2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 09:41:16 +0000 (UTC)
Date: Tue, 1 Oct 2024 11:42:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4 06/25] reftable/record: handle allocation failures on copy
Message-ID: <756a32c28558bfaa360304712110443d643fc303.1727774935.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727774935.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727774935.git.ps@pks.im>

Handle allocation failures when copying records. While at it, convert
from `xstrdup()` to `reftable_strdup()`. Adapt callsites to check for
error codes.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c | 84 +++++++++++++++++++++++++++++++++--------------
 reftable/record.h |  6 ++--
 2 files changed, 63 insertions(+), 27 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index 6b5a075b92..60fd33c9c9 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -215,13 +215,14 @@ static void reftable_ref_record_key(const void *r, struct strbuf *dest)
 	strbuf_addstr(dest, rec->refname);
 }
 
-static void reftable_ref_record_copy_from(void *rec, const void *src_rec,
-					  int hash_size)
+static int reftable_ref_record_copy_from(void *rec, const void *src_rec,
+					 int hash_size)
 {
 	struct reftable_ref_record *ref = rec;
 	const struct reftable_ref_record *src = src_rec;
 	char *refname = NULL;
 	size_t refname_cap = 0;
+	int err;
 
 	assert(hash_size > 0);
 
@@ -236,6 +237,11 @@ static void reftable_ref_record_copy_from(void *rec, const void *src_rec,
 
 		REFTABLE_ALLOC_GROW(ref->refname, refname_len + 1,
 				    ref->refname_cap);
+		if (!ref->refname) {
+			err = REFTABLE_OUT_OF_MEMORY_ERROR;
+			goto out;
+		}
+
 		memcpy(ref->refname, src->refname, refname_len);
 		ref->refname[refname_len] = 0;
 	}
@@ -254,9 +260,17 @@ static void reftable_ref_record_copy_from(void *rec, const void *src_rec,
 		       src->value.val2.target_value, hash_size);
 		break;
 	case REFTABLE_REF_SYMREF:
-		ref->value.symref = xstrdup(src->value.symref);
+		ref->value.symref = reftable_strdup(src->value.symref);
+		if (!ref->value.symref) {
+			err = REFTABLE_OUT_OF_MEMORY_ERROR;
+			goto out;
+		}
 		break;
 	}
+
+	err = 0;
+out:
+	return err;
 }
 
 static void reftable_ref_record_release_void(void *rec)
@@ -457,23 +471,28 @@ static void reftable_obj_record_release(void *rec)
 	memset(obj, 0, sizeof(struct reftable_obj_record));
 }
 
-static void reftable_obj_record_copy_from(void *rec, const void *src_rec,
-					  int hash_size UNUSED)
+static int reftable_obj_record_copy_from(void *rec, const void *src_rec,
+					 int hash_size UNUSED)
 {
 	struct reftable_obj_record *obj = rec;
-	const struct reftable_obj_record *src =
-		(const struct reftable_obj_record *)src_rec;
+	const struct reftable_obj_record *src = src_rec;
 
 	reftable_obj_record_release(obj);
 
 	REFTABLE_ALLOC_ARRAY(obj->hash_prefix, src->hash_prefix_len);
+	if (!obj->hash_prefix)
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
 	obj->hash_prefix_len = src->hash_prefix_len;
 	if (src->hash_prefix_len)
 		memcpy(obj->hash_prefix, src->hash_prefix, obj->hash_prefix_len);
 
 	REFTABLE_ALLOC_ARRAY(obj->offsets, src->offset_len);
+	if (!obj->offsets)
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
 	obj->offset_len = src->offset_len;
 	COPY_ARRAY(obj->offsets, src->offsets, src->offset_len);
+
+	return 0;
 }
 
 static uint8_t reftable_obj_record_val_type(const void *rec)
@@ -646,33 +665,44 @@ static void reftable_log_record_key(const void *r, struct strbuf *dest)
 	strbuf_add(dest, i64, sizeof(i64));
 }
 
-static void reftable_log_record_copy_from(void *rec, const void *src_rec,
-					  int hash_size)
+static int reftable_log_record_copy_from(void *rec, const void *src_rec,
+					 int hash_size)
 {
 	struct reftable_log_record *dst = rec;
 	const struct reftable_log_record *src =
 		(const struct reftable_log_record *)src_rec;
+	int ret;
 
 	reftable_log_record_release(dst);
 	*dst = *src;
+
 	if (dst->refname) {
-		dst->refname = xstrdup(dst->refname);
+		dst->refname = reftable_strdup(dst->refname);
+		if (!dst->refname) {
+			ret = REFTABLE_OUT_OF_MEMORY_ERROR;
+			goto out;
+		}
 	}
+
 	switch (dst->value_type) {
 	case REFTABLE_LOG_DELETION:
 		break;
 	case REFTABLE_LOG_UPDATE:
-		if (dst->value.update.email) {
+		if (dst->value.update.email)
 			dst->value.update.email =
-				xstrdup(dst->value.update.email);
-		}
-		if (dst->value.update.name) {
+				reftable_strdup(dst->value.update.email);
+		if (dst->value.update.name)
 			dst->value.update.name =
-				xstrdup(dst->value.update.name);
-		}
-		if (dst->value.update.message) {
+				reftable_strdup(dst->value.update.name);
+		if (dst->value.update.message)
 			dst->value.update.message =
-				xstrdup(dst->value.update.message);
+				reftable_strdup(dst->value.update.message);
+
+		if (!dst->value.update.email ||
+		    !dst->value.update.name ||
+		    !dst->value.update.message) {
+			ret = REFTABLE_OUT_OF_MEMORY_ERROR;
+			goto out;
 		}
 
 		memcpy(dst->value.update.new_hash,
@@ -681,6 +711,10 @@ static void reftable_log_record_copy_from(void *rec, const void *src_rec,
 		       src->value.update.old_hash, hash_size);
 		break;
 	}
+
+	ret = 0;
+out:
+	return ret;
 }
 
 static void reftable_log_record_release_void(void *rec)
@@ -954,8 +988,8 @@ static void reftable_index_record_key(const void *r, struct strbuf *dest)
 	strbuf_addbuf(dest, &rec->last_key);
 }
 
-static void reftable_index_record_copy_from(void *rec, const void *src_rec,
-					    int hash_size UNUSED)
+static int reftable_index_record_copy_from(void *rec, const void *src_rec,
+					   int hash_size UNUSED)
 {
 	struct reftable_index_record *dst = rec;
 	const struct reftable_index_record *src = src_rec;
@@ -963,6 +997,8 @@ static void reftable_index_record_copy_from(void *rec, const void *src_rec,
 	strbuf_reset(&dst->last_key);
 	strbuf_addbuf(&dst->last_key, &src->last_key);
 	dst->offset = src->offset;
+
+	return 0;
 }
 
 static void reftable_index_record_release(void *rec)
@@ -1054,14 +1090,14 @@ int reftable_record_encode(struct reftable_record *rec, struct string_view dest,
 						   dest, hash_size);
 }
 
-void reftable_record_copy_from(struct reftable_record *rec,
+int reftable_record_copy_from(struct reftable_record *rec,
 			       struct reftable_record *src, int hash_size)
 {
 	assert(src->type == rec->type);
 
-	reftable_record_vtable(rec)->copy_from(reftable_record_data(rec),
-					       reftable_record_data(src),
-					       hash_size);
+	return reftable_record_vtable(rec)->copy_from(reftable_record_data(rec),
+						      reftable_record_data(src),
+						      hash_size);
 }
 
 uint8_t reftable_record_val_type(struct reftable_record *rec)
diff --git a/reftable/record.h b/reftable/record.h
index 5003bacdb0..0f53ba5443 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -44,7 +44,7 @@ struct reftable_record_vtable {
 	/* The record type of ('r' for ref). */
 	uint8_t type;
 
-	void (*copy_from)(void *dest, const void *src, int hash_size);
+	int (*copy_from)(void *dest, const void *src, int hash_size);
 
 	/* a value of [0..7], indicating record subvariants (eg. ref vs. symref
 	 * vs ref deletion) */
@@ -137,8 +137,8 @@ void reftable_record_init(struct reftable_record *rec, uint8_t typ);
 int reftable_record_cmp(struct reftable_record *a, struct reftable_record *b);
 int reftable_record_equal(struct reftable_record *a, struct reftable_record *b, int hash_size);
 void reftable_record_key(struct reftable_record *rec, struct strbuf *dest);
-void reftable_record_copy_from(struct reftable_record *rec,
-			       struct reftable_record *src, int hash_size);
+int reftable_record_copy_from(struct reftable_record *rec,
+			      struct reftable_record *src, int hash_size);
 uint8_t reftable_record_val_type(struct reftable_record *rec);
 int reftable_record_encode(struct reftable_record *rec, struct string_view dest,
 			   int hash_size);
-- 
2.47.0.rc0.dirty

