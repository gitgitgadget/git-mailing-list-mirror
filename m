Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3781898FC
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 07:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732605927; cv=none; b=Lz4xC89dQ/55+PaFxJ8Y9Uhj9DHp2pKttO/rJrUieuB5ilSjb+N0CrZgezKzBt+LL0ZUhGRJ4dJuQ4MkHFBY4M3exN0pZEUYOCJfC2EV5St93WdkyIqBZC19nS8jjumBki1JC/pkBC2fAVR+JnianZe4PciruKfoMCLg8QKQ0XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732605927; c=relaxed/simple;
	bh=0ocqXMoxWd2DkdnFoSXe2oyW1S1x8Ajz5k2/2bMGIms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MkZSRfcBxHH3u0A4M0Dhm1ady7y8IYQzP9RtUo7nrsGnjo+wE50cM+sdwgSLu3NYmHQA1NWPbLi45oftH9nmC8RHZ/MTw8JbYW4OwnhkS8g0fsZWr3LvBFDv0/R1gOrH/Zof7uRkp6kDOzst6xnahMYd1zmpuhXNNcToixoJE+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sQviUuOS; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sQviUuOS"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 2422013805EA;
	Tue, 26 Nov 2024 02:25:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 26 Nov 2024 02:25:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732605924; x=1732692324; bh=GuZm9OWTXYzUV/QgEdqKlQI+6dQ+YrV4kmP
	r2r2yHOM=; b=sQviUuOSLoXROEmJ5Csl6OOMhuOo7JBJR5bQCZi34cNkz9S6ZV3
	vnpv9E8vmRmeTb+mAE8e3xEZX/e+g2RgJUPnSrhQMoG7I3PsKtneLGg67Na7Lvhb
	0nc1rAGLwUsyxG7/5oDgpfeQeQ03KaG5UQJohtJPhMtRZnIHBCJknbz+LZpJuApR
	B54NHgIYfdPfhwZu9zdxnNy+OAWInUpr5XZ1/DBwqBlvEnaQhmgKWTNQjK84kI62
	O+0rdZVh2lFiEbv+AuuPYjRJ0SnzpEX5KCuuThCpvHI0G52xrW6t6xFJgHD02UtQ
	HHIXH3KEyB256tO2MZJs6TmWFrEnl5TJwTQ==
X-ME-Sender: <xms:43dFZyoRYp_ebJDE8RzEAVeiO2DnBcPRYLisbPnUZZOe28xH1tUeaw>
    <xme:43dFZwon237UijmbpE4ju0SBOlfk6JZRAvvwBQdYHlSIXEBrZXe5RHa8LgsyIbFaI
    M9PxkkXZ3hdOmi4Rg>
X-ME-Received: <xmr:43dFZ3Pz-ohV4CaP2ARcGiWlwZuXEumrjyJYGzuyoy6BfClwStKL2RExVf0n7cUwMirpy7BrLedZKFbDkZZhl9qwUsZFrd_vcVNFCKI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:43dFZx5mejaaYgdW4edMFsu4t8V54Kvp2kXK_riebkYDcph7f4BnmA>
    <xmx:43dFZx4zyI3fCZo7Q3QHik6SIDivON4Sf5koPdWZdf_tBph7deQwrw>
    <xmx:43dFZxhUueCjHIVwIzwnuf-2Mm2Z8dYwzjKX2ypxKYcEfbyp90GHvg>
    <xmx:43dFZ77vM_nVtZ_hi4MHEHc9FCT6eDiNuWyU2u9sX6LSNH-it-ke7g>
    <xmx:5HdFZ_RcjcA4GVutM2uHIo2-LlpD4hDCfA2ePO37aUHe3S8jWzkZUhFR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 02:25:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  me@ttaylorr.com,  peff@peff.net
Subject: Re: [PATCH v8 07/10] config: make `delta_base_cache_limit` a
 non-global variable
In-Reply-To: <d1b6e8801bb7edc9ce55bb50a5d46f9779906ad1.1732269840.git.karthik.188@gmail.com>
	(Karthik Nayak's message of "Fri, 22 Nov 2024 11:08:26 +0100")
References: <cover.1732269840.git.karthik.188@gmail.com>
	<d1b6e8801bb7edc9ce55bb50a5d46f9779906ad1.1732269840.git.karthik.188@gmail.com>
Date: Tue, 26 Nov 2024 16:25:22 +0900
Message-ID: <xmqqfrnezcbh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> In `gc.c` add it to the `gc_config` struct and also the constructor
> function. The gc functions currently do not have direct access to a
> repository struct.

We should remember to remove this member from gc_config when we pass
the repository through the callchain.  As a built-in, cmd_gc()
should already be receiving the repository as its parameter, so it
may not have to wait for a long time before we are ready to do so.

Perhaps have a comment next to the member's definition to remind us?

> These changes are made to remove the usage of `delta_base_cache_limit`
> as a global variable in `packfile.c`. This brings us one step closer to
> removing the `USE_THE_REPOSITORY_VARIABLE` definition in `packfile.c`
> which we complete in the next patch.

OK.

IIUC, Taylor's comment to avoid repeated calls to configuration
layer to obtain delta_base_cache_limit, aside from typofixes, was
the only thing remaining for this topic?  If so, everything is
looking really good.
