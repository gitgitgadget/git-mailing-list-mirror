Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ACF2E54DE
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 08:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764576872; cv=none; b=At4Fu0Qk366q2d1N4XxB0JVRI/lcriFKy2ZGRcpNZkEh+No3LvqXphQ/zaqQD2Vrh+zFswX0IoP7IYSLG8Nab2xSFxRwOuJYILdXQEZbO5+ELiwQhD3fN7DWMzb5SxK2D3X6yDj3D3COxTeROYrL0yyXyesjiEibpDy9To5Jymc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764576872; c=relaxed/simple;
	bh=UCIDiiwUy4Yy4qpyTIeECQZeot9B/qew8Sxpn83b46A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/45wJxxk+P1UEge9YrzaBAZtaydzEHs07eHzVLHcfvYSJHX8TTjMSHYjfA3LohrX4Q1tIuxVGajRT2SlRt+d21PkUI87PxU7Ve7QdYg9AsijO/NPknjadMxuPYt+/lPo2E5rPiLt8rins03pLmlE0etWITi+5CRIj3989N0Hy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ow6zjCqb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IrtbtdSB; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ow6zjCqb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IrtbtdSB"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3783014001E8;
	Mon,  1 Dec 2025 03:14:29 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 01 Dec 2025 03:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764576869; x=1764663269; bh=obv81uAaL4
	3Apx/6HbQRlIENWQ6OkNJJbA895LpuEWk=; b=Ow6zjCqbN6xIm/h4QFBd++IPuk
	vJ4Sj6A1oFHEHnL1JlFki8ddz5iaWd0JMrkRp5LMGYGsNweskLrUK8dxwQ5SBghE
	JQWDZXihN/2DBnxzfLHLF8yEtYhStfJmmvOeDyCTMIaJy4IKxUh1iApsw3q6M02n
	cHdpxx9C6JI0zz+M/ergW/nRBZ6TcUlStjoR5RH1XH1edv55yjHTJolbrfYt5UmO
	9iwDOkZpq+MtIwMtW83CsDHLVrknTFYiAIgWvR3mXDf70OLE9RDrPntrwKwwkgPf
	L6+9UKv992or2cY0/b4LXusWI21GswFWJJqrlloZh07tD36HmOKsK//Rx1Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764576869; x=1764663269; bh=obv81uAaL43Apx/6HbQRlIENWQ6OkNJJbA8
	95LpuEWk=; b=IrtbtdSB2koMqqYnxiWDit7BTOdnT3sHWp5kvymS+1ZLQ/bImyp
	pUEisKxfZrmF3C2bhd+KZmumowpHFRyDMKT5nHBvrHluTLsnLpcBYyFagpf0XTNA
	bfzG1iBEuhZXC3vOOrr9B2K3tsXrzoMryLPcqMAwdsXgTXWIIhHUvfW1c+H59gBy
	XSq4ymffJo5KX0FNX7mWg1wqleGHXHp2ML9J2FzCObgw4Bl/3+VzwYzz5n0JQCNQ
	kEObybfK7Q/xylL/mHvYVQ5t6d8+dkJKFHVXq0T5iMVukt9g+vaDur8BiJDkwEFd
	Powdvhax0M06lisUlO5dTqtyMrajdXTaFwQ==
X-ME-Sender: <xms:ZE4taddgpPIr5bqALFCeoIbNH0PzHIU1FmpNcyIPVVNNLcYyzzb-ew>
    <xme:ZE4tae6mo67LIWg_Fh8lNG7I8BXyjZJtjpwS9cItX-mUNuGCaqDIyy6Ixj7gohHBd
    deHYan-qw_zZc7ouOks3QNBiG_XGMSXt3UWcVMuB9qMHtScEPBW6Q>
X-ME-Received: <xmr:ZE4taQVC0_PyBOSddFnXe0IKE6EEFbmwKokNrz7Mor9Et87zZ_SvE85AzNKcvEZUjiyxvoheN-DJ1CZ_D8kkfEGGRZnlDtY9aJF5VNa2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheejvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknh
    hosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehjuhhlihgrsehjvhhnshdrtggr
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:ZE4tad4JzbQ1uzu6dlVEilyD6kNCleJZ31E2L2-qyVP10YD3U4QYdA>
    <xmx:ZE4tabp2SDUQDndC1gLGunHS5wHCX-T4Wlz-UP3l0jbpGBYDqcmbaA>
    <xmx:ZE4taQnILRkjy1pJaXTD9orNC1z4KSf6j3HGE7KeR_ubs92oACj38g>
    <xmx:ZE4taXO4ih6gwg_mUCbyBSNmUYp-UPspAQVo0peRThV4QjLvdFPf7A>
    <xmx:ZU4taWAHyk3sJcQmmYNuvQctPAs3wK0xYClUqwp4NQgQyaH29P-8za6b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Dec 2025 03:14:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 137757ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Dec 2025 08:14:26 +0000 (UTC)
Date: Mon, 1 Dec 2025 09:14:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>, Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v7] doc: add an explanation of Git's data model
Message-ID: <aS1OXhBcx0IegwRw@pks.im>
References: <pull.1981.v6.git.1762545177204.gitgitgadget@gmail.com>
 <pull.1981.v7.git.1762977200244.gitgitgadget@gmail.com>
 <xmqqv7j11nkc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7j11nkc.fsf@gitster.g>

On Sat, Nov 22, 2025 at 06:37:39PM -0800, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> >     changes in v7:
> >     
> >      * Replace "file mode" with "file type", to make it more obvious that
> >        Git does not support general Unix file modes. Remove a broken XML
> >        link as a side effect.
> >      * Use "top-level directory" instead of "base directory"
> >      * Like last time, I still don't have any better ideas for "A branch
> >        refers to a commit ID"
> 
> We haven't seen much comment on this iteration, and hopefully that
> is not showing the lack of interest ;-)  Shall we mark the topic for
> 'next' now?

I've been out of office, but I certainly think that this version is more
than "good enough", and I have a lot of interest in these topics. I've
seen you already merged it to 'master' -- yay!

By the way, thanks a ton Julia for all these improvements to our docs. I
highly appreciate them and think that this is sorely needed. Our users
will certainly appreciate your work!

Patrick
