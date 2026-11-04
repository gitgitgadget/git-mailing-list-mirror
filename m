Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815753;
	b=wJBTXsMZFUbvYN9w/dC/rrrI8q7M9Ya1G3SpfdwlZ/2MclDyMB9URxq38BKnavOJwAmF
	 vsC7AHWdf92lQMVrgCWH+XVWrW2ekglOd7UO+i5R5F+50e7alqvG8p7iH1oZK+uLjK6+x
	 4xoZ4WNzVLGGCRuBUAmT90IcGkbXE1+Jizx1nHL8zXkFiIdlsFcSsoal9tju+myxoiwan
	 0fztUFrH7uBUuDxuXRIESx3gcoJga36Q2aEBgUzIDv4vHXEwvtfiON/r2S+INOB+1X9eW
	 VunqTfdE/WWZ/dAfziC6UYd3JtBJeFPqI42DJxzLEpS0cRV01GsBZRpPiCSQn/xkkrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815753;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=bVRnXPxLJevxEbzSe3eHd20qjZJwOeK/LZvOYYpCdy8=;
	b=zBTOgXzZ6EM9fyGlqCedn6jfrh93FHUlPBUE9Pxq0ZUgeAPhIIlneYVRmcAMNGoUWj9s
	 uJdwnTbaff2UwB8lcP4xLZJzm8rrRvbTVENtUocqCj+/hUGToMVCsA5AO+jr28tT/+6kZ
	 jIp91sSHrZWChQWmwwMSmH01r+9reCQ30IolwtswfsOT2D6Y3FzFc40VehGFxnGE1Po91
	 7QTgOcmH4TrVVUR/i65pPK1gaTQpQQWKYiN+gqUiKPUQVEuFUiiklCqghJzDDUeWyXwA3
	 uhfE5pLG7sFWxB0oKDZ1Z351NO46FqY9U8ztI6h8x9S6Qa6j7LLObPXVCXGJxgoAHvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b="Lh/TL87Q";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ESkEvxz5;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C697606A7FF
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 18:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C697606A7FF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=Lh/TL87Q;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ESkEvxz5
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 41993EC1AA3
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 13:09:11 -0500 (EST)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Wed, 04 Nov 2026 13:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793815748;
	 x=1793902148; bh=bVRnXPxLJevxEbzSe3eHd20qjZJwOeK/LZvOYYpCdy8=; b=
	Lh/TL87Qx+pICHb553CoCgPHE2D7P7apVITkGO/aHf1X4xNrcLFW26f5NrsgiB+R
	2WyVQY1VU6tViKDThkrDj6TcQvswe9tvlQUg/TUcQcsfd2KT0sJJAC9/ss/NSzdN
	0vTskSe3CRGmvLwjolThCQgAsXgAH4VPqddbqHUdYg6m9R/mywIrO2c2Z0TAkC3t
	eQe2DK324c0HT6ZsKhHU3jb5Y9mpeWnKAJiwxC3kiyfTyRpuZ7WzMR6jgRTgaLYF
	KCKmyIcnr1HbSzbBJjKTQR4UCNkqUYRsxodi7UjuCGTnFWULxJeE/UQnAHZr5ANd
	V5+zR2OC9vAFb7g7rkOeBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793815748; x=
	1793902148; bh=bVRnXPxLJevxEbzSe3eHd20qjZJwOeK/LZvOYYpCdy8=; b=E
	SkEvxz50Xx/SAF/44ubR0fvMYeOev6QbApFg7lfuv7CY4k0lRp5bhBDvS273PeIq
	Eao8QnQm1NUFrPzlNEEMIcBHt0M6PlokXjB1WwNjC3nyEiffppLxSIaMBjB4T9mU
	y4t4c5+8mSWsnKWr8SUXQ7YQGFk+R6FMLra/nkwgLOZ3tZjL8diCacUJDO/mFPVl
	kL9IXfqABf0CTSK0E70FrHMNroSb6biRCdPa83f34hsnInk37CeAYs7pKnFAUz+b
	lILRHroMPRuHw0FYQ596p8yZMdUhZZqpIB7yY/I/3PT7kDKTw37N3BpObDomQdPd
	N8goQbk0IA0+hNYhMZ9ew==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793815748; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:UPS96q5NjIwOIywkkFpPlhHwUduAixmdWBmKbjWi2gfUUAF
	yJcbeLXCKSIITfYTkX4v50l81BUXwv1wYFClC1fIy57SMV+6wRYiNcBcB6f4Pigw
	KeBLkcHeVEU8BoUHA8VLuA6bAO+lZxNiNOJKES5jYBTQnaUYgnbnu2NKBn91gdqu
	SxpNQfUZ8PLuBY6uNp/DRt0zjQrb1/ioyK0eH6Rgy/rGP/5UTz+rUmkLSrTlVMsT
	H7b96kzBjfXUUD5RWR4Bl4U+yxbaDnNPu1VP6Vp9x/nJdFe3PwnzbSKXu09WJRjT
	cOQg65n+Y2elmC8JGc5u6kz8a4pT57PvuGI9p6Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:LBgkJp0aiD41/p0BUgU4IFNLF94QpcmTP+5cjpo3f2k=:iFYbuaywsGrlFD6UFOcaQbu9arIHD4u6XgrFlLuBppA=;
X-ME-Sender: <xms:wXTraiYnEHfI05A1SVyCHVwhPB-yLgrweQWZ-0ekH2Y23I36B8Do0ls>
    <xme:wXTragOjoxu0LMNltgSiYtH_4-TD-NwLeuIh7fcJbG53JjERdQXSeWoR7GlfHbnYa
    TdXqalEUm4lRoK8vnh6ayQrTX2S4WuQj5Bo7m9sn2LXfoZNTZfBOw>
X-ME-Proxy-Cause: dmFkZTE2NjzRzq847zNrZ7Jgy1xR4jS5bLS1KDeiDwwUVMM9NBRYqVcsw5R3u8tzlklO54
    WkMKZWUGr6XWFLsEnUbV2toflNBXb84Byu+Gk4jBEvPARkiyYHam5zG8C2OJxrW5+SKcHP
    b+/9uoo/9KARWkT7b3s9kkEIcLpf41ihTyDKIfxmojIsKSgk2wboAvOxAbCojyfMtHkn2Y
    pPgFbJiMIGxYVWZJddAU85S5qoPsC8WU+BDqbwoieOWtfMRV1p70rS+Gx2ePzoEJkAAtN5
    VkHxfUZQ/VNGGO70xc5/uW09YXNjQ/LbGZ72LNg0epUlYHOINr2rQ0x6yUVLc1zaO1OPqq
    xzzEOjk9W+7ZRtEDqHyGku5lV05lgrb6OG+yzBgLGAszWWU7Arv1l1nnTz3Rut17gRidGb
    HK2KiO2cqs9i8ngsauRkHBdh8/j7nEDSWyFj4Bovc8bmqVVtaFQtMhwjf0THh/G+5Jj3jS
    LEKq1mGJ0+Fv+aFP2qCb4etbFngd83zumqQcGgrru+4BeCROawgi5Viq++CHDAaWb9i0j8
    bxEHAx48dwzWqFUEyF1N9JcHd1ixTpwy/hI7wUFGUbcfFg0M4nvZumkY4/ebsVuIJqcPrf
    xaH4ui7Efv+dM9qroJk2WQomdDVKc6sw3l1PLiLdOCCYTHm0gyeoGhcSiEGQ
X-ME-Proxy: <xmx:wnTraqE1tqBgb5C6Gsc63ZLw186F7HoN8h0KoNawKg3WSf0brzOvKA>
    <xmx:wnTrakrrHBQghaaAxQpvybQA5-UFAv1kgxfYuZkoDXpxsu6H22ad3A>
    <xmx:wnTrarZ5Ygak1Wg3iboYsBKG4y7vj-kdlnzBTVeMNdWhO5nZa3Yx7A>
    <xmx:wnTralV1P8iO-XnRo75_RTNNWnqR7kezLHWEyi6UjySIYHykc1L7Ug>
    <xmx:xHTramJIvpg-ezOpv18shkNL5xLVG5iyouEnfyX0MhXuay1NECHapIWB>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 4FA4D22C00A1; Wed,  4 Nov 2026 13:09:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AC1ZdHX1Xr-V
Date: Wed, 04 Nov 2026 19:08:44 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Matt Hunter" <m@lfurio.us>,
 "Harald Nordgren" <haraldnordgren@gmail.com>, git@vger.kernel.org,
 "Thomas Bachem" <gitgitgadget@gmail.com>
Message-Id: <fb9a42b6-e2df-466d-89f8-77c06f3b45d0@app.fastmail.com>
In-Reply-To: <2D59CFA3-B1A6-49E3-A930-C3057D97D507@gmail.com>
References: <62095245-8121-4698-b1aa-ff239286d9e9@app.fastmail.com>
 <2D59CFA3-B1A6-49E3-A930-C3057D97D507@gmail.com>
Subject: Re: [PATCH v3] range-diff: add --matched-only to skip one-sided commits
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026, at 19:00, Ben Knoble wrote:
>> Le 4 nov. 2026 =C3=A0 06:27, Kristoffer Haugsbakk <kristofferhaugsbak=
k@fastmail.com> a =C3=A9crit :
>>[snip]
>>
>> I use the
>>
>>     base..old base..new
>>
>> Form as well.[1] Then it indeed does not matter if you have rebased or
>> not, as far as unrelated commits are concerned. You won=E2=80=99t get=
 unrelated
>> commits.
>>
>> =E2=80=A0 1: The repetition seems a bit inevitable and annoying, but =
I use a
>>     script for assembling all of the options to git-format-patch(1).
>
> What repetition?
>
>     git range-diff base old new
>
> ;)

Oh. Right! :D
