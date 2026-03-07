Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E910527F75C
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 01:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772845499; cv=none; b=pBELaYGMeDMGr9TnCZJKIsYQP9r7xx7xzWQhQJio2DgGAd9U83C91HmZO56ZsPI0c/X7GGUncY2k64oZgxPFwueRRE7oHA0dRk+yJbhLB51hCzPsl9B6oKMz3LiS3Dw28O550BDA2lM1rUF2NnzZw1vBv4j1PrlnhDjF5+e7/bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772845499; c=relaxed/simple;
	bh=4GcS2dlOrJyrDRlrHJf6AIY5I3dpYhTuERtEVQaozZE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DtR8kCfilqBpVfecgfMERjAz5C3wAtCdeFBXRWh+hcdcVfldP6md6oQE536aAv173sVt/DqBot/jRu63jwLTUVeN30MKoHvbZke5WUeiTm7zWeGPDkh7e2VCj3QcLv76kmaMrrvdkeClmc/Kdf71ldluZkzcrXbPzv4fvTKPuoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=braithwaite.dev; spf=pass smtp.mailfrom=braithwaite.dev; dkim=pass (2048-bit key) header.d=braithwaite.dev header.i=@braithwaite.dev header.b=YQOn3+vv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=An78INY9; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=braithwaite.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=braithwaite.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=braithwaite.dev header.i=@braithwaite.dev header.b="YQOn3+vv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="An78INY9"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1253014001A4;
	Fri,  6 Mar 2026 20:04:57 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-05.internal (MEProxy); Fri, 06 Mar 2026 20:04:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=braithwaite.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1772845497; x=1772931897; bh=GXhFJhSQoSYRcgUq/Y2Clva+MtsHQLFx
	BO+yU5Vvsrc=; b=YQOn3+vv7OETrMQ9lJUl0fI8BlE/duHiZ8UNjx/kd2P6V4AY
	rXxU1QMBSgVYCcaqfZKoXhQxLNuvBsqrgC3Mtyx/FSQTRh0c677pjKXr50eQeTZz
	hKa2O27qQvvFb3GEj0B03GpIdCOV+RXXrbWe8RqDkDbr1/9sQIOR0C9+7c4WP/oC
	Q+qOS41yM6wHMF6LSzCnRot2827fNJkp+nXu99l2NHvFQfKCh6z69frj+TsCmuXi
	sAjlMbaPqqeBZtBEsylslVLCjAooqSn4GgXe2Xosx5TD7YEGZaJEDmch2vKX11ym
	7duNBXHGquagwSUlqpZb4YMdlrQmHLaLx/jymw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772845497; x=
	1772931897; bh=GXhFJhSQoSYRcgUq/Y2Clva+MtsHQLFxBO+yU5Vvsrc=; b=A
	n78INY9pQJnnC0v0kHNDNNO3QgVRBTrWYPSrmxuO7pZRNGJnHnYe5H5Hlyl76f2B
	uILEVaDCcDj2hzbNLvbKyiuTNPJhNNqcFy6tzcSDCsvUJjjCkGi7NA9tOpipOqAM
	mVP8CK6rnn1zoWqyifRw7gM3QvsvR/hQoAKGyyASgQXX/pSn7dNBcehnKU4iL3sW
	zKSmKFLq2SoK1fsoeUKLQIRVyfuLqK3/WNdDdPCQnADk+Cm6wJtqVp7KwJEfDFVT
	LNPxkX8oaEeZE7un0IfDm9D1FA7fXXHjn9bOwoLHy9tlRaCWnaJFdL6xMAFbwLTy
	Incr/Yl51l3DBvLTbnQvw==
X-ME-Sender: <xms:uHmrac00NdjjecrzeIKHreZ_F7YgxwcVHYlxYY2tm7qxqvuXnKh8MA>
    <xme:uHmraR59oio-SumtdP7DlwE37qpq8q6pIPrwpq0Xb7_RZ4XKS-SGnArno3ZhJpSB4
    _fZ_VlIUFErBCOlKetfC1LF4oXrjOeS76WNRtp7oxEBu1V76rVDF-0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehlrghn
    uceurhgrihhthhifrghithgvfdcuoegrlhgrnhessghrrghithhhfigrihhtvgdruggvvh
    eqnecuggftrfgrthhtvghrnheptddutdeffeffkeejjeehtddtgeffhfekjefhgfdvjefg
    uddvleeijeehfedtkefgnecuffhomhgrihhnpehgihhthhhusgdrtghomhdptghorhhprd
    gtohhmpdhurhhlrddqhihouhdpthhhvghmohhsthhsphgvtghifhhitghurhhlmhgrthgt
    hhifihhnshdrhihouhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghlrghnsegsrhgrihhthhifrghithgvrdgu
    vghvpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthho
    pegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:uHmraRPfqMvtWhVOHuOwIQcvYnWoveq2FW44ArBxUxS0YkgN9dSTyw>
    <xmx:uHmraUp7hR0N6TS8yHriJ5U3BnE8qx6yaHeB8J0gLyArYyTu2GE3Lg>
    <xmx:uHmraefOhprHaSfWEm9RzmDAdryHxQ_ZYmEMAOSpV-0ndgu7e4Shtg>
    <xmx:uHmraSQCi0pDHPqdvXnoyCkNB8FHkoFXRAlwuWhjekTYzOT-4J-Z3Q>
    <xmx:uXmraY8eGe6aqPACuraa57nvSkckmTik0bSY8wkuIAMI_9iXuWpdZ8Lu>
Feedback-ID: i1a914699:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9E16B1EA006B; Fri,  6 Mar 2026 20:04:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AItb9aa6r_v7
Date: Fri, 06 Mar 2026 17:04:36 -0800
From: "Alan Braithwaite" <alan@braithwaite.dev>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt" <ps@pks.im>,
 christian.couder@gmail.com, me@ttaylorr.com, "Jeff King" <peff@peff.net>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Message-Id: <01215e9c-c110-4860-a285-7f09bc6596e5@app.fastmail.com>
In-Reply-To: <xmqqfr6cy53q.fsf@gitster.g>
References: <pull.2058.v3.git.1772780113400.gitgitgadget@gmail.com>
 <pull.2058.v4.git.1772833649843.gitgitgadget@gmail.com>
 <xmqqfr6cy53q.fsf@gitster.g>
Subject: Re: [PATCH v4] clone: add clone.<url>.defaultObjectFilter config
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for the careful review, Junio.  You're right on both
counts.  The stale commit message and the test style were
sloppy oversights that I should have caught before resubmitting.

I'll be more disciplined about reviewing the full diff
(including the commit message) against the actual behavior for
future patches.  Thanks for helping out on my first patch.

The updated incoming patch addresses both issues: the commit
message now accurately describes the bare and URL-qualified
forms, and all tests use the test_cmp pattern.  I'll be
submitting what I think should be the final version shortly,
but I'm happy to continue iterating if anything else looks
concerning.

Thanks,
- Alan

On Fri, Mar 6, 2026, at 14:18, Junio C Hamano wrote:
> "Alan Braithwaite via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Alan Braithwaite <alan@braithwaite.dev>
>>
>> Add a new configuration option that lets users specify a default
>> partial clone filter per URL pattern.  When cloning a repository
>> whose URL matches a configured pattern, git-clone automatically
>> applies the filter, equivalent to passing --filter on the command
>> line.
>>
>>     [clone "https://github.com/"]
>>         defaultObjectFilter =3D blob:limit=3D5m
>>
>>     [clone "https://internal.corp.com/large-project/"]
>>         defaultObjectFilter =3D blob:none
>>
>> URL matching uses the existing urlmatch_config_entry() infrastructure,
>> following the same rules as http.<url>.* =E2=80=94 you can match a do=
main,
>> a namespace path, or a specific project, and the most specific match
>> wins.
>>
>> The config only affects the initial clone.  Once the clone completes,
>> the filter is recorded in remote.<name>.partialCloneFilter, so
>> subsequent fetches inherit it automatically.  An explicit --filter
>> flag on the command line takes precedence.
>>
>> Only the URL-qualified form (clone.<url>.defaultObjectFilter) is
>> honored; a bare clone.defaultObjectFilter without a URL subsection
>> is ignored.
>
> Is this still valid?  It is inconsistent with the updated
> documentation where both clone.defaultObjectFilter and
> clone.<url>.defaultObjectFilter are listed.
>
> These iterations of patches may require a bit more careful
> proofreading before getting sent to the mailing list for others to
> comment on, I suspect?
>
>> Signed-off-by: Alan Braithwaite <alan@braithwaite.dev>
>> ---
>> ...
>> +`clone.defaultObjectFilter`::
>> +`clone.<url>.defaultObjectFilter`::
>> +	When set to a filter spec string (e.g., `blob:limit=3D1m`,
>> +	`blob:none`, `tree:0`), linkgit:git-clone[1] will automatically
>> +	use `--filter=3D<value>` to enable partial clone behavior.
>> +	Objects matching the filter are excluded from the initial
>> +	transfer and lazily fetched on demand (e.g., during checkout).
>> +	Subsequent fetches inherit the filter via the per-remote config
>> +	that is written during the clone.
>> ++
>> +The bare `clone.defaultObjectFilter` applies to all clones.  The
>> +URL-qualified form `clone.<url>.defaultObjectFilter` restricts the
>> +setting to clones whose URL matches `<url>`, following the same
>> +rules as `http.<url>.*` (see linkgit:git-config[1]).  The most
>> +specific URL match wins.  You can match a domain, a namespace, or a
>> +specific project:
>
>
> In the test script we see a handful of lines like these
>
>> +	test "$(git -C default-filter-blobnone config --local remote.origin=
.promisor)" =3D "true" &&
>> +	test "$(git -C default-filter-blobnone config --local remote.origin=
.partialclonefilter)" =3D "blob:none"
>
> added.  They may have been written to mimick an existing line in a
> test elsewhere, but see efforts by others like
>
>    =20
> https://lore.kernel.org/git/20260305225128.54283-1-francescopaparatto@=
gmail.com/
>
> Thanks.
