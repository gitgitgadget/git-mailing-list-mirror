Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808141552EE
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 22:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760937; cv=none; b=GoE+gGSJoxY5Pk5s3CiCuHYSWd3in7miDywOdTxroq2LPCVYyE3sx0xCCggul+k+GHKZqn0sI5eRm7ySAALbWYUfLzTh6VobeRnkpTJnN497YOoNkT50dxnBpQxHDi36ptbC0Yx6h6qtTkYhkHzMkLTUE6frLupqlFmhse+f59M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760937; c=relaxed/simple;
	bh=9gI9tFmb5lm+kC+z3qm2I4abJzeJzffegyYeKYhwSHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghaF2/v72tGFPPOMv01iety3XgtAsxGv/GBThYYgcRAEKaZCmhSRjTmc9/u0wGLfK10KkaKabAERAL5sp6KAmWVRQPxjYtgASrhI0Xdd9Tp7MeuG2cJlLW1Vc/WOvXjTdOdDDpT8TUD6hi42IPvk7avLW4UK2JXOn75WVmSSmKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=PcAGcBd+; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="PcAGcBd+"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-690b6cbce11so14126487b3.2
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 15:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723760934; x=1724365734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NqThN4qbfvU+1vWMgiwXaIfvuShsSgAKF1gC3+o4HU4=;
        b=PcAGcBd+N+uK6KYzj53v/Y8sVOyNgfuc6xLJoJM8yhKBnmcNCYyHXSkRfPQEgMbm1o
         MOvAe6pLgqkAkVUO2yTAlmoUjgDpQsRdUApi+uUeR4+HcmqxBVcPk8Cobl8atW0yXhPN
         BqydHWbN7b1OuV6zyg0JvySgCSWsLzw/iQ5ehsRDumC2EhlVcJSrv7ZEQtfFX9kS+ykR
         FXE8ypXL9peAGMvqaVojvUdyjNIBt/A7bcmT6MWDkVQu+jeM4BZCS+JIanywoQonYLLI
         MI0BYOu/OJA4HRZjA9wiVygYFWadFg7+h6dDSNN0/S1vRRTgglQGCqBseq2ACn1exWzx
         tclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723760934; x=1724365734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqThN4qbfvU+1vWMgiwXaIfvuShsSgAKF1gC3+o4HU4=;
        b=YdS8SrHdPqT6mG+G83T6rjsL31ONZgw2zXfMYav33QViosESTq3rIrsDCHHHs1ssgs
         7gJWNdm2775uQUxHeEKJCtO/ovkRqC4cWhsR8NezMYEAmtPXwDuPHbZKB3xJ4oGukBwf
         TIYvNkjcjFf56FR/1FjQz5Ny6Ly0tCQpuGPmko+76HBft0U41lMGVfDojsUj/RLzy3TG
         wPTo/4l9Ms6rw3BtCpx+fK97wF/5ezLMibLxn7tsosRsUKQrHsrTXnZRugdxgFRqdfJD
         ClcFXH6jYUtER6bvloN1SsX3QmBTZBv9a5sjN6QE09xiJUH7XnPujRQjhYPo1umbuoKY
         8t9A==
X-Gm-Message-State: AOJu0Yw0wodQ9iSo4FdwJvSZhBDYGSX6NaEzKsDFZyPhOaW5y0m7r7+e
	U8sYG5M1Lv1a0Dwxo7Yo+B19EszQMh9uXx9TjPn24DJfi9CMO6T5UnwMhpWjIL9Omh1KW8r17C/
	2
X-Google-Smtp-Source: AGHT+IH/qIjqmoR7HGb1KNpDEiKVXem3+ofn9tRW+GF2gnDG7XNuXI7v9qN7cgWjJF9V2DUEzaUL6g==
X-Received: by 2002:a05:690c:dce:b0:64b:2f31:296b with SMTP id 00721157ae682-6b1b7597f8emr14400267b3.4.1723760934218;
        Thu, 15 Aug 2024 15:28:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9e1db793sm4127197b3.135.2024.08.15.15.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:28:53 -0700 (PDT)
Date: Thu, 15 Aug 2024 18:28:52 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/13] Documentation: describe incremental MIDX bitmaps
Message-ID: <d1b8d11b37fa5ef6f031d3070669a213e721bab0.1723760847.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1723760847.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723760847.git.me@ttaylorr.com>

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

