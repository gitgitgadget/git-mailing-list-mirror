Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792648458;
	b=MFUKfhIPFPgITPHAtL584HAM1bm+89CeEDZcKhC4EAvnQ1H646Zhgius2munIKnruNd5
	 wxpSZux2ATS6IuinddAupjXUN59cVzAwTXd7wnWyBsd51q6F6YerA4tGky7eve/FP2MOZ
	 5sbAUiT20uKPRYJpL1cwGNvxceL/x7AxagLnxRAkgxauPqR3+NOM1dMRRSqC4tgYUesa3
	 YZjKhypmSkPLtJOD0905t4RSTW19aagf06Hwu02I5q1/A71u+vu7GkZXJsCtfI5dN1epi
	 bFCDPz8P6p5oQbkOIoZBKqG8VNf0jHNIKyBqjKA2T0EVuwPrcYdAFyMFUvL1Ybqotlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792648458;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=6qxjHWzAs4Nt2rAsn3DXCfcskk1iXlF8vcmWE21NVhU=;
	b=kcSHd0l0XbJtOc+bRo8+Z4Zxd3ZvCNC5aPimmBy/gLT8R12PHErHItnO/bZcwY3Is77n
	 +Gy1z/IdW4LPYkSyw20qTT4IGAbAcxDW/hc0ki55Fwe2bh0m5lmKAFgtgUMcOrVDhlRM3
	 JgZzbtiJSA5s6AsxwH0SAEMvXKtoq5+LjK4sWm8dXvlURKdS1wvJV+B6nVSdTYVccz0hz
	 JHzXE0VR60NInSzj/giio/cbln0bFXPonobl7gkVCKswmgzfQR3ZIX8xPSKyYxAdH5xH+
	 KU8vJrX46z2fvPl859u9fsKpnGAw8gwus2LtcEMusrqrCO9Y4WwV2Jfh36YFEmWzPOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=GIbr0DaS;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="daU4/Gmq";
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264CD606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 05:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 264CD606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=GIbr0DaS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=daU4/Gmq
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1CA1F7A0081
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 01:54:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 22 Oct 2026 01:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792648455;
	 x=1792734855; bh=6qxjHWzAs4Nt2rAsn3DXCfcskk1iXlF8vcmWE21NVhU=; b=
	GIbr0DaS3Qux3McFoyta3mzEqjdDi2OEOTGMKqFAxyPS1AwCsiBi5bb3Q4JJlvef
	vs9LroP6CnKRh9W89mYgExd5cXX0Th7bHg9TCXHry3nB8ZMNEYGRcmFAna9su8M4
	okbQJjtliw3pKViQRvZZtvk1ns8wTbzZ/ijgEMwXse/CHH/RA2P2VsSDQa23P05j
	irs5zi//PaazVOjYzBcHn1j/BQM33Hyb6I0lJX0RIj5mSoZf7Uqn9oCwYOQTJhan
	KaI/VxMYNyMwrrS3FhhLRzC7sLyKNiEX22zIDlb7mjJxeqk2QWhoNtnLeDBKRtRK
	+yWVtHe/oFvoZ9YiCXh++g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792648455; x=
	1792734855; bh=6qxjHWzAs4Nt2rAsn3DXCfcskk1iXlF8vcmWE21NVhU=; b=d
	aU4/GmqLJzg1eVf8tJ1AGjfHkK2KI1DLrYZE15litoB8X1kKvaYTV0dOK5qTfkIa
	xkDrDu4RMG7NabPQdR7KJeBj6xp1p0jw62CnDrArQfTMHXphkHbS7K7v0K7GBgOt
	hRjURWo6jlnkMNJDvzHPhfFV93TBRlL88/EKb4hniYbxLamJ46OFhAoxAZC7ewtL
	6fBZZkXy2x3EW1w9a/myleSYQ418VGm84nLWLvHkHkN9uHkfylYJoXfCTB99yXm/
	StZBe42MKNimaGJxa+S/1wl+l85SK7usfTXpi6eAUD2RrJu2iCRJM4h7nL7dtqbm
	CkB7vb1+SsPMuA/7TTUqw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792648455; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Gajothrkw9/Uz7+6GZP1/0o7QJTT9MweaSodduPcJT868uf
	pNueDz5KgDIykyVy/lxppLOW0/W22P1OO7ec3N3Sydqgta3kxZ3yG+LT5xwGISUK
	GY+hGXWj0fDSnPG7KPvh5YPAb8iL9dW2XgWyrjdYTHvchefCSO4uIKw/Obciym5b
	Qs2JOrnN5TbHaFEe7aiPPkLKehLCM60DaA5ruxd8SMMUNES20UagA4Y4h59x5qL3
	6+aAONgB7QRCjx5FMiJjqY85U6fwwlrELBQ0mC4s01tztSGPh315c/36I8SpE+Md
	x0jE+9af6tjVAfUXKTGRTD9n/mls92VAkOgX/6Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:PUuT0zxD5zNEErnhoMIZgvf2F4FY5/TQ5zMj8+2LlTM=:wwoew9Jvm60imL7EOnAvNCMQ/r8qGSLObOzwH2NE7mA=;
X-ME-Sender: <xms:B6XZatvAkVmgpN4o95-FRaRR_CjbyUjLQHRWu1V9_psSAsSKpEBdtg>
    <xme:B6XZatefZi0a_H_dxhZ8ZqDLgIpR3xG2XfxOvg1t9JamlaHugrf4buJ5FBOAggUx0
    oKVLCAIXVf2iXHk0rMIB2xFzs930HT0q8DocUhUOpaeAn1OnXQr>
X-ME-Received: <xmr:B6XZalxGa8JEOMRhZlchhHUV75tl0ULvCd4JUSgFvjSvsVueXih38k5r124HH4AQ7RYQfQ>
X-ME-Proxy-Cause: dmFkZTEoDD+bow3nuErYeYZtxLvwG+GQ1I+ay3gzkl06v8Qki4nEYMbwf5Ub03EEQJx4oD
    hAwBtkNw461ejorNiuo1wulU6BjwFMrMO5anQJe/v6uBAqbXZR/vGrT5hCiFXkV0K24Bei
    CUIqS4rjxyKK7OS+KOfdcTBk9y6tMKRDQZqBweDI+FYdvfbOjTDmArOv2VZZqAsdhCSKDw
    a2zlOQlpXurTruMYqn0VcyM8/mw0mN2bqherZdD4lR76PS1R4Y0JjGP62QgTvBLozit2dZ
    rv5KYqiIQH5SZElh1p+g2t0GahE+PBzfTcd/3aQgeOEWKF9WnPHHAbWNEQ9quUqiIRL1Vx
    NrTnbKJvxtR0qYJI9P1gO9Whncz8b6s4z7G780mlD0PeWOkw5Du4QJHYXAc4R8O5SmFv6F
    FlavkFgm9ApBEpygWoJ3t1aVPSVBLn8UyKGI2TkJVKxMwicXyAl77JzBlV00yRMXCr6013
    KMdHN0a9ZH1kiWdyB3gAwK1oK+fJ4bofGuQcNZECV2fg5JvNdWfsOi1ysuTEdl1OXVdFYw
    A/NowX5/EvwzTFsm7C14kq9DFjGjbN2EyCFOLXaAED6r24uFsFNteQma5z5ClB0pKV54Nc
    opjq8up1GCAhGxEs35iVnsROixbBiZKJCEynIG03uNk+YLpSo8VAPD1AjlUg
X-ME-Proxy: <xmx:B6XZajGr06b_55G7vYHzCi_F6-deBu4qOqrGpfzLvKVdqUmJm92Ajw>
    <xmx:B6XZapwfWzC64n1ZPYG3qbPfOvtFV9mJ8B6lTZMVO6ewddRLsOx6hw>
    <xmx:B6XZakvrmC_pDrD4wn0OjjCFNKrpewxD0ouFOscvy7GPQAa8CdfLRA>
    <xmx:B6XZam2kkCIKD8E_65A6bo3WMR8_HN_2WLAYnJQ8i7Uu5hVEzzw2gg>
    <xmx:B6XZapR3p6HeK4nAr4s5_ysd8xTRlaj6bMaCC9lJ0G0sofiqhvddatQw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 01:54:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4fccf7d4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Oct 2026 05:54:12 +0000 (UTC)
Date: Thu, 22 Oct 2026 07:54:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/5] doc: move BreakingChanges to a manpage
Message-ID: <atmk9Q4MRK2JRTlr@pks.im>
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
 <V2_CV_gitbrchanges7_please.dc4@m5gid.xyz>
 <612b6065-9043-425c-83a7-2cfdbe140c4a@app.fastmail.com>
 <CALnO6CBuKKF=nCObFCK0coCDqbK=OJTWEshEtj6NaVV6XpWGuw@mail.gmail.com>
 <xmqq5wyvq9p8.fsf@gitster.g>
 <ab05a3c1-9da7-498a-a9bc-d586414ad0ec@app.fastmail.com>
 <xmqqy0bqlqez.fsf@gitster.g>
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
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy0bqlqez.fsf@gitster.g>

On Wed, Oct 21, 2026 at 02:00:52PM -0700, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
> 
> > On Wed, Oct 21, 2026, at 18:50, Junio C Hamano wrote:
> >> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
> >>
> >>>> Is there any interest in continuing this series?
> >>>
> >>> For myself, I favor making more of Git's documentation accessible to folks.
> >>
> >> I do not know about "manual pages", but making this available from
> >> "git help" would be good.  It raises a huge question about what to
> >> do when Git 3.0 comes, though.  Are we going to change every section
> >> and rewrite them to say "we used to do this differently before 3.0"?
> >
> > See me and Patrick’s subthread: <ar0OicAaDipYx-xU@pks.im>
> >
> > You could transform it into a section at the end for “what happened in 3.0” then introduce it with
> >
> >     These things changed in 3.0. They are written in the future tense
> >     [?] is reading about what will happen coming from version 2.98 to
> >     3.0.
> >
> > Then you wouldn’t need to change any of the rest of the text.
> 
> The rewriting effort is not a major concern.  Rather, the question
> is whether keeping such a historical document is worth it.  Do you
> still care about what the major issues were when we transitioned
> from Git 1.x to 2.0, for example?

Probably not two decades later, but at least for the next couple of
years I'd assume. It's likely that upgrades jump multiple versions at a
time, for example because the user upgraded from one LTS release to the
next one. So they may or may not land on Git 3.0 directly, but it's more
likely to assume that they'l land on 3.x where x != 0. And these users
would still want to learn about what has changed in the major release.

So I'd say that it makes sense to keep it until at least all of our
supported distributions have upgraded to Git 3.0 already.

Patrick
