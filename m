Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252CE18A954
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721250731; cv=none; b=bVgbVAKloigweJEroWwx7hvoVWeBkg63VixZqCOrJIoJGPTJKm5fGc3PDYa4inF0PtYcP7evM5ljrYVf3mhFNGmY3PIo5oxh69mn3iZgrBa/RtPadeRtYb7DoHEpKCnxK+ISo0zdyu8SkqPVxvJWeeiJpFxWV3J0waogR6TfGIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721250731; c=relaxed/simple;
	bh=xvg+l9xogRGcDwTMhuUeQWnrxF90DnU6LQvE/TnbY2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbtVWaMtXqB4iHBPB5FkpWbGSepzZNvDtYyUtNC4Oo8laBi1lPrjh8sFPoVLkYzlnju9/hoVvPb45QUbZQx6Ygvp8dKN9HUdo3MagQbnXoy3kTo0L8ZRsMv2e/tCyy9zbBeu78Qqyisk5KKMkm6C94Q5ylAYOcXg3AROg2n47Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=cZT1li/p; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="cZT1li/p"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dff17fd97b3so153901276.2
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 14:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1721250729; x=1721855529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z4V5h99dsx+XVhq/PbTMbdc8GIFrROpwL4mbb/IAAmo=;
        b=cZT1li/p+f6h5cLubFTz96Wmi7kiJLcZ3mpO19q+mDCOunnAiTEP0gT0sZcecHGxei
         wYkTYGsVBFI9gYiyzSknF/PrOqXTaUCkMDq42pLO8U4UEDPvYG9GY98XX58Ch7IcGQ45
         TtmAKE0PCURyvyo2O+06fX3wrK58+gX/9T6aJYRpf47gpHeMtL7uUdXpYiC2JH6YyHem
         M5+lQkY2iwyCnMSnQ4u2+tp13b+hdnC0HpeHuPtnAjRERyRM4ee+lo/p5GGT93QnBkAq
         qPRprl0/L2kCyviAm9zYOWPW+yNUeebJPDtvV6cnD9ytxbtc+3l/ncUitA4TafPSGHZt
         C6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721250729; x=1721855529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4V5h99dsx+XVhq/PbTMbdc8GIFrROpwL4mbb/IAAmo=;
        b=OPbRuCxR8blLsXV5sCKeeXSD2vsGTHl3O215wcfGM5JBMvH+bb6maqwlZhEV1c1txd
         hCUSqgcQ7KFeA57A7a86BaYRoEGdgaLo1hHcujWXUo0XL0AXa+WY5QmMQfOcWx1m+AY0
         sOx9uLJ1wp7v71jvRT3btzgWt4q/jf6N0G3F8iBHJQ5zuo+gMzpzCkza3dTWU6OmwNBM
         3tJh3JTPop32ffBLBvGKG5DrW+s6cLaY4z4wdTUB41kQpAVtFNgsBXXbjyiVI1+9NLTZ
         Az27GytmlLVMP/WrPKXm2JXJdrk8Ds24VtR47H4ZzRd08MeWUiZIVYbdweB8rjHlvKnp
         aZSg==
X-Gm-Message-State: AOJu0YwOedcNqAOTkmJdko3BPtmb12L9JBzsynqHnqAKobyUVouP/4LQ
	GAXLHJbkPu4oT/I3nctKtW+rr3mMPzjZS6LryKUJTzA0P5H0+BV0uWxTQlnQFZwisRQsSx/MnyH
	d
X-Google-Smtp-Source: AGHT+IGJOywWmYMEFiJD0RMcX1hxMH077rtuFTh+00auVlSHdepQB07OH0tvRE47kV2NkMfsLP6niA==
X-Received: by 2002:a05:6902:70f:b0:e03:5ed9:5c2c with SMTP id 3f1490d57ef6-e05fea9fcccmr853962276.11.1721250728799;
        Wed, 17 Jul 2024 14:12:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e05feb3fde2sm80068276.43.2024.07.17.14.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 14:12:08 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:12:07 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/19] midx: teach `prepare_midx_pack()` about incremental
 MIDXs
Message-ID: <f88569c819292a824c78cdffd4e1fbc329f07f8e.1721250704.git.me@ttaylorr.com>
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

The function `prepare_midx_pack()` is part of the midx.h API and
loads the pack identified by the MIDX-local 'pack_int_id'. This patch
prepares that function to be aware of an incremental MIDX world.

To do this, introduce the second of the two general purpose helpers
mentioned in the previous commit. This commit introduces
`midx_for_pack()`, which is the pack-specific analog of
`midx_for_object()`, and works in the same fashion.

Like `midx_for_object()`, this function chases down the '->base_midx'
field until it finds the MIDX layer within the chain that contains the
given pack.

Use this function within `prepare_midx_pack()` so that the `pack_int_id`
it expects is now relative to the entire MIDX chain, and that it
prepares the given pack in the appropriate MIDX.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/midx.c b/midx.c
index 39d358da20..da5e0bb940 100644
--- a/midx.c
+++ b/midx.c
@@ -259,20 +259,37 @@ static uint32_t midx_for_object(struct multi_pack_index **_m, uint32_t pos)
 	return pos - m->num_objects_in_base;
 }
 
-int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id)
+static uint32_t midx_for_pack(struct multi_pack_index **_m,
+			      uint32_t pack_int_id)
 {
-	struct strbuf pack_name = STRBUF_INIT;
-	struct packed_git *p;
+	struct multi_pack_index *m = *_m;
+	while (m && pack_int_id < m->num_packs_in_base)
+		m = m->base_midx;
 
-	if (pack_int_id >= m->num_packs)
+	if (!m)
+		BUG("NULL multi-pack-index for pack ID: %"PRIu32, pack_int_id);
+
+	if (pack_int_id >= m->num_packs + m->num_packs_in_base)
 		die(_("bad pack-int-id: %u (%u total packs)"),
-		    pack_int_id, m->num_packs);
+		    pack_int_id, m->num_packs + m->num_packs_in_base);
 
-	if (m->packs[pack_int_id])
+	*_m = m;
+
+	return pack_int_id - m->num_packs_in_base;
+}
+
+int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
+		      uint32_t pack_int_id)
+{
+	struct strbuf pack_name = STRBUF_INIT;
+	struct packed_git *p;
+	uint32_t local_pack_int_id = midx_for_pack(&m, pack_int_id);
+
+	if (m->packs[local_pack_int_id])
 		return 0;
 
 	strbuf_addf(&pack_name, "%s/pack/%s", m->object_dir,
-		    m->pack_names[pack_int_id]);
+		    m->pack_names[local_pack_int_id]);
 
 	p = add_packed_git(pack_name.buf, pack_name.len, m->local);
 	strbuf_release(&pack_name);
@@ -281,7 +298,7 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t
 		return 1;
 
 	p->multi_pack_index = 1;
-	m->packs[pack_int_id] = p;
+	m->packs[local_pack_int_id] = p;
 	install_packed_git(r, p);
 	list_add_tail(&p->mru, &r->objects->packed_git_mru);
 
-- 
2.46.0.rc0.94.g9b2aff57b3

