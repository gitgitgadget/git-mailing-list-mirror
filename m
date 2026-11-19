Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795087744;
	b=oxAuGUQcq+Wmab9hCG1doGQANUy2RwdSRV9ieBYftNvc9RApPxLeszybOF08UJN6O5Vp
	 1DeateQraz3Yq/EcvFk/z5NCtKU8vHW1XEYtXczgbO0Tt2o/qGOahJW5hvl3OmiOFKle/
	 SkSLHuqhlCcctQ8mnDNmN1XGAHiAvzsYFM82WQKFBdB0BE8amMbOKVuUU0RGqw7euVe6M
	 1Io4mY8nt3PM62YzzHtf/wyYy4C/eqveWNZ2tNbEMf28c6aE3QXb0hTwD/3xV8rBNI+1U
	 0EPNcnmXPt/s70GG+kIVKkS0jeL7Q3YTdiVuVppQsGFtZzxEKHwpJYpN+RyhJ4E3Ciw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087744;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3cnHS4fwjWPAxDdCR8Dag19sJ+OYGWSGeX2Kqk+G3mQ=;
	b=vWUfmXZU83SLrbLfCDDCbuP2gUy7d8iAF/bF3qabDg8TmtYCqAdvlT0cAQ+/XRWxkbYi
	 v213OCMaMvkJRjCfzRo+yXDz+FuDG79EuEU4N7I3x8kSyOsrmttPIcX2G0By0pFpFm4Mn
	 o5Aqp6M693ZcVdM6r0z4QEIcmgQxU8f71vCB5QkcEr10rf0nxlLOlFxJPFmTIDRsbBtPl
	 5kVMtUiuQz57QVJho4e27UrglXKffhafUNapmbwliSeaXflh884t11QxDB9Xvy9g7S7o4
	 W4+n6GVtOS8MIMMyimht7irVDdgjSX4gerXEsnEMNUf2dWqNGCV7HFcZYk4WAF9oA/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=nFlPZS5r;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=t8gf1h7Z;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAE8606A332
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AAE8606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=nFlPZS5r;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=t8gf1h7Z
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 063A0EC05AA
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:29:02 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 19 Nov 2026 06:29:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795087742; x=1795174142; bh=3cnHS4fwjW
	PAxDdCR8Dag19sJ+OYGWSGeX2Kqk+G3mQ=; b=nFlPZS5rFIaRFZbhFpnyU8DJ/m
	W6/QbGhrpCwnDCaLEF2USVgPeZ44R0US0ak2uAkGLSJEKKH+EIxFpq+3Zv8+8x+s
	v/hkhDf+xvHP7LFtkLXJkuGdGomkRx925qbZesfGN3O6zb+rTX7l93LEDzoJe2dB
	qn8s5RqvO8daSTtAKMjG/AOILgbJeKKjIIJjBAqVjQedx0FQXaOvteOpYOMLCfJm
	zpbtBDQ8Bn2gdSHa9TzhwJG4UQJd4fiREjOhKKOsJGhQAq1u9ZDv3bg5kYCsYBfm
	3czPiVIATclzmUoi/KgImvxGuXcYkyHTeigzAvG5uNj2SW5nui/BhIEM9zIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795087742; x=1795174142; bh=3cnHS4fwjWPAxDdCR8Dag19sJ+OYGWSGeX2
	Kqk+G3mQ=; b=t8gf1h7ZB9AdI/C3n9wRhvJHec6pGYSauhWZYYuFqFGXau6GYIf
	rC+ly9wRXmaJkocrsflfHcftcW1y1aqklrZOMdQ38hznXJYswQ/KPql2cOf0tU3I
	gx3Nz4D9Rj+iTSMWVTq/LnkXGVyl9OBFvwRP5oT364VVfMnLz/3xAz99nkzcZOde
	knUIFZ9oKV4g58LVI9q/kEMyshGw1u1Yr4nILo4/PXMn6HsRlGTprpI51RHhTjBp
	5qQPcwReQ38XE4/kSfy2+Z+2WFa3kijlpotBnF8lWeL/aTm0xnp8J1vpSnOYHLOG
	I8OX704eXqXZwVxuSsQmxSr7Kvs6tMaPqJw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795087742; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:gPJZTUPjJzWBVsPHq55hCmWlYhFc76niKd6scm+QJcAigqH
	mhlhi/qZvD8BSRrPP3VqL6Ksa4ukh/stHVKpT1sTf3MjTUnO+L6LAbzSJ0AEUIb3
	woWXGCXpHfwRMExqe+rO7uDMrFE3Jj4xZeLr8hcJR0Nw4PIILUlhKerakf2HjTak
	qDZJwOXPZTobyzk8rlcsJUXv6wjSos7HYcqumi5VJ/wrt0NTuv0QlmIqxc1tpsVz
	+1MgRBeXGEtSmRyL43KZ4XOL/N3bPvAbteZi4foSmYALzcb75OV+FSFyff9GlnTj
	PUF+hrANZaDzBWz3AIoA/9SXF9AbrbDnMJwyF5w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:s8WWT0csQ5tAxlOHlegkYrhNBLO3SNAtlUGfCU1QsFk=:AHDyBiVC+Tc5JTaVcucIFmiNyIl2nydBXGgib4EaIck=;
X-ME-Sender: <xms:fd3-aszNCP6t3oCkSqD0g_TjUjkEBXPpEHE-IYrAB9noOKyXILaAWQ>
    <xme:fd3-anLO4c2TaHr4iNHM5m_4vAEPZFf_m6mUGNKruLLYJDjo8QtMQ45QKf_49bo5P
    qsS6EZCy_Yj_3U1s0msk8kGWqlNAdXQi5JoZN2r2OR_UzyKQDrxFzQ>
X-ME-Received: <xmr:fd3-amrlyVgIV0L9-FY9qNYu3ECeM5u6838yjRurOiaGyoqmjiroDd16fz7y7zYn4_9njfU>
X-ME-Proxy-Cause: dmFkZTGKNtEmo1h1cAJT1Ph2IHFKPlrHrmzTgWTeRfHyBwfxZtnnLso+l6G5msT6zfBa8e
    j+O3Ly6+2PVPptDy2zifaXo4jm2kyzBIwoAXfLyJRfGx9Lvi3VrQcw4x/SAwJFvyPzuanz
    CfIznL9SgCdWVPXIkTDiO1yCKrocEc7E4qqJDCEhAOxT6/ssXanbEFBvVMZUK2CuNQVAEj
    jdfbxIelIUilhEGX6EO15RYV9rTW4FbwkcvofCSyub1MtFGMJJEfueyUGhX7F3krqsLDsY
    UZeGOuKY52laxuo0GEhHBuRnQx+kx8aTs+tqlDeNA9EgRd1A7jv8dCi777UcFoSvdrYBOS
    6y4pEQgeEZnDWGIC0FEFLIBPZ1NsmZz8rogTc67at+FyK3VGIJWyBIJGkh9JW/TKF0n7bZ
    NorgLej/BGzN7JWC11WVEv+oLkZp7K7q4e7xcHKZUwFwybO9fMLM7ND5lObG6Ldhqmf9Q7
    nJS1e2WHvB+FuSXLzkf26OK4D/l95jaKrcEUdncrJsb/pr+sJdYoXno/Xt/t6+9RXHDrda
    d33CW33TZxj23fEfmUBJST9KsC9AeGV4oKkZIpjpF7MQhSvRadxvN6fUQP+BehLtsh5oCi
    jBOa8HZiZDo1/zkdL1xRIMNjtzf4u9jPN5IiGaUfWc/6q35lB3eNFAcxbL9w
X-ME-Proxy: <xmx:fd3-amIUbSFYZyFVyXQm9qQJm0bixhhRaIwtjRO2uPQ3BjTbylZIfA>
    <xmx:fd3-arR2LzfoNsIBiJOD0ItwSQUTKgx592xwfcq4oGvTBYzm8a21mg>
    <xmx:fd3-alucx62dSuDUel2qnR-omw-MLciJAxhXd_2-poSDqU1Sd3YWiQ>
    <xmx:fd3-asaclLhYsL9DMJpmacoL9f_RsLuKGkxaycxGvsYw18cJ_vZzBw>
    <xmx:fd3-ajmpZaEovEAR6NhgvzpTm1eF17EADOmUZksMYn0M2-pBhE2VAlBO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 06:29:00 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9e8c9748 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Nov 2026 11:28:57 +0000 (UTC)
Date: Thu, 19 Nov 2026 12:28:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ravi Mistry <rmistry@google.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 3/5] http: add http.retryStatusCodes config option
Message-ID: <av7dY5lq1AAymnp_@pks.im>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
 <pull.2287.v3.git.1794022836.gitgitgadget@gmail.com>
 <6510dddc39ca61fe1ae2f81cb8e7febd5f82d5ca.1794022836.git.gitgitgadget@gmail.com>
 <av2TehodwlsK6BnO@pks.im>
 <CAF+mdify3esjp-ghiFj6uQEEwqQvOzMd0+Q9Z36BoWQGADb8tg@mail.gmail.com>
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
In-Reply-To: <CAF+mdify3esjp-ghiFj6uQEEwqQvOzMd0+Q9Z36BoWQGADb8tg@mail.gmail.com>

On Wed, Nov 18, 2026 at 01:53:57PM -0800, Ravi Mistry wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Maybe the fact that Git now handles retries is a motivation for
> > providers to fix their infrastructure and instead align on one specific
> > error code here. So instead of making this configurable, can we instead
> > nudge the ecosystem in the right direction and make providers fix their
> > infra, so that it just works and users don't have to configure anything?
> 
> For rate limiting, I agree that providers should align on 429.
> 502/503/504 cover different failures: reverse proxies, CDNs, and
> client-side proxies return 502/504 when a connection drops or times
> out, and servers return 503 during temporary overload or maintenance.
> 
> We also should not retry them by default because in some setups they
> could point to a permanently broken proxy or server. Keeping 429 as the
> default lets CI systems and system administrators opt in centrally via
> http.retryStatusCodes where 5xx errors are transient.

That part I understand, but I'm still not particularly happy about the
fact that we make this the problem of the user.

At the very least, we should document that the expected behaviour of a
service provider is to return 429 in case they are overloaded, and that
all other behaviour in this case is considered to be buggy. The config
should thus make it explicit that it is a workaround for buggy providers
to entice them to fix their infra.

That would hopefully nudge them into the right direction.

Patrick
