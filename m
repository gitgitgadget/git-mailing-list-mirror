Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF8128399
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 04:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733114306; cv=none; b=BswxhjvtLdK3aPzUYtWQMWKxDGzV3ii7WkGktUy+vDd1pVsP8SPD6fV7OlqvX8zD19CC7v5FVvyABwbGuWJwELS4zmt2dBt/IjLDKAj2xjYAi3XzK01MAjLJVW/7hOmsCAdJFbhG8jdxureZ/XBjz4WMQAqulxYhtwQps6PXzks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733114306; c=relaxed/simple;
	bh=aHNM885AMmC0TRUqgwvQn5VoRO37C0o0C6ulcnB/rWw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R4KS5/U8r3HK5Ihp8smIc1L6XZ5wUr1X6478CgReYb21s3DC3C9cTB+tfoRS46cxE3oetSTNM0DFZMirvTUAOlSDqloUbxN4ptXFgVy7KWIM9G0a8o210TsjLe4YlUmTo0YBPN760H4uHbyz5Ay6RMEHXFfiCBVSFQrEKjmMREc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XramD6i8; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XramD6i8"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 0DFFF11401B1;
	Sun,  1 Dec 2024 23:38:23 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 01 Dec 2024 23:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733114302; x=1733200702; bh=76aYFaU41FRYB8sy3Q0k+1u8uHq5TMXhR3f
	GbYnuNtE=; b=XramD6i8UuQXUqFbV4uhOdXlJe1+USKGAZfwOcM/kbRwbE9rXYK
	5q+gCQxx6XErqaZQCFCuvvpIfCCmg3e7M4aqX0IlRSHMTTj4ft0iQAAAG/rw4BdW
	LQEEcfg9kCXU8/9cyzZmOZ5KqHRr9vLDBvWYuSq96iaFfaG5U39hR0ESanHmKl++
	y1yk0vYZOhhSUAR3Pu0cnGKXFqEnQ5auemDht4bxcyBBByjOcqXVXaUciqIkX6NP
	/u+Bua3jURiSNz32nrVMs6wHv2QI15oGUvG6/px689ydJxUbD0MJIa8bXf+NK4bo
	S3tTq2T5BOhMR0YtpqqSp+zhgvN5zjH8ALA==
X-ME-Sender: <xms:vjlNZ6rB_Zuc82d7VwQlFB_TDZPO6-B9aH-QfPZbDrwNYt09dmshbA>
    <xme:vjlNZ4pNuKMFUHZJH7luNfQcLXRzIVdmU4ZLWCEaRkDTfLSnhXUciP7CkBpeXjFXG
    ysPUkLsGvui1TN0Kg>
X-ME-Received: <xmr:vjlNZ_NXu2kt0WhscTWvdCxJuvF8pbwkCrl0JUJGlOa8yYflzn2rSNWXD59nJCrfcE3Pt3dIHkz5aEpRraQddUDiURhbTQz9eHoq8Sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheekgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevte
    etjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehjohifih
    hlrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:vjlNZ54wsGiBzo2l_8MW5f9BQinxJv31BNCzdX7Deu_oA_J5W8va8g>
    <xmx:vjlNZ55rnvAw4yzyqYY9d5auEvD2AbJx5aUvqefqeValcQ4bqggJVQ>
    <xmx:vjlNZ5hisoKJsDeHkfQwtLfmOKywwoanarZzDCcQS-kyVA6ddHEHmg>
    <xmx:vjlNZz4cRhF5_ZVGMavZ8IyPPQRVmHkznO_9mguu-o9okAl82BS0NQ>
    <xmx:vjlNZ820e7EUSlqZQgAgqPovZoblB6u6obS-9z6E4slOgRrqT00VQFA2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Dec 2024 23:38:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@jowil.de,  git@vger.kernel.org
Subject: Re: git tag -a HEAD leads to ambiguous branch name
In-Reply-To: <20241201224408.GJ145938@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 1 Dec 2024 17:44:08 -0500")
References: <47cdf937-6192-4c83-a0e5-700e98f36c1e@jowil.de>
	<20241127142711.GB1712@coredump.intra.peff.net>
	<xmqqh67ss1a5.fsf@gitster.g>
	<20241201224408.GJ145938@coredump.intra.peff.net>
Date: Mon, 02 Dec 2024 13:38:20 +0900
Message-ID: <xmqqwmgiits3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> But I don't know about this. I thought when we outlawed "git branch
> HEAD" that it was quite intentional _not_ to forbid these names at the
> lowest level in order to retain backwards compatibility. They are just
> about preventing common UI mistakes.

Yeah, I think this is a sensible way to think about it.

>> There is a dubious test in t5604 that expects you can create such a
>> tag.  t5604.22 wants to create one:
>> 
>> test_expect_success 'clone with reference from a tagged repository' '
>> 	(
>> 		cd A && git tag -a -m tagged HEAD
>> 	) &&
>> 	git clone --reference=A A I
>> '
>> 
>> and t5604.24 wants to use it.
>
> Weird. Comes from 09116a1c31 (refs: loosen over-strict "format" check,
> 2011-11-16). I don't see any reason it could not just be "foo".

Hmph, yeah, reverting the code change of 09116a1c31 and then using
'foo' instead of 'HEAD' fails the test exactly the same way.
