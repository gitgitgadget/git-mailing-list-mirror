Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0D350288
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126905; cv=none; b=oAyPZHLXlkBzb8VQFA5TXWTzKzKVrfyqpMQTJ+QuPfYv5piDJiqsRV7cspeHLt4Sm+ei+ZumUAN8R50OIZFYHtBepanWbzZLzYZRQy3H70FB6UYLDeKAegsY63STIaX56m3/nUjT7qNyi1bpc/rpFodRKVEBL+97hX7NocGUXmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126905; c=relaxed/simple;
	bh=PhmIDP5ZiYDYtXxjJf3gpifdPLPgLxwKlFBfQEaedJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0VTBNoGa41bj5Ht1MA21V3Jcu7I482XFWCJsOftmmSJHh+PbvAVSo3+gQuk3rcnakSUOLum/NmY7Saw7ZOQ07HIUkk6khS+dd3eU2GILstvPkJcZbcTjby7/D60rpOHEdYwfEyxmViH+aUBZbWghPfB2XVyyJ+rDJO/dC3VNRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=sF5qefpw; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="sF5qefpw"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c9d70d93dbso803464b6e.3
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 10:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1718126902; x=1718731702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8YcLbpeKjhu5qvhoyBdbNqko79CkOovb0dIE/2i/IVE=;
        b=sF5qefpw7sBHQcxvX3Izi40EK7zXg8nvmTAnZU2LjGNHG+KiOYycvYpyj11uV1j1kX
         xhIoi7KCtp5gFZRUjLKtQ3epSG3YYysjpj9e5IthwDSjwZas08K+yhHrOXyT+q2X1EGK
         G5vLCbsddaD+xag335KE4u1MlCIMS8wcBLp5iwbLOBsKp928KCpu/jer20DVrfzN6WzV
         SIl21/kkZZLKvwLjnujcU0u/qkn2qeDErsy27QmEckqxp+AadP0JFslg0hzsa14gHmBJ
         9C3VzOLxITZJCRnZW+O0pEcd9OnJ3UGjl909zF7OSsMhS3jM42yLxEgttWVIGSQDQ4uR
         NXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718126902; x=1718731702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YcLbpeKjhu5qvhoyBdbNqko79CkOovb0dIE/2i/IVE=;
        b=lz4DbB7YuOxxG9n8l4Thg8mufDqUoKThuVQz9Xc6hqhR/SkkcKGT2K2kKoRHmqCOHJ
         oVWPYBF9qMCkxp/lqfCnWzKTFZHpbJMAOydlV8//s+fDafaSD78IxS26tAfjUiAdzIOH
         lvp0XuCdDDUSNh73ER0WR2yXkM416UzUfReKEnwmKHjCL/iwRVucShJMxdLJFPX4C5tO
         xj7gz3AEdo4rFfE6ljiTVTb4EWoJAieF/7CKFr7v3EyB5k7D70xL9fEp/09iFe44INuf
         5o4zV2Mgs8gjBbC/QN6TCNBzVn8o6L4moZwmj96vjt8uxiEW/Lbcw0ZKX9Af0ZYe0WhS
         rCTQ==
X-Gm-Message-State: AOJu0Yy8pOLU74RZC8EUHqxKwQ7l01YES/8q0yWwJYNBH/sCx0I7GALi
	fih9Gg+/UjxIhmbf8uwwla6EaqK78LZ0lZqG8xwLuY9bma2vbwr9Mof3iLctzc2I1GnDqmnNsHa
	L+P0=
X-Google-Smtp-Source: AGHT+IEDT9G33o+fwWfpjUQQPN5o4bLwgqCck5iL/WVMhYbjFffzISzTpsHNqcQ3xTSk0aDU4gG0Zw==
X-Received: by 2002:a05:6808:1307:b0:3d2:1ddf:862c with SMTP id 5614622812f47-3d21ddf86admr11428562b6e.2.1718126902404;
        Tue, 11 Jun 2024 10:28:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7955e3451a6sm256195985a.128.2024.06.11.10.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 10:28:22 -0700 (PDT)
Date: Tue, 11 Jun 2024 13:28:20 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 2/3] pack-bitmap.c: avoid uninitialized `pack_int_id`
 during reuse
Message-ID: <4b006f44a53fb8e0a27a89b78e43a5ef225cebb8.1718126886.git.me@ttaylorr.com>
References: <4aceb9233ed24fb1e1a324a77b665eea2cf22b39.1717946847.git.me@ttaylorr.com>
 <cover.1718126886.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1718126886.git.me@ttaylorr.com>

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
preferred pack's pack_int_id, or '-1', in the case of single-pack
bitmaps.  In the latter case, we never read the pack_int_id field, so
the choice of '-1' is intentional as a "garbage in, garbage out"
measure.

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
 pack-bitmap.c               | 13 +++++++++++++
 t/t5332-multi-pack-reuse.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index fe8e8a51d3..1d6b7f2826 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2073,6 +2073,7 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 		QSORT(packs, packs_nr, bitmapped_pack_cmp);
 	} else {
 		struct packed_git *pack;
+		uint32_t pack_int_id;
 
 		if (bitmap_is_midx(bitmap_git)) {
 			uint32_t preferred_pack_pos;
@@ -2083,12 +2084,24 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
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
+			 *
+			 * Use '-1' as a sentinel value to make it clear
+			 * that we do not expect to read this field.
+			 */
+			pack_int_id = -1;
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
2.45.2.448.g06de4005f1

