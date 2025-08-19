Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE0A31AF27
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596865; cv=none; b=eBDLO/OCMD8m0qazomzKE1iSh0r6TXgGuoF/wooAgaeYIIlr78R0EfTGQ3jJgmK0hCldOWp+v5Qnis3gJsctWGaWnTyABpnzOXreZy3J13tH6jVoFNms+Ce1fETzSRNszKSmRUm++YWJph8JKdIdI7e7awKs0m8h15JcNnYZ2Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596865; c=relaxed/simple;
	bh=iJDT0RQyxCm/rBPxxxaP21tdlP2wUcq9LL20FwF2JmE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G9/uLPkHng5c5GFZOMiIt9JnjXXEnIzuAuOmSRIPDNV/AVF7ICNqiM2EQ4E6DVeb+aEVAQIzxvpHTKHUgxoDDDO3eKKL+l3gLgCm1CQRFto1luTwCPUvVhw8THVttz/IcbzyqZGDBq2DWmi0JiCMlJQ1fUx2vulhHIemRjU/fIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I/7nyy9V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eJjnJwb8; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I/7nyy9V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eJjnJwb8"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9E0D97A026E;
	Tue, 19 Aug 2025 05:47:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 19 Aug 2025 05:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755596860; x=1755683260; bh=ybmV/zd2Xe
	dmGT2mH6UnRYAOXvGfCpdgF1vayvSAPuA=; b=I/7nyy9Vdc3r7n66x/l+gurdVf
	JF88qsbYxfcNyMj3yKHSORDazeqgurE1d3TcO7UMgJb9KvXoNIpZHdN0Mla5phO0
	Q46KvCa7wYyP7OvXnJK48GhjSpazQgi9fOKusdjq/kDwmXB+s8Tp2IVEPRjKmR3C
	rI4SMNTqJyEOy7DJuf/ZnvCHsROBx6xkuuuOGIaiNvYisiT90HS8Zudo/QzCj7fj
	7Exd/JCe32IJ9bkizCtt1j/5Vl/nOFFzyOn6r13HpYrANeKX8S3c6VziqAZmFC+L
	D3ARZz18KrYrhD5tkOmwk6j5Nthtfjs024pKhk7Ip7Fj/aX8toQj+vYdcjfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755596860; x=1755683260; bh=ybmV/zd2XedmGT2mH6UnRYAOXvGfCpdgF1v
	ayvSAPuA=; b=eJjnJwb8voqAYaDN2nzl1LEa2RScroGMQi7smYAWAv0hbWte0pE
	fmbcYVdh0EMemYwOUAF8BFYgn0z1D3xOCFsjaaGu8Pc1/bsI0psKQyWzrjbN+LWU
	8F6Ij9JbBRNFk2uyP4/E7W1Fdc22MdOlTxbGZtRtbeJiQEW6LTl+VQLmAHhD533w
	tekIQgU9ZQ8Qk4v1rK6pAqPhGxDX6gITrDxb3e8o21Jy8rztEdRbW7rAQEdxiuDK
	HvQ/mgly/sSEAT40wgSCNxkrWssHFbkNN7djra6Smu1izBqIimNTW40brjukTbl5
	23zOMjAqaQOLxPsU5hPx4R8q8rEzR5EXLPA==
X-ME-Sender: <xms:O0ikaCnT4avSOlSRO_Ea3cAXE9rAeQ9gCj3jp_p4bifWBDD108a5aA>
    <xme:O0ikaPXdSJXgpEWLG6cEdnGtJARFh4IeBf2aa1_CpKtiZZTaHh9cXEoaiqKtPvr_L
    gW74l38pmYYMpe0Yw>
X-ME-Received: <xmr:O0ikaI82Z326M7iNkoAXPgGdnV-WSVaGKPyBpRvwIE3TmIm02f8nkQPDZY16Q-rkns4s-dXMwL0sqKrtD6w3AtJsW60uSzBSen2Bgvo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestg
    hruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihl
    ohhrrhdrtghomhdprhgtphhtthhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegv
    shgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopegtohhnthgrtghtse
    hhrggtkhhtihhvihhsrdhmvg
X-ME-Proxy: <xmx:O0ikaEp0gQliqGpxV4OVFWQ4CatH5JbG4jLUMI-zR65wv3Fgs_Wc4w>
    <xmx:O0ikaCm2x74JKjLyybyyOmlhgtkpcPHr2xJrMjKwUInzBKdG6i6d0w>
    <xmx:O0ikaAZvIzqxPJBaanLsDYviYbSoAlF9Xj7SpKhzP_OxAeWqiUOSgA>
    <xmx:O0ikaCUHQTmAOvrpYEBdrzHXDnfiQijF_w3zPANojnQuN1bhPwOHiw>
    <xmx:PEikaO3WcgiJUmgEZYHiOqYJF1Dt8d5_8YQFEQhI45zFryPbMoMQkURn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 05:47:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Taylor Blau <me@ttaylorr.com>,  Christian Brabandt <cb@256bit.org>,
  Phillip Wood <phillip.wood123@gmail.com>,  Eli Schwartz
 <eschwartz@gentoo.org>,  "Haelwenn (lanodan) Monnier"
 <contact@hacktivis.me>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,  Patrick Steinhardt
 <ps@pks.im>,  Sam
 James <sam@gentoo.org>,  Collin Funk <collin.funk1@gmail.com>,  Mike
 Hommey <mh@glandium.org>,  Pierre-Emmanuel Patry
 <pierre-emmanuel.patry@embecosm.com>,  Ben Knoble <ben.knoble@gmail.com>,
  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v2 00/17] RFC: Accelerate xdiff and begin its rustification
In-Reply-To: <CABPp-BGvQdrft62S_0_-pdReZCV_rdy=2X0Uebi4oa+-emW6mw@mail.gmail.com>
	(Elijah Newren's message of "Mon, 18 Aug 2025 18:52:06 -0700")
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
	<xmqqldnggt2v.fsf@gitster.g>
	<CABPp-BGvQdrft62S_0_-pdReZCV_rdy=2X0Uebi4oa+-emW6mw@mail.gmail.com>
Date: Tue, 19 Aug 2025 02:47:37 -0700
Message-ID: <xmqqzfbvfxs6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> What if Ezekiel rebased his series on am/xdiff-hash-tweak, and then
> instead of further modifying the hashing in the first series, he:
>   - introduced brian's patch with the platform support
>   - setup the CI builds to test building with Rust (including Johannes' patches)
>   - started working on transitioning xdfile_t data structure to be FFI friendly

Yup, that matches my understanding of what our first Rust topic
would want to achieve, i.e. get the framework right.

> One issue here is that it probably wouldn't be too long before we'd
> want to rip out the xdlclassifier struct (mostly a glorified
> hashtable), which is kind of tied up in a knot with the hashing and
> line equality, so it would probably only be a few more series down the
> road before we'd want to start tweaking the code in
> am/xdiff-hash-tweak to make use of the new data structures.

I understand that at this point we do not expect to import any
(security or otherwise) fixes to xdiff code from "upstream", as we
are practically the upstream for other folks?  For our consumption,
that would allow us to take a quite different stance from our
historical attitude, which was to keep the modification to the
minimum, and apply whatever clean-ups and optimizations only to suit
our needs.  So what you outline does make certain sense to me.

I am however not sure if we owe anything to our downstream projects,
though (e.g., I understand that libgit2 extracted xdiff part from
our source, so if we have serious security fixes in ours, they would
want to be able to import them?).

Thanks.  
