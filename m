Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793196700;
	b=tgqPN7kBp4KEIjb9tVxMd9Kt7pdJhfYEjk53iyC56c8Fwqei/yLWbSJ2jvwdoapDPqbJ
	 fY5f+QdBsQNbphvq/B/02Zvqens0Z9B6t6dadTRgg2jLjBbShD6RN1tj66wkZl/tcZ8gl
	 VMbyWgNR9YHzmObtZFG4VcArZPKcCK1p2nLKmKlGc2Ur4KBSFZaLe34qD5eTLmZL+gKTO
	 FK5/aGSx1QoRT/T3X8k/Z0vPFIxwF8Js4rvHWS6gP+xbZq8N1Kdwmqt3b2Xk1ESGSmLig
	 aTOU8vDadhe1ndgP0F0lsq0DQOpdj5R7NA8lLG5r+bRT0JZ/3GuIKLyd4z/RJNp5zyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196700;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:Message-ID:To:Subject:Cc:References:From:In-Reply-To:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=P6mAYJAZM+99AEwvuwBh8uJQltnOOvPG9q850XH4Gs8=;
	b=UBR57tWpeXhNk0igTK6bDvP14V0weM2gaRZW5AR5HpuG4tV2F7VWfoDS6wIgm3QRLhaM
	 h+sjbFFXpT4zf7FjM/o5ORotItjLitiPFt00eb4F1KDQ+e+qE20/LhuiB4aZPHJrqJ120
	 OpBm5Y0bSsD5DLauCCtq9pFptPUtWsNwQWTepmPWpCpJotv4JdD4EnYeM3oO40uIIMwt6
	 bSIg331HChNaI4SvrvTOMAQTomlFGeO6jTtGyHt8nE4bG/ei+mbx4Tziu3ageyhf9cehF
	 peVg9RcNgM/GF6+5R/rk7njWl3GZpjPQQUUinIkbyrL8l6wR/EG2Ye/U8nwSKQ8SBpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=hGfTPO0m;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=nT5vie9i;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B01D606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 14:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B01D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=hGfTPO0m;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=nT5vie9i
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 8B56F1D0019E
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 10:11:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 28 Oct 2026 10:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793196699;
	 x=1793283099; bh=P6mAYJAZM+99AEwvuwBh8uJQltnOOvPG9q850XH4Gs8=; b=
	hGfTPO0mTdkhFijHRnW9JOwILf5SXiAnuux8NIX86s3Fgxuzp0qdCDRru+PsNKRl
	Q1ixHWmYXwgcTAB/LAJD3kaXLMJtgMkXn1N0Li+ifVTtkm1c07+qWVA0I/qsQefg
	oROdeTPQjUGO54Jv59VCf6Rvh0lMlRhFYYaKSxUFehHLAySuFxoqNgXDxTNaN+UJ
	4HQxuyb7FqakiiqsZ2WiAANjtRGIp2xjla6BdBmyf4vNRzYAdDZ3nucAR4ONqeks
	ZtX+0JDmH/nChkxqhi8ZrY/iATzMseAaSbNUinw9xj7nx6UUnXT49fgkDRtWWySx
	JSr9XrXP6EetAN10OFDuWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793196699; x=
	1793283099; bh=P6mAYJAZM+99AEwvuwBh8uJQltnOOvPG9q850XH4Gs8=; b=n
	T5vie9imkacfQm9Hrmyo8pOTMnbBCWj/OcimyAK+vEsCaYIuTjrSwZfA/PLdTL/b
	TF4OXDZIaufBCx0z79EtLwWf9AGJG5xmpxjKfxW2WP1gm/Jm+bAQpTXFlEQIyU7/
	kPn6mPB1UH39hO9Lj4xCHhxo6sKgwylQ2sh+IQ7dJaMtPIkBGj+mGswsn2Zjkdap
	gXuwqQ/8AeEbJAXCczX9R3whlkzKypuC40vp6QdGodjKCkZfLDmWqqGFRoNnHvxx
	L/TM+reaTe1JXysGealFhk4UQhpi4XTlbvaWMJEPQzWW/U321ZIeC4ja4cTJVUxn
	ZFNM39zBH4n7AGkLjVtdA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793196699; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:fx1kSrS8dUrXavMPOLrNOCeoMlduRRatqouuevSiPRVUXVT
	cQMO/Bwc03fReMjkt4ts6Kud1ad5WtXyTfLDAeiGMH/+np8ytKUDvYKvdM/qHMsc
	R1QVjUoAgkOCkZc25zjEcDGKQgkedqgO+nPe3gpbJ8v+M0jTiT/9wt3y0VHOFmcC
	YekEf+PLSkHwqV9WqzTVHoB9cHxD7/3Cbs17Q61rvCmFZPRu7PdzqTlMA9x/Wvo3
	d7KevF2UlQzdnlPahh0p+U9nMdSw1nUZXA7XirEb07IKpge+vMjtzrjgD50WFHI7
	cp2STVvR41i69WXftiMcjQZYglwhkYy6INEc8BQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:1neelh6NGPxvAaEKY4fC5rVz09uJjnZBu0j0cAdeDW8=:Qac01IHXwL+xsUjgEoEpsNB6znj52lBL8dTmrJ8pbOg=;
X-ME-Sender: <xms:mwLiaqI2iTVz1AzxkCclGIbmC5MPqLMRjsV1Uqz5F1356Pf4a8kmAw>
    <xme:mwLiapnGq53qk0cdv2tSHNepWVJnz_UH_B5VqFomXH_QXCg7ZEtCHg0X7Q4Vum7nn
    _PztAe75hkWqEHiEVc_8cOJY16iYTcNlMNh3umKED-psJ3LUsOMFJ2F>
X-ME-Received: <xmr:mwLiaoENG24TZzwMY5_yrNSYEHOqTqFOh-gOATx3iY74p420JzwAacJHBGY>
X-ME-Proxy-Cause: dmFkZTGK+kKfiqetnAKZuLHdp6BOYF8vDLJnv2C1JfX8sEy5+GYUEKtjtfP11DCWfk2G+X
    JmkISjyVuYtLNvCBMH3kYQYlmmV/9KoH6VbCedfXjAbPZsT2A2bl+VR45LlAR9uDKIz9yr
    14Em1QfbGf5+rsOB0ANdoOhmW/OKU2GfB21Mm6DaqofhAco2n1ccdbybSBaTx0t3/Fsbdy
    M/BVQrkLH6AFles74gQ15JQQcIJJO+P7N0RP//j0BzSQeyXcpuX//HtBeIMOYssHr2fYKp
    aonvfpbN9SYd6av+qIVW6WtP2n2Eqr+MZEaJ5IbGzo1NCP1xcOS62yodo+3msRqollySVx
    gamiCLD99KU7YHepFwmSUQzvlVTiJVGIDN14pTUB+4yA4/ILQZIQM7tDyG0WUw9Ve26ja1
    8TZkBsF3aSJWiH6Ne41IIyGRo/fzhuD/pO3F7XxFczeyu1hIanDG1VkEjcUz0NXCzkezFs
    K9/H4LuAaM4nrzDSWetw0zZerX0LRNZEoa12Lk8qyPY0EI8HXp8yaIfMJ/+lrcYsFukwI7
    8v3WXqlcsM3zZbFKPb/D5/l5HOUNcPFNJHgvfUaKJeME7zvbkJtNjrz1CKue+hBZykEBrH
    YcAIANlFZ53vrm9dR2yBWQtGu7hDdJ3Fbl2xeeb7PnNP/ooENXNCaMXRPSXg
X-ME-Proxy: <xmx:mwLiapEpXWmah6xxKKZg01ZiNdT9uep_94vE3sfL-nfYIg7zi1HJeQ>
    <xmx:mwLialN0EApiusFogzvbOFEFTlBw4-V1YYE2B0b__PissNPMyUhCGA>
    <xmx:mwLiaoGamVLsUsoKN193dXBc7RwURSt4u4SGBnGT4FDOsB6VisyglQ>
    <xmx:mwLiasO49eaZClUlPn48EpVVPzTfG_vzfGjdYV6X6jWW9eqGiiW55Q>
    <xmx:mwLiaht18xiaRT7_KGnyX61iwcfbKyv8r0BB3BXXO2IbBxhgCHMzhqCf>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 10:11:38 -0400 (EDT)
Date: Wed, 28 Oct 2026 10:11:36 -0400
Message-ID: <541b09ff60a5acd851aff471cf6fba75@fastmail.com>
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/12] rerere: convert flags into an enum
Cc: git@vger.kernel.org
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im> <20261027-pks-rerere-subcommands-v1-2-d836c36ce0c5@pks.im> <c23c4593fa3add2b40613febb2911cfb@fastmail.com> <xmqqzevzhqyq.fsf@gitster.g> <auGzVZj5vbVm3-xf@pks.im>
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
In-Reply-To: <auGzVZj5vbVm3-xf@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


On Wed, 28 Oct 2026 09:33:25 +0100, Patrick Steinhardt <ps@pks.im> wrote:
> On Tue, Oct 27, 2026 at 12:40:45PM -0700, Junio C Hamano wrote:
> > "Mark C. Chu-Carroll" <markchucarroll@fastmail.com> writes:
> > 
> > > On Tue, 27 Oct 2026 11:46:45 +0100, Patrick Steinhardt <ps@pks.im> wrote:
> > >> Our modern coding guidelines say that flags should typically be passed
> > >> around as enums so that it becomes trivial to see what kind of flags are
> > >> expected. Adapt the rerere flags accordingly.
> > >> 
> > >>   <snip>
> > >> +enum rerere_flags {
> > >> +	RERERE_AUTOUPDATE = (1 << 0),
> > >> +	RERERE_NOAUTOUPDATE = (1 << 1),
> > >> +	RERERE_READONLY = (1 << 2),
> > >> +	/* If MERGE_RR.lock is taken, return -1 as if rerere were disabled */
> > >> +	RERERE_NOWAIT = (1 << 3),
> > >> +};
> > >
> > > If we're moving to using enum flags, then wouldn't it be better to
> > > explicitly add a "RERE_MERGE_LOCK_TOKEN" to the enum for that case, 
> > > rather than have this value only documented by a comment?
> > 
> > Perhaps you misunderstand what the comment says.  It is an
> > explanation for the next line, i.e., it tells the API users "If you
> > want the 'immediate failure when locked' behaviour, pass the _NOWAIT
> > bit".
> 
> Yeah, this. I guess we can help that though by documenting all of the
> flags while at it.

Ah, yeah. I misunderstood that. Obvious in retrospect, but I was
puzzling over that for a while. 

    -Mark


