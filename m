Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AB218E74A
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 21:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721250759; cv=none; b=cyJlVrNxU7Xq7S18QzMPeMUVYMolF0QExTCuzCBWBCjJ23L1DZpPRqm2lV8J7+aZU+YVzAayVcXH+/Rht8SPhNoOTidVIbGWYrVSGs5yIjQlJwX9l7sYhWRfKUoayScgBfaVM+O/9XRClpmonVkC0EYfUXiAOzmeM9AeYAI4NGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721250759; c=relaxed/simple;
	bh=Q2sbIQhpYSsr+/BXnEOSLnGp0p2vb5wN0mSzNH3FU/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYHq8Q93meDxT/W6dluSbDLRc3fg85IS4hpT9py9iN6YYKFe28hJkDpC6bsje3l3JFXQ19TiIr1eqv2Zcf4l/gpQZ8/UnIOSnbccqlhQoRM7lftj2Ou17W8WYL7s0XpkUdDDPtrdhP8S5oj0MiR0hgXRSS/KwJ6ut0/1qznIzmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=3DnXIolB; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="3DnXIolB"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-664b4589b1aso1913247b3.1
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 14:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1721250757; x=1721855557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ns4yHYpyM/cO7ZxUx/3QB90dxH93QV0allO65drdbEs=;
        b=3DnXIolBYFpMQxDqlL0GobDgNPcVIhNDMvGuTnW653BTEJ/Icixb1hU3MXEJWCnAcs
         ASa73YIPrKzZMb4Dm41DSSbbhIYXwNETDiLNnlKCLA9l1LPdemkDaeVrr4iJDjP+/RVM
         eVYEz2+HAHi6NloucvfXWlp6usLfsD/ZXF3XsNcKBGMdanP2wRa7zNnHUeFIy8gBYUGX
         EDYEPtQiEIhRFJP+y2jneR63/J/jgyl120dOj/PbfwW3AbjAiIlTCbbXz8ODCrfnKGdJ
         3BEMJt2QHW6csQwgkJvVccf0GBpoS+ogFATXPU1aKDLae5JVIWxXS2qY0KA2uj5CiRGl
         NEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721250757; x=1721855557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ns4yHYpyM/cO7ZxUx/3QB90dxH93QV0allO65drdbEs=;
        b=cHTgOouPdpus7Gq0DKs4U/TGGLhmCIddaNDekIZr1+ulDCqOqv/S03NZPKjqix3PZI
         niYm1F/PQ27XSELhSV4X7QrMv2X4XK16wUuP7CPOvXfBnKAJrLet14wbFjHAHzOdwaN7
         hMrt9WukgrdfMnEE/PH4ie38JSLcCcxhqFMuyvSEjTyXam8ll+vpn+isI0hMgge+oX8j
         KF02jfyyMH/1ajcWICLU+DdirBWI3Zku2kqfPIPIEpeU4EF97K1moyMokJvYLBOQvMnQ
         Uohx/r9dFEqnGW2QJwkS3Sc5HKc2um1elSFZu3/msXy6RQDadn2hjdHENUGFka0omGbs
         64Yg==
X-Gm-Message-State: AOJu0Yxje4geN7JYeFJvgDb680Iat/8PNDF4Vm48qf96zpM3Ra8fnQ1q
	Z0psgOww+w6JEeJ7woUyEkffbF72MBFw5sjwLF+2GJXpNJCYDrjnWPC2bQdEdI4Xkj3nEUOQgrF
	B
X-Google-Smtp-Source: AGHT+IFvvprnNOCeqo070Agk35Sf2Jd5LV8VkwRb/2sZ+YrLUZ6RJHULc+NQKmVMCR8BAyghyeIykg==
X-Received: by 2002:a81:77d5:0:b0:61a:d0d8:75f6 with SMTP id 00721157ae682-6660a738d69mr4421817b3.24.1721250756738;
        Wed, 17 Jul 2024 14:12:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-666025869basm779987b3.71.2024.07.17.14.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 14:12:36 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:12:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 13/19] midx: teach `midx_preferred_pack()` about
 incremental MIDXs
Message-ID: <38b642d40423f2e14dd47d676de54f264b9d6f22.1721250704.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1721250704.git.me@ttaylorr.com>

The function `midx_preferred_pack()` is used to determine the identity
of the preferred pack, which is the identity of a unique pack within
the MIDX which is used as a tie-breaker when selecting from which pack
to represent an object that appears in multiple packs within the MIDX.

Historically we have said that the MIDX's preferred pack has the unique
property that all objects from that pack are represented in the MIDX.
But that isn't quite true: a more precise statement would be that all
objects from that pack *which appear in the MIDX* are selected from that
pack.

This helps us extend the concept of preferred packs across a MIDX chain,
where some object(s) in the preferred pack may appear in other packs
in an earlier MIDX layer, in which case those object(s) will not appear
in a subsequent MIDX layer from either the preferred pack or any other
pack.

Extend the concept of preferred packs by using the pack which represents
the object at the first position in MIDX pseudo-pack order belonging to
the current MIDX layer (i.e., at position 'm->num_objects_in_base').

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index 0fa8febb9d..d2dbea41e4 100644
--- a/midx.c
+++ b/midx.c
@@ -500,13 +500,16 @@ int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
 int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
 {
 	if (m->preferred_pack_idx == -1) {
+		uint32_t midx_pos;
 		if (load_midx_revindex(m) < 0) {
 			m->preferred_pack_idx = -2;
 			return -1;
 		}
 
-		m->preferred_pack_idx =
-			nth_midxed_pack_int_id(m, pack_pos_to_midx(m, 0));
+		midx_pos = pack_pos_to_midx(m, m->num_objects_in_base);
+
+		m->preferred_pack_idx = nth_midxed_pack_int_id(m, midx_pos);
+
 	} else if (m->preferred_pack_idx == -2)
 		return -1; /* no revindex */
 
-- 
2.46.0.rc0.94.g9b2aff57b3

