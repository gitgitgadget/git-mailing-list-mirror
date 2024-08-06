Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAD01799B
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 15:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958608; cv=none; b=dr9VlZYGH2GJJrgn2TAVvVR7B/YlPLtyNE4K/AR1+qRQR+gIT/CslRkqZDYISyL56jpGyYupsIEM+Ta1qHMLhHLyHUA2C+U+aKPCbETJVaJg0/Rjox6HLcrfiBXyfTmeXdewWqZV8MiWhJBZ3ZTLlm583SXFCwshLBNPgZU1xhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958608; c=relaxed/simple;
	bh=WYRKYLDHjvT9vT9KG2Me0U6hkzKbLoYSQYS6vpqqTIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7DYASkHlJwfRY3J7cYt/zA3lNs0ujxqcwvb5NSGtjYKzyLZuiLxsMxtNX5/CeNQlenkYtLJDEcQBuyZ94AfkEuoRTYJ02Yd6dNb/u0t56GI3FGUD6S8OqGhQeAQ/tEZmjy2Sv0NjI6rekszH2tav8t7aBEu3HWDEucIxEG8wds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=klhojAlx; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="klhojAlx"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-66acac24443so7348107b3.1
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 08:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722958606; x=1723563406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FBvHRKHw/kNLS3YJbTE9AEvtdTYxS0fv16LncCXaCj8=;
        b=klhojAlx9SPodLXPX/A12S+8TDeEnJ3wpvy4r8Inru04EuFv3pb59pMxwEwBeMhVBM
         cIYzuDgugpgmpF0dN80Hj6eyxKOymRx8TYY0DcK+iMZvRMbtIjNR1Sktny7Knry17kBX
         ToQfXBr8cGgaQrtEorsgMi6XUZmvFCj0uVescv35yVguKHkApWBnlAun+5A3MgF/9tct
         cqyYlJcAYf+KFtG9IFermtG9hfD1PCmOqT01X2zAMKvMZrAsXmG8CenUCJnqx+Kh+x35
         Plg4hyYjoRYAKOk7zfzWYcLdvcwEwQ1fAcfMf+jfqMkl8o1SFW6C0gXAgDMjHElcrIog
         ELBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722958606; x=1723563406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBvHRKHw/kNLS3YJbTE9AEvtdTYxS0fv16LncCXaCj8=;
        b=K28ICpWHG/GcwirWYT3E3XPOr0/lYF/UdASkxMuHvN6RUq59/1sB/jy3gElzM6V9/+
         KYbaIgZEt9WySNnTtrLpzqFnvDXY6t2OY8mLhAIfJq1SZt4jfrRN66qG2M7Q8fyo1Lnk
         f/0zRQL3fJ6v2nUhZoFEB8pvHWlkYZGxIqQaOf0QneuEbCY34p6uSXimCNiQIhgNsc48
         p6gIuMEnQ5wyAbEg1p/ahxmsGGR3NeE4eq1+Mtcw5yzW3aJj/cfo6XBr85dKGeo0lJKu
         sWOrmU9kmzgU5u9jRgHjl5MRkd/d87kM2e7mpxEbPXkvH/sciBc+ZDYfs8OgUR0cV1c8
         zsmA==
X-Gm-Message-State: AOJu0Yxuwscx7LvETZY0rxT/W/lA0z69B59LX+DYBNGPxh3NYGONJEyh
	Qf893Ty1DXSFpZTI/+/BJ3dZa+s/C0SNjkrr0GJK8WXNgLQLRnE2BjX8Z/ZUnRn4rcHc9V6SK30
	H
X-Google-Smtp-Source: AGHT+IEtkvaFD84afgjY5aOzVXOEJuYnIRdBZYfUQGW3ur8wgx0DmukHNno11VFL5pThEtckLmuobQ==
X-Received: by 2002:a81:9c07:0:b0:650:82e0:63b1 with SMTP id 00721157ae682-689641a6125mr171241277b3.41.1722958606106;
        Tue, 06 Aug 2024 08:36:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a135ca5c0sm15956127b3.117.2024.08.06.08.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:36:45 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:36:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 02/19] midx: add new fields for incremental MIDX chains
Message-ID: <0d3b19c59ff31eb17d283c61f615957e89137fb1.1722958596.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1722958595.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1722958595.git.me@ttaylorr.com>

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
2.46.0.46.g406f326d27.dirty

