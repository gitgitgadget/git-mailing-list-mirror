Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599353;
	b=DDpXzDcI+LNE7gpCUtewXwm/3N/m45O5a7dxHjVWOThzetqB5qVKj6YqEHd4XbCt5ps+
	 NKxfL0bVVzXWaAbyU1vS/Xhn4BGZXjXzyNE4cvARykw04H5P2cyhRrqAsGpvrvx/RCR+m
	 K7DEUBJvXrZo8qdhT4UFbCq8Aa5Og4OOq+P418LpeYb9HF3aVOuY5HT3VLPe1gbOyuzDX
	 CepO+5Kfzqr9B1zk7BkycP7Df2iwKHC/0S3UGqngh9E6NGNgkP1zYcF/F9yCG/Ccqr/4i
	 N/Ea3M+tIKjcfQ9LIy9efP5KTtdYmoOZA8qgQNjTN7tCp7G0mywfd1UrEws/9Tarkfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599353;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=xlGlhSRSdaTV/NSxHCw1AuWqbNS3lWUZT1J7fEoAA0A=;
	b=mc8t6ryHST7zUmF2ulS9jw1L108eNKDpCXfzWhqQrn5KZFEoGYfAI3EQ8exjySmvmTxj
	 0WaWUlKmylQo2AMeekEz8oRgbRTnl25uNCJP3/wBSaBUKPBV0emwgTj4KGa8dEV9otZGS
	 RxKpn4eUV7o1G9AW8gJm7RpzJ6VMFwPZ47B3HaWGxnkr+BXlF8r/SDJzKDruzfCN1IK7F
	 bpMYe7AmPrTV2zb8uD2W7EiGeXdCeRNjqDiwLv6Y7ZZxOV/kNjwGFU/1P42QbO9pyG5+h
	 ERkabGd4D/F9Uv4j1u4DQV0Y3DfeWDgPXyHHLIEOtSHiPpIo1R5ahcVBkZVGPo7UlDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=Dzcwoa2d;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=wcLy8fAe;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2D4606A332
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 19:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D2D4606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=Dzcwoa2d;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=wcLy8fAe
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AAB05140007E
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 14:49:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 13 Nov 2026 14:49:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794599351;
	 x=1794685751; bh=xlGlhSRSdaTV/NSxHCw1AuWqbNS3lWUZT1J7fEoAA0A=; b=
	Dzcwoa2do4W158ZMop9UrG6IAUQ+H+28VVGXd+1o4Dv1nls9Dbr/GGLIL3h2p2ic
	VOtNnNETA/g7MPQ/Ud7lB6V+5tAN4n6L3x7TKbeWx3VIsc/arFO8X4ohfPNattIq
	E7NDsWLe1ZyM+tSpXUUnCuLksjAjXgJD54bACNrCwk5D65KA1N7TUqzPfN7nvRO6
	CPX537Wp//BfSyt2ZlBke4C0HQkFeE4aikbJPUXV3ZBg029LwwNBxj0mhltbyNtZ
	Gfj9J2Najf/BJBiKNexFLIk3nfUsAs+woKep51dE1oKowBjc41PMC/p6XXfGsSQ8
	hCjlx/bejdW7i9lIbtrUug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794599351; x=
	1794685751; bh=xlGlhSRSdaTV/NSxHCw1AuWqbNS3lWUZT1J7fEoAA0A=; b=w
	cLy8fAeS1NMcGtUaWwgn3Hg/1wNGwxiP65O68q4MV27xXi53sC/2OByh4R5SGm9R
	faANl8Ow5PAe4iiul65wsLbG6LNrH8NDo97QRa3CvUDpqBYaVhgPECB5OIsiHE4Q
	rdJ6LSXKTX1mZuJ1aWLG9ndJka2QAxKRE5+KvHTek/1DLRVQ2VYcLgv7tiDhXqmF
	RptGyaBnLwrJ+f8UQbFijpBBR7G3UheBQtdKRpb+G3TypUyWzODYbqht9/PQOnWA
	VDMB762xoOo3OpTi8mv/sKH1kxmTHeScJDHrvub2IzMHEizuQKS5iZvcougHTQCO
	TSA4Q3Wlf4v3C1aKblztw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794599351; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:Kc0BmHQ58YjacJOnEfyKYaCeC9CHMVO2qS1IDzIVH0/gfp1
	Z0QWvCGGkV58D6qeYuLKTwuwEXLzUT86zHGdbOkFmihwi6vGAeehbmzpC8jXh2YU
	fifl3s54L70r1NjrtuI3v+C/xHiLDAqr08YlfQEA9lcQyt36t5tzGmCR4aZ/0vMC
	huouyyWSLmsFejzFrhCieeZVm32WWAAPgQ9Rwbrhg0unPmwYAVvYAkbv2x8mKxuK
	2lS86w7JHsshjorePcXpNj+EcUyoJ06e4shwTJfTE8qrKXF4DOQzXLzeX/TsJEml
	V7uyU4xEkcmpHYjG6+lnZWgigzXEsqIBlzgieOA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:mCwIqhwrujzW543LUs62mCtF6iu21avN48p53qm3oIA=:Q40TNkc16LFl03VuuN9tMKyD0Q9TshmJacA7MSakYyI=;
X-ME-Sender: <xms:t2n3anzcO-HRwRQbL5Vtl3X931f6-ns0H6_ZY4ZSt6aHfWA8jjYGng>
    <xme:t2n3amIvEZTrUuZYZvoCix63CPzAp5rCR4YawcH3-PJxM3Wj83nsKdFN8LX0d1y9o
    Yr3wYJ7ntN-y2nrYt99gzPt_Ed1ya8AKXfkEPMKSTE7RGm7JKSWOOPk>
X-ME-Received: <xmr:t2n3aprLTckuwzLIaeZXsUJp90hhVTx3lxqhc0TkYqxcDrxRvrdjTvY9E5S9kRz71wk_G9vvEggrP4mvKEcjNsP-7t5yTExgkpgQxVbnGNxz1y7XPw>
X-ME-Proxy-Cause: dmFkZTErMQI8q6ejHGVRnmjylxdl+tRNEs2vzCKlkwIoZD4ep2miHj2uA+5Pn9I1j0g+dD
    Zg1bkLzfVnNTjuksp8x/vOfQbv1RaII/2+2GYf4l9yJgxd6ABa+EFzr3eIF+la2u9at5Bj
    ZkCOOk3zIxin5Df9S3GvRHzNFagEbXyKexGMEJfztsKsRpdBj2sI1P5cY11imqm0y0mjxP
    LxOnZvww1b6MxPlV4UpKy6XiyW66i590i3IPAag62pMs/bHS7Y4u2UjsuvwbCsfz0vIGU7
    fRShTXlmvAus9hdBNMeZuS7rV2ZPI2Z0KVF5cTApoDFRjfNdlJMOh8qFeTG9X5MZGTtkno
    GW751KOzlGB05Gy7vv28BvnSSEM86iwhqCOCuk2rakQ8HKZrFaGgbnsN6DPdm9AkW0+OFs
    Uy9gz8Z7x4bPPeH+sH3Peci8TFNzvQynGAmweSGqBsNcitEAv7iseHTh1jLC7wgjcrv0an
    CTsJT9JMt900rOdnujZwBxim2QIyQ/fyaGFolaeN/GT+jSyf74xupB4X7ikpB/BIYnVUEe
    Z/jQrV9jy711AAAkPRbw68hR3v1MoCl+OC1Kh0JWP4aJe24Knq18MUPsR6t0mNSMs+aWeS
    PNWMCbPjArYqKcC1JUTfiDlNimJ4pNSdhfBTaZyWUuj+pQDfUdvVcrHIKLTA
X-ME-Proxy: <xmx:t2n3atI2pV5sZziKw5qVV0GFaiHtmeJVikYHtK9tD1tfRQUiWAwJjA>
    <xmx:t2n3amTARpbG7TvmVDWlFhiJy-S_-A4pwp5CiUnKUglcQAuLk6KuvQ>
    <xmx:t2n3akscJqXBInP0FySm7eSZox1Le-JDkwp6JUFsBJ9vRpDKaAYwIA>
    <xmx:t2n3ava1AgQijLOXWCoW50MzblX4Rj-IGCNM9rEFV-bqeYhrwsTwEQ>
    <xmx:t2n3aoaTywnnAiCcx1XLxwnc0v_XLE6Ljekdd4580SDYhuDFEwqH101H>
Feedback-ID: i2aa947c3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 14:49:11 -0500 (EST)
Message-ID: <c12bf331-0d11-497b-b5ae-874534a42385@jvns.ca>
Date: Fri, 13 Nov 2026 14:49:10 -0500
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] doc: checkout: rewrite detached HEAD state explanation
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
 <pull.2250.v4.git.1792177409868.gitgitgadget@gmail.com>
 <xmqqh5ile4h4.fsf@gitster.g>
 <CALnO6CBGcG42NxtpuPaJVrzAMC=J8iVstsHCSi6vDQhDmFJ-Kw@mail.gmail.com>
 <ddc6d42c-6e40-46a5-bb70-f89f11525ac4@jvns.ca> <xmqq5wy2kqhl.fsf@gitster.g>
 <931a94e4-feab-49a9-b5c6-479f0d7f8b75@jvns.ca> <xmqqik21j1ie.fsf@gitster.g>
 <4d6f9b6a-e658-4797-bc4a-0cfc533056d8@jvns.ca> <xmqqfqx5foxd.fsf@gitster.g>
 <36e73720-287f-47a5-bd3f-dc53629ac968@jvns.ca> <xmqq33t4fxx7.fsf@gitster.g>
Content-Language: en-US
From: Julia Evans <julia@jvns.ca>
In-Reply-To: <xmqq33t4fxx7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2026-11-13 12:23 p.m., Junio C Hamano wrote:
> Julia Evans <julia@jvns.ca> writes:
>
>>> The mention of "your current work" (started at the HEAD) and "next
>>> commit" is to lay groundwork to explain what happens when they make
>>> that commit, and how it is different when they are on detached HEAD,
>>> in contrast to when they are on a branch.  After all, what we were
>>> discusssing is an improved explanation on detached HEAD, and your
>>> commits not affecting any of your branch *is* the most important
>>> aspect of what detached HEAD gives you
>> I read this a few times and it's hard for me to tell what the issue
>> being raised is.
>>
>> Are you saying that we're not explaining all the details from "`HEAD`
>> can store either a branch or commit ID" to "if you create new commits
>> while in detached HEAD state, those commits won't be on a branch"?
> No.  I do not expect an introductory document to tell *all* the
> things that needs to be known about a topic.  That is an
> encyclopedia, not a technical manual.
>
> The fact that you would not clobber any branches when you make a
> temporary commit on a detached HEAD, however, is the most important
> consequence of HEAD *not* recording what branch we are on that has
> real *impact* to the end-users.  They can leave their temporary work
> behind without explicit removal by just checking out a branch, which
> also means they have to be careful about losing *if* they care about
> what they did during this temporary state.
>
> I view it as a disservice to deliberately avoid talking about it.

Sorry for the many replies.

I think I've realized that the real conflict here is that we're trying 
to write to two very different audiences:

1. Someone who's gotten into detached HEAD state by accident (maybe by 
running `git checkout <tag>`), is stressed, and just wants to understand 
what happened and what they should do. This is who I originally had in 
mind when I wrote the document.

2. A more advanced user who's curious about using detached HEAD state 
and wants to learn more about what they can do with it and what the 
implications are.

Of course these are both important audiences, but it's always hard to 
write a document for two very different audience at the same time. For 
example, one thing that came up in this thread is that creating commits 
while not on a branch is a problem for the first person and a good thing 
for the second person.

It could make sense to restructure it into two parts in the future (one 
along the lines of "help! get me out!"  and one more like "here's a 
useful tool"), but this thread has already gone on for a long time and 
I'm not sure that would be productive at this point. It might help to 
add a note in the commit message saying that this "two audiences" 
situation is an issue with the current state and suggesting that perhaps 
it could be restructured in the future.

