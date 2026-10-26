Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015679;
	b=0q9d3bMLjBKU6iVdKJZjWPjpWen7e0TB4IcxToH+3O2jGyUxUWRNw6WD3dG6+SL3hjx5
	 btL+vMQi1un/cVuiiyWD5BmxLHCAX/71qUWSotrjJz0G66jxvnrw1KkavnYyi4Wv/1kXn
	 XBcbrY56oFcF+RuBLPPCb3nUTD9SR2Kc44Wrq+iNC35TvT2MhvJSwZOu9S7xnSBVlPWSx
	 xF7j73qyozlyP2aKN7D9QlMyOMJ/p5VZJFkPeoTjtSi6wtotNJzK3gHgsbXYZkW2OFPLY
	 4wB+pIiN8tB6RD60oGuD29XB0st9f2E4k+jrN28SYmj4Zsb+eqsNzLuUYHD310fmBsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015679;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=fLdXg8anT1vXIiS9uWTwI4buPyKsK7emaW4gUMF9FB8=;
	b=Pfs3XeZtBESiAr+TzR1TGgMQgtxCXTWMDJc06S+GOlSuavD1Ud1rTp8um8TG81fzz4T1
	 BXITruzS9pBPk8dIvH8KpiBTd7uUZiFPngmMzjEx7h2QrcSJY5UJl7PalbHZ9fYMyD4Nn
	 hRav3mTZBXs8VVFIIvoZcFycsCJ5LHVP0lBw9msSPKW7+hibpcSArLORxwEPjf+12t0yF
	 +bUXBt5agzVJSzWnN0CBI45Bxc/LyDmb1JKe98T2OhiOcBh9/O3oc45bD/OBZlHkdt9y8
	 o/DfJc0wY1jGM/PuGKyZmbgPJlzyK36ZSuu3oJAdcyjbdVYsAaHDT2c9jUdHnVBsPnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=A9C8b6bn;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="eg/85f5K";
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9038606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 11:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9038606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=A9C8b6bn;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=eg/85f5K
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 613997A0160
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 07:54:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 26 Oct 2026 07:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793015678;
	 x=1793102078; bh=fLdXg8anT1vXIiS9uWTwI4buPyKsK7emaW4gUMF9FB8=; b=
	A9C8b6bnFWKXI3XXlyhIYi/MOUnGpMHiiP/isiMXjsdws/Da1tlTFLpCU3it51Tz
	WiISPjrauTkkx7Y2Uw6rcvenxfdVbgqfuG7OKpgTkmw8mdnaao3JKSVG+evpCHtY
	l/KsPzxuzggNj5Q3L1IhkbnN+HoJL8SPcgbd5FHqBEvO/kNvh1Tp/hBnkfi/UoXO
	dtM0Uha3So/4oUanGjaaXK+CMFRkJC4c9uzlz8jfM386QanWnr0yuZXs6kmfR7/P
	nwgiqpMHQr2dinyR0/A0Y4TZZB1za4T+KhxrYFmZRmGkY4cEsj/VbTsrT/m/akGE
	VdKhzsLj9sHB32dHdrkfaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793015678; x=
	1793102078; bh=fLdXg8anT1vXIiS9uWTwI4buPyKsK7emaW4gUMF9FB8=; b=e
	g/85f5KQwfAbyGwohxbMmr6Vv78nP/0aw9nmsgDjI7xU1rKNa4A2HeWzUn6EasnC
	yZd48c3yk0uXVfCi7qXK//cIgVci4pjIbnYvhfBGW/P6estat/gtuNHBMvu/l6/w
	oAMT+4x9L04wYqI5aJKOJ8KWSHgr8LKPavtRTCcBE9W6gHnkSEsUMpolpxUEHFs/
	czFKiA3pwxajDH9UlQZuT7nmGLOvVKBX3cB7R1Sm0LXhUugtQfef/e3Bm91+B2Id
	KsIL4pQ7zTYbJtOsNpmrz6xK2TuftBN/26ZKKI7u0VPiMBvoQ52rkeqgyLwACMA8
	S3yTsFEeg1kYwo3ur/RgQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793015678; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:sR2xbHkclhDrxA96NipuYLQWyX8s3kizyZP+Pd80dNjm9cd
	vZ8mXuDSE+yVahzIWjNqNfCNRkXUa1PXXGGV0/Ymedvuij3iGR9yPLPnJatMSzdW
	51gFEq0pacR35KJsXy+SfsV2l181VhvhKrH8sP3LBucO3WrktP5j033FNCsvVhw/
	4IH/GUc/TTfcCWG65+b0twvTMDMYR1UsiSuZQMGk5vXM+C/eF8C/jZFVU0FMqUYL
	3wLxlPSwmObrYezaKE7F7oU/t1aaU9HB5JpojP6mxKWjoJddU0MZuDAjDAvEtT0c
	BCCyKrBAmUhNjeGJkXbSWjpJjO9j6dNCnZ0R89g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:wUhBuFeqyOtyIShcmYp1WLWteg8AcfylEhEU//f/DiI=:fLdXg8anT1vXIiS9uWTwI4buPyKsK7emaW4gUMF9FB8=;
X-ME-Sender: <xms:fj_fau24PXZIC7Txt0LCH46yYcnGSCLNo_JPR8CZOKmQ-pp4oFrlug>
    <xme:fj_fakzsWcS06O_JAiznGUR9VTskT07GAn8LmNdX4eKQc3bVDKmwdbP4GbPqd9myf
    oeEl65FWTQ8P3C15U8HHHYqE_7-r8RAzy3qlIChwsCqV0fV_jH5h74>
X-ME-Received: <xmr:fj_fags_aWsWQJ-_lUVbfuCCtvBEIvMFrj6XQWIOXtS0TholKUC9Dg>
X-ME-Proxy-Cause: dmFkZTFcmQ4KChvm2KSmT0gVjY5WvFOSYktgHn1ZUU8r0ATzsF2YoUuxvDXDYSmQOerFYd
    qth6ZnHqMjcYsuGW2n7jqthzVXcO1ryBkJPnhy2dV4GifmHUcQ2eDfxGUtyeh/wdDoHPL1
    7br18qdpauj4OMv5YdHuPJWAxTX6oj+drMlkZqC8ISlHlHbLjuxUEN0D17DmLpxHVUOJfe
    QNrVGaDfjRUSqtlXb2AGIIo6d48x+ZimcejASmGmbjLIQeKAXlaurSyv6kRmge4g/fIWl4
    0gCSj+FW44tAWwqir8SQ4l80s4wvY9sGRrURy0prcniRC12gQW5fyk8QN988ovrJtVOoE5
    2TL3sPDlpstwFuJQrxH38RUV1wAOJhbrroOmI5DnOsKqc75WkYzIGGG5+m/3wiN+coR1j7
    zglwAdYtjW+2+WkBZXGNqAtnhbOodg+UoqIxI18GmUobbC0tKYygZdMgheY7ErrwiBBbXA
    AXkdNwdeST5k8uj2ERdk/ERgYcY/S9OhO/zBk6ScalBhaARdImk7EwoCYCepu7treDgCU3
    QEB4ce4/75BQa558jUb3UE5THcWfyRy+Mb8WLSXFO8UtloeeCsbXVdzBOtM5L3E4XxKHo3
    fZwS4uMVfZSTi/I5gFoxufRE0emMMp8IjHvlN8FNi+QRt9Yb+34HVutwyJxg
X-ME-Proxy: <xmx:fj_famwphdZy0s0GRTyvntd_qxnevB1Fj-B5A5Hlf_q__5gn_ctT8w>
    <xmx:fj_fajB67zdakK3JC_PYP2wjHnvkGFI4BjCVqQeCQamoGr2sLWBYQg>
    <xmx:fj_fakdFLsylheAzTM02XDVsVeYmN04zAcpdktyLx9MuacLJQfCPZw>
    <xmx:fj_fatm_bf-BtkY6kkJ-VMFnixb4evGiG_rEahjELbrQSiceqvXawQ>
    <xmx:fj_fai0W_U38WIb7VoWofxL3S3OqYeQ1FYImOsrprvjr5_pmXbP8BpZK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 07:54:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2163233c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 11:54:35 +0000 (UTC)
Date: Mon, 26 Oct 2026 12:54:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com
Subject: Re: [Outreachy PATCH] diffcore-rename: stop using the_repository
Message-ID: <at8_ebX7cYMrlhU9@pks.im>
References: <20261024221341.92086-1-okhuomonajayi54@gmail.com>
 <at8w9u6qA1dhmw3r@pks.im>
 <CAFpMFfDaVf47QKkNROJAHJB7oJR+iPt5gkkCnj4KdZW_9MRqGQ@mail.gmail.com>
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
In-Reply-To: <CAFpMFfDaVf47QKkNROJAHJB7oJR+iPt5gkkCnj4KdZW_9MRqGQ@mail.gmail.com>

On Mon, Oct 26, 2026 at 12:22:59PM +0100, Okhuomon Ajayi wrote:
> Thanks for the review, Patrick!

Nit: please don't top-post, the expectation is to write your answer
below the parts you respond to. Thanks!

Patrick

> On Mon, Oct 26, 2026 at 11:52 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Sat, Oct 24, 2026 at 11:13:41PM +0100, Okhuomon Ajayi wrote:
> > > diffcore_rename_extended() already has the repository through
> > > options. Use its hash algorithm when checking for empty blobs,
> > > and pass it to start_delayed_progress().
> > >
> > > Remove the USE_THE_REPOSITORY_VARIABLE definition.
> >
> > All of the conversions are trivial, and we already dereference
> > `options->repo` unconditionally in this function. So the patch looks
> > trivially correct to me, nice!
> >
> > Patrick
