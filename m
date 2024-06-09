Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4824B33C9
	for <git@vger.kernel.org>; Sun,  9 Jun 2024 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717946859; cv=none; b=bF3djlRRhzVXyC46X9A6ss8/EDEu73EsQYEdOOh+6a+DKcVIICsQr2UJ5Z9ZQcHu7JeSSYHWFxB82xXG8tsCbTv561K5HlEgeFWUco26tqpBOIYMHMY+N6xUtyiSO8RTIuTAB7WIzUGFMg5ZQlnau/dq0cWQfzG/35lo/UZ6HGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717946859; c=relaxed/simple;
	bh=wH0nwefDg+F5LMr4n4H3DwkJ3t/ZJ/hC0bafXtmfzXg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r2Uowi4rRnlLm1H5lSRmg7lsVzBIQTLiJ3I8XUEsu+OQX8Y/NiFDJG/WZcX3FX/egZIXlEZqLvdsJEF7sw+X1iNa4QyrMwF2z7piqmdkzHy7maCtpSFHFZcMNsOg+DMDNRaVl8wPuPex5mRiQjrYFdzauwM7xG+rp96uqjyZ0og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=22gpBZhY; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="22gpBZhY"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-62a145e0bb2so38665687b3.0
        for <git@vger.kernel.org>; Sun, 09 Jun 2024 08:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717946857; x=1718551657; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ECbvdl6EtSZfQJ5GaKVciW9hOOgfcYF2Yff83CQzYlk=;
        b=22gpBZhY/eZhxl4OBwvdNs/IIQt5vNKxYfXZAOca0+vx57iGdEyjrQEmzFFGc1JNOn
         LERlKtzFSUV3JBe3Oxu1qxovOUKBfW8XP3rLSaWehZ4jSsvhX1HAEa15tWidtO4DFtI3
         yTen1E34wJPVLc/7Kcc+CvXbJVO4sQcMDtOODcl2BwkwDRPwLxq8K7WmPkjvAcMTV2mX
         7gn3S9hn/AotOQMIkmFJdV52KMv97PVfGobk5J4SfLjwRDbIMjlWVypGrLzRO3hur9uf
         bu9BPsU+4n3G6akApnhYDeqGXdQNH+t88rqIUa3m6Tr8AF6/rduB7sUHY2Db270l2O19
         j0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717946857; x=1718551657;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ECbvdl6EtSZfQJ5GaKVciW9hOOgfcYF2Yff83CQzYlk=;
        b=A1Z57Yq53rxZgxTzV3geUgqjwzsdDHuIHGn0Zzui4mAkplpOeYCbb2TPwz449uexc4
         El6+opAA5/QZCnF3SxbrsnMGt9mraZm6k0LOZvNOsCKLXTIxsga46KXzU10H/3y4fjuC
         ALNOPbjGW8SDuo26lFlU7H/TYG0ZpDhNJix7Hh3Xjd70o5fI4ppfivUUhgNIsdp7zdWD
         8u/hbLsDK1BVlxv/9slw4xHW6FJP6CWFvF98Zg5/UYymKoNXTtgdFJVr0mPDNz1RhhVf
         jXoH8CcIQdyMcStYHpMUzLO67NC9GYsqMtNA2QD9shhYGjLp+CeQC/Q9lcPC1JxcsNT5
         4qng==
X-Gm-Message-State: AOJu0Yy46N9JLNCZDxEPYy6HPgM0tEmmTSrM9L0/iczrsK41uk/JDnQm
	Ab0bVjZt10Rdt+DC9R9NiKHTpL7ok1qLHitDBxnH8togQcWVi9OcbpEGWDYyGXTewgSgMpv17FP
	RYCo=
X-Google-Smtp-Source: AGHT+IE6gYVoGN3YT5IWCgKWL9kDvX2T3Ebs6D76QBAvfS75cEHzcjzfqIq3izHoI4c7Hr/oBUC13g==
X-Received: by 2002:a81:8402:0:b0:61a:e903:8d4f with SMTP id 00721157ae682-62cd5653d09mr68571347b3.37.1717946856878;
        Sun, 09 Jun 2024 08:27:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62ccad1b12csm13861987b3.64.2024.06.09.08.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 08:27:36 -0700 (PDT)
Date: Sun, 9 Jun 2024 11:27:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] pack-bitmap.c: avoid uninitialized `pack_int_id` during reuse
Message-ID: <4aceb9233ed24fb1e1a324a77b665eea2cf22b39.1717946847.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

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

[^1]: This can happen for a couple of reasons, either because the
  repository is configured with 'pack.allowPackReuse=(true|single)', or
  because the MIDX was generated prior to the introduction of the BTMP
  chunk, which contains information necessary to perform multi-pack
  reuse.

Reported-by: Kyle Lippincott <spectral@google.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

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

--
2.45.2.445.g1b76f06508
