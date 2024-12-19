Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C357082B
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 10:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734604520; cv=none; b=uj/kPgiju7SmfhsTcVw+lqgnepMHTsNBYUKUURpkGjNP8Osel/n83/gpXSsNVp1GjkYJ0n8Pr3bumbNwSl8fJLkDf9ridCuhxSWLpBoeDMTE2s2MgE+XjmSAJVXwzAzNKn2o2BY/3AcIiiDyZrXekWOtebA8CAaJ8pP+h/82M04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734604520; c=relaxed/simple;
	bh=WjLwpNmNWeVFzwKsah0nWdqC/3DMR2GaZ610KIWpW64=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KnHkJYst+TU+XKpY/xB4FS0i0vLcHxPnPVfaLitc000ehlLp3UsxHgJ0fLASaxvWP0tIjNx/PBKxZLacb9HDP+1g/QVFdLy5s+uXE2lEZqk/Hh9414K/WC7jtUS5/ZTeVjh07N2nBsFMIws14QOeOww5RLVyC6i14Wt+U+6ZVdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N3I1QgKF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C2wiQMkQ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N3I1QgKF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C2wiQMkQ"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2A25D114015C;
	Thu, 19 Dec 2024 05:35:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 19 Dec 2024 05:35:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734604516; x=1734690916; bh=OKuSPfFA3j
	37JsXhQVHEchxM8THq1tzCzjLb0+ptZkg=; b=N3I1QgKF6lIuurodrE6VaCX5WW
	skA+VmYUKsxN20Pz2DY6j6BSfbdaTSlv5NhCbGUcU2/CK7tAaVtJu2QhCybLbAiP
	KEOAV2nzUxwFwShJzpy5Z58wXg2APu73QGnhV0zI8aZaOKdMS9U4M4Q25J5+wi35
	6zmMm634tFi4ocjydH80m8kxP8qrV/QbcbGqhg5Se0nfxp0BY4lCoY8R7mfJMUdu
	pc7vdggBcIDth51PGrfhMITm50Fj0ExDOq7e6EsY8u1HAjq6OYRxR18L47dxqqY1
	5fhtZJnockeDE1Bh9BNIDGRP5c/W4Du5rqV2uPHyO+kHOz2gxsmdbsC84hpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734604516; x=1734690916; bh=OKuSPfFA3j37JsXhQVHEchxM8THq1tzCzjL
	b0+ptZkg=; b=C2wiQMkQrfK8Jp9Y7aC9a9S+k55j9WpYVgFqGR6hOlhPkDhZcRd
	xUPo0MwcXMk8eyJxISGqxiuF3VTuT1UOBe5HPWT1Z1+xRhXsRIly7elpZgO6WDSP
	iOBEvbdYXAMBvgdGJAVDXK21jCQNp5e2FcS6LSm5mkgPZkYefdLXL7sRDsDS2oD3
	/g4mhB3l6P/ulsqZ1CPk+qsx1KAW1KsEhkj8L3+9udWP0F/LycHXSHSpROsyJxBm
	uIdvnHYZUS+0y+sg0LRtEnp1xbFZOxqgwxIBDojHTD3fVoxnH/2qtzKi4FaKsZ7m
	KQM0uw+GCCceVOViOZfKScHAQwsYeoQTrIw==
X-ME-Sender: <xms:4_ZjZ9ByeftHop4fCnQWRq4dig7bcI7UOlXC8LOvlivI4zi9jD0udQ>
    <xme:4_ZjZ7jekq-tbZ8qPgQscvhOPiq-r9jfQUuH01qtk8rfSPgjbcfDch2nkScIIQWt7
    N81Re-FMdKlCXNwBg>
X-ME-Received: <xmr:4_ZjZ4l8oo6ug463Uoa-cwXxL5wOU6XoRPYn1B9ERu_Ipq10wBlfOanW9aCX6f7xGttIw76h_lwWO8bZBGv4eBy1tlzi2MsFzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddttddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegushhimhhitgesmhgrnhhjrghrohdrohhrghdprhgtph
    htthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheplhdrshdrrhesfigvsgdr
    uggvpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgfhhunhhnihdvfeegsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ughorhgvmhihlhhovhgvrhduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:4_ZjZ3yIQZieaxoYS3pdIx7IBcnSy4AOr0roI4tfUIeFsCMeZjK1Tg>
    <xmx:4_ZjZyRJGkvjzoZLvExdMi2nUeYRihrIwsIFRRvUC9gRSU2Opj4zsw>
    <xmx:4_ZjZ6YY_r2hqZ6ADZm_TzC5lIvhuhGekLoC6vGyp9b6f_Q7RGO0vQ>
    <xmx:4_ZjZzQ0-06bxr1OODEiEsYGdyvUg00k7XCfSiwjSWh3aT4AVNUq6w>
    <xmx:5PZjZz_A-aB76-anr8A5GxjlpZmGElUJU3j8kvr13n5bgxaHH5hymmHj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Dec 2024 05:35:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Dragan Simic <dsimic@manjaro.org>,  Jeff King
 <peff@peff.net>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Phillip
 Wood
 <phillip.wood123@gmail.com>,  AreaZR <gfunni234@gmail.com>,  Seija Kijin
 <doremylover123@gmail.com>
Subject: Re: [PATCH v6] git: use logical-not operator to toggle between 0 and 1
In-Reply-To: <pull.1620.v6.git.git.1734541037465.gitgitgadget@gmail.com>
	(AreaZR via GitGitGadget's message of "Wed, 18 Dec 2024 16:57:17
	+0000")
References: <pull.1620.v5.git.git.1734540395021.gitgitgadget@gmail.com>
	<pull.1620.v6.git.git.1734541037465.gitgitgadget@gmail.com>
Date: Thu, 19 Dec 2024 02:35:13 -0800
Message-ID: <xmqqttb0m04e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"AreaZR via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Seija Kijin <doremylover123@gmail.com>
>
> If it is known that an int is either 1 or 0,

This justification needs to be updated.

The point of using flip = !flip pattern is not that you do not
assume "1 or 0", but follow "zero or non-zero", which is more
idiomatic in C.

Other than that, 

>       -				flipped_block = (flipped_block + 1) % 2;
>      -+				flipped_block ^= 1;
>      ++				flipped_block = !flipped_block;

it indeed is a good change to avoid modulo-2 like this.

Thanks.

