Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5822F29
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731749844; cv=none; b=jje4O5gnkAKdFpI6KNzNNFyEUTkCqm+PXaOVlX6QWOlvGWlO/Xrd3wbtABQMFBHX1u3ecADrutfcujDLbx+uTOKRxf31qaLYoI3YGQ856MlZTY+P5vgT/aJxBu7GckBQcPUvwi1C8+pcg5oPuOPK6rSGGCDwH6PnLyKMONAUOWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731749844; c=relaxed/simple;
	bh=UDePiiS1UhOVmh2em2l9qY3XNq1iU3Cps/TgKXWejHA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CxGdSosyEXo6P5hbi6iyEgl1iVNZ9tdLOTxmZJSLNajq9nRAWbhJ+mK2sPZQ7DRoyXwphtpehIrd0CsWh1OZQH6yn3iAvN4phgYImDM3deSPrk6V8keKLjVkRnioWrzFWrIRhQFuuSSmlRJBHAF3U5kry+SLa5vz8HYAJJo05Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eKYACm5r; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eKYACm5r"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id D3EB2114009D;
	Sat, 16 Nov 2024 04:37:20 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Sat, 16 Nov 2024 04:37:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731749840; x=1731836240; bh=UDePiiS1UhOVmh2em2l9qY3XNq1iU3Cps/T
	gKXWejHA=; b=eKYACm5r50bs1kP1TB0N8WES9OV71trePRFN8j+osxnL3dmCOcT
	/K/3JAgxznjBtyITgkPP5UWUF2GiS1kOxCUo/QCdo6m5OOw41D9V5LxI/zWVpUvm
	iYzenzZ1OMJ4+NATnYh6cfO1kwbDN8BTP2tCNn7FqUrjNXhQnEqy0/V9fSmwLtO/
	VuKZp1S+3KNbA9EZ0iamqgr61PHtqFg3C9cGs8JoXEye9XLfSY3buTSg9RioMAtk
	IlGb4lUxSfRyJr114qnN0anpd8QCRQQOaqffPji10SUh6ACgIkLPR2aE4UAH5peU
	pfO4KbAFwRRPJOeDaKcawbJrFrc+X2wxsvg==
X-ME-Sender: <xms:0Gc4Z_R_1hwK1y9Obx-5f_H3N2y2DQ-uCgpIaJXaBjd1n5jbLb4S3Q>
    <xme:0Gc4ZwzPL9Pdpg9ltZVCI9JK9fdC8lFarSFn8tJqmYvH0SvVl6sdJ4K3lL2jejqeS
    uw1-c_cbA5mJmdjBg>
X-ME-Received: <xmr:0Gc4Z01I0B2A2glnVpSHluXTAt8bGGEHHXcLmlNdAHZ-u4EdutzfEcC5BG9FJlWeQa9Gn5F_uwF_rrNK8GEAlCirOoqF6egYTXl5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdeigddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevte
    etjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:0Gc4Z_Big4T53CEPeWLCY3HB2LjSVlmD-d6-zN690l6elyA0oGO-bw>
    <xmx:0Gc4Z4iEWAjWRgy8whLhwm3dcUf0cjUrC_zTM3qkp9UQqL1WKRTz-A>
    <xmx:0Gc4Zzo6CbOXuePs5T50JXE9HoFijZrKuQG31zmF76r1023gGH0kIg>
    <xmx:0Gc4Zzh4U_Gq7S3AzEkAFn3ZZp4yrI7LyiM8ix_RbkbH8Q69pcdGXA>
    <xmx:0Gc4ZxvtZCU_O7UFQU9bZFGFIEFAdIAGHWHbYtxqS49lGD4VxnR91hg0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Nov 2024 04:37:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2024, #06; Thu, 14)
In-Reply-To: <20241116031904.GA1782074@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 15 Nov 2024 22:19:04 -0500")
References: <xmqqy11kys9z.fsf@gitster.g>
	<20241116031904.GA1782074@coredump.intra.peff.net>
Date: Sat, 16 Nov 2024 18:37:18 +0900
Message-ID: <xmqq7c93zfht.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> ... when I sent out the cover letter, followed up with a "oops there's a
> small fixup I need, I'll send out the patches later today" message, and
> then later sent out the patches. That "v1" that hit the list (and what
> you picked up) is the fixed version.

OK.

Thanks.
