Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2361C25A35D
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 20:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758747305; cv=none; b=Yx5rQaUqF9PyN3jV7sfcOg631z4OZ6SapYdiF+iX3wjB2IWRPMXI3Mp72bYkXS817do6+tOW2yYjNyah5ApfULVnlCen1Cesr83Xets1/ClwQij8oTiyciLDWAszebk6/L6kFQT7lnmg7IexUdY5KYHa+ygeRO8zRX19c4XAOOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758747305; c=relaxed/simple;
	bh=HxsmplmClN3mxU4vahwM74WNh0b7ZN+FEuPZGKcPsX8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Pjpg3BAMl4dYOTxSMk+FfgYZODWJQF8B4Z3AtqThJ85SMy12XWF5Q3ejpenMTyVQ2M3DiNoOlEpp0tbAnXPEXEvBtZZI8MReoDOrARRrwTieJoPrfblnzwWDdYzLxHdP30kmDUE27qeqL/qdsdKbRIkkF6R7H7IKqIzoQVPPX4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=HLPjfe9W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ApDM2BFx; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="HLPjfe9W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ApDM2BFx"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4F32A7A013D;
	Wed, 24 Sep 2025 16:55:02 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Wed, 24 Sep 2025 16:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758747302;
	 x=1758833702; bh=5BRuGF3Qzcv7Kpq5molfAgoB6uj5qUPOn4/PRjnjQW0=; b=
	HLPjfe9WSq6y/IhISpfNOuPpzbJ+yJVIMtN5wHc8w27Q5elbXY5j8QlIbPkPbdRP
	h0ABK1UXCKCc9EmOGsNq16UpRZs9YfNsoSqaTViPpOjjC6+uD3r9LENHCs3/61Yc
	zZ4vmr5deVlRozud2b3fAVFV+BOFNnmWALllWRz8KxqG/Ybs9q7i/CjKowzqxxsR
	5sHRQUD3JT9h8x5dqf8gOOyc5JejRVq04fIx4AhYBhcMlE72xBkXvYjU6tIusYal
	rw3WRtRjQIpct7pyZ5dbINycD9I1nhSbxZ6hmljRbsF3L2KCSJ0/w2F4EBJIxDOn
	ABB67hcQtQw2qA6EbaugMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758747302; x=
	1758833702; bh=5BRuGF3Qzcv7Kpq5molfAgoB6uj5qUPOn4/PRjnjQW0=; b=A
	pDM2BFxwcNa99fmw1k7YKQxYh+16WmII22tg9MWf7H2U5KAzUnlnT6z4dhvQN2bi
	eIk3vm+J7jCItJFc1vxPNmk+Oy1QlXB31wIhkBIqOT62Ua8Ek9xgBZURgXdJ/+2t
	IF1SWkUv66y6PlYUteVexsc3jGfsVFBt9sJbgEohz4Y6MD/Rh6M6ud05KIfyTjj/
	lDOJ0UcBCac1FbfNMjX+Iuk8h2FX2bVGw+Ra2GGwujM9zEjsaipuZn+wFEBUd49P
	JySo+DeLAJy7Y/Jv0OPoTwC2YDtzFoc1sb4P7qKCJV3oU6Zoedh1/Bx/Pc3qucN1
	RHHcB/7LV4QjW1hSwgBMg==
X-ME-Sender: <xms:pVrUaCR6p1mGjLibaSWYcg9D4WZAXmyUeqj0se4aUyTlvpignihsUw>
    <xme:pVrUaCktylDANv5XqGPTjXNhziqXNt54qLEkvbJTgJ2nH5DBuiFhAEDnt8qpwdlLk
    ZQrEkyEG0fvzrkSRwPmxXh5EudavkGAQVLZiCZqV6majN7Vp76Pj3c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigeeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfluhhlihgr
    ucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhnshdrtggrqeenucggtffrrghtthgvrhhnpe
    fgveekudeviedvveeuhefhvdetgefgffdufeeguddtkeegtdeltdevhfdtuddttdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjuhhlihgrse
    hjvhhnshdrtggrpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:pVrUaFv_b4inPoGzTBnbwzxneH-jHofq3S1kYJXWMKkQcYhGFfyIqQ>
    <xmx:plrUaGP_yfFNU-C-Lp20wBkb342iaKn6uIsCq7mAbYd3k0DqvJ2QDQ>
    <xmx:plrUaL0qGiJcjobXzGytMYj3z2g_wHUwzVdLdR_0apfPisu-qN99kA>
    <xmx:plrUaKOBV16yhDca91fUJJBHQbFKmhvUviQhoQLcElKCCi8tVunSdg>
    <xmx:plrUaBN4H-gG8l-wf1SsLC8_l5TW2r2hJGQ93DNUOXii0PEA2qRiG7nZ>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D8B8D78026F; Wed, 24 Sep 2025 16:55:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ATtqAgZ0pDEJ
Date: Wed, 24 Sep 2025 16:54:40 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <f6dea581-04c5-4b05-ab81-1fb06de1cf41@app.fastmail.com>
In-Reply-To: 
 <CALnO6CCkWaxZKGseHR7dk20erFPAvGMqO+OYr3Np+y+=1Y34HA@mail.gmail.com>
References: <pull.1976.git.1758656702.gitgitgadget@gmail.com>
 <ffbb9d7c6aff77f9a1caed86a20bcc6b9afe66e7.1758656702.git.gitgitgadget@gmail.com>
 <CALnO6CCkWaxZKGseHR7dk20erFPAvGMqO+OYr3Np+y+=1Y34HA@mail.gmail.com>
Subject: Re: [PATCH 2/4] doc: git-pull: clarify options for integrating remote branch
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


>> -More precisely, `git pull` runs `git fetch` with the given parameters
>> -and then depending on configuration options or command line flags,
>> -will call either `git rebase` or `git merge` to reconcile diverging
>> -branches.
>> +Integrate changes from a remote repository into the current branch.
>> +
>> +First, `git pull` runs `git fetch` with the same arguments to fetch
>
> Hm. Is it worth saying "similar" rather than "same" since we don't
> pass e.g. `--rebase` to `git fetch`? Or is that detail unimportant in
> this context?

That's a good point, I'll try to think of a better way to phrase it.

I guess the truth is that `git pull` has three categories of options, 
those it passes verbatim to `git fetch`, those it passes verbatim to `git merge`,
and the others (-q, -v, and --recurse-submodules).
That's a bit of a mouthful but maybe there's a way to say that explicitly
that isn't too awkward, it does seem helpful to know when reading the
OPTIONS section.

>> +remote branch(es). Then it integrates the remote branch into the current
>> +branch.
>
> Plural-singular here leaves me wondering how Git decides which of
> multiple fetched branches to integrate. A quick test of the form
>
>     git pull origin refs/heads/\*:refs/remotes/origin/\*
>
> just gives an error in every mode I tried, so I'm now confused about this use :)

I find it confusing too. My current strategy for handling this here is to
somewhat awkwardly say "it's explained in the DEFAULT BEHAVIOUR section"
a bit further down.

It's a tricky situation because I find the DEFAULT BEHAVIOUR section very
confusing. It seems like there's a fair amount of duplication with other
sections that could be cleaned up to make it easier. But removing the
duplication and making it easier to understand feels like too many changes
for this series, especially because really doing it well probably involves the
sub-project of "clean up the <refspec> section of the `git fetch` man page".

In any case, I'll see if I can find a way to make it a little less awkward.
