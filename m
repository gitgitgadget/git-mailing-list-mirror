Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405827;
	b=3cNnAB1TUNJuNigWpCjXjDV8fi4dzf2Q4TVQ/O0pIkMpu1rxHqz33YR4qu1MUBdrnnc3
	 R9286NiCWbs/d0B1fhYrjG+1wFaKXngZwj5Blh2Ej69jRH1BfI6H1K4gtskb274ydy4uf
	 3fnifCle0FeDXHtrZbXyDxZNDPvMAPGDJhiROBy2NliHiY5C8KzfM+WXr6ibHoctQj6N8
	 ukf2oIlyEJW1Z4VpcdO5rOOoneav4YX48vksfVeq/tMYrl0jqtDMuSnQl1YWAcQOxkzSC
	 eITalEtClUerS//S3USYwEaISlBHAACGI0JbHeQQJQfbcqEsedoAd/VjUsc5U6q5B+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405827;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=YzIvUqxBaV4NGd0IWQxHjNJC8VSXi9EX4ymz7jTpY4c=;
	b=Mt4jbgW+U++hPuajF+s2gzx1eNKvdtu1RNHTzgNPsab5WGPhSk+czH0AYuXQkEj8uEid
	 aTsHrJ4tNRORAYlgK4hG9E8U7Zx0kqWIwRtrQvay522ixBMfwpgvaikVYPHyBB935Sdk4
	 2/UIxSmbtW6MjCEj0bYrsMOyPznusicgGw7foeYKMCgFonrklkYX5YuS03HmrKh/DJ2aX
	 0KtE8pUyAD0r0uTcVj5Z2b//LDCxqRNNREaqIyfIa2AQIKIfEAa+0pnQkdVHkcOlrYfNW
	 zJG8kur0WgTPSsL9uLsdg8sfRwQFFgtL4zaXcuL9QqeFpxHY3TfD+TCN7GZMKmejayQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=JuHiFuJ0;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TxAAhcon;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AFD606A321
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 14:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46AFD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=JuHiFuJ0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TxAAhcon
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 908D51D00249
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 09:03:46 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 11 Nov 2026 09:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794405825;
	 x=1794492225; bh=YzIvUqxBaV4NGd0IWQxHjNJC8VSXi9EX4ymz7jTpY4c=; b=
	JuHiFuJ0cTKrDHgIE6U4EIr2yg+qop5/OqiIIOCN/wVJfDWJmHMCkTSn5mZ9KuCe
	QgJLjMIg+NtZuLdrUlp1lim9Qo+twwQKCBj4pGUtAaRRM+Ac6JMGsTVBtCrPsbWy
	0xPbx8eg9Ebsh9zH6FfD3EC01bBd3mXyDphSWqSb6Bsf+VWo1ctJgisWJlzt6SQ0
	CoQz4c1xJQZxUOqzCD281nanqrBUVeX6HBH2NjozGbv0OhrMCHy0fuwlPouzYsQE
	fQg+tUj2pcB2qL+4Wh1h3+KUTsgMHS+rnVBN6RvjHA9XS1/xlFmV0PCskdZ5LiQO
	pRxLiDVgCDYW2l2z5F2cEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794405825; x=
	1794492225; bh=YzIvUqxBaV4NGd0IWQxHjNJC8VSXi9EX4ymz7jTpY4c=; b=T
	xAAhconDEOVDQxQx5XW7ud5jyQ0LgBVY4+kSyVKgN9SWdwa/KKJHU+j0gmiswtbQ
	LRobkD6ZfK6K3+56umK2tyLqxD4GfA9rDo3QCuYCVGVElDeYywNZweauFRDfKIjd
	TAw91iq2Me+p81cH2rXtVPnWPWNglzSCUzxuG5qZOTY8Ltv587f23T6wRW/lU99f
	0P7LyumKXYAHQ5TGvdmJ83hfhEipQu8i2wYFN98HOgg+6r/OJ+NNvG7ouzbbZ+Qg
	P3mTZ/u0DOFcw5OYFhy/2RhkeDyUgDswbKNrhXONdx+pN5A+ClZJbpKKLolL7gSx
	D7jw2Lu9JPtdRvt0WhPRA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794405825; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:rnf/TxN2Nox7yx08OUNEZGaHjI+p/cnvHvt6fRQG+C9YHQG
	LWS4TeXd8oDRJZNkLAFX/AUHn8H2HTLQ3+0ZtubKX1dk7htkfQm1kBkAgCpdRTAF
	SiNWU9W4GbzryVpBmb9bD+VdagPx51u2fSTFIJCN2DebX0hYFoPcAoecF225uLqi
	rsyFLl8+KcKvmWUw6IpclzwSAfOpFQ6bLgA2nBfXuhscaLZODpfQFiGPBxCeCIjQ
	yUJtuZSWmtysico+cKnP7R5yVYh3sNub5tPdAXy/c7IGusRVTcAHIo754x1r999d
	3XWPu58ArEWoaKM9PIwSC0VOZ5ushMVI/2ouq2g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:iI69LxVBG1Nd3CCxcgAYgno8Rd5GiDdToOu0xRya8XQ=:reNUQrZ7BgLjH5a6PR69NXbENBKa1pUIrSZFHaliFEc=;
X-ME-Sender: <xms:wXX0asfxA8qlMS1uX5rOWwV7RrK6zNFkgqOpBGJnKgOUJCpapaHcnQ>
    <xme:wXX0ajJx5xF-FHK2mees6X07OSk6R-qOhexVcMbmWZzcpmjEOpQes4_w6mtEXSGsb
    vw61t5kGLAkeIywLryxcuZXZht7cUum8q9V3Cc3Z3V2yvQCu5_H4Z2z>
X-ME-Received: <xmr:wXX0ahxO1saMWzH1cqkgkWIFti9irOd9JHsIN1VwO2lKabZheyHYxAJTcGGkuaA3CVZe9g>
X-ME-Proxy-Cause: dmFkZTEdfevom6Obifo3m7w0Kcni5uxDZWQfP/HQF4OSxo2w4Mc54wSqY+zokkR5smReIs
    WgnwESxEyquWzCUvpogzWUkuXyqJ/jeoJscpUcZrFBoWczFynmpp14edbSttZ1Yv9ds41d
    InWiSSW2RxyyHjHIZb4AfwSHzMUS/S3kh8SVGE+wATLlz/BDfRkjOPUCR08MnbTdpXS28w
    lO9Deub5xYeIHdoSsFvWUAnnPmhD9N0JiGkPUtc3lqnJ4CzfHfPIhLN/9GmS20weIHOvBE
    apacOS3sGthAK1Plk8xKGvvsJqAomtZKT7eT11CsOUK9efBbT3fn/OZe9StVufIukb8eeg
    6rZh9s0R9zhes6tk3HNFKGpCPO6EZ+23wJI+aoGsrmeZ0rk8hKe4oMYpZOcuMbLWRE1VJJ
    Wf4UXiFcjwkOKeEvLE22h+qq4SuPk1b7dS5wwf1Sor6y0gXPmCkf9i1Zk8YjLDiSaWaWaw
    UvpxKXExOeOp37r5HBqCcF09M7yKTAbU2jIEi3PND9ISchSolX4XmUo1hBVVMVyobfDC6L
    okEsWmyWOEO+kVbGxd03yKe8i/a8mDlC25Z4c6LAaqBcx2bODwQX2fao+s5/peOY5NGhOu
    0zMxf5y2X1jSAJ0T6JiCUqEAUSVcx9zOxT0Mbj/gebRHcrqO1PEFaEn26H9Q
X-ME-Proxy: <xmx:wXX0ahsg3o5YMBZXASxSF6g_E6g-VwO7BwJy-AEVMSfVShGc0qqjpQ>
    <xmx:wXX0asDpVjHV0rFJ_XgClylD1yGbjPV4z8DK03B37K3_m2QTh6R8jA>
    <xmx:wXX0arHtz4yjwaJyVXplybv2mZzJD873wpmLEM_nvTPCAFSK9_bjUQ>
    <xmx:wXX0akBz59ReAzfLxqC2-qL5_vuYiTqF980dIXgjfoTfSWx4jCeAgA>
    <xmx:wXX0aulDlNtyUEOEXVaF8MW2I4F2hcVsYWUNNP3JhjQy0rZ2kqosWTZ_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 09:03:43 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 125998b7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 14:03:42 +0000 (UTC)
Date: Wed, 11 Nov 2026 15:03:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ben Knoble <ben.knoble@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jelle van der Waa <jelle@vdwaa.nl>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Harald Nordgren <haraldnordgren@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [RFC PATCH 0/2] Support --verbose in git history
Message-ID: <avR1u_y2IQ8WoJXe@pks.im>
References: <CAOLa=ZQowi+fepj+RNegTZhK_Jy4G8VLE_Af2UdsO8-rCdviJQ@mail.gmail.com>
 <53CA2747-58F6-4A7C-81EC-33EABF0000FC@gmail.com>
 <avRHowwvxoo3e78H@pks.im>
 <e93076c4-cd5a-42ab-b383-e77ef68c1214@gmail.com>
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
In-Reply-To: <e93076c4-cd5a-42ab-b383-e77ef68c1214@gmail.com>

On Wed, Nov 11, 2026 at 01:57:46PM +0000, Phillip Wood wrote:
> Hi Patrick
> 
> On 11/11/2026 10:46, Patrick Steinhardt wrote:
> > On Tue, Nov 10, 2026 at 12:15:20PM -0500, Ben Knoble wrote:
> > > > Le 10 nov. 2026 à 08:13, Karthik Nayak <karthik.188@gmail.com> a écrit :
> > > > ﻿Phillip Wood <phillip.wood123@gmail.com> writes:
> > > > > 
> > > > > Another case where we might not want the diff is scripted editing as it
> > > > > is much easier if the script does not have to worry about the diff
> > > > > getting in the way of its edits. Personally I'd be happy to see this on
> > > > > by default - the history command is marked as experimental so if having
> > > > > it on by default rather than following "commit.verbose" proves to be
> > > > > problematic we can always change it in the future. If we were staring
> > > > > again I'd also make "commit.verbose" on by default as well so maybe I'm
> > > > > biased.
> > > > > 
> > > > I'm on board with this suggestion. Plus, I see 'git history' to be more
> > > > user facing and it's always nicer to have better defaults for users.
> > > > Showing diffs and verbose information seems to be inline with that. We
> > > > could add an option to disable such output for scripts (but that can be
> > > > done later as you suggested).
> > > > <signature.asc>
> > > 
> > > I can live with opt-out as long as I can turn it off via config.
> > 
> > Yeah, agreed. For me there's two important parts, where being able to
> > disable this is the first one. The second part is that we need to make
> > sure that such a format can work for every subcommand of git-history(1)
> > so that we don't have to have multiple different formats for it.
> 
> Can I just check what you mean by "format" please. It is not clear if that
> refers to the option name, or the way the diff is presented in the message
> template (or both?).

Both probably, but what I meant is the output format. So it would need
to be able to cover:

  - Changes to the commit layout (e.g. `git history split`).

  - Changes to the commit order (a future `git history move`).

  - Changes to the commit message.

  - Updates to multiple references.

I don't think we need to have everything implemented in a first
iteration. But the output format should be flexible enough to display
these kinds of changes.

To me it almost feels like what we want is essentially the format used
by git-range-diff(1).

Patrick
