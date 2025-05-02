Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89A0376
	for <git@vger.kernel.org>; Fri,  2 May 2025 18:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746210987; cv=none; b=i4tfsqYS2mZaqMjev2L4sModNwys9emArDw92+bS3afCX4n8kZ+nM5BWhDKwaMNM/njZvwWOs4Kqfz82XjEa24sXjdlS7MVqgXY9EK+8QyWZq+eMmDFcb8az2sMbkVXiWHSnfFD8nZGitCdm2IYrWajJ98jO32SXg7JYLN/z6+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746210987; c=relaxed/simple;
	bh=xV6hfdE4fvtt1NUyrmtiEmat/UfzjAUSNjexiIslXuc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mqXKz16NuZOlKgmawn0iGl3yVFPNNhI1o6cBRplR8oFzAHQLg1EYfxpAMLtCx3P2EYIs4PNQyqskZXQsBcD915WofvbhkOwWyj003vmON5ExOf+WEMIvaoV1ADVQwXYxmVZiqpO070ix+soMWqIUl8wiRHPneTHOFnPtF1arOh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Oo5JNrCH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oAlWPjGz; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Oo5JNrCH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oAlWPjGz"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B7680114015F;
	Fri,  2 May 2025 14:36:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 02 May 2025 14:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746210983; x=1746297383; bh=PyEEP1OLiI
	ub2XtyIWRShoC8wQ0EFquTCl9QxRBUmNY=; b=Oo5JNrCH/KccJweKE5prvjvzdB
	k+K+iUJXzPsM9IJ1sySnbnN4hC1TxwxojinRkTo1kRiPZC7SCJ0OYJLb1fOUwTmI
	W/hztSYZxq/Jo+6G8wEm7+O9oMZfBZTt/Z1tSYGRmKgb5nWZnmCLOS8+IVSko5WW
	wcrna1Z0vu8pyL13p26aZIn7nLc3oD+4Zipxxnliel+4tNp8U78gZMiyEf4mxkt4
	oIi2QSmtZwl14N0tp4XVlcDLI6+no192uoBIxIho4cS+SusPur5aPPOih7TpQvrC
	FCACv/h+a4hPHQ3fR9Wl5ZhmBJPVN6XBv/wkEy/6Jw0F8VEOmu1nTWFyVuSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746210983; x=1746297383; bh=PyEEP1OLiIub2XtyIWRShoC8wQ0EFquTCl9
	QxRBUmNY=; b=oAlWPjGzdC6/PpKp6TiChdDwMH/rHqDFKLlKdaGnbWEP91BtBJg
	y5MUIkwDr2pDGMDGFmIcz9U6VCTms0yBqArzZXNrJqu9Wdf4Z7XcfEHT43r91gOZ
	ogWKzqHtf7OdN1n3Shk4PvFsg3620AIp6VwNTiDbfJbHQEph4IA5Qsf0p+bWkvXB
	M7t/6eY4tK1kFg4/rjhY2/8Rd3y2voxxPLWvh3Fc6P/2q9e0vdf7LLm9B+R9ht5F
	XLrwU3PCMwnMA8GVO75vdeJtLFLhKpjTN4j9dhqdbCQjIFYxSnExJJuif6fzfaHK
	7qJX3W7637HnhQOoNdedm4jmL86DeWFaW3Q==
X-ME-Sender: <xms:pxAVaBzgTU8OK2_jfCFNS4X9AxyfA-2gNhgGLn8GK7iSkGGDhoJKKQ>
    <xme:pxAVaBSwR-XQJVcvxquCtYkrX8NfJGsBMULvqWlkBLoWjcHWPx668aPmRnToDsj0m
    mGt69Qjdz35OatHRg>
X-ME-Received: <xmr:pxAVaLVIiKlNTp3103CysVgWEtQWVvXLlroMm_cF6_H0T8ap_KxdYqVHIXmVusow-z-6RXa1FLKvC2JfHZM8ABNbA53fm51ep5GZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeefudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhgvohhnmhhitg
    hhrghlrghkieesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:pxAVaDj_GOKuU-kwbXwnVcydsOrRPWlYNvENIVFyuJskWhEAbcGp9w>
    <xmx:pxAVaDC_1M3GyOoywsDcqV9mI9Ad84LXKxTDn4HZJkbgS7bOnRfsuA>
    <xmx:pxAVaMIjgSg0kgutSFUAiOzPOSx2T7ncOAKKE1SHJCQOkPOVIChn0Q>
    <xmx:pxAVaCAXkurgKqGIByYmEaUU3Jq_hL28fe1d9GdS7R1yhs2EPdoMUA>
    <xmx:pxAVaIYZORWAImw0xgDI6bmaHkPBu9c4zdR9kJvCeYDDvZwrUHVFZKF4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 14:36:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Leon Michalak <leonmichalak6@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,
  phillip.wood@dunelm.org.uk
Subject: Re: Discussion for interactive --patch commands to get --unified
 support
In-Reply-To: <CAP9jKjEbb_ABmGmLNwn=ruh+BOR73QDqtzF-cCYv40cE47fEGQ@mail.gmail.com>
	(Leon Michalak's message of "Fri, 2 May 2025 18:13:15 +0100")
References: <CAP9jKjGb-Rcr=RLJEzeFdtrekYM+qmHy+1T1fykU3n9cV4GhGw@mail.gmail.com>
	<bf7f6606-e719-4c3d-b7ab-ef7351f66f37@gmail.com>
	<CAP9jKjG+khoUmRpVJ8om-bs_qjB=VFCj3p3h0VSaBHVnqPLNVg@mail.gmail.com>
	<xmqqfrhnuf06.fsf@gitster.g>
	<CAP9jKjEbb_ABmGmLNwn=ruh+BOR73QDqtzF-cCYv40cE47fEGQ@mail.gmail.com>
Date: Fri, 02 May 2025 11:36:21 -0700
Message-ID: <xmqqbjsavp0a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Leon Michalak <leonmichalak6@gmail.com> writes:

> This is what I have been using currently although the perfectionist in
> me says that a user could pass `--unified=-1` and the code would treat
> that as if nothing was passed by the user.

The command line parser and corresponding config parser callback can
be careful to check the value they get from the end user to avoid
that, can't they?

In any case, it is PEBKAC when the end-users do that, and they
cannot complain about their --unified=-1 are ignored.  We do not
have to care, and can just tell them "Don't do that, then."
