Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792998082;
	b=iZfxtNQJEpfHJU+wCMEvoN0Q0v8IyT+iqymqXQ5+W2kZs2IjLaJqSsl6odvd/4sAt7y6
	 CZWaJA856Jd3rINQ9yLScRokEYnWvP76Xh0uuAte+0QwqByCVeNaAOcE1ssV4EmbtUMW3
	 pJIwbwGWgqLXL/76sbR0oNCvPyy+7LMi1GkIZSTBu1Cmm3DmG59DzFrHyLbXjnjT3N9DX
	 0oMFEENb7sCZ6MjbUmRWWLlgDUf9VvFdFSCB6g2om+wRGmYWMczAIFDwI9wcc1DHadU9X
	 j/5ahs04ZPh5Xs7a/FHMDdMNaRQDKyNIQ9Nwgm4n9LY8isKTpQoFV7JI7eZYxcXehYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792998082;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=THjTN5usCtLJz1MzAjzeeEG7ddGd8P/3zNuVe47SaA4=;
	b=WFDgMpO+vHgRkyHO1qA2isYkrjXOB6mEj5m0eSy4NWvQgMYeD6Emilc7B1l0WZh0p3S9
	 I4QvAr5atECLhLfIw1N2krU1+D4zeN+1BP4m64Ze99AeZCh+QFV8zpW/VS6qU0RLuYI2Y
	 edstgmI3rFF/3Q/R/u1kOUfjciQoxHN9M3d0CaIWP1ChBk2YkG5504GMyJcE/g5MZ+RXd
	 8RiIjRtd9iseiPrdlje8b8kem1nxGxNeiBPkwcenFaHkdcBT7iTGQ39pruzpkb277l4du
	 A2ZVs+j3cp0l7msekO0AuPeK+3Vcq7tVQX+Mjy8BwdLghnr4gX16ojG0iEuSQToeJ1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=A9PhWwbr;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ir5TrHGC;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB70606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 07:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCB70606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=A9PhWwbr;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ir5TrHGC
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id F35331D0004D
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 03:01:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 26 Oct 2026 03:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792998080; x=1793084480; bh=THjTN5usCt
	LJz1MzAjzeeEG7ddGd8P/3zNuVe47SaA4=; b=A9PhWwbrrSbhex018oAlDHTPE7
	VpFvCnOsE/zCxQnLm2ApjFbJUBvMusOfKhHytb7RGwNixjWf3fr7us5xiY1U7s2J
	vtRWa4b/dV93OpiAJGLFVa8GBoiJbTY7EZt+yX/16ad7xaCsHg2pVBpMF4+GIBSk
	ok5BDqBbqfrv02QJlmVhq0QqGfgBLyl3Df//Pmptl1fCB6iR52zcsUwyKwbkZr/z
	1HMmd5M9kgS88J0PKvGwnRtzzO7gshB2z8lULmklaEjUNKMcxIxoLwoB7gi92GOF
	Ad7lmF1MFoTMZglwAuC0DGlOdew/HofQQDMT0N9HZjdxyiVU2oJsT16Dk0Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792998080; x=1793084480; bh=THjTN5usCtLJz1MzAjzeeEG7ddGd8P/3zNu
	Ve47SaA4=; b=ir5TrHGCF87t2m6YcW7hZeVXE1O8QgKEGxHx9kavJ7Ztp3EumNq
	bQto7OTFs3mMu/qcdlvPjmT/ZAb248kAGJ8BkNvjxHSCdI2P0b9Mnr0023QWIdYC
	QUAW0sI3+WhxLX+jbbfLedf76VSxnLKmjVy3tC3QU3Efg2dGNX/1RVYK4CECWocC
	7VWDIkx/zVJAXgEDijanZvjGK+rg4vqvqA5Qi5LuQ/IipmbUVKVcLh6cH/an/31A
	Is/yyqtqpti3EhENkbyBgICeBIPeWfq5wUN8wYTsTSIP5X6FaXyv9hkMqFK/Zxta
	V+8MLF1pV5kcOB3NP0BRvdYLrE/SAwRxFVw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792998080; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:HrTtQXQgon5GN+sgrBJGvC8JMNHBd0kNIcyQSIK1xiyG9Az
	1bWglabzIfuPbnRBNXxGWgoCcPkAvejxUvmTIrO7WR4rL06aNgSGjP1nNJtiH3dl
	tc7SHNGv3+7TigMs8q3Y2ylakptsRCnFekV6zb64qJgmeQ6FrvLJ3Dr2eHkLKLPw
	BSqL+3usftbEVQXLIwvTnPfbxWTR59ARKsoy9CDGBEkKlZGqtDTzPmb1SfHjb8ca
	8glP/TJyG4RKnuAz2YHslzfQT2LvgBb+Efxjlkp9fBQ30Pq/OVxUpBaDGE6kye3P
	7JDEH5PmHA/ou3VdQwB8Sq3Tm3fvvVB2hOxWjqw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:mHcvgzGtSSUBVSrnmM3bl1op16woWc1Kfsu+I2U8MkE=:hgSoTOEF8ViZECTIQ2Nvfp/41eUnfdmNWoxr5tn202g=;
X-ME-Sender: <xms:wPreai2wRMzgdXG-KxeXr3DDzl4ogkRqRQJOj4RHLr6h5w7GbkunUQ>
    <xme:wPreasExMoIpt6LkkD45XpCKMSpUPXbQdYuqNlm1ycBMiY337_p33z_X054fRvD94
    xSyijtXPVbWXL3hmCt4xgi-uEZsTjbQyMQav47EKGFib_j9hcrBzg>
X-ME-Received: <xmr:wPreav6i6DHk7SB5tAeKYEus53dPWbueaCoVQyRE3dD1jrCKAaSihg>
X-ME-Proxy-Cause: dmFkZTGDvWYzcxHeNFuz9gc5kx2UDkXws4WKRDE1iriVit4hQrvsydyNTtGkxyNixJCj47
    xyuu0g9lLa36daTLwSETEPCv/BgFcqnMLO3wiMZWQdxokcdcIxLo5EffgzrZyjrQb4ku1o
    yFw5HnB4VlyimyzvdS1/0eJKL7bjsjEwOxliDhouAQkhoMuUS1eNo6zMDlryn7i0rDmH/J
    WjwQOxdXCJy1m5WnzAGqLxSB8xQOt1JV1S7AOEZwbdh2J9R5wrZeioDqzFKyrFz4Ypc2uB
    MdlzlsbGNo+1EPx9YaOLtdeuoln3q/xYoYKNQhbp0Da688FS6Aj0Y/HNgiJJagEF4wVlpC
    dVpsgdduYX4QkMJz2C1UWCd9N2KX9B/g0Co20g26cLTHx8y3tOoh97YnQ2NDtsMKjxlmjt
    XfjvAZbAt7i6LKV+lZ5BLefD/2QP1JQ6xcnAsULuasYAHm7oPWQanZ3t4tShQ+Ovw5FVGV
    /z+X/RWJqnQVhR+k+pFg545q8hFCEpf9RKosXECSIfGXh4IVSWv23pGyEjCjpUTDp5l44V
    WoFEEzqB00MeIKDMVFiWTgVgBzsU7aYYQlZHYyUfS06TH2hk43YEWXu+DZt7U4urKwtTcj
    ojWuy5dG9x6/QjhlBMU2NqGRQ3jiaUh7OMeDzD+Q2nW+TWbsGpNqpaat+isQ
X-ME-Proxy: <xmx:wPreaiuoxaE4X1f7LBC05344f7to5zUGJrE5YRmLe28FOmCsBIJryQ>
    <xmx:wPreag5yJHVPWjuAw6aIpY2UziQKd83Dm2G0l9a_paufTs3QTtpMWQ>
    <xmx:wPreatVxezaAaumwzJQ1xKdsdW7_gIWuUTzSm1FxxhFhgAp3d-cZ5A>
    <xmx:wPreai_pG0mVcZazgtcF9FOjdwWl0pFM9ETnRGftFm9nKdQ6zS2yaQ>
    <xmx:wPreasp44hUvb36NDX2vX6wf41EkW11DWVZfCR9qJPVaOM6Nt2dszMfd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 03:01:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4afee91b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 07:01:18 +0000 (UTC)
Date: Mon, 26 Oct 2026 08:01:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Matt Hunter <m@lfurio.us>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] init: show absolute path of (re)initialized repository
Message-ID: <at76u_L1yiot329r@pks.im>
References: <20261020053932.1274210-1-m@lfurio.us>
 <20261022120749.3567828-1-m@lfurio.us>
 <atr-Juww5KZN-ugM@pks.im>
 <DMC7P4CPEV2X.25XRRSBEZCFPH@lfurio.us>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMC7P4CPEV2X.25XRRSBEZCFPH@lfurio.us>

On Fri, Oct 23, 2026 at 08:21:11AM -0400, Matt Hunter wrote:
> On Fri Oct 23, 2026 at 2:26 AM EDT, Patrick Steinhardt wrote:
> > On Thu, Oct 22, 2026 at 08:06:32AM -0400, Matt Hunter wrote:
> >>  
> >> +test_expect_success 'init shows absolute path to gitdir' '
> >> +	expect="$(pwd)/init-path" &&
> >
> > I don't think this extra variable buys us anything, so I'd just drop it.
> >
> >> +	git init init-path >actual &&
> >> +	test_grep "$expect" actual
> >> +'
> >
> > I would have tested for the whole message, which is short enough to be
> > reasonable, I'd say.
> 
> I considered this.  I decided on this simpler version since there are
> 4 possible messages that could appear at the end of git init.  Do we
> want separate tests/assertions to check all outputs
> 
>     "Reinitialized existing shared Git repository in %s%s"
>     "Reinitialized existing Git repository in %s%s"
>     "Initialized empty shared Git repository in %s%s"
>     "Initialized empty Git repository in %s%s"
> 
> are as expected?

I feel like that'd probably be a bit excessive.

> Furthermore, the final path element is configurable as well, though
> should just be ".git" in the case of these tests.  I figured, since the
> actual breakage was about the appearance of the path, then I would just
> test _that aspect_ of the output in this test.
> 
> How do we feel about this assertion
> 
>     echo "Initialized empty Git repository in $(pwd)/init-path/.git/" >expect
>     test_cmp expect actual
> 
> which tests the whole message of just the default case?  The unnecessary
> variable you point out above is repurposed into a needed tmp file.

I'd say that's good enough for now. Thanks!

Patrick
