Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029711;
	b=MfnsgLZcBK6PkNGt7E54rWnoQGohESJdi3NKIROmG5ASXS2Fo3XYPDrtudfglP86ZzQ6
	 6CMMZCARrFw6G20VhJkNeT/Qfe1xnvC+sDH3cwYNrfhoEtqTaUdAluGLgpY7kVjBsWOHG
	 6dU28LPNOsF+9zEvLDHJLGwBjCW+n/dtYnS2D7MgKNpqffpAj5k9fQXQt+V0D9GPJrn3S
	 tKYW9r2uEwLUNGu1COczQvJ8UYBx1FJAj33aqg/U+u4xI1I0cxv9hgq5n6HpqhqtbCtdr
	 bo8r9qXMWQTh1Uz1BMsOsEqNrXwaqDYEJXwm7YCpCiApC+be/qzUn2aYHHWVM+N+Obg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029711;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=fKwPueVCdramyzWeseKTHNAN0cwQgvJHlLb0plvha7E=;
	b=xE1430uhekO19sYN4q85pN6bVDboVlYPZ7FIPocQrRQxFE28ypThHbdwIZLJKRYiZfi/
	 xvxGgk+716Upvr99lR59vERoFXVEHAxUJBPnhkay1Pz/Fiddb58sb1Sqwfjfdiv8DN+MO
	 F6XFM4RHzO3bjWLDD0hkjrp0kmN+oEOjW9jCYp5zCtZfYHumqYSZIla4yEcfm/azAmbHT
	 bFFGFwhS+zzB3+9VN6g6UpfkZ3xQLuYcKxNjeobeR4VDdgkTiQvxf/j3ow10KOeuxB4ma
	 jar9qQK3Rj5gRaVPBHz873HycDEWmVNaOtGYxGT3MpbiifC/B2QyWzVBPb1MTFzOEvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=kxMSptQJ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=FaLR7Nxm;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B51606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 15:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8B51606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=kxMSptQJ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=FaLR7Nxm
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 157547A03E5
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 11:48:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 26 Oct 2026 11:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793029709; x=1793116109; bh=fKwPueVCdr
	amyzWeseKTHNAN0cwQgvJHlLb0plvha7E=; b=kxMSptQJ3E3V5TCY0R5iFHsyVF
	GRS8rviDh7bzt4zXBETwLg06A48BTFBfAaVJ4QHbbX5JJCsQ0VQnMAYntXWJPvo5
	c3OSCHO4BN8/TIpcgAMBPStEWyPlBWEU36GYBZZjq4yNTZ/yPZEQttywbhR5/evD
	x96z8w9caMZm0eKH2oFAPlveQ+5+qmPg/DUxbZNTT5De1WUiO57c5xSBfd+GOgdq
	v3+rBgZHEFsUEqVPUqpM9wTFmjjaoUlJ+Zilgt6XierMfYnOT16KInfb11BN5G/T
	pjJH0YF6tqgRU1b2qhi4NDSh3KT0tgtPGwjJ+t+dD+fa63od9Qumw6SGLm6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793029709; x=1793116109; bh=fKwPueVCdramyzWeseKTHNAN0cwQgvJHlLb
	0plvha7E=; b=FaLR7NxmI/MHArKbnGCaXcIT4AgyJKQkAjZus/YPNzBTa2P7RMw
	0sEbCK5o5seHkQtD0Wl6brJtppFbJ6avXpTzavE2YBpXZzCoZbTHTgTUlxAduw8w
	gZ0/OYgtOC3XAZ0OU0dLuaqPPrQSpUxYecI3OsfIptohxvhvuNzDvJgbXaDY0sQ2
	esJIq3y7QWTVQVaAOw03P30rdCGTlh+cQS0YNRUu7mfkPMttxu5ON5nQac5yL/U1
	wCceULzafc/s7w0EVidpqvjUB5l0K1y32wjSi0SLLSloN2vLl81W2GZgCQcecBwy
	AEzr4sqAICqOTNB7zSUnU00+zSxhH4yxdyQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793029709; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:N2e4ZzdXmSDe4vmYtCTgDbZK2/ya0r7GOBOsZ2F0z9nWGmV
	BYTh9Zkghr2m5Fuqc5Y2Oe4C0VtzbMDV6PXD5TkySL/jtr/k4z8OkzGnVqzFAaKl
	yTH/bAJ2vxDuJt0J0Ixm2uRSkC3+wisErNDslyPlWFyefq6mw/Ja4T9wEEl5JwJ0
	qAYnQHjYppPalfXzBDOydZBFMcUXtHFwIL09KGD1mE2r1TsMwAc0ZZqWbKT+5Ox/
	LiBWuiYDlj3oWDvOt+FKuPXsjgExlZ8ADCbHRdz5JPPk+4AoiCrcQ4HGSkV3NvNu
	zRQOFooiHpfwugmAfcl0GgkrOvpEH3ueoFF4O7Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:sZmyxVoOxgYS+N1m3ZmjDXmVXfQXduIas7EtVhVsaH8=:caaBcrUw5PmsdLHehxLxOU/gZcH33EXlmlJdQ12cHqc=;
X-ME-Sender: <xms:TXbfajI2XZEuwap3GM9UrxuPzNaifO4FQjKXNlTHJR6h_jtOSblpBw>
    <xme:TXbfaq1A6uwrcV7x_vPZaXUB75zhSeyWxQ7BwIv0ZIRKeAk-uRSEHmZENghpq9zFn
    c6JVMMGefoEAoX2ZptXNpAjJGobzTij7TQbUfsmWB19_OtYkyBuP4I>
X-ME-Received: <xmr:TXbfalhSGERXbRHUEEWS5YxctnhsUMVcA8YiyT23L-lfcnRZ4SkwBdnS_r25l_ITGGxe7uPcWvN9wtWMyxZLrtILCNrwxHppJp0p>
X-ME-Proxy-Cause: dmFkZTE9uZ9K7pP2TjUTgk3W2rDhv4ha16c8I4qoNQJ7j1MhtdNPAkz3TTpRwF34bp++D8
    IsR7vuuXXQlhqXFIB4RMOv+zsiKINx87n/xpkcgz+3pkp0ErrAuBoI2kOiD4jt+dxI1QKN
    ugrftwdifaS48FVtmvuKquiA9rEWPvajHoksoYlqyxFIjivDhDxH3LPYZ9Icy1+vjrfFjt
    jXOIyE11lMVsR2DxtXybm438UMv8U2LfkS7dS3GsLPfAYE/OqrPqpm2igzlLXHTIbOgcO9
    M9NnS474GXD9uxg/ztoZc/MKZjjrNOW1vQwTSLtVD9O0/z+O4jjTflegGpLHRs53v2bbhq
    qZCjTYNR/XA65Ml1GTzjk8ep2Mf/SUgW/nw8tpJDqiR7NgVXPHLT6hmmHaTYeiCYl3NH/X
    nL1ZeAYrC00BOXqOokReAvvpaKCPC+nwj0v5gnK6wjI8ZqFupn4ZmPainlA6+t3oPk2MgX
    VwBJkynW6ps+oeLxPv9Uc9WjIKVGYM+/xNpP8Xgwt3+83OIDiLrbzotIhPVFWyqWl+hGb4
    8jh4YArQVy5btaXheByMURArZPjs7zkV9RuVUdJBcc8WahNCoxeqzO6LAReAdMAou6aAqW
    YIpZSkCmLdjSgjveqpXuBbjBiYJNGjs3eD5xl0wKXCoOfFP/AdZ98IKEtszw
X-ME-Proxy: <xmx:TXbfajWPY_XD2Xiot_w5xhFhA75puDU5rdtuxPOn8lppQIsCI95b0Q>
    <xmx:TXbfasVmX0_Wfm8kScAdYufSi7WAJOOgHpapQ1O9B32j0rAomRp37A>
    <xmx:TXbfarjev6Rv_girC9X-ofIMLa5-vyzKLdeaHnBK0mWFbsu3Jf4uHw>
    <xmx:TXbfavaac3d-AkCXoTpC6bMGHjzaenX3sR1PFr9xNjCYxe_Hkxq6PA>
    <xmx:TXbfaitT_iJ4vpwi5JilI5oc-94qfIMGcx3VFYXFksVf4oDMTHKPMMeM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 11:48:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Harald Nordgren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v10 1/5] fetch: add remote.<name>.refmap
In-Reply-To: <CAHwyqnW=W=XnRs210h1VxA5KWxdObwihCty6Gthiwh6+hDkD8w@mail.gmail.com>
	(Harald Nordgren's message of "Mon, 26 Oct 2026 10:21:04 +0200")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com>
	<ba7f1354cd5492ef964ad4d1d398b5ecfc4e0086.1792503778.git.gitgitgadget@gmail.com>
	<CALnO6CAhUNRMf=KZmY6YbC-5g3h8DE6U40HehGwbcRTPhDasrg@mail.gmail.com>
	<CAHwyqnXWxiF6NLh3e4yGq6_y+=A+-_PwKF7D9DJJDxbk_0vF-g@mail.gmail.com>
	<CALnO6CBAEB8=FfZfde0OWvfLJikVkXQ8itP9wZpGHxfxK+y_LQ@mail.gmail.com>
	<xmqq33ttxw9h.fsf@gitster.g>
	<CAHwyqnW=W=XnRs210h1VxA5KWxdObwihCty6Gthiwh6+hDkD8w@mail.gmail.com>
Date: Mon, 26 Oct 2026 08:48:27 -0700
Message-ID: <xmqqcxswtqd0.fsf@gitster.g>
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

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> > That does look like it would fall back on the refmap, but to be honest
>> > I'm not sure what is "correct" here :) I was hoping for more
>> > discussion of the questions I raised to see some thought about what we
>> > should or shouldn't do. I suppose falling back might be important for
>> > the later step with --limited-fetch, though?
>>
>> I just encountered a case where I wished to configure both refmap
>> and fetch at the same time.  From a second remote (let's call it
>> "cabal"), store any branch fetched from them in refs/remotes/cabal/
>> but I want to fetch only their 'master', 'next' and 'seen'.  I'd
>> want to be able to write something like:
>>
>>         [remote "cabal"]
>>                 fetch = master next seen
>>                 refmap = +refs/heads/*:refs/remotes/cabal/*
>>
>> And, no, this does not require any inferring based on what is
>> checked out and what the checked out branch tracks.
>
> Yes, I think we can handle this as well with some extra code.

I actually do not think we should have master next seen on the same
remote.cabal.fetch configuration variable.  It is a multi-valued
variable, so it should read more like

         [remote "cabal"]
                 fetch = refs/heads/master
                 fetch = refs/heads/next
                 fetch = refs/heads/seen
                 refmap = +refs/heads/*:refs/remotes/cabal/*

And without these remote.cabal.fetch configured, but with
remote.cabal.refmap configured, this command line

	$ git fetch cabal next

should work just like

	$ git fetch cabal \
		--refmap="+refs/heads/*:refs/remotes/cabal/*" \
		next

I think.

Thanks.
