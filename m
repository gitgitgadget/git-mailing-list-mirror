Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B7B1D4151
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 21:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724793220; cv=none; b=CfQXQZ7c9z/7wM6w6dZyOFgpgSmcq4sImli9dFGMVdCT7gN0JjZOwKiwxxeDgun69N1gpQgpQqeAiCruoNvFXLHIEdKg8PuohfNGnvxa1IzCe4TtrwMO6AMnIdsYH+g30VXKgclkV/syzMF5YVshoKv2xhDxdAQkd49wo1wk69Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724793220; c=relaxed/simple;
	bh=rHpynxrrIMfRmixj3eCQ4+gBoq2VCScBQQO2t7+Zquk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKHDRpqj/gANJ883yRc4eKdFwCDtDKfVLd1pvrbKXPzWNVDRmIS6pe37qLXMhCD9laOkUPyao+u3Zr6xkFO1O/nxB7okcTUk9V2I/fQ6rAZCNcfPN2UJZCrbUFZcMXoqeRTEZnOO9pcBYqQq2CTSWJm8oBc8OmFtAhowlIMZ8Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=TXQSpd/T; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="TXQSpd/T"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6c32daf0797so58967947b3.0
        for <git@vger.kernel.org>; Tue, 27 Aug 2024 14:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1724793218; x=1725398018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EF97xyvUiugjVKOpBxdFrk2D3yPbmnr46zpjYqiuewc=;
        b=TXQSpd/TV14+0H5ch3vxJKlHu1BmHnmw0HRZbpT11N7jWrsieGFN6FRhMLOa6gvGCD
         aW0nqEP9l2ZV81g8X3MHpJ/A6y6JMd6hh/MzHrfKHDwpOCuYqe60i/7FB9cPSlVJnQa4
         /lAwvvovi+dz7bR5p9Zt9OkSaav1/o0UedcIw6ZfwGaJfrKRKuWkG+hiyceXoi/X2CH2
         DDCOyxmS3KEIXvJ0QCkW0fyaqF9d0iJw9GhkqhrWJLV9RUfpVrx8n/vOit2FXFkpNSjr
         reCqT0207UIAqcGwm9KoRPAId2Pr/WTp3xmTqR1IlQuvT2XLEpesr3RNtZpszauoO/8I
         JxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724793218; x=1725398018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EF97xyvUiugjVKOpBxdFrk2D3yPbmnr46zpjYqiuewc=;
        b=t70ovYFheIb1O7PvI1WkiuDGt+MFgaOyIAr7YIvrho8IpoHDm0hhLcVRZmf2gwSZ1A
         u6wQWJWHDmnej9Cf1H2LT5jbflTn3/DIWFCzpCtPcql1cHaFwJfTGWbeFiG1V+0JdPMs
         I8rfJ6mXZ6SlLIxiDbW3f/dAGAS8pESZJlvHed3yi1rOcgrCGVUMCrWcEnRU9g/Or9Wq
         1q/KMtIB9bWPdvoApKjbseah9VUFw6L2jdPHz7hRctBQiwoAbFySsVTErqSbUdbpCvHq
         JHelGQlriRHHcdBlN21R8ze0faYNOtkXfbNQ9Y9yId6q3e5bm04Pe8XffF4mpAhup2DU
         UVUQ==
X-Gm-Message-State: AOJu0YySP8LN1NkJvsUr3gtkWBfFFqJkBiD1TfaGw8+if4sS3Pl2aBDa
	kWWH/ZebUMobrTAFpf4E9aUKg2sVl0sZtAJQdYF2W5FiDmbDKdzAhzkC3ux60A0EPKJ8B9VgUxd
	z
X-Google-Smtp-Source: AGHT+IFeHOaQQOinKfaPEEz9edSLLrg1iXJ8d06srfP/q87XR18kfRhFgrwlzgD+p2fHeEuxX5wYQA==
X-Received: by 2002:a05:690c:46c8:b0:66a:7cbe:6d4b with SMTP id 00721157ae682-6cfb99e6f7fmr50716897b3.12.1724793217861;
        Tue, 27 Aug 2024 14:13:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39b007fbesm20910237b3.70.2024.08.27.14.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 14:13:37 -0700 (PDT)
Date: Tue, 27 Aug 2024 17:13:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] pack-bitmap.c: avoid repeated `pack_pos_to_offset()`
 during reuse
Message-ID: <afa25c8806b0e80f1d3ed46f29eb164cab4583ac.1724793201.git.me@ttaylorr.com>
References: <cover.1724793201.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1724793201.git.me@ttaylorr.com>

When calling `try_partial_reuse()`, the (sole) caller from the function
`reuse_partial_packfile_from_bitmap_1()` has to translate its bit
position to a pack position.

In the MIDX bitmap case, the caller translates from the bit position, to
a position in the MIDX's pseudo-pack order (with `pack_pos_to_midx()`),
then get a pack offset (with `nth_midxed_offset()`) before finally
working backwards to get the pack position in the source pack by calling
`offset_to_pack_pos()`.

In the non-MIDX bitmap case, we can use the bit position as the pack
position directly (see the comment at the beginning of the
`reuse_partial_packfile_from_bitmap_1()` function for why).

In either case, the first thing that `try_partial_reuse()` does after
being called is determine the offset of the object at the given pack
position by calling `pack_pos_to_offset()`. But we already have that
information in the MIDX case!

Avoid re-computing that information by instead passing it in. In the
MIDX case, we already have that information stored. In the non-MIDX
case, the call to `pack_pos_to_offset()` moves from the function
`try_partial_reuse()` to its caller. In total, we'll save one call to
`pack_pos_to_offset()` when processing MIDX bitmaps.

(On my machine, there is a slight speed-up on the order of ~2ms, but it
is within the margin of error over 10 runs, so I think you'd have to
have a truly gigantic repository to confidently measure any significant
improvement here).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 218d7ac2eb..9d9b8c4bfb 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2055,17 +2055,18 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 			     struct bitmapped_pack *pack,
 			     size_t bitmap_pos,
 			     uint32_t pack_pos,
+			     off_t offset,
 			     struct bitmap *reuse,
 			     struct pack_window **w_curs)
 {
-	off_t offset, delta_obj_offset;
+	off_t delta_obj_offset;
 	enum object_type type;
 	unsigned long size;
 
 	if (pack_pos >= pack->p->num_objects)
 		return -1; /* not actually in the pack */
 
-	offset = delta_obj_offset = pack_pos_to_offset(pack->p, pack_pos);
+	delta_obj_offset = offset;
 	type = unpack_object_header(pack->p, w_curs, &offset, &size);
 	if (type < 0)
 		return -1; /* broken packfile, punt */
@@ -2184,6 +2185,7 @@ static void reuse_partial_packfile_from_bitmap_1(struct bitmap_index *bitmap_git
 		for (offset = 0; offset < BITS_IN_EWORD; offset++) {
 			size_t bit_pos;
 			uint32_t pack_pos;
+			off_t ofs;
 
 			if (word >> offset == 0)
 				break;
@@ -2198,7 +2200,6 @@ static void reuse_partial_packfile_from_bitmap_1(struct bitmap_index *bitmap_git
 
 			if (bitmap_is_midx(bitmap_git)) {
 				uint32_t midx_pos;
-				off_t ofs;
 
 				midx_pos = pack_pos_to_midx(bitmap_git->midx, bit_pos);
 				ofs = nth_midxed_offset(bitmap_git->midx, midx_pos);
@@ -2213,10 +2214,12 @@ static void reuse_partial_packfile_from_bitmap_1(struct bitmap_index *bitmap_git
 					BUG("advanced beyond the end of pack %s (%"PRIuMAX" > %"PRIu32")",
 					    pack_basename(pack->p), (uintmax_t)pack_pos,
 					    pack->p->num_objects);
+
+				ofs = pack_pos_to_offset(pack->p, pack_pos);
 			}
 
 			if (try_partial_reuse(bitmap_git, pack, bit_pos,
-					      pack_pos, reuse, &w_curs) < 0) {
+					      pack_pos, ofs, reuse, &w_curs) < 0) {
 				/*
 				 * try_partial_reuse indicated we couldn't reuse
 				 * any bits, so there is no point in trying more
-- 
2.46.0.426.g82754d92509

