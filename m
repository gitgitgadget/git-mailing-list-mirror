Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B874D1DFE2B
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 20:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728505879; cv=none; b=rakpaXyn7O6u6F28lVmvrXD/IRBuX8vBkYjqxRy9o/1o4Aja5hTBpF4VatbRyTiXLIFkIU/elsGYTWD6/Tg+3DLW4MbNBVwcp5hCrvboflOZUeM1mocf6ZmxXu3+G7UUvpfiRPxZfAjDSoWe7YpKql397GLuS73gALcj27IPHss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728505879; c=relaxed/simple;
	bh=4q5yxhJJXoLLr3+Ye/IHlYpmxzjCEFmb3HTTNRpNOsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ej2CQI8cau2iaPoW8qCp2ocjIWnUh/b3hzukgx65+eXoa2d0guPasl819ETn7yGKGJJbXa/PRn1oaJJ/wZG37pRb5xkwQuTsKp9iDmJSKpU8QVncDaJc/Q/iYrdnNXwnaQBZjfxCJIerMjvXx5uamRvBsQC+DoSFEyb3s9vbyjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=R3govh6L; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="R3govh6L"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e129c01b04so2585067b3.1
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 13:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728505876; x=1729110676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hTsER+cHeQLEW3HZD4aUsowq/3kZuml36OPqteXqdBM=;
        b=R3govh6LCqgLhKKtDbQNciPK1tp9mBpyfcEOm9Xq/A8o2UJM34KAkzf9vYUmIe3RyN
         Wbq7XElnVIF5ji5lZZYy7nTvpasIc85naicMus8U26ubYkBE/3KYkT347iKrxgDRuleb
         ttZ5arVyFUY1XCeiwRQozah84kOGJ6ivMXKra0V97MLvX+brydrwvJLA4lYQSdyD5PTD
         iQbUl96y8ajZJHiemCfxTAnoyep6kcNs/6eOAxtOE4WgPSRFAXNxigXcHZqFwJ6PdmIa
         P0D/t0/AcowuMkmBel6e4+kz9kfvyJ1frpCjH5/SGzZtiZH8/iBwSQxtlDVnPumkNe9J
         f+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728505876; x=1729110676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTsER+cHeQLEW3HZD4aUsowq/3kZuml36OPqteXqdBM=;
        b=Jb+b20+LzA6IIjRcffcRkilHmX5zO0gl0vayMU2uKYnRDZhLC5Y8DZH0e7nH1URCKD
         ng07vw25tOMFRtJUkbjt82mnhFHfR0liNU8N7iHrCSpYwclhDZwEh9kF/EV4737bo+Fy
         zF10j5klh58dA7lN6sL6bDkKwITeS57tXSzaCScuDyZ0EjHjy1dkFxODdGf9I765NCEf
         3vFdCO9vx0J9nHkvNZhmrsT6yggqsmHeECKJxfZ3O9ADyD4sVv4nysNQwJGSd5Md/DiT
         39iMSyMvpqA+2CkfqMaLPt4vII56r9UKuborBip+M8hiSPQTiQAYjt8oHzGDdlZF9eZj
         2J8w==
X-Gm-Message-State: AOJu0Yyif05A5ev09tA/uB7vrjQtatXRmjADD89mj+YSAZ0kDhT50tGM
	5NQzon3CsYZos6xNKPfM13yiPcsFpgX94AD+IlTmHExsy41WjeLO7eOBdFDquL3l8qpJ/GC5lb9
	skMc=
X-Google-Smtp-Source: AGHT+IGX2j7yG/fGRZmwEI0qRzH4e35MannYAAwaZedz/tgEVAspk/EKryd0ybpIk3D/aqn8ITqiWQ==
X-Received: by 2002:a05:690c:89:b0:6e3:2b5e:918f with SMTP id 00721157ae682-6e32b5e93camr24725807b3.44.1728505876077;
        Wed, 09 Oct 2024 13:31:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d93e2cdasm19860487b3.114.2024.10.09.13.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 13:31:15 -0700 (PDT)
Date: Wed, 9 Oct 2024 16:31:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 05/11] pack-bitmap.c: extract `find_base_bitmap_pos()`
Message-ID: <f4dca03d84583b5e8565af3b6759f05cf2b0be3f.1728505840.git.me@ttaylorr.com>
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

Inside of `try_partial_reuse()` is a block of code that handles
specially the case where the object we are attempting reuse on is
either an OFS_DELTA or a REF_DELTA.

Extract that part of the routine out to a separate function, named
`find_base_bitmap_pos()`. This will allow us to make that routine
slightly more complex in order to implement cross-pack and thin-delta
conversion (which we'll describe in detail in subsequent patches)
without compromising the readability of its caller,
`try_partial_reuse()`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 90 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 49 insertions(+), 41 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 3e1034cabf3..6dbe6a2c5bc 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2047,6 +2047,52 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 	return NULL;
 }
 
+static int find_base_bitmap_pos(struct bitmap_index *bitmap_git,
+				struct bitmapped_pack *pack,
+				off_t base_offset,
+				off_t delta_obj_offset,
+				uint32_t *base_bitmap_pos)
+{
+	if (bitmap_is_midx(bitmap_git)) {
+		/*
+		 * Cross-pack deltas are rejected for now, but could
+		 * theoretically be supported in the future.
+		 *
+		 * We would need to ensure that we're sending both
+		 * halves of the delta/base pair, regardless of whether
+		 * or not the two cross a pack boundary. If they do,
+		 * then we must convert the delta to an REF_DELTA to
+		 * refer back to the base in the other pack.
+		 * */
+		if (midx_pair_to_pack_pos(bitmap_git->midx, pack->pack_int_id,
+					  base_offset, base_bitmap_pos) < 0)
+			return -1;
+	} else {
+		/*
+		 * We assume delta dependencies always point backwards.
+		 * This lets us do a single pass, and is basically
+		 * always true due to the way OFS_DELTAs work. You would
+		 * not typically find REF_DELTA in a bitmapped pack,
+		 * since we only bitmap packs we write fresh, and
+		 * OFS_DELTA is the default). But let's double check to
+		 * make sure the pack wasn't written with odd
+		 * parameters.
+		 *
+		 * Since we're working on a single-pack bitmap, we can
+		 * use the object offset as a proxy for the bit
+		 * position, since the bits are ordered by their
+		 * positions within the pack.
+		 */
+		if (base_offset >= delta_obj_offset)
+			return -1;
+		if (offset_to_pack_pos(pack->p, base_offset,
+				       base_bitmap_pos) < 0)
+			return -1;
+	}
+
+	return 0;
+}
+
 /*
  * -1 means "stop trying further objects"; 0 means we may or may not have
  * reused, but you can keep feeding bits.
@@ -2081,49 +2127,11 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 		 */
 		base_offset = get_delta_base(pack->p, w_curs, &offset, type,
 					     delta_obj_offset);
-		if (!base_offset)
+		if (!base_offset ||
+		    find_base_bitmap_pos(bitmap_git, pack, base_offset,
+					 delta_obj_offset, &base_bitmap_pos) < 0)
 			return 0;
 
-		if (bitmap_is_midx(bitmap_git)) {
-			/*
-			 * Cross-pack deltas are rejected for now, but could
-			 * theoretically be supported in the future.
-			 *
-			 * We would need to ensure that we're sending both
-			 * halves of the delta/base pair, regardless of whether
-			 * or not the two cross a pack boundary. If they do,
-			 * then we must convert the delta to an REF_DELTA to
-			 * refer back to the base in the other pack.
-			 * */
-			if (midx_pair_to_pack_pos(bitmap_git->midx,
-						  pack->pack_int_id,
-						  base_offset,
-						  &base_bitmap_pos) < 0) {
-				return 0;
-			}
-		} else {
-			/*
-			 * We assume delta dependencies always point backwards.
-			 * This lets us do a single pass, and is basically
-			 * always true due to the way OFS_DELTAs work. You would
-			 * not typically find REF_DELTA in a bitmapped pack,
-			 * since we only bitmap packs we write fresh, and
-			 * OFS_DELTA is the default). But let's double check to
-			 * make sure the pack wasn't written with odd
-			 * parameters.
-			 *
-			 * Since we're working on a single-pack bitmap, we can
-			 * use the object offset as a proxy for the bit
-			 * position, since the bits are ordered by their
-			 * positions within the pack.
-			 */
-			if (base_offset >= delta_obj_offset)
-				return 0;
-			if (offset_to_pack_pos(pack->p, base_offset,
-					       &base_bitmap_pos) < 0)
-				return 0;
-		}
-
 		/*
 		 * And finally, if we're not sending the base as part of our
 		 * reuse chunk, then don't send this object either. The base
-- 
2.47.0.11.g487258bca34

