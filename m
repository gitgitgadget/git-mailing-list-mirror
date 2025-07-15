Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98C3274FDA
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 08:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568027; cv=none; b=HZ6Vb7pFQ8E2LIl7/zMi5e6BqzCYf80eDwGiJ6q8wffwZZiKNg1KJuI8SbwGnP2JQHJsJcH/iQVp0PU1vJJdbeUZH4NKpqYvmAyg/CLtyO+WwdgaTtl0sfL8SG2rOZ5QsOHPYYB+9LmAZHM8rdSB8mVZHl72Ytf0kb58Rp8ydZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568027; c=relaxed/simple;
	bh=miILtn1z3kVm80hCcrRCBUyh40kRIMPuC5PH3vZ/oR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUllq/K8BGVauMMDOoGg41f8jcSjGoi0sHLWHFptXZAwa9LeX8rIIpIDreAc0UKBuL6SVPnY2WPbGvWXxc4QfF9aa7hPpIiCkRe/EtXs0MQAIVoT6U0XMensEoXn475/MLsgQyVztHRQBlZ7UymiQw/+BYeZzDDzos+L8Q8AZEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=v1y4uPjO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XmMHkV8m; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="v1y4uPjO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XmMHkV8m"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F22C414001C1;
	Tue, 15 Jul 2025 04:27:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 15 Jul 2025 04:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752568024; x=1752654424; bh=dRnhqYyo7u
	MjGgXXH5plwUX9PTuyeAuZzgxtUJ/3hXY=; b=v1y4uPjOGVdXOPfbLuiUMyDzVr
	Y6pfzRB3iyK4yHXygnWjlAuO2qoATU0uZgOHTIEj60vatehsViFvynhD29TUBfrK
	VHsyRV67rv94/uCQq3tq0cDddroCIIE/nBkkBKdksDyZ7XUfFnEk9ZE0dUgnIjI/
	AFr/4DPffycBBXHNw+5o6rpGZu3WNZwHE/L+O1hKisV4RyLdYldkAns7J1ZcAazG
	GbbWdOGaTxOh2tOY1u8pBOG8/rLXeftsaqS0fTI22jqLW2VNU+28GclQDQy5Qz3k
	MYEVf/FADF8A5B5ylBuc0ICpQU/RUpfoyzCYzZ/O02RZG7M+VVLLVUVUfE7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752568024; x=1752654424; bh=dRnhqYyo7uMjGgXXH5plwUX9PTuyeAuZzgx
	tUJ/3hXY=; b=XmMHkV8mUwSzpJi/7XDYSmeKmDqXobnoS5m+rMu/dt53rUdSh4U
	3G/SotSYJMhSXlA8gIfvdMMSi7MIArghhXDpB4tlKvE3hXQ4wCVXkrdAMyPNlAui
	E3HKKp3Y+lx6ZkXkNKgPxiOMJT6DXVH5QmRxfm/9bQa0pEY2Ny0InuDTx5+XNGl/
	yoqmk0pRleXq4GDUdSSn7ZJfgarabWo1mMft4qL3KfAFWrIIWUzeowhyqTzcGqoA
	XVMso513d3015hpJqFGkUDHA4GcIY1rq1ZzwN1ISXgF+RwGfbwxe5aNQE4DjJoXE
	qkMFdLCw2t+mcQSKEAZNcJnSRy5XFiJo0dg==
X-ME-Sender: <xms:2BB2aDyRWYFra2BJ_fPHMPxc6hPguZZGHmx6YPiq8BQTWjW6kpqsgw>
    <xme:2BB2aOjGbKtI2oDrSRYm3UoLZuBtUKw1nBWI3cartwb-FHqNIW9A0o2NVvDsvrsAH
    R2eaQ8ZEZqZrZ5d6Q>
X-ME-Received: <xmr:2BB2aGykry7mLPxEDnA6QLJfsQ63Dophisd4CxcMmOO_mpRJEojY04mdoG3dOT3nPu4e3kXKTxHzUcin6sC7CxtMDKX1WnNDNjD4HeDXY2H1QQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:2BB2aJKFc1T0UA_sEGmboTuwv4Rig46PT6XSZ1fd2KIkO8Z0Mlcb_g>
    <xmx:2BB2aFSMWohpfuBnuLXXwre6T4Lgc-WEyMnVUlK2gbVXkNVbYDfjGw>
    <xmx:2BB2aJpB5At_Q88pc2d17374gXJW55VyVkr0_u2sd4nl1aHBf_Bl6Q>
    <xmx:2BB2aCoLR4yZM0bFuAqqfoeyJXQ888eFv57JJ9AcoMuEq1PkhQQI3Q>
    <xmx:2BB2aAq6oKi1b2MC75s0PsHSaTXm3r384EFE92g8nn4pSQP3pK6MbIb1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 04:27:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e48dd0e4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 15 Jul 2025 08:27:03 +0000 (UTC)
Date: Tue, 15 Jul 2025 10:27:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/8] midx: track whether we have loaded the MIDX
Message-ID: <aHYQ1MzmSj82Vm-s@pks.im>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
 <20250709-b4-pks-midx-via-odb-alternate-v1-4-f31150d21331@pks.im>
 <kmprav735ntlgo3x47ptxyhqc6c5n7tyyub5c545gw2g4achng@sst72rcazce4>
 <aHBMGBHaD/Yfx/uT@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHBMGBHaD/Yfx/uT@nand.local>

On Thu, Jul 10, 2025 at 07:26:16PM -0400, Taylor Blau wrote:
> On Thu, Jul 10, 2025 at 05:16:12PM -0500, Justin Tobler wrote:
> > Looking at `prepare_packed_git()`, it checks
> > `r->objects->packed_git_initialized` to see if it has already been
> > initialized. If the intent is to start calling `get_multi_pack_index()`
> > for each source individually, doesn't `prepare_packed_git()` still only
> > execute once regardless already?
> 
> I was wondering the same thing. Perhaps that packed_git_initialized
> field is going away sometime in the future and this is its logical
> replacement (at least for MIDXs)?
> 
> In either case, that would be worth clarifying. If it's not doing
> anything (i.e., because we have no plans to get rid of
> packed_git_initialized), then I agree that this patch could probably be
> dropped, but I suspect that I don't have the full picture in my head yet.
> 
> > > Address this issue by introducing a new variable that tracks whether we
> > > have tried to load multi-pack index of a given source.
> >
> > The contents of the patch look good, but I'm not entirely sure
> > introducing a separate variable to track if the source has attempted to
> > load a MIDX is useful.
> 
> Yup.

Hm, true, you're both correct, I missed that we already have this guard.
I'll drop the patch.

Patrick
