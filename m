Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC61535C8
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 23:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715073; cv=none; b=n1lc0sk7KlE2FCwr/ISkmuhkND1MlvJbIboMW4ajYNDRPOvwx+jZQq/x1Lr/SqnCD68TFRIwyaCTDg4bea70j4p29ZWXwSeLp12wwM0wF6aGWQ5hMPUK0gNdtCA15h+kgNzoT+tq2HQfZ3MzfAOeyMe+jfCoCMnS3EwEpSTy0n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715073; c=relaxed/simple;
	bh=N3Z1PZ72V5odW9/MQjFz+L5vJqRbXcSiFIR91zHCaL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcOkzdysi11TLlu8+YVcO6IHZgrRBw2R7ddgWf1v6hD+ZSuTKB3q+nn7XX+RFRT1EIUic4y1L+nxI6aUcBu04KBFtng1LeNx20M8DngIjDIurcO+OIRR6qXPl3e9eYtjCliNPCiwoF9rFWeuTpoWjA7fzkKdBbrvELcnxZ21Bmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=qwSLVh9f; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="qwSLVh9f"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-24c9f2b7b19so800890fac.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 16:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717715071; x=1718319871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+NUBPmlrNk7t035RPVDJ8n/QQM107S7lc+8eGlqfjLY=;
        b=qwSLVh9fbD51Dco013aqlKsY4KG378E6j0AM3lsB7CDhFBZZjFh6YjTpbUppPA2fAY
         XfnCHs77QejJvqoHZU9hBP2YWiAwXs0Kp5ztu+ZO0ds9sjHmjBvVH8/bctc/hK/UpOSL
         zdK+c6gHWNyS3gpXrFX5gUI8Mk5p4O+7CfqlPt9tYSBHMtzI6ne48K1Bm3mH0kK21+/E
         NQ7nzdcgsr9GQXvH1n4fRBzBMa8WOpTO32mpkRmLkgWVnJiwiOSaHQnFM9UWwb+eoFDt
         soaI7PEeR2Esv6wmYTQZDeyyMjhxDiWDdCi1LpSx+XbFvdztCHJbEc7FhJT2eeGjiJ3R
         Sb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717715071; x=1718319871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NUBPmlrNk7t035RPVDJ8n/QQM107S7lc+8eGlqfjLY=;
        b=kjXcMVPGt+aJexwrA3rXdR23vbNWTqEEoHhrogP3px5xh7BSTx40FtiIqyH0ZbqjxB
         PKCgoA42hn2W6W/0dhjt8ttZSUYfdVBHIPvvfT4sZwgVcjRn3tt6/yLWP+YFNWEYF7cg
         dnPs0HErsX/RSkcDEFXFsEeFdl+76GI1QTXfp7EAbCeHcrL7Xu9mkt752ECFJlulaaEV
         fXvYMHKzLV+O+XvlV8x+5ry3LS2m4G5wvDsDR0E8uXeYeuXkKbfNKtJYTMUXlH1V7t6L
         p5Jiknx7F7CCRVEE84locjsnDuCgMsbDTb7lZXTKsAEoP/1v3H84kkDIEpaDcFYfvzt/
         VTmQ==
X-Gm-Message-State: AOJu0Yw7sqB9swW+FXWrrF9Dw8pRLUAwhhoBbmsWKZWrmJ2jCrpanqr0
	iwjdL+5bBj0zGBV3+Bwem9NIYsPaeFwzE8U5YHKYFbIqvsh7RK3KL1sUffAvZCOrfH9D+ODibSw
	3j+c=
X-Google-Smtp-Source: AGHT+IHExkUtA8VVFPRnrpJadtRnAXhUXNhLv3VUml4j4IXJURtVRV4tbNxLH5NZrGsbz6QWtoMlDQ==
X-Received: by 2002:a05:6870:c1d4:b0:250:129a:d0ef with SMTP id 586e51a60fabf-25464e9e9a6mr937817fac.36.1717715070846;
        Thu, 06 Jun 2024 16:04:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795394389e5sm52735185a.15.2024.06.06.16.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 16:04:30 -0700 (PDT)
Date: Thu, 6 Jun 2024 19:04:29 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 02/19] midx: add new fields for incremental MIDX chains
Message-ID: <b810521bdba2d6990e3213c626ca00bfdcaaa4fe.1717715060.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1717715060.git.me@ttaylorr.com>

The incremental MIDX chain feature is designed around the idea of
indexing into a concatenated lexicographic ordering of object IDs
present in the MIDX.

When given an object position, the MIDX machinery needs to be able to
locate both (a) which MIDX layer contains the given object, and (b) at
what position *within that MIDX layer* that object appears.

To do this, three new fields are added to the `struct multi_pack_index`:

  - struct multi_pack_index *base_midx;
  - uint32_t num_objects_in_base;
  - uint32_t num_packs_in_base;

These three fields store the pieces of information suggested by their
respective field names. In turn, the `num_objects_in_base` and
`num_packs_in_base` fields are used to crawl backwards along the
`base_midx` pointer to locate the appropriate position for a given
object within the MIDX that contains it.

The following commits will update various parts of the MIDX machinery
(as well as their callers from outside of midx.c and midx-write.c) to be
aware and make use of these fields when performing object lookups.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/midx.h b/midx.h
index 8554f2d616..020e49f77c 100644
--- a/midx.h
+++ b/midx.h
@@ -63,6 +63,10 @@ struct multi_pack_index {
 	const unsigned char *chunk_revindex;
 	size_t chunk_revindex_len;
 
+	struct multi_pack_index *base_midx;
+	uint32_t num_objects_in_base;
+	uint32_t num_packs_in_base;
+
 	const char **pack_names;
 	struct packed_git **packs;
 	char object_dir[FLEX_ARRAY];
-- 
2.45.2.437.gecb9450a0e

