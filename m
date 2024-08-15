Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4781AC8AD
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743067; cv=none; b=hyuRK+D6ljA78N3ctZCG0B67eCKFKgBb3FTNSOYqM0TSfvb8El1t1Q5gxM0tlGX8jU8luOXy5QGC0QW7gWVLt7aiK7ozjoffXNjuPht3uN5HaMr7Xwf9bW9M4hBMyMnsheAUtDOOwnrxEgZ7uKL1jq3UaBqcGUFj/p2vRnxXumM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743067; c=relaxed/simple;
	bh=KjlkXMFD9nI1sOSUb3r4eFYBqy0wTtqiS9MFGW1eLx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLVjyqbLUtykVZ51KdNHGCkfuPVZreYHzsX1CuesKegiBEtNIQVDgNm3PsgIQY067yMszEzED38xNF3bKHGo9Tk13EoYQpC7bThgaCJ9ZJvlS0YR/ZEw+WdlhJJm/WCvABZ0Co9yWSCX4P2j2BraDAIJsZBHvOimAJ9ZskLg8fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=GcU0ioyc; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="GcU0ioyc"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-709485aca4bso640227a34.1
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 10:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723743064; x=1724347864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dMYhr7dkRHEnVeFf1mQXi5LPv1CrbIACKnXd9MxXuaE=;
        b=GcU0ioycXK6eTXgqigjh0kLYBzrDOXAT4Ao87C/1pwwjRXb3tW9j6DHw0i6yDoridw
         yQSAn2yrT9Xv9d++B38Cag7MSHStkaj8aibQNv6p/z5uYugDN+SPUIO2UDeJKkq6kyJj
         KG3YLPoA1e3Ri+HW/cCIp9jwrk2TZFbij6DXoQ9Hmfik6773z4vZ0yqlhToJVgabbaJ7
         Z8+iSS4L47RQR4bbvbMATogA1G1ikDSOHJfIcXDt8Qb8RWfRKZzdySXcWWhiIaNdU9gM
         WsC+lvv2++HSHkPJvIFwJ/zwah/IVY5viWRmPPJOhq/AhRhoJIpY0thryoRd0yM0hQTq
         gJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723743064; x=1724347864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMYhr7dkRHEnVeFf1mQXi5LPv1CrbIACKnXd9MxXuaE=;
        b=j3Ib/T18oMMcs7aLcXk/+cYWpTPqAQJ0N4DqpBJBi8iBLuBXq76V0H3ZOVuLNMzRnj
         etmdf+CbqGzkiUHhKpDH3ft6Htc9ofcsicidm+9xrjW5WyKxS0fAcFBYVRBtpPV5swin
         Dvp192eNt09wKo9RhYzWPnEABCjOtCL/DsDCvLiJcPVTds6RM3fBIl70wDNJo+SetRbp
         il+7Y9bgN4Iu/Q6cpfKxOjFdGRPy5I/ac9/pbOaSCE/Sdp3Y+iubarC/6NN6bno+5lya
         yHdoF39W4y7siL/HtfW+Ark6ilkDMbCqbPTyAv25EQXMApWI7HLNi1Vfe1lZroDhsQPc
         Lk0Q==
X-Gm-Message-State: AOJu0YyVSS8bwvv8TrcPJnZs/I3QxBm8LJppvx4DVh3AuLYkaQsjg3pZ
	jrctok8mdJNBdzwker7fj4eBloy+s344KBDSEZYeBZ8/iHBV856+rvepZu7i8ZpTzooKACYbdPM
	d
X-Google-Smtp-Source: AGHT+IGBysAkMSlGutwIJyZPY6CjYO8A+UYWW9/jewErcrplxq8gOHM8xNNxDgEYNq+Se7wZICobew==
X-Received: by 2002:a05:6830:7006:b0:704:b58d:377a with SMTP id 46e09a7af769-70cac86f50dmr302099a34.19.1723743064450;
        Thu, 15 Aug 2024 10:31:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9aa5ca32sm3171877b3.69.2024.08.15.10.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 10:31:04 -0700 (PDT)
Date: Thu, 15 Aug 2024 13:31:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/8] pack-bitmap: drop redundant args from
 `bitmap_writer_build_type_index()`
Message-ID: <238ca46998e936fb5d57467aeec5d9a0b187341e.1723743050.git.me@ttaylorr.com>
References: <cover.1723743050.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723743050.git.me@ttaylorr.com>

The previous commit ensures that the bitmap_writer's "to_pack" field is
initialized early on, so the "to_pack" and "index_nr" arguments to
`bitmap_writer_build_type_index()` are redundant.

Drop them and adjust the callers accordingly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c |  2 +-
 midx-write.c           |  3 +--
 pack-bitmap-write.c    | 12 +++++-------
 pack-bitmap.h          |  4 +---
 4 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0ad533c045..c08a62718d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1345,7 +1345,7 @@ static void write_pack_file(void)
 						   the_repository, &to_pack);
 				bitmap_writer_set_checksum(&bitmap_writer, hash);
 				bitmap_writer_build_type_index(&bitmap_writer,
-					&to_pack, written_list, nr_written);
+							       written_list);
 			}
 
 			if (cruft)
diff --git a/midx-write.c b/midx-write.c
index 62f507eb72..b3015af07f 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -827,8 +827,7 @@ static int write_midx_bitmap(const char *midx_name,
 
 	bitmap_writer_init(&writer, the_repository, pdata);
 	bitmap_writer_show_progress(&writer, flags & MIDX_PROGRESS);
-	bitmap_writer_build_type_index(&writer, pdata, index,
-				       pdata->nr_objects);
+	bitmap_writer_build_type_index(&writer, index);
 
 	/*
 	 * bitmap_writer_finish expects objects in lex order, but pack_order
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 4a7d2d1370..34cdf5f150 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -101,9 +101,7 @@ void bitmap_writer_show_progress(struct bitmap_writer *writer, int show)
  * Build the initial type index for the packfile or multi-pack-index
  */
 void bitmap_writer_build_type_index(struct bitmap_writer *writer,
-				    struct packing_data *to_pack,
-				    struct pack_idx_entry **index,
-				    uint32_t index_nr)
+				    struct pack_idx_entry **index)
 {
 	uint32_t i;
 
@@ -111,13 +109,13 @@ void bitmap_writer_build_type_index(struct bitmap_writer *writer,
 	writer->trees = ewah_new();
 	writer->blobs = ewah_new();
 	writer->tags = ewah_new();
-	ALLOC_ARRAY(to_pack->in_pack_pos, to_pack->nr_objects);
+	ALLOC_ARRAY(writer->to_pack->in_pack_pos, writer->to_pack->nr_objects);
 
-	for (i = 0; i < index_nr; ++i) {
+	for (i = 0; i < writer->to_pack->nr_objects; ++i) {
 		struct object_entry *entry = (struct object_entry *)index[i];
 		enum object_type real_type;
 
-		oe_set_in_pack_pos(to_pack, entry, i);
+		oe_set_in_pack_pos(writer->to_pack, entry, i);
 
 		switch (oe_type(entry)) {
 		case OBJ_COMMIT:
@@ -128,7 +126,7 @@ void bitmap_writer_build_type_index(struct bitmap_writer *writer,
 			break;
 
 		default:
-			real_type = oid_object_info(to_pack->repo,
+			real_type = oid_object_info(writer->to_pack->repo,
 						    &entry->idx.oid, NULL);
 			break;
 		}
diff --git a/pack-bitmap.h b/pack-bitmap.h
index ab20d6a0b6..d2529abadc 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -129,9 +129,7 @@ void bitmap_writer_show_progress(struct bitmap_writer *writer, int show);
 void bitmap_writer_set_checksum(struct bitmap_writer *writer,
 				const unsigned char *sha1);
 void bitmap_writer_build_type_index(struct bitmap_writer *writer,
-				    struct packing_data *to_pack,
-				    struct pack_idx_entry **index,
-				    uint32_t index_nr);
+				    struct pack_idx_entry **index);
 int bitmap_writer_has_bitmapped_object_id(struct bitmap_writer *writer,
 					  const struct object_id *oid);
 void bitmap_writer_push_commit(struct bitmap_writer *writer,
-- 
2.46.0.54.gc9a64b1d2a

