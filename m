Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E16128468C
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751467615; cv=none; b=jVhuG7Sg3egxzZ3SbpzfxekL9Jzu8Lhgld/5CNTI6rZ6Sz1fbf2/cOBmmfRYkRVe98C3+6JLDeoe8Oo0CHpzxLyE1WNMfDrtdFE05FRVKBvqJll6Qftp5BbYnLtFcZLx87HU7OCLNPJLR2xV6QiIH9tJqylneD7miaahiC+07tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751467615; c=relaxed/simple;
	bh=AVz/HKMYg84Mt3Zfugn+o13f6LGF5/w/qv224E4yrmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiFAyMhzOBeDa99HEjKKX2R2tD7dpMqASmNIjryI007cCpM7LGpnsZ0EeqOuG01MrQ1w8Ky8hrdphWTIo7mj9ms9T3qE6SX7Jj/DeazwXiNEKwbC750kj5lrm1GtAZxB8m6jxY9ftv6Rh1+ez+3mWTspw4zglWVSvNtrieQA6os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U00j4d0B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lFYyYd2o; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U00j4d0B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lFYyYd2o"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C8CEA7A0285;
	Wed,  2 Jul 2025 10:46:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 02 Jul 2025 10:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751467611; x=1751554011; bh=+zRJxtmDqV
	IvyX4zzX5JcUy9HI3ncZkCg2oe5drbI5k=; b=U00j4d0B3POkSUTab6meBHD+CM
	7og/mrt8TksEFRXj9tXNluC+eG5zb1DQWJHEgjdjzMLNGw5ldSJ4IONYYh++P1e4
	3U093CVYWx539ydoC2G7JnHhSV9FBF0Xbr1oeWUAHdCj1XA1H5yMJdyy64VkzJX6
	yh3Z/RXab6CxFX/UBlmAb8X22tWaVH000LdHaSpTFHlqxwZWUi2cL60pTWVHgyuh
	6GoezQPIKhVYEVuwoDPusFSgvttZDdB6juJQMpM3jZlNsXGcHb8SYkLP0a5wby6D
	DwEPwTvcXzTU4C9lS0UoxmBaGdfXOFRlvKAarx2jQOU3jMZKeXkwWe0SzXhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751467611; x=1751554011; bh=+zRJxtmDqVIvyX4zzX5JcUy9HI3ncZkCg2o
	e5drbI5k=; b=lFYyYd2oggDR+E/pPGSo9xBQBDTrWhylLcPfKh+wncmcuMh1hdl
	amsH+FS2IWTN6dlW8k28Lz3sfz1JaKpclowIhdEPiGIvGKCxCQ/Ecgq5wT0ICbXR
	s2iD8MTc7a6pl90rJO3X5Mb7J7NSa3eiMa2vgIgYBxq5Zul04TgVvXu6tGcZezAk
	P9WC7IuitiBY4cR3FLG8Zg3GFnvXbmUR+cfbQN4I3lnvyn70wUyFlWUvUNVdIzeQ
	VEuBsJC2AuVUPU88I5BCNwHYgZv6bDopBLtVcIRsTSuOez+xyW6F7ZxoIEp4OLaQ
	WbJyQlXCsNMHaF3PJsY6vkvwFEYFvygNJbw==
X-ME-Sender: <xms:W0ZlaGXULQoraG8VDGyHNu5orsBZ1oocpmXs7oQOGNman7r-0lfWqQ>
    <xme:W0ZlaClJaC2-hN4s6vTD4k7KSc9kNfTZJ93Ydxb26h-Yd9_4FMIeLjQITEsaVf8dc
    _r6ps6IYEaAH6khwg>
X-ME-Received: <xmr:W0ZlaKZUTv7kEGnjOni-uK61C3so0_Fy6p-hd_sSwPb5nLxt63OO9GbKAmYrGhkj7Yl1DiqPq8SL6gxjg2s5Zoe4bWZsaqS4a-adot_1XA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsh
    grnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:W0ZlaNWaUukyqrY0Hp52ZePgQz8DxyUNjFQNRr3K_YUnon0ABS3AsQ>
    <xmx:W0ZlaAkP5z1ziJThZXJ7-UNcgy6tN-Toq5RlEWpi9Mp237QjQpmE5A>
    <xmx:W0ZlaCcZFh4np6S8M96Ri5orVqXCGDE_tZ3glSFlaIJCpe2oWyUVwQ>
    <xmx:W0ZlaCFRkx6mTRQdkWiFpEDW4mYWSSu5UfXa6OB3ul0axzke48Pk2g>
    <xmx:W0ZlaIt_GaEKjgHwtls2oNuLTG0zBTMX3vw65GRgl4MyE6MJCQJ4yYQL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Jul 2025 10:46:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ea3423b2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 2 Jul 2025 14:46:48 +0000 (UTC)
Date: Wed, 2 Jul 2025 16:46:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/11] Add SHA-256 by default as a breaking change
Message-ID: <aGVGVIryDXD576iG@pks.im>
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
 <20250701212237.766774-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701212237.766774-1-sandals@crustytoothpaste.net>

On Tue, Jul 01, 2025 at 09:22:26PM +0000, brian m. carlson wrote:
> Our breaking changes document outlines that Git 3.0 will make SHA-256
> the default hash algorithm, which is a sensible and prudent approach,
> especially from a security perspective.  However, we haven't tested this
> adequately and it would be helpful to allow users to test this behaviour
> so their code and environments are ready for it.
> 
> Fortunately, c5bc9a7f94 (Makefile: wire up build option for deprecated
> features, 2025-01-22) introduces a build option that we can use for
> testing breaking changes: WITH_BREAKING_CHANGES.  This series introduces
> functionality for SHA-256 by default in this mode so we can test it out.
> 
> Changes since v1:
> * Add a build option for the default hash and use it in the tests.
> * Rename GIT_HASH_ORIGINAL to GIT_HASH_SHA1_LEGACY.
> * Improve some of the commit messages to better explain questions that
>   have come up for review.
> * Improve formatting of nested C preprocessor directives.

I looked specifically for the things that I commented on, all of which
seem to have been addressed. Given that there is no range diff I trust
that there aren't any other unexpected changes.

So this iteration looks good to me, and I think that this series is a
step into the right direction overall.

Patrick
