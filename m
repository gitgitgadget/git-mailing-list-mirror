Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DB41D365B
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 21:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724793214; cv=none; b=D6nG5SmgdFoL2eb/cRI9mlfPrSyHulvZOlVB91IsZTujiunDS2pvefQCEmN0IpwEur2jY+YkIzxbna+r2NV5Fm7w6FWUJkCDtyqxvppjek3LCWVwBkFF4+ePT8WP1C1RiDnM+uClrrelTocZS1Qni5fOMJ5Gzend6FLE7mTWWzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724793214; c=relaxed/simple;
	bh=4f7BFNKiaLpwtNG7wPlBNb3d3L4AJMgv6HGUNOS8jgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRGOB2oBf5Mvinub6afdzOcsMvq9UPHlhJOTwxBzb4KP9x8hgwQQhl4tzt308JiZN3HsZRjv2FdBR8EZwpbSeSgmPRVa8x6Nenmz9Vn2sEl2U447DNU/Rrc1U3iQWDzQBfHyZyI48EUM/AgVRlYL6PPm7QULFbitTDeDlwl8UdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=nNADMimS; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="nNADMimS"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e0b7efa1c1bso5991016276.3
        for <git@vger.kernel.org>; Tue, 27 Aug 2024 14:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1724793212; x=1725398012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qdsoKEwEudq44U7iidyLm8TCCiWQopKX8U0EB1/XBaw=;
        b=nNADMimStx5vyhozObVeY4k2obFHDstF+urBoVsXL0mr0JBg9JFeypTeF89wYIvGKz
         fHN3usRE/gYNtdjqXNncJMOOESIbxqKNv0a39V9QFw6CSrdti9+TOnrn1U/CMsu4tWTy
         ysmMNsYdpxA8pf1iAfM4x94rMH8A50NfIaqq8criaZe1uBYT4+l1RUwvwneFlCHEvPMw
         0YiYcJOJqB6ZGvBLTfx3ICdM0TQ0kZdgvfV/CBjLv4LHTFG1PDyN8X0aamtdjruypyvF
         sNS74OnCr5H5QE14s3xoiV/RsWCn9sIQuI6yk+jticIGQW09we5V1eIVHeCtgs3lM54X
         zHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724793212; x=1725398012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdsoKEwEudq44U7iidyLm8TCCiWQopKX8U0EB1/XBaw=;
        b=S4r6aUQwk4QPzxxjIF/BcG+ry0r+S0u9w9gHtE87f3Q/9bnJYnqF8C+uPlt66zJJS1
         /nT9lddpDFWP5g6sQVYUAhIBpNc0HR7salVlIEjfuQkG/tLGQPZ8kXsMNHPez6eLjzkA
         JKo1MMZ2Q1C1iqikXrOwhh4mS+1rEVFX8NsR/uIkK6Y2nt2PgkrFfKjrFcnSOsJC1ECN
         PTwjCGd/Akd2JlGsEWTeQHwq4LSrALu96D34W5nxEwCI0xquESNzebj3SzlVgYhi88iE
         6K5q4Sx1gHN6guE9EalCzGLDs7pTsr8qU9C/dzDOw9SL9heNQ08hUVYV1xYOoeTFwGWK
         wiRA==
X-Gm-Message-State: AOJu0Yx85J6LgvBzC2+KmGUMlnGcJO/oyfmDmaaOMEIbZy2KIDeI/ooT
	qvjA93ny21iaZahBzrwB96E/GDaXqZzm/Xs3c/P3mQ8P7IwnQpb/s/rnYD+dDwLfJISqvaovjA+
	T
X-Google-Smtp-Source: AGHT+IFNPVno7J53xhNIPmL+5RqWj8CvJSXXMXS/cHb1Po/wy9Yf8e9o2qzllaDcpiA9pkkxI4/cZw==
X-Received: by 2002:a05:690c:399:b0:6c8:7827:f271 with SMTP id 00721157ae682-6c87827f682mr159640317b3.19.1724793211919;
        Tue, 27 Aug 2024 14:13:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c399cb541dsm20665597b3.21.2024.08.27.14.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 14:13:31 -0700 (PDT)
Date: Tue, 27 Aug 2024 17:13:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] pack-bitmap: tag bitmapped packs with their
 corresponding MIDX
Message-ID: <1838bbcf7fe6daa58a7db78b81a2d08138fe176e.1724793201.git.me@ttaylorr.com>
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

The next commit will need to use the bitmap's MIDX (if one exists) to
translate bit positions into pack-relative positions in the source pack.

Ordinarily, we'd use the "midx" field of the bitmap_index struct. But
since that struct is defined within pack-bitmap.c, and our caller is in
a separate compilation unit, we do not have access to the MIDX field.

Instead, add a "from_midx" field to the bitmapped_pack structure so that
we can use that piece of data from outside of pack-bitmap.c. The caller
that uses this new piece of information will be added in the following
commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c        | 1 +
 pack-bitmap.c | 1 +
 pack-bitmap.h | 1 +
 3 files changed, 3 insertions(+)

diff --git a/midx.c b/midx.c
index ca98bfd7c6..67e0d64004 100644
--- a/midx.c
+++ b/midx.c
@@ -496,6 +496,7 @@ int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
 				 MIDX_CHUNK_BITMAPPED_PACKS_WIDTH * local_pack_int_id +
 				 sizeof(uint32_t));
 	bp->pack_int_id = pack_int_id;
+	bp->from_midx = m;
 
 	return 0;
 }
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 2e657a2aa4..218d7ac2eb 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2322,6 +2322,7 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 		packs[packs_nr].pack_int_id = pack_int_id;
 		packs[packs_nr].bitmap_nr = pack->num_objects;
 		packs[packs_nr].bitmap_pos = 0;
+		packs[packs_nr].from_midx = bitmap_git->midx;
 
 		objects_nr = packs[packs_nr++].bitmap_nr;
 	}
diff --git a/pack-bitmap.h b/pack-bitmap.h
index ff0fd815b8..d7f4b8b8e9 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -60,6 +60,7 @@ struct bitmapped_pack {
 	uint32_t bitmap_pos;
 	uint32_t bitmap_nr;
 
+	struct multi_pack_index *from_midx; /* MIDX only */
 	uint32_t pack_int_id; /* MIDX only */
 };
 
-- 
2.46.0.426.g82754d92509

