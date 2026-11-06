Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989877;
	b=kYBG9V1yHhw7pBWVHg2/Bq5FZe7swKvU4mKDnFMkmL1RpTw82HWH4SHWMxt3i+sbjl2K
	 +18enHTHAAv4Sn1M0m9WkMw6f67sT77BFBAm9bgiYYMOZICc9J1tf0nt3kiGjOA83MbX5
	 i9RhrvQV9xZkhrtzdn3KBMvq1nDAhUznEzrRf7oHZZAdTIBXx3o5NsLZ+wHSKka/ZqM22
	 RbsaGyhkPUeSzg7dCfdJJKNiPJgRdDl9OThjAmGeEqxfTmKD7QRE4ubUkwSrqH3E7uUGV
	 BPnupzc/1GbyG5xVbshW3Oa3EGsp33S3MpQXbNOPpDGfD0AXP9QzF8xq0LhZ5STdoig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989877;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=6KdFjRnomxMnTcRoCGQ7x9s7YHmARnpmjluOUt9zgw8=;
	b=Hl1pqBbD/w2wYH9HMirwtZeloKZQEvt1y3JxiDSzAMH14dbVFG1+bormCB35cHp7V23H
	 EONKzdl4sfM0kLo/pbJBNlIIolMW+kai4Sh+Bi7Wh3PBiP2Jyl8Ptoj8F2+quPcAO9Bpq
	 k7WPf1t0scXP+ZUwHNCPgJPInnOu11Uvu3XMJ+e2E4OLeQqJo0Uo4CZZQVocplZEPS4r1
	 E2WS4ERomdNEFqDI8+2qM4gtichFdaNJMZVmMGEA9kP7xnPvemS4fFznn27GVakBUsH+8
	 MYpJGiI6GEIuLUHKsmYoKVIpqzQXYfFSNgcjHxSWHLkqyIEmbYaPqEJinQR7fi21BzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=mLqNjtTP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cbk9Q1rB;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3422606A32C
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 18:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3422606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=mLqNjtTP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cbk9Q1rB
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 43B2DEC020B
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 13:31:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 06 Nov 2026 13:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793989876; x=1794076276; bh=6KdFjRnomx
	MnTcRoCGQ7x9s7YHmARnpmjluOUt9zgw8=; b=mLqNjtTPCvHNobUoTkLzeZEHGu
	RvouELRXDSLVHK/TtDPHqriwtfQbprTA37OV2QL5zLZUDdkZRigJyy4AVrjcEIzh
	avVCRWYmn4oBX6abd2oqlXq8zebLJOyV3kCwX5fNZ2zd6SmTx9MGCfxZiwPdC3tH
	P6ny/5U4dWfLYtuO36KxHtpD6XAe1lJ2TjwiEMkCcMSxdVjIVOHqybMr37EODxv2
	L8u8fSpMOnMgLY/CKIPKVKvjV+Sd4IqT/EW+r9fr0SNh00I85YYsVJMgVQxbg88d
	JoyeCH/bLeCg0FUyvYpUDCDj8g6Uve942/9iu1+8q2ilnJQ9hb4CTiLQhHgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793989876; x=1794076276; bh=6KdFjRnomxMnTcRoCGQ7x9s7YHmARnpmjlu
	OUt9zgw8=; b=cbk9Q1rBxjfRcESAk3Mmp2xWn37VCIXey6bMBsUpI9bD8ETa4CH
	USQBFJJ4BatpTu9Rlakj9siS0Mq34oh5/mfaOu8HxmH38Ttschmr0HqSiP4VgJiI
	cRa0ZT4olzVp9SlkPrfTtlzSGL0BAF5PD36xfTv80Xv8wJGUgS893HpHSgq/6V5p
	AW3Aii4Az42cxQ0Ri0yCJQfVh/+L/V4SCYTmSUni3SPQieDzUUcu1m1nZUexA49l
	0Cok+F3XrwR+53Gmzl7R7xQY3uaDPpCXg924QIk12UNSxcQVzd39cyq5LzXZ3H/c
	a9gAtduFz731sZipu2NVKYA9v0yr1yAL6jg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793989876; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:c9pQAO01IOCTK20FTouUMfDxyzNjXL6oX8MI7y5r0GAI+P9
	qUNYYOnyf7agVZR3urLp0SzQPWZrKcMoLMJSnsC1+ycNx93oFJZL15YGYb0gzYAj
	ZYmonS0joeBJw1OMyci++1+uSIQAjPsfFauJOAwtXO9Er3brOMVWTZTreA/H2zmr
	ScXRFX0EZoHZwt/Wayn3UmeB301aKpcNHCvv4woCkAvdDoCJiGnMmbBwzdBXke23
	sKvArYdPF1XajZPMUIF7ewLRlLKrNnnrYCPuSz+RJnMjZfYdb4wuycwvVfpHlFrw
	fDBaOy78f17vNHv/J4WRAMLdjXs1uGaKLj2rjNA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:3YnopSLJJTCKKnGqoEhvK1x5PlFFogzLNGObyjIk2fw=:p0jM2VsBdqJ5NVX2G7r53bVMACi/wfImsAp1z/zvydg=;
X-ME-Sender: <xms:9Bzuat_CuYzuEQ99NN_pWoz2F7KBuQf-c6M43LcEdUwjNj7Gorl87w>
    <xme:9BzualaUMc8wAWY9wvZTTgwHD13tLUY20Iwy1KpiwHFdEuNYJZzT3tkETp5uQJV19
    mQaZOGJ9kECiyKmkoazmng41lghqDisy5JWqK4nx4N8AILUr61P0Wg>
X-ME-Received: <xmr:9Bzuak3HbF8zkn7U94yn8tL7VS1FweQaCjBpv_2iWecRAGkEZj7h-Y7PAwIYaFfM2pYV__WGjJ9p0xGfXCXOGr6XwCYPESVCdBxo>
X-ME-Proxy-Cause: dmFkZTGr1f8rP66Hl7Bpw6SLvzt4BPye5FQcv583FiJtKYyM+Gff1KHAOAfV37cQdGLce4
    qJbdj6E4eR0iUIvQJkCDJXUMx1Z/HO32nxt3s0Sb3FiMy8THytLbuVnb50LBl7X6d83z8R
    Q8S2NXaRXfsljVweh1f8SrOSa6db7+iNMJ7JCB5NxsA8z1lNZotC3JDwGznMYsEaizCMNk
    N0nKeU5DYyRwKaCWJHgJ4miL7KrsNcmR2bQi/9OGiKL0shLrCDLJCLxNNymVQocvbOmTDM
    9f4rp9Y0Hr2qp8Wuz47Waxo/CKVTRZFv3BEbfc/xFHbh4dKVcD7lSb0+QSJMXM/xDKRKqC
    5PtfEeupqPhjVwywoH8wV5WCFIOnDQBEh3IDGdUUzfKqNOdONYwL1f6l8GVz+z20F9RyUF
    diIjPxtwchI4rp1evu6Dzoz+E+KATlLL/nmdIhhCz09X2ng7CmY/Fm7tFIWTGjIhqTRY0G
    xzY1fNTW7xFP/wDw0vpoqNaVBNPg29D+9YP+UcKHEEqGRnE8xVblpM84/uNumV7lfgWO9+
    kHBHK79GawNIfwftTPmmg5sTnsbpjTqydWy/xUmtea5lcrHKIqD448+QsbJicrqoP2khR3
    vp7MSq3rDBy2otWC79yt7VHuQFX63jCdeIISryM6vjtZvHzzoaCTOwCaZtvg
X-ME-Proxy: <xmx:9BzuaoZ5ScFj9KqR-LU8D6kCUoQK9F7DLMaWrJZ4Z0wWzkB3qb4jgw>
    <xmx:9BzuakLxdPHzuXCGhSts_9PqqgzE__5wUhJQYGTU45u-HJsFbVi5eQ>
    <xmx:9BzuavEjlBOmhovsVSZYeFZ8nFGLeSCMdXnduH9pFoWqH-cAprpPjQ>
    <xmx:9BzuajtKkpzD2Q5ycYgpB2xI41c0Bgi8gMIbdaFXRAV1Y95es8IBpQ>
    <xmx:9BzuajRaYDRLhtrGk7v0W_0eED6UcLsr2gFO8uy7UKB3g2jdOrdP2SYv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 13:31:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Antonin Delpeuch <antonin@delpeuch.eu>
Cc: Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] doc: document the current project governance
In-Reply-To: <e977b49f-8462-4b63-bdff-daee75994a36@delpeuch.eu> (Antonin
	Delpeuch's message of "Fri, 6 Nov 2026 13:10:24 +0100")
References: <pull.2479.git.git.1793632435937.gitgitgadget@gmail.com>
	<xmqqmrrqg7uf.fsf@gitster.g>
	<e977b49f-8462-4b63-bdff-daee75994a36@delpeuch.eu>
Date: Fri, 06 Nov 2026 10:31:14 -0800
Message-ID: <xmqq4idtke19.fsf@gitster.g>
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

Antonin Delpeuch <antonin@delpeuch.eu> writes:

> Do you know who moderates the IRC channel and the Discord server? Is it 
> also the PLC?

No and I do not know.

>>> +=== Project Leadership Committee
>>> +
>>> +The Project Leadership Committee (PLC) liaises between the project
>>> +and the Software Freedom Conservancy, Git's fiscal sponsor.
>> We are a "member project" of SFC, which acts as our "fiscal sponsor"
>> for us, providing non-profit administrative, financial and legal
>> infrastructure.
> Is this a comment, or text that you would like to see part of the 
> document? I think it's a good idea to make the term "fiscal sponsor" 
> more precise as you did, as it's a confusing term for many people (who 
> might otherwise think that SFC funds the Git project).

Exactly.

> Thanks. I think it would be worth documenting who is able to add 
> subscribers to this list. I am assuming you are, but are you the only one?

You ask for membership for the security mailing list and access to
other resources necessary for the security related discussions and
reviews, and releases by asking <git-security@googlegroups.com>.
You will get a response for by somebody, then join the security
mailing list (or not).

I do not know if it is necessary to advertise anything beyond that
to the general public.

>>> +=== Localization maintainer
>>> +
>>> +Jiang Xin coordinates the localization of Git by maintaining https://github.com/git-l10n/git-po[git-po].
>>> +
>>> +NOTE: How would their successor be appointed?
>> Not limited to this, but there is in general no "appointing"
>> process.  If there becomes an open seat that needs to be filled,
>> it will stay vacant until somebody volunteers.
>
> Makes sense. Here again, I should have asked my question differently: 
> who is able to give the necessary permissions to a new localization 
> maintainer? Are you an "Owner" of the https://github.com/git-l10n org?
>
> Or would you just stop pulling localization changes from this repository 
> into your tree, and point it to another repository, where the new 
> localization maintainer would have the necessary permissions?

It is something to be decided when the time comes.

Jiang volunteered, set up a repository, and I respond to pull
requests from there.  When Jiang wants to hand it over to somebody
else, the successor may have to be somebody who are already well
known in the community around here that people trust, or perhaps
there is some effort for the successor to gain the necessary trust.
The successor may inherit the current repository or set up a new one
to be pulled from.
