Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9395714286
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760078964; cv=none; b=tRv38hz/Wh+DUeEh1tbfLTyQTseQ5vpVA6HwnrC5tpDe7W7IEYmRXxZyaMp+lH6xNvEr6nvwZNLBuij2A0PEIeA2IAofoleMEtu5R1fY/W09Oi+T6GoLPxf5GSVloYRKKH/JHSkunoyhk0CtvUe+1BmkIHIC/HrMGAg7mtp8V0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760078964; c=relaxed/simple;
	bh=ggGZZ4YDKLODauQtBJQwW0DU4TeIdwDZ015yLAhOTEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnRvvvpa85YXDV3KzcHIiV5pXUEvlEhQCkX5fUQdreA6TUXSh87zksMAhzkF25lgFOS4bX0XU5b/Sa1j2F/0/Qvr9/KLdWsGuW91uRVP2Y8l08tbofryZdS2Z5cBzIrBO3xjTlkRCppEQWBGSn/xDkPMq83YXsC572WERrFuwe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eRQnmVU6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MM0qJWRz; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eRQnmVU6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MM0qJWRz"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ABA7B14001DC;
	Fri, 10 Oct 2025 02:49:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 10 Oct 2025 02:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760078961; x=1760165361; bh=vQvsj4recZ
	0ekv4HX+377a8QLHeZC5PKNVorRjpLexY=; b=eRQnmVU69vS9tP8ruw+RGRzor/
	JM122z0xeWVrZ0KOmcaxDA9zHVARQyHqZUpXnbe5kW98R0C+0sE4nsJNrktmGhfr
	iGs+8qhXSLf/LIh0N5qze20XFkVrJxosPycPy3rFgS1WaZpljR0ECAfrfs3O6EB0
	Nj4qIbBPe/hNBSI6Dr7L5yUEU8cCKAhQlTltE3Gacy+SYQFobf5/SFmj5pv8nLWW
	eYkniRVotOr74AkP2r2VMe8IgkbJcpg+B8SubrkdwrLxHPZ6xVeuGKRaRCWmmCNV
	3P2Ygjgzit6gca7pMWwARr0EQRzMpuolaMUBZCX93Gf/FcK1Ql4U7BRb/BoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760078961; x=1760165361; bh=vQvsj4recZ0ekv4HX+377a8QLHeZC5PKNVo
	rRjpLexY=; b=MM0qJWRzdxleeRH0oLjJPF5N6Qm9c9qAh467ys6fcuG66wtLoUI
	vYTFjQ7sxSPmPg3zz2zxsu2e4IMff27BJkikrERZOaKqoznpe8Vkm0pV085BpUs7
	oAaj2BUfOT84ghucRPuNNu0FRi6ydceeSE689FqeJJ65wLfxsZCa4UwNIB7xkLqM
	G8csgYbhhht/HJmoO3zS455gGIHH1JAmjK6BtcOKCCvskx5rijz6zyK9s/XFI8oL
	yKur9JexnQ9+1fngNACHkzgY+4Vv5OlqFouvFj7w/JyqQ5uzVq11heIFU1RaZgw+
	W5dYX90roQPpFrGmjVoj3oUZFu4a/JyyJ+g==
X-ME-Sender: <xms:cazoaEnSeV6kcdKW407wiGRwqYt-b9E_CDARDp1Mgza_F0KGvJD4Rw>
    <xme:cazoaAYG5E0xo-qSSoNROJlZA7ZzUiOU6xqWhjZjLYNHLgktrnGejru7vr0loq_GI
    FfB5MXSLMQ3bbItoozHv1S1TdUda6ojh82mrQBpZgI_DoJlR9-0REo>
X-ME-Received: <xmr:cazoaHEtrjwk_n3r7QsTdN420wpX87JtDjdunaGaH-2Ok3gM_Vd-uYIRSvzrA4N1SX8EQx5xYmKbNAgcTP5G3tizOfL5WElF9WRqDWOkUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjeevudeggfffffeigeethffgieekveeffeehvedvgeeiteegueejleeihfeitdeunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedu
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprh
    gtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestg
    hruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvg
    hlihhnsehgmhigrdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:cazoaHbgnWUUms_fqAKTT7B54ojZIDzPxPT8lALLpJcaw5SNGniaJQ>
    <xmx:cazoaDxuyLiyHaxLHcGW2SQVLxevo_UJJKtB9SBVb05L7GRM-FKSlA>
    <xmx:cazoaBRPs0AiVL3gEsM3CoMzAe_Qc7cWis6zwIvDUwJeYZ3J3aPQpA>
    <xmx:cazoaIIMlXd0S8nCHoomaodEYyJ1BrLDTxwACjyF73KXltCu7z6KEA>
    <xmx:cazoaBzFy66dKdvsTnBJFWr0-3FcOakBKjuzmA1vnjPHV_bsb3eFD8cl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 02:49:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e5b7e8de (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 10 Oct 2025 06:49:17 +0000 (UTC)
Date: Fri, 10 Oct 2025 08:49:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Todd Zullinger <tmz@pobox.com>,
	Collin Funk <collin.funk1@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 2/5] lib-gpg: allow tests with GPGSM or GPGSSH prereq
 first
Message-ID: <aOisaq-rSdwjwo6b@pks.im>
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251009122457.1273701-1-christian.couder@gmail.com>
 <20251009122457.1273701-3-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009122457.1273701-3-christian.couder@gmail.com>

On Thu, Oct 09, 2025 at 02:24:54PM +0200, Christian Couder wrote:
> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> index 937b876bd0..b99ae39a06 100644
> --- a/t/lib-gpg.sh
> +++ b/t/lib-gpg.sh
> @@ -9,6 +9,16 @@
> @@ -63,6 +72,14 @@ test_lazy_prereq GPG2 '
>  		;;
>  	*)
>  		(gpgconf --kill all || : ) &&
> +
> +		# NEEDSWORK: prepare_gnupghome() should definitely be
> +		# called here, but it looks like it exposes a
> +		# pre-existing, hidden bug by allowing some tests in
> +		# t1016-compatObjectFormat.sh to run instead of being
> +		# skipped. See:
> +		# https://lore.kernel.org/git/ZoV8b2RvYxLOotSJ@teonanacatl.net/
> +
>  		gpg --homedir "${GNUPGHOME}" --import \
>  			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
>  		gpg --homedir "${GNUPGHOME}" --import-ownertrust \

Interesting. So I assume that these gpg commands here fail because the
GPG home doesn't exist, and thus we disable the prereq? Too bad, but I
agree that this doesn't necessarily have to be fixed by this patch
series.

The remaining patches look good to me and address my feedback, thanks!

Patrick
