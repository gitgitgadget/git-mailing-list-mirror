Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9076280324
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 20:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771619040; cv=none; b=DTq1BGSzu7jAEcXYDFBM3wYFvYebZdeX8orzoFQbgUsQ0grldzOnsH7SGVu7lWy6HUCU8kldVQVn5u876jW1Wpa5ckoSUSUCXiG5NK/GFqP8Rd8ymt1XJtzUjfUpXfTAutcECw5yf9I+LMJ3uvM+qVoLDKUAVkWqizP6GUS7q08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771619040; c=relaxed/simple;
	bh=HWOvUofoXZ06/Wfm4NOdYAK9lZEoB4qwjecrM+N0Xdw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nAtPh+f+ejk4y9q6KbXP5sfZNZ6y9IiJaSbNdVpQp43NjFWITL2xZ9kEG15ct55VjQYRmFXh93fBs0YZsLjgXNLAP6PU9k8dRDq+xPovPY0yzBdBSDN81tHeQuPsszCDnUTDECJ4e8jILNTkyEqNMVw2SP1lLGyWKTXpPLgIFtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J6q8e8bJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g8PBDnJR; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J6q8e8bJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g8PBDnJR"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C15767A0161;
	Fri, 20 Feb 2026 15:23:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 20 Feb 2026 15:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771619037; x=1771705437; bh=JUq+qRSfv+
	OkPupqNKiB3ed/Id+kmywYh28tJT43ygk=; b=J6q8e8bJrucCpC8aYfA7kobkqv
	aY9xPv7DEAiDWMWATgDnGFnLhUxU8xUwcPcIDcdd/8Bvob2Gx3b6f+CbkPpKCd5/
	3wbRQxDTD4B99OH4kxCZWXNgL3bR3vk9klSOzqnzWWUNA6a7OLjp40mQjTjoc+wt
	VMxbtamm/fQl2Wfi/yDY1OM8Xbmfej5nT0woCZL7Urt3huDYZdgHYzHTWadAIG77
	f+6QnfZKdYyBDpduUnWaCXrTGaC0bIsNbTHu1L6Z/hILyr8o/jk1TFbijZ8jdiTo
	JsTXSu3OpffUW7+/Caf6I8Fw2VYk7CkJdPPQmzOp1+PAdtnl+4DmaCSTglug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771619037; x=1771705437; bh=JUq+qRSfv+OkPupqNKiB3ed/Id+kmywYh28
	tJT43ygk=; b=g8PBDnJRpynyBzX6g4j0MjzpvIzWck60flU8kOUmTVjAl0gERL9
	eY33+86qb1Vc9qmZmDC/YC/SU3Q9n58rpcKIoPkuAFHo0zSSIXFD43SQzelkzx13
	nvY0P6qTHkbGwwwaHQgWYATTJcjheLS+cJ09xm/JEb+XJQ2K39BIog0vMGjPh4yh
	2aVSf0h3ihLWWJTVDqL558YlqI2X5czK9xT5Nta8+mISLSnfx8xMXifFPn+Qs8Ye
	O6LP+dT+q1z7UOD3DD4muJ7KFAmMrOK/Y/KusmWXOhFnzLKKV0Nl8M+hchwRUYHe
	epmuaIiBlYMYV5HKC+gHXXJLX8uZTipuOwg==
X-ME-Sender: <xms:3MKYaVi9e0C0Hu1kHUlywCeID0wyXFp-sx6iUKpbWkP_hiFX-JYdtQ>
    <xme:3MKYaYQ0ZeDGcT9scvOEhAxzxe--XcgyPaeVIXvBG2-tIKabO1_VYQkEFyeS1kWNE
    5qaHULXQEoT0xQW_ReP7HV9PhgFXC95Vf9vyzNpqkRCwFRV_qANyQ>
X-ME-Received: <xmr:3MKYaeY3RFHsF2gPh_d_Rg5xu1KAnEQK4uW6WSgseS3ycp51IMjVnkfFOQnKSPpXSZdWuqlAg1Yw-KIoQYQTyfdPS9NCSPjoHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdelfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtth
    hopehsihguughhrghrthhhrghsthhhrghnrgefudesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhish
    htihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhs
    rdhimhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhope
    hphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:3MKYadRDMdcU8eBS0gxJ-nOA6jtvzP5GBj6etgWnMHUS6qAO6D6nxQ>
    <xmx:3MKYaV90JRJywwYGE0AgOcOPZFjDkNyX2ABF2CD-oXdLmteCch2GsQ>
    <xmx:3MKYaVhRRceHoPcTLvzM26lMiLnw0haOqF6Y0OzvoRSFZ9wFSEuZqA>
    <xmx:3MKYaebrCTXLqmFpyvOLprxB_Wgfea9O-RxpUadZ7ZiTPwIxTGS6dw>
    <xmx:3cKYadVWBHn5MLtQn_IfODfKW8jOUD1YP4O0G_LkVsIJeL67Q43fblHh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 15:23:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Siddharth Asthana <siddharthasthana31@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com,  ps@pks.im,  newren@gmail.com,
  phillip.wood123@gmail.com,  phillip.wood@dunelm.org.uk,
  karthik.188@gmail.com,  johannes.schindelin@gmx.de
Subject: Re: [PATCH v3 2/2] replay: add --revert mode to reverse commit changes
In-Reply-To: <87tsvbe2sm.fsf@iotcl.com> (Toon Claes's message of "Fri, 20 Feb
	2026 18:35:21 +0100")
References: <20251202201611.22137-1-siddharthasthana31@gmail.com>
	<20260218234215.89326-1-siddharthasthana31@gmail.com>
	<20260218234215.89326-3-siddharthasthana31@gmail.com>
	<87tsvbe2sm.fsf@iotcl.com>
Date: Fri, 20 Feb 2026 12:23:55 -0800
Message-ID: <xmqqy0knw4dg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

>> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
>> index 8d696ce3ab..ffdf790278 100644
>> --- a/Documentation/git-replay.adoc
>> +++ b/Documentation/git-replay.adoc
>> @@ -9,7 +9,7 @@ git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
>>  SYNOPSIS
>>  --------
>>  [verse]
>> -(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) [--ref-action[=<mode>]] <revision-range>
>> +(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch> | --revert <branch>) [--ref-action[=<mode>]] <revision-range>...
>
> The modes `--onto`, `--advance` and `--revert` seem to be extremely
> different from each other. So I'm starting to wonder whether it won't
> make more sense to instead create subcommands instead of options for
> these. Maybe something like:
>
>     git replay revert --base=<branch> <revision-range>
>     git replay pick --base=<branch> <revision-range>
>     git replay replay --base=<branch> <revision-range>

Given the earlier discussion on confusions (mostly by those like me
who weren't closely watching the topics around this command) on what
options among --onto, --advance, etc. were incompatible, etc., that
certainly does sound like a good way to make these distinctive modes
more clearly stand out.

Thanks.
