Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C21123D2AB
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772825594; cv=none; b=GfpU3+feGzCtYyaQnjUwlg5gdxz1fC/RQqn20eRvvDjaQgwUXdk81xBbQLQFhHKL/RBSJYruzXbOArcZKFA1+fPvnUfN6jV24uXdt9CjZN192k4mMeO/C7OwAFf07WnOyr2TGX1DilGfXMQZGvdcla2+pNfaK8+WN4ANF/oilUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772825594; c=relaxed/simple;
	bh=fkB9SsyAHttJ5hHRsZn2Xq2FHLPRaB9ImZIaQLB38SY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rmE+K2E3onWQuE4MLWo3BmKZ0gI5jtSp4bQtibvXiGuifFVJj2vq6oDhMBPzDhUd4Y6BMY83c82S4/6QyyYuwoW7RIuQqVSjJJ2H+KAd5XZ/oiEEbghTxCL1LaZxmXVpd0gW3AwNYJ/LSy3aPAJLZSc9U6AlRP1lCPk3HAeIlT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LAjI9IUi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pDvmKvBt; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LAjI9IUi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pDvmKvBt"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A0A4C1400112;
	Fri,  6 Mar 2026 14:33:12 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 06 Mar 2026 14:33:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772825592; x=1772911992; bh=grtusCNxII
	OOdSUe2dmsFM3c4xfOQRizIQwNuKHsaeI=; b=LAjI9IUivINWd3LKtENAHnaGB4
	b10RiPjiiDj8/h2mlhjwiIld5Oq4ul0Z9dcd+w6GYEmr1YJ1vVd2S89sIWhlLWt4
	B3u630fEqG4ekz25tkYhnyUCDO9UH7fLKven0nDyWOw/MAJ5Ka4nb8gD/2Uhn055
	eXhgTOrmiKplQ0iHrjevIbXFRBY/89S9WSUkD09kFwinpi2w63t9aqbSyxSe5QIo
	vJhA9TMIdmQjBuvoFfBfB3DojBewm5NdkTCB5hraaR4vKHec/Jz4o0dICsBrdliI
	ablzDiRSyXBElEiSTSeu/k8m1IG2sjpLqY4J7+zjTWIFDBiCDLIwntHnOauw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772825592; x=1772911992; bh=grtusCNxIIOOdSUe2dmsFM3c4xfOQRizIQw
	NuKHsaeI=; b=pDvmKvBtl30kldTWF8BeZ9DWNSgwguTHr1xnaPe2sQkG6nHE9az
	7Knr7UEbB5jGN6loIISv4mmYbD8Zw2RVV68hqHwLHuCQ/Rbffc7KGhow0IUe7AkD
	KC43Sz9UxIQtyFF0xaPHvlMqmHSYYNIFOV1GRPV+vGEskJZiOoxPSPbPVlryni+z
	PALcZFAMwN5hSt4gUzAkRkrwGUTZMf0pBbq5pt0yP9TPfDsKvYtdWqU05jCNVSyT
	YBePT5qw/Faxmh5Dj7qltU0A4qZ8cD08rXNacxTLAnXrmNxS5jTiOfsE4jB1UGZM
	M1KQtpXtlE4ez2reEfYz/meBbvyDGPQBDBQ==
X-ME-Sender: <xms:9yuraXI29-IYKfFh5cYADYXnHhWtce8uxkE529XLHjgYHlpn9mlZKg>
    <xme:9yuradt6-P1qDbW35nKoOlJ7ceYWjndWahJFw7TJxlcHxU2RLSwLqkwekrYIdYp1r
    c90c4x2slylhh8jBxX0uAwRR5CUALwCORBYerX5h7bIxc0rnn4Y5O4>
X-ME-Received: <xmr:9yuraTXmLhSyDg6kYdCbgixzbf9lJc9zfPTb-cq7pas1-drmHGq8LFmMU7ymYc6wH_NQhphVGd1-kxt_o6vOHa-qol4hpbVhgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehpshesphhkshdrihhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghr
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheprghlrghnsegsrhgr
    ihhthhifrghithgvrdguvghvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:9yuraQhYNPdebn_eoPMknu348tcH27cL2VRrKfbez6NyjulxfE-2dA>
    <xmx:9yuraTrbQOEa87zmA5AhijL9vgjFL-WO7Fy7Oo34DmDGmQkshjqgUQ>
    <xmx:9yuraeEpraSkhJ4iKasdP1BKv42t-P6a0FQGpDHdKJ6-TKXiHs8stw>
    <xmx:9yuraQ73zTNBzvJcKnqIeC82dWaN8h2ZaHvrXEazG09Md0zQTZz9PQ>
    <xmx:-CuraQgSHC3EGaQjl-eOvxiVbPoqUnSPsccTj-BcwIxWUbehrMQWe1Eq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 14:33:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Alan Braithwaite via GitGitGadget <gitgitgadget@gmail.com>,
    git@vger.kernel.org,
    ps@pks.im,
    christian.couder@gmail.com,
    me@ttaylorr.com,
    Jeff King <peff@peff.net>,
    Alan Braithwaite <alan@braithwaite.dev>
Subject: Re: [PATCH v3] clone: add clone.<url>.defaultObjectFilter config
In-Reply-To: <aaqu44_sDJYcftWd@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Fri, 6 Mar 2026 10:39:31 +0000")
References: <pull.2058.v2.git.1772672251281.gitgitgadget@gmail.com>
	<pull.2058.v3.git.1772780113400.gitgitgadget@gmail.com>
	<aaqu44_sDJYcftWd@fruit.crustytoothpaste.net>
Date: Fri, 06 Mar 2026 11:33:10 -0800
Message-ID: <xmqq1phw21op.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> We've historically not implemented default filtering for clones because
> it makes it hard to reason about the behaviour of the clone command.
> For instance, if I have a script that clones a repository, it almost
> certainly expects a full clone unless it requested something else.
> ...
> We've traditionally placed this kind of customizable configuration into
> `scalar` instead, which is designed to be configurable and set options
> for large repositories that would want to control clone and fetch
> options.

Hmph, my knee-jerk reaction to the early part of your message was
"oh, but isn't clone a Porcelain (admittedly without corresponding
plumbing) whose defaults and end-user experiences are meant to be
updated from time to time to help users?" but I didn't realize that
we have another class, which is "scalar", these days that we can add
these settings to.  I do not have objections to add something to
"scalar", but I personally feel that the configuration for clone is
such a bad thing to have.

Do we have a way to defeat the configured filter to say "no
filtering, we want everything" from the command line?  If not, that
needs to be addressed, if we were to add this configuration.

Thanks.

