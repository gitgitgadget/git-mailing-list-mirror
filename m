Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701407;
	b=Wad7ooOsdLVNO54MSPxFAb+utisH7RIrzEq/MKVCbcRVU+9HXVdaEVQNuK77mPCUwY3i
	 S9W6PUbctBGKAfl6qgfD3SoFmjE3kDvhpC/ObV/pt4dPaDptfIaQVY8wgVzoQyYQZ4PRz
	 aC7hiciZd3na+EXek4+wA5ml4E1CNxoM4EDzc3nCDYTTSYWmA0LiYZ40/69mCzqYQMZeq
	 AHGspRelbSlX9O7m7VwnAAotjqoSFnLQTwgvBIXLMnttFP+mvQh6ItW5LaS9QojiKuJmo
	 xabJkkPm+rlk+Z2pzeoM8b1MIouw9fY8HDF8iqPW2J/gq72eRO066KoblsaU8lTXb4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701407;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Wx9DrBoeZqjP2V/cZh2sc6hziscTqjVVF2zy3X17x+g=;
	b=TclcwnDD6/W0HMDOv0xawkheq5FXNiAWwW1EUeo81WEe/mAgUxu1ZcccBhUEIPR8yoYy
	 jr3CGnp1OEkDab+hn38aRtymffgamdi1Gw07sttnA1E75DpqTimC3+GYpgRieZUyJmiK8
	 5RlBtOdYWavb3ImavRjc5htHgxCfOT44oUBAPzk7elnNJDXmZUuNw7qcjSF6X32oMYiYq
	 EC0IGcw/yd1SyE1xIpSWUxRDosqJx6MuIjsljluyzvR/F8mymsXOybTdtwA4UfVP7gti+
	 NSbvR2a4+muVIV6hiw/61O6bpLhoLCzQpuScWlfkrmmBrdgeN4SkqtiJfPXNIOzVbyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=zTQHqDE1;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2ri7+L5s;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDC06082BF4
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 10:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CDC06082BF4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=zTQHqDE1;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2ri7+L5s
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 512811D00095
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 05:23:26 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 03 Nov 2026 05:23:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793701406; x=1793787806; bh=Wx9DrBoeZq
	jP2V/cZh2sc6hziscTqjVVF2zy3X17x+g=; b=zTQHqDE1DxemPRrrfXIr+dXRjy
	UXSFP8DKRfEwMxZAKxvw8F/uGF4jwDbhEfV0LVT9BKqJ21Mp/ASCCYdIgR8B5rgL
	8wsEGRlCDpHb6y5pAy5h3rqBw60ndKjVaKWo1FI2iZnxPJ/fTQ6mqNu9q0xpKk/R
	8RwxpGk2XAV+zUJjG0Mq+sHJsV5Gjj5u/DtDCklwkB4m+1WXLIOfZujVp61SvCq2
	ERkieXWOh3F3K2+D6bZB4+LvykTGy0Ybtc9j8FacsW8G32eLo+6VfrooZl2kn1Y5
	AgsOu+GnTvupIhuYYxEVK1i6xKj7fAOmlgfzEyCIke4gxcth4Ca+2iQF+v9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793701406; x=1793787806; bh=Wx9DrBoeZqjP2V/cZh2sc6hziscTqjVVF2z
	y3X17x+g=; b=2ri7+L5stxowA0xemDJi/2IWJZCsYRB+a9vDoNo/5K0cJSIbZtk
	2rgzoPMuEJKFFSDwGZ5njqz9pqwRP/F9+c1MfFae9pEaE97H++RNTqGkRFJSsyGo
	P8MWByrwg2zceQcYG97zopfaTuwGH2T2JthVuSRQdcyaslGER9xKeiXxS0fyfZW5
	3/J6aFYKCQzhyDdnZk2Ytu6FaYF2/0LxylGcf3hYfMcLSzx1Kb9XxI9RbG1iPaSs
	Cg6GAGcUBKMvdo9AmCuC8f8YdCdV2jd0D/HBLPLrS0xZPFahxkU0z58fMkF6xgEM
	CTiQg633kOhSfhD0/X/dPzzVEOcye0FQY0Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793701406; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:LoLfjZ6t2zspAM4VX6KqLNRffqQZ+hiJAjoE+Q57LolNEWR
	2LMxCEXaw4bu4DM4rERnT2RlnK7yhp2AeC+CyG/PNKQyMDQH7cKgqKUI77kos+Zp
	r7ZzyCCTlLlL67l7lskF9SAlMC4BAuoYQGh9kQcEjtEjY8KbqqITyuE3En355IId
	oa2F3mzQ2s8M2vPkwJjhh0KnZgbORn3Ni9DvQeoH1meHpQRh2ptx6wOX6LFpBcic
	ve9K0wpRbRICYTmRI6Mj5jfZueQRzF517Xthib79p90+tkG6BpMJc82fhfJ3PbLr
	lZgT10U7XqvCd1gTsdJnPe93GH3gBYXSHuH+MJA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:MWAVN3nYKf6ukM68lcRG6Irth+UtdR+TlJzlASU8XpA=:Wx9DrBoeZqjP2V/cZh2sc6hziscTqjVVF2zy3X17x+g=;
X-ME-Sender: <xms:HrbpaqOsFK3azGd26xCHXcMI072qyEqvOONVQapqNMgqPvs-649fFw>
    <xme:Hrbpau-Sv53wv11YP5D65_bUBpUj-dDarX_8NjO8dh1S1CFue-6tQ4kho_VbPfwx7
    nEuSwtPlBdjmhmGXPGhzo8evlII5Tc3IvfYBrkcahpycS5_riWJTQ>
X-ME-Received: <xmr:Hrbpau4_MTNpkS4TQea3pE-igUATKt5bXq4rYiZfRGaN3dFbX-JfMg>
X-ME-Proxy-Cause: dmFkZTE1csS0CwOoMhx1ilyilM7YNEH6ipKKTLh0mtNFn7kShpw9nvZODCVrfboSW/K2BT
    bbu04J0b/FfiV2qL7qpj7NY/E+fOO4gjGS/UxyWVfcIg9vNwY+SFuM+A3IFwTFOWzW18nZ
    U/kT72xe+dH8b+r0fxR6fnspVYj7BI9QTZ3auo02OC/W9MpB6EKeiLRoW7hISLyah4WVRa
    mVNbr4oHFM3OuXa8sfkmJdlPcHuEpdEgEyT4Dr46bkRn3xn2ynI/4N+oTOO0DJOIQVDSOc
    UDBcbBIAywoIh3Ofm0UNdFyZtJ0GU/qOAXN8iAoR88FXNJS/9XYkd2NmGBeWM/+Ym/p7Ws
    0K0hT3Zn5sgFuVXqKG8Sf4k0q1SUhkSHGi1JQ/5gIYxg+7uO9htyf+qVlGLd15yJNk2Xbj
    Aidy9U9Vl+7erZWWIojYzBa97choXXebkRvATvxd5kWb8nuY3/l12DXDScpAG7uOhSIJjT
    RAYd80jZlyj3PaJCNSxrlkvKqBnd1tXlx7I2ETLP2pXqQIW/47QzehhLP+zYMNdtpg2z6v
    bGblhqhAcZLluSZap1FNrlgU15TUQ2TLV9YK8c4eT4E+VoIHtOcCwggA6HIavDCXG/as4x
    zvmq52QwT4ibZwMXzgS5NM2ndNMS6h9Z1/k/JNz00GIbOGxlXFwNd1DOMXmw
X-ME-Proxy: <xmx:Hrbpal1VqoaJ2AKgrehE9Xrqf54GXMqvYX_zg9RQNvIlHvHY1MKGnQ>
    <xmx:HrbpalBkuqAJeF5rGt6EMznuurzAZs1e6IPWkL69IgMfQmq4-AdYeQ>
    <xmx:Hrbpan2B1FwdvWzSQ_pLrh_lLfdpiAdfBRokdvMlevIGloWkd71WhQ>
    <xmx:HrbpavsiohPDrI8vzWO3ARl4BBRZWUbnDP8o8M8Y8AdeIH0oGPdlQw>
    <xmx:HrbpalnII-yo14IJM8_FjznPBI3MH9pgzV-RR4MSz5i9S4fxxSQFdjaR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 05:23:25 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d71ccd64 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Nov 2026 10:23:24 +0000 (UTC)
Date: Tue, 3 Nov 2026 11:23:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] ident: remove unused
 author_ident_sufficiently_given()
Message-ID: <aum2GVDloMarZvwi@pks.im>
References: <20261030173956.585250-1-gitster@pobox.com>
 <20261030173956.585250-2-gitster@pobox.com>
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
In-Reply-To: <20261030173956.585250-2-gitster@pobox.com>

On Fri, Oct 30, 2026 at 10:39:53AM -0700, Junio C Hamano wrote:
> A pair of functions {author,committer}_ident_sufficiently_given()
> were created to replace user_ident_explicitly_given() in d6991ceedc

Nit, not worth a reroll, but isn't it "was created" as it is a singular
pair? Might just be me not being a native speaker though.

Patrick
