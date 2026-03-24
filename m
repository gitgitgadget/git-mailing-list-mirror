Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A04B33BBCB
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774337977; cv=none; b=QzgR68Exn2t84C3S80dVipFq+iD+S1c2Oll5LpJEDxrGmIrlaNkjSyAq+W5Vf6NRecgy2pPpok0xAHSfz9X+TiwKw5DKGm9OXpVGhanYE6bNu/X7mNwzha440QaoJjApow0RU/KmfsWjk4QYL51c0cCGR2ZktTRvCaRMLQoslj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774337977; c=relaxed/simple;
	bh=duWlnpy7U4joBAGD/lBB6rmeI5dwwUIDM89k0bagb6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ga2I3slH6Y3YA8v5HqcLoXdkJuhYNoiYGTDKnlsCuFYP1neubTRmAUFDb1tzXE+5IsJRlHHvtCZQm8zFsjRdc/Vv80wcoApmVVgva+wN5gsGVEWiTfLLuqAOk3s6JSCYiNC3Upqbtdo/ZkirHFHzulWsZJKZK7p4hYgSUV4XdhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hk7IR6YL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lHYbv0oK; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hk7IR6YL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lHYbv0oK"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id CACB3EC0203;
	Tue, 24 Mar 2026 03:39:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 24 Mar 2026 03:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774337968; x=1774424368; bh=2WpSggK0lQ
	s/eP9f4axcHkocoNzeoBcOAnxuKsFE6HA=; b=hk7IR6YL6RuTtL2cao2NGcTO8W
	Yl3NscYVuZBW5h3Hs9f5u+xnRGzOo0P3EFDelJXdc6o7IWoxTWRb/2lqVrIkhtKx
	3NuerFbbPSKt0HpZkgyf/T8A0nuAdIylt2vHq+gJMHgGqetZaXCKHVr3L0vMAeyZ
	CgKa7ezrxbFK8YkbszKeda2Dj63phVLPUTJFRAwVfRrnM8NWX0u+QoKS83cwayl6
	9+XDG8GqpH/GbqG6DlJd5bHptgK8m+KIRplO8FhxpGqibwWba//jmChsXMaUMAb4
	NW9vekfxiaCYY9sCfROPbpRo4DaEPIuereq7n+XGfzk8GDwQE8Ur0+cvNftw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774337968; x=1774424368; bh=2WpSggK0lQs/eP9f4axcHkocoNzeoBcOAnx
	uKsFE6HA=; b=lHYbv0oKpijWWg0vfdVNi7Mxon6OXZBIyB/2Xx3h6heO9gzeDQ+
	WCr8LxR6xIIDOWbrR1iBsbs3q0jT2zGIBe5UqJ6BFLxNsdlCdqZRtVfzRtigzCSX
	koUWgVYwWwqKCHT6eio2QVI3nGBl03ZMhjqcd8QVs4gWQMuX+cOXqGAreTcdY3j4
	Upr7NV3q+/nGDR5CFJVm2ClbEhcx4EH+Ek2rg2aHSlkhWK+D1DFrD0TWz9mi8cLG
	tdEm7mNFjOcfnAahO8krwaggjNzHjDhdq3UkW/T6ebB0vBh+1a0ZIyW+3nyjoW8y
	7KdGNhJM836QDI2kgUKi2hXscdNYAZnqMbw==
X-ME-Sender: <xms:sD_CacF11GPOFcuEChd8AQ3vPMg3FjvKCfgrLBBSTMeX7JBVyJJBBw>
    <xme:sD_CacNvWmoCILAzv0jwRAJ-1sLA0VHn3jIAsoO_XDNY0oeS5YdMOMiJZrJVozUCP
    qosIpMNemTQOT3ApHIP-rxdDMhG5--D02jJHFw5L4F4BxpluC91qg>
X-ME-Received: <xmr:sD_CaedawU2HPPkD5ki8cBQ8dGSARwIGiAF9nvQu8qCpzGePV3uKyeDcr7mWPMDxVDrPNxavXybbvbY1FPqOdRO_xvkLuX-8aN47GQyHmful6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddutddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthho
    pehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:sD_CaZtolHc0eKA-IUUtL5Ecc6rVLBnuGofQJOgKY0mmIrBzSQnp4A>
    <xmx:sD_CafmIJU7yF1Ev4mN4QPRkacZMVwj7ZTlTlO6RjYm62KQEwESzFQ>
    <xmx:sD_CabxhkzatiN_aCQ80vO7b2RZ6gcpoj9RCBsZ1a2IC96v-t9Dzqg>
    <xmx:sD_CaRPNGB4dQ_NSEOiUjovCNhESmkQMnfNaWfZTm3o_Tte2qBYHog>
    <xmx:sD_CaWPkWnuazMbwXy6Z70mHR1W1FyPkcTClKjZ7Pw5fimukN5bBH2DV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 03:39:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ee4dd727 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Mar 2026 07:39:25 +0000 (UTC)
Date: Tue, 24 Mar 2026 08:39:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/5] pack-objects: plug leak in `read_stdin_packs()`
Message-ID: <acI_pTWTcJN6QaK1@pks.im>
References: <cover.1773959041.git.me@ttaylorr.com>
 <1dac74f1e4a370097117754a6b1fbb6fa2b382a6.1773959041.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dac74f1e4a370097117754a6b1fbb6fa2b382a6.1773959041.git.me@ttaylorr.com>

On Thu, Mar 19, 2026 at 06:24:15PM -0400, Taylor Blau wrote:
> The `read_stdin_packs()` function added originally via 339bce27f4f
> (builtin/pack-objects.c: add '--stdin-packs' option, 2021-02-22)
> declares a `rev_info` struct but neglects to call `release_revisions()`
> on it before returning, creating a leak.
> 
> The related change in 97ec43247c0 (pack-objects: declare 'rev_info' for
> '--stdin-packs' earlier, 2025-06-23) carried forward this oversight and
> did not address it.
> 
> Ensure that we call `release_revisions()` appropriately to prevent a
> leak from this function.

Would be curious to learn why none of our tests fail with this. The fix
looks obviously correct though, and there are no other early exits that
might need fixing here.

Patrick
