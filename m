Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C6716F0D0
	for <git@vger.kernel.org>; Mon,  2 Sep 2024 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269393; cv=none; b=GdPzOuHdWeD0khaK6zf9X8jEWD7zxV+zHPUuDW+aice2cT/ea7M9NkRayBPugpKA/gWpZ7CYR5xzVZfP5agbc66FiY7nVdk5PENjpVxxMcMdJJF9ZyYFJ+izRLDITqwBHy6AZVZnopZVNLsXLvzOU18SGftl0RtFj4f6C7TGmik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269393; c=relaxed/simple;
	bh=GjAYcJoUi5x5YEESeQlYCVvQlpqMtsIjQJj3qmIsctg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTrDRph1TdJfg1PUFoaq4oU8D6f+Bydo6vSnpCQC7EcBLbOEYvjaiV9+gmqQE7VDvuo+TMkpbOn47Go2h/u0YK346RhYqh+iHukaJR1w5YEXj7ZeU5H7C+5FT0bHWQLVTGE3QXXZLLsl1RBB+CCucw/twfBluAEv5RPN+GcdSQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TrCicULf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hIwGBw/V; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TrCicULf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hIwGBw/V"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CFF05114025E;
	Mon,  2 Sep 2024 05:29:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 02 Sep 2024 05:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725269390; x=1725355790; bh=/FtKyt7zrS
	XVORhgicGtyLZjU/sv+bP8+XF49ddJZEM=; b=TrCicULfE5X+98ZDtk8P0yuXl+
	R28zztBKBt3sqaMLcwOv5pjGsmla6Ecw/ECRAr6VFhqXOKVImiBGH2XIjzaVqR4P
	pBTRXzp32lZbDQ/JhXgrCCp0Z1Dvr9MEMCMLSJbDr4TmTPu5OFnl0PU/d4IDFWBm
	qriR1cuTcH4mZA5NyYyXtlMb36i//QxBhDitXAtvXwBvjKYr54IQeDuYTXWgWa54
	Go9RzTAF4Zqd8s0n8NWWDn1AvZ9iyf0wLSHlI1R74TWwpkpCqsso/kWBc1KfPTI0
	QanmB4xUlFa8qLvkRcovV/u6xok36v8dQ7APMRzzMrWxbeT+FUvXpJykx9eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725269390; x=1725355790; bh=/FtKyt7zrSXVORhgicGtyLZjU/sv
	+bP8+XF49ddJZEM=; b=hIwGBw/Vu3eZ//MYhP5Vy8/YcrsSRgsk33VZP0MyszI9
	x87nWaz9T77Mohne/W2yChUsXrklXl+Jl+A3DWdvc6HFpqsly5xvzaYGWFEhX+XE
	tYMLpZDhVeshiH616lLR49R14yMOz7idjEzsK68su3HiZps4EY7y7QRf4rrSTEsd
	pYBUh8hULOeKCtFx51mmqBQZO+x1npJyZpfyZ0n9jjMOxSYGCKpc1pETaFn0KdAa
	BDgp+zdXU/Joef9dNe8pOVkmKX3YDc7juvWShJXAhCJMqYZaG076IY4+1H+nMVc+
	NIQTMFB/JA8kKRPM9JHHylKQPTYMUJIJsQcAMmRnwQ==
X-ME-Sender: <xms:joXVZoR7oLwll4t3N98QeHgSZsXn5LNcmg7zlQO5lxhiz5T1zfq9Og>
    <xme:joXVZlxL8xyeF5NiWz6yZWYgNokiO2IaYaad5MrhPMktZFJ5iXny_IqSK3yu9JXa3
    SPwBRuq9AJsHCdBeg>
X-ME-Received: <xmr:joXVZl0WfCGMAvFBjFyRrQlJkDiAIrzvvtbWtsov0WVroU39xS8uCzU-TS4XPJWkmqY2BF0LJ9xkKIeqVXHx_LEAVBSooxNQj04Kb1XHI--q7-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehfedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdugfeh
    tefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:joXVZsB_jEY1ifsHLLTAHlXG7ZH35w0w9a0w805SRbW7I0_IdqA_Yw>
    <xmx:joXVZhip3MVpri-9hofqLaXqx5bOarT9gIJgXGYvxxG4NnT5rmNcBQ>
    <xmx:joXVZoor5rGxyqgGS3ssHhz3GJtdPCRFtdODjQEoCSFVYUXYuj2l9Q>
    <xmx:joXVZkgX9MuXhnW027asXGqFHFQpX9mjSGCuRVbiEWtsTNaIxcC6lQ>
    <xmx:joXVZmu4UMoF_Pw3bjCPKDoh8IO5njkK7peVBludopQubkfjLF61BbHm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Sep 2024 05:29:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 37baa027 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Sep 2024 09:29:44 +0000 (UTC)
Date: Mon, 2 Sep 2024 11:29:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH 00/21] environment: guard reliance on `the_repository`
Message-ID: <ZtWFiv-caqIfYLoD@tanuki>
References: <cover.1724923648.git.ps@pks.im>
 <xmqqle0fuml4.fsf@gitster.g>
 <ZtFtpjaGFhORNEP4@tanuki>
 <xmqqr0a6rmxo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr0a6rmxo.fsf@gitster.g>

On Fri, Aug 30, 2024 at 09:32:35AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Thu, Aug 29, 2024 at 12:59:35PM -0700, Junio C Hamano wrote:
> >> There may be more, but I know at least of these at the moment from
> >> https://github.com/git/git/actions/runs/10619536685/job/29437358521
> >> 
> >> Perhaps this can become [0.5/21] of the series, before globals are
> >> hidden behind the macro.
> >
> > Thanks, I'll add these. I really need to spend some time to finally get
> > Win32 builds set up in GitLab CI.
> 
> Windows builds we can get from GitHub Actions already.  It would be
> nice if somebody had Cygwin, which might have avoided a need for
> <d8c5e920-aff7-4e4b-af77-0d3193466b57@ramsayjones.plus.com>

We already have it, yeah. But as I typically only use GitLab CI, I tend
to hit the failures on Windows systems when the series is already out
there, which requires a roundtrip that would have otherwise been
avoided.

In any case, having Cygwin added to the mix in addition certainly would
be nice.

Patrick
