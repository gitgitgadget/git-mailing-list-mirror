Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157B91E2831
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 20:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728505882; cv=none; b=QIGhOfGRr4RPUj/ej+7vj2hRxAyZombjw91fVMYE7YZ0hJWfatxLZl0JkOfPngs/fQQrgUN0zkHcxEkByc+tQpY9YVpXb+FQ8lq7cNr20PkgytE8PwibPfRFIgf6TW23LDPrAi9Oi6jAPztw1w/Gw2FUCcdRuCGeBSAj0qCa5bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728505882; c=relaxed/simple;
	bh=mMAgZa07M/tSaFvM4gDdX6SIaFdy73SCo6kbM0z+P+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eP1eDiOTh29WccleGiX2SzMgk01PibqVfi36nuDng8cjQppJQWmm2cvvYx9Q5NfTKIzOjk9prrqZqd6sRJXbv1yaa9CZDTtm2iisXRDwZh0VYFI235S/fBf/2vjk/c4z7WA+o+POnPPwTnzdNiOB7+Dp7fW0Pl9Fug2NCFD1mqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=LCaD9ErN; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="LCaD9ErN"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e28fa28de37so152771276.3
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 13:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728505879; x=1729110679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a8fC45fk3kkuGgz5bp0aKHUHsvCc3Jgn8s/zOrWkLl4=;
        b=LCaD9ErNZfXdfVQPvz2eDLrhWI1QwkkJZRvCqt+PkyqKe9McQch7tIBmQt+5iZSH2V
         hcDLpBnR72rcvwBSi++OPvR/wGOxeF7VRpNw9Q/FujQddh842+/rrkXoT8fw/q7M1J+I
         CyKj6oYyIqriU8Tj0jLG5QNcNjW7CnhFaH4VpYjMCU0NOPPUmqN/JG7caRjKDfPQr8cs
         48NIy5702wCrdHDGPCJWmAyp1I6N5AvUHrS9TfYGVT2c/Xea8maHKy4sq2ze/OE89gsI
         /fKeMJFEFgKbfVrwbxeb8TdY1z+xoYvhuPKtJ5UsyqHI77vvkIkEPRuxqKEzIU7mof5W
         kQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728505879; x=1729110679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8fC45fk3kkuGgz5bp0aKHUHsvCc3Jgn8s/zOrWkLl4=;
        b=K+xxJbIgqgGzY++nJYUiOw3KGW6wwWUPuuZsSSu6Wqj48s2rvPb8ydA5T5zievRYJm
         0t3ThsQ8NelrDdoT5X2JrIheao361BqfNY511npbHQ8wlbszSo/w7N3yPbmsuxe54Njg
         wGilb7iTasL1U2zl4tQ67w0zvxf1dOUQ4FfOxi2fATFSDLmC6s69r2RIqqGjXR4BiTOs
         K/zoS360sBRL4xGiM0XhGQMpLePFH8QOumBtQKa4G/u87tw8jL8Bxr6rPwoLDQPbp206
         SbUe6lzKL/hVoJ/9u3hj3grUH3AcuCosQVggCKgAfTtdlOLAbnGbBrtQstTdRgXgoE4i
         1QmQ==
X-Gm-Message-State: AOJu0YyJgHYiwm7rb+jpadVJ5yQHAOtYpt7qvYnxcyQ/TA/LnLTZp7AS
	IFq7Ed51+GX/oSSDWoQpx34EIhR7jomvNwnnorszY1y2Pzbu9CXr5/072+4TDrk+MIFHX7fLmZ0
	KZbM=
X-Google-Smtp-Source: AGHT+IGf/IEk5AtA0WDnEKW35I0p0zu/B1H9Z/T5/ACsPwuH316Qgsk8ueHTiu0mMSx64m2lV3uEWg==
X-Received: by 2002:a05:6902:218f:b0:e28:f176:105 with SMTP id 3f1490d57ef6-e28fe4dbdc4mr3789125276.36.1728505879397;
        Wed, 09 Oct 2024 13:31:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e28f0e31127sm729836276.58.2024.10.09.13.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 13:31:19 -0700 (PDT)
Date: Wed, 9 Oct 2024 16:31:17 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 06/11] pack-bitmap: drop `from_midx` field from
 `bitmapped_pack`
Message-ID: <278beed9cfbca0ec00a113e36d615d1d47a5223f.1728505840.git.me@ttaylorr.com>
References: <cover.1728505840.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1728505840.git.me@ttaylorr.com>

This field was added in 41cd4b478f7 (pack-bitmap: tag bitmapped packs
with their corresponding MIDX, 2024-08-27) in order to expose the
bitmap's MIDX in order to translate bit positions correctly from
within 'pack-objects' during pack-reuse (c.f., 125c32605ab
(builtin/pack-objects.c: translate bit positions during pack-reuse,
2024-08-27) for more details).

But another approach would have been to use the `->midx` field of the
`struct bitmap_index *` directly, which feels clearer and avoids
duplicating information.

Unfortunately, we can't access that field directly since it is part of
the `bitmap_index` structure which is static within the pack-bitmap.c
compilation unit.

So let's instead introduce a new function which returns that pointer
to us, and replace the `from_midx` field with uses of that new
function (which we call `bitmap_midx()` here).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 4 ++--
 midx.c                 | 1 -
 pack-bitmap.c          | 6 +++++-
 pack-bitmap.h          | 2 +-
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0fc0680b402..097bb5ac2ca 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1201,7 +1201,7 @@ static void write_reused_pack(struct bitmapped_pack *reuse_packfile,
 			if (pos + offset >= reuse_packfile->bitmap_pos + reuse_packfile->bitmap_nr)
 				goto done;
 
-			if (reuse_packfile->bitmap_pos) {
+			if (bitmap_is_midx(bitmap_git)) {
 				/*
 				 * When doing multi-pack reuse on a
 				 * non-preferred pack, translate bit positions
@@ -1209,7 +1209,7 @@ static void write_reused_pack(struct bitmapped_pack *reuse_packfile,
 				 * pack-relative positions before attempting
 				 * reuse.
 				 */
-				struct multi_pack_index *m = reuse_packfile->from_midx;
+				struct multi_pack_index *m = bitmap_midx(bitmap_git);
 				uint32_t midx_pos;
 				off_t pack_ofs;
 
diff --git a/midx.c b/midx.c
index 67e0d640046..ca98bfd7c64 100644
--- a/midx.c
+++ b/midx.c
@@ -496,7 +496,6 @@ int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
 				 MIDX_CHUNK_BITMAPPED_PACKS_WIDTH * local_pack_int_id +
 				 sizeof(uint32_t));
 	bp->pack_int_id = pack_int_id;
-	bp->from_midx = m;
 
 	return 0;
 }
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 6dbe6a2c5bc..b9ea1fab397 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2326,7 +2326,6 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 		packs[packs_nr].pack_int_id = pack_int_id;
 		packs[packs_nr].bitmap_nr = pack->num_objects;
 		packs[packs_nr].bitmap_pos = 0;
-		packs[packs_nr].from_midx = bitmap_git->midx;
 
 		objects_nr = packs[packs_nr++].bitmap_nr;
 	}
@@ -2981,6 +2980,11 @@ int bitmap_is_midx(struct bitmap_index *bitmap_git)
 	return !!bitmap_git->midx;
 }
 
+struct multi_pack_index *bitmap_midx(struct bitmap_index *bitmap_git)
+{
+	return bitmap_git->midx;
+}
+
 const struct string_list *bitmap_preferred_tips(struct repository *r)
 {
 	const struct string_list *dest;
diff --git a/pack-bitmap.h b/pack-bitmap.h
index d7f4b8b8e95..a1e8c8936c9 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -60,7 +60,6 @@ struct bitmapped_pack {
 	uint32_t bitmap_pos;
 	uint32_t bitmap_nr;
 
-	struct multi_pack_index *from_midx; /* MIDX only */
 	uint32_t pack_int_id; /* MIDX only */
 };
 
@@ -157,6 +156,7 @@ char *midx_bitmap_filename(struct multi_pack_index *midx);
 char *pack_bitmap_filename(struct packed_git *p);
 
 int bitmap_is_midx(struct bitmap_index *bitmap_git);
+struct multi_pack_index *bitmap_midx(struct bitmap_index *bitmap_git);
 
 const struct string_list *bitmap_preferred_tips(struct repository *r);
 int bitmap_is_preferred_refname(struct repository *r, const char *refname);
-- 
2.47.0.11.g487258bca34

