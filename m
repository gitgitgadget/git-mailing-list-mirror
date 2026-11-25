Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795635460;
	b=5dVtwuglNvohA+afWqavgF/rwUqAkGgWv+oaLmbCBtXlounmuQlLl7znyWt+IVP0AeBA
	 rhE/s2LFgzYMfslBKBU1tDpYXxwPIx8LcBySV8zBgT2tUFk4vZbIG6vLegVSD7YtkMnuQ
	 p79VoVKTXOjN9yixOWSZT/sleSJZ58bQ72BGbi+evwQNFNbTtxKR4Q+va7S+LSMey19d3
	 0f83Gu1kLiYZ4eLMyKV3MZLVUB4XYF0wvofb1Tv0MnpJwYyh6pdqp9/2wdwfFJytZlkWn
	 V2Xh6rxhVyfHBv/UMgc/26+fAfb+kQc+bwBE88ozloOHBnS5ERndY5afRFHro0LT4IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795635460;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=fC1MOit7M8i+caNJBcSY4+8FieSvckK+YMX/VontH5k=;
	b=Q3mLxSe8b2yqMZulcF6S8FDpD1NOusrxCE0yhUs9L3pLMEYszAISmfA3xP6Wclgr2Pw1
	 ZUyCa1AQNRObm95Lh1tVxwofqDGpZUW9uYUvJLDsyeRYzl91CYKhTRPamHkPhyk67UmSp
	 MQIJxpNSpy21BCv0ZNgbunlm0e/mpLY7JHgT1JI2bnnsUaqG4bd9kHh7lIuepxDVSA0eV
	 OvPVZlEjO8MCGQbgy/WdQIoxaqO9GWqsx0vt5ysiTZ2YGfVl75TTQeBhpPtLvvxyw9Hn2
	 63Y35nbZh7GsfJgi87BwHdPEKnXY72w4sufL9qr4zPzfaX4NM2X12hQsA0anP66bc/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=CP7x2+MZ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=afcNoaK5;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8555B606A32C
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 19:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8555B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=CP7x2+MZ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=afcNoaK5
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id A712BEC0C45
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 14:37:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 25 Nov 2026 14:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795635459; x=1795721859; bh=fC1MOit7M8
	i+caNJBcSY4+8FieSvckK+YMX/VontH5k=; b=CP7x2+MZT6uiKS4OSnOKOqwYX7
	CY8Ef4muFLQjbKYJVEW9jdKPIxl1cCBBO5VJXPYvftg5gPUoUZqsu/xbD1+C2/LG
	qOdtLYCLvKhWExO/COx3uxlVJoX14zflkS4htJ5A4lacQpaRSftIpWwU53889d32
	tAgOZVWoLfswsUPk6mMk9T/ier0+Uo+NgTPP6hN2TuJ2ee3JD8Rzbi3uq/VfqehU
	LxDBkiXnktrdmJPOkvTgSB7EF04n7fXCff5GducVfxwam0/BEWI0A47fuhOjrt2O
	+9mEXml05XarLnhudmX8aI3sBDCA3n2tKEQ3OaQslZdbQpO8WXb38+QntHDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795635459; x=1795721859; bh=fC1MOit7M8i+caNJBcSY4+8FieSvckK+YMX
	/VontH5k=; b=afcNoaK5eEwg3k2XTefG8N9rsorI168EYnoH2yJ6Qm8WwBKg1Bf
	PfQsCoD0xGdWL6lFfYRv1TMGdiv9L7tUwjJhXL80z+pEsSxX+/zpjJIPx0+iZAoF
	tZy0h4d7KyRFkoXuFQD7zxuQg2ZTkzWLz6BD8lgPTNFLInt1nN4Q1ftvfmWhYs40
	++KQIejVozg6HpQQx014UT6E6CrhMh7Xz1UhRUpZs0sp/jKagN1tDhEymt8NHzzJ
	iWUTu+Tk6AW2mbicMIwZxsgKrhpYj4QXsmCjouwhepLLohGNGDQuMyXNsFAWVxp9
	8WzfJ0SkKcOJvOztef7OOy/nDnHgvRnmLWA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795635459; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Puj2Rio7eswyCWMiFuDxSr2l/LfN/g95qmU6p+VtWgOqyCX
	4iZJ+zbuFB0sJCcc3AvRP9KPAK34Wp8rAlPDszQlTHG/swTflkCWGkxhTajUEri0
	zd7gLr/etTgPj2fJB/u8E6/lMAZTm/lZROeBB10spZlfodVypJ2QtxlTC0ZyxFjL
	iOrFMSDycZdzEW0/HgCBAaP5G2jpuGCn1DmZRvJ1txLUGhnd0XdzBtFQSBXNake3
	YmqP+/pUsyb9Bxls2hemphiOTVH5i3jXSGC83cVwRfrfxgRAjpezJ7GgCyW4IkYu
	fBWZgqPvAJWVxG4hle8TJpDDwpxRdNznc4zOA3Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:35q/QxZRpG24VjMVM4/fhE8qrel+c/XgAviG/QManE0=:fC1MOit7M8i+caNJBcSY4+8FieSvckK+YMX/VontH5k=;
X-ME-Sender: <xms:AzkHa_C7nsSMLnbkp9jNi6vuz0HGTcvkkP6X4HIkaxKw_kGum_pSwg>
    <xme:AzkHa5PmIK20ut6blb1ihPbuXgCjOjIF_Q-Cx0pYG8Kb5Oftr2gZQEL0fFgxTFqGD
    FTXbF6epijIyMgOZXIYIfJ38pgFNtVWHYC8PU8pIoUdlJGzwZZN>
X-ME-Received: <xmr:AzkHa0aZcZh4DSn1pqoPvJqzDT33dmd4gAMvq85kBmsFvqL5xROmnWEq2oIS3mYMLy49bN3QfH-5BdPW7-B8k1xt5jqy8T0jFv8_B-A>
X-ME-Proxy-Cause: dmFkZTFHEK7/DfxJb0qiAxeZinRZFHC/RbM0MkyxyI9tLtWwNQwZOYRDM6bThL/SYe1gek
    02FGNczRn1mmpQaO/HI/rj1WzyETtC/bt4CtQ625TlJWowdleul1zSkQ5ywOgQpKvQKY7a
    ijFR6mpMNOkDmiDX6+N4dBafWMu90XD3Q+Etbph8AOf2jMLTevmHo7EQ1OkCBOLXcjE1cf
    YHwXL24C/0nzdVTwCv8HdkZNhLdV6fdxUymljkpsrcSpLpPHJTWrnsgugL/nEkR+aqjiAM
    pRX+TVFhozD6RxnQUjlClGmL8nqBn5UDw7mqrIoBbHjvyPPVUZCcAwIHUlLwIIuJuwZiKs
    eCZ4k3d325sVZKj8lwefAcGf6Pysx+tcoCkZLjW71JiYkW/PfA1dhDuR4tbC7QiYjC2DEP
    51kGn7uLBjI+t1pbca3+xe2NPJbUbLsDMlpitCl/g+3YWvbwjDrzkMo2AanyR51ccNnxaM
    nwjjn1dj+mdv/MAbHrJA5MC9S+9wjFy6M2ZESW8eyHvoVXXFNYhPqx95toxmUUgvpbqkiD
    MQnL8Ot1sX0nyyI0sFN71AZSEuypHsJ1r0TtXvM9qt0oJoAwu1m3NUMFXBXxgPvcTd4eSP
    sKIDyQpBlngiywxw3o1tywiFwQS0RYtRsJILDGDokp9K2BtQNe0DRfIZMcww
X-ME-Proxy: <xmx:AzkHa4uWiNwzLu6TSgSsTSldJAuHmHvfE8Uer-ueMpOH_v9ZbYn7kQ>
    <xmx:AzkHa2PKAlZS22-PG4hm1yAxRIfmHQMgHpYV5xM2cLcSCe-VTHFO8A>
    <xmx:AzkHa_48eR1xx_zbmyXbzq3kpEqDnN9E_H0eC5pborggY2Jbz4ho4w>
    <xmx:AzkHa8SimwUtqo-n917YyJMMnDqGbABdVbx5C5UrMYy0lXJ1LBRTnw>
    <xmx:AzkHa8WO9T-J4akSjmt0h9Tg-5AajUc5baL7Ock5vpU3HybA0iKeEuf7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 14:37:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Adithya Chakilam via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Martin Fick <mfick@nvidia.com>,  Christian Couder
 <christian.couder@gmail.com>,  Adithya Chakilam <achakilam@nvidia.com>
Subject: Re: [PATCH v2 0/2] repack: write filtered-out objects as loose objects
In-Reply-To: <pull.2314.v2.git.1795571091.gitgitgadget@gmail.com> (Adithya
	Chakilam via GitGitGadget's message of "Wed, 25 Nov 2026 01:44:49
	+0000")
References: <pull.2314.git.1794607911.gitgitgadget@gmail.com>
	<pull.2314.v2.git.1795571091.gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 11:37:38 -0800
Message-ID: <xmqqmrqw1z3x.fsf@gitster.g>
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

"Adithya Chakilam via GitGitGadget" <gitgitgadget@gmail.com> writes:

> git repack -a --filter=blob=1m --filter-to-loose=/path/to/objects

Shouldn't this be "--filter=blob:limit=1m"?

> The destination is treated as a Git object directory.
>
> The first patch adds the option for objects already stored in packs. The
> second extends it to include loose objects excluded by the filter, so the
> destination also receives those objects. Objects already present in the
> destination are not rewritten. With -d, the source copies of those loose
> objects are removed after all objects have been written successfully.

Note that as implemented, the second patch only handles blob:limit
filters and silently skips loose objects under other filters such as
blob:none, I think.
