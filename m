Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793173025;
	b=EbENco8i2TO+Iu6brA1Fqg1Rat41XlUbaSkqbUNlViTfEEv2JvtchzyUYlK37NPLz4OC
	 /eRL6E/Qel5wUTBC2GQbRGa2oVNSK1ChVvabUspz80Jfifa+a+B7959mvdFnA7H9tU+wP
	 3RyK92lQMsceL+6wAWFg0YfnlDuo8UIvyaslR8yFiRhjG9GZIys6Hu/PaIX7CTzdjTohH
	 VmIR1HSFM9GWjRQgJ2N/BysyoaJJIt9fW2r4CdKihtF+zh5lXO6ZW1ELiqKvQLZl7yNWC
	 vKUf13Ca3ziaB7xM4qyAKuCnoE8Q/IULjZeXKbyo2WEcjF4HrOGVFuhWWJ5/R1VmEwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793173025;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=k8vW7YamAXvfWYe62dGSCyIjpcDs9Y2Ra5QcbR5fqU8=;
	b=hnCobtt1OtY1dY2Nc9qjaUqFSzMnbrKu88FqzDgkbxACChYRek1nTita0hrVGDXvuuLv
	 d1UPhQ2NZOnLh7FwwkhxKhAUjfGiYvswizSufjesrtgi3Ih12aXP5tI9R3/e5ZehhpvlK
	 Xxx78cSBYpIpRO6bKEWbTcEaEyUoDYj51kpaXRwjvN5JN5z68qnin/5O0KyA7nW8Sx2C9
	 Rec3sUCXuGrnIPxCyvBxk9tk9QxB+USr8xR6INLCQwyJav9bkeI9dIp+0nWq+kk/8VhBH
	 yY5E3+yizYGpT8ExmhFQlo4lN4frV+bhjQ1hl3jeIke0C8SpP2BSmxkqxfHiYeb3M2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=DAFNjlio;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="WZ+OlL/B";
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7B0606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 07:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA7B0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=DAFNjlio;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=WZ+OlL/B
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E9B5414000E1
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 03:37:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 28 Oct 2026 03:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793173023; x=1793259423; bh=k8vW7YamAX
	vfWYe62dGSCyIjpcDs9Y2Ra5QcbR5fqU8=; b=DAFNjliogKdYl4iE5Q/O4aRsuu
	mITCdf+2IUgZOL2g/7VPTAK6vib/jyThpSSqvMu4ZLUG1EIRVktrPxG366Wv96Rd
	Yb+dFRy+KRqXLdXNkb+F7jIsWEr7T5K2hgVyYgOLTWqpuPjk0VMga3bEy31f5q9K
	60qMrVuHa91m+JsCnd4/Deh0XOOHYIorrGXbe3Bf6HiU1/aVXPpJ0ZkiUtgyQzyZ
	Ov8O9vVwodqGETnxUR27ah+hZvns3FMynlD1TnuwGTbA3pIMKnYfqtxwp6tLSvW9
	7J0sxm7Lh+xht4MjcIfj5hmOk3X5EoVHJ+q8NO2q0Unz5FRe4AsoUM0kKMLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793173023; x=1793259423; bh=k8vW7YamAXvfWYe62dGSCyIjpcDs9Y2Ra5Q
	cbR5fqU8=; b=WZ+OlL/BX/2kdn4kX7J1KWsIY23oRQ7YKaWbE2USSB1Qm7SLotF
	Fcp+Q2aIBrdB8hiklMHPc8RoeReq/rmtk2qBLi5Ds2HWYeCyibiQK+Z8V+Iq6CIN
	n/rNV+EyuW+/uTWhqLrTvKNjCfRgWrbBGrZhaU4f+VDhpA32OYGWdDdUYcjRpKPw
	+EZmI07fXekt+SNXV+gKebwTJsBjhPVnznygAUlVeaLrLf8DiKcEgGA94wX6i+tL
	5j69rqTGtpraPWdw7lF/OV/M7bC1EeKFNGX1aaulbTTqGLU4+PI7DVkJV2bdfLil
	rH8J4RnzJK6Ew6usjO0h9K7eRxzu9v7F1SQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793173023; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:fT1S7Q77EEvXYk9FzLaDJnj/N41DJ5lqY4aJdKv0TOJCTIT
	qAY4IYfeBfsMpvcr43QXQrkQdrB/MfX6OD/W3LAjMy/TjjIbUCoVz3RCQzVbVXQU
	3yVw+z1Q+kxcni1NP/1+6vQa+Tg5RnDz6XkPA4Orl5mxVrLPgxHG/fYL+rTtWeMz
	bpaUrdSDtI2oALqb5Naeei/SlW7lgvxXYujY82F2L/eFVzAV3A0IZNx3xYqknWPA
	QvrhF2tpG+j5Z2hOOVf+wuuPJ4YzjQTXnfEoNs51kuvyapYCpUfttJb+Lo6Kn0HT
	88+GJCpqUC8XCR4CocbRVVilWlwvcbQ+534KSBQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:P9pFNn9Nnfdsh9iDH+1P6BbPFsOJdm7e/pDpV2FqL+Q=:oCtFVaJo1naKJqWAirAu/51Hd8KDbGyS+FU4QPmf8xc=;
X-ME-Sender: <xms:H6bhamAc6vr_b04ll6FZKjFBZ-Qh_e_uMNDj8-34nBxTgOhjePH6Mw>
    <xme:H6bhangV2_ZK-mXOsXXCKrw0B5E7w4r52XMy3zGLnOu_mFXcPYRlstZoWSpnY2Q8M
    4ExMDZFi-g1eJr-DmpYZRXoPbpBCSQp-jqrk56G7Y1ClovDDHDvf--S>
X-ME-Received: <xmr:H6bhaukBHDnvYw2erytg5glp5_5bCj5iox8JGwEb4byzhrrQdblpn_rwi396E72wfqTsT77J6XKn1ZNEmIbp9UQu6iW1f_O7Ckyl>
X-ME-Proxy-Cause: dmFkZTGB85QLbLhZD08sYc/PGIvwcgYImzgtJQNeF5bm31nRWvs591n918Ga/gKtKaCbjb
    UwU902Vh95LUjKfrV43ver17l/3S6kDAx25gvS2WTzE06cozjO1q3bahRa821Gdv924wl2
    Msw9P1BKQKUozW2iI3g74arhZ4tjlimKBmiPTHrclJIl64ps+91vRF2sDoVrIBJz0Gnm5K
    bv6K7a2prjJy0y+YsKfzT/4yCSPIFTcEJBkhaeLFimtGFswWPRYnVY1K6ZrO3vBq8aHK+2
    Hc9e1gmrq5hxmkAMZSibPU1yFA1n5ib2cSC/Vgcr90yoKPmv7AMXuQbeOEglg+au3U85Cj
    39phu9x9W+w9hR1at/VYjym2qUISpGm6ZkDllDkzSuHjet4JZpKZjx4FWt9XsTpdw5UjLX
    iIS1FxNMf2+6L2pvFSZH44SxIxfTpqOc/lbt4SMbwAvjiTGqkB1b5ajQ5gclbfB9xUPSDE
    y3cC3pOSglIPDxnU6fOaml6NySc4ArmFCsMkrm/WbbjO7ln3LiIGyq96I28y7rtl1zb7Hq
    H0NgjfZqcoaP0l+IYF+gA53KWPZ2uILpukhkos/AxXOXGbRVqv8azUpEodns0CgGO7qX1y
    /aukjhJQc8eCMLgSIF+/Wz12vip6jF+43u5hs8S7kSsaf64biNTvOYZy9Hdg
X-ME-Proxy: <xmx:H6bhajo0kCQEZ8PU7KzHPt0ymbBKodbMECuJ1E94zeRIEz1wZEJsnA>
    <xmx:H6bhanGOCz_te-_pvu9zu6HP8Z_8E21lzOum6kiKKAM_IbRB3DQjyg>
    <xmx:H6bhavx5p9Y9N444aqWfFGMeS8ZzqgmVOA9L3bFqlSOOk7xWxCakwA>
    <xmx:H6bhasprImGPKZlY0XW70EDsojtTMzFizot69BHwhjN3okIH5c9LOA>
    <xmx:H6bhamFFlCiDC6i9lkOupLCDyO3Ns9RuI9oRoStbWnvDyBOEeXD4nkdY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 03:37:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Daniel Zoghalchali <daniel@latchkey.dev>
Subject: Re: [PATCH] pack-objects: handle missing objects when excluding
 promisor objects
In-Reply-To: <20261027-b4-pks-pack-objects-repack-links-with-missing-objects-v1-1-f50f90651274@pks.im>
	(Patrick Steinhardt's message of "Tue, 27 Oct 2026 08:00:28 +0100")
References: <20261027-b4-pks-pack-objects-repack-links-with-missing-objects-v1-1-f50f90651274@pks.im>
Date: Wed, 28 Oct 2026 00:37:02 -0700
Message-ID: <xmqq7bj2e0o1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> this patch fixes the issue reported in [1]. Thanks!
>  builtin/pack-objects.c   |  3 ++-
>  t/t5616-partial-clone.sh | 55 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index ca3a891dfbc..d6caed16d97 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -5085,7 +5085,8 @@ static int is_not_in_promisor_pack_obj(struct object *obj, void *data UNUSED)
>  	};
>  
>  	if (odb_read_object_info_extended(the_repository->objects, &obj->oid, &info, 0))
> -		BUG("should_include_obj should only be called on existing objects");
> +		/* Missing; assume it is a promisor object */
> +		return 0;

It is not entirely the fault of this patch, but the code relies on
.fetch_if_missing being set to 0 elsewhere.  While that is not wrong
per se, shouldn't this call to odb_read_object_info_extended() pass
the OBJECT_INFO_SKIP_FETCH_OBJECT bit explicitly for clarity?

>  	return source_info.source->type != ODB_SOURCE_PACKED || !source_info.u.packed.pack->pack_promisor;
>  }

Thanks.
