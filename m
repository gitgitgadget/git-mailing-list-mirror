Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85980535C8
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 23:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715077; cv=none; b=akyUu6StdB66CMN17gN+WoHlgL7qx1Y/BUb8qtk8tzk/tEbMqfCavRTA6gdogOIamLTI9FbzAoh/vzvw+sbxY1oNMzlRN9YtDysr7KnoXVwQoyO7RHj7Ohz1f5mCk11rE0InkcW+czM1p2KUvgJTbqGb17i/IrQEDHVZ4fQIzmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715077; c=relaxed/simple;
	bh=aKz6PjgmFYmhXt9wGM4ig7A8ibAxI5QSOQ2/L7icZqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gINIvVbSJVjSGsYSULSCcTZIP+eW5gmXnb5OhUwagqQfn7nd+L8gCeLA5W8NCrgvAneBOI1l2TakrfsIMTOlcVD7HvnRTe+iSmm3nhD90J+XnkM8ZSP02KibN5kfWGesWbRe+EdsQDz/TeKq2/ZFkdz3PVYRga9zGQENmS60IfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=aZrWi9LN; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="aZrWi9LN"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-79535efc9d8so68528885a.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 16:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717715074; x=1718319874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lvfhUyiIBUHEVPo4UsdIp09q3jyUZir7shtDZpw/IOQ=;
        b=aZrWi9LN8Iz3JeOB8a+qwV+S1LbAnKkYhCz7WKMrAk92nsWR5b0Cvz9p0kyy0djEIm
         dWHKR/QsCTwQb07hH8u75eh7GpHzyzB/KOT46A77IXZlqfQmI5y+ICvQNe574KqQ/5QB
         TnYmM0jm5/sHh4A37+snkqeBb6TmRbhLtQHBgskUB9BN64B0Lq8f88sRV9X+tE6YZQHO
         odH4gYTfgDCAMw/MoeeKQ3FUOKBkBs2gLDFxmWLaiadshbwblHG6xsc1mvtXePY62V50
         O5lRuh3okpNP6pl1lwh4BVyGeGOPrIb1DGn01i8E81MtRbr7SrWpStvr+9D7ZXuAHQCU
         NIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717715074; x=1718319874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvfhUyiIBUHEVPo4UsdIp09q3jyUZir7shtDZpw/IOQ=;
        b=HUMrytOG2kSCe5Cbbr12aTfFYOD2TeRWV7A/H+YfYoBQsS1hp642D6Vv8WgABMhPwo
         rvxIGKhqkn9KD50ra+kCS7hOGBJkfouUI31oJLgX/muztw+rSOC1/4jT12oLux6HXAx5
         /uNSKgNHuePXiASEeE2fhYjU3GrnXuSllTd5XA+sxF9uSXl+7Z6Se3Azq7kNr7CxL69C
         hRmaj54ACQaonmURGCcBtm+MRT5/XwoNijgSHdRQx5e5c2MzxDRYDaxuu3qfmhE2RdHA
         p1UsTx/nxCWoHyFjBP72p5AnYvOgSJHb5fpctE/kvZ42quDkpPk78WlyWELqdgMO+lxI
         do1A==
X-Gm-Message-State: AOJu0Yz2ZqPs+cAKGjvPjzJl8DPOJKiQ9Gw/ENNLrAN0JUUob3Ggu/jo
	p+HerpdZYEz2holJYyrUzJ7zqvAAvY6K+0AzlGj5BAWG+lfLl/Gt2DwLgoCpNQIPgXT6BJqg1xP
	3UXk=
X-Google-Smtp-Source: AGHT+IFT1a/RrG3pyov6/aMKwV1eSlVDUvQAArF8IcM9Y6xcO0isGfF6q4wYfWWQvwiVFhKPhAVpig==
X-Received: by 2002:a05:620a:204d:b0:792:b938:90ef with SMTP id af79cd13be357-7953c6475d7mr68463185a.35.1717715073935;
        Thu, 06 Jun 2024 16:04:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795331c9320sm103069685a.120.2024.06.06.16.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 16:04:33 -0700 (PDT)
Date: Thu, 6 Jun 2024 19:04:32 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 03/19] midx: teach `nth_midxed_pack_int_id()` about
 incremental MIDXs
Message-ID: <9f2cec7aa27b806bedf62826be2a58639717b289.1717715060.git.me@ttaylorr.com>
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
  4 objects appears earlier in the chain, then asking for pack "6" would
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
index bc4797196f..d5828b48fd 100644
--- a/midx.c
+++ b/midx.c
@@ -240,6 +240,23 @@ void close_midx(struct multi_pack_index *m)
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
@@ -331,8 +348,10 @@ off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos)
 
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
2.45.2.437.gecb9450a0e

