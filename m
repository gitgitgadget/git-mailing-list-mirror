Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F631DE8AF
	for <git@vger.kernel.org>; Mon, 21 Apr 2025 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745250082; cv=none; b=dzP0Tzm19f1F1p3fxXUsO92cydaC4IQX91SsbRTeBL+EkHr35GU0UZ/jC9QgV7/QD/sPU+ahdal+ZwUiAJEuxXNaTwk9W+pNMtAMgiOe/69RiyOg3a0eKpB9mfYwMa8HHpQN0gdgWQmLIHcWvtsxvQoOWcnCjpUpkvyllwtMjOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745250082; c=relaxed/simple;
	bh=2nua2s7+yOBxL2Qp5phZdROhA/cnzXAOEODiD8gjlbo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ilYTY2/1huBlKYs00hbsYr1kgOfViah3n6V4oWwv6yhw85Q/B9/XKWQ4n3OAP5IUqPjJiP4wcevJRMYeM8vg0uO9iPrKbcyJJ03UXnYnosGw+he6gE7aaFSni02rmGkrAr6EEtwl7iou+NajBXcBPART76Y+Wz/CF/1x5/IE6ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zz1/ITBM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nuFQDDVH; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zz1/ITBM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nuFQDDVH"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 123041380223;
	Mon, 21 Apr 2025 11:41:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 21 Apr 2025 11:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745250078; x=1745336478; bh=y9FJWcPFGj
	d5bQvfclWxWEhgHPnWv7HR2mIbyJWp/7s=; b=Zz1/ITBMNvhHqoNFZ/2FNZuIGq
	9MzvpBCFTSztytZinZhxM+R5DVWxAz0PW+btDTg5405l0lpmr2mrBJAYw2/7rhAY
	yGAbwjpWkPfl8fb/PUvCw22cg7e4/b1iDJm/Ie11wNe9WuOanHe3Qdqp9A+OodsU
	ol4O7bM9x68KXf5oElTBTweao0cLnxbUwvEOnP93DujHKmCloLh5jxrlv/YJyPss
	c8TsdcW5Z6x6RzsJLuGBaqrDzMYTqHtHP90EL1Zwog49OLLz4zLR6btOiHIJ0Igq
	Dk6VRzF8wJc31VY0Ncx3oNwzQOad8zQjuWzEXbRtN8byIhlBkjl+clS+PfXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745250078; x=1745336478; bh=y9FJWcPFGjd5bQvfclWxWEhgHPnWv7HR2mI
	byJWp/7s=; b=nuFQDDVHnD9MXgd12bFIUXUNxHc4u3hQpU0IoAQMSPJC4A/4Xil
	FuQQNCYOJzf7yWP1UhM4RhWW7b3i8EOxTiDq93RBCD78qV0biVhNtE19i1MPah0u
	RV/tms7szr45HSy1YL7ZwN5de8YTY+svzJpg3geGAK1cMy3uR63c2W07L2XGiODC
	SMRNJG79DCMYAsKH9KrcN9ItnyOhT0PrBp2tPVbjwk0zc58mO2mTWQ8URJZY0TjF
	KX1rUCmTjl1eg30BUOl/ZHKzHcxIPXXUySC/sPSxaMD951GMgMjNJY17CwTgaj7O
	wawPpGM2xo+Gju1w1Ob1MOt4XCSPbNq8iXQ==
X-ME-Sender: <xms:HWcGaB461QmNSVqozV1AYZiu225jjAG9TYelEDXoD0TliN-FPIhk0g>
    <xme:HWcGaO7OnqGD8yFTolQguscAmJqlgxNhB89r4m1YgqcqH8OB2g_UzzlN5iH5xINr1
    81c1w4H_6aWEhylBg>
X-ME-Received: <xmr:HWcGaIdHUJ3RUAsrR_zLF5A8vDPDNM6Bo2fW8Csy2Qef0aULa1BcW4iXkE1gPj20gkx406XwqwnkefsdASd76-VNHaM8Ri93_jX9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeduvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddu
    keeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:HWcGaKIqyWLXh9Lo6ZhD4C-qxrkz8DwxP-jJCGfomyv2yEvhCRXWmA>
    <xmx:HWcGaFJ3kNG-1nopKKfxDsom-dWC6zJ2FFhVOMKTd-Aw57pMwbxs7g>
    <xmx:HWcGaDwWNaL-Xt-JiUIcllR_b1h3lFA89yaewr-yNP6MaHLQLMa2FA>
    <xmx:HWcGaBLxgbxnXe0o_3KSFgw-KFZ9rUPw3U77tYImS2ho6twjtr69AQ>
    <xmx:HmcGaDadzjW4wh8MkToFPcumDtyfiR2EvShxC1LshCm4T1oxjSkhhRAV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Apr 2025 11:41:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  toon@iotcl.com,  ps@pks.im
Subject: Re: [PATCH v4 0/5] meson: add corresponding target for Makefile's
 hdr-check
In-Reply-To: <8b380da4-8d27-4efe-85fd-3bb599188fe9@gmail.com> (Phillip Wood's
	message of "Mon, 21 Apr 2025 09:45:59 +0100")
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
	<20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
	<xmqqh62i6jli.fsf@gitster.g>
	<8b380da4-8d27-4efe-85fd-3bb599188fe9@gmail.com>
Date: Mon, 21 Apr 2025 08:41:15 -0700
Message-ID: <xmqq8qnt7c9w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> "git ls-files" is complaining that there isn't a git
> repository. Looking at the output of the checkout action (reproduced
> below) it appears it is extracting a tarball rather than using "git
> clone" because git is not available. I don't know what the best way to
> fix that is - I guess we could run "apt-get install git" before
> calling the checkout action.

Interesting.  The use of actions/checkout@v4 is nothing new in
Karthik's series and we haven't seen this issue come up.  What's so
different with this particular series, I have to wonder...

Thanks.
