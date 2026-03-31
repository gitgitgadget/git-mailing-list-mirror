Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3243A3DDDD0
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 21:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774993338; cv=none; b=nS3Ezinj0m+nWwUj8rntknTwv2v26WvbUHQMbuzK7h7hbVKYeyACKVoMJflq6tAGzRH8AZOvBMsZ/hcUQd65EwrZYCqhSZ2Aa/e+gpyq8EsZUpFNwVRRzgym+0HWuKcD30OXASLwo6YizZHzwloId3cSm4DJeORX2rknmZyCBoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774993338; c=relaxed/simple;
	bh=dSSLLOPtwVSH8YaJuaQyq18Sz6/iuvyeqXII0z7jh1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rZJiAm2GSEekRRZwm7rQ4YtxbSJDPlhI0rNXuxZjdPKx9XwgNI8WNTZEekcY5xENIH/wktxhkH6QcxKRmD+AehcLAUJAV6t7YBtGTkLqeY9lBIVt5f8eNoxxE08MkijKtcgVu7moX5KMNh01vdvSpJVib/nS6+e/lVLUDXMggJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hN215v1L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NRNloKmW; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hN215v1L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NRNloKmW"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8355E7A00F1;
	Tue, 31 Mar 2026 17:42:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 31 Mar 2026 17:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774993336; x=1775079736; bh=89FlzQ7dgb
	7ult7LXUeuE3E6h+avbfvpeSsmx4jl82c=; b=hN215v1LBCOKAyfXSSHkioe0eK
	3xhWUnrRo8+kOhqxJHCSdW2fjWzD2rXny1NeBAQd1PeBNNqVTAZe0U8GuQoIWk+0
	m7IlgqpM8y6RVLvBfAs+y+h7ppMgV7PpuntcvjblJ+eZhBHQRC8xirkgXDSBnCPE
	8HEMaqXWLtjMMEvZg72tVKPWGwHdAnJYWPeLSOyT88eGscSutOXUEDSumUHt70B4
	ALAJcpGpvo7WN4bjJpXeZT/VJWRwlwlH/sPFN5bybR4+0nqNekfe8hwrnxmKu/e5
	VTzNVS9R1TcX0TmsJdHLe14Kkseu6W+0Y1hoqceSfZkdTxIK4HmOZgFY6iCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774993336; x=1775079736; bh=89FlzQ7dgb7ult7LXUeuE3E6h+avbfvpeSs
	mx4jl82c=; b=NRNloKmWb/7gHO2eO1LuGZn1C7SiYiLavUkslSh6xKCVi5dIShO
	LM6JQ/+63zVZ/FtLRtHPKuf91jSzD3u2x2Uccck2tl7lALU4nylA1b2nDTrWJvhk
	wWKsOGo2E2B+tkesdkz17WXx2BnsMtZe2j1At5s74b/rHsuCo6ZrNL84/DHgbP4T
	wTy4M9y5uPtyHqsw+6JIajkaas8jGi9li/6lvDZRUtD3cqkM0yw9lFvzwNyBUFZ7
	lmKQFWX9fkC5gI0DiP6N4NvjzJMTFPiQQIJjTrym8JUJWU9AVhW9p5kF6tUAiIRQ
	ypTXGXPVrqmrNaG8/E1FFN10snyKqXVSY4g==
X-ME-Sender: <xms:tz_Mad7MsOQPzRpu4spEyOa1IpePAQk8R2pxUlCKNfiNunYJiSrSwQ>
    <xme:tz_Maenvb49uJvTEZ_5sUiaQOuiwCB23dynCqIGBiQgQGQIBo6j7vito0ngv8Np57
    G5iG3WXcjEUCyIaBiXSeFFX25rbtNYGPuayWor9REGSMgLTU-FgCBo>
X-ME-Received: <xmr:tz_MaeTWwyXp9sEOW2H_jFWU0YaOXv6BlbyHVDTFn_mv0XHD5M_24wJs-EvFAK2JjYFD4pJPfNYIJhFxBSHlXkREzhXeFT1DPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefud
    esghhmrghilhdrtghomhdprhgtphhtthhopeihvggvtghhvghnghdrtghhihhnsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:tz_MadHGkL2qnDyUUeo736Q8ZD4ApmKMCH2wdbrr4V4TGQSXawcvPQ>
    <xmx:tz_MaTE8ZracB0fuQory6pA7Gs1RHX6pHZEZzyQeuAEGf0rQIiikUg>
    <xmx:tz_MabTF9w0sk8AFMFIijR-xU8k0cPdGROTHP5NwCCR6hQ-HoP5n3w>
    <xmx:tz_MaUJcF_bmB2CIObgr3B92yHuEiuQf-PqYlXXjSDORksTip20m-g>
    <xmx:uD_MaXGuepD73OSW0zqPvSSII2mYs_2QHAyP0S-E3szu0_vRmMr-L3zf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 17:42:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>,  Siddharth
 Asthana <siddharthasthana31@gmail.com>,  Yee Cheng Chin
 <yeecheng.chin@gmail.com>
Subject: Re: [PATCH v2 0/3] Add option --ref to git-replay(1)
In-Reply-To: <87tstwl9g7.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
	(Toon Claes's message of "Tue, 31 Mar 2026 09:55:20 +0200")
References: <20260323-toon-replay-arbitrary-ref-v1-0-5c7172f675ec@iotcl.com>
	<20260325-toon-replay-arbitrary-ref-v2-0-553038702c9c@iotcl.com>
	<xmqqjyuynv99.fsf@gitster.g>
	<87tstwl9g7.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Date: Tue, 31 Mar 2026 14:42:13 -0700
Message-ID: <xmqqfr5fy8ui.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> As sa/replay-revert has been updated, I rebased these three patches
>> on top of the updated version of that other topic and merged it to
>> 'seen', which broke CI with t3650.
>>
>> I naturally suspected that I made some stupid mistakes while
>> rebasing, so I applied these three patches directly on top of that
>> old sa/replay-revert.  Unfortunately, the same test t3650 fails
>> exactly the same way with merge-ort aborting.
>>
>> The failing test run fails like so:
>>
>> ok 45 - --ref with nonexistent fully-qualified ref
>>
>> expecting success of 3650.46 '--ref must be a valid refname':
>>         test_must_fail git replay --onto=main --ref="refs/heads/bad..ref" topic1..topic2 2>err &&
>>         test_grep "is not a valid refname" err
>>
>> /home/gitster/w/git.git/t/test-lib-functions.sh: line 1180: 2840466 Aborted                    (core dumped) "$@" 2>&7
>> test_must_fail: died by signal 6: git replay --onto=main --ref=refs/heads/bad..ref topic1..topic2
>> not ok 46 - --ref must be a valid refname
>> #
>> #               test_must_fail git replay --onto=main --ref="refs/heads/bad..ref" topic1..topic2 2>err &&
>> #               test_grep "is not a valid refname" err
>> #
>
> No need for you to worry about those conflicts. I'm happy to do the
> rebase myself.

Will wait for updates.  Thanks.

I said I suspected that my rebasing introduced a bug, but what I was
reporting in the message you are responding to is that the patches
without my rebases are breaking tests.  So perhaps you do not have
to rebase and there won't be any problematic conflicts, but the
patches do need to be updated to address the test failure.
