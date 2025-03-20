Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6F219F103
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 05:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742448041; cv=none; b=BqMlwOGq1CUqQcUnWXV402Si7K7FTs6DHmzF2+BsyfKfsDnqJY/HMrXabDIdv67/572zZsmzb+gWngwoN8muaF7XXvuPcoh8HMd0b4ix30v+F6t/T2bqg93zyh92VWAuc7t26ruGPbLfCo9xAu7TJTCvQXsXT/ufdqo3yQjN/sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742448041; c=relaxed/simple;
	bh=lFVyJ0pNvTHBqtQ11hfDVfAJ/3km+v6pMEXSZdDhzik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gok5nwwG1qGuwxdwCNsTTNBu9V2KncyJTQfTpmoDHsAdZ2a6DOcR0SS7fe5NdU5RGpJI5Z5TLaNqiRtXfI/3q0U3nDqK1BkZW4SrUE7cwLFMS9q3n9guXi30ScfIbTZmftwRHu/NOA7F4ocFtu73TDGHnCG1Ll3Gn3yt13zRs3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V+euWyrP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mgoBRPtU; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V+euWyrP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mgoBRPtU"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6A56125401EB;
	Thu, 20 Mar 2025 01:20:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Thu, 20 Mar 2025 01:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742448038; x=1742534438; bh=yuhYtV+XNP
	iB98bQZQgjhUGG2XT6bvqFOAKCc4r5tTU=; b=V+euWyrPSJPoQS/DhYoJmGRyLn
	kd+xaZKcvKZSy65xo5oSwoiNSnKe9PPkX3dFvIM6WjazZd5Yxnu0k/9bnoMgA5Ja
	R7WneB/fFeB1r3uv/Mla4oX41jxpeW/wbjFvYQ2AHera6mDdi8crnOMNiytuyh/B
	x48iG/FBbL8horgV/FW2/9YlIVDGXO2ThoT7lpfGyGhNDgHXb6UZ9pOpYSG8a1Lj
	jCn+nNw/gGgRI08u1Nasas+iauQvTT5VPwgYBjceJguJ3SVO2OUH/dWFmxrbQ8oK
	cZ69kuDIevpZuvC7OJQal+91ThqFUBtOcUlXh2cOFiuS0h0dDRH/qip2qg7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742448038; x=1742534438; bh=yuhYtV+XNPiB98bQZQgjhUGG2XT6bvqFOAK
	Cc4r5tTU=; b=mgoBRPtUvoLTAJC8xIwM0QmBQRbNgcznkV3ne3E7ziEQowylO05
	CUtpwtvWkz05EK1E3tGXN6t9o7F9NqmhlqGMEk8G2gy1htdNWFHUux4kwOC6xsKB
	h+viHgJW0/7jUNhDpFBb52ySLD8wzBw/hLTYj6yJFnWMD2DzrTLP6kMjc0TansaF
	XPGy9l8HZibNkkabiUbC5h3IwudEpI4MBxnd3juQLBMjKhyH/LyWa5+iX+Ofsh23
	h+aFOuoJ6KS2aOIfCWV5nuWNz2E7H68463qPda1ey9/Lzop9a1ttlf9HftGKaD2t
	Wx5frt57hL0MCkJ2E3gV6fjC7Ljbfy/UnNA==
X-ME-Sender: <xms:paXbZ-NEFfka-pCibMfgPi17EI6olKT9F_9jGetQqNwSZJpwruSZZw>
    <xme:paXbZ89iLM1mSUXENOG5leZ90sHwsFtpz0UfOxbCx_MsnSmYhkpp6tJL7HSeLALRl
    KEDZhgCkii3CwhpHQ>
X-ME-Received: <xmr:paXbZ1Rk4MwBEXLW0-ZtO690iphL074gT55Y8zc3BhDf4xFTiej--JgpECSDU0peINn3OasaxpGFoVwY8O_12tgvlp8KGo_1-n8kv250-qSK_4s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepjeetuefghfdvfedujedutdekheejgfffiedvvdef
    ffdutdfhgfffieegleevtdfhnecuffhomhgrihhnpehphhhorhhonhhigidrtghomhdpsh
    houhhrtggvfigrrhgvrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghs
    rdhplhhushdrtghomhdprhgtphhtthhopehgihhtseguihhnfihoohguihgvrdhorhhgpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruh
    hsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:paXbZ-ubAXBca1SKSXgCxqxAtKCe5RISRUQbZlwFrW3cktXzzo8Tfw>
    <xmx:paXbZ2dJrOUUp7IWq2_kPw-s_kRHJMIWeWYc0MR_jUALrcmIElIHyQ>
    <xmx:paXbZy1nKBJPf4VwJgqmR_Xjg-o4UC4_ldXcTCiwWVoao5cWCbua5g>
    <xmx:paXbZ6_t_52NKlzh-kUMOO_XUHnpidUon6D2fOKm6qW5pHBCgYvK_A>
    <xmx:pqXbZzE5_TtjJIDXDqsyDbdRaerw7ef-UBdjDASVLW5Bl3YQVu5MUayn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 01:20:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3e0b0b7f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 05:20:35 +0000 (UTC)
Date: Thu, 20 Mar 2025 06:20:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	GIT Mailing-list <git@vger.kernel.org>,
	Adam Dinwoodie <git@dinwoodie.org>
Subject: Re: [PATCH 12/12] config.mak.uname: add a note about CSPRNG_METHOD
 for Linux
Message-ID: <Z9ulomq1tDrZRsmL@pks.im>
References: <8c8e16ae-87a2-44bf-a87b-7422eb04fec2@ramsayjones.plus.com>
 <Z9YbJFJjtXNYnTzk@tapette.crustytoothpaste.net>
 <xmqqr02wbtdn.fsf@gitster.g>
 <Z9rG3JVA5vSoYynt@pks.im>
 <74b2838e-1d7b-4ee0-a4a7-e3d21f4e6597@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74b2838e-1d7b-4ee0-a4a7-e3d21f4e6597@ramsayjones.plus.com>

On Thu, Mar 20, 2025 at 01:28:31AM +0000, Ramsay Jones wrote:
> 
> 
> On 19/03/2025 13:30, Patrick Steinhardt wrote:
> > On Sun, Mar 16, 2025 at 01:41:40PM -0700, Junio C Hamano wrote:
> >> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >>
> >>> When arc4random was added to glibc, the Linux kernel CSPRNG maintainer
> >>> argued that it was not a secure approach (I disagree), and convinced the
> >>> glibc maintainers to just make it a wrapper around the Linux kernel
> >>> CSPRNG, which it now is.  So there's no actual benefit to calling
> >>> arc4random versus getrandom, and since it's newer and less commonly
> >>> available than getrandom, as well as slightly slower (because of an
> >>> extra function call), getrandom should be preferred.
> >>
> >> This
> >>
> >> https://www.phoronix.com/news/GNU-Glibc-arc4random-Functions
> >>
> >> was the first hit of my search in the area, but I think you are
> >> referring to
> >>
> >> https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=eaad4f9
> >>
> >> that happened 5 days after the thing got in and the code there tells
> >> me that your summary of the situation is quite accurate.
> >>
> >> So I agree that dropping this patch makes sense, but do we want to
> >> do a bit more to improve the situation?
> >>
> >> Here is an attempt to improve what we have in Makefile (and possibly
> >> the Linux section in config.mak.uname, but that is improving what we
> >> do not have) to tell folks that arc4random in glibc is only for
> >> compatibility and they should pick getrandom() until the situation
> >> changes.
> >>
> >> --- >8 ---
> >> Subject: config/Makefile: a note on CSPRNG_METHOD choice for Linux
> >>
> >> arc4random() was added to glibc in July 2022, but quickly replaced
> >> by a stub implementation that wraps around getrandom().  Hence there
> >> is no actual benefit to calling arc4random() over getrandom() on
> >> glibc based systems, at least for now.
> >>
> >> To avoid enticing Linux users to choose arc4random(), leave a note
> >> that their arc4random() in glibc is not the same as what their
> >> friends use on other platforms, and guide them to use getrandom()
> >> instead in the meantime.
> > 
> > Makes me wonder whether we should also change the order in which Meson
> > auto-detects functions. That is, do we want the following patch that
> > favors getrandom over arc4random?
> > 
> 
> That was my immediate thought also. :)

Okay. Will you pick it up in v2 of this patch series?

Thanks!

Patrick
