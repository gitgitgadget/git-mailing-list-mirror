Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA542E6CD5
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762799919; cv=none; b=hh8dhlAqlBbcYOFz0ovdn+qtkOfeHTEzyo7w4p0IKd+/OuJ4Zts9TmrzxdN9DeSN86erb0UjO9scWM1x7+hVUWKb44HqHCxmntTBJnzeJxXQBnM89bAqK8OKJIIk+1IdFml75CNBZrt8IWAZH0Hk6pzidHAUBRCn3G8kg9t0eWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762799919; c=relaxed/simple;
	bh=4JQcGhFTRk8zR7gQ/T7z3Elv2lOcrPLArMk+SVz+QrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lJ+cn5kU1WpzZ9uJBBV4hD9mw6gzziv4C9huelXS5XKigrb25oMW8PjCUvHQIY2BpAQHKyOiY0cKqJ4P2qDaUNtTRFtqdqkgZB6tpNwFhYY7oVYyHCujO4055LfVV+tXPSeg72IEert9EtbEYGYl3JQ8uM77p41x7Qmfuq8Cikc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Old+yB8t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hAXBPavH; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Old+yB8t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hAXBPavH"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CCE89140011C;
	Mon, 10 Nov 2025 13:38:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 10 Nov 2025 13:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762799916; x=1762886316; bh=gb4F2k+q6X
	zaicJw8YS4XP2SkFus7i5s8hBpO+AGN90=; b=Old+yB8tq5a9R8vuIeAWhPnoG9
	Aw/iPREEAIv9YpkgxiEUhUMd7blD4MLfwvx7wHLrPT3hV1y0L7B7s7JPm5SQItP5
	7dFQrBWfRS4LZfibirMfZeH+t3EHTf4p+OXiVZecwcRKjd2HGiDuEjKRcz4nv9Th
	E9Qzm1X8Ag4OHGSD8WTTDyqOkWxXEXSmmPEKmBsCJmj6xB9U36cxwnaIlJxI65AM
	G2KWQ9OArQZR8DV6HohwX27qPKTVl3DzSC3i7H2Y2rpQ+rWesPasUi8WKK9L9THa
	e/4VSQvM1GkmkQaLGMhZxzlu7E9iIxCTp67VScL0ee0teli+1IsETEf31ydQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762799916; x=1762886316; bh=gb4F2k+q6XzaicJw8YS4XP2SkFus7i5s8hB
	pO+AGN90=; b=hAXBPavH2lEX+mWVr3NKyRRRdUXxZmrx+ghcn/x60A1AzH7mpp7
	TeI38+lE3hUripmNl6M6ioBO5erGBmPqx2Di4eU3cv1eJlBpTnPQrOItGSkLnCBL
	EmnLOKMouow7vMrBS8wqNnkeTb4SwJ8RLfvu9Qq1NJXiaDiDRz6CC+rN9uHODNPg
	4zr7dTtZ+Be176VkbkGFsAOmZo6oDUz4CfBT/j+9Lg5knCe4GllHYe3PEWjN0MHa
	Ektd+OITsQUQ4l9cWhMwe49WiJwt/ZPRT7qWVULCLPSg4Yyd5c3xKf/AUvy9oHRH
	y7NQjrMDXfFgZesoZ+QWN8QmvnslIJC8RcQ==
X-ME-Sender: <xms:LDESaSRdPJcwZncFrlwnns-juOsmQ0ABoQ_HbHMKQwsOsXR_1E9Qbw>
    <xme:LDESaezAwBhWplC1LgsoEL0WxjxybN33CGJE7DLQjYPXc-fCIdo7iUi_RLU4Pes-n
    Mea3rCtr1pValmLLSNVrI4gFXbWvZEmDTVibBkTbn9yYvswRX73>
X-ME-Received: <xmr:LDESaU064KYHS9nHKH917MHR5-YtBgsISWfy79XqKerurljllK3XYiMtU3SXvlo2QjURsZp1vem8iLV3pZLwXjiEsnNYs0UUIn3B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeltdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:LDESac4O9t-c--0DRefh8_tnAHuz0x9mXR8sB6TQKGMEdNmTm4sj5Q>
    <xmx:LDESaXWXOmQ3UZWChyVwnrj2anDvrXdjA2IhTU65LChKSWbH3UfuWw>
    <xmx:LDESabDod7VkneuGrNkwpeQUnY8q72FU8KMOfiB1M7aWpeLfxkBt8Q>
    <xmx:LDESaW5GR6lzk3wAlFgYx5hTpCCby5ZULAYUzlOkb4m6LD0047lmKw>
    <xmx:LDESacViySGsCGXHb4SBYhcVK0znMXghD7koPXqMNnYaDLHxz6A_OQml>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 13:38:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 11/12] diff: highlight and error out on incomplete lines
In-Reply-To: <7aa91693-bece-4fa6-ab14-f914d6fd49bd@gmail.com> (Phillip Wood's
	message of "Mon, 10 Nov 2025 14:55:11 +0000")
References: <20251104020928.582199-1-gitster@pobox.com>
	<20251104020928.582199-12-gitster@pobox.com>
	<7aa91693-bece-4fa6-ab14-f914d6fd49bd@gmail.com>
Date: Mon, 10 Nov 2025 10:38:35 -0800
Message-ID: <xmqq8qgd20no.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 04/11/2025 02:09, Junio C Hamano wrote:
>> Teach "git diff" to highlight "\ No newline at end of file" message
>> as a whitespace error when incomplete-line whitespace error class is
>> in effect.  Thanks to the previous refactoring of complete rewrite
>> code path, we can do this at a single place.
>> 
>> Unlike whitespace errors in the payload where we need to annotate in
>> line, possibly using colors, the line that has whitespace problems,
>> we have a dedicated line already that can serve as the error
>> message, so paint it as a whitespace error message.
>
> This explains why we don't need to call emit_line_ws_markup() in this case

True.

Also, even if we were to call it on the previous, problematic line
without terminating newline, there is no good spot on that line to
paint red to grab attention to the reader, as we are trying to
highlight lack of something, not presence of unwanted things, like
trailing whitespaces ;-)

>> +test_expect_success "incomplete line in both pre- and post-image context" '
>> +	(echo foo && echo baz | tr -d "\012") >x &&
>
> 'printf "foo\nbaz"' might be clearer and save us forking "tr"

Perhaps.  I find it much harder to read and uglier, though.

>> +	git add x &&
>> +	(echo bar && echo baz | tr -d "\012") >x &&
>> +	git diff x &&
>> +	git -c core.whitespace=incomplete diff --check x &&
>> +	git diff -R x &&
>> +	git -c core.whitespace=incomplete diff -R --check x
>> +'
>> +
>> +test_expect_success "incomplete lines on both pre- and post-image" '
>> +	# The interpretation taken here is "since you are toucing
>
> s/toucing/touching/

Thanks.

>
>> +	# the line anyway, you would better fix the incomplete line
>> +	# while you are at it."  but this is debatable.
>
> I think it is a reasonable default.
>> +	echo foo | tr -d "\012" >x &&
>> +	git add x &&
>> +	echo bar | tr -d "\012" >x &&
>> +	git diff x &&
>> +	test_must_fail git -c core.whitespace=incomplete diff --check x &&
>
> Do we want to check the error message here?

Probably an overkill, but I could try.

> Looking at the tests below the coverage looks good for "diff --check" 
> and for diff.wsErrorHighlight
