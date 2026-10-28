Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793187751;
	b=n5umB8OvG7vG6zm2CEYwCYIUlacBweoMvsyarSB5M3ofrybZFGm5fhjweMowHqX5rwn+
	 zDr0Qfiy2l9ZN6pcbrDvx0L0oHvElrNHgk/0S4HFv2US+fOCr3k3EJO1ldVf5JCilKERM
	 /3ShQaPjbBfG5a5GMPiR87AZKASze/3rYQEGJAyo/SI0AGLUa1d2aiq9/fEATOVV4kZAS
	 LQ480jtcw/ctKfEpjKGji7y4NcagXk1Ia4ql69QUPOeje+Xf3XZoPrI6XDqEsR0t04dhE
	 VkU/1A9lx1rLvXyaM47T/CVuZxsgjEStiFUtCH73jq3Zz/ImdVnPNW34/J8GfiNG0FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793187751;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7zdwUgXas7iKWi1yzEmNufILzeSkai2oGfAaOMuMleI=;
	b=5XiAd8IusrOtNYj7nivW/Pqc4dM9Z3lD3xGLsYHkVmwjMNEiJRLvc/Q1ecNGZUi9R9t2
	 5XDYo9t+aAfFEK+guOq5vlZmTWh5pQzL5oraETuYHsSTNxPTwEVZbK6al+uxVmlLtOZMy
	 9HwuIzSalVRQ47DhxUZcU+9bn74OKJs1NKDUm27zoWLvtvhPPRYdvp8pF7gRyR1mGGu8c
	 K1HhKt3tnN3lGA/fgyYbldPbgB8R+SlSMOaLfogANfRAddxiKUL7hApN862DKVZwN0+af
	 yfTEboiT0bd14Q0D1y+Zu/vp5RPA+xfpBH18i6LMvEWjUlc6AVoNggKiyOVbY6EgnQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Q4JCBCOk;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=eaVZBY3z;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B11606A31C
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 11:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3B11606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Q4JCBCOk;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=eaVZBY3z
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 12F121D00198
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 07:42:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 28 Oct 2026 07:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793187749; x=1793274149; bh=7zdwUgXas7
	iKWi1yzEmNufILzeSkai2oGfAaOMuMleI=; b=Q4JCBCOkfTyIOYcs0CzJfflKMx
	fgCr80diLFmnwFi3WGx8SPlE627mCOaI6Te0rp+aH8FAyyLUnnGqb4HjrYKBUN5y
	0X8HLEwey0klgkLCvUZj8gTBO0Ex3h36x9/pRnMGhl+smdf14Uj8jMyIN/34qM0v
	20qtbyKvZdrQ+uHmyr+pJ0tVw01EDRIKM4DgMic5rFHFTjFlv3U7K0sT30PfezAR
	X4Pz8JXFJYq/MKRmNLz7k8Kl/InPvV+zM0NOrvNUJk1Q3tOFXfFgLRXD/Lgqmj63
	YAk5C5QlZmlReUcOf9SQvX4OIJLLh+BJV5EI+D5dIBJHvIdFS1CfYHvpb7tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793187749; x=1793274149; bh=7zdwUgXas7iKWi1yzEmNufILzeSkai2oGfA
	aOMuMleI=; b=eaVZBY3ztbKJjIfWazd+mZKc38lqnvtfnce8dJzhFHtZU1CuUYx
	UgHcC8BISSpJ4b5MVw00XWxlXXfL7Vwc9BPd+QexYG+28l1++i9KpqyXQbrLGxPg
	mCQ5q+NA/EwbiUjE2WIptqeO270Nhj1lD1x/akwuLFWyV08/4P7uj4Cw5P9KzcL/
	VJqVrFvkdCEpHLOH4LttKlvbe8th9JpzVuxcczSBsy/soEgdwU2mnrZ33dtiHQYQ
	z0cg3s5cxGl9VlUR3ELGdkdVEvBa6kh1m1yAj7IO5unltfEfmzClCGaEsEMWEqeX
	toTw2Ien0gUk1hiwcOmyt0+lrcY7j5wJl4w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793187749; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:k22kKWbdUXRwR/PinAw1Pihfvmc0S0Vt70uOzn2FoGw6YQt
	n5gmepymIL5E4mgJvxAYQOdNJ4pJhafcZZyArd/p2HUjppDJ+Q0o5gUEIZRhWYuU
	qfqC8iB9MegCF5H1IyQEopI/5g0fCLx1rLHPViR1+iSsrXAib8uUeBjL7EMrZLuj
	O6ij5ezEcRXkjXvhmJp1BrNwO2l/X9LxzcuJy8BPQzIh3602O+2vMLeWJXyK4xsE
	pw9dOWKpVwFLxHiL8NZRNkK3b4f68f9LQ9FMvNwoOLBFdRrnCIIqsdOXefY7L/jC
	ikZYwMydoypGj6IepTViTmnMQYm8zRUOahXhdSg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:17FPphX7IbiSTH3SkBvl2r5n0faSHufBv2CCBHUUFFg=:AydvoZ6twPiqvOdq7Ih8RoJxhAzikq5Ga92PWRiSBUU=;
X-ME-Sender: <xms:pd_has5nBfWLia5dpZ7aQ5sckEj2HrNm0IJjMZmbCnAZogwfWjxbKQ>
    <xme:pd_hakwtpZ-PoiLWIhp3TTRH0NAFabkJM3Su_TwfgAI-Wn_Baihm6BqA3i5B525fz
    kiOMVbm2c6DlfzQRacW1mCYm5Ow2TxG6RvWyOFYyljiKfqjgZKTsw>
X-ME-Received: <xmr:pd_hajwkKa1faNianPync4L7V73VkCzfU9znDrNscIL6cPS6ePP9hg>
X-ME-Proxy-Cause: dmFkZTEXPtKClHnVXDOz5er/n2663sIl3+MfysieDCduyshG/9+wuS45wexyzDqfkPcds2
    tUWb51VaCo4+QLML+czmo1Ha3hOt8xVrqBjNPg/0KP15c5I6+MTEBrm2uGP3IcNgLTgeGL
    LNti8QCK/HxaXJIivoV2tnNqGo2zOPWMhWjcn75R+f0llfQ7zootALCVRuxdi+py+8BidW
    ex8wEHyrlOOc1RgGBvgHXJwPmwHk6ZXfDNQpjcVoRE3U3HHWUA2NNx2Ucs3PvRq4+FIGcf
    5TUADDQeuvYzUzPH5Lz6M77XPnES/lR8PUn3ybka5etNiA/xrOu7vQ/92oNO+dLfD0sBiF
    QhDbNtOtkvgUph/GRX9IxxkhCpH5na9qVAicsEs1NLUzT91EkcRUMh4mrPwxgRGp/zL4Cj
    5hY7Fehu5p99OmvFCB6WQbUgledl/jDRFqfsR0EBivfYD0shjiO8s0EyH0WhiU8RIX64bK
    I+O+hdd3SWxJOjqO1rY5KPFZS4VppAVn1mkiAnaJZ7pCS5+YPCO+8KItN4BjjlM5vCpzDb
    v7oiSEoETC7MlS63sZ9k4fyH/loUKanB0EU84ldosCrEj5CwTVV+WhvPRNkndtIIakgJtm
    aFnzfPB2A3dQ8HtPADO7gYa4tod3h/1apO8mKhcseGbmZXv8tel3E+Iagqtg
X-ME-Proxy: <xmx:pd_hasx_A6Z8Cgwm9sMaE4XHy2-8FFHBtec2nMxKnZbON7p9HrlNew>
    <xmx:pd_hatZudMECJBwu8a9jU1l0rvP8LuuwSRfgcUnAtV3INgz-c5ZP8g>
    <xmx:pd_hatXOa7_7KvR-YKzPEvMQrrVKjzTkkaZJmT-wL4pRmYDhSe6ZcA>
    <xmx:pd_hari2TxVzi6BxpPFYZTkMQtOF2DSReu5HMgFJzbmG4SKPuvdaAg>
    <xmx:pd_hapQtTZjDwpH5u8jiEkVPjhyJOjjKiqC3HF5NfJnvGGYWQrRbKNkl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 07:42:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a22e0d81 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Oct 2026 11:42:27 +0000 (UTC)
Date: Wed, 28 Oct 2026 12:42:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Mitja =?utf-8?B?QmV6ZW7FoWVr?= <mitja.bezensek@login5.org>,
	gitster@pobox.com
Subject: Re: [PATCH v5 3/3] t5510: cover upstream info update on fetch failure
Message-ID: <auHfoVfHQJ-dRwkM@pks.im>
References: <20261028-799-shallow-fetch-with-tags-v5-0-7c43cc9ae810@gmail.com>
 <20261028-799-shallow-fetch-with-tags-v5-3-7c43cc9ae810@gmail.com>
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
In-Reply-To: <20261028-799-shallow-fetch-with-tags-v5-3-7c43cc9ae810@gmail.com>

On Wed, Oct 28, 2026 at 10:48:01AM +0100, Karthik Nayak wrote:
> git-fetch(1) performs reference updates in a single batched transaction,
> so individual updates can be rejected while the rest succeed. Even in
> that partial-failure case the command still performs the remainder of
> its work, such as writing the upstream tracking configuration and
> backfilling tags.
> 
> We have no test asserting that the upstream tracking information is
> written when one of the reference updates is rejected. Add one.

Very pedantic nit: I would have ordered this commit before the preceding
one to demonstrate that this already worked beforehand.

Patrick
