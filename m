Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793992543;
	b=UYB1XLUhKEwBQUVGdpu+hxTwpXA+rdl2jdZZzE+x5+V1Hc9ULrVh1Q5gR0wAt56S5/TI
	 M+ZPJ2/AyktkdozwMXTXb6Jy5DtxReDJ2x5yUz2hVBo/TuNbR9QNBuATKlIPg8pP18xE2
	 g4Zd9b7+iB6Bj4MtyzN6b4TR0hmeP8RdT1O3mEadMUWLY8QvMOHdtThQs6bT1pRODeq8i
	 LI7pYIVauUV9gocWv72RsJQPJOr3sRwaoM2RvvsOLYVgn34dsvSN0dFHFT89O3yRcGgr0
	 bmCWVXBCtED3+1zIYGckHWz+JXNnrRo0TKb9il1IUh5rdX0vwlsgMWDLwTm9kvEIJIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793992543;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=rxdY0nsqLwm0txzr7ot0PNOuws/MrcIJf7YLSZDAkQM=;
	b=owuMpgYwVM1LYvTQohxAqNgPtb9SkMoosaiYdJ9uJGbJ5DC+ZUHQrQ6MPIQsYmbzRRZp
	 DiuYH0FryMyCCI+ZDVqtAzLGC7jzqIyBx1+JvDEg9C1qAKW0JonLIdowwxihaN3hCNOIb
	 L0IsxmfSBCpHq3vwMQfOcaHgBedvQWd9dnhP3HLmJ8L7e3NwfOGVdID8775ks82Hpz+j3
	 3s4OTXH4yY4R1w4n13jt88md1pXB+u/xxcTWhxT+zuL06uhg5rbj3Fx9EwIH1u0X/z95Q
	 nrI3fhVJWbtmVvrLRWs+lc/3wKvhuG+jfWDHx5gP8NFf9iKytzddiVrrHSYYpWwXiCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Kaa82wST;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=asuLPkuG;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C908C606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 19:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C908C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Kaa82wST;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=asuLPkuG
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id C075FEC085A
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 14:15:41 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 06 Nov 2026 14:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793992541; x=1794078941; bh=rxdY0nsqLw
	m0txzr7ot0PNOuws/MrcIJf7YLSZDAkQM=; b=Kaa82wST/Mdf+9QNaF/Ab4ZfoX
	x91Pr9VLBth4r5uuG4CmSd8NOII/LkcLJAvXk0p14UX/jTYLMZrTel/1rt7cSM7L
	i4HHtgZaENln7i/zSEHDWWA+id0wTIW+LAcWLTd1Jtt2uFFb2zqT4+j3VYWbPXQT
	khUS5go/dlOxLqyVxu1dYlInDizlciVuDtbAF11REkIh9d/H7CPUs2T0aEWfVhmN
	+LNkJtbOCknCYFcGX2Bc4P3qbStYC5MLYADHFkCSfaxrX5LbpVoSQrPFvsNjJvnR
	UaV102BFmiBsJ1jFMcX0Sr0qNg6at4Xj9d9oNOI2cFfK5exKn5UzTmFIZwmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793992541; x=1794078941; bh=rxdY0nsqLwm0txzr7ot0PNOuws/MrcIJf7Y
	LSZDAkQM=; b=asuLPkuGJhQup1k3Ei01VrLbkHVQDiWU4hPnHWO6DqKwABvEoGY
	q568N0buGbKDOt9Pg3L+bNRDkYJOXoaX5RnSuG4o5PvCATaztBrTAawBcKyQV2xJ
	WhWdQPBL/zFfWj0K0Kukb77PWU/Z0mvVlbQhWaPboqOswDi9h9kavXKBXt9yrj1G
	qkMjbpDQJFeAS8wokEXSl1EaOKYtR23lQAS4F5XwtQnXMCts1YTkM0H5pbfzi3v4
	JT0ymD6g811W6Ri1AAHJbaG/MV4974IpY+x86uPzDXrNDNYwFscL55TRdu7bZxIq
	w2sdbuoz6buyX6zQgyRZUKyuvwHks2gIrDA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793992541; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:LvR5KtnlSgF6m7H9cqC1igDoGfBgGTrM9l4TmxSyOz+W+9o
	YrHehLRL7EI1SRQQkLGhv0+dbtulySifIfI3jGp8Ing+dmTXetgEvd6rkbxVVAka
	ivCiGgeWQ0H3WGWuwWnWgX7G0Wl0LycuxvRc1qHBADjAHB/dw7bEWOzmEh7XDIbc
	XsFfdHuMFKrerrRmsANlFY8hFWFZo7xcEpkr/EE/L99wX/VBQux6YHeyc1tx7D8J
	0RehSlEaeG+tA3VQlpaYq0784PiJRPfnPx2RjgiDFVKMxGUq9DO8ZfSSWFH+Wlo/
	YaalRkdsrSd1w7v3ptlIXjIfKXfimcmZzEzJFQg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:IRAJ3KTOz3FBp55XBoGsOuYaFcbD67QHph/JSR994BE=:T0tONwAuNtuA0CdWnCHuZ4CyO4Ste/Z1OFcWnjQTR84=;
X-ME-Sender: <xms:XSfuaimk-hq2P9voySEbmA1wMDn9X8X7p1VuXvbby_GHFnPpDbizqw>
    <xme:XSfuaguiLasag9N8rbpp-90q8uVRhb0q3FNrsz9l85BKFywqN_QtAmmqFH0qxfK9o
    cnaQUR6VSwGh8lA-Kp3Pikkx0YXRtTytHTxS5b2zh4_Uqk9TBoSQMM>
X-ME-Received: <xmr:XSfuao9zOnGETYt6XB8I5KmNfjQM3o14eJBWRjJZm3s8zXq7L4so__Vko_Olyf0WHwRaqZIuqFax8clsK_cZlQwPP1dnMknsWwvI>
X-ME-Proxy-Cause: dmFkZTGqCqcx9yRPcNLBKc0pC4X92dE6O+HBjyBzh74ebYZK3IaOQbs6X3hYeUWHrqbQyp
    Nn17+7E6kWkTTo6WDlB/JiEixI3Yfr219BnxfHi9YPPR7xHlCWifdiMzgve8qhKSvtidmm
    +NeGeFQZ/EQa6dE6vnzdgFX/q6LgIxM/QiYYt1hebYQImjuL0fIvhTxoGUFwbNKJh3+vjE
    i6SZWuwxoGjywsu/xNYgeozs9qJyJ0kyGBol9GtcjcW57PEGo7pNJFLs+8d3imMbEkYh/z
    sf6jrsytzNnKzC+UJABm1AwyNMm3t8Yl72gh4fIwcpinI/m5ftDRTcJN+CftbWC7BLDZEg
    LCcI2FN3Ve8NqClr/IP0mpojo6qjgOsdt6EaDaf6ppss63hwoQTuCO0qxoYdcctNshhIw2
    MU/ibTTYxnLZIN1G1e5h3l2shSt/oqjk59bfMwcaaTBDvWBn2NqdYh6koTcfhGL6ax+3W1
    RLViWPolMQv3fhXA7dnoA1qqyrvWKgT5JqILvkQQPLGMdlv5UVy8dziOWS93r+ZRLZP14L
    F5Ly5XaXO6FpHSTe/nsh1eSeSeSEs9Gz+tvyd48oR99IsTga52kjmBEXROo0Sr7RPjGari
    s5vRT6T8Lz6+/vyyXPcNi4ZZMx0numy8XIcXRISlDHCW/Pb7FJVjcKSPKh+g
X-ME-Proxy: <xmx:XSfuaiPYKsl6d5RoWbnvrFBKtJzAYt_YngOaYROaZCW3k-GWLoPcPg>
    <xmx:XSfuauE1x_RRug8aqziefxJw-MvLldMP_6YbBNYPegwkDcdXDWDf4A>
    <xmx:XSfuaoRwogBhX9wyUarasgEG3le24MiOeVSLS2m9mxmFXQKQvCTaLQ>
    <xmx:XSfuajvIKb6aL9n7iUai-4UlIKYiCktgFJo7sgHNq0VC0wYybEitKA>
    <xmx:XSfuahekOEHAfav1zCtdh1qfjvjlLi-Xgt-psqFCLhx1pWRj5M_CZQzI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 14:15:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Aniket Gupta <aniketgupta3001@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 2/3] remote: do not show credentials when
 relative_url() fails
In-Reply-To: <85924f20-298f-401e-88f7-7fb3f949d0fe@gmail.com> (Derrick
	Stolee's message of "Fri, 6 Nov 2026 09:43:50 -0500")
References: <20261105152842.566318-1-aniketgupta3001@gmail.com>
	<20261105152842.566318-3-aniketgupta3001@gmail.com>
	<85924f20-298f-401e-88f7-7fb3f949d0fe@gmail.com>
Date: Fri, 06 Nov 2026 11:15:39 -0800
Message-ID: <xmqqqzgxixes.fsf@gitster.g>
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

Derrick Stolee <stolee@gmail.com> writes:

> In environments that store stdout/stderr logs, those systems already
> need to be careful about such strings in the commands themselves, let
> alone the output strings.

Hmph, is this true?  How can these systems be _careful_ without
knowing what these strings are?  By guessing that https:// is a common
enough thing that shoud raise red flag if there is some:thing@ that
follows it?

> And back to the bundle-URI application: if the bundle list uses such
> URIs for its child bundles, then that's not a safe mechanism for
> communicating those credentials. This isn't going to protect secrets
> like that from being exposed.

This is very true.  So the patch may be protecting us against an
issue that does not exist in practice?

Where do we use anonymize_url() in existing code paths?

 - "git clone" leaving "clone: from X" in the reflog
 - "git fetch" showing "From X" to show ref updates
 - "git push" shwoing "Pushing to X" in verbose output
 - remote-curl talking about "url" in die() messages
 - transport showing "To X" to show push_report.

These are all talking about what is shown on the screen except for
the reflog entry left by "git clone", I think.

Thanks.


