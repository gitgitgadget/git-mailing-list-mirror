Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EDF3375D1
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 17:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757527137; cv=none; b=DqTf0IyriOQJ2AUHt0DSqiESH+ERrORJOpsf+4lSk63rIV+h04Pb57m9nsSj9IicA2d+R3bzF2q0xpyvCjNDP/yoXMk7A047iLJFVVZh1gaXsNLGfZZvtOga4aeAdlICJut4yiKe0y7osgStzPKsFqxdjkyz773PD+yoli9KD+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757527137; c=relaxed/simple;
	bh=35vMtTDsjY3/obmDXORDHLpCWw82lHtDr5uIYVOVy0Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=d5v7lO0RV/Q2hS+64hRh9BcwQFPsl5KNuODy3/3MKfO/6vB3i1KegHF/AZvTn5AA+NeQYhOZ4IjHRDJiUd878n4iloltoCjQCBhXgackjm6kvwc+wsx+UP++h9gZOVk5iymp8C40VZzl8Byl0q2GuGtoxQeKA8Uul9oBhvCdZgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=SOiBMweS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fEaIDsWg; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="SOiBMweS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fEaIDsWg"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id B9E5D1D00146;
	Wed, 10 Sep 2025 13:58:53 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 10 Sep 2025 13:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1757527133; x=1757613533; bh=oPFgbRAdl1loDSHdKq/Ztq1nUHFo7CsU
	fOV9Zerwlns=; b=SOiBMweS4QaxUCkhY1yMSPrecnTO7hM5iGaYfVRgMee/Xa6t
	4aOJ4gd6KOfEdjfiMsrd6aYvpWYD9u18NWTa/WXLJluzcKZvx6Xc2/gvPUprcvgh
	mt5ye9yHHV0OwbDCctRX0clsQWJxbqMNEt2X7cmAok981gAFOs1B3HJPLpoB88D3
	1LBSJGjlwW8xiGv9doGw7QGMVecMqX+gKeylDQNzefD2B1hPe0JPoE+jv8MecmfE
	P/mIc6rJQF1h2qr7tyKPLzUUwBuLmEQ0dQd9rMSZz+Qq+YTI+L9iH6ztefaiatTr
	9P+vseyVBdexsDMWawnQXCegMYRj1rZCfnZCtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757527133; x=
	1757613533; bh=oPFgbRAdl1loDSHdKq/Ztq1nUHFo7CsUfOV9Zerwlns=; b=f
	EaIDsWg3h7+FaWxPplODmCDNjJ8Q8X6Edse75yu1pcAYMA1KagZvSN3DJXNQNaKD
	kIU6+EKfgrDR0SC7MdN+PEb78kpzbLtAbSTGgQBTrgjeJr/51SmjajuKoBju5dxC
	qJIDb7mh7rmDGtoKEEeNL0JZ41oXfkmkb4q2A0vnlGk/cNYif7srlWBLdVMSCpts
	LADdpaEIOIuB0zpW5aKzxXIInGRoKb6zZVc3FACE43P0YsNNf+9OHESLj0MoOQnx
	zRomrEWyh4WlBj8eGTtZAIIxe65DjDHatpj2o2UvhtrvbJkZ4EdWacZ1ceK8aDjm
	stYGpYTtW2BWlOZZ+gAhQ==
X-ME-Sender: <xms:XbzBaE2mNqoT4pirNKaB18O_Egfq4K6J8D5bgvqykMqwRTjwfPEUSyQ>
    <xme:XbzBaPEYoO-N9-5L-nGgu1-HiqjfeS7Rzfmiqc02NEnNRqHluY3Nyui8-nlQJ4Qz2
    THR5dEB14YnMa5NSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeefteeghfegfeevleeguddvkeetheeiveffudej
    lefgudffffejleffffeludekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:XbzBaPXdOjWhfPhWh8U0u9dlcVdiMVcCBRnWd_F0jZurPmoS8r0kew>
    <xmx:XbzBaEtcbNYXyLg-Ad1JvwgLZgaBBGYboBPT76lY_-EmbbhoL9M_UQ>
    <xmx:XbzBaKYHL8qpQx5g7olJio66jKH5rzlZfiVfAQ5T31HRlTwWormDVA>
    <xmx:XbzBaLWtJq4y2ADIeac4Aqd-gZF4DnFCxkpRvU3uBQWeSjGPiXJP3g>
    <xmx:XbzBaPeSp90YQllasgO6Fk1RAVDmKpSLip8CFj_aEUcWGY2OQlDJLe1e>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 17CA11EA0066; Wed, 10 Sep 2025 13:58:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ai977590-_NN
Date: Wed, 10 Sep 2025 19:58:32 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Jeff King" <peff@peff.net>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "Eric Sunshine" <sunshine@sunshineco.com>,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <b39ba543-24ad-4bd6-be6e-dc1b8a416eb0@app.fastmail.com>
In-Reply-To: <20250910154859.GB562601@coredump.intra.peff.net>
References: <cover.1757345711.git.code@khaugsbakk.name>
 <cover.1757446619.git.code@khaugsbakk.name>
 <672253e0e7167c40290d1fef6d5076adfbe25d80.1757446619.git.code@khaugsbakk.name>
 <20250910051347.GA556174@coredump.intra.peff.net>
 <20250910154859.GB562601@coredump.intra.peff.net>
Subject: Re: [PATCH v4 2/7] git: allow alias-shadowing deprecated builtins
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025, at 17:48, Jeff King wrote:
>>[snip]
>> There might also be a way to do it just by calling handle_alias() and
>> checking its return value (it seems to indicate whether an alias was
>> found, but I didn't look through the whole function carefully, or thi=
nk
>> about the implications of how the done_alias flag works).
>
> I _think_ this is correct:
>
>[diff snip]

Thank you.  The best I could come up was making `alias.c:alias_exists`.
Which must be redundant given the call to `handlke_alias()` that you
mention later here.

> The handle_alias() function will either:
>
>   - return 0 if it does not find an alias
>
>   - return 1 if it finds an alias and we should loop again to run that
>     command (but set done_alias so we know to suppress in-process
>     builtins below). The "args" array will have been updated with the
>     new command name.

This case and the `continue` seemed to make sense to me eventually.  Not
the `break` case though.

>   - exit itself if it's a "!" shell alias that we exec

Yep.

> So we just need to loop again when it told us that it found an alias (=
it
> is tempting to just continue in the loop body, but that would miss the
> case of a deprecated alias that resolves to another deprecated alias).

Yeah, that=E2=80=99s subtle.

Do you think this should be a test case?  I guess it doesn=E2=80=99t hur=
t.

> Anyway, I believe that is correct and solves the leak issue (because
> handle_alias() does the lookup and takes care of cleanup itself).

Thanks again.  My local test suite passes.  (Except
`t5801-remote-helpers.sh` which never works for me.)

And thanks for pointing this out to begin with.

--=20
Kristoffer
