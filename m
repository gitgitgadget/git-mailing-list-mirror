Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2E9371CFB
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 22:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775082172; cv=none; b=UO/Hayl4m34CaP5zccJmQZ386NXzhBLoEXEHzfeV2AMOVRb7OoGNy2S6BXQUGAy2QD/tsIyYigt/Z2w0APwHxXTXMKl+RC+ELQKkehNGqcnBIFiqdPYvNTF1tiZddZfVwuIoGTPMCE09IPuMd8AAwiCtxs/7ckQq6FlMzUmp2+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775082172; c=relaxed/simple;
	bh=Zd8QA03KdwbHq7eYIXlimsoJVSRaMx8Ng/6LrSLdeuY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LRdhEsg3HxRJSFWOGE+ivDU9ONBPkR/eAoVg5dkIsyGM0ywBSGCMJ+wCq0bkLrVH0bIQPwD0rvtwG4Xlg36TVkBONNmn8L+TbeoSACxyigQXn26WTxfTf0PahqUzq3/f2WslrrZqgF2Ga/FoVx4HoP2+CHG7q8N0p9i19FQL6Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lD7emk3Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LeyNWNq8; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lD7emk3Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LeyNWNq8"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4CF1E7A0220;
	Wed,  1 Apr 2026 18:22:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 01 Apr 2026 18:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775082169; x=1775168569; bh=s6dST3104V
	mWg1Z/p4gC5npb26fZ69LdHs6oQ3kiEiI=; b=lD7emk3Q5X9KQv3Ya8YTHhcuxk
	AGfU4r0LsUmehShHJzrAh7ofLcDAV0DKRV5stpxaZWP7FloHHa6Z182wj4e++x6m
	b85k5GjnuBuLxKuqcBgKLn4cmhyXEQtT+clayAM10x6uSxJYycWzCTUKN7G+ZVKn
	nDlUi7rkSKPF87NbOoz/kdkGOWFE0SEDbqd78DP9UvEw/bBQECqQSuaOz2Jz42Ui
	mD6AiNfVpQaW54GpxRa/geJYeZ3AYEXCznXTKa9O+KfJKLel7ZA0CU4H/w6MZM4I
	e/1xatvEi1W9wuu+zyfV7RxeVrFgfclw/2oDoZNzx+RHtkWb3TczyOpCbwBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775082169; x=1775168569; bh=s6dST3104VmWg1Z/p4gC5npb26fZ69LdHs6
	oQ3kiEiI=; b=LeyNWNq8G7yn0TNjJ/ukMh+Zx6ir1HLOK6NBbVF/aA+tZ3Qajs3
	vFKosND05Ge23l1/W5tyEPjq34hraVxccy3vclZnkVxRlsMsaKgAyx1U3SY9HTs1
	++/Nk1WC+cD+JpdY32PuTJxDdF0gqboSzmVJ6olwYHn/TjawN9veC6LExWp4VNjY
	gEVWSD7T3DkS4wgynhBxvVE8LJYoZaJKPE/LNFN9LABPh/aqNDl8fX5pMsqCAW8a
	zDbPCwA2K4I5R+KrJhYP38qFOqPefRwMd3XfsEllYhK9pliCPsDhibe0LgKZP/K4
	a8WybLgv4LscGiEL/E6D5cbqgkhkz5timOg==
X-ME-Sender: <xms:uZrNaTLNcs3bTsycYex3X-1rV_BVbRfXXj8xjorDDcogl3Z7DXPIJg>
    <xme:uZrNaa2LxRsDFa9YIVWwB5fLz8CJ8_Mi6uI_Xr_yWPNFtLFgsoSY2_e5efuIeID9i
    nQqvOBPUxXfRbhvb9LOvOlpQ6rVbIpH1u3i6TVeZwT9U9TGAu0NKA>
X-ME-Received: <xmr:uZrNaVhB2WA7YPEqWJy2mfeWkSyxyNEHzHQt8WCeMM-Q2ZDZeqIU8ZC54B57KEkdGIHraw2A5RO_67ist8ptzu6TJwFK397OeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehgrhhusghigidrvghupdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:uZrNaTVSQ97ZVhW34aWVr0Fs347vuspcBpQ8T4YAVhAUNd4yf7-7ww>
    <xmx:uZrNacVt10M1Y-cDqoBdCR9oWICZEyDqrGXTc_EBeyMgddpOVftOtg>
    <xmx:uZrNabjZJAb6W0DIkcpASX2AsIOw56SyMPMd5lZqljMGWAtvfdkHeg>
    <xmx:uZrNafZ59Aw1qFlIH8f2ri3A8xhD-gL4-fT1-LMxUfW3elNMwIWD4Q>
    <xmx:uZrNaTkUZFKmJluTY3aeNPdkF-MMZYuv2aszy3ohfbKN-E6l7H6JO-Zw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 18:22:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Collin Funk
 <collin.funk1@gmail.com>,  Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH 12/12] refs/files-backend: drop const to fix strchr()
 warning
In-Reply-To: <ac0h0xwqLdX5u51v@pks.im> (Patrick Steinhardt's message of "Wed,
	1 Apr 2026 15:46:59 +0200")
References: <20260331233856.GA2327197@coredump.intra.peff.net>
	<20260331235341.GL2328529@coredump.intra.peff.net>
	<ac0h0xwqLdX5u51v@pks.im>
Date: Wed, 01 Apr 2026 15:22:48 -0700
Message-ID: <xmqqzf3mtj5z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Mar 31, 2026 at 07:53:41PM -0400, Jeff King wrote:
>> In show_one_reflog_ent(), we're fed a writable strbuf buffer, which we
>> parse into the various reflog components. We write a NUL over email_end
>> to tie off one of the fields, and thus email_end must be non-const.
>> 
>> But with a C23 implementation of libc, strchr() will now complain when
>> assigning the result to a non-const pointer from a const one. So we can
>> fix this by making the source pointer non-const.
>> 
>> But there's a catch. We derive that source pointer by parsing the line
>> with parse_oid_hex_algop(), which requires a const pointer for its
>> out-parameter. We can work around that by teaching it to use our
>> CONST_OUTPARAM() trick, just like skip_prefix(). Note that unlike
>> skip_prefix(), the function is not inline, so we can't just wrap it
>> using the same name (otherwise the actual definition would expand the
>> macro, which breaks compilation). So we rename the actual function with
>> an "_impl" suffix, and callers will all use the macro.
>
> Fair. In fact, I was a bit torn with the other commits whether it's nice
> to reuse the same name. I guess what it buys us is that you cannot
> accidentally call the wrong function without the guardrails. Even though
> that's quite unlikely with the `_impl` suffix.

I share the sentiment.  If I were deciding the design, I'd even go
forcing the _impl suffix to everything, including the inline ones,
as I found the earlier "strip_prefix()" example already confusing.


