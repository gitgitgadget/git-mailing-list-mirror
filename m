Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793617307;
	b=LeAbzUMS5yIIKR2beRtXhbcy8BP847ssiW+4jr0AY8AVFBWcYh02jIotGa7FrrK+fXMm
	 7kGxC7WgitFGTBu8dvC0xKhFUECduQhaoh3hintuQEmW9u14sWaKDfUbolP2VLhGUvTfq
	 3vLDHJ8v0UpbgEQFrOMrGKui4VgLPKzkbYhdENM7nhHRkcKb/gh9m0GZYYoKfzE+Br1ic
	 CymOtXAsG/x4pRbTYAx5WFQhUsRyAIdGUR/7mWvGAv1vqEV9aPg0ghH6b6MJncsivzX6x
	 6mPIDmrnFYVUIeVRUDHh3g8aOJh/DoQiPJDTj8umhrk9IVrc3vLek0YtPqpgw3HqLzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617307;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=b4lO4cxE4mN1WkKM3tgs819AU95l/hVllsIny4lzXyQ=;
	b=iILD8YIRfPpTlWdnvxLeg/WyfeJ0tO6tHg2FRr6k7LrFZVIgDvPny/PovBlb/2sZJw2w
	 yFoqQw8hnsoHJA8JK+3U21aNZixFrmOE9pMRyXach6/szGFnmyQdwuOz/EBQLOWSOc9o4
	 rnB1Bl4m4eNX6suDztuBZH96Ww7QVhhxgAaNVJ+TMrWYQCHmzAOqLdWXdw5c6sF/qxmwE
	 KrIQpWxqzhyPMde2qRiag7f3Da9WFM75nMgcIIXYBSa1u/fg2TAUwcaBl3QvEBmVTK3Qz
	 uUXuHXx3epqtNDVYl/AN5UMRVUO9l6PosuZu4mT/22ldbyQB68oeIujbCpzTU/1DF5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=H+YuO7yh;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=TdAE+nMT;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FB0606A324
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 11:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08FB0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=H+YuO7yh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=TdAE+nMT
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 664381D0020E
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 06:01:46 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 02 Nov 2026 06:01:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793617305; x=1793703705; bh=b4lO4cxE4m
	N1WkKM3tgs819AU95l/hVllsIny4lzXyQ=; b=H+YuO7yh6x2dmGE7q+ggwNGrkA
	BJoXl/pHt6pT/NnHjkfFrY1az94rAD4R0GGEAjZhQxnhWpCjz7YCZw2LxIyqM2Qq
	FLuOY3jLmjzqDyY0rNNeRLp8r7vuOiA6pcf3U/KFcSSwOWi3DPqzFwlH1Nxjb9H4
	/YnOkpEjmXLmAzS/jF0BYZns/K4eZ0WLC37Q7emdCiEXACfEn1tZbmbdGvkAbO97
	aRADPfU2S8keMtPLp6hT4e34YM/gqPJ1GEUtY2iG5Fvo1Djfnp6dApQL9xfM4SYJ
	KcNYLI1LxUt4dhkBXasYqvloKPKm7rl3dS00z7/w6RzBbwvhtu3LwDKMParw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793617305; x=1793703705; bh=b4lO4cxE4mN1WkKM3tgs819AU95l/hVllsI
	ny4lzXyQ=; b=TdAE+nMT+wea4WXARbxihq5K+8E+o2ZKsbXQMiXiPezS89o30ja
	iz4QerY99wlWiqn6F3Ed6wQlcWAeDqPeNrjUnBbaimjI4rYPB0+JPjHHx4BcX61V
	eib8RU4tyna8Ep6WfsfQ2M86jj57fcjzarRKvE9VC7ZgHsn+uTZ5vJv6UT6An2/f
	ygTieGOb3AMhJacrQgH6+050baESKpPNGpLpR0+jQErY+PoqUHAkofl7gX6Jmpsc
	nMtKxWS6l12F7P2SNSfCZB3ov5FjBr3sHeyxa0D2rSLpqEFfgwkI/0Wl2wYOaGv6
	Adwvsu53TxMjR8foyT/+wC8ISTgUTknH5jQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793617305; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:u7Z9CDBB0l9PJ/xuyr1BQn9DOIV0d85QmyVWCblMXGEFISk
	hAHpTKN9PC/OGosaBcLELY7Cco2xReLj2NGK5qkY9wnuks5mgw0fC2vxrE/M/Yln
	PAZPJ8RLVj+ziWC3Z3oW3BH/SCpu9rqx1Nq6Re+MyDGR87yQtL4Ut+oWUe7hqFLk
	pdfMOm8PWaBwL8xv3oNIYGsbxaDHFCnpwxhuQus8EkPR+aZVqgWYlEBQGZRsiX3U
	XE+eno4klLYXAGMkEbgcmoCMuuqVGzvC8lh7R0boZY7toS80oEAEOMPB06dtzdVc
	f7OVg5HbDRVxO83Zm/VCwoeyBeDO1AhufY8qd2w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ppRJeZVPFb1920LdrID55o4h/YMhz2uiO4So1C1furU=:7ptAh/v90jZ6Kgt/6xR4Is4Qg3aiqBHpJAcTvs0jd1Y=;
X-ME-Sender: <xms:mW3oamFWDr9pekD2ilET2EVMWTQkPlNXoGokLDDVruyVM8Do9c6E_w>
    <xme:mW3oarAuk_HmSUbuGiosQK3m3vgXcUsMopF2bsEoroaJG2DpdP0zZi4bg8rMFV2xx
    0TqlDtUKbdkDhtXCcDEo7oN9xPyMV95U0ZiverIf3jDu9LzrQnoZkE>
X-ME-Received: <xmr:mW3oap9boApNCuZzzb8Mt2neUjWNoAiqMwzWXcsTZiPBDgqXXkTwAftHcaQvOJGXwJ7aoQ>
X-ME-Proxy-Cause: dmFkZTFkpFY9vpvJG5cwdH0kUnpsAnuvebzx9vSH/s0M5wCwHg0pGKohkqb5eJd0Fj+yQL
    BLrFc4spWKsYpd8lRuW70Fdc5mRKYQzIMuqMw9TCuerd5n4WZosbdSEDk6bEzeTNh9i8FX
    04ZGOKPOSrYnmqnL4bd7DLgKqjyQh2Y2SI4ItvHRc30cP8jjMjYlBbHXOCBUQ7QbQkvGA8
    KL71AMvIP4P/p/rHuOlBb32fpbrwXBxaexfjdYdu51wukjNpG3y3SIYD3nrf2ohrjOvkXa
    MGEuydZtznBWusXskvk69Va6USpaCVBBVo5u7sR8F4ibzcmEawaoQBpjBMenGkiJJ+1NAW
    cLBDSuPuq7/MquQladi2x2qbyELfyW09d+VgbzlhxGoqPRmSprAbyo5HVIDSMoHZP/NCiK
    gaUk2aZBoh+imxwX6a9/lQeeud5Iql2ARxYhmaVZdflvm5yf/GUrGzn3JsHlYs6ruN0IHi
    rPyn5zlqjsHTnncctH9o6EoRFMtdBOiLKmqxWEQtIROhld0o909Z8kIin5wi0EcbdV+D48
    hFea5nEbo1te0Ms3E80/bbjiFLIC4iSuN2/iY8RXOqwbOt0+V4daKiXmbiMXIZqBidJlgg
    mDLsgXVngLk9WQwnWA/CMKaqheVLUth5BYE3mON/G3ur2ioAIv/gDVOx0GqQ
X-ME-Proxy: <xmx:mW3oanBMGdWx5tykL9-uWbtttlIsFQlrMN07wnHq6YErvhyj5q0vww>
    <xmx:mW3oauT6J3TXO7snsVCmv4JPT2vfeGD54qse0FDeUruICeQhMOK7LQ>
    <xmx:mW3oauvJzvGaOpvEYvsoBgpl4uMMY8KS9Dph7LX-nPptd5hCgF1LsQ>
    <xmx:mW3oaq2RIbueR3OPic5WEQ2Sd5qDUZHlF8Zl1YKVZo4ESIHq522XDQ>
    <xmx:mW3oajRBrHm0Zw8rRSMVSMZC5XknxtY3mWkY2FuNSGJ0y3GyMyf79KDY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 06:01:44 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id da2f70fd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Nov 2026 11:01:42 +0000 (UTC)
Date: Mon, 2 Nov 2026 12:01:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com
Subject: Re: [Outreachy PATCH] notes-utils: use the passed repository for
 notes refs
Message-ID: <auhtiZ86trLamccS@pks.im>
References: <20261031104526.46711-1-okhuomonajayi54@gmail.com>
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
In-Reply-To: <20261031104526.46711-1-okhuomonajayi54@gmail.com>

On Sat, Oct 31, 2026 at 11:45:26AM +0100, Okhuomon Ajayi wrote:
> create_notes_commit() and commit_notes() receive a repository,
> but read and update the notes ref in the_repository.
> 
> Use the repository they are given.
> 
> Keep USE_THE_REPOSITORY_VARIABLE because
> init_copy_notes_for_rewrite() still uses the_repository.

I don't quite understand patches like this. They are _so_ close to
getting rid of `USE_THE_REPOSITORY_VARIABLE`, but then they just skip on
the final change that would make them work. I've already asked about
this on one of your preceding patches.

Also, could you maybe reduce the frequency a bit with which you send new
topics? There's a ton of in-flight patch series by you in this vicinity,
and it gets a bit overwhelming. May I ask you to maybe batch related
patches into bigger series (maybe 5-10 commits) so that the reviewer can
focus on way fewer patch series overall, and then have less series in
flight at the same point in time?

Thanks!

Patrick
