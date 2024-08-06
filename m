Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CED1799B
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 15:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958642; cv=none; b=iqiiIZAdYHoihbHVZYBwxzbj9ZpTOzFQPfQ+SjyqoXP4kgTYfMOewQ2TYmCAPi6U4X1BkfR/fJqRqEXE7/DbNiYDi2pzMznG+JEQMeosa2zcHdcvshOYyYspC5dc13aiQLqPaffmJAfSS9ZzF1fMfDMOc3f4nEScOyN5tUzuQFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958642; c=relaxed/simple;
	bh=T2ABrx9nYv8rEbdKuGVBmkdIaR0TnfAFUkN7OvTioq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMaphLMhEg+BRk1BxC9k01BltvNJOnqp9LgZdXi6jxeXkBHgt8BFSOPyCM2uvUdc9w2sgwXNwHf0gb91AFbz3MRpEBnCd9QbtAxDc7fSZje/rrPpq+ghqeWo8sgwLQiGAWVm75xf/OVbRBrmt2cOsYSTZeJR47Ux19VTnEaFMGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=mpHpidRl; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="mpHpidRl"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-68aa9c894c7so7471877b3.1
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 08:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722958640; x=1723563440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MkDZ8LohH7UWQYLGoTItOAFXWqRR6j/yiQyB0dNtufU=;
        b=mpHpidRlXlMVcT1NkCO9djOu1FZGjI4zGn3avzv++4tKgu+laxCn8hVuATF+ffDrB6
         MR6s8auCxU/q2FQPAJU8URkwk/TGfmkEyDeY/E9Ntax2azJKPSVkYlKyH4jH0gEcf74U
         KF1jHFK76DcKs7IJbXxKdkyQxcjGJIlcA3XnxR3EYJ8KPhMfdo97NM9a0NBtw5ZPMDAX
         XWjEWoXqppwe5Rtlo0GFPGHwec99HiBpScJpsQMsz9vHGToU0qPZ2m6b2AXWjXyA6UTx
         dU2L9Yr1LfDecXn2WVB844SRrU7zmszq/AE5jR/zCo1Jc+fBiguVjt7yH4kYVjlTNe3t
         ICvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722958640; x=1723563440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkDZ8LohH7UWQYLGoTItOAFXWqRR6j/yiQyB0dNtufU=;
        b=hs6ELHIjsYvrxHmauPiQ09ii7t7BUz6N9ZygqpERu9+9TCs9tzyBHvsfP0o23x2qMw
         +cQ3GlFRZNFlTni7k2w6XST0SKmFkfe711eX1Ctp2RR7MVkNiXEQiy2VCP5yrGHnZihe
         CYXavSZP3LbwF8E8FuibvmRpWae9xzPuBSh8pb2str0Pi6ODkxpR+39dOMPrl08pOqSx
         xnM/THGJgoZW2WqqJaZGiVBZ5iDGXdgFDgNDKWe8bsQAQJovk+OCCIB5EmU9uSKxHCzd
         gt1ZKFhqXKQIoU6VbKdO5yE6qm7M+FOz8otCWyq2Z4Bh0d+jFGZWbhjOgv0ov7NA9M8M
         4Dhg==
X-Gm-Message-State: AOJu0YxBNF1fWGRzqLJl4FMSJvlrlQjj9wSYOt2NoZdv5Fcoyxr6y/yL
	WzMazsTYkQK/6B7yv15HgE9+I1gxo+4z6BphTLOHQYdxjhc9p1o6yhnBvl/kaWGsslUr6iBVNid
	C
X-Google-Smtp-Source: AGHT+IHHeOKPtouuiqB7ks4gp8ne3z8BWUWNuclvpfH4Rc2NAsv6O9WhEaeVv3TqUkOCLwi2nyRW+w==
X-Received: by 2002:a81:8901:0:b0:630:f7c9:80d6 with SMTP id 00721157ae682-6896160e208mr162328677b3.27.1722958640090;
        Tue, 06 Aug 2024 08:37:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a136bfa21sm15902177b3.119.2024.08.06.08.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:37:19 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:37:18 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 03/19] midx: teach `nth_midxed_pack_int_id()` about
 incremental MIDXs
Message-ID: <5cd742b67761913bd9693102a8b823f353b60f7b.1722958596.git.me@ttaylorr.com>
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

The function `nth_midxed_pack_int_id()` takes in a object position in
MIDX lexicographic order and returns an identifier of the pack from
which that object was selected in the MIDX.

Currently, the given object position is an index into the lexicographic
order of objects in a single MIDX. Change this position to instead refer
into the concatenated lexicographic order of all MIDXs in a MIDX chain.

This has two visible effects within the implementation of
`prepare_midx_pack()`:

  - First, the given position is now an index into the concatenated
    lexicographic order of all MIDXs in the order in which they appear
    in the MIDX chain.

  - Second the pack ID returned from this function is now also in the
    concatenated order of packs among all layers of the MIDX chain in
    the same order that they appear in the MIDX chain.

To do this, introduce the first of two general purpose helpers, this one
being `midx_for_object()`. `midx_for_object()` takes a double pointer to
a `struct multi_pack_index` as well as an object `pos` in terms of the
entire MIDX chain[^1].

The function chases down the '->base_midx' field until it finds the MIDX
layer within the chain that contains the given object. It then:

  - modifies the double pointer to point to the containing MIDX, instead
    of the tip of the chain, and

  - returns the MIDX-local position[^2] at which the given object can be
    found.

Use this function within `nth_midxed_pack_int_id()` so that the `pos` it
expects is now relative to the entire MIDX chain, and that it returns
the appropriate pack position for that object.

[^1]: As a reminder, this means that the object is identified among the
  objects contained in all layers of the incremental MIDX chain, not any
  particular layer. For example, consider MIDX chain with two individual
  MIDXs, one with 4 objects and another with 3 objects. If the MIDX with
  4 objects appears earlier in the chain, then asking for object 6 would
  return the second object in the MIDX with 3 objects.

[^2]: Building on the previous example, asking for object 6 in a MIDX
  chain with (4, 3) objects, respectively, this would set the double
  pointer to point at the MIDX containing three objects, and would
  return an index to the second object within that MIDX.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index 3992b05465..39d358da20 100644
--- a/midx.c
+++ b/midx.c
@@ -242,6 +242,23 @@ void close_midx(struct multi_pack_index *m)
 	free(m);
 }
 
+static uint32_t midx_for_object(struct multi_pack_index **_m, uint32_t pos)
+{
+	struct multi_pack_index *m = *_m;
+	while (m && pos < m->num_objects_in_base)
+		m = m->base_midx;
+
+	if (!m)
+		BUG("NULL multi-pack-index for object position: %"PRIu32, pos);
+
+	if (pos >= m->num_objects + m->num_objects_in_base)
+		die(_("invalid MIDX object position, MIDX is likely corrupt"));
+
+	*_m = m;
+
+	return pos - m->num_objects_in_base;
+}
+
 int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id)
 {
 	struct strbuf pack_name = STRBUF_INIT;
@@ -334,8 +351,10 @@ off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos)
 
 uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos)
 {
-	return get_be32(m->chunk_object_offsets +
-			(off_t)pos * MIDX_CHUNK_OFFSET_WIDTH);
+	pos = midx_for_object(&m, pos);
+
+	return m->num_packs_in_base + get_be32(m->chunk_object_offsets +
+					       (off_t)pos * MIDX_CHUNK_OFFSET_WIDTH);
 }
 
 int fill_midx_entry(struct repository *r,
-- 
2.46.0.46.g406f326d27.dirty

