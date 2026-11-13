Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592679;
	b=pUT7/EIR8d3/gW0MGNp0+wFN5B2iDgLYnmeQdQcbqYX7fr/3zTvjzIqt4p5nxdjQi50w
	 1UO3U/oZ8ivwqVQxAAy1eYdsv1dUiBNWjQaTyF0PjCyxWAXUXnyiDUY7PE8D2jNND/IDZ
	 XEzxQi2whrQvYZi0lwgM+bMYEyVswkCKIlnfoEOAc4c2K4RjtGSWtMcuDNgj8UoInmxZW
	 jloBxtIFhTJVnMJUfovHijPhdu/aSRQxZW2ZX8oJ0oL5h3Z48ET7NU2LoESG7qLlktjKd
	 nRm6x4M+7tWVMtNF/PU3+hflRiqkMEMMytTm2MQfCTMdryowmBMQStbZ5uHjNXQWoBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592679;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ivltg/QjsVOmtkiZrh8AG1bwWWMGSKssUOLnFeqLT08=;
	b=usO7inTOzBoi/tQI6thpO+tPkS5gdkFJHmzxvsxyf+i7/smCUd8/GtLeQBGQFIhAgNmG
	 t+D/IcKsiDsGLtglJYyS1exaRsjPjh29i4dm8+d76W7Vpqvn3Wd96t9aSBC5ON/vLQ11/
	 PuN9uwHV2uHU7j6sQAenxe6htfjH6+meBnobgW4xojziVcbCX5nrhYwD4qG3juE+war4j
	 z39ZHpm+B94R1YZxSGv1hD9GAuJwpTyQXHQ6Bc34zQ1E13EGIkCoiJfPWsNqpz1+dpCO3
	 YTGjHrNGPf9zT5TXw5dXdLWBGt0oQWPTVeYzkCkY7ArJVeWMpx1IX2c8U1tWbL+9JNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=Apl7TCBE;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TEHZatq0;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE44D606B23A
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 17:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE44D606B23A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=Apl7TCBE;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TEHZatq0
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 0626C1D0016B
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 12:57:57 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 13 Nov 2026 12:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794592677;
	 x=1794679077; bh=ivltg/QjsVOmtkiZrh8AG1bwWWMGSKssUOLnFeqLT08=; b=
	Apl7TCBEe+upN1v4rSLpgMKwjvqmucrRY3ZE96bwtFeGk9E6oJlPpy3A5m47OCfx
	uYAnu3yrj25hqwsk0CDR3hu4qTUIclqfeFmHoqSnbPHNpeKdgVMEitz1SwVca9Gs
	q3zzbgpcKUxod+yEVZceZqZRxhvcSf+82IYMUrPUg7o656eLyPGiWv0YgvLac33D
	TCGsKWqyW79R9WseX+btZe+0lpQa8DszXQLk+1LJeH/iP4gWF6At4KP1NKHca3Sc
	uEy/Br4ZytTRE7ZuVy/8TfoMoAQMcW4uunuHMAjy2i/Z3EsTG+RgIyNVZtP48jof
	WlYxbmHGQzg8V0kO7FTyVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794592677; x=
	1794679077; bh=ivltg/QjsVOmtkiZrh8AG1bwWWMGSKssUOLnFeqLT08=; b=T
	EHZatq0Vez1XXExswJWedGgMmJTF8q7dRgPjJji4cMsCvBjLQGMUZiYwP2dD1/sj
	v55Dm7pBjyd3VikA1s6VY8cq00lJv3j1M3llnrCWbIi7nBqytv5Ecm5yFPZ53XCA
	GDOgIqAyZnYJXgCoZB5iTDGKsQd53IIZvUlidIsgyXqp5LlbPfUpqcxPZ+C3OEug
	0jEtP2RDV97wFcQUcloA+kHHHXlG53c6whHceU+PMWNQFk3l+yYmmS1F9fDtD3pB
	ti5nIAt4sqFvapOLjWdpWK+AAxpbvD3fFHHhyOm0xhWq2lRauh+5SGXUSXEhF+E7
	63GVG53oj+3wLxIe4WKlA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794592677; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:s2yL52gBGVkfVXajGXakd55XKlDhfd3h+qvrJ/rHBf2f2ne
	1+JiQ3z0GOF3Q7SfY1hyrmuxE2YX7EzFLq9FAsM+xakon14bFb6BMtXvQ4QGvryN
	RHnwIswsqQOynAjYqRkUdyRRqUPwr+kROD/Yh+0jEsOjHY0KgslzAeoO9VD7w+dL
	yqxTE1RLg6mKxGe1RCzBcQ8M2/f3gbhS73PC/tMFv4TJvlwPmnHgSyicSfX7jhFz
	bqANOouKvhlAObUMOHX/YAE3lleyxmg+Q/8As5jp+7rvdTEIcHUUUx3lKWXTjdAx
	Hvu1fIZNUBElSBToWyHFlYkoULUCQkRwY8VOd5g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:kmtPE1sCBZGz5J9Y18yk7XrE1VkrWWlmm7HW+JpHHxg=:IVVxUIh+3oXFEiWyb3a3wvRPBL2unVfHKAzGpCc3wQo=;
X-ME-Sender: <xms:pU_3ajVY_T9MPIvCVUAneMgBTqNccGkSEpupMFYNSOEiX1eQ0C0T-Q>
    <xme:pU_3aicTJz4GC4i_ICEskLsh4GAKjiwc7aCwuzgck1qB-UlL7oG1M9TzbpB4sAVI8
    fAt19Gsilw1_dEbGSmMyvgS6egZvzBUfajbnbChSTrBAjkKxqcIpM9d>
X-ME-Received: <xmr:pU_3anvE3q6ovQHlxGvLxetZTb_TvTOjvjeEmZrC7NuJcgVFPoDMuU1-mBA0kgvzri6VaR4gm4pTo3O0GN_UZhimZmaRPZ1fUcTRSOoQMX9UrohhKg>
X-ME-Proxy-Cause: dmFkZTFHPNjBOGM/FypDUB8yRntrSCOjdXC5osSR6UG46gwwfhPv4bK/7thuJzqrqJWmMQ
    z8oR6OdJJbL4CYaiM+Z5Y6c7vjDk7Kks1Wl5Nv7fSRJi7g8tur6YsDPohU89eygtFkHAUc
    cR4lBxVq0RM55Wx8N39mnhQlANX1jRXFB1jOZgD5kFNE8yvH1pwIu3Oc9BZ9+NBgq78rJf
    +Gl8+uHC87ZQovmijxfckCTppzM9USGxGRSa+r1H/be3OhTqSXEQcw3leTxiMIszYlOBBM
    4wyI5sLmyd/bPtgjOVMYleUvNJeDABiyI6YmCRVcd44dsggsXVPc8lNgfRuZyYWzWfZNHL
    NM1n3066mXeA1pN5iLIQNWA9qwQ7dZ2GEixtT/TIfrnVbAST0c9kSK9YneSZJNsHcFHcEY
    RPrem00TdgTyWiSe5UmBRkA3wo6bcyFT0dlIApiT4qe0GoxggYzlMa9PWTLCRb6OFaicOh
    qmVNs4nGKSlvxWO/4Tzttlq8YKC8B07j1qa+haGXg5nzuIFdtiMBY41DsEwCzZjbn92YVj
    nhpybSb2yjaRJnuVCuVQ+2qHQ1IRbxrCgBkGPfG6N0CF0uteVkXdO12+axItW2K8rW6xOd
    4hI4Ntt5RJM28R0XT4Y5/A7ajLjoq0VRetTbea8EpmLSGd6rgL1EA1WqN05A
X-ME-Proxy: <xmx:pU_3ap9UZep30zfET1DrMohon6lRRa_aF5lAY5j9jA9l0jHaE92IKA>
    <xmx:pU_3aq2e1fDz51DHTPeNWS5X-Es9Df9323sCMHOxGBVxNRtj2mW5HA>
    <xmx:pU_3amBX_MgZblm9qdNWmIjinRTg_FIzhJ8w9GDKU56UOaRH8Afiqw>
    <xmx:pU_3aue7qmzvy-DdnRSCWHGdUwypMD58T8GZIQ6mnAFtu2dT8liVWg>
    <xmx:pU_3apMTwYM5oZf1uDVPyFhpwRfFH-A55Fapm5ihw9gol28Hp4buO6_i>
Feedback-ID: i2aa947c3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 12:57:56 -0500 (EST)
Message-ID: <a70524b5-5ece-49fd-acd5-c97e21faa76d@jvns.ca>
Date: Fri, 13 Nov 2026 12:57:56 -0500
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

Okay. How about this?  (the added sentence is between the **)

   For example, a data scientist could use this to run an old version of a
   data pipeline or a programmer could use this to figure out when a bug
   was introduced. **You can also use this to make experimental commits
   without being on a branch.** By detaching `HEAD`, you don't need to
   create a temporary branch.

