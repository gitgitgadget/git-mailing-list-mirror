Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEC2383
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 00:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728432074; cv=none; b=QZDaZj2C1UzGZjki4qjQruD2qJCKTa55zAOUa2b+ogfbPSvBn1O/BUs7NAAD6TB4tM2dSUad5YlTjihG9kRFpqEyNYY7G4iYeCxfco2JMI/6hZUXK7lEaJATMy4Ra6w2LCOMYhADZW4KguNKTAqf+nvv82bbi05AzWFszDjoh+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728432074; c=relaxed/simple;
	bh=ZBHArMRkYntJzx2Q1WONRzA/KIMk+1RbE2pc+8jpwhc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JCBgDc6uT8TL7xl7olBOJvuop01U2ZjIqQmqlBSN156pfp5Www5X/3FRejTXEz32wpK4tA5B62LiZvhVf3QtPscGlU280AQd4x+gbtz0dWm32xKQTPtfv/pzHkkcNV+S7ZBgFGAAyuqjTCHQ30lUiDSZun1zI+Bc2+47KS6wBjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nB9PDYVH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qhfh6N8F; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nB9PDYVH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qhfh6N8F"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 1E9DC13802B6;
	Tue,  8 Oct 2024 20:01:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 08 Oct 2024 20:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728432070; x=1728518470; bh=euak8S7bGZ
	yyzpAeqtJ63w8OBUgbilL5P7hXjNxbePA=; b=nB9PDYVHdF5kZUqWOJ97+gAjdu
	0HpOgmPLqrFis9bnD3GfdpFD2zzmYjiNM9VTbQWIjiQ/IV/FWfQAbdl+k7aM5DQk
	sXOGgaE3FihxMy/1irkrD+3msCiTK8NcP2e3EsmvX0Zb3KiCWuvPnycmPb7vz3qu
	Ok6P+8Lk+pbhJdkoSQyhdH1kTCwrHFCQSmDmaHkO3HBgYHxwhz8+L7fHTeqLKuLO
	Pr6f/qBWDCqkfKBol7e+T98Q7s0XRlLjRYi2514YKhxMcCjuOU/0nv1CUpVfcV/p
	T6ioFD+/MrGjUyWm+kDe7hYvM8/OpOvPSPg+ku8i/T/7AsYpLYafuV4Vgk0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728432070; x=1728518470; bh=euak8S7bGZyyzpAeqtJ63w8OBUgb
	ilL5P7hXjNxbePA=; b=Qhfh6N8FUc6t65CU0kd58IQMOWOcT/EdQT50hNkKDB1+
	bql6duObEKGykAzCCOFBhvC0vb1nvaum/uoSsMPOIlI5qseuEPyRXN2j84j3R+uw
	WWViV/GomlvX0EPxJe3CLMreNsCuq9L8GukgPix7JxuQGt3aHA+eASYZSmi5PMtF
	MM55vyEiVhwfjxGSNtBreQ2RIjK3KOje8VFOhqvqE3ZhAFYd0rLdeJBFMz7EwgLR
	Vrb8TS+L9dfsnADwEvZJyl3HurE1I4etgKmwR5O9MgFvGbOBwOU9NrCKwqhPhXkA
	TgrGPjd2TZpcwn6bU4NuqslCI6zMVroFBfs6f8EfQg==
X-ME-Sender: <xms:xccFZw4OAjbErZDfrXG9h3ngRoBGVZ1RHD-3YmfYI0cNemw461tLMA>
    <xme:xccFZx6sXjiyt6wdiIfDYfNKa-qHzVkOS_4uKMHiqIY4dj6tehd9dGNSvwWRLodvX
    S9LYeXgAT56QPobrw>
X-ME-Received: <xmr:xccFZ_eU-rX_7-M9QN0RFcjXouyd8J4A-G1mLd0mEF-ug8lO0yVqIWw2nlK8YRxdEPN55MjvoKOB54OBlOgK05B6TBFnUFCgT8l5cJs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefvddgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvrggumhhonh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomhdprhgtph
    htthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvghmihhl
    hihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopegvmhhrrghsshesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepmhhhsehglhgrnhguihhumhdrohhrghdprhgt
    phhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprh
    gtphhtthhopehpshesphhkshdrihhm
X-ME-Proxy: <xmx:xccFZ1LDHmhH0pNffYOYZt2U7spjztsIqU6USwUylfx87QeYy5HO0g>
    <xmx:xccFZ0KacGCceDnl2cVVtmT0Zg8s8JdMY8qTjceEMuaVHoG6vZC1dQ>
    <xmx:xccFZ2yWRyyH7TSVa8KNGIa00kotyGHypmIlRyPrr5qSHK3MY717iQ>
    <xmx:xccFZ4KlzfHKYKn6rSoAMHnm3w8pyRQW7ehRBirwIMwKLjKVJQiqrg>
    <xmx:xscFZ2jl1QwOgNsjmoipuva0CLlXHLpxXOE7hGeCtFsjWKadM3rKW8mu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 20:01:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  calvinwan@google.com,  spectral@google.com,
  emilyshaffer@google.com,  emrass@google.com,  mh@glandium.org,
  sandals@crustytoothpaste.net,  ps@pks.im,  sunshine@sunshineco.com,
  phillip.wood123@gmail.com,  allred.sean@gmail.com
Subject: Re: [PATCH v4 5/5] Makefile: add option to build and test libgit-rs
 and libgit-rs-sys
In-Reply-To: <2ed503216f8e14d7b516c488caf3c76ffcb15697.1728429158.git.steadmon@google.com>
	(Josh Steadmon's message of "Tue, 8 Oct 2024 16:19:35 -0700")
References: <cover.1723054623.git.steadmon@google.com>
	<cover.1728429158.git.steadmon@google.com>
	<2ed503216f8e14d7b516c488caf3c76ffcb15697.1728429158.git.steadmon@google.com>
Date: Tue, 08 Oct 2024 17:01:07 -0700
Message-ID: <xmqq7caixhz0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josh Steadmon <steadmon@google.com> writes:

> From: Calvin Wan <calvinwan@google.com>
>
> Add libgitrs, libgitrs-sys, libgitrs-test, and libgitrs-sys-test targets
> to their respective Makefiles so they can be built and tested without
> having to run cargo build/test.
>
> Add environment variable, INCLUDE_LIBGIT_RS, that when set,
> automatically builds and tests libgit-rs and libgit-rs-sys when `make
> all` is ran.
>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  Makefile   | 16 ++++++++++++++++
>  t/Makefile | 16 ++++++++++++++++
>  2 files changed, 32 insertions(+)

Interesting.

I tried

	$ make INCLUDE_LIBGIT_RS=YesPlease

which did not fail, and then did the same

	$ make INCLUDE_LIBGIT_RS=YesPlease

and was surprised to see that not only the libgit-sys part but
everything was recompiled and rebuilt.

> diff --git a/Makefile b/Makefile
> ...
> +.PHONY: libgitrs
> +libgitrs:
> +	$(QUIET)(\
> +		cd contrib/libgit-rs && \
> +		cargo build \
> +	)
> +ifdef INCLUDE_LIBGIT_RS
> +all:: libgitrs
> +endif
> +
>  contrib/libgit-rs/libgit-sys/partial_symbol_export.o: contrib/libgit-rs/libgit-sys/public_symbol_export.o libgit.a reftable/libreftable.a xdiff/lib.a
>  	$(LD) -r $^ -o $@

I can see libgitrs is a phony target designed to run every time it
gets triggered, and I would imagine "cargo build" itself would avoid
repeating unnecessary work, but I do not see this patch screwing up
with the dependencies for other object files.

Is it fair to say this is still a WIP?  Showing a WIP to others and
asking for help is OK, but it is fair to make sure that others know
what is expected of them.

Thanks.
