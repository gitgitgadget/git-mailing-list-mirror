Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A3023ABA1
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 07:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759907669; cv=none; b=bxUmBWtfHn0ele6znfi3Hyv6eHjvi4h4LtvkxSQ1HybMGqj2Rz47BATfzVMqgJYuRi5QhqYNq8F7jX2Rn3WNd5o92dKZVxO5w+549ON0egY9mP4SXd+4LzL7a0cZeumk/tl0D+ZpbPCB7B32y1Mv2lW9AWRn4nf9Lw5PpaFHKkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759907669; c=relaxed/simple;
	bh=TUyL/dH6yz0U6eZejDcph+0UG5AejDVjLZx0IMSE80w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LoTxQSnji7yiSMNe5RqMjaV6BC2tRUQskFUHpCNqLYMsChzeLP+kwzqWFTZcfWrFPVTHlo562BWzKW5IhIQHm40LoQztFpR8f8AakGbx+RLWk2y5/iBezaWqtf9s2rYrAacOVcytuzcUXK26czkKYBMuBwQoso14iM2vWp+fDEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KeMh7k1u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q9sbsn3F; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KeMh7k1u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q9sbsn3F"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AEACA7A0775;
	Wed,  8 Oct 2025 03:14:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 08 Oct 2025 03:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759907666; x=1759994066; bh=1fwEO0DdOM
	3PwzypWlJoHf7arkMtrE+DyQ7Y5TpODAo=; b=KeMh7k1ukTDGQl2U1CCGpiiioi
	+2OFyX88LSXuy5aqjj87TdD5nyGRrKb7cRuFdAd/J2v09SDtwFGmxGKvpvzp3A0N
	Z6jVyHyLivBNER9T8mgWoj3wnMWhdDCbiA3joyAxnewdtXGZAdsOvhE3Z7pdpXOs
	0EvsmocX698bVzWkh4h+801JTNICjQJvvpzipnFs7ZVAi1QVEknA3LCDW+BEheld
	SX4jddhjn/F2iE69wQ2UjSf8NHIObzumVJTWL0HrgNS5pK9/z2/HrfGM131RS73d
	/+hfEbWHlg2B/moLQVPsCcKUePmFbjZ/TlZPvzBeHQ4fuKopG69HeRrTNBHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759907666; x=1759994066; bh=1fwEO0DdOM3PwzypWlJoHf7arkMtrE+DyQ7
	Y5TpODAo=; b=q9sbsn3FEqdPESwo2kDKIOZu/gsVW50Mks6Vh3HCxinCgYrZKXc
	PHs/Jx0s5z6Bxjyl8Pjx/ne9np62iBAzzmh/GvQSp/1XYf9xCZWMUOcE/T36/Fr/
	0yTB5vJwTFJ0DrQl2Ed/p7h7j/Pjsp0lVfvb965SQFlXPmxWtmK5jECpTegYgNcJ
	Vl3YHexRZeCbgdwgi0kEDPXxUMQIWILx5eWODvDPXNVMbh4wXlaUNtBxJnoiBTuQ
	fTGeF3szWKKjo5h4VaF7AtbXxc/7BOjHR0WdXfCXp0gcfey4AY6JGMscmSKqhUAw
	IeCpaYSPtf5PajJnb8NWg3TXxS9SliSuEvw==
X-ME-Sender: <xms:Ug_maAiTqo3-fPjp6S-QQ3ZImnNO-H2JgTO-HFxqD-pwGhMhcu56Eg>
    <xme:Ug_maIHFgpvjFNMhf5L4swP3I1MZAx_qPPS9nyzlP_3OYA0872kxyL369S7_3OuMm
    xNIosftyvRvImuP0LS_1JynjWQpIL4bJuTteKtzhQCJQz10Iybk0w>
X-ME-Received: <xmr:Ug_maOS7mDgm_n_mSWWHCKkMvMZ3X9MKGDs6WtPDcpInsnnsReJmoqwfDJ8WbkUBVak5HPyZEVKOhpl2xqXwKUWmtGhlaVYj6LQGN0ah>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddvieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhstg
    hoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhs
    tghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:Ug_maNz177Sc7bIgNh2wMnCLGX9o4M8lUvuN2nyHKP_Wm1cgHUsfGw>
    <xmx:Ug_maCflHTieeHjiJNfPf1SOOWjInmQj9BwDX184ppnYfWc4zK2MQg>
    <xmx:Ug_maIOZR7ObHMqKPUhzlQF6Q5r9pvWuAmXRDAHOeNiB3Z-N2HbPTA>
    <xmx:Ug_maFtf70rORrg5Uh3LkvfGZwU792UTChUqJltWbkd4jhOath8UtA>
    <xmx:Ug_maM419P4887qV4I1SSnRyBEXxD53_nQr8XrlRSYHS114q0eDmpEaG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 03:14:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 005a3073 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 07:14:24 +0000 (UTC)
Date: Wed, 8 Oct 2025 09:14:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/5] lib-gpg: allow tests with the GPGSM prereq first
Message-ID: <aOYPTKG9t4ZB_Mbi@pks.im>
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251007122958.1089680-3-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007122958.1089680-3-christian.couder@gmail.com>

On Tue, Oct 07, 2025 at 02:29:55PM +0200, Christian Couder wrote:
> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> index 937b876bd0..743985efab 100644
> --- a/t/lib-gpg.sh
> +++ b/t/lib-gpg.sh
> @@ -38,7 +38,7 @@ test_lazy_prereq GPG '
>  		# To export ownertrust:
>  		#	gpg --homedir /tmp/gpghome --export-ownertrust \
>  		#		> lib-gpg/ownertrust
> -		mkdir "$GNUPGHOME" &&
> +		mkdir -p "$GNUPGHOME" &&
>  		chmod 0700 "$GNUPGHOME" &&
>  		(gpgconf --kill all || : ) &&
>  		gpg --homedir "${GNUPGHOME}" --import \

Okay. I wonder why we even have to create the directory manually. We
don't do it in the GPGSM prereq either, as gpgsm seems to handle this
for us. Doesn't `gpg --homedir ... --import` create the home directory
in a similar way?

Patrick
