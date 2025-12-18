Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CBA321442
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 06:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766039329; cv=none; b=TGGF5sGTSWtxADN82R56GQAiUoSH+apv7w6DGYehoSnUzTkwK0h1bKLRpOw51s9CPE76LTFSPDprgdIH5w4/030hWMG9x4DTWAawXe2BKtJGhUQKlZIAgkzHcxExPYwc5o75rjJo4YOHci7mNKawDZIf+euJ6mk52tXhnBbgFDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766039329; c=relaxed/simple;
	bh=atd57RA+kzC3n3YuolzLPTuJ2WnLl+/GLP8dFBzgrZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f/z6eB1PXP1kGSp2eKkJZ88razZ6pz2uy9f4cILsR7cqf1N++DxuDxbARkmLzzwew1xtKKnefZAp0Us7soLPZKdwWHj1XZd0dP5aPxZFXZx2xAs8+Am+vxDsyGIBGGfJEK8WaTenCuITWQy+yt/qRospLnrDPROPAMcIw6TT1k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tjNZagut; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x0CqFWic; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tjNZagut";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x0CqFWic"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 648067A01AC;
	Thu, 18 Dec 2025 01:28:47 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 18 Dec 2025 01:28:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766039327;
	 x=1766125727; bh=qQQ0m9OuQe+P2Q2dLgur2StmgXEr2v8d24lI/aFUQRk=; b=
	tjNZagut2JNghw+QgNli3GHNb0Zw5b04Ms/AiKk8fwp4pbBi8ivdDcGgfMh5Sot3
	41Or5zdrjYGkLLLu98TzCT7NicSTgT1284h3uvsKJpXt6/Wf+N7cPUVTPGZQsVJO
	u7KXe11FbS63U8HXCf/0VQssyC9Htx+9MACH+Pg7CmF4yRUfW5O80YL4eMLw8Hvt
	Kqtp6DJ1L2UqHoyikd2qWKSMK9FfA6xUyfEQ6quXe10zmP85GJ3kXsjmfeLf1AQx
	l7zb5QmWQW9Ak7+I+2A5kQITpAsKclHffCVA5QkUNiNPShVYIm//wzlTZQyCP48i
	ynM7+LG4AiZSGGkV+5RQuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766039327; x=
	1766125727; bh=qQQ0m9OuQe+P2Q2dLgur2StmgXEr2v8d24lI/aFUQRk=; b=x
	0CqFWiczsTIJo2rADnSFcFGJvMjadkKFDMQZC4bFKcgwR2hyz4fHcPxg2ZEbJvcz
	lcB9FhZAPav4/GwRY4ytQNxmfIE6Lr5LDZ6X3DlEZQT2B6mjz3FHsJaE+/w+OgLu
	qv9u8qcA3QZPJj4rufcuhEisuUmPNXAXuK5pJAqHuDDUekkLLFQcdT0nttvnF3Hi
	mQoROO2oglge0xSc2GEhtGq1Hptr/hyu7usK6+Rn2QJXc67p8E8RjZGRi7DtRnUI
	N+Tbxx7Vo+7UOqBa3HWySPtIFQ+ZSyImPetqSckEYqTYVg6Hdul0jfsu0FDygPmV
	HQGMIHzf/iPOkNXWvYjVA==
X-ME-Sender: <xms:H59DabBjIu3YgDVXVPOjQMXB6pAetKA97gXSwzFVYRb5TqN8PoW7Fg>
    <xme:H59DaY-JRhVUJUKxa4Rvz2MnpHT0QmZNo3X5nv8aW93phCvBO58AeZzfgH5X6Khtg
    9sqrlFuQf5c6WeeEF-wDFjOCJocsX9XmyBbbhKHFgTermpJLWNx>
X-ME-Received: <xmr:H59DaT8U8XSZxWi_XnGNSd56e4cLla2al57l00hOJeEA3VU-wkoVQ9XjUxnKwgKEZZl28zvER9RyecZpsPpU_XVWuxp-q5-qZE9-G5AxFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtoheprghplhgrthhtnhgvrhesnhhvihguihgr
    rdgtohhm
X-ME-Proxy: <xmx:H59DaXe8tJegk_2fwtUifJ6u2NSc7BkmT7QfiJxSEbpRpFxELnxa6A>
    <xmx:H59DaUGkXFMRUL3c5QJOTXYJlFQamPDwKm6x8N3mctsZDI3QY3zoAg>
    <xmx:H59DadfWgY58AG2X7zF7yYi0P2Ihr_BxQUHEm0f-7GhSIImVobksfQ>
    <xmx:H59DaWGtVEJ9FwZN0bDrHCb97XvI06Qt6T_M9XUqqSCkkyiC3y4ctQ>
    <xmx:H59DadHKDOFoC6gkuQeHcoGG7ZXBDsean9J8weVhBAjlpgzvdSekieQb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 01:28:46 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2f72ccd2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 06:28:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Dec 2025 07:28:18 +0100
Subject: [PATCH 8/8] packfile: drop repository parameter from
 `packed_object_info()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-b4-pks-odb-read-object-info-improvements-v1-8-81c8368492be@pks.im>
References: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
In-Reply-To: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>
X-Mailer: b4 0.14.3

The function `packed_object_info()` takes a packfile and offset and
returns the object info for the corresponding object. Despite these two
parameters though it also takes a repository pointer. This is redundant
information though, as `struct packed_git` already has a repository
pointer that is always populated.

Drop the redundant parameter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c     | 3 +--
 builtin/pack-objects.c | 4 ++--
 commit-graph.c         | 2 +-
 pack-bitmap.c          | 3 +--
 packfile.c             | 8 ++++----
 packfile.h             | 3 +--
 6 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 505ddaa12f..2ad712e9f8 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -487,8 +487,7 @@ static void batch_object_write(const char *obj_name,
 			data->info.sizep = &data->size;
 
 		if (pack)
-			ret = packed_object_info(the_repository, pack,
-						 offset, &data->info);
+			ret = packed_object_info(pack, offset, &data->info);
 		else
 			ret = odb_read_object_info_extended(the_repository->objects,
 							    &data->oid, &data->info,
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1ce8d6ee21..85762f8c4f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2411,7 +2411,7 @@ static void drop_reused_delta(struct object_entry *entry)
 
 	oi.sizep = &size;
 	oi.typep = &type;
-	if (packed_object_info(the_repository, IN_PACK(entry), entry->in_pack_offset, &oi) < 0) {
+	if (packed_object_info(IN_PACK(entry), entry->in_pack_offset, &oi) < 0) {
 		/*
 		 * We failed to get the info from this pack for some reason;
 		 * fall back to odb_read_object_info, which may find another copy.
@@ -3748,7 +3748,7 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 		struct object_info oi = OBJECT_INFO_INIT;
 
 		oi.typep = &type;
-		if (packed_object_info(the_repository, p, ofs, &oi) < 0) {
+		if (packed_object_info(p, ofs, &oi) < 0) {
 			die(_("could not get type of object %s in pack %s"),
 			    oid_to_hex(oid), p->pack_name);
 		} else if (type == OBJ_COMMIT) {
diff --git a/commit-graph.c b/commit-graph.c
index 80be2ff2c3..f572670bd0 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1499,7 +1499,7 @@ static int add_packed_commits(const struct object_id *oid,
 		display_progress(ctx->progress, ++ctx->progress_done);
 
 	oi.typep = &type;
-	if (packed_object_info(ctx->r, pack, offset, &oi) < 0)
+	if (packed_object_info(pack, offset, &oi) < 0)
 		die(_("unable to get type of object %s"), oid_to_hex(oid));
 
 	if (type != OBJ_COMMIT)
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 8ca79725b1..972203f12b 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1876,8 +1876,7 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 			ofs = pack_pos_to_offset(pack, pos);
 		}
 
-		if (packed_object_info(bitmap_repo(bitmap_git), pack, ofs,
-				       &oi) < 0) {
+		if (packed_object_info(pack, ofs, &oi) < 0) {
 			struct object_id oid;
 			nth_bitmap_object_oid(bitmap_git, &oid,
 					      pack_pos_to_index(pack, pos));
diff --git a/packfile.c b/packfile.c
index ce83e77899..8daa5a5ee7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1580,7 +1580,7 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	hashmap_add(&delta_base_cache, &ent->ent);
 }
 
-int packed_object_info(struct repository *r, struct packed_git *p,
+int packed_object_info(struct packed_git *p,
 		       off_t obj_offset, struct object_info *oi)
 {
 	struct pack_window *w_curs = NULL;
@@ -1594,7 +1594,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 	 * a "real" type later if the caller is interested.
 	 */
 	if (oi->contentp) {
-		*oi->contentp = cache_or_unpack_entry(r, p, obj_offset, oi->sizep,
+		*oi->contentp = cache_or_unpack_entry(p->repo, p, obj_offset, oi->sizep,
 						      &type);
 		if (!*oi->contentp)
 			type = OBJ_BAD;
@@ -1635,7 +1635,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 
 	if (oi->typep) {
 		enum object_type ptot;
-		ptot = packed_to_object_type(r, p, obj_offset,
+		ptot = packed_to_object_type(p->repo, p, obj_offset,
 					     type, &w_curs, curpos);
 		if (oi->typep)
 			*oi->typep = ptot;
@@ -2175,7 +2175,7 @@ int packfile_store_read_object_info(struct packfile_store *store,
 		return 0;
 	}
 
-	ret = packed_object_info(store->odb->repo, e.p, e.offset, oi);
+	ret = packed_object_info(e.p, e.offset, oi);
 	if (ret < 0) {
 		mark_bad_packed_object(e.p, oid);
 		return -1;
diff --git a/packfile.h b/packfile.h
index 07f5bfbc4f..573d06f6ba 100644
--- a/packfile.h
+++ b/packfile.h
@@ -382,8 +382,7 @@ extern int do_check_packed_object_crc;
  * Look up the object info for a specific offset in the packfile.
  * success, a negative error code otherwise.
  */
-int packed_object_info(struct repository *r,
-		       struct packed_git *pack,
+int packed_object_info(struct packed_git *pack,
 		       off_t offset, struct object_info *);
 
 void mark_bad_packed_object(struct packed_git *, const struct object_id *);

-- 
2.52.0.351.gbe84eed79e.dirty

