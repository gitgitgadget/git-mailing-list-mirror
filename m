Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258B81E5B64
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 20:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775333112; cv=none; b=sSsj+RjKKKKiI4Esm+8jIUUHMEoHFJ+QnLNnc6PjOnLYke6WO7i5YQlOxaqw/L9R4S/NH4WWcwLgZ25xU2XlgH7ENDir2Tul8mdt75QcKVjn7V8tKQeeDLEBz+6QNNOjNardbLpQBHAGL83HZkxI8H5JYjjkqMvs0s+L0SrUmuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775333112; c=relaxed/simple;
	bh=Hxt7cE/7fkBAJenwP0/skK4xUdh9Qc+ncRlFNymLd0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wv+QLKk2szt6ZcZwmep762knszmNjqx3mib8BmeFDHa0UFqd7x2262ENrCEPFpWrO6shjQIDW3oWq1+oKU6S8g0/bsXN4k3Zm/aB+cazEXeqpqdeu7/3qmLZ/G5R15nv7FCGk3+2NSdr5k+1AWi7XWhaPDdxeXUS3s+ihcjb2qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u92.eu; spf=pass smtp.mailfrom=u92.eu; dkim=pass (2048-bit key) header.d=u92.eu header.i=@u92.eu header.b=YQroaJAN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hk//ldO9; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u92.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u92.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u92.eu header.i=@u92.eu header.b="YQroaJAN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hk//ldO9"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 16154140007C;
	Sat,  4 Apr 2026 16:05:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 04 Apr 2026 16:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1775333109; x=1775419509; bh=ktI/X6T19W
	Dz+4RtBeckBIh7PJ7RlTGEB3UvPYuyd+w=; b=YQroaJANsAAgUplTWVSGl1PEMb
	9WuiiXiuqfQn59rsdVoJyEoliyFgmbQASsoHcbAoBltNfYSZlgI5SNNlW+8kGl8S
	XGAunazF6x5Wg5Xb26ZcGeURhcfdx+xBZ6khQF5PenikmHOogGtMoPmFBTKVBtoZ
	vqUxKt/SLPZviDmpT1yxP9kl+ssx6+JuxUTrPs9P8PKWcO7H4Pv3WhYwfSCW116Z
	QgH82DqbGy7pnLD0HNXxjtRyapMtbXkoMpwaZmp4NSMwgO0gQkSxiG3zDxsL8I0+
	Z3hwpJI6+HKRZ3dPrpHGsEdVn+AT4xGaQXj7ashMPZ3eMlAzuOiIV01mU1nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775333109; x=1775419509; bh=ktI/X6T19WDz+4RtBeckBIh7PJ7RlTGEB3U
	vPYuyd+w=; b=hk//ldO9sUP3jADGlAbGqfK+FH+LiuL3cv8685X3N4iAuYUzD5k
	+VRUEGEJLx8+VWSPklUQqm7jsZp0Om+GlY51u8Ea/QKW+cXJZwwUGJlVg8VQCLS+
	cBNxwDxW0Z5LZawA45aupcGaUjFyX1HqN6xaJgzOr/N3iOp0yiRl/ki9ExipqsyC
	4gWm995WynDG143AKBWiK+hBx75tl8a9wAJsPopw+D7lafvWVvukwEp+aIeYrt+W
	u60mooRo2h4EWmDtx2dczuauf7wXpStOt0UQWIkzfjuyeS/CKSh5ebZ5K3znjWkT
	ZKuCbe5d39xsk+dTWwXaFfIhJwW1nNC8kkg==
X-ME-Sender: <xms:9G7RadEq0eYNusUTVw2kLUZEDn9vq2Tqazon7z8aC3Wv1rsk-7CTKA>
    <xme:9G7RaZz4BJwsV1t9mNUb452jzeiworKQdgZbctR7ZyCIOdDnZdOcV2TaKjI18xRGG
    iqFheZFcxAAn58d_qIpSE5U1xePfdkYJbLWwZju-7cPzNt67o9rpQ>
X-ME-Received: <xmr:9G7RacgKyJHkNWe2XiPnWnRa5y22n6ac0TONYBPXrIQaen3SDBGAcEt3YtoDceHJ4mv1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtjeenucfhrhhomhephfgvrhhnrghnughoucftrghmohhsuceoghhrvggvnhhfohhosehu
    ledvrdgvuheqnecuggftrfgrthhtvghrnhepfeelteegfefhudeiiedtgeeihefhudduhf
    dutddtkefgudfhudeifeetkefhudevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvvg
    hnfhhoohesuhelvddrvghupdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehprggslhhoohhsrggsrghtvghrrhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgv
    sehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:9G7RaczKBhXGUV9-vGkU3HRwMbfqnciH7g_WOh9VX_JA8636ph-mUA>
    <xmx:9G7RaXIciVTLk1nDRe7pO-VqvQH69sy78dCu5sJo-lzEySa7tbf0AA>
    <xmx:9G7RabQJmU39C_n_RuRUs3_Hzp4f7HtxsZ2mPIpLpHMlYe9tPzWYmA>
    <xmx:9G7RaXrjowDZSBagW5EFh1g8h_RpaG7cd2SS-2lhgtl4UrDW9C5jAQ>
    <xmx:9W7RaSMgG5ln_xA4LsJYpcwtXkvusQLfXjyONj1qeCku8ujIGm5p8CkP>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 Apr 2026 16:05:07 -0400 (EDT)
Date: Sat, 4 Apr 2026 22:05:03 +0200
From: Fernando Ramos <greenfoo@u92.eu>
To: Pablo <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, me@ttaylorr.com
Subject: Re: [RFC] Show empty root commits when using --simplify-by-decoration
Message-ID: <adFu7wLmro5A9NDr@x395.localdomain>
References: <adErl-EdiaXopVx-@x395.localdomain>
 <CAN5EUNTUDT7FMNYTOnTA_GJJXa2eZZL=RhJHfA6PfJvFSSHL-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAN5EUNTUDT7FMNYTOnTA_GJJXa2eZZL=RhJHfA6PfJvFSSHL-g@mail.gmail.com>

On 26/04/04 06:08PM, Pablo wrote:
> >
> > Issue (2) can be "fixed" by using a diferent character (for example "I") for
> > root commits...
> 
> This has actually been discussed before and it was ruled out some years ago.
>   https://lore.kernel.org/git/xmqqwnwajbuj.fsf@gitster.c.googlers.com/
>
> You might find interesting a patch I'm working on that tackles that
> confusing look when two "parentless" commits are stacked.
>   https://lore.kernel.org/git/20260404092425.550346-1-pabloosabaterr@gmail.com/
> 
> This answer from junio might be helpful as well:
>   https://lore.kernel.org/git/xmqqbjfzn6ku.fsf@gitster.g/

Ups... I completely missed those on the very quick search I did on the topic.
Sorry.  I will ignore "Issue (2)" then and wait for your patch :)


> One more thing, even if it's an RFC it would be much easier for reviewers if
> the patches were sent as git format-patch (one each email) with a cover
> letter, discussing your RFC, so anyone can use git am and b4 to apply the
> patches.

Thanks, I was not sure whether I should send individual emails for this,
considering that, after the feedback, they might be dropped.  But now I know.

Once I receive freedback on whether the "fix" for "Issue (1)" is a good idea or
not, I will resubmit a proper patch.

Thanks.
