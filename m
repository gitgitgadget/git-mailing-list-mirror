Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321119;
	b=jtW+8mLNgSCGIFI3bO78O76b40/ONIxThA712kxFaKH/235TRvQbDS8yhyROjRq6jWsG
	 fi7d1Dh7NWyMTy3SC90oXeq2rUdAnGpbo+S2OlCBSfDakvIUBJ4RmmzYicnHpLg8w0HIh
	 I1f3RSZHLgeTmPzpRAL2TGh+121RECvhnDQFihmTvivBt703nyVjGDlsAbIuEecKixMiQ
	 EZxAeHLw2oL5Ut/G5q7PR/FubKysUpppCAN0m3YJ/WZ3EI3FKnc1edOyi/TQWDGL4zJdT
	 mEOxgXxn/sxE9UdtaApaD3VbppsLsNUKx8/2jy6cwCG8QMAp51yOFUen0OCImE4Wt/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321119;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=miBe7RYknd0rdKYpm0kg6kXgbCJi9waCtAtNAdd8Qn0=;
	b=q6Dwd5kjtO9593tqkqiQbBa38ap6NRO8OF0B7b0QrTEXgp+MujkhXIbFht/arrjK7rJp
	 jz3+DlwTJ6uhTvGT4RPmTuu/ZQW4spAAAWihwq3V7KSecENbjlHNqiFzUqPuHs5gssAZj
	 A76bPrl8rnzL0AUuaGcdKJfnDVzK/n9pEHULuEZUSOPbv7wF+LcWAp4Iyauc0j/f1OUiy
	 9y0oOPhtqGAxnev+QlRHp7f0avSbzdpIM9b8IGJQ33SKpsFyzYE5NPImCZOBgO5rskMay
	 SL2oJ+1giI+8/L3fJ0aQ+YRCgm5Z7qwyu7ulejq4MNAFnd5WJEc8HAWoHjdrxwMznkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=tgIgnwET;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jcEGH8pt;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E193F606A334
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 14:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E193F606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=tgIgnwET;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jcEGH8pt
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 35A637A0280
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 09:31:58 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Tue, 10 Nov 2026 09:31:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794321117;
	 x=1794407517; bh=miBe7RYknd0rdKYpm0kg6kXgbCJi9waCtAtNAdd8Qn0=; b=
	tgIgnwET4OwcKICYRl6BvE/3xqql9gQtaXujAXXHGVxIMmO1oTxPdhA9J5pNppWe
	oDsJOvExANAR8aISrC8FaInJen+XCJYqBm08nbnuFGJ3910QTheNoTDZPUh9HwdS
	ZLU8qAqmWIkzWCyREirTnnsSYjOe/AVdpH2YS2hg9yfwsIb3XHAnynCkJhBo15oB
	oRHrBcfw/G+6sDQhHI3uoo3rBgE9fVrKRFvtvTLCnda4U3aU3ZHrSG78da761E4i
	wrDEIToSZp239S/ll/iYfKmhCUEDvcSW2jAU/i+j5ASttkFN+NOy8QDwVx0/uV2t
	9D76Dw1589GQLoUBf3TUTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794321117; x=
	1794407517; bh=miBe7RYknd0rdKYpm0kg6kXgbCJi9waCtAtNAdd8Qn0=; b=j
	cEGH8ptEKPC9s6ztaeM17m/HeBK+nnDT0x9B3Bj2QdlsOYsmkpWNZ+x6/VAx/3oy
	rPVyvY99ZPSf32ewIn8yA/sq+1zEuECKxpdMwe+1DIF9o/XOxqJlvUMfwfm4vFpr
	yekpOmzB0DYEqlA9og+8vzRGiW1A9WmbIl6Xt3yyMdPGQ73D8WnGPSbfic25YoQr
	upr+MC9e9e/YMDOilHtlonkBsIHZXh3xNpTK8x0j6qyz7HUG4rp1kejNg35RSjpq
	MPSlzfNiySJnttxvFRog2Ll4k23TlHhByI3pZoBsz5TSmDOtv6j24o3sgmI8b8sw
	Ic8w+VByqxSxzpELamxYQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794321117; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:FOUhX6QQ8ed6E5xIM+1GvAxHjx/sWC8QU3uNGU5SlCcKwF/
	qvgZ9KGVMYrplCewOt9H70Ykt1k403n45OTNppKYjtC0ndt5gd6w9MnJg6ww5MLS
	QK4hlLx40rVj2ajMVawdN8J9MCsHosLazNfyjcBgrlG+v9PtrfKSuaSKGzTO7QGh
	xwGziHXD0nVv7Xu+Qit4nrQrsrbNIvIBhMDG7r4I1LC3PaU+tzZ/o7hE5ggdwZko
	LfPE/pSnzZoZX4BzwOhKvU1ndnPSvrWtDFLI+JLc2szshyjEGyqASiIeZqWPiaf6
	CVyyZfXAtUG0cr56V/7m7byzt08eZ3G+InH+B3Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:EvPtZWAW4ggw2XKk/20/ZK7pDrTh7mPMbJKvV2G+dwk=:2QzbfPxqRBHsqpom0NjNUjNMrKewR5DgheUSxexj440=;
X-ME-Sender: <xms:3SrzahMnWRpoQuZXS6bI19Jzi4-n0TvZKhXBbbK11X67jGM728EbKA>
    <xme:3SrzauyII6xAhtOohGvemhgMx9SvnmSGoT4d2Koyz4DJJpRQ7IEibuhRtT4o-1hK8
    vX305WAUh0v2yZmjdgjN_er4_LpCdVvkQoTe6CbA6r2kxUZ48oo103C>
X-ME-Proxy-Cause: dmFkZTGFt6sfHUB4VSTUiq6wjgGwqS0sp2LRduXeIY9QkpbphWqYhA/cEwQh018wnMsDP1
    IseRcAu7SKDKNrKVelzZL6xmcZ0yc1IVZlbKV+ndVc6oQdSkBwqg54+Ww1cJIfMZ916ohd
    kG3TpprSMbc0WF9TvnGlnPdYA8J71SsicnL1mOxbNa/Bfr9DtU9iYv/oRjEqr8TjV4p/st
    4JPAKmUc0HL7z7dlPNHYH0H+GGJ47BqUF9RLQj2k76hXCyGneCbuuFB9vil79IHBmTgO8z
    LPIhJpwVPBPYwyXOHXVyUcbCv3TtdzRdTO7kYJMoBwkJoVqnotqW1d8t3y2UWrTE3V5qCz
    nh/qTK80pF1f2cgHTVgajgbzAxTOGL2ZtVts+fo6/fhjVukqUu7Ivz37Sx2ikh/4dAzirj
    QjhjJeHvP9IjMrYZX4RUKpiVv20f4lUD+02X3d6crOP2e6tBakMqA3t1Cf8TkE/4nLTaMj
    myziaJoJ9nPI24F/QQssNzlqAo2rljXw3rQndvM/NKnSL5DVfBV5iUocnIRV8sNRIUnE3P
    pM7xlAfEE+/Uscfd5Q9iNEwvauefKNFFBBJuN4CWHvmazOUCKZN9CB2gCzH2XKImP7zYDF
    VHT3oM3vaTne15+fh5g5bPfyhl8hFq2YAYj5OiriimQnX0WKIPWoDjjCh9Pw
X-ME-Proxy: <xmx:3SrzapyCyVAYAbr3UarGMz4YUNyPQhpTUYTiHxKYBY609Lb07-RbXA>
    <xmx:3SrzaqzulaboWZMAlbwMiOcG43qzXYNt8D3uiLZJ73PImcaTo0kV8A>
    <xmx:3Srzajbk6gU1sqbgvXdDV4Vpeobe1RLBIgSO_QbVBmQ2sLwZsq8YbQ>
    <xmx:3SrzarUI0MfbF-gAChsj9bF41k_RXp3er-UeHPBFvAVr5zdcd3owWg>
    <xmx:3SrzaiG_EiJi1nRG5CXsMjvfmSo57APCz2dewewHso1I8nHpDh6CI1Ys>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0B149780070; Tue, 10 Nov 2026 09:31:57 -0500 (EST)
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
X-ThreadId: A6BnYcedRdqN
Date: Tue, 10 Nov 2026 09:31:36 -0500
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Patrick Steinhardt" <ps@pks.im>, "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <75ad021c-b23b-49c8-818f-c28b57436aa3@app.fastmail.com>
In-Reply-To: <xmqqecctwt7x.fsf@gitster.g>
References: <pull.2307.git.1794259990263.gitgitgadget@gmail.com>
 <xmqqo6bxwtxa.fsf@gitster.g>
 <4696f458-62b5-4d18-a74c-aa692708f7d0@app.fastmail.com>
 <xmqqecctwt7x.fsf@gitster.g>
Subject: Re: [PATCH] doc: add tutorial on branches for beginners
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Mon, Nov 9, 2026, at 5:11 PM, Junio C Hamano wrote:
> "Julia Evans" <julia@jvns.ca> writes:
>
>>> I wonder what incentives, carrots and sticks we have on those who
>>> have in-flight topics that are so close to the finish line to
>>> concentrate on completing these topics before sending new ones.
>>>
>>> Ideas?
>>
>> For sure, I can avoid submitting new topics in the future until the
>> current ones are finished. I don't have any other changes in progress
>> in any case. 
>>
>> I'm very conscious that reviewer bandwidth is limited and I'm very
>> interested in ideas for how to make the docs review process easier.
>
> My interest in making review process better is not limited to
> documentation patches, though.

When I applied for funding from the Sovereign Tech Agency to work on
the Git project's documentation, the main risk I flagged in my application
was that reviewer capacity in the project is very limited. I tried to deal with
this in a several ways:

1. I emailed a few people who had reviewed my patches in the past to ask
if they would be have capacity to do review on the new patches.
Patrick and Ben agreed to do some reviews which I really appreciate.
2. I applied for a relatively small amount of funding, which limits how
many hours Marie and I actually spent writing. Fewer hours spent writing
means less work to review :)
3. We recruited dozens of test readers to participate in a kind of side
review process. That doesn't serve the same function as the mailing list
review of course, but it hugely improves the final quality of the document
without introducing extra pressure on Git project's reviewers.

I don't know which of these strategies would apply to code changes but
those are some of things I've tried so far.
