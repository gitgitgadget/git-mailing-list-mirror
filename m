Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA77189B84
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 23:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771629153; cv=none; b=ZGQM7K9xHEotMqh/7/0yTflDVtY4Diu5edLCuJj+2PofR5RfgtBFjGsyr890ydMzef0TEiQ0ormjpRoSR8cG1uER80NLZUirJABkOdj0M1y2LmRKQMkkWvIiQD5B+rTKP7msCKxNQnUST3CuBGk2eACREd/fc/kXAEQZOvz9G+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771629153; c=relaxed/simple;
	bh=XWAyULsx0XRnuXekvJD+vgRWvkTSlkQKhwIQegxj8Fw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ce8RcRYe5QPqP9ed3Gd14yZXmLpRAixTBJOsurSg3JJehy6YLSqjU/5FtDOICdJyjR+ysKJxaw/hM6pWEhWSQeP4LmQDLI0QZyWhXolxAAXZi4GOkgHS348BjRrVgSHBLq6qUQadTpUSAPfIOD2FnnFNa/j0udJ+UvUsUHyMvSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Fd/7n7lK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qqCJVDi1; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fd/7n7lK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qqCJVDi1"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 430A37A000E;
	Fri, 20 Feb 2026 18:12:31 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Fri, 20 Feb 2026 18:12:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771629151; x=1771715551; bh=KobvEMcKcB
	OoEzS4Tlu6j78bl6arKk2g4tbc8JcJ79k=; b=Fd/7n7lKHlrQh7dQ0OWuahrz5x
	lbg79SuVBxfwCURPS+Weso5YrCTsK7iUejC/WiXk6fZuAEIzDSkDu4rGOebkCfK3
	AqU0EeJbVbRiap6VVunPXyGUWUyqr5oqfNBzid3JGNpoGCGaWQCXPx0tkM7xzDJr
	g1MNNtpvQ6SUE826fPN6drztXWy6iyZiXEEuVTpxWhewN2T8zrf16NmkZWAjbjro
	VN48pYS87DrzwAdcSrWlG3DRIQPYgU3/dVtDvitMQ0M5itOf0Fu8G9s/PHz6HfcT
	lEA/R5cJ8TArwGhUqXrhL3toR1q4i9s5xZ03H2hGZGEy6yvEFVsFyD3RYO+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771629151; x=1771715551; bh=KobvEMcKcBOoEzS4Tlu6j78bl6arKk2g4tb
	c8JcJ79k=; b=qqCJVDi133UFY90h0esdEZcoG3xYyfFupxQ6g6cHgDF9pVHNOeh
	wSJ9/QbSx7OGeTuuMLm8/QArPQidhebw9YwbGWsbjEfX14fGA3PLVTm2QJqsyxEp
	jbB9+I5Q9Ho0QvlCyY94xmuOhA9FFVxTS+zskZWxZ1J+bg4sbq8s8TL3RML5CCx3
	bjCuBPUxbxqDa9cj4f57gNP1sWeETnpdPeLzces7u2lyoHnTXE3GHk2jxnPFx6rl
	9cdtq28RWfSpfURXQ+z1+1TeWQxO1ojh8GoOdVQtfS0r9gyc7oi4LDYekKBpP6Ci
	7VcL/FHcPaz4fQEIVwrTMoM9wNw4tasBdCQ==
X-ME-Sender: <xms:XuqYaTorc4x0hQy49QJc6O9neCYdlpspw-JCYzFZG4NYUD4G6laYUw>
    <xme:XuqYaW_zRE925HaSV_mOCFQvCLkUxpXev86zJE9__n6dxpWpKzdUTu2HeR9qL77RY
    T-H6wEhkaotPfmj8H3ynDIroQwa1E9TY7vfTDnra8TMxo4IOu0>
X-ME-Received: <xmr:XuqYaXcv28WqbY1f2JPIxCe-5I-WlRgEpzXWcE0fGrV5N9Vwnwg1vjrFbA-CpugtkoqD-i4HpT4hQcxRw6kAaYBR3TS0sayiNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeljeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnrg
    hsshgvrhdrghhrrghinhgrfihisehoshhsrdhquhgrlhgtohhmmhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgt
    phhtthhopehjrggtohgsrdhkvghllhgvrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:XuqYaYI-3K3JziiP7SyvzohkGnxPEdC0NEpm0q3aerokDI-mR4nDUg>
    <xmx:XuqYafjfz1CFF1Gxmjsb4KD1I2VPbUIfFWijWrFT6F46J-7TifFzbQ>
    <xmx:XuqYaeQwKbMH9PeEAphGyZyvuMNIswaCZADhbCVGcTOuY907SJgR3A>
    <xmx:XuqYaRWF6v-Kq1MQa7QV-DITFBf4zg5RSNnCJhzJf7byG-4Xkjaggw>
    <xmx:X-qYaWvXy3BpldBwEVQ-fypsbetHJs52v_RBiikZQyz4au1KDLnU2pAX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 18:12:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3] submodule: fetch missing objects from default remote
In-Reply-To: <xmqqms23lpn2.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	23 Jan 2026 18:18:25 -0800")
References: <20260114194815.1049888-1-nasser.grainawi@oss.qualcomm.com>
	<20260122152722.866341-1-nasser.grainawi@oss.qualcomm.com>
	<xmqq4iobhpvg.fsf@gitster.g> <xmqqms23lpn2.fsf@gitster.g>
Date: Fri, 20 Feb 2026 15:12:29 -0800
Message-ID: <xmqqzf53t3fm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> ...
>> This test assumes that the first branch created by default is
>> 'master', which will break in one of the CI jobs:
>>
>>   https://github.com/git/git/actions/runs/21304166518/job/61328461844#step:9:1942
>
> For now, I've queued two fix-up patches on top of the posted patch
> to avoid CI breakages when the topic is merged to 'seen'.  One is to
> rename t7425-submodule-get-default-remote.sh to t7426-submodule-get-default-remote.sh
> (both filename and the reference to it in t/meson.build), and the
> other one is the following.
>
> ----- >8 -----
> Subject: [PATCH] SQUASH??? fixup
>
> The test as posted breaks when run with
>
>     $ make WITH_BREAKING_CHANGES=YesPlease test
>
> as the added part assumes that the default branch name is "master".
>
> This band-aid is sufficient for the purpose of the maintainer to get
> the CI passing, but the real solution should probably be done better
> in such a way that the latter step does not have to rely on the
> creation of "anchorpoint" in the previous step.  I'll leave it to
> the contributor of the topic.
> ---

This was from about a month ago, and we haven't heard from you.
Will we see a hopefully small and final update [PATCH v4] of this
topic sometime soon?

Thanks.
