Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51DA14F70
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 07:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762415472; cv=none; b=oqSgXug5qKsB9iGWneEDzrWzBxWrxGDbI3ML45EKFIkO4nzVLr3XDfGya60qLQRZpb0DwuycgbqNLcSiN+3UYhCpdfW+lssvo0SP9LBArtIHG7DkqXJ/HUtpwRtgGdPbch8NTFv/Up1K+1exBtDwz9BCuT2Jk0DKDEt5cv1fY5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762415472; c=relaxed/simple;
	bh=NXPKqa4An5CSLVoucli0WNSHzUDHgHq9/4+MjExlqj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXs99fhjQaKHY1zVYunHWezSV08e0xvP914BOk2VFsEfmxU53haD6t36FgU23xso9U/BYpcFcN9q2sTFCysFcLtSjFVh6x/BHaJQS3G9QhwF5umI8evN7HfWf+5bKM5ID3ZHZ5sgX7GgBD8vT6TMx0B4FZPdRueYUwLhCwzWNs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HkiLrVLt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pyx1gqJe; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HkiLrVLt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pyx1gqJe"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D6F3E1400171;
	Thu,  6 Nov 2025 02:51:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 06 Nov 2025 02:51:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762415466; x=1762501866; bh=/UB4d6GaWq
	NSRcGryJKACV0l5rLMsiD1ePn+BdEmMTA=; b=HkiLrVLtUTdRp6BiLq2I7mlUNo
	2+hzNP8+zMLEHH9ieROo5l/qTPCHIF4Gt5dybcC8sK8rN3XN4EJYLfmWa0d7rpsg
	jYpPuZJtsqmnBxrs1zvlqzfiLTweYC2OpwURxykqfzpceRfvdNAH0gASdTflLcpj
	5atKfFFQuc9YpTPinvCOdBDrOL2IrQZY76JHumlY7WiHQ7FE7D7EFBeKlXff6OSM
	6a+vfi8bE8AvcC20BM+Mf1pKA/3hA5NisUHhc225AH/xYENr37uoWRj3rj4NiGMw
	vDunFNHFCTFUrPf0stamlWxdtQHt/aJOEgUdrcE4UIWMhAkFr1L/U4KQMp9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762415466; x=1762501866; bh=/UB4d6GaWqNSRcGryJKACV0l5rLMsiD1ePn
	+BdEmMTA=; b=Pyx1gqJeDDRWqfD5mPzTZAf3Bpi0IKuDYjx0c6jotPoerfcs2X/
	T16wJtYlX7zrQ+rontL/85STJygCy68Qs/bZV7rCXX3CtD5YuvMfwGFKEf6z9jUk
	iRiIvS3xD1sksuShCjD2T0IH5+NFN+faRCLcVj+OKHiifQfDjmrJnlcOO6gnGRRC
	SRpAsRdqOYMazFLhq2CJ11SbHcpfZqUcll1aaCiQmarQriYwSM1EIA2f2olpLMjp
	7vF1+x1ts0pDccouznW3CjyEPBfpCdBdumeGTgmyCiSVY+9yZb9BR8uudRdWGGJ6
	EoaVFowNKvD6/YNnQ0fjHHkBfjfJl6ZwOiA==
X-ME-Sender: <xms:alMMabi7VbUMigWz1zVKwmDdKHgUmKtvXj2xOQVfGaL9aFtdd830fA>
    <xme:alMMafD99jziqu3pG643GoD_aVGfTk_C1MAUKZwztOJm3CF4VEFPfOgsyi_tXlwmk
    _cG7yX1POJFwDD6y7jbQyQI61VhWyqYXwZwoJsoRHAi3uXFByXyvg>
X-ME-Received: <xmr:alMMaQHNeYTk4jCVRZD-utvG5qvGDyJimVlgX4ffI_evlHXp1eCH4OLILHXDPU9qgJbS23LzSLmTDkjTpv7Cbr_makXvy7DkpBXwdETGxIyO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeivddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhithhhuhgs
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhmiiesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:alMMaXI9F4qMqa5ZJ0ekwMQeDhV9srkappVpUb2H8yIXppEp8Lbb5Q>
    <xmx:alMMaUnLctvOI4_4vSoVLAHgVormTfv8k5KFjfrfrKB-o9JlUQZI4w>
    <xmx:alMMafRxZpY84rFoBe7Wo4VDABem4tYPawPqrRPVEusHC2PDpUM6hw>
    <xmx:alMMaWLQ2kCM2x3QF7GTnBaRYBVxOF5jPuk-N2wKZ-BTIBkSPc94mA>
    <xmx:alMMaXne3TzQARMcF8spGFe0zmRUqkc4aTi3CpSnUTW_D0WYfgk8Hqse>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 02:51:05 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3ca45031 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 6 Nov 2025 07:51:04 +0000 (UTC)
Date: Thu, 6 Nov 2025 08:51:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] meson: make GIT_HTML_PATH configurable
Message-ID: <aQxTZNYKKAsmL9Sg@pks.im>
References: <385992f6020703558f0ba75a1be6c4f9dae08b83.1762264709.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <385992f6020703558f0ba75a1be6c4f9dae08b83.1762264709.git.ben.knoble+github@gmail.com>

On Tue, Nov 04, 2025 at 08:58:29AM -0500, D. Ben Knoble wrote:
> Makefile-based builds can configure Git's internal HTML_PATH by defining
> htmldir, which is useful for packagers that put documentation in
> different locations. Gentoo, for example, uses version-suffixed
> directories like ${prefix}/share/doc/git-2.51 and puts the HTML
> documentation in an 'html' subdirectory of the same.
> 
> Propagate the same configuration knob to Meson-based builds so that
> "git --html-path" on such systems can be configured to output the
> correct directory.

Makes sense.

> diff --git a/Documentation/meson.build b/Documentation/meson.build
> index 9d24f2da54..c00c9fe7f4 100644
> --- a/Documentation/meson.build
> +++ b/Documentation/meson.build

All of the conversions look sensible to me.

> diff --git a/meson.build b/meson.build
> index 2b763f7c53..1f95a06edb 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -768,13 +768,18 @@ if test_output_directory == ''
>    test_output_directory = meson.project_build_root() / 'test-output'
>  endif
>  
> +htmldir = get_option('htmldir')
> +if htmldir == ''
> +  htmldir = get_option('datadir') / 'doc/git-doc'
> +endif

This retains the status quo, good.

> diff --git a/meson_options.txt b/meson_options.txt
> index 143dee9237..13d421c067 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -1,6 +1,8 @@
>  # Configuration for Git installation
>  option('perllibdir', type: 'string', value: '',
>    description: 'Directory to install perl lib to. Defaults to <datadir>/perl5')
> +option('htmldir', type: 'string', value: '',
> +  description: 'Directory to install HTML docs to. Defaults to <datadir>/doc/git-doc')

Tiny nit: let's keep these options ordered lexicographically.

Other than that the patch looks good to me, thanks!

Patrick
