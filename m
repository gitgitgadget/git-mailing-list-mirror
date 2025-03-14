Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADFA2054F3
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 20:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983522; cv=none; b=XdrEE9XJ++muyr7CIyU+/IoLdUQAXI6mH/rY2y/Soa7ALI0x5Y/vnz9sYRLQt8DrFpHn7Hlrd8DzyKJuCVw6bbm5aGn7bOElhRT/EG2LO5iFpTAVcpPxxIG5o/MXH3fYP2MM5GMSy2uepUACZ6rTk1d79f5TaUq08ApIIQRye+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983522; c=relaxed/simple;
	bh=KM2bJA0MViNUnwdYT0Bz58VxPzDp7jMGau/ps4mS4+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQ3epPiWvZxrYxEyxM3GeX4uBbrupY01FBLiyLFbdDaVtsB6yPK4w8Xr56ilRnFoFsT1hYogemt1aEVL+2JeQ4i3hxAfEWtJfytNqEH0WeI18TgO/8A5wN1gwoc8452EfI33frmJfM+71b/If9RdFsBgclYx6oXTQ9l1Ko8KXsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=1F+5CEzS; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="1F+5CEzS"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e91d323346so26834656d6.1
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 13:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741983520; x=1742588320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kP2Cp4/Wu0NP1Cmz9gq1/23FRXWJPZdjWHo2ATLqG3Q=;
        b=1F+5CEzSg15IulRDEuA16DSU0A/Ix7CPVmker9Bv821bAr5YHJZH7ZwWWqbNgi9hQ8
         wyDWhvRCCLGO476UpG5LNzbbS7mNC7jlMRnCfcRThqlrVB2kafSGwG6eoKZKYzRiNHNO
         qpw0N1eqbbdO69evaN0T0Sfr6qtpi8DrihyHOGwr+gMU52/spY4Iu7xqEmevcNbJ54N4
         EITIvEyC9x8xw7TQPCvEZrDwDUpHx1LJhtW13HTANcOd/w62gfoWc2VNGX0PFLnT13pI
         GjSlvP454gTNt2g+WvwnBIQKjqm6RAFYls20H4SsQSxhjkfzEQC0mGVAqzT8VaMWsu3/
         im7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741983520; x=1742588320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kP2Cp4/Wu0NP1Cmz9gq1/23FRXWJPZdjWHo2ATLqG3Q=;
        b=DLOqhRIyV8/0u0zML6mnBnkta9RXPZ1sG5WAmjUqIcsYekmgMCAl3WbDTbWJmT+bzz
         DLNd+JIyZxhQd8IrlHeII5nZZjSidmXtiWgVwEDRxjK+oIsftXoiXnWiFkkzCoXxgGC0
         ZRR7uj8LR4fnwYIYjsDrQUBPO/LHZKHRsjpvt7eOZS5gWV3jMw4E4xbzaAdmLx1qjgcd
         rfpi+SufQ7r48ZcDQHVXIqha0ztbbIPG9dzl7jWPIaEGegavwQrdS72s/wLCJcYA92zI
         gg1ms3Cw2g2tJV8mV7UsTdHziKu4Yo8dz+D9D2vFmV7KWiJmYfmarJFv+7fCOtLVimXv
         U+4g==
X-Gm-Message-State: AOJu0YxwPzSeHVfUslH7BZRjj2UKK5Yz/yiDsXJ5Zu9iouBL7BBUa+01
	KF+Mth7akQOuLA2Ylf/A66H1/B+py3nyjrdieQSJVWuIoMLvunU+u2clxi1NjIPm1Px+J/BE5rT
	BDe4=
X-Gm-Gg: ASbGncvMKSgHcn5e1kTOkkwIlgVC8rdOY5TdJXRDv0gxiD9UFbFjbuOJcKaOeusgUp0
	mJ/g0dn3YbRh0/5hn+iyFVO65qsa/6t5sjBkWpiRqItDmU76M4QxzJvNsbJwe0fps1lA5hp8x3o
	ev4i4OoVgRk2pZ7iPX+bCuPPhpoyHyl1EH7VqOZ/GaJO8GX5zUAS3P94/LFkERvYkDAeIdkaa6w
	VrGQx7/oV87xh3QRzcGY3Kl5uW61f+bG9TG/YiOamx7s3jH06JROYOhOZhX7fwZ6cTCr6sp2AT9
	Kpf8l5QEatOvJ8rve+QT1kr440nzismQPQJf4kTEob+pWVhlVjmiFgp6eD5N/FGKYzUbN7XHDI8
	PYy2BJGpiepaMx7h7
X-Google-Smtp-Source: AGHT+IGBQJCpYZ5N4TQlhEu+xSIy20+lq30heDAmGZezrBxqeZeWhkoTtZSDUu2Aso5lKhd/kpq5cQ==
X-Received: by 2002:ad4:5c49:0:b0:6e2:4da9:4e2d with SMTP id 6a1803df08f44-6eaeac211b7mr51370116d6.9.1741983519053;
        Fri, 14 Mar 2025 13:18:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade209bcdsm28018196d6.24.2025.03.14.13.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 13:18:38 -0700 (PDT)
Date: Fri, 14 Mar 2025 16:18:37 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 06/13] pack-bitmap.c: support bitmap pack-reuse with
 incremental MIDXs
Message-ID: <14d3d80c3d301233048004fe9de18154aa597782.1741983492.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1741983492.git.me@ttaylorr.com>

In a similar fashion as previous commits in the first phase of
incremental MIDXs, enumerate not just the packs in the current
incremental MIDX layer, but previous ones as well.

Likewise, in reuse_partial_packfile_from_bitmap(), when reusing only a
single pack from a MIDX, use the oldest layer's preferred pack as it is
likely to contain the most amount of reusable sections.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 1b4fec0033..7a41535425 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2333,7 +2333,8 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 		multi_pack_reuse = 0;
 
 	if (multi_pack_reuse) {
-		for (i = 0; i < bitmap_git->midx->num_packs; i++) {
+		struct multi_pack_index *m = bitmap_git->midx;
+		for (i = 0; i < m->num_packs + m->num_packs_in_base; i++) {
 			struct bitmapped_pack pack;
 			if (nth_bitmapped_pack(r, bitmap_git->midx, &pack, i) < 0) {
 				warning(_("unable to load pack: '%s', disabling pack-reuse"),
@@ -2359,14 +2360,18 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 		uint32_t pack_int_id;
 
 		if (bitmap_is_midx(bitmap_git)) {
+			struct multi_pack_index *m = bitmap_git->midx;
 			uint32_t preferred_pack_pos;
 
-			if (midx_preferred_pack(bitmap_git->midx, &preferred_pack_pos) < 0) {
+			while (m->base_midx)
+				m = m->base_midx;
+
+			if (midx_preferred_pack(m, &preferred_pack_pos) < 0) {
 				warning(_("unable to compute preferred pack, disabling pack-reuse"));
 				return;
 			}
 
-			pack = bitmap_git->midx->packs[preferred_pack_pos];
+			pack = nth_midxed_pack(m, preferred_pack_pos);
 			pack_int_id = preferred_pack_pos;
 		} else {
 			pack = bitmap_git->pack;
-- 
2.49.0.13.gd0d564685b

