Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE1B27144B
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771611102; cv=none; b=VZd9FG1KvWArYlwhzvqR73BhhHXOYhwUnXIXLGKw/yFlnXEJa7KuqR6lpw61qLXLdnBkJRx0g/OT0cYoM/yMKLQ+i/intlt5HTulwlQfGfQW7fslqEuKFXmu9zHIr0ATg+g3IS9SQaCOrvk26FBSxGtJUgt02kmzrBe87imZbW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771611102; c=relaxed/simple;
	bh=3JTMCEgb9jIOO/Hsg9mYqWPciWQUv7/fvxZJj7TMvQ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jzBUwn6VvQfh3uDmllqrD0/CLvFL0x+YqjK1IoTUirykOI1ydPQryMRbJI6Qno36eFZ1dCAIy3mpywIqgBmg0KyGgUewNGk+gjA6is/Ey03pLxUQ2P6N+20Eu7ryk/F3J5S3MiYfDfb+vSrQaHp2o4vyGxdWc2r+rM0QfzRVWCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=10Cd0RKN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fc7VEAjw; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="10Cd0RKN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fc7VEAjw"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8FACA7A0015;
	Fri, 20 Feb 2026 13:11:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 20 Feb 2026 13:11:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771611100; x=1771697500; bh=rv/a2EsPg0
	+3Rma2pefA2hLhe4ofavZy3u5J+DdTquE=; b=10Cd0RKN3qK4XFKIYViU4ZeObg
	PYo3o2BBYnvYDXfxoOP1gQ0KydCDeIXSilu9Aad2Qr0V3sPCI5mKHleVzZGAcfQv
	xBjBrAXD1KFxds6Rq7KHVzf04RjvfJxEboxxVE4ZUCudKEYk7hxVZaRJ4fM6WmW/
	bHbnmaM5Qy789poNO7T3Ggn8T5VAovYfRw6Kd41djVX5HrWzo9XHjvQd+4OcvZ/n
	XuyRoAvLIRZB6hG5gxNE97SvhcTbAAXuefBT2dxGY4dUlhmw8HesukNyZLPrFr2D
	1AlluJ+9lWf+KG1ds3smezGuGVY4g30D4syFv+U01KIrfhhNYdBC69wlMzsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771611100; x=1771697500; bh=rv/a2EsPg0+3Rma2pefA2hLhe4ofavZy3u5
	J+DdTquE=; b=Fc7VEAjwjz5ek7M0SQb5W6ctpALJziUs+9DjvtChZgqSgyvMIrF
	/pk1tRy71R50eCgEkvUC34k8v7sAVRAHHLGb+zggFMa6zOQqPSNehtArY2k0t4eB
	haMfpdxaokyU5bVImk/JPQOi63yQEm+tAn5Xwoyd2HbndJnNTc4mnAyA4p7cMaOG
	yJ/AXoLnXufL/W9xryhfolNZZvZQgJJU9GzCt9v4urz7Cl8gpgHNK0afVaGfMylf
	8MNY0XdfMVV+B1q2kpm9aB4q5XhpRTmuDEnd9/FNrwN7K0xlXkMhbbHJGcyWTNz4
	ff/iDNgBJnXRxQ8PjdteSxFfH8slzyl75Pg==
X-ME-Sender: <xms:3KOYaamw6pJKphNYQNYRMrE6h2icIfqaT4VzemklVwn01-B15gMOig>
    <xme:3KOYaYv0ne2BCK_kJevutZtXBmBvH6ILRz3Y69D7wMvH_AK-W4MPf5SCvQWOQmsTe
    hBQxN6unwnKdeEc8YtdtnbceQpwXeFMcOY9oNGMfzhCHH2vikGa4g>
X-ME-Received: <xmr:3KOYaQ-ULLPmQJOwm2Gc_V-YphnSYF7CLMFCbkLOxvFGHEHOuOVMLgpHsjOp8niSrhXnRYpFGY5y7JbZB6f2x48BAK-fpfhCUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeludefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepmhhrohhikhesuggvlhgrhigvugdrshhprggt
    vgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3KOYaaOudVxKl5opmEAnBJx-vxOJFtCNF449oCpniN4MuOrfGExvZw>
    <xmx:3KOYaWGKW6bObYCakUVuyCf8OQ-cBitefWcWp-uo1nrHmm9KRvX44g>
    <xmx:3KOYaQRrtcaHUb1xIzBJlbZNnoVpJ7qAVDw8X2hDdtGX6BS4Gw97pg>
    <xmx:3KOYabtwTQ9LV_z6iHd5FOiuMbeampA7Khlq2XgYS1l96v-Q1YssYw>
    <xmx:3KOYadck070Gna2jSdCrJ3lQ_TrmTFObRqs2ygkPMbiSMMmImW1nIKTZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 13:11:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  Mirko Faina <mroik@delayed.space>,
  git@vger.kernel.org
Subject: Re: [PATCH v2] format-patch: fix From header in cover letter
In-Reply-To: <20260219114307.GC3529@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 19 Feb 2026 06:43:07 -0500")
References: <aZAMr6XOwKkTa55q@exploit>
	<20260216152730.37478-1-mroik@delayed.space> <aZQJEDyUyMv4_c1l@pks.im>
	<20260217063400.GA101988@coredump.intra.peff.net>
	<xmqqecmje6o6.fsf@gitster.g>
	<20260219114307.GC3529@coredump.intra.peff.net>
Date: Fri, 20 Feb 2026 10:11:38 -0800
Message-ID: <xmqqbjhjxp2d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> I use it myself and I really hate the way it lists the patches.  We
>> should have done "log --oneline --reverse" instead of "shortlog", as
>> it is hard to understand the reference the cover letter message
>> makes to individual patches like "the first two patches do X", etc.
>
> Agreed. I have long hated the shortlog version. According to the commit
> history of my personal scripts, I've been sending with:
>
>    [1/3]: subject of the first patch
>    [2/3]: the second patch
>    [3/3]: and so on
>
> since at least 2009, and nobody has complained. ;)
> ...
> But anyway, if this were happening internally in format-patch's
> cover-letter code, it should be quite easy to do (we have the complete
> list of patches and their subjects there already).

A good bite-sized #leftoverbits project for somebody relatively new
to the codebase, perhaps.

Thanks.
