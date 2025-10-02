Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DC8221264
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759419042; cv=none; b=ongq0ShA1YNiLWJhK2joPFDZUannZlnr0hTUj9OblroJzWyS2ItjUEXQDvYUXhGheNnbOH/EJtCr1DDIF29g7XRYJYWxuBDgJxhsLPeEuDBy+Edmz0rBGYmrtsQinTouIWwsXvGXYca8LtL1rSAKYavLGWUFWX9JB58puxhNlkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759419042; c=relaxed/simple;
	bh=+nvQKbl+ER9gBpqOGmCVNukln1kosFiDnIkKp8bujeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdBkxyKH3c/PhZq7IiZUjnkhxPgc6sr6943TRSATqJEJr48aHrDNArMaTMM4eABra3pEPrP2k2DYjWeQxo5wuyPLIjwsAAwm3p/r3RnUPLh6yE7v4pr4PXelFC8hXkT1J/gOhRKomHkTEtSKidvel9rfftTVMb7rfhw6n/GJIek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TADZ7F+1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MhTTBdHI; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TADZ7F+1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MhTTBdHI"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 71A041D000F4;
	Thu,  2 Oct 2025 11:30:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 02 Oct 2025 11:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759419039; x=1759505439; bh=CjEtwbGRyv
	e159m9mBwiNBiBGkb6nKTOqRo/KesxM4o=; b=TADZ7F+11wsXB+IDxAvJL2RtsQ
	0C4uiEAJn9eOB5O41cXCIpvI7XTL2XDoDlZ5F38MyjF9W5oqoeNXRXn7lZa0ufzP
	oiKJqz1bx+URH6tpL3DmwE01PQ/+B31m6VYd/TWRuTG6hIUtqs75vPxgFLSd9pt7
	zgY9B8lsksMOkNckt8kFe+Qx6/nT5ho9C+rqFcCMP80WV5mlg1FzpwH5vc33cfFH
	RuS9mljqTTm7RsB/m845aKD9sZ905zZDR2t3MVIe0CRh8cTJ6FPRs1KOmMDP/jqi
	kxzzAPhhEsrGtxNRWqCT3KFuH97ykwAKydW8FV5M97ZDnaZyDhgPDmhtGi9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759419039; x=1759505439; bh=CjEtwbGRyve159m9mBwiNBiBGkb6nKTOqRo
	/KesxM4o=; b=MhTTBdHIcNgIA++9HXH+J6mQ4Lu6uKjaVf5nXAdq8CxoyjX0EJV
	TbOpmXb47ON/CrDjFBGS36YRWag/q7PNLTphSfWJw/s2s31ht8dAnrB1M8KxSGF4
	fv1+jEaK9H1UkGGHYV3dAtyzYcxnek7SLNOchRT2eT2nqXfGFHTvAnzi9N6BqfN8
	TPSGVQbBcJ0oWuZE1b65w0VaIyA6V5ZzLQ790vfka91hR2BOSAC5MtWfe3LUu7MD
	bReqhAsbmA+y7lyFN8mPYoYQst0juc81sN96fWV0iULVYqi6dLa2rG3TEj1J28gP
	aDboGVkh9HySis1CPzy4GERNcSnaCX05hfw==
X-ME-Sender: <xms:npreaAlDXQbmuOreihkov41oXc9Cei_6dM7eLl5T2MpwtCqlI60dNQ>
    <xme:npreaDjirBHEti-6eTPGXmq2FwcZnzkptfDuvmFnwiBbL-lE9KxtfNmTwsaBdsd1y
    8lusmNX2nakFKiKp6mh7Vb5XnfZMJsbBuWVKfIlqzTyNh3kpyHcCA>
X-ME-Received: <xmr:npreaIf8PT4faL2ybCIsnd_q_bIiUoppG4X2ATX-SNNwWOUYK6LnDc31RA2VBiyrfUDAC8hrmDQns-AIVr7VgBWcJW2CkPGk-fPZznM68Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekieefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehsihhgmhgrqdhsthgrrhdrihhopdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopehhrghnhihouhhnghesphhrohhtohhn
    mhgrihhlrdgtohhmpdhrtghpthhtohephhgrnhihrghnghdrthhonhihsegshihtvggurg
    hntggvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:npreaDg_p_Nwxb0JWb1ZmL2twXw5bY9BnEFwsmuuolsOwnhQIAIpfg>
    <xmx:npreaAwKGD-uJgHZQkhQcIH9z7TbWcIxQra6ozhjIvcA5pDwosrxzQ>
    <xmx:npreaPMtg7Beg42kt0TI2GUnlZ3721gs1cIjMSyXNV_tfJ8voLEnuw>
    <xmx:npreaBVZLycYalrpAY6rUjEwMvL0uHfAOl4xbyks3aMGNoAfuyqzmQ>
    <xmx:n5reaPCrUv5zthVWPiwi1wZj6yaqij0UXfh7BBHo5Om1madaEpa75Nld>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 11:30:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3d21d46f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 15:30:35 +0000 (UTC)
Date: Thu, 2 Oct 2025 17:30:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Han Young <hanyang.tony@bytedance.com>, git@vger.kernel.org,
	Han Young <hanyoung@protonmail.com>, Sigma <git@sigma-star.io>
Subject: Re: [PATCH 1/1] files-backend: check symref name before update
Message-ID: <aN6amIG2Sp3W500K@pks.im>
References: <20251001150805.9652-1-hanyang.tony@bytedance.com>
 <20251001150805.9652-2-hanyang.tony@bytedance.com>
 <xmqqv7ky1l70.fsf@gitster.g>
 <CAOLa=ZTnHQbg9ocdA1omqER6CJH-w30G14-F2JAQMtueXENWew@mail.gmail.com>
 <aN5mOTbGBcr355E6@pks.im>
 <xmqqo6qpxw6w.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6qpxw6w.fsf@gitster.g>

On Thu, Oct 02, 2025 at 06:36:07AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > Agreed! Overall, the goal is that all logic to verify references should
> > be contained in `git refs verify`, so that git-fsck(1) only needs to
> > shell out to that command to perform the full check.
> >
> > So if this logic isn't yet part of `git refs verify`, we should migrate
> > it over.
> 
> Absolutely.  As "git refs verify" is a way to do the sanity check of
> the ref part (presumably without incurring cost to sanity check
> other aspect, like fsck does?  why is it a separate command in the
> first place?), it should learn how to do so.

We have the same pattern in other command:

    - git commit-graph verify
    - git multi-pack-index verify
    - git bundle verify

So `git refs verify` is following the same direction.

I think it's a nice pattern to have this encapsulated functionality so
that it's easy to exercise certain subsystems in isolation. git-fsck(1)
then becomes a thin wrapper around these commands and is the one that
ties it all together, if desired.

> "git fsck" should keep complaining about the failure as before,
> whether it is done natively or by delegating to "git refs verify".

Yup.

Patrick
