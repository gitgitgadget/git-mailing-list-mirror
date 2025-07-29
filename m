Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1632AF1C
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 08:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753778611; cv=none; b=QQosQ0gfqglYl/VefArOXFdiPg+TU2qXMnYli/scm6SiUb0g2sm/mKSpTxuA05bgg3MYMJnsZ/besjIEky23UadMMkoprTccPekSv9hFi9QyH+Vqrgd06UGeYzBk4hLtniCs+HUcJR20nKEOIF5U1E7WVeGrpQed2Fo7A/i9rfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753778611; c=relaxed/simple;
	bh=rDuQmLcq/UIFkYhVxaXlHbfGbG/83GfQmP6y2JoMyuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiUPKajk5NmCxrIlCTZS/l+CPOEBEptATCZEFuiUBqyuVYRaXr8dYEAuE7bdzk2r38jNyhIn+hcTsFhrusCQy8MxzaZWSQCEgvyk+Rjs6yYDDT2O20Hv7uDTxKS+IbbRFyfre4YvA2FA0MdgTb53T+Rnp//HJs0ebR+gXjVHBMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HhK3fUC6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HERTfIrE; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HhK3fUC6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HERTfIrE"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 791907A0449;
	Tue, 29 Jul 2025 04:43:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 29 Jul 2025 04:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753778608; x=1753865008; bh=8gOQu48V/d
	74K70jg4OU0GKfB+cn+WrOYokPM4w3u+E=; b=HhK3fUC6416b2ATpm2jG4+RWdq
	JGAqpcvXAkROWFoxZ3DQ7pLTndnj/IGfleUyti5paNpGIxIpfI63q0IWDm50PWTK
	U1g2OpLFTcGwk3pT2p7q7YOEY4vjeRzblw9zzM7EIAg55fsRvUAleApCXPULCj0q
	151mpf5DZCkPyYfR7VIiOh5njSv8KQOcPO5GJ+b/7Y2dJfz/tUawpV4xnwa0t0BB
	xdJisslIGofRtwX48nl5/MoIqK2FeyAoMks7jXt8hmr4LU1Lt3qkz4CDUvjiUHQY
	igumQIwB5aOKSj8mCmK/Sv7iSz1X+iNtsTKXM9wW8hPy+QpUIlehAi4+Or2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753778608; x=1753865008; bh=8gOQu48V/d74K70jg4OU0GKfB+cn+WrOYok
	PM4w3u+E=; b=HERTfIrE4ppjK8XMegShKbHWhk0/Or5Mj1JeCUdDup99MnzplEW
	KkZe39rbs+lY39hfDkAyeB36rGgA2PYKJhaQVeiU1PN6vjf2qJ3qA9lxaZ6jSsmZ
	rE0XAMr3jAisrLN5leFQlc3k5ZEMdroEmAhhkDOeJSfm/VM+wNisnxs4m5JV4SAb
	EUd9WPfkIjvGTBUMP8W5oiYsMCupBzhWdrPMd+MJaVZoapJf8Qy/nix9lVpVXwDq
	y7UXWhE+KLig/01Yp2ZHg3/MJaAQNeY5s2BV0b85zArzPv2NjK5u4tDFG3Xr2m7I
	0Uk15w7/f2IUGWNwlmrOtECXhjPji6rnQvw==
X-ME-Sender: <xms:sImIaMEgsjlQJ9ac_b5TJdVswcvxtMT2Onnvgo0adZgPd9chbIiAVw>
    <xme:sImIaA3rQ81URZCB48JxCtOcTcQjQScRcCAgSxn0DUFLd3MuM3IuluInWFqilhd0K
    g3_b-lfGPPxboq3uw>
X-ME-Received: <xmr:sImIaMnsteZCq0X8-8EpYzw7nVUzmadnG1E-uP0Ec29PwrHDpeRMRH-bIW1EoTBRLLjT_Gd5982y02wW_W_fdHS7ok0nMTwT04FjLxwRjWM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelgeeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhhtggrrh
    hltdekudegsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:sImIaI8klHrnMHD5aYrvoCdXvWOOr9hySiSDH-DfP3Bc9wKHI9qBZQ>
    <xmx:sImIaJpkvAOG3KM7yNtGfBsdALjqJmuk-mmmkxS4MrSYmW_x1aLK0Q>
    <xmx:sImIaJl5ynkmC1rg4RqrV9IMXMsX_Ppm4spD0y_iP-eqkIopc8ZagA>
    <xmx:sImIaIh98oKkQUle0NS1TaZcb5ptbMSNbFU0O9OIk6wHkqEOriP6XA>
    <xmx:sImIaBzRZun6ODFeHp-otZ0D-EhgSPGt8s1Uejja4VShLMX9kSg3QVxC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 04:43:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1d788afa (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Jul 2025 08:43:25 +0000 (UTC)
Date: Tue, 29 Jul 2025 10:43:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Han Jiang <jhcarl0814@gmail.com>
Subject: Re: [PATCH 3/4] builtin/remote: rework how remote refs get renamed
Message-ID: <aIiJpUC5cn9oeMv9@pks.im>
References: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
 <20250728-pks-remote-rename-improvements-v1-3-f654f2b5c5ae@pks.im>
 <j75h4trgwn5dvvxy6cqjv6pbh5ernehvnoi5itqr3icogebegp@ldbsvfwtxoeo>
 <xmqqjz3suosc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjz3suosc.fsf@gitster.g>

On Mon, Jul 28, 2025 at 11:57:07AM -0700, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> >> +	 * This split is required to avoid conflicting ref updates when a
> >> +	 * remote is being nested into itself or converted into its parent
> >> +	 * directory.
> >> +	 *
> >> +	 * Unfortunately this means that the operation isn't atomic. But we
> >> +	 * cannot avoid that, unless transactions learn to handle such
> >> +	 * conflicts one day.
> >>  	 */
> >
> > We could detect if the rename operation would result in a D/F conflict
> > upfront and special case it by using two transactions. If we know there
> > isn't a D/F conflict, I think a single transaction would be sufficient.
> 
> The right solution should be at the implementation of the
> transactions, not the application that uses the transaction
> mechanism, no?  So I would think the above workaround is actually
> counter-productive.
> 
> > That being said, it might be best to keep it simple for now and leave it
> > as-is.
> 
> Yes, we do not have to update the transaction layer to fix that D/F
> thing in this same series.

Ideally, yes, and with the "reftable" backend this is a trivial
addition. But as ever so often, the problem is with the "files" backend:
if we have "refs/heads/parent" and create "refs/heads/parent/child" we
cannot create the lockfile for the latter ref.

There probably are ways to solve this, but we would have to add new
locking semantics to the "files" backend to achieve it. And I am afraid
that such new semantics might break existing implementations of the
"files" backend that are outside of Git. So I'm not really sure whether
this is even a possible route to go down, unfortunately.

So with that I don't think Justin's proposal is unreasonable. Some
options:

  - We can check whether the old and new remote names are prefixes of
    one another. If so, we create two transactions, otherwise we do an
    atomic commit.

  - We can outright refuse to do a nesting/unnesting rename and just
    always use a single transaction where there cannot be any conflicts.

The latter is of course a backwards incompatible change. It feels quite
tempting though, as hierarchical remotes are just so esoteric. And then
renaming such hierarchical remotes with nesting/unnesting semantics is
even more unlikely to ever happen.

A slightly less intrusive way could be to opportunistically rename refs
in a single transaction, regardless of whether refs are nested or not.
And if we do notice any conflict we abort the whole command and give the
user guidance to please do `git remote rename parent/child unrelated &&
git remote rename unrelated parent`. Which is overall a bit of a stupid
limitation, but maybe it's good enough given that it is so supremely
unlikely that anyone will ever hit the issue?

Patrick
