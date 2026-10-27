Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793138714;
	b=rG7gXqVwSTHPCV9KUi3rDfI1S96wcHXLfHnlkhrtrhycPbXWJfwof2ubK3IiYLYTBr1J
	 Nt9cPHogcAeFd+EKhe766Gt5RNqXHsGNmzgg8nvWegueCha+a1KiQW0evSCs2m8sqWxoC
	 WSgnKUWWgmMAezZUhsIm10woxOrfOm898QltGgYbDQ0tSCXR8zc6H4k8VGdrlavt+4UBU
	 twgmphzhQbRaUXF5AChUu99tLGEPYj91YKvRWaDy9TEm3oQLIW4h8QoHV7fE6PkHKUSkM
	 9Ct/qimNvVi29BviHwnw4leVBkurKI+j1axdO2IZcBc/7QTv4yD4xrU1WOR5EjswD5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793138714;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dBtuDw7XAwc1e7TRBObpy6fBLskoxZZKa1Z3umMOK4o=;
	b=mZ7PvsR4fWJK03fsNrDCnilxnWDyZYoGJgErR4kohyYlSCYlRnZnUKYyvy6XZCKSXFcO
	 1N4Lr96JdtqrCnrR+V68c9ZeQFcf7SuRxjaJLnon3WBJi4ZC6IBrilcBOz63lLtaBgqft
	 UvVytlyfPDR2YOmo9Ery64cmwQTBKaOgIcq9Ftc2ycIjoL2lsMLCqV1tfJNI79juVHaF8
	 rLJxC3sPviTDOPZMPUxdHNT85qwtUgQpTBT+oaXPVnbk4yGkLj4qUbK5QUijZ6ETuw4hP
	 d0uCtoZ/REkZsR4H5bn2i7u2B7KKaviu+bObNGBO9/6m8MHQ97KlHpCSOu1LBl5PhTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=pFEc1EsY;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=x64dlM9C;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AB1606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 22:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0AB1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=pFEc1EsY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=x64dlM9C
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1515D7A01AC
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 18:05:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 27 Oct 2026 18:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793138712;
	 x=1793225112; bh=dBtuDw7XAwc1e7TRBObpy6fBLskoxZZKa1Z3umMOK4o=; b=
	pFEc1EsYyDs71jIi4c4bNvuT/ROMBl2aEqCibZ947gWRGxLL4SG1uGXJaxkesEru
	zd1mXdBcqZV9lmEaFaZFFNAJvelgzO22pK1Jgm+aTMyiM1lUL0kbiE73pGZDDnKa
	t/1lgP761Wh5P7e0mGRwUhuO2HDgXMkH7ISKoI0JDDPg/NkyOEQ/UvDu1XX2zHkH
	aADzTnR+JDP2QhXUH5wlWB/yTCvbMjmY5Ga2uWXK9m0syNHhjubxnMgru+k/IMT/
	ZGIk13k69sB+4Qxg+cpa7cqIpdtKGIqiqV+VK5oA12DbcGhyUophfeJrN+6/S+DK
	Uwwn2btarE+irt7XoJpYCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793138712; x=
	1793225112; bh=dBtuDw7XAwc1e7TRBObpy6fBLskoxZZKa1Z3umMOK4o=; b=x
	64dlM9C96Mr49HRhg9bkKF7ixDosNABwHZu1FBm4azaQK0f8eBx1VWTbfGNanC2x
	4VU9UaMZsKAZZuRVB7bm3JI+x0v4Eox74V1sOz6J8hvypH2GEBXO5lWAROWoUult
	1mbfTftlhSNMLd+udVFNPrh3y1GfQJG/rlwI939dnxtEwVpFBo+6QSL1OCihha0g
	R2irHBTRZNwvKKzKGMW3PHWx32hi6CqP81c/FLgPfD4FE8RRVbQNsP9go0UftR4u
	1SU3QNxuqmldZJNdNegOAp0NOI4wGnHpzMbIKgCUzqorz9hdY8hdwiIkV/23Zzj+
	1NXFSejh6Muy6HnzIdxCQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793138712; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:GACX33Ft8LqT4VIthlOCLUxXr5M5oG8GFaDO01MLZknxKxT
	wIrv4rxDPf+ae574UtQBTqzNfEvIjYtHI6giv0wz056YOro03Oas0Ku/gVRQvgfy
	hIydYV8VTfEt2e6P7s7e2YgC0cTNFFYzuZ9vdeZ3rZa1So4Z5vWelomseXcrM3Nk
	2cCvVv6qPwtDp48IE6P8Eox4OdZyRSYmzeN2EsOclYp6kB8/jMV0InLoo40rB5oS
	bz2wipTs/CZavVwmnhKVLVUbMN9yqp71LVH86wA893p+zErqb2Vw5hA30m3UCwtq
	anGvx5rICxy3I1LYuVV7Y1XpJkYr5XcgAccl7AQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:j2K56wwkp7Tn2ql7yCVRvKlG48+iNe+52e25sIigpQw=:dBtuDw7XAwc1e7TRBObpy6fBLskoxZZKa1Z3umMOK4o=;
X-ME-Sender: <xms:GCDhavdOf5fdMzrByULcnJQYIA1a2zHbJAjt_CYKYSJ8M960Gx2_Ug>
    <xme:GCDhao7KS9c_kD7pyN4qWB-C_aBTDiOu5X4-zmstkNzemLBnESo-7WHHi_pnPRC0r
    Iqt1K-iZSEryUkq_ACbAit6t5USGwOlmmfLj-0qbgyKFfubVQZy9ys>
X-ME-Received: <xmr:GCDhaiUt7Oql8dR88e_8huTxO6SV4swBpStUScZMsaTiCM9U1ahrjKwMoucOCm-2j4ge8KCkcR94wzPX2uvRI_aqxsIVcrEzGxcU>
X-ME-Proxy-Cause: dmFkZTGtfSC02iaIArc893JDEvqTeiGwy+4adK7ebUNuRRD656dBGF0JDdnZeGf1H3O06g
    gCFTST99RU+TCxT6Hc2ku5F4RWEO144RK8e91z171aINE/iLtZucE40LMdvyobv9yZXrd4
    MXSncPiUzl3PXNktc0RztXwY6La64OkLXaL2Oj73D+xeGMqsklPJ5CM8cifoPW6EfsTTaW
    YpF2NION/UTJ0An4eSaBg6ma1hV6FnAp7nrNlP+FOTCdiswoV1zAzJ/hd8wkvQPE0kCWO1
    mgO3K77Zd4toKsfFYiY9Nf8bieypb+sdmoQIcDVuzL5s/P1pUDxRSrqaXvtKLU/+uZG8Mb
    NWQ3AmVVYD/2S56Xl0JljFRqyEELq/ipVZq/IdryooAuNuQ9+MFcvvl5rrBoRJ4Do7l92W
    oZjajm5it4PsemN2O0mjsrq7mmxzqtv5p07ZS/Yai2GI1cnXQoBESJHSTLEpUEhEd18hFd
    z+WD18RM9zSRbtbiJ38Wx+olZiUFX8pOM4RiW+It9qVZZbrwaLur0Sg8OLjRiQPRNrvEuF
    oVQuh5VCxpMbwgOoJn7nk4yrFej/xgBMgf5IBWp8UC+I9ElJfi0ZGd5m12XZNpx8bMD1w8
    SksTtL2qvJ911Qf5RPJeprRqjEXzNG7IP6I/0hbQU+vnva30k2S6yBzLzKHw
X-ME-Proxy: <xmx:GCDhan7mJ8--V2CwDSCyq5SK62x8wkxtqMOEnR8QTknIe24_rJB0KQ>
    <xmx:GCDhatomsDOdw_sXR4E3GQw-PaId9hojgmBfFvaOzwCbz7zBbelVNQ>
    <xmx:GCDhaqmFELEO9UWDU5biPazDKmpIueA3_CUEPZuq8iz6SDZtTRYV7A>
    <xmx:GCDhapM18w_7mwebpogXtAQmzreYh4UQ41f9m5rQ9SYDNDc4M5xv8Q>
    <xmx:GCDhasQGedJXtKf4-iY1Je480-PLeT7EKvWQPZcN7FlcJYz4UV71Ifcw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 18:05:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <ttaylorr@openai.com>,  Pia Park <pia@pierre.co>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH v2] midx-write: skip writes with no object entries
In-Reply-To: <CAOWp8q5UqPrJQosjypdcq=KX1TKcVenAOoZUYfTBDKbRUwazTw@mail.gmail.com>
	(Pia Park's message of "Tue, 15 Sep 2026 15:25:06 +0100")
References: <ap-KYtsDXXwbBzDM@com-79390>
	<eef33827000cf106544174ed000129c2989af1cd.1788851232.git.pia@pierre.co>
	<aqAkfGZtLJ97nG1m@com-79390>
	<CAOWp8q6uCcVL-0cLxvf-ncydSiapheYTDnFhom3CnKiMWyfJ=w@mail.gmail.com>
	<CAOWp8q5UqPrJQosjypdcq=KX1TKcVenAOoZUYfTBDKbRUwazTw@mail.gmail.com>
Date: Tue, 27 Oct 2026 15:05:10 -0700
Message-ID: <xmqqld7ihka1.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Pia Park <pia@pierre.co> writes:

> Hi! Just following up on Stolee’s suggestion to return silent success
> in the no-pack case. I’m happy to prepare v3 if there’s agreement on
> that approach.
>
> I’ll also be at Git Merge in Lisbon this week and would be happy to
> chat in person if there’s a chance :)
> ...
>> On Tue, Sep 8, 2026 at 4:06 PM Taylor Blau <ttaylorr@openai.com> wrote:
>>>
>>> But I want to make sure that others are on the same page. I would be
>>> curious to hear Stolee's (CC'd) opinion on whether returning silent
>>> success in both cases makes sense.

Has anything happened to the topic since then?

