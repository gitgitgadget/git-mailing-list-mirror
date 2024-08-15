Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA34C14C5AF
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 21:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723755686; cv=none; b=rn9UrdXBU8wEtF89a1grQxXV4UV3DbzLGn/OhS1wVmXeOqk26tUOr1Uh34cSi6D/hgUMR2gGMN60lABrwC+K8WTsyw4hyJmg+phg2eRenK92lUFU8GreLv2NMnhiGBHJThpmOWNoMGR1nq55OKGBuCh/KBvFcCcGiGvjXBHiF/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723755686; c=relaxed/simple;
	bh=9gI9tFmb5lm+kC+z3qm2I4abJzeJzffegyYeKYhwSHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jh6RnFIAuUCVvnPjcceQ9tkiPL/R43MZZM2pdUe64VgdqNaDY5Ypoq6cF6ITv4gUnnDCWwKgl5FLd6rpfj6vuaxpFXdamj27LfWEKBQ7g0/M/XfmD87c5cZK8XIak8MX/rgaJqV3QGniUazX0h5OBsUDF9qHS/mleHd/OunWRZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=bfn5iRqY; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="bfn5iRqY"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso1324315276.1
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 14:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723755683; x=1724360483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NqThN4qbfvU+1vWMgiwXaIfvuShsSgAKF1gC3+o4HU4=;
        b=bfn5iRqYaQ97n0rpRHLoS1PdzV413YCP2njkj8xESGjLMLfwCgS5mzdT9nCB14NT3Y
         8zW2d+hnXNLke1l2Us+dyPFrk+FORIlitf9sp7m2KnXZFzVw420upv+Rhak4p8AUjJ7P
         /pjMYKAc8Qz7/8bhp194h1++vrLRVPxzqr+ZZxi2o7DCW34oZSFhhNah3cod4MqJ54WF
         Serxut2lhLnl/cWB18FdoV4WT7lxhOpDrTZTfRl/smi9W/LFUr98QmUQEdbYiGYRTfFT
         3G6m39XE3sAQkzXHsfuUSDeI2jgKhune9cEl6cSk3rpQ0lfL/eopqDw473xDVZiSMnde
         VOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723755683; x=1724360483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqThN4qbfvU+1vWMgiwXaIfvuShsSgAKF1gC3+o4HU4=;
        b=opGugF3fvzuWX08mfA/ABkO07s/UPrkiFkC0JrMssMlBi8lSVDJJ0nvS+gaI9X9+Re
         FWVHPLhKd5dBJSk0WyvCfDuRAeRmQTb2o/9GvqunZntr3Pl9YBJHwGMZMS9aUTEtCxBq
         3SrG5lC5+k3Usv159RRCVVg9Jj+oL1RS2SVo4vhU72XDei5XWfV7g12nWDo+sqdAlTaM
         PtX77Et4x3+1JlcNuFOoOs9/dxehXx59QKqnCjSiHtwc5MQFs0rk21mLCnP5I+sZydia
         OaphTcC9SYraZEVkaa2TNYynlOLnLKQzxXrFXXSpQrff4feKH4Ibvbszlx5mBNb5xVKi
         6IvQ==
X-Gm-Message-State: AOJu0YxIfhsGmnzjsdU42ebNkEBnH6r3y5oLBNv7iazC/sNw7/FX1ZD7
	I6WNhl0Cy1ny++xrROZV5rNFPaNzdhD8mcUGzhTaedpD+xsAQ6EVBBXi2CHI1B7BJk+rg32Tykw
	A
X-Google-Smtp-Source: AGHT+IF4Qr3lCNO/3KlL1oX/bDjo8ZAABb3h65S+IkKlLg3QdMTHXpP6s36Z/oDAxfzcMtxOaV4xew==
X-Received: by 2002:a05:6902:2382:b0:e11:3f5d:9e3d with SMTP id 3f1490d57ef6-e1180f72076mr988298276.37.1723755683277;
        Thu, 15 Aug 2024 14:01:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1171e6ffb6sm467859276.32.2024.08.15.14.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:01:22 -0700 (PDT)
Date: Thu, 15 Aug 2024 17:01:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 01/13] Documentation: describe incremental MIDX bitmaps
Message-ID: <d1b8d11b37fa5ef6f031d3070669a213e721bab0.1723755667.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723755667.git.me@ttaylorr.com>

Prepare to implement support for reachability bitmaps for the new
incremental multi-pack index (MIDX) feature over the following commits.

This commit begins by first describing the relevant format and usage
details for incremental MIDX bitmaps.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/technical/multi-pack-index.txt | 64 ++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/Documentation/technical/multi-pack-index.txt b/Documentation/technical/multi-pack-index.txt
index cc063b30be..a063262c36 100644
--- a/Documentation/technical/multi-pack-index.txt
+++ b/Documentation/technical/multi-pack-index.txt
@@ -164,6 +164,70 @@ objects_nr($H2) + objects_nr($H1) + i
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
+  `o1` is considered less than `o2`.
+2. Otherwise, if `o1` and `o2` appear in the same MIDX layer, and that
+  MIDX layer has no base, then If one of `pack(o1)` and `pack(o2)` is
+  preferred and the other is not, then the preferred one sorts first. If
+  there is a base layer (i.e. the MIDX layer is not the first layer in
+  the chain), then if `pack(o1)` appears earlier in that MIDX layer's
+  pack order, than `o1` is less than `o2`. Likewise if `pack(o2)`
+  appears earlier, than the opposite is true.
+3. Otherwise, `o1` and `o2` appear in the same pack, and thus in the
+  same MIDX layer. Sort `o1` and `o2` by their offset within their
+  containing packfile.
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
+incremental MIDX's pseudo-pack order (see: above), it is possible to
+extend a bitmap when appending to the end of a MIDX chain.
+
+(Note: it is possible likewise to compress a contiguous sequence of MIDX
+incremental layers, and their `*.bitmap`(s) into a single layer and
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
2.46.0.86.ge766d390f0.dirty

