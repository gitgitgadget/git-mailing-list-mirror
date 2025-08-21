Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3780D2BE650
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 06:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755758446; cv=none; b=m3hbjooJSUtZhNGhvyMJj9QKQeMYaqrRkA+CJDqbDzGUewLlJlXht5PBUZoqrbNaxA+bnANU93wt1YXd4q7goJtVQH0iHsGZSyp7bFlK5r2zlNjkaZWeUbCSBgwVgac6Ztf86mCPasjqiggHTgk3cVnNxq3GoVXOIp0ECZU4Nvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755758446; c=relaxed/simple;
	bh=aOb8ObYJ6bYSGa3U1JH5I+QziXzv3smIKp5LWu+jK48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVM7TepzjaK+RLkvxmV3mOIDNB3TZSDGseS5woC0Pxfgc+RCAmbvCWHvf8iH8UPYYTlqIr7+P3hdnu2HGJytmTOtVmVOZWvnPKJAMrDaSinEZ0SiVVJXztK3+xwEWyYth0f1Fv7kZPoB7DShsYPzYxv+GKS1grpX4sxAg0rhCZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bECtGBmh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mXvHppab; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bECtGBmh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mXvHppab"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0F8DD140005C;
	Thu, 21 Aug 2025 02:40:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 21 Aug 2025 02:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755758441; x=1755844841; bh=Cmzl42fxjq
	IYlZIE/7171vVMw/6A16G4JLjSpidL7JQ=; b=bECtGBmhTPQI1vseukC2yyN2S4
	we0J7nzjKv5+3XOprieMqhC0hqBmys0SV9rqmR1PWSrF1mBZuoEXfzGGGM93mu6b
	cqtoQ6WUFymOHncJfH9/6Ur1zKKNAdhc6nh7L15brlfmLQC43LQWFIeY/couOqGc
	ONPbdwukYQcEUm/vjbyrMUsv/WqFMMHnEr8fpa8FbSgrVeZC1OFL1/DGseL5DdvL
	LRVMll41sPCVkPr6yWj76jOfTpf5H9fVO1P6P0QSnLMyy8JYY9uAWH5m/2BUiWx2
	R9ufX4Xz6PkrD16HsSehQUeRYoQNE/oMdRVSPHi7FzOj1f0bONarNwHQjoOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755758441; x=1755844841; bh=Cmzl42fxjqIYlZIE/7171vVMw/6A16G4JLj
	SpidL7JQ=; b=mXvHppabEd0H6pP2jkpvgmjyVX6XnnuECr2iF8E3SfjjfGzC+9H
	AvoxIBMHqWdntEvJVAExSoyKteqF2nd6Uev+Nz0NGYjGc7OzbrW15sJrBv3UMazT
	zvzhGbDmfb9S/43W+2J8iXb4HwfharKhWgge8hdxw5V0rYbiw1ULguuwqYv194yb
	BpZNJq7hQGNw96pJrxoMaHp4iPQptAEErjTAJEciDV1mBEV9hNoeiWYqXCK7QA4s
	aFn/TsE/7SJIRcPLEB6L6Moac3qqjHMoVQ/tetK4MyxLhM08BhMz8bAnUyGmMR5W
	n1cof72z3q162XGiyniOoBES6Qk+Mjh6sMQ==
X-ME-Sender: <xms:aL-maPDy1VecIK1mb4fXTtyrbLz9myPsbVPmbXK2GwVa2I4cZ14Ndw>
    <xme:aL-maIwYGuhm5ERKz8oHWusP4cDMR_yesKbnWBlWQLdc5c0b84ylHOzg9qsOZEzR3
    k9tDlG66rtA9PpRow>
X-ME-Received: <xmr:aL-maEC_BDd_TgnidXPfbRnLbyqvPTco0hHeqyeS7mrX8GTAIeCZxpMgF_TZOFiX8a2LDAPRtT4uKvA-TLNYPNTo664y9qC3EhD-IAcEwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:aL-maNZpOuob2eo0CVP11Q4KKfQlJbrtZN1EDyTuU9GnoVFMbwuUCw>
    <xmx:aL-maEjVzmUbb_E4qM3DeuEuARu5JOQannCquVZIETKDzEUP6i1Qig>
    <xmx:aL-maH6J4qiu68qcE-eIKL3s2ZWmKyfhYR2pM19cvulPaTpeH7h97A>
    <xmx:aL-maD5_UterG6FZ7DH76yQFDp-3GLixhQideBpkQpmIeHRg613ayQ>
    <xmx:ab-maMYwMnst01MJpodcLOsToLtwuOSGnJZKs1lEJJdrZoov7k59qWZ_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 02:40:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0cbc60f7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 06:40:38 +0000 (UTC)
Date: Thu, 21 Aug 2025 08:40:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 05/16] odb: move MRU list of packfiles into `struct
 packfile_store`
Message-ID: <aKa_V_Iyv4Kwtmx6@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
 <20250819-b4-pks-packfiles-store-v1-5-1660842e125a@pks.im>
 <CAOLa=ZRfWamERa_tKenhnxaGnH096p8hGYjauzfw1UzzjA_T_g@mail.gmail.com>
 <20250820192008.GA1662788@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820192008.GA1662788@coredump.intra.peff.net>

On Wed, Aug 20, 2025 at 03:20:08PM -0400, Jeff King wrote:
> On Wed, Aug 20, 2025 at 05:44:36AM -0700, Karthik Nayak wrote:
> 
> > Question: for my understanding, so we maintain a list of `packed_git`
> > packfiles in `packfile_store.packs` and then the same list is
> > available in a MRU form in `packfile_store.mru`?
> > 
> > I assume this is to optimize searches to use the mru form? Is there a
> > reason to not pick the mru list?
> 
> Yeah, I believe you should find the same packfiles in the linked list
> currently formed by packed_git.next and the MRU list. When I introduced
> the MRU list long ago, I cowardly did not want to take the risk that
> somebody depended on the order of the original list, and left it in
> place.
> 
> I think it would _probably_ be OK to just keep a single list (and
> manipulate it to keep the MRU property). But whoever does should take a
> close look and make sure that is true. The biggest risk I can think of
> is that there could be some code iterating over the packfiles, coupled
> with object lookups in their loop body. If those lookups reorder the
> list, that would screw up the iteration.
> 
> IMHO it is probably better to do a change like that outside of Patrick's
> series. There already is a lot going on with moving fields around, and
> consolidating the lists can happen on top (and would be made easier for
> having pulled it out into two adjacent lists).

There's in fact been a couple sites where we _didn't_ add packfiles to
the MRU list: "builtin/fast-import.c", "builtin/index-pack.c",
"packfile.c" via `prepare_pack()`. This is no longer going to be the
case at the end of this patch series as we in a later patch adjust
`packfile_store_store_add()` to handle this for us.

But I agree, this is something I'd rather want to push into a subsequent
patch series. I've already got one cooking where I change how the lists
are getting handled, so that's a good opportunity to do so.

Patrick
