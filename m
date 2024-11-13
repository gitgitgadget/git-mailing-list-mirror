Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721DA186E5F
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 11:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731497051; cv=none; b=RgbNUckjkyV63K3WiahX7TwTUKeXYFvcxb2zRUx3xpyrQSPgDPDuMu4r0+HT/90O1Vb5FtEAcUIhfk3NpKzldCAOxHGRW2Wky9mTEgC1rGGDBjmK1giqKUMHSx2zdKBvBuET/UObm6TFJFdYK55wzQiSGy7WvwX2O4f1LAG3c7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731497051; c=relaxed/simple;
	bh=ZX/8mNOLKYkyfuSo/WW9Gf4LFLTgFRWvYILWNLQEylc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=os7GZiksNYnVBgV+8RgIn4ARyZVhypX1p//dt7LAtI/tp1CC9W3S+R3peIK0niW9TBFUMNI0kOWkaGNadxjTBnOaSnGd9TIfBlIG9xE6ukQZBGETQ56c2sopkRmLMM0CwR4dLo8Drp97iV5ahfHXliPuZyW6P4MS2BKpAoeVEW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JSiCr5mA; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JSiCr5mA"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9AA091140190;
	Wed, 13 Nov 2024 06:24:08 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 13 Nov 2024 06:24:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731497048; x=1731583448; bh=ZX/8mNOLKYkyfuSo/WW9Gf4LFLTgFRWvYIL
	WNLQEylc=; b=JSiCr5mAObwltD++DnSS0bWzmind/ErXkHaqdEYe5/14bUedgvp
	KoD4UtFFCKRWYqOfXGKuAiOnEpcanSOVw9rtx2+YmOFIWKrg4u0VjXOFFO71w/Ma
	lTMB8eIUZ53ywURk5qKF10A/8i1UHZh3/txvpuaPmukQ6UwNYvv1YJvQgeB6mjzN
	cmlR8ge5f8wZ+dfAZMr7a3SD98dlZAROvz0tB7d5aOuAAXWLzETF2ZSQMDE4lpoM
	bLcPG9fX4JqA+FiVZTIYEgILgikbTcQq6CJVtxluwlaGTM5I6n2o2xM634J4JdUT
	LKaPrqDVdCs2UoO2+Jto3i9X6m8o0+vBt0A==
X-ME-Sender: <xms:WIw0Z3hgNvppn_DTUknBLxxYyWs86AmTwsN97b1IM4Bq64_LCtEZpQ>
    <xme:WIw0Z0D_aKojRMDKcprkTGuIfGiloBvDsQG5w-pGiftL7tmJGf-IT2fmGm19E6pH3
    E13NIcxwKHS1u36Jg>
X-ME-Received: <xmr:WIw0Z3GGaKr_DdplPE_rcq-UIFVfnypeyYtypd2OPYujgI5loD9nKy3x8YTivoRnbXpqo5VXUsyGHbpKjiAwmuAPdnS3u6B5pP7S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddtgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrsh
    gthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehpshesphhkshdrihhmpdhr
    tghpthhtohephigvfihonhesrhgvvhhirdgvmhgrihhlpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:WIw0Z0QwWqojRnhwCX5YDQflSYXGSJIUfNQiH3K0y2py7EgsLQsWtA>
    <xmx:WIw0Z0xpt0JMwMvSvxNlOJ1aWr8v94PUjOOAxiiP89KQ97Vuvyj-gQ>
    <xmx:WIw0Z665qKvnYEOn5j2kmtWFIFsBjMsOP6mhZBLsOWk4tpnKL90bnA>
    <xmx:WIw0Z5z0rjA7Y0vjwyojSb02KPuklDZwLazt0s1DuGdCImC_sHymmw>
    <xmx:WIw0Zzru8Ur9Ksm3L5mK_JrzAYNgUftq5BtAGi3Cu55ziR0-SZVqHnJM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 06:24:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Patrick Steinhardt <ps@pks.im>,  Yongmin <yewon@revi.email>,
  git@vger.kernel.org
Subject: Re: [PATCH] ci: update to jgit 7
In-Reply-To: <492a40f0-c8b8-01db-e4bf-10478f1f6108@gmx.de> (Johannes
	Schindelin's message of "Wed, 13 Nov 2024 11:08:24 +0100 (CET)")
References: <xmqqmsi3262e.fsf@gitster.g> <ZzRP7cR6S6YCWIze@pks.im>
	<653fd6b0-0351-44ec-ba31-dbae0e2d3ca5@app.fastmail.com>
	<ZzRXGi_c2ncEJNu4@pks.im>
	<492a40f0-c8b8-01db-e4bf-10478f1f6108@gmx.de>
Date: Wed, 13 Nov 2024 20:24:06 +0900
Message-ID: <xmqqfrnv9y21.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Oh, that I didn't spot. Very much looks like that would be the root
>> cause, thanks for the pointer!
>
> Sure enough, it looks like this was it, as it is now working again.
>
> Thank you Yongmin for finding this valuable information!

And thanks for restarting the CI jobs for 'seen' that previously
failed.
