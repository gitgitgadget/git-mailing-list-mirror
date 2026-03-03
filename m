Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D1F351C12
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772557534; cv=none; b=Hilt1AIWOYu9Kud9qQOI6lqMPf38g2ovooZoYhrUgf0CVIv+kY6J9GN2N6LkubKA1m2zG5wp5JCh0TUQxMVYuby3thyeuU934mvyLziBvA6oToyA0mtajVipdSWqJekFmpZK5BxyS9AXla+3Jj37v+1IhNWsnA4TaLw/tuM+C8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772557534; c=relaxed/simple;
	bh=ca+SnE+yh/FPyDwTZN2Xgu+y2Rs9ZD1D6t0IU8ksI1w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fdvGwcvELH0W2OLcpAcDi6Kfr8CD22PGObf/lLYT1j0kZlBWj9qbE0Cs58PoCH4gNiCF4jNEYNvmNeDm4cYO3Z9P3LA3EHVIEKolj+HmwigQwzRKIhroXfffHJBdvEx+Nr8xvG2qe0CzjhcQAPFJbmfmzX7CZ9maENAWrBj7yek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k4n0II3d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z4J/+M9R; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k4n0II3d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z4J/+M9R"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 4E65FEC0625;
	Tue,  3 Mar 2026 12:05:32 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 03 Mar 2026 12:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772557532; x=1772643932; bh=rW6Splqoep
	3o2I7O5UswqAS0JfrCmYkf//mvY5PbNSo=; b=k4n0II3dTfVUpFGFhVV+xU0WKJ
	0xODZG4Gx0K+2YVxtFuiOMwlt1WoRlLLCpWd1ICoSDnCfcP6s8A06TD+xcZ5qoe6
	QIzQH8CTUbfb8e0MnQD5hcCVDBU5AomJ2ffUAyw3Uhdf2vN72nNH7ISBem8dKC6M
	tFClAez0id34CPRyWBPPw9lNnzlF30t861+SpTz26uSgI0A+uLqv7JVzSj6sjeoG
	H8lg8M7pAXqSTd9juZzA0E3nwDdhEIu+qWEErAvP5ptZOVPbj72FzpKoSdDWBrKD
	YRNF4zbBel39NFMjfCM9bslWs0uKJD+U8ZaKxsS5aILbwpsU2hB2MX6/Hudw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772557532; x=1772643932; bh=rW6Splqoep3o2I7O5UswqAS0JfrCmYkf//m
	vY5PbNSo=; b=Z4J/+M9RKwCOHul61H8qGM6IxhgE0kGF3usvkrx0ErKIHJPXkvy
	tQ/wtS1jNDU1fEk7sLoCmCgkWzh9B7kaFEdPirykP5nNU54fSorFHVeUfIo+jZNE
	NPFAo0AM96BA2ByDOPuM/1uJc1fKUY/shteFG/izeuoWJWqeYdmV9nyIUbwq0Fnw
	zyCPBsJZdGD4nYtpKD0k4YcBoE7tDNKYIY5VFTtH6/eivQJ13CcGMH4N6T07m5Qq
	cf1C3ie8NWyZacanuRlcPkUaXO324m6b1z9ekxcY8+4c0UReF3OUP1pyoYr9bvys
	n2KobPiMefMiE22/XiaU9Mk2cliUShQmHPA==
X-ME-Sender: <xms:2xSnaZ05TXWZepCiY1J52Vx7T_KdhDaZe6FRbeN7RVrxUk6n3lrbHA>
    <xme:2xSnadBT7Sme9xEuL7jzmSEs-ZElMwrqv414aaamu_--AzWAc9eqWwngb_gsytVxp
    -iexKNSRTzbooDMBjPQp9ttWR_NIOXPZ8DNPWkJwgZB5_hB5FZFdA>
X-ME-Received: <xmr:2xSnaVitAiwdPLZrJZ1l3qct7QFFV_Ci_7n8ZFs7ItCkGutI4HWnDVJowwUVekUITC0rbokN22FKhQWTIqXhlWYag_kWSR2Gig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieduudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepvedvffetgedugfeiieefffeghfegudekgeekfffgieehvedvudefkeejueeh
    ueefnecuffhomhgrihhnpegvgigrmhhplhgvrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopegrlhgrnhessghrrghithhhfigrihhtvgdruggv
    vhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhi
    shhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhonhgrth
    hhrghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihl
    ohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2xSnafNsP2rw7reiHk_GDJDfC2nMZ-O3cbYMcmdx64My9OISRbbdvg>
    <xmx:2xSnaV-zn0PKwMDLTjuX8xCBXjROWrL6dQjxTZqzOKQgkgpPwmH8SA>
    <xmx:2xSnaQcKfoYRbqmSZ9yN8EIBbdvmaPVZmYtDxT46wJy0_OfJOnVxHA>
    <xmx:2xSnaUxv1AP5ThzKOF6-_RYHGqPn3Rjpjm_6wJW4JdpT2h99IocvuQ>
    <xmx:3BSnactoZEAHyT-sFlMn513Udiw9tGqz1z50LObJGdTi8AteNIWdjpzC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 12:05:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Alan Braithwaite <alan@braithwaite.dev>,  Alan Braithwaite via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com,  jonathantanmy@google.com,  me@ttaylorr.com
Subject: Re: [PATCH] fetch, clone: add fetch.blobSizeLimit config
In-Reply-To: <aaaACBJVAZPypVtn@pks.im> (Patrick Steinhardt's message of "Tue,
	3 Mar 2026 07:30:32 +0100")
References: <pull.2058.git.1772383499900.gitgitgadget@gmail.com>
	<aaV6PLJCrpb2mQnq@pks.im> <xmqq342i12ky.fsf@gitster.g>
	<a3e064fe-9f0d-448f-b034-4a95dcd3fe97@app.fastmail.com>
	<aaaACBJVAZPypVtn@pks.im>
Date: Tue, 03 Mar 2026 09:05:30 -0800
Message-ID: <xmqqseagetd1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> No, you're right about this one, and I think this is a sensible thing to
> want. But what I'd like to see is a bit more nuance, I guess:
>
>   - It should be possible to specify the configuration per URL. If you
>     know that git.example.com knows object filters you may want to turn
>     them on for that domain specifically. So the mechanism would work
>     similar to "url.<base>.insteadOf" or "http.<url>.*" settings.
>
>   - The infrastructure shouldn't cast any specific filter into stone.
>     Instead, it should be possible to specify a default filter.
>
> I'd assume that these settings should only impact the initial clone to
> use a default filter in case the cloned URL matches the configured URL.
> For existing repositories it shouldn't have any impact, as we should
> continue to respect the ".git/config" there when it comes to promisors
> and filters.

Ahh, thanks for pointing out the flaw in my thinking that forgets
that "remote.<name>.partialCloneFilter" would not work in the
initial state where there is no <name> associated with the remote
repository you are trying to contact.  I agree that something like
"remote.<url>.particialCloneFilter" is a more proper way forward.

