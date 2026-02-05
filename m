Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93CB42DFFD
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770309595; cv=none; b=YFuWd3UcBUc0qnyvgnmXLRlPJ3c6uYAOmp9Vv/6jdf2oWkdy+tD64rNqZz8vybSD9b0CvFGlLh5oWRO8wIHth+VlLS+jqTXtLcPEi1i6hScvsA7f46+HMEOx44rnq6l8A994mIIU15CoxOhFWMxkgKKNppylUam0hSogjcQmkqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770309595; c=relaxed/simple;
	bh=FZy/DbRfq4icAMc2V8KXzKWyKmOiEpn/eAH9AgPEY2o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G1qC6Y8nOwHbsAlJRkHyBhRb5b7rwWwBMIyAYtUU5ieFkFvU0iyFcI8zv4GcOBMocUE/p7Zjn1+2Jcx8hDicxXGWvTQ+Kl4fpKODuex6BLazTtPSaocM8jQ2qPO/2Qy7pHRYENbgaaTyIOvZN7jKn0kjeyST0Qs/RGq2jLfP0UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CD83GEh9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KuN7soha; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CD83GEh9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KuN7soha"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6E1B87A0190;
	Thu,  5 Feb 2026 11:39:54 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 05 Feb 2026 11:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770309594; x=1770395994; bh=gPYeaaHdxK
	eFXKF/Y7BL8FZlCk5VD4drWsdol4Zgza8=; b=CD83GEh9ocvslnWdAsGpouYeAL
	VFsBKfdJXm/uP9LHd+83NjKwQw14WHa5OsFrlTEyOgqg3Z7nCl0NrvxGPLCbm2Hc
	J/+wSDl7eU9LfK/WQNVvAwDwiCrjTCYwjhwdstdTTN9FmLo46H7+psTlmHSv+LI0
	+doskxHeVgAPocfp0bHWd/g/y9L43gzmgbCCCtig+eydo579QcB10MFc9kZhWz0m
	8zfHUKWut7eVskM6P+nzEHmVVwpI//itWlfAUt/Bq8OzCg9+nvvvbwqq+R4yMe84
	G+FPibStjGWJTcckEB4jdk6MSsiEZPDUiuQT/BAQF+js5AOOTeOvOGVeVkGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770309594; x=1770395994; bh=gPYeaaHdxKeFXKF/Y7BL8FZlCk5VD4drWsd
	ol4Zgza8=; b=KuN7soha/d7cXG030wxOzdjDG7gOSgVMKI4y3Jp0LkkpeVyW2Pl
	5twEWHuHYO5FQJ+LGKR4cdtpEnsB3YMnMOv3kU630H3dVxZCnMqhf2dxAqwHajkx
	NxC4fvjiez39SB24u7/tHFDysRndO2NcUSiwGRtW1Q0PtgpnUGfJJJoGU2761G6X
	hwHTdF9D3hom53IK9hHRu0fawl2OUcjsc/96PvoUMe9pL57Iiarg8IbgzbR1bIRs
	Pxvg1cleiGSWKiYptKzgcexS0e2IoqznhWJxNLpOl+pw0Slm28E5yPIUaAl9w68O
	5HHmsNoKLkMhrSa6Wbk9saAzr8+Gqw/Rvqg==
X-ME-Sender: <xms:2ceEaS_VuiMqvHnxzTt8jXC9Ze6oUe7iTNGEQyLiYC1eN513DUZknA>
    <xme:2ceEaWZA2lJc_ihl0xpzRDFdnQZY3RGKKoFrkIBFOOifZW-PIBB31z-kyag3w8mv0
    6jRaiI1rV3p3GNcToeD7tFtREw0SAtq-ew5-7iNlH8QwCWX1F1cMZ0>
X-ME-Received: <xmr:2ceEaR1qlHfq2BPFZLm0BaC_-upbO4mDBLmO780OuM0JxLHlwnrtPHEJUkdzIJ2WV8azwOOb4CPAqtZ1FyqTxQFUhXBUkMP-MQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrsh
    hkodhgihhtsehhohifughoihdrlhgrnhgupdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepph
    grthhrihhksehpshhpughfkhhithdrtghomhdprhgtphhtthhopegruggrmhesughinhif
    ohhoughivgdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2ceEaRasMB6HnthaS39mhp0UN3LhsjwOpYpwxMw-9lVUCCnTRcod_Q>
    <xmx:2ceEaZLYErS4XvK0wVhNN8nb9zEBbAJ7f5KesO8GvLUdZPpnT2sKDA>
    <xmx:2ceEaQGBYWxbsiohljNbb8UTKD3HS208XEWR6noQC8ZZf37CnayFpA>
    <xmx:2ceEaQtKX5iPqfADD7Qo6Kc7WAVNVPgsieK35ASGVo9D4yzgfCy5Gw>
    <xmx:2seEaf4Rjlom7rnmYcZY9q8s2ESuvGHE4VLajf5nOiR-litIbkIvT8LS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 11:39:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Colin Stagner <ask+git@howdoi.land>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Patrik
 Weiskircher <patrik@pspdfkit.com>,  Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: Re* [RFH] adding test coverage for contrib/ in CI jobs
In-Reply-To: <ef128e1d-dd3e-4573-bfcd-6a98a0a1f394@howdoi.land> (Colin
	Stagner's message of "Thu, 5 Feb 2026 00:05:59 -0600")
References: <xmqqh5smdejc.fsf@gitster.g>
	<20260115175403.3971-3-pushkarkumarsingh1970@gmail.com>
	<7k7ewvrb5hj3jyesiigy6dvo5w5pl67rk7ihztsuxbtqpymafv@ey64nvhzhacg>
	<xmqqjywuyhu9.fsf@gitster.g> <xmqqsebhu9nn.fsf_-_@gitster.g>
	<xmqqjywtu58j.fsf_-_@gitster.g>
	<ef128e1d-dd3e-4573-bfcd-6a98a0a1f394@howdoi.land>
Date: Thu, 05 Feb 2026 08:39:51 -0800
Message-ID: <xmqqikcbm9ew.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Colin Stagner <ask+git@howdoi.land> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Unfortunately, this seems to reveal existing other problems with
>> subtree tests (t7900), in addition to diff-highlight tests (t9400)
>> in various configurations.
>> 
>> https://github.com/git/git/actions/runs/21617099884
>> 
>> This Ci run is near the tip of 'seen', so there may be breakages
>> attributable to new topics in flight
>
> At least some of the subtree failures on linux-reftable, such as
>
> <https://github.com/git/git/actions/runs/21617099884/job/62298228602#step:10:421>
>
> are actually due to a bug in ubuntu:rolling's "dirname" implementation. 

Ahh, rust bites again?

Is there /etc/alternatives/dirname like /etc/alternatives/sudo that
we used in fddb4842 (ci: fix broken jobs on Ubuntu 25.10 caused by
switch to sudo-rs(1), 2025-10-10) to work a breakage around, I have
to wonder...

