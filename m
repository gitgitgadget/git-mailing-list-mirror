Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E41B28D837
	for <git@vger.kernel.org>; Mon, 12 May 2025 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053733; cv=none; b=a9oCQhZA5Nwgf8Hw7z5Rp+fgLujfNyDmkUCY2/P4axIDLLQN75/WkgzBKJHXYa3c9i0xIxchmiSWS9elKOz7Z0WCjzRMxDaEM7Sm63nsMK7v4v6XQnA+zJou5ylMKLmjGuAWwr4HEIvV+yRiwAOGB9sGjPl5lAP8CdsNd3c0lU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053733; c=relaxed/simple;
	bh=1Ah8wB21CunzaMLcXcTFDhNQryp5u3MyXlrdybuATk0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j9kUmDmXFi0alu/UyUj/+uhOJ7vGW6KJWTjSjD8iCsbLNoaVN99BSN5PPicygwQIT7g1iF8tPVoD8fqAnwbfgYXuOBNrkJ/kt8t0piCzDJ4fTDdffDSv9UTtEn+W0USikFrApF7mfl7Zqz3C84K6TyIAri6ycgPwfkZoYEtXriA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F7XviWAS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XGl8kju/; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F7XviWAS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XGl8kju/"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 3887D1140108;
	Mon, 12 May 2025 08:42:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 12 May 2025 08:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747053730; x=1747140130; bh=yG9jGprwur
	zEEkxHu1P2LgR6/68ZI9zMFCceqpfPsiI=; b=F7XviWASZy4VKwbbXSOT0xIPcy
	0F3TKdSf60791tktq+tckkYsh1HQzlRd2ndykh/Z9dW9liAeuUQWwnvc1uTMvBzf
	1FMD7BLC/Mgj+wDhNwT1sqPNdAbvHqg2qKUXeNA7YyiM9G1+eVGnBLLwmzypI7an
	M5LyewU/QuR8j9q68jNq036yRT8IMxAVxqcjEEG5QhL0yfS8+NIxRncaiXxPRNkP
	n5vKIiOVDDUe9DLCZLN3ZQQVMIwpiYI+MKCbQqxylD4rJ1k1qwKDfxFLAcvkrfxd
	RH9W3F7C6eJ6HlaWF0ukUBhi20KgFRt+sOoaNUuyJf8qgobWTo7LhekjDDyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747053730; x=1747140130; bh=yG9jGprwurzEEkxHu1P2LgR6/68ZI9zMFCc
	eqpfPsiI=; b=XGl8kju/rTbLMgZ3w0ItzhWWG/6IZ80iQbTUWYD6ORsYoogp6e1
	C7Uohw9S1iqgXdCb+9QZM6qgzpV+JyGhKigZT+3y3kKCZZCBJV7tqI96Oky+pzuC
	91AsF7F/VQ7hbfEZEwIktyp742R6goN1ozwMmLVYnQKlOSVVgE7Gl26ovGF6oRp0
	MBNChR4owDHjdNQyw4JV6uO/UTxDX8r4yRpIYwZyTV6gUIS/5TnxXCAsBqKZnyPg
	qii6rhYKsXKDRcHv73/mN/pTc9psQr6KgTdoVdZ3V8Z+U8J0UK1muxJGjAlw1Bd0
	7rAjFn/dT+qhOnjKVQI4vMTlIPnd5JWY1rw==
X-ME-Sender: <xms:oewhaNtAUuZj9kkbux2V2EyLf_AZ1uvA0WbB9vHcSoGY45K4rjbnSw>
    <xme:oewhaGd7JPN_5uNLo5uXbEDuAKkMhRtsAkwhhoHMWEF5CZZMvqo3SiDVHBsEokDOp
    rDsGWV4AAUzXBBhIQ>
X-ME-Received: <xmr:oewhaAxtu1nhmL1ajfqcEmQJinc7QuUZb1_Ovk3FhDzUNv2DvS2cg09fTiK07Vr3sJN_pqMApZmhVgpByhwZBbVVkN1fioQQOKRXUkM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdduvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgr
    shhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:oewhaEOiucxFnPZMiCxtcWrwvd23IqoXgmytA4pXUHIwzA-gXKbl4g>
    <xmx:oewhaN8M2t6b4Z6gP-gwtCn73s-bXtjFf5yQKUs9Mm29bUn6xEGGIw>
    <xmx:oewhaEVx4oplVwjFW0vd4K0-XO06nzOn-UoRCm_j3nW8LQ5iwyDdfg>
    <xmx:oewhaOfJZ0gNcRHJK_mmxZwI_Y8DjhVpaK0oynqPJl2arirSpK1xtw>
    <xmx:ouwhaDJAWxllym1wEfVd7lEQspyCOdXhLdpYOHv8ljLfIi9jctmiqzqM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 08:42:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 4/4] builtin/stash: provide a way to import stashes
 from a ref
In-Reply-To: <20250510172107.GA601540@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 10 May 2025 13:21:07 -0400")
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
	<20250508234458.3665894-5-sandals@crustytoothpaste.net>
	<20250510172107.GA601540@coredump.intra.peff.net>
Date: Mon, 12 May 2025 05:42:08 -0700
Message-ID: <xmqq5xi6xaov.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, May 08, 2025 at 11:44:57PM +0000, brian m. carlson wrote:
>
>> +test_expect_success 'stash export and import round-trip stashes' '
>> [...]
>> +	git stash export --to-ref refs/heads/foo &&
>
> Here we export to a name in the refs/heads/ namespace...
>
>> +test_expect_success 'stash export can accept specified stashes' '
>> [...]
>> +	git stash export --to-ref bar stash@{1} stash@{0} &&
>
> ...but here we are writing to the top-level .git/bar. We do currently
> allow that, but there's been discussion of locking this down a bit
> further (requiring BAR or even BAR_HEAD at the top-level). Should this
> be refs/heads/bar?
>
>> +test_expect_success 'stash can import and export zero stashes' '
>> [...]
>> +	git stash export --to-ref baz &&
>
> Ditto here.
>
> I noticed because I have a patch series from last summer tightening
> these rules (it got derailed by some conflicting work, and I've been
> meaning to pick it back up). I can certainly adjust these tests as part
> of that series, but if you're re-rolling anyway, it might be nice to do
> it now.

True, and exported one is a sort-of-normal-looking isolated history,
so it does not have any strong reason to be at the top level.  But I
am curious what your plans are to deal with .git/refs/stash itself?

Thanks.
