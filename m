Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956EB319871
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588725; cv=none; b=sCzMSrwNv1ojR4Y+s4hjYnJm5Y2ft/H0B5gIpZqVBH9GIaQvsmo1muA4mupAR1uUk6e5S54ZP/IcrpWKB84B3qBH1fq3QCjZ2XvKrD3ogO26poJe3o+NDj+fRokJQU2UqGxFZ6u+HmQ90uDt31oHsyMDVrOL4DpDlXGAL8il3rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588725; c=relaxed/simple;
	bh=nGimskaOiAkSwaCgsTrgkpEAMztYutgOkz/EDCDf/3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cmo8oM4KKmyd9M+gNfpdM5Fi57XRkE0aTA0NBjeMEW9OCv+yFdqKcBL7/+/yRs+NcLIN0BkbC5hTMQ+8n54DE1vQkQaNEr0odA05xRIiTJ/S0KdSvxPYXI29gAJ2y3Y0RYtVEuPLkbugv3Nx/lC0qOvTjwZm6HVnmo2jKZ492t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VSBEjRS2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XaHw8hK2; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VSBEjRS2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XaHw8hK2"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 0C13B1D00041;
	Thu, 11 Sep 2025 07:05:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 11 Sep 2025 07:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757588717;
	 x=1757675117; bh=YogdcqB5m+E2eW/wwsup2cO38ntUTeRCmV2Sbb7oVG8=; b=
	VSBEjRS283WW+mXH6S4riVyXFM+zjNvDMLpW5lFPWFCGitC/oKbufQuDc/pOyAab
	M1uZ0Fsn5uMB72AdJkE0eOLcAJK2y1YKMc0UIqAGhYHH17P8pDdxrAy6Ee1NMPxM
	UTJcDZjJRse6cBTEU1SctHBsVJd7jFwuiYbWy5Eh6zQ5XWXhLibNQxnIZLpV4yOT
	29AZFurssRGBHBfaHA6ZRVEGgPea/nwjsZ6Y7v/r/PgbzK5V3Y+FIoZy4rHLfP6h
	tF6vfRccdC9ITwvsv+AQJqNa0iBQWcC+rCApig5M91hT8sId93oNSK6nB9DmM6WC
	3LvM9qf0yubSC/j1Nj9l5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757588717; x=
	1757675117; bh=YogdcqB5m+E2eW/wwsup2cO38ntUTeRCmV2Sbb7oVG8=; b=X
	aHw8hK26+9/8eVL5Ngkg++En+WpayYGbn1SfQRo28JoVw038+pohSm10U3SjTX8P
	S4reV0jhe1tXaikN35o1Q83hvEBs9Go7FRfgAdWcMsWTeydDdkCEsGVw2TtiksUE
	hiyitg5k6IPAnK8z/VaxcMtiTHmwQ38P5Evc46HsHv06locHA/4XeXYpMAwXhaP6
	t5tjzf3wk7+7jU5CJ5rql5FNQZQNHClFaqIi0plVIdI/yM1r1DwgMgCt38T9llPP
	5d7pewjBFq+fE1gdQsyNyZ62gzLFdys7G/WeKGuZl1b/cUE1AlsSPfOqAjPju9JS
	o5pdhOLTLaU9j4xvr0RJw==
X-ME-Sender: <xms:7azCaG4mIh8Lf96U9JC3Gcj1B1P_w1CK36b7rBmgOEf88Vr6KlP7Hw>
    <xme:7azCaMwFl0h87VnOyQgBdKjcrdp0ZlAQbXWRtAXGU1O-xSIqy9dTlDA35LyOamMlA
    ThywpITnUiksKF3Rw>
X-ME-Received: <xmr:7azCaFN1H-XyLzWOGS_j6VCjF_Jcr5jz0r-0Ym5b3NLsHZ3PZFo6YcIMOS0qE_44YXnqa21tIh3Nasf0eL_9U9iNx_D85hv--HuKPOi-gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddviedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgu
    ghgvrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepshhunhhs
    hhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
    pdhrtghpthhtohepughsihhmihgtsehmrghnjhgrrhhordhorhhg
X-ME-Proxy: <xmx:7azCaCm20XWrgbx2nC1UYY8JiSmBI7wS4TDS9imapZSHZdss-KNK9A>
    <xmx:7azCaKQbYSG3XR3ye0BNcCBwQi-YrwembmzvVAfBfyww8Gtz8M4e6Q>
    <xmx:7azCaBUZZfEbAxbeQ0KZRyGz291pTBrSRQH2Ly4_lwNWaTFB0CwmBw>
    <xmx:7azCaOJyvGkRNANXGQzaeXX78gPKGUu41glIRGLmKO92RSgmA3u6-w>
    <xmx:7azCaO0HfeS8nbeDrAUApdNV4kqKLIeHOMftVGDaWfO8XppImZ8t4X3e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 07:05:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2cbee207 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 11 Sep 2025 11:05:14 +0000 (UTC)
Date: Thu, 11 Sep 2025 13:05:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>, git@vger.kernel.org,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dragan Simic <dsimic@manjaro.org>, rsbecker@nexbridge.com
Subject: Re: [PATCH v5 08/14] builtin/config: introduce "get" subcommand
Message-ID: <aMKs4qcEI4RrP_6U@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714982328.git.ps@pks.im>
 <29676b81e0151e2982326663f8b64e2a70bec0f8.1714982328.git.ps@pks.im>
 <aI+oQvQgnNtC6DVw@szeder.dev>
 <xmqqjz3kdomv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqjz3kdomv.fsf@gitster.g>

On Sun, Aug 03, 2025 at 03:30:32PM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> >>  #!/bin/sh
> >> -WS=$(git config --get-color color.diff.whitespace "blue reverse")
> >> -RESET=$(git config --get-color "" "reset")
> >> +WS=$(git config get --type=color --default="blue reverse" color.diff.whitespace)
> >> +RESET=$(git config get --type=color --default="reset" "")
> >>  echo "${WS}your whitespace color or blue reverse${RESET}"
> >
> > In this example the second command in the postimage doesn't work:
> >
> >   $ RESET=$(git config get --type=color --default="reset" "")
> >   error: key does not contain a section: 
> >
> > Consequently, the last command doesn't work as expected anymore,
> > because the color is not reset at the end of the output.
> >
> > Luckily, the commands in the preimage still work.
> 
> Instead of an empty string as a configuration variable, using
> something like no.such.variable that does not exist would also be
> a workaround.  I.e.,
> 
>   RESET=$(git config get --type=color --default=reset no.such.variable)
> 
> What is bad about this is that there is no generic variable that is
> guaranteed to be unset.

In fact that's even what our tests in t4026 do:

    color()
    {
        actual=$(git config --get-color no.such.slot "$1") &&
        test "$actual" = "${2:+$ESC}$2"
    }

But that's certainly not great.

I'd say that the current behaviour is just a plain bug. In fact, there's
even two bugs:

  1. We set up the pager when asked to print color codes. This does not
     make any sense whatsoever, as these should never go to the pager
     but should always be printed to stdout directly.

  2. We don't recognize the special case where we have are asked for a
     color, have an empty key but a default value.

I'll send a patch series to fix these.

Patrick
