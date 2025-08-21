Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA61E2853EE
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 06:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755758466; cv=none; b=ow2NuFLRtzk/5lSjZhYjfX9ObGFS2+jvptp9HUXW6yEVShTYIpKD40J3NgffVnIlvUa+tZZoqWVEN6J0nAzpCCo/JsluiG6P+3LQ50o6odxPxMZjtPD7A/LLh3tKPLwnRL9a04gRGWgZiYysuYVHcMy5eg32Kyj0fyHGfzYQA2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755758466; c=relaxed/simple;
	bh=uU3bLQdiOmqcC4gd1nYQ7EYNSP3A2EeCMBUSgHhaNBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haYff3LJz/JLKFp2JUkKymrLT/14yye1UDvf9LuIfzxi66Hb3PMkMrH8m2Ib4Efwjb+76yT2uAQBy7dXxPcR7Cc1pfZ2vyBGRZVEe0kFhf7U85X64UN+LirtvkyRZmbtDEC4xjpcvjRfvpH1nG6xJQNCAHpt8RkHHR0jpWggA04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ix2crPkn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g9kun0AY; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ix2crPkn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g9kun0AY"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D7C8014000AE;
	Thu, 21 Aug 2025 02:41:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 21 Aug 2025 02:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755758462; x=1755844862; bh=wzrplyTOLK
	gphSn1l9u1YwS/bHnUO5JgK2WZ8RsRVLU=; b=ix2crPknPFwOudUAB899c57ake
	5kN7U1OKmdO/Rs2QSpZzf2z7RJ1Y8LXjvuQshKoai1LSXq9BV3Gj93C0DcFR8G+6
	SuaX3PFOx1vyD6OPyK+R3cvIt0NgIOljGXXCgDRKjuXENBhwcpYY8/OIaxEKgyYn
	ejCWKYaP3w2TpqqP3VLwizhRMud3LP5xAcvXsm1t3S2go93tkUocPLC+rjpmB0ft
	6+luPy952SuzZUqg+ogMErGbHGhYSYse/mIAsW9cmexdCnnleevEGeLRq78tIXmZ
	KDAMjZd6W3o/rBJbVr6E932jaaj2RylYCKeSNf0qA4udp5KpV2SDGiGC/RDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755758462; x=1755844862; bh=wzrplyTOLKgphSn1l9u1YwS/bHnUO5JgK2W
	Z8RsRVLU=; b=g9kun0AYzkpoMp6f9cPyK0kLGOAYZdQZ7GDELCW2eJDTVq7L7Ae
	SSxW2huWO5g3ZI3Qc6JB14fWmRuhPLJCyxohKJ/tpycYbmAcHwrslMs8AAl/6Tcm
	aIpvlvKPYluLNPELSIc24QmGo5kOo0do/qLJA/yKDTkQ14UBUJqaNtOMrsrA512R
	xvrSvuU2+US4oQOBjecPLRyOAhRKn+bGV4wmxQyCL/kHjEUSEk9ul0DDYxO+54ct
	wtnCofuDyjcXCVoGAdBAS/R3yDN8z4vR1JozDE0AQkT4x8yg+NJ4qpNMDxf34kDl
	YHrcmBP2ofJVy9vj2ekq57+gdft41AOw1zg==
X-ME-Sender: <xms:fr-maM4jdizAScdmjumwheZSplRRsrX9yumVh0WfsmCaLeUhD90PaQ>
    <xme:fr-maOFIqewsIvsUJfsg3kX7KcV7PK9L5KF-6L4Nmwsm0TlX4Uw22iPHbO9TRmMF9
    -VusY--c5NeCzbiqQ>
X-ME-Received: <xmr:fr-maNR21FAyDdOKuI2wV8JjqudTD8vnHiV2oG2FqzCT4_13rpWyQi7j5TLb2XxG2vOzCHCgDEXhfua5K_RFw2sFrZ8wBJ5eNhRs7JHpvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fr-maPuNb5rDP6yjHhqB7-UvPLqnXbh6rEHms7XcOT0yULen_DEW7A>
    <xmx:fr-maEzhCib2KesV7g1OzyqyfxmCKXZMnzPJ7o010N6eWO_CTX20hA>
    <xmx:fr-maB7osG4YT1TzohxyWRt-wNXmia7K1fGo6d85UvI_EUVAuXrlyQ>
    <xmx:fr-maGXAV8N4Pptq8Wi3l5SrcPwychWqu6b4h0UF6I2oq9ujh4Bwyw>
    <xmx:fr-maIK9t-BaO-xSbOjCSvLaW9NI8cOkrPcvzftPJO2--KR_IkmXxhm_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 02:41:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c770293c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 06:41:01 +0000 (UTC)
Date: Thu, 21 Aug 2025 08:40:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 15/16] packfile: refactor `get_all_packs()` to work on
 packfile store
Message-ID: <aKa_erHX3aFhgL5j@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
 <20250819-b4-pks-packfiles-store-v1-15-1660842e125a@pks.im>
 <CAOLa=ZTZzomWcCObMoBtNzFzNrC-OCWuzTqkTUB5+xnJ5VoV1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTZzomWcCObMoBtNzFzNrC-OCWuzTqkTUB5+xnJ5VoV1g@mail.gmail.com>

On Wed, Aug 20, 2025 at 06:53:34AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The `get_all_packs()` function prepares the packfile store and then
> > returns its packfiles. Refactor it to accept a packfile store instead of
> > a repository to clarify its scope.
> >
> 
> [snip]
> 
> Nit: From running the clang formatter, small cleanups:

These would all be while-at-it changes though, so I'd prefer to punt on
them for now.

Patrick
