Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081940;
	b=cBBbryRaErene7+DCVccR96B1wsOWAtdYyd2TRkHTY9zmDtMx5yoWEJHXQZsz/cT9fMB
	 VMpGrAXZA+iERrt1FEkHYlNxz09qPaSHapAWwcAhrEs0rPAOjOTowMMnpP3JUbSUGfAWy
	 XzhtmvMmnEtqWfNQ85ZIbS874M7i1rt/S6pzrjPZ60ok/0cBN1pgO9Nq6O1OfjjNBI88p
	 V/r+fbcAHAuLlRCntee9x8nh0in3modUHm1CZQrvKrItai7bwOZ35f8WmhQMirTG9ZxBZ
	 F0XKFBx0pQNkCUZvaX+4uJVnx15oVwtCSFF11nO2DqGdmh6JfN06gHBN34fD9EFzWYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081940;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qjYPEPs9THPYJK0LUFIj/ayGFVbMT3gVYMWkKxCMb+8=;
	b=iV/kyvLfPaW674/c8Cr345KAAEdP+QlJGdVDmJ5HTLuY6Iq2GWPXbkkVa7XEltUcNAAM
	 w4Cao6fAb15dHwNUecQ2JcYS61kw3TJmVyQmW7PqbtHyApyFEDJL8DAff7moL9yYUsSPH
	 pE52+wlOs2II6rvi05qZBQnKqdfYY4I7QFPGMuiZGzfA4A/XA8zla2MOXXfshEnqj16Ia
	 h6Z8BnppbJqijJPWelBX74TAlcAjeJNE2oh9CFvjL8cWu9A/i+oI4RlQNVOC4/gNFSVvZ
	 1LosdzPCZF+kLmRN6DirFjnfbGDt9JBsqp58GhO+8/oJ5X2820izBGIp9LvZ2rzmI4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=m8RX6kHl;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hD0sgHz1;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABB3606A330
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 09:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8ABB3606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=m8RX6kHl;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hD0sgHz1
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4D1C11400080
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 04:52:18 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 19 Nov 2026 04:52:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795081938; x=1795168338; bh=qjYPEPs9TH
	PYJK0LUFIj/ayGFVbMT3gVYMWkKxCMb+8=; b=m8RX6kHl8QEPqNgImxsHFMU1qK
	jUld13/m1kNqbBAbXv0IxrlmMNCcUVa5bOmopFy3+q/Cmkg3ihxvtrBSPcOqJqoj
	3regVxLxytX0lM2jiDnkiRNus5WVhIa8Vv8Ng9WJpcrtp2ojXovQh+mh3sGQAeB9
	g0kv19jjqhbkp8rK9k9S5L8+uuddicmR6m3N/3kGTbR9tdmoniCnlgIu8n4lWSNh
	qVISjK1l//mLJXVJaGn+myRs5O4Jv24pJEQpiIswrbR0dAg4aLnhfkwG98X6PqQW
	LZaO5EZhaGsPtVOe7PM3ueHMasPxeU+rOY8ffAN5nTg9LesUsDbmnFCXmUcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795081938; x=1795168338; bh=qjYPEPs9THPYJK0LUFIj/ayGFVbMT3gVYMW
	kKxCMb+8=; b=hD0sgHz123RwkNrK9iA/k94HWFAe+r1Ee380yPhyQ11KbK/6xod
	OKwYWYHJWtT8ZCHhzJ+ORGLbKX+WjPFx7Vp5LnBAFcuyK2k5672iXk44Plp/UFSc
	ZvMft/VssIjVQJrCLspZN7CkHLMHH9GwHBUqS5S4gOY7P50qKne5eiPxemApEN39
	dfvVhvGYy0vc3uqpMc8vWN4ref5hsWgDfz749egfDRc2VoexPF05Gxny35ouvb/g
	iAInwP135eiGv3lwSZ7dtAWIhNgpsp8wW7JNq3/ADjZcz3mwxVxXK0thM+gVbyBh
	88kF3x1WXpVUYYT7tL1fMAY7pSLX+izhUeg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795081938; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:I0nSn2kAvORgh2Sy6pfO7jSChIcLR66ZualjQ6Nkz8t7Bg8
	gl9mbq/I38SxwMT7zbCTy2KVrVBbpHip90wf5mZvtbYpaiXi+Gl03wchh4gHbx+I
	F5/R4d337aZwhEmeqOfXWlF/8BWBA782RtEPb5bv8i0bckHSjHkXA+f2xemYd3Gv
	M/r8cdLRqYG9Y3dtWZDuhrsqkiXtF6aCbvQZ7kQQ/qRmpZWxx9Dha/EadAewjms+
	q4RENcwxjhrV7WwOpq0n3bdrVxGtTeRtNpAC3oqCLYF5jkJqmXYegkTUszv+xbnd
	sjctXL5F/05oIXrr6IBk59QBkpgRT85px8jlsMg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:7KSFa3QAfCWtTuOeZdsimWAqmMj2/jU0S5nmXXo7Ycs=:qjYPEPs9THPYJK0LUFIj/ayGFVbMT3gVYMWkKxCMb+8=;
X-ME-Sender: <xms:0cb-ajhILTuA3MH_XVZJrmFAuX7JLM_YPKv6_2lmoRiGY8WbZFACBw>
    <xme:0cb-anDQ-Gcxn8a_LlD0JoaTGIZU2LJP2lalmMnHsi0zBVrZNflFTQ5iT7twYVWov
    PXxNHCUVJPxkS1obIm6v7LmIjXCwN-Pfh7arczHzrftPHcCu7qYXw>
X-ME-Received: <xmr:0cb-aoFtX4WqvGoo-tFb8ndffS8Ttu6AivfNSsBosxWNeZLdRymCI4RV6-0TZZ6hJCIzviw>
X-ME-Proxy-Cause: dmFkZTFrnfmw4gJlWku8vZnvcpWTXDGiF7Jqm2WtEe2oWMqR8dMxBc4kiH3pwLCbuC3Dfk
    kF+odFSGuMf+DLeWDP1FZ/EXTSB91NapBrsAIw7FX38ywANIDArucl8C1SZz2PaY96uRl1
    E+QobHDNzYFfjkIU2yFJ8hsnWPX+WO4o9AUP1FslGRCM6DU6/hv4iKKBOz7ZW4xZWRCFDj
    5f4HtuDyB6b7/Fey77jbnUCkIUE4B0dIeE1SQmfP1WoOY4ayj/An/uj2zxZam4OuPa9oDk
    SHZcLKK3wYdYx9E6SIzRvQ607e+yJFeDB+g+tROQ6018wT2VzIjvgBvlcgvq54OjH5Bnb6
    LxdlPUmBjIbPZtsQ6IzW7Yq4SAvrRBIxFElPKkqY832EGMdBP3Zn7KlVKwSht2C0cpV1t4
    cOn2BEvUsGBleWMmhlUMuVY3ul/QLw7mtcbXU5Wq/uDmZi4wf42QoOp9fB3y98lfmfSJkr
    WCsF0D8ph1BKVIrD1YGxGhybf78QsnfjmVEJvhSQkwKp3sMIsL/ZLmYyOV+0LbCr8pgz2p
    djviwBdF1kTSmhSfJKBD7LQ1WH8QalVeUE76rPpgWTE5qxJJYoVm9DoeEY+dA38+xBYSMw
    e0gr/ZtV4wgmbSVVuJbB8Omcj1MX2/xZv8zygb8gjPPi6TLjGVrYSdZu3lIQ
X-ME-Proxy: <xmx:0cb-avKTDzCxRjrgzerGSVQhRIVAcy-gpyiAfAJTUH6SxYHMSpHU2Q>
    <xmx:0cb-asmf5mF3lFObREdh5U55MFbbppcMYMFiccVSVEt66jOfnUeFlg>
    <xmx:0cb-anTsoswHc5hgfCa9Oq5gNaVPL7JG7fdj-FUqzoh-pDVpbJm9rA>
    <xmx:0cb-auL4qZxPIDljxNOpMfZPjB77Jm1OYDkBHPoN77Tc-FcWGiwE-Q>
    <xmx:0sb-avX6SgZYppHFC2BSwkzw9Vn9EAnGYWUqIdb-aLsPMcLRIHvSoA-2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 04:52:16 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 28120e5f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Nov 2026 09:52:13 +0000 (UTC)
Date: Thu, 19 Nov 2026 10:52:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH v3] setup: fix hash algorithm detection
Message-ID: <av7GuJC5gMVsTaQL@pks.im>
References: <20261108011633.1772000-1-sandals@crustytoothpaste.net>
 <20261119010612.687733-1-sandals@crustytoothpaste.net>
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
In-Reply-To: <20261119010612.687733-1-sandals@crustytoothpaste.net>

On Thu, Nov 19, 2026 at 01:06:12AM +0000, brian m. carlson wrote:
> Changes since v2:
> * Remove comment.
> * Use `$GIT_TEST_BUILTIN_HASH`.

Thanks, I'm happy with this version.

Patrick
