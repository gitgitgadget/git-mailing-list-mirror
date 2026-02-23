Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7117C1534EC
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 06:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771828449; cv=none; b=OtDymQyv5U5qG9sQweeNDNG0h11H6nnOkI4njcCrhrSoJ346zUszJkIlfgUXu/uQI97Ug4/mDXI/uuDpnRLWZpqaJZSjg42uT1JqoC/r2mOCKnE1WIW4VJcP3PvHBCuXqbooe4+WYRPkyBaaQOdU0yI4WtJPPSFNGoQi86wVyz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771828449; c=relaxed/simple;
	bh=DJ8aJg3AiBSvHSIPEESdYiKc9UXqO7qF2s00YQpgaWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/4cAVuMOcQ+qd4W8TYJAW/lpp4R/AvaCbr7MeVGhZi6tGuJl5TwaJU/yu6756WonSX/8XWrFdGiGDo086Hb5ANEeGprAyNX5VgR4tRoeC9Gm3YkG8oAygkAVTrdOYUU+RnUGK9hwfa4POMsxih4IvJ21D+1BTNd0nWSSSvTg+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=madKkb8X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GTewJxg0; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="madKkb8X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GTewJxg0"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9EE8F1400012;
	Mon, 23 Feb 2026 01:34:06 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 23 Feb 2026 01:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771828446; x=1771914846; bh=O1bkFaM/6C
	wj62ciETbW4CVK01WghCuAScTKzw96NYs=; b=madKkb8XBBRMddyS/VK1x3sfIe
	x9ips0X+KcOqtVDGvmlbMfqZhNnqhxTOkAQ/DUSbGPGY43r965W+IWXyGqwJPpFe
	BPpBLddHtduV+2l7p5pGLK5+pQLytUhWXZ5iPvsZ9rVxi5fS/mIf0l9pndigA9kR
	4y76XPQPljjlUuXMbAoRg51hag1pVhZTc9NVRFuH3+63vT4FNr87J/7vX9DMnzRs
	osaNYFUncztdeei+AKdNpi63nEiIm1AVD2U3GzzVTXyKBqnZu3nHq6gkuZcm6NDR
	FBxU8y91sEPODFAVwkmfQhJ4fb7XixXsN3okZ/hhC1I5JdgDt6vPMCRG/Y3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771828446; x=1771914846; bh=O1bkFaM/6Cwj62ciETbW4CVK01WghCuAScT
	Kzw96NYs=; b=GTewJxg0V7tcXzFoBrx1k0anuczQuVUyuLvUdGFPm5B/uNQgMRf
	/F8n4rtzbNrbjMzekSIWCG89ARJkdaTrG5GoZk5Nf2pNc8Bt8dtcq8yxCv1+EHw8
	7dg6WTK6ELLmhZqL7BQeE5Q371XkwJgzul910/YhllDHZoLUgrGkAFNWV5+y8LfS
	L7/kcfanTDVDnh35LDIWFDYeljA3FMUCx2LyLV4yISid+9LZClGvWFZP37YwHqAT
	gw88Crggfo8GKz4j0i5JgWU1CabUWtUZO5A1L8HgTyjzp0wTPv9tIzP8c7NPWgFC
	MbUPUXDY76o4QbO6zMnkOJMsSuzfU9epd/g==
X-ME-Sender: <xms:3vSbaVwKxLn7ubRH1t2Vyzptt1aP-OJ67xTEvXqAcyWZajQIcLRLUA>
    <xme:3vSbacL3w6nptBi5cM8HRuAKhSOQuGb89wYvpT5zsshXxu5q4_NkWOXF3-KhvqIAD
    stJ0d5pntcaSuRnbwvleTwgCes-T1DColCJjQvAHBRkxUhE_v08fw>
X-ME-Received: <xmr:3vSbaXpc857g6Y4CMEiVmHXxfHbFSuEk-HAj6pUNvcZDLBlGx3B2-oGBPVP_LYmcwp7xI2PexfWbPbPkNN0_n0mPE_ksLm4KFSrL0lhY8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeeihedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveevfefhhfehtdekheelfedtfeevveejjeelvdekfeffffehvdejhfdvleevffdvnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhdpuhgsuhhnthhurdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdp
    nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhithhhuhgssehprghulhhishgrghgvvghkrdgtoh
    hmpdhrtghpthhtohepphgruhhlsehprghulhhtrghrjhgrnhdrtghomhdprhgtphhtthho
    pehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:3vSbaTImzeRTlND9Hr_mATltx4JOWgKqLZwXn4n0PpGzy5gT8JSNig>
    <xmx:3vSbaUTs14ISSzDfx2Ago7GGEZLb56dDly8ifpQp5ueGWYHRHjd0zw>
    <xmx:3vSbaasK4X4gkkAlYFWJDHLrO0VXX-MKW5UWz_qiwC1c8U2b2NOxZQ>
    <xmx:3vSbadZ0RKtSFJQ8iaxhfdHKIrzp29VWKZLeluydOaiUXM6jKnZbdg>
    <xmx:3vSbaSk69iUdqq-jaBnONdPAlSbrNOGFYv1lmN5spV68W6VxbcYA1rBd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 01:34:05 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 827c4677 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 06:34:03 +0000 (UTC)
Date: Mon, 23 Feb 2026 07:34:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Paul Tarjan <paul@paultarjan.com>, Paul Tarjan <github@paulisageek.com>,
	Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v4] fsmonitor: implement filesystem change listener for
 Linux
Message-ID: <aZv02KjfheyFlMfb@pks.im>
References: <pull.2147.v3.git.git.1767099302592.gitgitgadget@gmail.com>
 <pull.2147.v4.git.git.1767202894884.gitgitgadget@gmail.com>
 <aVuplzNaoCHlZG3S@pks.im>
 <xmqqikbrvz2l.fsf@gitster.g>
 <CALvWuB70kwPAnQ+v4ch1TKMDxbUQgi5NP8NX7tbCZRqivJ=vig@mail.gmail.com>
 <xmqq1piet47r.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1piet47r.fsf@gitster.g>

On Sat, Feb 21, 2026 at 09:07:52AM -0800, Junio C Hamano wrote:
> Paul Tarjan <paul@paultarjan.com> writes:
> 
> >> I just noticed that the discussion thread went silent after this
> >> message.  Has the patch been reviewed and tested well to proceed,
> >> except for that meson-build support?
> >
> > I'd love to see it integrated upstream. Is there anything else you
> > need from me?
> >
> >> > This would also need the below patch to support Meson. Would be great if
> >> > you include it, otherwise I can send it as a separate patch once this
> >> > topic lands. Thanks!
> >
> > I'd prefer to take you up on the offer to send the meson support as a
> > separate patch.
> 
> This part of your message is one thing we needed from you to unblock
> ourselves, I guess.
> 
> Patrick, do you think you can help making this into two-patch
> series, the original one being the [PATCH 1/2] and update for
> meson-build in [PATCH 2/2]?

The changes I sent should be sufficient, so I'd propose to just roll
it into the v5 patch.

> > I'm unfamiliar with that system and the suggested
> > patch failed in CI on some dependency installation steps which felt
> > unrelated but I didn't want to debug.
> > https://github.com/git/git/actions/runs/20720903513
> 
> The topic has been in my tree near the tip of 'seen' and I do not
> think we saw CI failures coming from this topic.

Yeah, I think this was simply a flaky CI job. The "linux-reftable" job
has failed installing packages:

  Err:3 http://security.ubuntu.com/ubuntu questing-security/universe amd64 Packages
    404  Not Found [IP: 91.189.91.83 80]
    File has unexpected size (89328 != 89310). Mirror sync in progress? [IP: 91.189.91.83 80]
    Hashes of expected file:
     - Filesize:89310 [weak]
     - SHA256:16943889a9abc4aaeb0e701e99db0004ac0241de728183f7a2923bb7927b107b
     - SHA1:fac9e79fb36b57de3770e639c4b5bf9231342f15 [weak]
     - MD5Sum:8cf081c59fbb279da27867d94f2b9520 [weak]
    Release file created at: Mon, 05 Jan 2026 13:30:45 +0000

And all the other jobs simply got aborted because of that initial
failure. In any case, the changes work alright with Meson on my system.

By the way, I haven't yet done a full review of this patch, I only
chimed in to help out with Meson. But I can have a deeper look once v5
was sent out.

Thanks!

Patrick
