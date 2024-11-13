Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC96202655
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519180; cv=none; b=usb1zPD8efZ4r5QPWKh3I5j1oNOy6M0MViYh+jRR9ib/zozOoJn4MNDPRH3EYqlqOER/YZr9PsEVi1Mej6bP/Cx6VtEEWcPrnruLJmre4m0PGrq2be/JaIgZdUVzTxwd0GMjzChztjzvlnLMBBiV0OQJjg5Tq/XhSuD0/l2qsfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519180; c=relaxed/simple;
	bh=74t0eYwM+nAF43zW5ufWb/8YVIjWAMvHQpGpG1Wy4ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvBX+rmD6+ZK0BycgECL8ryPYPqXLRr3UeGfJr9siwR4G72cjVyu7glS6wb7iRGlm9hCN9AtctbdrK/BaEuFPRsnC4oh3I79Be9WKtsLr1z8VJfYoYwed4binc6WeyHtwjHRqManMvtd4Z0bbzrflO+qMZSvSnCaSoseabRf0cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=oN2WkWPz; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="oN2WkWPz"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e3cdbc25a0so72498187b3.2
        for <git@vger.kernel.org>; Wed, 13 Nov 2024 09:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1731519177; x=1732123977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1pm80mIGFsqbkAbe45oxN5F/1oWQbSiIyoCG0dLzSQ=;
        b=oN2WkWPzLuQ3c+foX5Afi5Fw9MVi9a6lzHqZj2SeA95CqXrNnS+M+GCRJtQ9gVKU3O
         rMHiyXAWBQ7dYr/7b5GOYMHnEGXj03FVrkn/agUde8G8J9AsK33hCjIL61cxiPSHUmD1
         YgVyz7gysW/em0PB5lMFC1whLK2Vub76i2NYpkWAjYOpHuSGc/DzkaSoFSsieSVw5THq
         SrhvGldnp3XtLjQZo/KjU8fs2tzmM5iNLtg4JmAi/fKYsNoIP+SW0hszu9GN/KtfGyGW
         K0Uos4oA9Bym4Lv5O1VSZBFkxZS7B4ZZKTMzGG56L22iT/4HZwAuJK6caIBh5y0+gk1o
         PCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731519177; x=1732123977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1pm80mIGFsqbkAbe45oxN5F/1oWQbSiIyoCG0dLzSQ=;
        b=SvdM1GdZPhD8BKFJIJnpFt0YCW7J41o4BRUB9IGa+46E7J51MCSA++JdSnCAbO0uJ9
         AYYNZC4RGTLZcZ1RNVBfNrMw2/v19UYsKND/P9PVrcFOzW1qoPSTFKoOmMoPF37vW4Vb
         2NlnNanygRkqYJKEKNY55tC2+2CRVrjWFew/fY/HcEAS+Q/FszyE5DmgVjpa2YlOyskY
         mVbpss+9xHO22NxK0H9vDCpGEjdEX8NNKJNA5G82tMJgK3viFWN4G7EGcDZhQ6nruQgR
         ReZWIrafEqONjuFCDevS3pgTLx9sQRhu+RNQl5IkIucdVMHDiATs0DCX9K89ThD/ufqe
         uS6Q==
X-Gm-Message-State: AOJu0YyiGwv8NQ/bYZMSYguQRFd+TW6eao0z4FQn2oTbeGoyr1Vl/D34
	SXu0Gb9k/JHshLe5BIlBGyv8NdeXRLKtKQDOiZb7peaob62nR7dSMZYXUwd+DY8z5lEMUQ0tQF3
	Jmas=
X-Google-Smtp-Source: AGHT+IHaGkbnDzCblTK2ul5v1LDAk+FhjAxZGYFysfTL9QhXjz0ZseEcNJm53B7T2wkdrz1floNmfQ==
X-Received: by 2002:a05:690c:f83:b0:6ea:5da9:34cc with SMTP id 00721157ae682-6eaddd796a9mr215795297b3.7.1731519176671;
        Wed, 13 Nov 2024 09:32:56 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaceb7b240sm32078917b3.112.2024.11.13.09.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:32:56 -0800 (PST)
Date: Wed, 13 Nov 2024 12:32:55 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/2] t5332-multi-pack-reuse.sh: demonstrate duplicate packing
 failure
Message-ID: <7a69cf84ae5b92d99e5777d4600270712424c4d7.1731518931.git.me@ttaylorr.com>
References: <cover.1731518931.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1731518931.git.me@ttaylorr.com>

In the multi-pack reuse code, there are two paths for reusing the
on-disk representation of an object, handled by:

  - builtin/pack-objects.c::write_reused_pack_one()
  - builtin/pack-objects.c::write_reused_pack_verbatim()

The former is responsible for copying the bytes for a single object out
of an existing source pack. The latter does the same but for a region of
objects aligned at eword_t boundaries.

Demonstrate a bug whereby write_reused_pack_verbatim() can be tricked
into writing out objects from some source pack, even when those objects
were selected from a different source pack in the MIDX bitmap.

When the caller wants at least one of the objects in that region,
pack-objects will write the same object twice as a result of this bug.
In the other case where the caller doesn't want any of the objects in
the region of interest, we will write out objects that weren't
requested.

Demonstrate this bug by creating two packs, where the preferred one of
those packs contains a single object which also appears in the main
(non-preferred) pack. A separate bug[^1] prevents us from triggering the
main bug when the duplicated object is the last one in the main pack,
but any earlier object will suffice.

We could fix that separate bug, but the following commit will simplify
write_reused_pack_verbatim() and only call it on the preferred pack, so
doing so would have little point.

[^1]: Because write_reused_pack_verbatim() only reuses bits in the range

    off_t pack_start_off = pack_pos_to_offset(reuse_packfile->p, 0);
    off_t pack_end_off = pack_pos_to_offset(reuse_packfile->p,
                                            pos - reuse_packfile->bitmap_pos);

    written += pos - reuse_packfile->bitmap_pos;

    /* We're recording one chunk, not one object. */
    record_reused_object(pack_start_off,
                         pack_start_off - (hashfile_total(out) - pack_start));

  , or in other words excluding the object beginning at position 'pos -
  reuse_packfile->bitmap_pos' in the source pack. But since
  reuse_packfile->bitmap_pos is '1' in the non-preferred pack
  (accounting for the single-object pack which is preferred), we don't
  actually copy the bytes from the last object.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5332-multi-pack-reuse.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/t/t5332-multi-pack-reuse.sh b/t/t5332-multi-pack-reuse.sh
index 955ea42769b..8f403d9fdaa 100755
--- a/t/t5332-multi-pack-reuse.sh
+++ b/t/t5332-multi-pack-reuse.sh
@@ -259,4 +259,27 @@ test_expect_success 'duplicate objects' '
 	)
 '
 
+test_expect_failure 'duplicate objects with verbatim reuse' '
+	git init duplicate-objects-verbatim &&
+	(
+		cd duplicate-objects-verbatim &&
+
+		git config pack.allowPackReuse multi &&
+
+		test_commit_bulk 64 &&
+
+		# take the first object from the main pack...
+		git show-index <$(ls $packdir/pack-*.idx) >obj.raw &&
+		sort -nk1 <obj.raw | head -n1 | cut -d" " -f2 >in &&
+
+		# ...and create a separate pack containing just that object
+		p="$(git pack-objects $packdir/pack <in)" &&
+		git show-index <$packdir/pack-$p.idx &&
+
+		git multi-pack-index write --bitmap --preferred-pack=pack-$p.idx &&
+
+		test_pack_objects_reused_all 192 2
+	)
+'
+
 test_done
-- 
2.46.0.421.g159f2d50e75

