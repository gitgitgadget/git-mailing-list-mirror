Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310757DA88
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735570211; cv=none; b=opK+XFcq2dJNp3dk1w4dGfz+7mWQE5TxrI8MWNw38fQD8ZkJubXbkYg/wWWwL+UlYnKl1nwx/wf3Z0QAxONKNI80mI59DuXORq2Wl1YDTtK2+tbZbZH9WLQOYD+lUxA9u/xIslf7WLGhNlpcb57PJtLFUDcAvvWBayTPlTW7bZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735570211; c=relaxed/simple;
	bh=HklM8AVVAh+C1qOS8QUS0kNBidWhpMy1ARabCwwalRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqmmRAcKJti3NoHDDmZncQYeekBkH0+UI1LT1/SX8VS9ywXGM8t+t/0f4Cz33izWkKu27Hu0cbHZmRrZT/l2WhMuTZtZDOhFNj5akaYh4EOEfUmK6ioGvGQkGKtR+Ie8JvG78pQ9uwdXHCGiuzKbzpIhRSl1f3GQNTZqkDLtFb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aT0OV0iX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fn/xXlcu; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aT0OV0iX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fn/xXlcu"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3B6A225401E8;
	Mon, 30 Dec 2024 09:50:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 30 Dec 2024 09:50:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1735570209; x=1735656609; bh=cmUDRn+gd7
	nB3sDy5YtE+x7jvc4lwbTtt1z+J30E+6c=; b=aT0OV0iXEJtN61i8P91IV9F8tD
	v5UmGCtR+qfW2Njqa6z9B2pPKWnZKKgu7GIBVhbveH3l2Wbh8V/CUXIBrgZLRL6d
	UCfvR49PSiulN48l4vphgGwulfj9733d3vAD9FEFi0SGIs1hhNQzL7sbTeHk3RpF
	1rfYlt2xzR1bDFPzkxO94z3iLBDcSt+gEmUu/J/hI0EZOQbW7p/yrHnNdHU7Gqxr
	h+7dww1ctWj/F0zBo/GeFAoK0iJGZebrAYE0PbHHe6sRJl37BAB37yjPuj+vSk4K
	nCdAj4H1z/FbebEVMvnn7M7zy7dHkQTqgfPQ0t5RQhokLviqWT+6r5coN+4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735570209; x=1735656609; bh=cmUDRn+gd7nB3sDy5YtE+x7jvc4lwbTtt1z
	+J30E+6c=; b=Fn/xXlcuHGn7rWOoIj+r4a5RM++lhxpwLKe87RTZ86bdFAai4G9
	v6Grnuso9Wyy5zPGXLWo73bKVAyEclmYFTRJxVd18In0p2F5/zkDwK3A0d+wL21s
	/QE2Ed5NsF3n2BjWP3I7g7zH8hKtBmZQg1ZLP5vh+ftk7+8bGHjigNAvFPo2idLn
	4E3UjGaK9RwbnzZe2a46ik0lV4Yenbs5wCCTRREVDlF0WtWwutHzGJN2x8bONOBV
	CwKEUIX0LY5l3+0OaQlF0NhcPxhZl4UkRwkm4wZA/aMga/1qPxW7vcyc01lvPy3A
	zkHE7OUdi7L7QG9JgjE1YmwGXI19BoOS+dg==
X-ME-Sender: <xms:ILNyZ-jWgb-PlJs5ouRBcQ0IfVI4hsMB1RWwqdBAyNb6Z5hj8BfGYg>
    <xme:ILNyZ_AMM8d62j5lpjq-Essjf3ugrR5di9HVgqreZM6y1mnUEzIg0nP_dmc38EP33
    QEwrk3lmCVAmoSLXw>
X-ME-Received: <xmr:ILNyZ2F6_LJg-cfHntzWgAe_jt52aSH3AjuvshPQm2uTBYnuUZqfx6sc9n84Qn2vBhTvu50QHUnBu3VWz68SoyR_ExIW8d_qOtZY6R0M8tPEpZl2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddviedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgv
    sehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:ILNyZ3Stwj9CIADZV-K7hCKjOpqZcDz1gvgvA6znTSeZ-uDy0XCO-w>
    <xmx:ILNyZ7zW7ciRR1O8WqFftKyl_n0miPcBNnPdnY7nEcYflqOWD8RNNw>
    <xmx:ILNyZ17yZ7p8PoK1sCi2Z9Y32Ydm9S6BiBnNu7BxkulPh_vcL2A91w>
    <xmx:ILNyZ4w3SCdHusRq2jb-zYA-pZbBq6Lk3e8Sbwu5aDpKKyHprMbWPg>
    <xmx:IbNyZ9ur_DqeBS4AVZ4Kg3nFqoLs-PHJnD1DEleHZ_qvPwBqhglALvzl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 09:50:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 78fd863e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Dec 2024 14:50:05 +0000 (UTC)
Date: Mon, 30 Dec 2024 15:50:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] object-file: fix race in object collision check
Message-ID: <Z3KzHJagr_3Fkz67@pks.im>
References: <20241230-b4-pks-object-file-racy-collision-check-v1-1-11571294e60a@pks.im>
 <xmqqy0zxz11m.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy0zxz11m.fsf@gitster.g>

On Mon, Dec 30, 2024 at 06:40:53AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > By definition, two files cannot collide with each other when one of them
> > has been removed. We can thus trivially fix the issue by ignoring ENOENT
> > when opening either of the files we're about to check for collision.
> 
> Thanks for digging it down to the cause.
> 
> It is more like even if these two files collided (i.e. have the same
> name based on what the hash function says, with different contents),
> when one of them has been removed, we have no way to check if the
> collision is benign, and even if it were not, we cannot do anything
> about it, isn't it?

Depends on what "benign" means in this context, I guess. We can only
assert the most trivial case of it being "benign", namely that we have
computed a packfile that actually is the exact same. This is also going
to be the most common case, as everything else would depend on a
cryptographic collision of the packfile contents. And in that case... we
cannot do anything about it, yes.

> I do like the simplicity of the solution.  I wonder given bad enough
> race, we could fall into a case where both files are missing?

I was wondering about that, too, but it would very much feel like a bug
to me if that were ever to happen. So I briefly considered whether I
should treat the passed-in filenames differently: 

  - One that must exist non-racily. This is our temporary object or
    packfile that we want to move into place.

  - And one that may have been removed racily. This is our target file
    path that we want to overwrite, unless there is a collision.

The idea would be to only handle ENOENT for the second case. But in the
end I don't think it's worth the complexity because `check_collision()`
is used before rename(3p)ing the former into place, and that function
would already notice ENOENT anyway. So we would eventually just die the
same.

Patrick
