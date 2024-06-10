Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C8D14F9F3
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 20:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718050257; cv=none; b=YvUWI8SepDvwucrj97rFiXheL6/wYNS8vrNQTdzCw/4vW26NqPMouYPEFvi/mxR9R4Jij+iR1+7bGZm/s+0Sh0agRV9ynuWKc3NmmsZuYtgXQ8S3o1n+XKUlckaKSVRp8uqhfNCgD/9nesVGAQxMpIvzqIi31KRg2vFUAnA0zlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718050257; c=relaxed/simple;
	bh=W16oYFJANyV3wznygtJUE7HwNtDrAAtCVOm062LhO44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWTKbYRbG50Xnadh8S4+eJMmTk+T04XGHvMKMII4OlK42p7UhwFZhekmoB5UtrBzAoQIuS2ctYOlYt3Xbc02BUCrpCkYzKiM+IR6IxOXLky1fhpvYOiTeQdpIofiCVCWEecA2x2u/fXWRffwJfIVAA/6RZXS5bDxytKX9uNbLsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=1DdDOkDR; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="1DdDOkDR"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c9b94951cfso2805710b6e.3
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 13:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1718050255; x=1718655055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=381zQgZH8a+V2M4tHyEJzLE15vxwNRilN4ptupM0eaU=;
        b=1DdDOkDROk/UW+aBZYfRtbEbrsK4yAERcmu6aJIYfOX83LGGfa3Zrlh/sfiLHIGK26
         9U1GDYqwUdDipyXtYQoKeTsKb0EsWENfcE8YscJPseyYpDkmegqzNZ6Q1YazYvCk/kCL
         Obj0AmD9e5ZCndPpvNPjsJBXEc0d6i+AngfFlqRUfn4YrX7aV62DwXv5F55vbtD0n+8y
         /mh/WVWYx3o5Neuz3DUOx0F9IWMgSEyieKiLOJXaUwOPYKJ9G24+um5L6qKEe3w2gKlQ
         woKyaF0YN/xMWtZYcLJjlyvkjhYyXmRinx18nA1Ch03SEiPhltgV5NRawe0J5pFFbYuV
         GMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718050255; x=1718655055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=381zQgZH8a+V2M4tHyEJzLE15vxwNRilN4ptupM0eaU=;
        b=mZSBF3I938AJR1jcOYH6PBXhKBr8/sk7BA0wCZQTRXrQ8vj3pCLeY/vNFb69Sl+0g2
         iJBzEe3YSix0ItTrk+jjU1RRpKAcRIvVSSBCMGUvX5IYg4a15ysnQTijOLYr2YTg1Voa
         K2+sdPRRD6qz/peXoQsVYjxNA8KC3WgZJyvRw7oAPKGnHkvVVdP+SpuL9OkeKxx3rMwi
         nMDccnFifrnnp8FG+rILdPxkJby9+etYV64hOeXUNuN/Bb3baeoGY9lgGWTHo+zyedtU
         /Zjuw00s7+MVasNsUCpE2uq0KqqhFlVJCGl7t5WV0F9xb/o0+4iET9LVjGOCOzMXJA40
         7P7Q==
X-Gm-Message-State: AOJu0YwxkWhrVPiFSeFTg1iiMWz2YToIu1XEJiWYBsQ1ud3KZbMeWTn9
	s26cbVWezoHnwW28AvKx+M1D4DYTI6Zr5xHirwrRrov5G9ecP/Oo6YnuUw/31YcgAsaHvGF6ER8
	iCWc=
X-Google-Smtp-Source: AGHT+IFTaR84WSb9RW4KTQ62YoOoD2NNNOSgx2s3IxlcCpeSKouVFCufdcVmAmfMvP+tYkf5VHIfPA==
X-Received: by 2002:a05:6808:1385:b0:3d2:1503:6ca5 with SMTP id 5614622812f47-3d2150371c5mr11801393b6e.26.1718050254993;
        Mon, 10 Jun 2024 13:10:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795499515adsm317767485a.103.2024.06.10.13.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 13:10:54 -0700 (PDT)
Date: Mon, 10 Jun 2024 16:10:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 2/3] pack-bitmap.c: avoid uninitialized `pack_int_id`
 during reuse
Message-ID: <a3c28f12020712818060bd50d1483507c9b11556.1718050244.git.me@ttaylorr.com>
References: <4aceb9233ed24fb1e1a324a77b665eea2cf22b39.1717946847.git.me@ttaylorr.com>
 <cover.1718050244.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1718050244.git.me@ttaylorr.com>

When performing multi-pack reuse, reuse_partial_packfile_from_bitmap()
is responsible for generating an array of bitmapped_pack structs from
which to perform reuse.

In the multi-pack case, we loop over the MIDXs packs and copy the result
of calling `nth_bitmapped_pack()` to construct the list of reusable
paths.

But we may also want to do pack-reuse over a single pack, either because
we only had one pack to perform reuse over (in the case of single-pack
bitmaps), or because we explicitly asked to do single pack reuse even
with a MIDX[^1].

When this is the case, the array we generate of reusable packs contains
only a single element, which is either (a) the pack attached to the
single-pack bitmap, or (b) the MIDX's preferred pack.

In 795006fff4 (pack-bitmap: gracefully handle missing BTMP chunks,
2024-04-15), we refactored the reuse_partial_packfile_from_bitmap()
function and stopped assigning the pack_int_id field when reusing only
the MIDX's preferred pack. This results in an uninitialized read down in
try_partial_reuse() like so:

    ==7474==WARNING: MemorySanitizer: use-of-uninitialized-value
    #0 0x55c5cd191dde in try_partial_reuse pack-bitmap.c:1887:8
    #1 0x55c5cd191dde in reuse_partial_packfile_from_bitmap_1 pack-bitmap.c:2001:8
    #2 0x55c5cd191dde in reuse_partial_packfile_from_bitmap pack-bitmap.c:2105:3
    #3 0x55c5cce0bd0e in get_object_list_from_bitmap builtin/pack-objects.c:4043:3
    #4 0x55c5cce0bd0e in get_object_list builtin/pack-objects.c:4156:27
    #5 0x55c5cce0bd0e in cmd_pack_objects builtin/pack-objects.c:4596:3
    #6 0x55c5ccc8fac8 in run_builtin git.c:474:11

which happens when try_partial_reuse() tries to call
midx_pair_to_pack_pos() when it tries to reject cross-pack deltas.

Avoid the uninitialized read by ensuring that the pack_int_id field is
set in the single-pack reuse case by setting it to either the MIDX
preferred pack's pack_int_id, or '0', in the case of single-pack
bitmaps.  In the latter case, we never read the pack_int_id field, so
the choice of '0' is arbitrary.

Guard against further regressions in this area by adding a test which
ensures that we do not throw out deltas from the preferred pack as
"cross-pack" due to an uninitialized pack_int_id.

[^1]: This can happen for a couple of reasons, either because the
  repository is configured with 'pack.allowPackReuse=(true|single)', or
  because the MIDX was generated prior to the introduction of the BTMP
  chunk, which contains information necessary to perform multi-pack
  reuse.

Reported-by: Kyle Lippincott <spectral@google.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c               | 10 ++++++++++
 t/t5332-multi-pack-reuse.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index fe8e8a51d3..8b9a2c698f 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2073,6 +2073,7 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 		QSORT(packs, packs_nr, bitmapped_pack_cmp);
 	} else {
 		struct packed_git *pack;
+		uint32_t pack_int_id;
 
 		if (bitmap_is_midx(bitmap_git)) {
 			uint32_t preferred_pack_pos;
@@ -2083,12 +2084,21 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 			}
 
 			pack = bitmap_git->midx->packs[preferred_pack_pos];
+			pack_int_id = preferred_pack_pos;
 		} else {
 			pack = bitmap_git->pack;
+			/*
+			 * Any value for 'pack_int_id' will do here. When we
+			 * process the pack via try_partial_reuse(), we won't
+			 * use the `pack_int_id` field since we have a non-MIDX
+			 * bitmap.
+			 */
+			pack_int_id = 0;
 		}
 
 		ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
 		packs[packs_nr].p = pack;
+		packs[packs_nr].pack_int_id = pack_int_id;
 		packs[packs_nr].bitmap_nr = pack->num_objects;
 		packs[packs_nr].bitmap_pos = 0;
 
diff --git a/t/t5332-multi-pack-reuse.sh b/t/t5332-multi-pack-reuse.sh
index 3c20738bce..ed823f37bc 100755
--- a/t/t5332-multi-pack-reuse.sh
+++ b/t/t5332-multi-pack-reuse.sh
@@ -204,4 +204,30 @@ test_expect_success 'omit delta from uninteresting base (cross pack)' '
 	test_pack_objects_reused_all $(($objects_nr - 1)) $packs_nr
 '
 
+test_expect_success 'non-omitted delta in MIDX preferred pack' '
+	test_config pack.allowPackReuse single &&
+
+	cat >p1.objects <<-EOF &&
+	$(git rev-parse $base)
+	^$(git rev-parse $delta^)
+	EOF
+	cat >p2.objects <<-EOF &&
+	$(git rev-parse F)
+	EOF
+
+	p1="$(git pack-objects --revs $packdir/pack <p1.objects)" &&
+	p2="$(git pack-objects --revs $packdir/pack <p2.objects)" &&
+
+	cat >in <<-EOF &&
+	pack-$p1.idx
+	pack-$p2.idx
+	EOF
+	git multi-pack-index write --bitmap --stdin-packs \
+		--preferred-pack=pack-$p1.pack <in &&
+
+	git show-index <$packdir/pack-$p1.idx >expect &&
+
+	test_pack_objects_reused_all $(wc -l <expect) 1
+'
+
 test_done
-- 
2.45.2.447.g6b4ffca7ec.dirty

