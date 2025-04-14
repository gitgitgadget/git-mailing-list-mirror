Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1C51ACEC9
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 07:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744617297; cv=none; b=NdQGrxsfeXjwkVT+BWzSMNmYarJ6GN87cx65yj2Nys2LYIMxDWJH7OulU9A6gUMXXeaNnZ8SXTrpAg8hI+w50vzL/t5hipqSe8HXVSbwy/6PZHUJrvH4lZFrI/R8DUc88Rc9W7e8r2TyicC4SveF2fdZtn6a8SbOVgBqQ+/BxuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744617297; c=relaxed/simple;
	bh=BWkYiLiL1kX0uvk6j9twhWz6dpzDd5dGGoo/tr0+nwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASvQKfWjrHxU0rvJlJzZ8e26H5N+KfuVhrILvC9tYkfqSCPSQPsIa439iIaIeND9byMqB4NCQ0Lpc2eloiRph1mDQafP0v3dxeirG3puY32ZVr8mDGbuw15jsWcFVjOkKKnvPSL5Ci2Kz9/ePHaYmdPw9jXEnuk1rQNg/0aRTNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Drvm3YOQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LgIdSLMK; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Drvm3YOQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LgIdSLMK"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 79D3725401A2;
	Mon, 14 Apr 2025 03:54:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 14 Apr 2025 03:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744617293; x=1744703693; bh=/jPVMNyAMq
	9VMTEfz0HkG2xHd5ZnshorMYlZ/7Cah44=; b=Drvm3YOQ6K3+vnRQ3wBEuHBAzd
	oFZL8vdZkdvKzwuzK18I4AY8RyMv850781GoLz5NwRmWeRB52OzkkIwbM1Gav3Fv
	UB/awoZ1IIECxwWoBMBOD2KSxRCfd6SddUhz0pLzcsCnaQ1gkC4WX9LZLnwXRiPo
	W58N3EclWFvBeJOOgGhSv7EaPCev2O/k38AuSxeezOyyl+q112LWncmgwBBsjD/x
	ntIrau0RFo7wK19toIbtlz6Oj34Yv7FWj0WX8qRLV82mpp+pA21ixjW23Cjwu13e
	uylPAZQQQOAR4oKMJmE+rW5MNECdG3GkOPWXgiaZ5Zrhm+7ebaWV9ZzOzhMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744617293; x=1744703693; bh=/jPVMNyAMq9VMTEfz0HkG2xHd5ZnshorMYl
	Z/7Cah44=; b=LgIdSLMKl+LeWsnRtefNEOx8CDPn2vxmggwhEob+dKLDZaY6mpa
	Jq76fj5XxDPAPq1sUDirZGXgRmYgx0OSf+tyNdCxyk5teRS9wgtYSzkr4m11js2A
	Lmqqm2bOdZS5vAhHMtQLImfhJCN2lnlphoBc8zUDhot8VuilqNjLcTSYXtJOdtty
	qbmyO24hOE/+1ugmLQhK9TfPSNsJN88HNyvqM/DXd+G01trngsKAhwA1k1XC/aft
	rBnxuFjNIqNmMOTu2aA2jFkkN/+ol6HMrVmakj5JFwIqYBDBgtp6zEYJY3ETq7iL
	zEx7sQtcTZzTlTrH30rReFQwNrNrWIrP5Ew==
X-ME-Sender: <xms:TL_8Z7wAkExcHxCVvs0fnk7WpNVlvxlg1jYKMCYjgT0aLR2zNm5q2w>
    <xme:TL_8ZzRUP_deJPoHL2jWftJmzCGOuaej0gbdUFWNAcPDg9DUQYRGfeKdpH_Nr8Rm-
    Dczo3aMlVPi1Lbe5w>
X-ME-Received: <xmr:TL_8Z1Xq7drbsqg_e6AqhLtoSCctDB2Ptx_uJW2-RSdmuLXc8AGOC0Cag2TFvn4wAWU4YmarxwU8AhDn7H-qgOHDFx9l5aInRNHLhpSaN7yM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddttddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesughinhifohhoughivgdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrg
    ihjhhonhgvshdrphhluhhsrdgtohhm
X-ME-Proxy: <xmx:TL_8Z1iQFPl0qdBB6_lNR6dgC13ualYiyzUPd3LKa2zjN8OPfrkwpg>
    <xmx:TL_8Z9BJ1CSdkcWcL-7GmSONBFKV1kfrju8v3ILeTEG-IlWcMM1MLA>
    <xmx:TL_8Z-LpWlWlTZ4ufYu_DIcqYvhsGBiB3Zs5cG0g_AN_UOaNuLTPFw>
    <xmx:TL_8Z8AyzBDXqyl0bXnBnnQrOZHkq3ceuYM2lnGb5Xt0aBXgG9vxow>
    <xmx:Tb_8Z9fv5RsJ99EeJqKNl9ncZeNn_ujlllbHjNMP4PaCB8t4CPrHDVum>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 03:54:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6b187f83 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Apr 2025 07:54:49 +0000 (UTC)
Date: Mon, 14 Apr 2025 09:54:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Adam Dinwoodie <git@dinwoodie.org>
Subject: Re: [PATCH v2 02/13] Makefile: only set some BASIC_CFLAGS when
 RUNTIME_PREFIX is set
Message-ID: <Z_y_REMmW95_5IcI@pks.im>
References: <1c04882b-e518-4272-bd18-ab918774e424@ramsayjones.plus.com>
 <cover.1743859985.git.ramsay@ramsayjones.plus.com>
 <8df541634aedbba40d8b0fa57dbf9cb0e495f11b.1743859985.git.ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8df541634aedbba40d8b0fa57dbf9cb0e495f11b.1743859985.git.ramsay@ramsayjones.plus.com>

On Sun, Apr 06, 2025 at 08:38:28PM +0100, Ramsay Jones wrote:
> Several build variables only have any meaning when the RUNTIME_PREFIX
> variable has been set. In particular, the following build variables are
> otherwise ignored:
> 
>     HAVE_BSD_KERN_PROC_SYSCTL
>     PROCFS_EXECUTABLE_PATH
>     HAVE_NS_GET_EXECUTABLE_PATH
>     HAVE_ZOS_GET_EXECUTABLE_PATH
>     HAVE_WPGMPTR
> 
> Make setting BASIC_CFLAGS, for each of these variables, conditional on
> the RUNTIME_PREFIX being defined.

Makes sense. We already handle all of these conditionally in Meson, so
there's nothing else we need to do there.

Patrick
