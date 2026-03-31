Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D36B3590A9
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 22:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774994708; cv=none; b=GBpoA8vzBDpPY+uXRtW8YEhIcFv1HBb/eieclICG45nrH6/y0M+RxPjRix87Pc9OAh3F6GdG7j6N7QplKG6+GFa/neijhkFf42MZefe1GjBujXpXpgrO6HArnYjPLCnx+mpjLBVgfOxIYh3AsSX/y5o2e5/IwnpSz/MJ+MB+afk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774994708; c=relaxed/simple;
	bh=DIkX0b0zxXrF1ehq49U1NMEzsC7p9XiOJyGYy8r9ucQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qMna95L+RquKvsxzYCzWqR7/hcEauPr/iRs+4b1wCvTXmTh64wAE1IU+dEyMoLn/bQp2GU6m7jyIuVdPtHNerE/o6XjJcSsrDWdlO65mFdT7PDqw0jXzsc1YYlpwL/utGOWhyZ8aj720DY9tutS2z191sEWEHGUyXZX8PYZD2ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KvDjZYyV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DEMKOo+L; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KvDjZYyV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DEMKOo+L"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A88711D001E1;
	Tue, 31 Mar 2026 18:05:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 31 Mar 2026 18:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774994706; x=1775081106; bh=Sa4MiJEgFN
	Rlnw3xB7myAjErqcp6QsFdoOhD6CfGxx8=; b=KvDjZYyVEnKOvwhWiIoPQ3eITx
	XCtUY2aNZhEsix6vHegMFasvatKCK3mk8H796cjk4mBPZ38eVswWxXY/lSCMDLFd
	gGkidldaZ9ltTRqVx+M/5SsM9h1sSSGAhpdqZr7JUvdnllmzJfbrZdODdH/ZP6GC
	Zk4VxB3UKckUwA4Gz9caqlRt7iR8GdNhxUIihvIgMAmGZ5JzKnjwQQZwJrcJgD4W
	kmm/WmOfiGh7YIezdOZHr4Qvd6WjFzYx5JIxjQOR24PwLZ1QYE9yEdqVHLGjmlNd
	5Ew/iAP+VoUc18muKQRn75eyekw+YWmEhJp+978e+YBEBeq98lAGkIbN1Lzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774994706; x=1775081106; bh=Sa4MiJEgFNRlnw3xB7myAjErqcp6QsFdoOh
	D6CfGxx8=; b=DEMKOo+L8OAH7hUnYe5CxDIHRfHidvAhKDD+W7c1DfDgNUL1fkX
	hUlknIcNnxhZh9Zv5vz2kpQyxm7rzfDT53ccmVj8s3GQv2Co20KJhVVKAFlNlcdy
	IzmueOqrE04RzymgCGKu2/4uVXHn9mYPf///dd71UHxR7R4xT2v8jnYOSOik2co6
	lGi33ZVUfVZ/szr5y9WImXSgHTM7IXuI38lLewRLqo+TDR0Px0WzMFSARbThngTB
	wuEDMmq+wzYwEZI0AN8phurllMsdzD+9ZguE2qDQMHiWeL1CGfqwnDK0vKVWSSEm
	s1sw273ZychVUoVcwHJqn/xAKFHmQPLhsOA==
X-ME-Sender: <xms:EkXMaVyG8f84I75GLW9o69lPqBqH0ZrddJ09VSoxnhA_ZxyXWtRb8Q>
    <xme:EkXMacvULk--6bnxkfVq3FlohU5PXH084YdoSF4SrfltkUE1beU78CQEqCjfz8D8_
    EOCWe9l1HFCp3F6VsIkadocym8AjNFc_eneDywuPJ2DempOQxLmsA>
X-ME-Received: <xmr:EkXMacsEwTNSmom1kCVWBScuJ5aeeehFdZncGZAdERHThxDSoRRPHc0az4Rufq0umQOE5rbMIHAZ_dxub6UsG1y7ap-Bd0bXDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdejledu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhn
    sggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:EkXMaRPwa9FM1Zm4DgJcbBQGcTnjcCUiW-ESQ66KOWcZ_nvBbHjQEQ>
    <xmx:EkXMaa3Fi1rtZ6BKtqDAeq8AYx3Uwfie8YfA3iUApFrjAWLqSMo-fw>
    <xmx:EkXMadMZKm2Y5K41oq78oMh8O6e21THHYRmv7JjQsUmbzPRWW-x2Lg>
    <xmx:EkXMaa2ad4Tb47TkXVKeYuKudGxAMx9g_ZoJY1QH8ob2yN0SSS-zUQ>
    <xmx:EkXMaU2EY2GlW4RShn0t1liE9HJhQL6FctiDPe3o_Vv4VhENlm4CE0se>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 18:05:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 00/12] fsck: drop use of `the_repository`
In-Reply-To: <20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
	(Patrick Steinhardt's message of "Mon, 23 Mar 2026 16:02:51 +0100")
References: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
	<20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
Date: Tue, 31 Mar 2026 15:05:04 -0700
Message-ID: <xmqqy0j7wt7z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> this patch series refactors "{builtin/,}fsck.c" to not depend on
> `the_repository` anymore. These refactorings are mostly done to prepare
> for upcoming changes where we'll make backend-specific fsck checks
> pluggable.
>
> Changes in v2:
>   - Propagate the repository via `struct fsck_options`.
>   - Link to v1: https://lore.kernel.org/r/20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im

Looking good.  Shall we mark the topic for 'next' now?

Thanks.
