Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47DE226D07
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493392; cv=none; b=tY+slP6L0MAJYECjBf4kIrXDfh9eq2jVYyVybUA3Ngk3pCsInlDROoZZwVhMgXBA3JoYXtdtuvSv8OSdkOUP4b6mbPVlKojimaRk2KkpyBrwBkrhpnOxCz2DDnsZnQOoPDmReFgVudk+mAmstg2OaHkH8xcaH/8nWLT3I1SPEm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493392; c=relaxed/simple;
	bh=f3AV+8otO5hbjxB/NdrYS7Ir6wA65aLzOGBbJaQrjPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFxNWPCBVUMbWZqM9ifHdfI8xNguSKHMy6FL1GPmNNlDTyDhGfo2IY4aIvi6WYIjG/y7ep6bO/yLWfYepnWkQ4gfzRWhJrdKjaGevZIjjrcJJ/mfEqG0n1WYozpTCw3SOxMfXwi2bh6Fkl6oid1UL1cLdDow9U0K0gwuiJm/ArM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=wwwWuRbT; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="wwwWuRbT"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46c8474d8daso10038511cf.3
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 10:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742493389; x=1743098189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NpfHGMLFzmBBNjIAqUnwos+XwPk7NDi9WzmE3kCQHn0=;
        b=wwwWuRbT2/yDQueE7RchcPS/0Jwhm44OrBnra9vo2O6D8xThNDVdgw3dLRJm0tL5b+
         aBR8m1Vbif7oGPeVkS2rAY12G11oafXSzsGSJInH7AAuSJdX2rBgurKyOg8zBliEfsJi
         cakSqg3V5bxRw9B5O4Nnc7icNU7OO2o9ePorIWEVoyFb8EeKs0LQG3GSS6vw8soczhS+
         ONdRmIIPJiKiAXMzcUiWsHQWtvOU+N+KwmurqgtKbLc1cLt74BKd7QRshA5uMjjoV3du
         wpWWnBY5h2PXLasRuUBSE5/jd6ZnKhoz+YMlZQeDMdLejSmaiPQQ/O0hDWnjEInlNZtu
         9qag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742493389; x=1743098189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpfHGMLFzmBBNjIAqUnwos+XwPk7NDi9WzmE3kCQHn0=;
        b=uEZ/qOVmT7VkcnV0XVef4WeQQnF3uMX5FrndXabUaUTsx3f4eG6QZ+6zRIhI4Ig5zX
         ao0ll3X4aX3SMvNlbLIpT1knAy2s6l7Vp0Nv9v7GPOdr1rG8nErKI7Tvn2YfQ6Wkkpth
         VEzhFgZ1KB3LiQxdJjRtz05I7QGkBitGi9Ca2DsAnWeyuqAdOUCMRLPu8BeVhp21hGgP
         ownJGkoZPi/4nc4uMPtW3lxxNqEX3vLAZ/9U9yzw1cGYcuBvPE9ajaC2N1SudakmBzm1
         2yipu4QXjVMZbEZwdfKgDNNftYNfjHBw9+g7L2mDxq7RGwxjmPJH0XW1Ds+ikUsS5Zby
         8Kdg==
X-Gm-Message-State: AOJu0YyRamjeDd9AEaviLnJYXUSOBz6zXtv+RT1RU+sp+I4ffZSHDN1b
	qvWO4XUDhb0fg/IxlMnjzA3eXYBFZcH1yMAmy8sOYv41wlZjxPHJCCLJrAhStiyvQv59eEdHiaq
	Qbis=
X-Gm-Gg: ASbGncuteWHCLZ8cs0AiKrq8tbEHsCKVSh6AYli1DCipGzuQTrVRWwsf8Zz2m+/Ricd
	Tyv2Gk1yiAhNe8X4yHLWb8SVgcBHjoEsfINIFFwmmN05Jtm4g9RAqihArQaXyZ1RZMxjOAC8KEH
	dRl2iIoWC0dyFeT651TfEHiutS/8D9o7i8DVHhr3O1XNbjk8vrEFx1awOylzZCT4A30aXVhXF+3
	UQMmlExMsmWZAGk1HVtCGN1QvGzc8L3dx3bAHU8bP0Q/CK0TnIqvwY+WcT8JRbGti4yHrUpNZrP
	RZkCADINkg35wA3dC5Zhfqr9o0xrPyoR80t589VjMammRCjvGLUHdswY8zW31WLWjTcWSe8rrIw
	Lt+uZpGtrCimInYNa
X-Google-Smtp-Source: AGHT+IFeePsiH4nbS6Ked9Kfp3bYcKP50HgQPjVpKLWr/gcuBUvyDwACWi6xwvDaNCIWlvn75sjPIA==
X-Received: by 2002:a05:622a:22a5:b0:476:aa7a:2f78 with SMTP id d75a77b69052e-4771de5b160mr3130441cf.49.1742493389658;
        Thu, 20 Mar 2025 10:56:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c5b92d6883sm16219385a.45.2025.03.20.10.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 10:56:29 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:56:28 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 02/14] Documentation: describe incremental MIDX bitmaps
Message-ID: <0897359506211b407c173e50007555e7de083342.1742493373.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1742493373.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742493373.git.me@ttaylorr.com>

Prepare to implement support for reachability bitmaps for the new
incremental multi-pack index (MIDX) feature over the following commits.

This commit begins by first describing the relevant format and usage
details for incremental MIDX bitmaps.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/technical/multi-pack-index.adoc | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/Documentation/technical/multi-pack-index.adoc b/Documentation/technical/multi-pack-index.adoc
index dea6486f88..ffda70aa13 100644
--- a/Documentation/technical/multi-pack-index.adoc
+++ b/Documentation/technical/multi-pack-index.adoc
@@ -164,6 +164,78 @@ objects_nr($H2) + objects_nr($H1) + i
 (in the C implementation, this is often computed as `i +
 m->num_objects_in_base`).
 
+=== Pseudo-pack order for incremental MIDXs
+
+The original implementation of multi-pack reachability bitmaps defined
+the pseudo-pack order in linkgit:gitformat-pack[5] (see the section
+titled "multi-pack-index reverse indexes") roughly as follows:
+
+____
+In short, a MIDX's pseudo-pack is the de-duplicated concatenation of
+objects in packs stored by the MIDX, laid out in pack order, and the
+packs arranged in MIDX order (with the preferred pack coming first).
+____
+
+In the incremental MIDX design, we extend this definition to include
+objects from multiple layers of the MIDX chain. The pseudo-pack order
+for incremental MIDXs is determined by concatenating the pseudo-pack
+ordering for each layer of the MIDX chain in order. Formally two objects
+`o1` and `o2` are compared as follows:
+
+1. If `o1` appears in an earlier layer of the MIDX chain than `o2`, then
+  `o1` sorts ahead of `o2`.
+
+2. Otherwise, if `o1` and `o2` appear in the same MIDX layer, and that
+   MIDX layer has no base, then if one of `pack(o1)` and `pack(o2)` is
+   preferred and the other is not, then the preferred one sorts ahead of
+   the non-preferred one. If there is a base layer (i.e. the MIDX layer
+   is not the first layer in the chain), then if `pack(o1)` appears
+   earlier in that MIDX layer's pack order, then `o1` sorts ahead of
+   `o2`. Likewise if `pack(o2)` appears earlier, then the opposite is
+   true.
+
+3. Otherwise, `o1` and `o2` appear in the same pack, and thus in the
+   same MIDX layer. Sort `o1` and `o2` by their offset within their
+   containing packfile.
+
+Note that the preferred pack is a property of the MIDX chain, not the
+individual layers themselves. Fundamentally we could introduce a
+per-layer preferred pack, but this is less relevant now that we can
+perform multi-pack reuse across the set of packs in a MIDX.
+
+=== Reachability bitmaps and incremental MIDXs
+
+Each layer of an incremental MIDX chain may have its objects (and the
+objects from any previous layer in the same MIDX chain) represented in
+its own `*.bitmap` file.
+
+The structure of a `*.bitmap` file belonging to an incremental MIDX
+chain is identical to that of a non-incremental MIDX bitmap, or a
+classic single-pack bitmap. Since objects are added to the end of the
+incremental MIDX's pseudo-pack order (see above), it is possible to
+extend a bitmap when appending to the end of a MIDX chain.
+
+(Note: it is possible likewise to compress a contiguous sequence of MIDX
+incremental layers, and their `*.bitmap` files into a single layer and
+`*.bitmap`, but this is not yet implemented.)
+
+The object positions used are global within the pseudo-pack order, so
+subsequent layers will have, for example, `m->num_objects_in_base`
+number of `0` bits in each of their four type bitmaps. This follows from
+the fact that we only write type bitmap entries for objects present in
+the layer immediately corresponding to the bitmap).
+
+Note also that only the bitmap pertaining to the most recent layer in an
+incremental MIDX chain is used to store reachability information about
+the interesting and uninteresting objects in a reachability query.
+Earlier bitmap layers are only used to look up commit and pseudo-merge
+bitmaps from that layer, as well as the type-level bitmaps for objects
+in that layer.
+
+To simplify the implementation, type-level bitmaps are iterated
+simultaneously, and their results are OR'd together to avoid recursively
+calling internal bitmap functions.
+
 Future Work
 -----------
 
-- 
2.49.0.14.g88b49c1b34

