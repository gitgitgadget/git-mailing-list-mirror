Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31D92046BE
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 20:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983505; cv=none; b=DoA4QbXK2jZ5JmYg34ZsXvr3iyiM7e4CEX6b+KZojcBwUJMAsy5AeVYjxDW+yubd/26svX+YfGKickcd964ROLBXrhwDzEKoWp4icW3ON1sP7xjJWKttCndEfdD276Na8H3k6H9twx5mUnFo2DtI0MXiWP3WlFmPTognbOGL24U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983505; c=relaxed/simple;
	bh=ccGhW+7vzD/TmdLOHMpdGUnkrtzVYOWB7wnQ3KraAIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yh7OazhGxfithScNRjKYlOpIpU4UIJleUuZDxhRmcEez0gm07l6MdNC1whXYEWsVU44GXI2+8yk7Tfx6LWQbameyIcZqaVTR4rkxoG7f0Ss3JBRFqSUSIt2XZUZ3SAF315RcX+g3qtxaR+RSKYPwBWhwK3JlssBYxaM8OoDlA+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=XbrAGuPV; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="XbrAGuPV"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-476af5479feso25183021cf.2
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 13:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741983502; x=1742588302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hn0FV7RzxfiyXbO1m3w7A6qXi6kVkTwOVXrDzIJAeX8=;
        b=XbrAGuPVEpuZKWSEuHlNThIukEbugj+xhPwFsqBpFGtK8iauUVRWCLkrslt7JgbsK8
         2QACKrLSfrMtN0U+kFHuSKlhfpNmgKRzG1qJTAbkttgdzohzY0NDoKx8ociGcLxyuGhN
         PyDm/EFngEV8g7xy+CxtcePduEOAt903aDn2CtcNzR2LkasIb43ylJ9BIJ7HoBIRdsPl
         nB71/fyY+mWChXEanii6Mee9hz+JXHUllP9LSFBl0plKwKMZ4yEM7CyiO8rTPHq/p2hn
         WDDVaYtQaz1+z/7+9me+23PyFOY6gUEQ6LxrdjnjpgM/WX5O06KqaZpryNiPzd95W5v2
         0/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741983502; x=1742588302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hn0FV7RzxfiyXbO1m3w7A6qXi6kVkTwOVXrDzIJAeX8=;
        b=kBBkineSrGsZMNYfb3KswJkK1XTIf36smjz9aUkvHKsdJ61xMCG8YuoPVuc11B3o19
         Q9HzoYXlqWmm8XfsyfgmwYEDT727utMoFt46QwomhTrgXj7UvZXsfYUt085dNb3cS90t
         b3jFV8XpBF4u80oc7GFvSlUxNH1z+lSiqmgeHuuXZncv+qK0E8PJj02VxmScHZgPrWcY
         oOROAwl6oleAhhekUZ0b16IpubFCbBwozizB1S3VYCY4SDlGic1s5GGzecMcg6vIou5B
         WTUxRnbspbGKttwQpY1hMYUqZkTC1t2PyGm3lqZrTYSg/x27apuRVtm17zpCtnja7N5U
         xPtQ==
X-Gm-Message-State: AOJu0YwDGJRXNkJTllcXvKr0dhLZ5wrdVVC5LfO1DHTPs4Bb2SfZGzMr
	QiMNgxG0C1RbXJBlLiY2VyONkxQ1B/PQp9a95NQmgMVug77v/oo+hktm2OxMsHzy5RFZYObYSRY
	VL8A=
X-Gm-Gg: ASbGncv7NEOuxxDLvLLN/uh8NdP0fspEg5rS8LrYkfQ4U51u5w3LkFeB2e9cBMxhzHH
	CXQjEuPUPP67ZTm1oDVWOk0e7a9ZONUVYhcXbPgaLcb398zGgUqCdvmeecOt18S5H1lpZwbvi6f
	aJnQVXviSBmeJBa3JUK1GGeqQqQQOMy7/0o/LZoOlQgfpPWJ1h4f4aziNK9Q33jrrUhXl9ceh8C
	SkAkSTZQQmJR8yV/dVYIyHpo0IvZBhkL27ZbYNzpA+l0UDSHga0C5/rTbbnOHcFRliu6vON2M3E
	DFrbgxxeek+n4oKHn0DC19WJ+O/fyngPmcx7gNnDgR0HGXXllDpGPnQTKqg7wAIruYPqulUlry3
	JDNF1F1g8DKgwUAcr
X-Google-Smtp-Source: AGHT+IHL6ZcrrJf75hCK5S+AUN1tw3rLGaXuTK4yUIoi6o7M1nYE5a6FlgGAeFlS8MfTem3fwDaW5Q==
X-Received: by 2002:a05:622a:438a:b0:476:8c58:4f69 with SMTP id d75a77b69052e-476c81330e9mr53114281cf.1.1741983502375;
        Fri, 14 Mar 2025 13:18:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb82c170sm26627901cf.77.2025.03.14.13.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 13:18:21 -0700 (PDT)
Date: Fri, 14 Mar 2025 16:18:20 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 01/13] Documentation: describe incremental MIDX bitmaps
Message-ID: <f565f2fff166bdf4bb2505f4a8853215a5365b17.1741983492.git.me@ttaylorr.com>
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

Prepare to implement support for reachability bitmaps for the new
incremental multi-pack index (MIDX) feature over the following commits.

This commit begins by first describing the relevant format and usage
details for incremental MIDX bitmaps.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/technical/multi-pack-index.adoc | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/Documentation/technical/multi-pack-index.adoc b/Documentation/technical/multi-pack-index.adoc
index cc063b30be..ab98ecfeb9 100644
--- a/Documentation/technical/multi-pack-index.adoc
+++ b/Documentation/technical/multi-pack-index.adoc
@@ -164,6 +164,77 @@ objects_nr($H2) + objects_nr($H1) + i
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
+
+2. Otherwise, if `o1` and `o2` appear in the same MIDX layer, and that
+   MIDX layer has no base, then if one of `pack(o1)` and `pack(o2)` is
+   preferred and the other is not, then the preferred one sorts first. If
+   there is a base layer (i.e. the MIDX layer is not the first layer in
+   the chain), then if `pack(o1)` appears earlier in that MIDX layer's
+   pack order, than `o1` is less than `o2`. Likewise if `pack(o2)`
+   appears earlier, than the opposite is true.
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
2.49.0.13.gd0d564685b

