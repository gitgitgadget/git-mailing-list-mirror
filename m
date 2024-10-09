Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8821E284B
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728505885; cv=none; b=ugwVJEGxxd8zfrLjWaAV1Mzq+jlcTroRrpjhCkkkAm681N3NrwOzY+orWBTgrpLolIgtNXH4DXxHcgrYmlwUmeBaAxIJzHt+wrSNysdMhNOZf3FIXpM3zyuYSa4jaf6h2zT+XS0ZwXSoRSwnuZalgQXfYm3zMSr0iy56pFCnTxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728505885; c=relaxed/simple;
	bh=8+RhcNlNymeg5o2rLVPpOBBAFzTvS9OJEsV8+beC2hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbVFnylJbOTFqW9ILcmfM3W4pMdfY6kpYPFs6q1nrn2ZTDKjmxWzkhUK9EbIsEoCaWK4xhd/KUuflNnr3e+df2iRDZViVTRpevYqGTRKDDSQULWIUmub31HZz03OIrpLCp6FkiUvrWRCBq7Q7SSDJS0uNIXNeX9YaGjy5XBYpQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=N5TIShPD; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="N5TIShPD"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e2346f164cso2603157b3.3
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 13:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728505882; x=1729110682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mqe0GPnuXb9j/DsS9BJF8/QGW/5Dw4Nes3IsxXwm4R4=;
        b=N5TIShPD2jQX08DvrSyu5s1gxGdwRJfXT1+ZkP1bHzf6GzWYTht0JDlcOJdJ1xz1IQ
         bC3NbCObBgkH4m7eY3SIeq02DPRmKruVk/CuNCcXRIiTZCou5ihW1K766+HsCJeAKat3
         10GozdOqapbeyZ97MR/3NK9zjAe+dGoPTsjwEAP71//cgFqYEXGyeW1joLiouNVfADDP
         lqQQeGdOpbxL8eN5TkNNLrM2jroKaWg8PMkz7zBqsBTJxzfePQJHvSO4n8lFGpHFtPEW
         LepZ2hFKpqn20pghc2LfqNH3VycP0cy9VfRCEOde507tcJDntaAtRZjlhnPv0TWiz4XQ
         Bxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728505882; x=1729110682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mqe0GPnuXb9j/DsS9BJF8/QGW/5Dw4Nes3IsxXwm4R4=;
        b=sgEuaJ4DiwVOzI8kKz/MOnZsz5d5y9ONNp3AEzxcfEuugfocYW3fnmibadJEE7KuCY
         Db2uPomaV7zRhQoTFWEThR2k2Mlpx88fIkAaopGI1uCEncCivIbIT7P+YwjVNyQYh6jF
         lBh/Qh1p/K0oDT8UqIyHcID/vOXMH3mYPEPY2Xe/jpuN90kaoadcLWkSr7q4zNkz4nfP
         +F+xteWYL88HfmQmighnmq8qZ+fnkdjXXxh9sPuQgyDis4hnE1NCIoTAa0/yG85B2628
         CIPMZcql2qmOrbRog77Kb9gyxVbSWPbxZdbFJjE2RTuom9Cav8+svrIhCnTW1BXEawLS
         Oxyw==
X-Gm-Message-State: AOJu0YxKLcQdl8EsN3lt99zwforsnF3ZCZIjARXdmNI1EvcqoqRde7XT
	0fKevwxOdNKXgoH2VinA0nHKUT9m6AnMDnQ/6nTW82XmWOgDT0f8hRUfBA6+R4877TctdvhsEH9
	nAgE=
X-Google-Smtp-Source: AGHT+IHdLnL1jg4F4w9r+rw56f0uO5RMMGyDeG4knzXHNPck/OgxH7kh8aHoyvZXZmzDMsACsgFS/w==
X-Received: by 2002:a05:690c:3502:b0:6e3:21fa:e50f with SMTP id 00721157ae682-6e322197244mr45605567b3.13.1728505882551;
        Wed, 09 Oct 2024 13:31:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d93d75a8sm20404927b3.96.2024.10.09.13.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 13:31:22 -0700 (PDT)
Date: Wed, 9 Oct 2024 16:31:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 07/11] write_reused_pack_one(): translate bit positions
 directly
Message-ID: <94e5c96f6859479e0206d6d775eacf54b3639ee5.1728505840.git.me@ttaylorr.com>
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

A future commit will want to deal with bit positions instead of pack
positions from within builtin/pack-objects.c::write_reused_pack_one().

That function at present takes a pack position, so one approach to
accommodating the new functionality would be to add a secondary bit
position parameter, making the function's declaration look something
like:

    static void write_reused_pack_one(struct packed_git *reuse_packfile,
                                      size_t pack_pos, size_t bitmap_pos,
                                      struct hashfile *out,
                                      off_t pack_start,
                                      struct pack_window **w_curs);

But because the pack-relative position can be easily derived from the
bit position, it makes senes to just pass the latter and let the
function itself translate it into a pack-relative position.

To do this, extract a new function `bitmap_to_pack_pos()` from the
existing `write_reused_pack()` function. This new routine is responsible
for performing the conversion from bitmap- to pack-relative positions.

Instead of performing that translation in `write_reused_pack()`, instead
call the new function from within `write_reused_pack_one()` so that we
can just pass a single bit position to it.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 78 ++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 37 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 097bb5ac2ca..7f50d58a235 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1017,6 +1017,42 @@ static off_t find_reused_offset(off_t where)
 	return reused_chunks[lo-1].difference;
 }
 
+static uint32_t bitmap_to_pack_pos(struct packed_git *reuse_packfile,
+				   size_t pos)
+{
+	if (bitmap_is_midx(bitmap_git)) {
+		/*
+		 * When doing multi-pack reuse on a
+		 * non-preferred pack, translate bit positions
+		 * from the MIDX pseudo-pack order back to their
+		 * pack-relative positions before attempting
+		 * reuse.
+		 */
+		struct multi_pack_index *m = bitmap_midx(bitmap_git);
+		uint32_t midx_pos, pack_pos;
+		off_t pack_ofs;
+
+		if (!m)
+			BUG("non-zero bitmap position without MIDX");
+
+		midx_pos = pack_pos_to_midx(m, pos);
+		pack_ofs = nth_midxed_offset(m, midx_pos);
+
+		if (offset_to_pack_pos(reuse_packfile, pack_ofs, &pack_pos) < 0)
+			BUG("could not find expected object at offset %"PRIuMAX" in pack %s",
+			    (uintmax_t)pack_ofs, pack_basename(reuse_packfile));
+
+		return pack_pos;
+	} else {
+		/*
+		 * Can use bit positions directly, even for MIDX
+		 * bitmaps. See comment in try_partial_reuse()
+		 * for why.
+		 */
+		return pos;
+	}
+}
+
 static void write_reused_pack_one(struct packed_git *reuse_packfile,
 				  size_t pos, struct hashfile *out,
 				  off_t pack_start,
@@ -1025,9 +1061,10 @@ static void write_reused_pack_one(struct packed_git *reuse_packfile,
 	off_t offset, next, cur;
 	enum object_type type;
 	unsigned long size;
+	uint32_t pack_pos = bitmap_to_pack_pos(reuse_packfile, pos);
 
-	offset = pack_pos_to_offset(reuse_packfile, pos);
-	next = pack_pos_to_offset(reuse_packfile, pos + 1);
+	offset = pack_pos_to_offset(reuse_packfile, pack_pos);
+	next = pack_pos_to_offset(reuse_packfile, pack_pos + 1);
 
 	record_reused_object(offset,
 			     offset - (hashfile_total(out) - pack_start));
@@ -1191,7 +1228,6 @@ static void write_reused_pack(struct bitmapped_pack *reuse_packfile,
 		size_t pos = (i * BITS_IN_EWORD);
 
 		for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
-			uint32_t pack_pos;
 			if ((word >> offset) == 0)
 				break;
 
@@ -1201,40 +1237,8 @@ static void write_reused_pack(struct bitmapped_pack *reuse_packfile,
 			if (pos + offset >= reuse_packfile->bitmap_pos + reuse_packfile->bitmap_nr)
 				goto done;
 
-			if (bitmap_is_midx(bitmap_git)) {
-				/*
-				 * When doing multi-pack reuse on a
-				 * non-preferred pack, translate bit positions
-				 * from the MIDX pseudo-pack order back to their
-				 * pack-relative positions before attempting
-				 * reuse.
-				 */
-				struct multi_pack_index *m = bitmap_midx(bitmap_git);
-				uint32_t midx_pos;
-				off_t pack_ofs;
-
-				if (!m)
-					BUG("non-zero bitmap position without MIDX");
-
-				midx_pos = pack_pos_to_midx(m, pos + offset);
-				pack_ofs = nth_midxed_offset(m, midx_pos);
-
-				if (offset_to_pack_pos(reuse_packfile->p,
-						       pack_ofs, &pack_pos) < 0)
-					BUG("could not find expected object at offset %"PRIuMAX" in pack %s",
-					    (uintmax_t)pack_ofs,
-					    pack_basename(reuse_packfile->p));
-			} else {
-				/*
-				 * Can use bit positions directly, even for MIDX
-				 * bitmaps. See comment in try_partial_reuse()
-				 * for why.
-				 */
-				pack_pos = pos + offset;
-			}
-
-			write_reused_pack_one(reuse_packfile->p, pack_pos, f,
-					      pack_start, &w_curs);
+			write_reused_pack_one(reuse_packfile->p, pos + offset,
+					      f, pack_start, &w_curs);
 			display_progress(progress_state, ++written);
 		}
 	}
-- 
2.47.0.11.g487258bca34

