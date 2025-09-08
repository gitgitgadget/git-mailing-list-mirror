Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9302989B7
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 06:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757313758; cv=none; b=VRMVZjN9xs3E64Cud4jZTeUtwuoCb/COIiWFU73WGB9J/xJf3Wm5crnmvZN4QlmOarsnJQR/TM/GvehVKs8mti6rPd9e3sni8yBaCVe7PLtcrIT8Ec32iAb+ul0ntIz4TFwQlVdHKpqyHDXboQ9qX55KsqHqkdAOQn2ub0ztfB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757313758; c=relaxed/simple;
	bh=+brtPJyITP1O+AHfVklNW5HHAVXAN2cxY+CBb/m8Xgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNp07K1pNaUo7d5jyv52t7lRD2ErvPLFhF3FVV90toBrhqr/gu0UAaa0L1jPMtcSs+wtekrbDQoXvgjmsCUaDBVZIpNN8IHy9BndAuzySncxJsHExRKzhvw0kuD3mTAQQy35edvRrWbPCnqLd1xSqT4eiGlvdOoqQoKAfFQNuRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eLRyfgET; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qw3Yz+XW; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eLRyfgET";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qw3Yz+XW"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 0194E1D0013C;
	Mon,  8 Sep 2025 02:42:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 08 Sep 2025 02:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757313754; x=1757400154; bh=wemnzu7bTE
	dEF/O2zqUdfdwL43MKsqLvfC/Y8pXrcKc=; b=eLRyfgETtijSZNsqEDqj0pLDHP
	SRDWtx824j4DtSy6Xxpw8m6Bx0yHzW2y7/UJMQN81mBsW8b9aBHEGsnMn0bVx4oI
	8nMC124e/3JGr1aElOVoe2kNVf8JZqq1EIZnar0Yh/ljeCn1lYhi5wxVV0ISNfCd
	Luq+UJSKeaHzZDXphqArDx8V+ScUhtEjH39ivVznMPsVsE/TJaVeb0JZRXRwGyrK
	lJYeXSmG3V2bZ3u68emnXltEmuhZXCVvwpepFJKBoJnhaDsgsA46Ko4zBkq1HJBw
	8vxFJmKFLUFNTDB9kkxlmZDao+3kQh3rll7m7DPMPcjYzPUdt+4F6L+4OfdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757313754; x=1757400154; bh=wemnzu7bTEdEF/O2zqUdfdwL43MKsqLvfC/
	Y8pXrcKc=; b=Qw3Yz+XWwt3UGWa2Z1QCyEYuhR4cj60akWRXzPKRC2ygc2CjWyO
	BHKd2j4kx86Q6kl0O6M295MwhBEZVCGeLY8s4msmXlS2m4loMQEq4FB79Cc1O16E
	SZYTgBbmosqLjhaou7IbMqh/P8J0xJpdh+F8pnvGXRZDvn3IEVO1Ze3pOJ+BBjpN
	30V7mzUkkTP7XgYITCeBf0UphkBTAdqIVNY19+Aw5Nkx5WZHgwEB1n8AJzu8vnfv
	qCaG9lK28drgweE42F9UXITIgAuIcD6vOsFCkcjefxZIcoCTP5HLvE6UwKB4orC9
	a91IjJHINZnI4ZmFGxSVqyk/cG0dEPvmI2w==
X-ME-Sender: <xms:2nq-aGlcuuaBf6vrPaZB25T3Q__8RY1JvFbv3CKAJy0DSOwEuiSKcQ>
    <xme:2nq-aOceD0yvIrJ4nw3_imyAg-N4SIWKP_i9yndE6lJIAz9aa5WSECPxTBc7wAwTl
    I14d2jALU4H3Bpv8g>
X-ME-Received: <xmr:2nq-aPyBuR3gooCAhhtbumJmW2wg6aLD6PSbYSoLYXtOjsF_bchr1xCV7NEGAbMoVg9w3AEIivO3nyjU2T-lNXNwny7kqUCz4Bo6DGp7ojfLyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptggssedvheeisghithdrohhrghdprhgtphhtthhopegtohhllhhinhdrfhhunhhkud
    esghhmrghilhdrtghomhdprhgtphhtthhopehpihgvrhhrvgdqvghmmhgrnhhuvghlrdhp
    rghtrhihsegvmhgsvggtohhsmhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtoheptghonhhtrggttheshhgrtghkthhivhhishdrmhgv
    pdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepjhhohhgrnhhn
    vghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepvgiivghkihgvlh
    hnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:2nq-aPLKv8mjf5UnpAjwz0QXBUix_sSjBEDgrVdgWEw_f4sS2TV-Wg>
    <xmx:2nq-aIs0yt3tJRJ27Bx9SSU7rOwTBm3eaO2VHfnoWua-g-hOGroGSw>
    <xmx:2nq-aBTJwigg7DLM_BAYbiHjjQ3lstwaMgdiBckAdB8NapyhJycxww>
    <xmx:2nq-aJTTjfEPjhFGw25vgQeXF8_cVWGVihV-N7PcjroMRMY5yFqSFw>
    <xmx:2nq-aD8FFNLJWFOW63gJE3RZ8CgrmIPTX6f9TouFg-KKWYnVh6pNgAaB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 02:42:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id afa9cc18 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 8 Sep 2025 06:42:31 +0000 (UTC)
Date: Mon, 8 Sep 2025 08:42:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
	git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v2 5/7] BreakingChanges: announce Rust becoming
 mandatory
Message-ID: <aL561B_js3l_FGqD@pks.im>
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-5-6939cbf4a0b8@pks.im>
 <DB9P250MB0692264976781C194B7D6194A503A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
 <aLrnwOGKaAjLj0Bo@pks.im>
 <9fcda14f-d4d4-4db4-ae77-d9408bfae035@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fcda14f-d4d4-4db4-ae77-d9408bfae035@gentoo.org>

On Fri, Sep 05, 2025 at 10:38:16AM -0400, Eli Schwartz wrote:
> On 9/5/25 9:38 AM, Patrick Steinhardt wrote:
> 
> >> Do we want to commit to promising support until gccrs is ready? What if
> >> gccrs ends up abandoned? Or takes an unexpectedly long time to reach a stage
> >> where it can build Git? It might make sense to give this LTS release a time
> >> limit instead, or in addidtion.
> > 
> > Yeah, I wasn't quite clear on that one, either. An alternative:
> > 
> >   - We will maintain the LTS release for 8 release cycles, which equates
> >     to roughly two years. It sounds like a lot, but recent security
> >     releases have stretched quite far into the past.
> > 
> >   - If there are still dependents after these two years we will hand
> >     over maintainership of the LTS branch to dependents. So they will be
> >     responsible for the backporting.
> > 
> > This really only is a suggestion though. I'm especially waiting for
> > Junio's feedback here to see whether he thinks that this is a reasonable
> > thing to do.
> 
> 
> This seems reasonable to me -- people who still need that LTS should be
> allowed to ensure it still works, and be expected to commit to the bit
> -- but with the emphasis that I would consider it absolutely mandatory
> that the git project accepts to host that branch, and it won't just
> exist in some other shadowy corner of the internet.

Oh, yes, that's what I meant to imply. We hand over maintainership, but
it should ultimately still be sent to the Git mailing list, have proper
reviews and be merged by Junio.

I'll reword this accordingly.

Patrick
