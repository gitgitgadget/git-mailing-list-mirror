Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795374943;
	b=WVzsPFb0KWQIu7OCEOr7QoNVTXCQr0X5WW2r6RSC5l95ZUBcsMJ58pdPo9jMmd1zKfy2
	 r90xMLHA70UcO+v+/XmKxvm0x1Ihobv92rsj8LPMKT1SArncdJZo7osmGNr+Mwj5QwpBl
	 qvOu+EsOtiqrVt4xsgehreFssgNOcd5HVBY6N9F5BS4OlpbdzrvnEB2NTJENHy8gsWORX
	 +aKcpMNI4LS2/gEGdcMf3XyzI/FQimMuC5arhL3QI80Uwe9hgRU+eYBsqPuBXs2Y4TyFc
	 gC4w6jpgfDr+wQGm0nSGNRPex0m+/8uLBRGiBVR9lGQLZo1OcO7pWKm5MoiCFG2Wcug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795374943;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=O6uEAvv3BrsmbSH4gJ1rEMn8bA2eKBcD99BWeTaNtlY=;
	b=nV1fmLRi2Bn6+e1Pq+JlKbCFZxn5+VdRnhE6XJ5axuCdjAFXqh2HXBdrdDT/ZCCb5+l1
	 iGD0KfvvJy9p3fxS/QDs7TzWNsF8iVLcItiGiAxozzK5yBvLCIr3rEyuRYul9A/pSBMe7
	 nyjiFGoq0FuWQJYXBjRTHC5y0j5i1nfWHCviRa6jbRPvNFwrTMzVjHLG6rbj9EaWYsfvx
	 ZZmfO1I9zFeLkZ2+/2gw3pbu4mT2ycTgcF7lOHNjgGndT3ABzgiNbfuE9ZGYYjhjVKDzl
	 UVKjHGScXQeP8fkUJedAXoIKBSg0iO6tmq4MNaVtAhBcBlP2TKkw3FNHMquPju8ZGag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=jfH7eLLp;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xS63761+;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77EA606A338
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 19:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B77EA606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=jfH7eLLp;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xS63761+
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AA40314002F0
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 14:15:41 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 22 Nov 2026 14:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795374941; x=1795461341; bh=O6uEAvv3Br
	smbSH4gJ1rEMn8bA2eKBcD99BWeTaNtlY=; b=jfH7eLLpPmE9uEy6g5rxUcAjWr
	t9tS+puisZ9z/ZZwdRYEsU/7widfTTNEWyeL/R82IzDEwfR3Aim+xEyiZxPpC+kL
	BUDGCcWT6pNccps//1ln7cLoHOjBw+UnA6SXBpMTFBO6g7HVstMyusjqDJbRr1dE
	oyP3X+4VVcgU9jHrZTMhzyDI+6vek1rcGVy04fGpSePw9V4YQlsuqwFjYbB4e4bP
	Ik8DMabO2Ij7g/MYaUwBEBw2WoxQ3rVnu0C9JiYy4V6NrMK8ETvlWfnZHmseJpDv
	+4LyAnLEq8BbJyIi5eYrpJJ2BsYKJfpJqmNRbOVOj0t9h6SKBP/JCsvQCW2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795374941; x=1795461341; bh=O6uEAvv3BrsmbSH4gJ1rEMn8bA2eKBcD99B
	WeTaNtlY=; b=xS63761+8Qa9ocmoqosyl940Q7ScX16eZHjaic3nRPETkDJdD+8
	5DE8geuLy3txhOiAV2cYls0nIwEh/RBmFDycH87HZMM3gtekpiG0ndvRr8AV48+o
	reMWWLUEeBq3qpdKK7AQOBulRm0e8B2Wh65lmHXSvX45av2NPJjMIMp+ABo7N4Hk
	QOf1E+Aa3kEGIR3aKRxNHk06Apylhf8JudvfyxRebpu6tzQQPznhuCFV9/j4wemo
	wOaqZzzAfJhdQVY+GfYZS1GOhL+gyZOKDYqk6xRyGpoooTf5qT65eb/7wa+9tQ6L
	z8EgyXoMomQ4+Rsfb9tCzyV/n7kdLdJ87tA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795374941; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:F1Q3qG30/zb4LHIlEAaCG9Vdn3KekHdugf7aBmNvv94/a5T
	yhCRsZA6gFHo+2cEFvcAJBfWFa7/N8eQukseDnm9tnEAFrvRBKxYeiSLfxFIFd7B
	AEsJqiqZGuhZWNB6cNM8UuH4oiCsWuVTRawJrQyCGDLf4L9CiPxGyUJFdT+wjzJt
	AK7ls9sQBe8Pl1dwgpt7b3zTlByJHi/2uI4V0HiLB+rt6GTRO6mcQ/fN2cyBZW8/
	M88nfy6v5rjZTxkaR6Gqt7mfl773DtgsXAonbhFSml00Iumesu5dMfpGsHQDfebl
	DeiANpgWRExy4hxZlf3jQzWLC5wbm/1qOkbeYTw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:hnTLydQbvgZtuDpthYbhfy4yW99p7mW81aWzJzR4HwA=:pkfGHp7XYAF5kTHZOaPUhH2pubSh0zkapblwJWwEDAk=;
X-ME-Sender: <xms:XT8Da9zAQE1do5axBoePHVUCdb2PGVcQfy6wF0JOGKLoVOEtNX9eAQ>
    <xme:XT8Da0SG1ge6k9tRNs6JVf3dSIaLIMBLz1KhhBpl7jGvr85g0NMqOZS9lm_EfTsb9
    i-Y-IoaISnaiVTPFEB9PfTlX1Trs4h80ILspd8bVZyyy4UCfgLIChgw>
X-ME-Received: <xmr:XT8Da8VQkj_ap7ibxs5DdZ0qquBY1fYUZ1eYzgSuAAWbv-eaF2bIAroYl2F4kwh8zKz4ILQSMJqHOw7pIU0r_ALrBFJshwvtq8NAyco>
X-ME-Proxy-Cause: dmFkZTE1fT8fLMVqi6cQDf60jKxgJ0t4mmv/cUGycmBIAK6k7MgjBLKCdD7pZRoPOfDk31
    sDH9hnwBg3cZkspqhXUU+ubpi8o3/5FnfTidDMcSel3g8peRvvLyykg+f/QZwy8pk9tsAK
    kQvxWtp4Ml9EtZ+M1eNcOOJH+snl9xA7OimJBndgCkDC1DLaHSEE3riy3jTIk1JhtTs0ma
    vCJapOdyADTB9Fd0dEJ0i28eTfSTsgD0GpHJ10k/J1AxUiyJeclzSVAa9Rtn/VunBPCT6L
    kqC8z12wZ9y8Qt6yKprPDBrof8DB0bTraOEf9nu3jVjbOpVqP6IAqutmf77vXudgQla9Of
    H0xlbn0neTyR0OZkr41HytRQSP58nAOAh7GzcdKjbyMgCy8llAVQXMUNHuWfuIa7cMrvOW
    nQY7C7ZUaGWDdUV0txXIvU54/MPQpBhdL/aFq+hfQSq3TjSWcASCj6uV4A3O3RcpJwt14d
    dBFR/LBUAq/6LoQ5fPYRcZg4zoDklVCeG2QxRlEDzbr88dovFjO5pdtrDTiBerGX9Pobc8
    0A9qsOv5gNqXkfqGUY/M6PAFwb9pkm2K933djKMM0eHPEcFTdH/5QmhZgkiOfGUQw+PPQR
    5BKvYtjR3I5x5zQ8oAfb7oxnulSlB71hMHEEFYn81APqmm8e2InOFvXg1jAA
X-ME-Proxy: <xmx:XT8Da-ZvmaqwQtmnw4rzB2XN5o96rVVXmtL3lLx68iapDdu_Mv7R3A>
    <xmx:XT8Da61-JseTV2CSWv1-ExVdIxdU9eeai5-W_2Xq7fj_ayhAPPLjOw>
    <xmx:XT8Da4irRX3k6zlLMrj5a3OD9Dx7k9RSsGSoFVxfuRth1zO4Hg8YAA>
    <xmx:XT8Da2ZMEYja5C557pba6E8k_ZkI2Cz3Y68HX9WqzdJlm4nzN86NVg>
    <xmx:XT8Da7WAuJB3niI_fx-JAQ5u4Nlu9d5EFwXJU5lUp6t0EH_2klwYWFke>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Nov 2026 14:15:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: Dirk Gouders <dirk@gouders.net>,  git@vger.kernel.org
Subject: Re: [PATCH v3] doc/gitcli: minor fixes
In-Reply-To: <CAHWeT-ZvrBXJTJWuLNsw3S_Do-NCF_MxVf80mWbbuoKtxdF_7Q@mail.gmail.com>
	(Andy Koppe's message of "Sat, 21 Nov 2026 06:42:21 +0000")
References: <20261114201632.103400-1-dirk@gouders.net>
	<20261115070357.113875-1-dirk@gouders.net>
	<CAHWeT-ZvrBXJTJWuLNsw3S_Do-NCF_MxVf80mWbbuoKtxdF_7Q@mail.gmail.com>
Date: Sun, 22 Nov 2026 11:15:39 -0800
Message-ID: <xmqqv75ok78k.fsf@gitster.g>
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

Andy Koppe <andy.koppe@gmail.com> writes:

> On 15 Nov 2026, Dirk Gouders wrote:
>> Fix three details in the gitcli documentation:
>>
>> Use plural/singular where appropriate and imperative form when rules
>> are listed.
>
> The introduction promises a list of three, but only as single point
> follows. The message should mention the change to the '--' rule.

I somehow thought that "three" was a count of patch hunks, i.e.,
locations that needed fixes were (1) the introductory text in the
DESCRIPTION text, (2) a bullet point on argument disambiguation, and
(3) another bullet point on not bundling multiple short options.

Or perhaps I misunderstood your comment, specifically the "only as
single point follows" part.  I assumed that the single thing is that
the patch corrects number agreement and uses imperative for rules,
and I didn't think the issue you had with it was that there are not
three grammatical things (they are two).

>> - * Splitting short options to separate words (prefer `git foo -a -b`
>> -   to `git foo -ab`, the latter may not even work).
>> + * Split short options to separate words: prefer `git foo -a -b`
>> +   to `git foo -ab` (the latter may not even work).
>
> Nit: "into separate words" reads more naturally, although "to" was
> already there before.

Yes, that does read better.

Shall we mark the topic as ready for 'next' as is, or do you want to
do v4 with a (hopefully final) small revision, Dirk?

Thanks both for writing and reviewing.

