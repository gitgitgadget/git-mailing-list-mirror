Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A921E6DE4
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 19:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725478096; cv=none; b=IjDYyfR8WDModPCibMbs2T/OA2E3pfHw3k498xI1gcXlLO1DPB5Oi8EkD5XxTwde5rpLctnF7qILIHe7gHCirtvpnWpxcMuhgiMeuJmXxnCELEKTjiDZJlZQh20XIFCMRwtxPLVpCUXOW9NYnbqCU4yfY2DDQ3usTlSFtKTaiNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725478096; c=relaxed/simple;
	bh=6fUGFe9VzgJk8jVcL+FVwt0A0mP3ack5qroHwfQ+yRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OANANawu1n8r+fXiCKq48VOjQY84D8E6ibvhmAg2czv1MxF+q5cCNesj9n0z5Qsj0qigiN9UL4LN8lqzJD6LPOeCmZOW06vGy2ii3A3RxRhHJhw8Kz7wDUax8VlGI0kumvEoc0eDV10VcoCHo/YnotAuRjuGbz8BZkzI+EwI8AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=1b2eOyE2; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="1b2eOyE2"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6c359c1a2fdso23487436d6.2
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 12:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725478094; x=1726082894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OvYs8TnYuWRluQ6UAhYwSKQghWdxUin3opez1Ai1Ptw=;
        b=1b2eOyE2ay4O8JvYOUn5gCp8u8LxaHJaWDTXUbp9u3in8zgceMcRaZZvaXzsIfirXY
         vypkf5NE6IOYZLk4Ql0epvIFLvMKav1eNO6MZnIR7spmmFMo5skyNnIICU/2FK0QYuvc
         25nyaXp9K4KOvg5+i3V13m9Y6+rMPU+4YgBEi1ip7PbLt3u3IC7Ft9LJiWnoijyZFLyG
         jNNG7IcCxzLzkmlsX0B96v3gOYI+BOCPcdIOYnOQxdMCzx49TozsRYyVVz8hanvFOXe4
         03AsKImsrVo+4Epli7iVdFQ7F1/xfyMiBH4xmrTcHEOVg7/CnSM1CXxjq5E4SFT62VzR
         TkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725478094; x=1726082894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvYs8TnYuWRluQ6UAhYwSKQghWdxUin3opez1Ai1Ptw=;
        b=LtsXqIAkJqgSuF6PCHRFnOnfmP5TP/+7nCF1tY7Odr/ixkHwirL5lkSbbHS34uaWtk
         LoDyhk2v9Q+DbjUq+T16gp2LeZtaOdwoPQsUTZ0JCdRNUm7ESCtabiW1KLUAlL8B0btv
         uLAtDScghiyrjFnmbWdQDom7h8KUm7HNyyFxG6BWwEu9XkRduXelfQvM0oo03HGLhqm8
         CRiW4S3dflhAZipzVz+Jjisy3RhK3cCCoI39di0WOEyHJHpr39gK5IDI+QTu6lIgS4nA
         9BsmYDvaoslJ3fhOdvLJCV24jhSU5NGzS1J8r7JOoyfTDdCerxGL4EicgoINJAZtfJbM
         OBkA==
X-Gm-Message-State: AOJu0Yw45IBB8jmE8g30ydPmiyndfC/hJzQIkcgdV1F19vGt5uPEZgJC
	T3ZvPbst3ecynQN4+K4agK3zmF9bQgLxEyiu0wlJYIMbjBdNMfgm4knrFwGh0MrBh/B0eBTFlTZ
	0CBg=
X-Google-Smtp-Source: AGHT+IEHhcd+lgsjbBD24NxxRQvKuQlnqB+AJIOQIESYoVzOqeKDyiUKe0sQszBcv7JgztAPn+QVOg==
X-Received: by 2002:a05:6214:319f:b0:6c3:68b0:a5ce with SMTP id 6a1803df08f44-6c3c62a7ed6mr88137576d6.27.1725478093966;
        Wed, 04 Sep 2024 12:28:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5204180ddsm1053776d6.109.2024.09.04.12.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 12:28:13 -0700 (PDT)
Date: Wed, 4 Sep 2024 15:28:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] pack-bitmap.c: avoid repeated `pack_pos_to_offset()`
 during reuse
Message-ID: <Zti0xrzCtpWScPjz@nand.local>
References: <cover.1724793201.git.me@ttaylorr.com>
 <afa25c8806b0e80f1d3ed46f29eb164cab4583ac.1724793201.git.me@ttaylorr.com>
 <xmqq1q1z9rmt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1q1z9rmt.fsf@gitster.g>

On Wed, Sep 04, 2024 at 11:54:18AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > @@ -2055,17 +2055,18 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
> >  			     struct bitmapped_pack *pack,
> >  			     size_t bitmap_pos,
> >  			     uint32_t pack_pos,
> > +			     off_t offset,
> >  			     struct bitmap *reuse,
> >  			     struct pack_window **w_curs)
> >  {
> > -	off_t offset, delta_obj_offset;
> > +	off_t delta_obj_offset;
> >  	enum object_type type;
> >  	unsigned long size;
> >
> >  	if (pack_pos >= pack->p->num_objects)
> >  		return -1; /* not actually in the pack */
> >
> > -	offset = delta_obj_offset = pack_pos_to_offset(pack->p, pack_pos);
>
> We are now passing redundant piece of information "offset" that
> could be derived from two other parameters, which feels a bit icky,

Yeah, I agree. The only spot we use pack_pos in this function is in the
hunk above, and in the check where we reject any deltas whose base has a
greater than or equal to bit position than the delta object's bit
position.

But I think both of those are redundant. The only caller in
reuse_partial_packfile_from_bitmap_1() only passes bit positions that
are set, so we'll never trip the bounds check above. For the latter
check, it would suffice to compare object offsets in the single-pack
case, since the bit positions corresponding to objects in a single pack
are derived from the ordering of their actual offset.

>  - The logic to punt on a delta pointing backwards can be done by
>    comparing the base_offset and offset, instead of comparing the
>    base_pos and pack_pos.

Ah, yes -- exactly ;-). I should have read the email in its entirety
before starting to respond.

> but it may not be worth the effort, unless we are going to do
> similar clean-up globally in all the codepaths that access
> packfiles.

I'm not so sure we can do it in all cases, but at least in the case of
try_partial_reuse(), doing something like this (which compiles and
passes "make test") is fine:

--- 8< ---
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 9d9b8c4bfb..fc51f298d5 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2054,7 +2054,6 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 static int try_partial_reuse(struct bitmap_index *bitmap_git,
 			     struct bitmapped_pack *pack,
 			     size_t bitmap_pos,
-			     uint32_t pack_pos,
 			     off_t offset,
 			     struct bitmap *reuse,
 			     struct pack_window **w_curs)
@@ -2063,9 +2062,6 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 	enum object_type type;
 	unsigned long size;

-	if (pack_pos >= pack->p->num_objects)
-		return -1; /* not actually in the pack */
-
 	delta_obj_offset = offset;
 	type = unpack_object_header(pack->p, w_curs, &offset, &size);
 	if (type < 0)
@@ -2121,8 +2117,13 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 			 * OFS_DELTA is the default). But let's double check to
 			 * make sure the pack wasn't written with odd
 			 * parameters.
+			 *
+			 * Since we're working on a single-pack bitmap, we can
+			 * use the object offset as a proxy for the bit
+			 * position, since the bits are ordered by their
+			 * positions within the pack.
 			 */
-			if (base_pos >= pack_pos)
+			if (base_offset >= offset)
 				return 0;
 			base_bitmap_pos = pack->bitmap_pos + base_pos;
 		}
@@ -2218,8 +2219,8 @@ static void reuse_partial_packfile_from_bitmap_1(struct bitmap_index *bitmap_git
 				ofs = pack_pos_to_offset(pack->p, pack_pos);
 			}

-			if (try_partial_reuse(bitmap_git, pack, bit_pos,
-					      pack_pos, ofs, reuse, &w_curs) < 0) {
+			if (try_partial_reuse(bitmap_git, pack, bit_pos, ofs,
+					      reuse, &w_curs) < 0) {
 				/*
 				 * try_partial_reuse indicated we couldn't reuse
 				 * any bits, so there is no point in trying more
--- >8 ---

Thanks,
Taylor
