Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E2485C51
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 22:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710972318; cv=none; b=gboDoTyfYiJBKY81DhM/CqiwBi0VjypR9m4P2BbMqvsijEEEHCL1hK02F7jUmo+XwStRB8Ol1XMVsvbPP2SKDgsRY1WwS5F6ATXyH/raAADtO6obfh+gRvdegEH8MVEGT9hyHcgCB3+oBZlsCmzaibBpdDvadHxSvODTnh/dP+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710972318; c=relaxed/simple;
	bh=RS2/o5MI15Crbt3u2N2vqi9z3bnbLmffnO6rzHUUNxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huVmR5/3qZIPGbTUoApW1CwTBOZfuJ52emF3CfAORL4jii2QA2xtc7OStlkA4+x+l5iolglnZeRR8ucoLYZk/xZBoqUm8gys/u4CVen7A9O9yYYobHhmkO0aKLEzyZfl7J4fXI4H4ACdu86zpgNR9vANubug4OwvcREPFQOPlZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=gbqaKzL8; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="gbqaKzL8"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-789d76ad270so26304185a.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 15:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710972315; x=1711577115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/R78c3RzCDTF19i2i8QCOcqM8AieB43JkFGW6CZxAcM=;
        b=gbqaKzL8rN+3xsEs1350Bf0p/8YoO4dtQfHgmYZErCvYwlKVUL1jCIsbPzTvOObcbt
         PFeCimB8wZXI72V2DRomMFomeq4QdmZLojzgKNMCQaEAZRWshSi+SkJ9L+Ixe0npIPiY
         COcZFWrWP57bVACJDYfqcLOq23bsw8ubUF8Bon3gBCRs/tufuJTqjWVdUZEzTIxSncMN
         LwNl/jzp8kc3nMb4G+vj9gN+ObW3RoakJbHIcAbuXGX/RR0NKePLQqghN3er/9ZDQtXD
         KIvFSM8v11ivkMRXIWirHQuoC6tZ91uGz1WkMrkO+tuVWn8cP5o04yXPL95RWJkvLOiM
         hAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710972315; x=1711577115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/R78c3RzCDTF19i2i8QCOcqM8AieB43JkFGW6CZxAcM=;
        b=uOo73LqB2JRRJfUJgMjCR7v6OZMUOcMdtddhLV1F9Cb5vQDPzSwvI+UhbfomIZbgp1
         CPvrPQB2x7k27oW6yAB7OFs+jEnEvRRVedglPAKPVygFI5EESvGwrwDNFaIOQbCQA8FJ
         WhdEkH+O9kkMxutexqx2PTA2oz9fs0LxgYgqUUZZh82NHLipYMtVzx0ek6NXM37IhRcg
         cVYoQC0x27IAzCRh2TdUaYK+zcT1SVUXH93ZnqcJY3c/2WlFrpWzoUAhY8Vn1FYkEo1e
         51JlPFqdK1YxNru0SQZRimymZW4DJdvt+OKLWI/wZHkMao6RFKvtUQ2InrEmDF64Qk33
         rQWg==
X-Gm-Message-State: AOJu0YzQP+yGFicAPxw4b2+l/INZGJZNIbdkx+hgSq50jRYauK0EkH9A
	W0K6SeHLIs4gxavNX7FnlJcG6PeW/mCyKpQCgcw0EPykQYEIpzHCAa19fSdQWwjaie6BvIA8GO6
	xBw0=
X-Google-Smtp-Source: AGHT+IHBJA+Eq3du1mvj63h2PZc0Hkpb9wdT2I1dQfsjNsSOKNsvJmTYBOdR+rtA6oJrwBBTLRawoQ==
X-Received: by 2002:a0c:e212:0:b0:690:b098:1407 with SMTP id q18-20020a0ce212000000b00690b0981407mr3597084qvl.3.1710972315286;
        Wed, 20 Mar 2024 15:05:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id js7-20020a0562142aa700b00690aa73c1a8sm8286690qvb.45.2024.03.20.15.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 15:05:15 -0700 (PDT)
Date: Wed, 20 Mar 2024 18:05:13 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 05/24] pack-bitmap: move some initialization to
 `bitmap_writer_init()`
Message-ID: <a65316567391160dddae70fb036f03858772014f.1710972293.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1710972293.git.me@ttaylorr.com>

The pack-bitmap-writer machinery uses a oidmap (backed by khash.h) to
map from commits selected for bitmaps (by OID) to a bitmapped_commit
structure (containing the bitmap itself, among other things like its XOR
offset, etc.)

This map was initialized at the end of `bitmap_writer_build()`. New
entries are added in `pack-bitmap-write.c::store_selected()`, which is
called by the bitmap_builder machinery (which is responsible for
traversing history and generating the actual bitmaps).

Reorganize when this field is initialized and when entries are added to
it so that we can quickly determine whether a commit is a candidate for
pseudo-merge selection, or not (since it was already selected to receive
a bitmap, and thus is ineligible for pseudo-merge inclusion).

The changes are as follows:

  - Introduce a new `bitmap_writer_init()` function which initializes
    the `writer.bitmaps` field (instead of waiting until the end of
    `bitmap_writer_build()`).

  - Add map entries in `push_bitmapped_commit()` (which is called via
    `bitmap_writer_select_commits()`) with OID keys and NULL values to
    track whether or not we *expect* to write a bitmap for some given
    commit.

  - Validate that a NULL entry is found matching the given key when we
    store a selected bitmap.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c |  1 +
 midx.c                 |  1 +
 pack-bitmap-write.c    | 23 ++++++++++++++++++-----
 pack-bitmap.h          |  1 +
 4 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 41281cae91f..34a431e3856 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1339,6 +1339,7 @@ static void write_pack_file(void)
 				    hash_to_hex(hash));
 
 			if (write_bitmap_index) {
+				bitmap_writer_init(the_repository);
 				bitmap_writer_set_checksum(hash);
 				bitmap_writer_build_type_index(
 					&to_pack, written_list, nr_written);
diff --git a/midx.c b/midx.c
index 366bfbe18c8..24d98120852 100644
--- a/midx.c
+++ b/midx.c
@@ -1311,6 +1311,7 @@ static int write_midx_bitmap(const char *midx_name,
 	for (i = 0; i < pdata->nr_objects; i++)
 		index[i] = &pdata->objects[i].idx;
 
+	bitmap_writer_init(the_repository);
 	bitmap_writer_show_progress(flags & MIDX_PROGRESS);
 	bitmap_writer_build_type_index(pdata, index, pdata->nr_objects);
 
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 3dc2408eca7..ad768959633 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -46,6 +46,11 @@ struct bitmap_writer {
 
 static struct bitmap_writer writer;
 
+void bitmap_writer_init(struct repository *r)
+{
+	writer.bitmaps = kh_init_oid_map();
+}
+
 void bitmap_writer_show_progress(int show)
 {
 	writer.show_progress = show;
@@ -117,11 +122,20 @@ void bitmap_writer_build_type_index(struct packing_data *to_pack,
 
 static inline void push_bitmapped_commit(struct commit *commit)
 {
+	int hash_ret;
+	khiter_t hash_pos;
+
 	if (writer.selected_nr >= writer.selected_alloc) {
 		writer.selected_alloc = (writer.selected_alloc + 32) * 2;
 		REALLOC_ARRAY(writer.selected, writer.selected_alloc);
 	}
 
+	hash_pos = kh_put_oid_map(writer.bitmaps, commit->object.oid, &hash_ret);
+	if (!hash_ret)
+		die(_("duplicate entry when writing bitmap index: %s"),
+		    oid_to_hex(&commit->object.oid));
+	kh_value(writer.bitmaps, hash_pos) = NULL;
+
 	writer.selected[writer.selected_nr].commit = commit;
 	writer.selected[writer.selected_nr].bitmap = NULL;
 	writer.selected[writer.selected_nr].flags = 0;
@@ -466,14 +480,14 @@ static void store_selected(struct bb_commit *ent, struct commit *commit)
 {
 	struct bitmapped_commit *stored = &writer.selected[ent->idx];
 	khiter_t hash_pos;
-	int hash_ret;
 
 	stored->bitmap = bitmap_to_ewah(ent->bitmap);
 
-	hash_pos = kh_put_oid_map(writer.bitmaps, commit->object.oid, &hash_ret);
-	if (hash_ret == 0)
-		die("Duplicate entry when writing index: %s",
+	hash_pos = kh_get_oid_map(writer.bitmaps, commit->object.oid);
+	if (hash_pos == kh_end(writer.bitmaps))
+		die(_("attempted to store non-selected commit: '%s'"),
 		    oid_to_hex(&commit->object.oid));
+
 	kh_value(writer.bitmaps, hash_pos) = stored;
 }
 
@@ -488,7 +502,6 @@ int bitmap_writer_build(struct packing_data *to_pack)
 	uint32_t *mapping;
 	int closed = 1; /* until proven otherwise */
 
-	writer.bitmaps = kh_init_oid_map();
 	writer.to_pack = to_pack;
 
 	if (writer.show_progress)
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 3f96608d5c1..dae2d68a338 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -97,6 +97,7 @@ int bitmap_has_oid_in_uninteresting(struct bitmap_index *, const struct object_i
 
 off_t get_disk_usage_from_bitmap(struct bitmap_index *, struct rev_info *);
 
+void bitmap_writer_init(struct repository *r);
 void bitmap_writer_show_progress(int show);
 void bitmap_writer_set_checksum(const unsigned char *sha1);
 void bitmap_writer_build_type_index(struct packing_data *to_pack,
-- 
2.44.0.303.g1dc5e5b124c

