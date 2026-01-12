Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DA92EDD63
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232229; cv=none; b=L9VfKfkfjc7R6KZul5SCA8Ep63QhqHpCCYv+6DiOeiIF3AzkElj6CAvsWgPWnZTbMttTwxHgPHHPE8IUsuzg1LKTUuPkG4SqGt9ePg4zevqoWhNH0tOIgzPOJ70SisFYGvJP33dJuNuXcUbMbzXFX51VoWCF5Sq+XtL3gBRwF/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232229; c=relaxed/simple;
	bh=1fUVpbfj6opG58YQfJ1CuVQL6Dcur4q9jRhbDTYet40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1zZ1QES9jBHDm3KQNfMXI6keqfNyPQk2qsxFs3hC2QTPTlbaq/egqGPdjZrosgE722KQxaLxq/Z+yb7r65mfR+G/ZCjj7RaiuFsebbgExk/uw54nwI7q6381taPaVeh3oI0wfJw14fjpzGaopM2gA4RGwTu++yweTzJJ0CNYoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d6xu4Grr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qdnKYZSk; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d6xu4Grr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qdnKYZSk"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 33D1A1400153;
	Mon, 12 Jan 2026 10:37:07 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 12 Jan 2026 10:37:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768232227; x=1768318627; bh=ywpMeQxBoz
	2xOQTIAANsAXVKCnpNfpqO7qIY70oLCys=; b=d6xu4GrrnLfcABo+1tfGMlc1Ag
	f5FY+PNchxUhyXR9pTH8JimiYgJXT0c2mql29Ew9qeiqLVFbAfc9dJKYN5A1jOxY
	jJl/eta+4CHvj2YrmfEGxx7men38gmfu+Is3vmqE8uLiwBBtYzxyS8rMeF0lfCpv
	bQGanzALXCA9tVIAkiOgS2vXNhLOSeOY/uyXXV6WHcX+Ejz0xUne1ti9608XjAqk
	LkkMqabxR+JF8hjU7rEi1OgtN3RpgcXkNAbJlxEJ8WRwv38u5JU1vX7rm9e/sjYo
	38Uc5jXPWsNOM6wKfIbx6ELkRCOCk5VMUS4blyDJQfptKODA9/6fi/VPAY5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768232227; x=1768318627; bh=ywpMeQxBoz2xOQTIAANsAXVKCnpNfpqO7qI
	Y70oLCys=; b=qdnKYZSkTe7aZafUp5ikNHE1s48gecy+FZ7O0kXbajxnXXFJk5L
	dadvDdXWMGU7yG96sn37Wrp1Pfvrn2aGqbMTGl5E1VuatiGeDjAaY4jEMWIuZrXI
	XD/mdp4/W3g8cNK8oNxc0rxfgsI7NfbtQTZzDmhXczs5L14QOZAB9TmG/CFX04Tg
	tR9QTYWG52DFq1PnAdOx4UkEQxXnq/G54gVBXfZhUvwHd7FKFo6WSs+8qkEMsMqS
	jsl4kiTgyJtYwd/nL4W0wmxzbht/FGAMkGmBLUX0fb8oF8u/kiRqSu/isZSgwbd+
	JgpmMDPQSKLrOPZbICputrPgY/KWMGB2Fnw==
X-ME-Sender: <xms:IhVlaVAKS9keoKh5knfQ0BHBPmTlcFyEU2Tw5uLGckMXlTz9IX89cw>
    <xme:IhVlafWuKI8DtBy1UWIZQ3b3vknA-x4zFAr5dWEKbYfkOlBdkTTnggJJLZ9_P0WV5
    AvtWQvQNCdUHMfOGsixDWRxtWvFayW7zrdmepfA0RM_jhZgdKO2Fw>
X-ME-Received: <xmr:IhVlab_Vrwk1lOvHEdXDaRT74pqcLW0_ouSjMH_NR9WUgXx9VP8oZgQqVZ7iHUBd_A83dlF9F8ZcAnszFzTj7csxJuwVd0qkg8SgoR0b6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphh
    hilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdr
    khhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:IhVlaZTZqfrAtuiv-nIY2qm7b7a39UnEmAzKWAY8Nb381qQWk4uQAw>
    <xmx:IhVlaYQyx4aM8-S60SI0wN0meEhH9RdN8mUrbVn39tmxazWZiLVJFw>
    <xmx:IhVlad7r4Y44LrPV1xSuRRzbt39Wj79_SSEd283BU238KQ-y__gpnQ>
    <xmx:IhVlaVXvW47EG36NoN3iUY-CoaU1t8SajgDgK-R7zCjy-oB1PXiTgg>
    <xmx:IxVladCS5FQQFoP_VDVifz9Dj-azBntyHGeeycpwOI07sZ7lKPx7ULBb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 10:37:05 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0b0d274c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 15:37:03 +0000 (UTC)
Date: Mon, 12 Jan 2026 16:37:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Elijah Newren <newren@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Matthias Beyer <mail@beyermatthias.de>
Subject: Re: [PATCH v10 1/8] builtin/replay: extract core logic to replay
 revisions
Message-ID: <aWUVHKMfG0vRb8_G@pks.im>
References: <20260112-b4-pks-history-builtin-v10-0-e3c6aa5b4cec@pks.im>
 <20260112-b4-pks-history-builtin-v10-1-e3c6aa5b4cec@pks.im>
 <xmqqv7h6na0s.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7h6na0s.fsf@gitster.g>

On Mon, Jan 12, 2026 at 07:08:51AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > -	die_for_incompatible_opt2(!!onto_name, "--onto",
> > -				  !!*advance_name, "--advance");
> > +	if (!(!!onto_name ^ !!*advance_name))
> > +		BUG("expected either onto_name or *advance_name in this function");
> 
> This brings our crypticness to a whole new level.  onto_name not
> being NULL is a sign that "--onto" was given, while *advance_name
> pointer points at the string that "--advance" option has received.
> We are saying that only one of these two must be non-NULL, and the
> other must be NULL.
> 
> I know !!VAR is an idiom to turn any pointer into 0 (=NULL) or 1
> (!=NULL), but isn't the latter (i.e., normalizing all non-NULL
> pointer to 1) a bit overkill, which becomes only necessary because
> the construction wants to use "^" as "sides of this operator are
> different Boolean values" operator.  And then to add on top, the
> whole thing is !(negated).  I wonder if
> 
> 	if (!onto_name != !*advance_name)
> 		BUG("one and only one of --onto/--advance must be given");
> 
> is easier to follow without being overly cute?

It should be:

    if (!onto_name == !*advance_name)
        BUG(...);

But other than that it reads way better indeed. Fixed up locally,
thanks!

Patrick
