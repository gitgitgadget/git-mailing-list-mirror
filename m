Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6AD25CC6D
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736878; cv=none; b=ADbuM3YSklq03ry4SGFxuT596E3vPCK82urT1sl5gJyIuOiuegeJiOtqaxGUuPcbVP/OXHAXNLf32Dz5xFuX35swO5Y2f8OTjKBjZaKI6czPc/CRBXIMTafkBTeb+LOuCaunWcyvtnoE/BPmE0sm5kl2xSPiyzn+QEPRc8jhcbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736878; c=relaxed/simple;
	bh=6bnZLlaUVJNvlcAMzAp312ao73N+1LYoSO5Fr4KqvtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBRpxyQ9Rs5aCGZavwqIxT730ffvsNPZPh351yhKuP+UMPSKdZjygHJErx8lHz176RGPrGKAhAIl5pB5Z9O4XGerF5I5XIufo6zGa9HUsou9TsAdim2MUWdrAuKsbFo9UmgnrzaaLs2MXU8Zl8O1fcMEnv5d2REKB/uF3PdxWdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aI14LbGv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KTS+rn2q; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aI14LbGv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KTS+rn2q"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 85A4D1140094;
	Fri, 28 Feb 2025 05:01:15 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 28 Feb 2025 05:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740736875; x=1740823275; bh=EplEKYl4VB
	YtaxZDvK85NITI2q9QLOi0ryZOXzxEpAM=; b=aI14LbGv9CoQ8SrtMoFEr9KYhU
	u5aiXK2ttOfKCEgAvfMtpnZVN2B3FR+aAdPv3E8QXZzvBOrIoYve9zlbaAM8ds3t
	7kCtPgRTuUYs0zvmFn4Gy94PGXh/iAM7cXJOh3ppMAF1gE+TSKxS72R04oNYuB6D
	2sVs9NX/IwQoMh5IScuMq7Tna+e8ivsy7qFkZAqWg8isrWp+5w80DQ1Cf3KSOdv9
	NNyD+Sq5p/wBanC4uUd/0k1HqX0YaMeFKaKYwdGh8WCtskvwhmMybcfpvRqwbpcl
	i+AjFvgvPmsEuTZkK8K89eZNlYWxO9yB4U+4FIcCKsurnoiuqjNFYcm77m+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740736875; x=1740823275; bh=EplEKYl4VBYtaxZDvK85NITI2q9QLOi0ryZ
	OXzxEpAM=; b=KTS+rn2qKheCQprDWPQQsPd4Ay5/vAMzmDz6GLWAmA25VHOcks7
	4BERhyG8sFCqjMzzwTcyZGiBx50OyEpYwaDLEehU/RB9/udWMBXxEGQcr/u4UKsi
	IuFlp6XCh39UtmqtN3lZ9j3ErAD0dO+lbHdUhSxCs3Z5oG21O+AsmWtOLARGj3Iv
	sioe29Q9+xQB+M5vBT5HL64D/VQ4ZeUcpQfnfSsx56x13dn6Oy7uzjYUcRzybm4g
	aj3leVKmUTif4py7x5QhVoVjngzqc/jDZ56aK9/iFUYpSYNFynSIx33LQf5Z6hpB
	bS6uJ1Y/mr5S3m3qPY9unzEM6yRle0bvjkw==
X-ME-Sender: <xms:a4nBZ2_tRvJfXU7W6qfei2essDtB_G3-KL5NgfZ4s_bvXovDx5ILdg>
    <xme:a4nBZ2vuzk3acTGmEvRNkJm37qBlfLi9qj75GkbIsak64lBTRq49yK0uEyLAVYkfz
    7V34sEmo8O_TDwsFw>
X-ME-Received: <xmr:a4nBZ8D9U5eRNAY9Q17PBUshaJTu91SYBQXtnf7j-raonEo1d0RlBn4Rxae9krZet8k1bCCY5nqGIhWHItnTBr15X-KyunN7IcRPfUwesCIzZhLa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:a4nBZ-f2oJbrxXnwSZAodg0W3aFAuTJ_GrS1mgtm6GRJyUMZfkBGZA>
    <xmx:a4nBZ7NulOv1dDd9JPgeuQnVMftmtHM3HpbEr147pfCLBB9TGfBjfQ>
    <xmx:a4nBZ4mQknHl_4EG6nCtxOnv6iQTq0PCWLHlCuYJXWjfHujOmsMywA>
    <xmx:a4nBZ9sxLIj0HZpfzKKpAx-CA6fq3MKYNEgdCCmme2CyN-9db4JxBQ>
    <xmx:a4nBZ21jiiED2RsD03h6CTh_jUaKYeBsAm06S7dKZ4euudT_R_p8ZskP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 05:01:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 50896425 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 10:01:13 +0000 (UTC)
Date: Fri, 28 Feb 2025 11:01:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 02/13] pack-revindex: prepare for incremental MIDX
 bitmaps
Message-ID: <Z8GJaFPMQtslEEt3@pks.im>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
 <b902513f43697e94976c1baf5598222fe2e3b847.1732054032.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b902513f43697e94976c1baf5598222fe2e3b847.1732054032.git.me@ttaylorr.com>

On Tue, Nov 19, 2024 at 05:07:22PM -0500, Taylor Blau wrote:
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 4fa9dfc771a..bba9c6a905a 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -170,6 +170,15 @@ static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *index)
>  	return read_bitmap(index->map, index->map_size, &index->map_pos);
>  }
>  
> +static uint32_t bitmap_non_extended_bits(struct bitmap_index *index)
> +{
> +	if (index->midx) {
> +		struct multi_pack_index *m = index->midx;
> +		return m->num_objects + m->num_objects_in_base;
> +	}
> +	return index->pack->num_objects;
> +}
> 
>  static uint32_t bitmap_num_objects(struct bitmap_index *index)
>  {
>  	if (index->midx)

Okay, despite counting our own objects, we also need to account for any
objects that the MIDX layer that we depend on may refer to. I assume
that this is basically recursive, and that the base itself would also
account for its next layer, if any.

What is interesting to see after this commit is what callsites remain
for `bitmap_num_objects()`. Most of them are converted, but some still
exist:

  - `load_bitmap_header()`, where we use it to determine the size of the
    hash cache. Makes sense.

  - `pseudo_merge_bitmap_for_commit()`, where we use it to compute the
    merged bitmap of a specific commit. This one feels weird to me, I
    would have expected to use `bitmap_non_extended_bits()` here.

  - `filter_bitmap_blob_limit()`, where we seem to filter through the
    bitmap of the current layer. I _think_ it makes sense to retain.

  - `create_bitmap_mapping()`, which feels like it should be converted?

It would be nice to document in the commit message why those functions
don't need to be converted to help guide the reader a bit.

> diff --git a/pack-revindex.c b/pack-revindex.c
> index 22d3c234648..ce3f7ae2149 100644
> --- a/pack-revindex.c
> +++ b/pack-revindex.c
> @@ -383,8 +383,12 @@ int load_midx_revindex(struct multi_pack_index *m)
>  	trace2_data_string("load_midx_revindex", the_repository,
>  			   "source", "rev");
>  
> -	get_midx_filename_ext(&revindex_name, m->object_dir,
> -			      get_midx_checksum(m), MIDX_EXT_REV);
> +	if (m->has_chain)
> +		get_split_midx_filename_ext(&revindex_name, m->object_dir,
> +					    get_midx_checksum(m), MIDX_EXT_REV);
> +	else
> +		get_midx_filename_ext(&revindex_name, m->object_dir,
> +				      get_midx_checksum(m), MIDX_EXT_REV);
>  
>  	ret = load_revindex_from_disk(revindex_name.buf,
>  				      m->num_objects,

Here we teach the reverse index to read indices from MIDX chains.

> @@ -471,11 +475,15 @@ off_t pack_pos_to_offset(struct packed_git *p, uint32_t pos)
>  
>  uint32_t pack_pos_to_midx(struct multi_pack_index *m, uint32_t pos)
>  {
> +	while (m && pos < m->num_objects_in_base)
> +		m = m->base_midx;
> +	if (!m)
> +		BUG("NULL multi-pack-index for object position: %"PRIu32, pos);
>  	if (!m->revindex_data)
>  		BUG("pack_pos_to_midx: reverse index not yet loaded");
> -	if (m->num_objects <= pos)
> +	if (m->num_objects + m->num_objects_in_base <= pos)
>  		BUG("pack_pos_to_midx: out-of-bounds object at %"PRIu32, pos);
> -	return get_be32(m->revindex_data + pos);
> +	return get_be32(m->revindex_data + pos - m->num_objects_in_base);
>  }
>  
>  struct midx_pack_key {

Here we teach the reverse index logic to walk the MIDX layers so that we
find the one that is supposed to contain a given position.

> @@ -491,7 +499,8 @@ static int midx_pack_order_cmp(const void *va, const void *vb)
>  	const struct midx_pack_key *key = va;
>  	struct multi_pack_index *midx = key->midx;
>  
> -	uint32_t versus = pack_pos_to_midx(midx, (uint32_t*)vb - (const uint32_t *)midx->revindex_data);
> +	size_t pos = (uint32_t*)vb - (const uint32_t *)midx->revindex_data;

Micronit: missing space between `uint32_t` and `*`.

> +	uint32_t versus = pack_pos_to_midx(midx, pos + midx->num_objects_in_base);
>  	uint32_t versus_pack = nth_midxed_pack_int_id(midx, versus);
>  	off_t versus_offset;
>  

Okay, the calculation to calculate the position is basically the same,
but we now also offset the position by the number of objects in
preceding layers. Makes sense.

Patrick
