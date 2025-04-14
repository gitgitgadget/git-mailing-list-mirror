Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABFB23D2BE
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637657; cv=none; b=lUTz73h8AUqNbj9GFzF3PR1ctm/fRKTmEKjtkDip4bkraPNIUjIjUn9u4bWCoLCxCLTx504DCn6pmbxegi8Xkfoo2DUKRbVG/c87pHAnHB6plTLO685A4HMQjLLQ9GsghYYjkSAvg8q2lxQDHKXBkH7kku8by3XwMPmW7AimNEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637657; c=relaxed/simple;
	bh=CGjFtqrcpJ9gsiX0HStcdM0CGnGYijd9cU4qUT0U3XM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UZj3gI2f6ni3V4UI77+4jj4n7fTRxBlSfM7Xo9hxki+yZbXxWuvuEvO94l19YdvFIEge8o4NqvqkJFo1kYxeKkQ4fOGBIRr9LeO502JxHVf/8U39QTj3LgcJJ+P4EyOSbZDUJHMJ5dE+WkEMuoJVssP9UQJpbmolRK25QhTVr0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MPeezRSq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xcjl6igI; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MPeezRSq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xcjl6igI"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9E5D925402C7;
	Mon, 14 Apr 2025 09:34:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 14 Apr 2025 09:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744637653; x=1744724053; bh=2mvfZM25ZL
	hB6QIVP55B21gG2Rjsa5Z4k2JDO9w45tM=; b=MPeezRSq3Y+uqEqA3J8WbD4m7l
	KsaSnSkawFPR5Q5GeGPU7ZULm1cjBTCQn4C6FzCT0b+PSWvHAt3/HhUF5pIA0uqH
	wCU2hlUua90oieGaCPFLs+JDbE1L3l5/zi89ejsDKyq8ycZd+MTs6E9kct3uHVb9
	5qrTXRla3QZu06WTHiMeMbDgcafapp6jiKcRI7CAFLblqGudYPGmbyZSHhox9WKG
	EnmZytfwqYmkXTeyMEdWoooPnkmw5jTuFsH008p0mq6DexYDIpxIadNBk+ug4RBX
	T7NdQEVp15NVBenpQeOWrnw/Psv8eW+hQQshD3nvbadQJG57yMoMlKEhDdCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744637653; x=1744724053; bh=2mvfZM25ZLhB6QIVP55B21gG2Rjsa5Z4k2J
	DO9w45tM=; b=xcjl6igIVmoCq0jEJUlnQpNxq6GdrsQsRInfRbNwpFRJJi9rlTB
	dgzTTAojsu9YuiWSV8HCfQad5ri+Gs6izOwJpx4WOcxob/2tfU/VZk14V/CAxrAr
	Fh+Ox308vw8Nqs/LfstMHgFNHpkVh+wNj+Bi0uB3UNKyxJR1HSZyg2POF+JBA1Sb
	8AIYZ6H7GaaR1mLMb/f8u/jl1F0po8Y+gglKOMLqTH4Da6pBjJg2LtozCfDdf3fX
	0u5JZe3s539cBRJDWSFYZc7sE3gy+iZZFK/il7D9QNcgiKz3qdKIb3hZNKdEzT6U
	w8fD1kZAB5aTdeuMGWNujszATgfo12EGDrw==
X-ME-Sender: <xms:1Q79Z1oOqfwRodtWt2KJsHBtF-Zxk1aaBA7XDWORg2xuCyUwLuDlag>
    <xme:1Q79Z3oUzgWL0PFCQg1H7Cq2JYGRYu2zolA8UbRCQlnEfvtPsl_c7RJwx8Ecxmr0d
    _pXwUAx8BtKqw0IjA>
X-ME-Received: <xmr:1Q79ZyOs_EJZw_66te5EOpmqQkIQh9GlrqFi3msEBoNc2uwZ85j2v4SQBykok3B_AGt7JNBhzv0-xxUjiH6IKuMZ86l7QPzexcde>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddtieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:1Q79Zw4pZNdCQF9QcFATvcbcmvq_WTLP4N11gKmbaFpkxK8cs8fMTg>
    <xmx:1Q79Z07Ts-uK0lJ8fB2bOFI-09SXvBp30mUDiB3aqDpfg_vZBNNURQ>
    <xmx:1Q79Z4ioN9xw6L_rz10cCyRRyPrlICGcFJDEEtR6qjA5nknyUeoNXg>
    <xmx:1Q79Z26DGoW9MaqKXnQ9YERpKtTje13WKo4mir_kvb2s90x-ZNL8-g>
    <xmx:1Q79Z3LJKEQU_DWnMG5h5omePr6D4qpavqzEL83BSXq1QQokXi5YeB1T>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 09:34:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2025, #03; Fri, 11)
In-Reply-To: <Z_zDposxyFf3xPZD@pks.im> (Patrick Steinhardt's message of "Mon,
	14 Apr 2025 10:13:26 +0200")
References: <xmqqmscml2zq.fsf@gitster.g> <Z_zDposxyFf3xPZD@pks.im>
Date: Mon, 14 Apr 2025 06:34:11 -0700
Message-ID: <xmqqcydesw8c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Apr 11, 2025 at 03:58:33PM -0700, Junio C Hamano wrote:
>> * ps/object-file-cleanup (2025-04-11) 10 commits
>>  - object-store: merge "object-store-ll.h" and "object-store.h"
>>  - object-store: remove global array of cached objects
>>  - object: split out functions relating to object store subsystem
>>  - object-file: split out functions relating to index subsystem
>>  - object-file: split up concerns of `HASH_*` flags
>>  - object-file: split out functions relating to object store subsystem
>>  - object-file: move `xmmap()` into "wrapper.c"
>>  - object-file: move `git_open_cloexec()` to "compat/open.c"
>>  - object-file: move `safe_create_leading_directories()` into "dir.c"
>>  - Merge branch 'ps/object-wo-the-repository' into ps/object-file-cleanup
>>  (this branch uses ps/object-wo-the-repository.)
>> 
>>  Code clean-up.
>> 
>>  Will merge to 'next'.
>>  source: <20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im>
>
> Let's wait a bit with this one. There's been a couple more review
> comments that I want to address before this is ready for next.

OK.

>> * rj/build-tweaks (2025-04-09) 13 commits
>>  - config.mak.uname: set CSPRNG_METHOD to getrandom on Linux
>>  - config.mak.uname: add arc4random to the cygwin build
>>  - config.mak.uname: add sysinfo() configuration for cygwin
>>  - builtin/gc.c: correct RAM calculation when using sysinfo
>>  - config.mak.uname: add clock_gettime() to the cygwin build
>>  - config.mak.uname: add HAVE_GETDELIM to the cygwin section
>>  - config.mak.uname: only set NO_REGEX on cygwin for v1.7
>>  - config.mak.uname: add a note about NO_STRLCPY for Linux
>>  - Makefile: remove NEEDS_LIBRT build variable
>>  - meson.build: set default help format to html on windows
>>  - meson.build: only set build variables for non-default values
>>  - Makefile: only set some BASIC_CFLAGS when RUNTIME_PREFIX is set
>>  - meson.build: remove -DCURL_DISABLE_TYPECHECK
>> 
>>  Various build tweaks, including CSPRNG selection on some platforms.
>> 
>>  Comments?
>>  source: <cover.1743859985.git.ramsay@ramsayjones.plus.com>
>
> I just reviewed this series. It looks mostly fine to me, but I do have
> one question regarding one of the Meson patches.

Thanks.
