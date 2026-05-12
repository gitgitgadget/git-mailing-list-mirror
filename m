Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3BF384CD9
	for <git@vger.kernel.org>; Tue, 12 May 2026 06:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778568133; cv=none; b=kxUvzJibRC48dxubCSv1oilL+jLhiWEsHntCGVRg3fhHhalXnTMYvwhc1NvYdndeC1QIDI6lBn5PzGNv4+1tvPHTdRBusAfa8tCH13FxcbVwepfShKGspewcqFF3N06EqIPW0R8oH3rM9ouQy9CUV1PJi2zG7aNpYGpu5S8VDKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778568133; c=relaxed/simple;
	bh=D8AJYJ1TZYmOaci+fU02cQ6PN/58A4E9GPBVm4sGTbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hm3blj6qG7wryu5cOAnJYqLajBW4GcOZxMhjLuZNdXG0UUE4Hew89+HQT3JpU2PpsTCRPElNEQJOXvN/pI04iD2H9uIULCwCxaR2RkkJWs/FIzp0+LPATGmLvHC9i/dY1vbgN1mI/YErJJ+mpO8aYehM1kBRoGLlrEjCsmA3864=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GadHKQdG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d8rGFLtP; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GadHKQdG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d8rGFLtP"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 84917EC00BE;
	Tue, 12 May 2026 02:41:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 12 May 2026 02:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778568119; x=1778654519; bh=jmqJLbTCRg
	Jrx4Z6he/FHBYtkI0nTSr6FSEfz8sfat4=; b=GadHKQdGiCojlYyMo41H6vH9PK
	ptBy9R6n+vm3aIqQF1xZfSBuOvtmh6/WbabeUIjh8YtSKujzlOxS5IcUJHVBVYO/
	lW9TZ9qQkFaB0WYPwi+hdfzbbi2Zk8YQRsM8nueYT/oMl9yLYeKlJGCXtG9SJQ6P
	EgBmpLGhj0q6SNzNjoPcEG9xaMLqN7dX66FASQ0y6OC0I+SqCXigiXMpx9c9lEgU
	t0yt6uQquqB9frO0nP2XfieX1vJKGyJ7phQeeklKM0lOUe3FervDASqrk22wlOO8
	0w5K9TZxBeNEh7y03xHtNTnWr6UJIAwuvLaUWOmYyyUOB+jVorv1LkbpfnlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778568119; x=1778654519; bh=jmqJLbTCRgJrx4Z6he/FHBYtkI0nTSr6FSE
	fz8sfat4=; b=d8rGFLtPdAGIXZESQHprufLsyWI8ofWnKF70eCyw4qec1PbM6xu
	8FyUFmzoJurlynFZVW4GK15z1T47A8b36clqn5fV2KC4mvQBsQUf/TOzCa/mgavc
	zsxVGovcMVrhjfP3NKo/urA48TRM2qIai6ldJC0I1jT8KI2Rjl17+edqW5uunix+
	CysLMahsrJDiVaniXFCVdAK18H00Wvn2YO99NCW85cPy/l/UmSzizlbKUsiey1pO
	t2fODy0xN1Ewzc1Wko0q5hZgbDpjbYbJDr/6UUv6H71Yh80Iyv/RDVdAqIr6UGwM
	/wKtqqSYIaCMvA52XC4+TUexNktJIr9yg7A==
X-ME-Sender: <xms:t8sCatshbzykbKO90GNPu3sEVWv2H9EcU9IWCUiL4xVhcFDXe6_3sw>
    <xme:t8sCatUSzc7BTYoACga1wEWt3vREIplgMG3TC2rpuNptvJhLcMy_z-qIxL1e8Tqmq
    h1NpvCvIqUpE4xwO4-YXcZTJ7JXh4JY3FDcpFOJTerhk6WDFmZp>
X-ME-Received: <xmr:t8sCapH1qgH7laGNzNLI24--IrFvSt8Y7cMDYl2mDpzvlRPyHX9qSOKWn59ifIYzBoVIkOivUonStGA7Wk0JTzFKtuhJw4z9ZDNSgcerVO8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdduudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epfedutdduhfdtleffieekvdfgheegvdevgedtudefvddvffdtteduvdehfedufedtnecu
    ffhomhgrihhnpehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosg
    hlvgesghhmrghilhdrtghomhdprhgtphhtthhopegtrghtsehmrghlohhnrdguvghv
X-ME-Proxy: <xmx:t8sCav3-t_Nkyu_iQD0FDGPy48xbT_wZPI2SrojwARzlvCpmHVKzwg>
    <xmx:t8sCarOcwMBWsPOQ4ZEnq2e76uHcBZf3wOixNKKpx6swQmU6AYV1Cg>
    <xmx:t8sCau7jy9FlWKKu-5IrJZi9U8Gv2GtuxPnQIeWzdb-UTYnL-6-bow>
    <xmx:t8sCal0oOVwjHzj5XpracMy2Y5RT8TB0G2dRWi4F6g8CzZyH-h7pzA>
    <xmx:t8sCaumCbq6_fBj7O55cpFcEu-ttQ0YDSqRi1Pmp2KQAmlY7dxAiZpjq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 02:41:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 06d55bb5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 May 2026 06:41:56 +0000 (UTC)
Date: Tue, 12 May 2026 08:41:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>, Tian Yuchen <cat@malon.dev>,
	git@vger.kernel.org
Subject: Re: [PATCH v3 0/3] builtin/history: introduce "fixup" subcommand
Message-ID: <agLLsbPx1zH7klvj@pks.im>
References: <20260422-b4-pks-history-fixup-v1-0-48d4484243de@pks.im>
 <20260427-b4-pks-history-fixup-v3-0-cb908f06264b@pks.im>
 <xmqq33zxp4aq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq33zxp4aq.fsf@gitster.g>

On Tue, May 12, 2026 at 02:47:41PM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > this short patch series introduces a new "fixup" subcommand. This
> > command is the first one that I felt is missing in my day to day work,
> > as I end up doing fixup commits quite often.
> >
> > The flow is rather simple: the user stages some changes, and then they
> > execute `git history fixup <commit>` to amend those changes to the given
> > commit. As with the other subcommands, dependent branches will then be
> > rebased automatically.
> >
> > This is the first command that may result in merge conflicts. For now we
> > simply abort in such cases, but there are plans to introduce first-class
> > conflicts into Git. So once we have them, we'll also be able to handle
> > such cases more gracefully. I still think that the command is useful
> > even without that conflict handling.
> >
> > Changes in v3:
> >   - Some more polishing of the command's description.
> >   - Link to v2: https://patch.msgid.link/20260423-b4-pks-history-fixup-v2-0-d7571c6d36eb@pks.im
> >
> > Changes in v2:
> >   - Introduce "--empty=(keep|drop|abort)" to specify what happens with
> >     empty commits.
> >   - Adapt documentation a bit to hopefully clarify how changes are
> >     backported.
> >   - Link to v1: https://patch.msgid.link/20260422-b4-pks-history-fixup-v1-0-48d4484243de@pks.im
> 
> The iterations v2 and v3 saw no comments, unfortunately.  I just
> gave three patches in v3 a cursory look and nothing stood out as
> curious or fishy.  Shall we mark the topic for 'next' now?

I didn't plan to post another iteration, so this works for me. Thanks!

Patrick
