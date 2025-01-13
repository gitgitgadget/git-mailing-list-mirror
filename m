Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35088233153
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 08:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736756826; cv=none; b=aDHQJmd/OpsA4kW4ZS8kaUC6gL/SzGaclRf77xhOomAoykso5ICw5qg5CYjc84rN/Dpn56vKUaS67iJ04Z+6Reb6XcNIf66sQE0WWHMLO653kmIBEV6FUWMg3t1xGhXD38x8BKvbg9x1WPLnvSjwhUs1vzgyPUPnuyNkn9UvzEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736756826; c=relaxed/simple;
	bh=i6OC2e5IbfjD/rueNiteIZNj0FOaf7Y9Tobhrp89Gwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gi0lG+BIV+ujlhkznn3CEkHJkSjbEeAYMVJ10kilndVIZkWIIXveVgZ3EN1Zp/aSLvn9nflAIB3OfISNEauRHEzDuVHFP7WiXwjmHuoQj3eS4+mnsYdhghPUYHotzjJMYUe6mLGa9eGxrF3MF+fu3KcA5aC3k7qsbEV5SxaT7qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VQ8vnSPT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xor5d99/; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VQ8vnSPT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xor5d99/"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 514E32540168;
	Mon, 13 Jan 2025 03:27:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 13 Jan 2025 03:27:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736756823; x=1736843223; bh=43sAyfBKpn
	X9CLbwQGNcfekNLG8lBQ+lQDarsV88oPI=; b=VQ8vnSPT7wJyaADeEr7AfQO58i
	LSqSYRR2bLUg437dfywPYem5jmsBXFcFlldPzNyIzRAYXLLlyV6cn/01xdGDtt6j
	O/KRDFieUhWpEs8LmTq9JIBlmgyW6hclynGKi7yVaFOvRiI+0QL2k9dUk0j3HVmh
	hKLX1FUdcMPk6Fqv0wXnqy3ptcL72DV4WnS/D5sCGgPrrCcgwvGHTd/mr8rnCjHU
	NbIAs2UByk6eA61P2K8aoGTga4bfhfK1U5P15vNAl0tCyRBgfQj4+XkgVbNHyHSV
	hS8r6yhqUqCHWd7mIe6N75uI+JD4WT/Mug23ZOaAl0Y1PG4pajPfVLoRNsgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736756823; x=1736843223; bh=43sAyfBKpnX9CLbwQGNcfekNLG8lBQ+lQDa
	rsV88oPI=; b=Xor5d99/wPqyJAB0Br61aFo7f6TJo2YvkhcECiCwnp9J3krToYS
	yzkUPrAdxvi7hMdAiw42gkGYf+5uBrJFOX41EuCz/mBSg2l922AGQiIx8DVO9Mn0
	vyhsEOkjKO38MsLoTZv+KZ/vc3MuoBVm0niD3YKxVmJFXJgItexSia2rO6ivIPfr
	fxNp0E6Q5FgQJd7Wh9HdFmxMozUDt4ZGKLLoNX9U6mf4Jif1Qre2teR0Ty5751nE
	d3I3bZNbD50wgNvyvn6wnXrQ8oevspobBbv7TwXZHsSPuEBZM54r/zCf0S4IdMYI
	6y8P3ccUW2GIkcdMdjzbiJYcTZ2fx8+K9/A==
X-ME-Sender: <xms:Vs6EZ249FuDnlWHPi6hYwdvEhWcYJi1sDBeJR1ISkDyNEtB3CtJUdg>
    <xme:Vs6EZ_4XB7KkKnJ6HR_8Ss8WxAjDjTwBUal86vKRK20R-Vtmec0iAEvnShJy4O1xd
    Uf7_e-5kghTRaydaQ>
X-ME-Received: <xmr:Vs6EZ1fDG4bG_6wNEH-rsqDt8smkmg7g_WxCXUaMqNRMJwzCksfpBKlvlYb8Dj3908eCXdQ_8iIqPeTI6qllXN1F39uNIVo7XqWGeb6672IHP5aO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehfedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsrghmsehgvghnthhoohdrohhrghdprhgtphhtth
    hopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Vs6EZzLCadZe1glTQWL0MKUURi5Sci_VkyzW_dTrDCeu3PeawgJJxw>
    <xmx:Vs6EZ6Jf3O1FeMGT1FHXGz2lyrji0KgByQXmyPWKE2hCN2vi2GaLhg>
    <xmx:Vs6EZ0zg_mr9k0wDUUcShyA4Om-ia2-Tpq-ot8rHoZllNOBxwVGSnw>
    <xmx:Vs6EZ-JZt6xXyzJjCocjGMetyoy8bSck5VTYQ7J135VxkhI_B48MtQ>
    <xmx:V86EZ22DzpxnkIwpsXxJ4DKVbJa5tUJ_m4OZRSyeUW25VeA4abypGbW->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 03:27:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c8dcd1de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jan 2025 08:27:00 +0000 (UTC)
Date: Mon, 13 Jan 2025 09:26:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Sam James <sam@gentoo.org>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH] meson: fix perl dependencies for Documentation
Message-ID: <Z4TOTVZbDlxh4Uuy@pks.im>
References: <79de1bcf31f708960a889066ce3d986e55155ad8.1736577530.git.sam@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79de1bcf31f708960a889066ce3d986e55155ad8.1736577530.git.sam@gentoo.org>

On Sat, Jan 11, 2025 at 06:38:50AM +0000, Sam James wrote:
> diff --git a/Documentation/technical/meson.build b/Documentation/technical/meson.build
> index 21dfb8b5c9..8c93da3566 100644
> --- a/Documentation/technical/meson.build
> +++ b/Documentation/technical/meson.build
> @@ -42,6 +42,7 @@ api_index = custom_target(
>      '@OUTPUT@',
>    ],
>    env: script_environment,
> +  depends: documentation_deps,
>    input: api_docs,
>    output: 'api-index.txt',
>  )

Wait, this doesn't make a lot of sense to me. "api-index.sh" does not
care about "asciidoc.conf" at all, so why is this dependency needed?

> @@ -60,6 +61,7 @@ foreach article : api_docs + articles
>      command: asciidoc_html_options,
>      input: article,
>      output: fs.stem(article) + '.html',
> +    depends: documentation_deps,
>      install: true,
>      install_dir: get_option('datadir') / 'doc/git-doc/technical',
>    )

This one looks as expected, though.

Thanks!

Patrick
