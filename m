Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B8E35976
	for <git@vger.kernel.org>; Fri, 23 May 2025 20:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748032980; cv=none; b=Tu6rWYM6mARCV7hZMhjac/xKXS5rhbivGIs0UDyku9lD6VKg3cPSG+zLx0GkXlw+UCLzRHy/45JJmQDETk2AGi16hxwRSLzDVrsca5cKh8G+9aDNKZg3R+BEfo/NTEmqHI4yBhevJZS8wRVZ6wSIZn5bxkmHPvngTXsv3xYLIe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748032980; c=relaxed/simple;
	bh=q1Zewqc0TutBjAVykidFLiiV1s7DuC0QA5bkIx9A7EM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tzGSayRAvz5II2GqgjqPgXlMGlA7a7Z/fDn+yyg3zrOfCRAt1tUipLitMEW3gwcuwRRprs/Vkl7hnnL5hu7HWkbdeRz6iW5e/LZHEiRYBJXgp5L5TNgCYCkumeSKH8+UKgRYpX1EnSHwK4RKaZcP4qVmF47JmF6Yt3Dc/Tm2jz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jzRGt0LG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gNj5sn5H; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jzRGt0LG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gNj5sn5H"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A179B11400CC;
	Fri, 23 May 2025 16:42:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 23 May 2025 16:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1748032976; x=1748119376; bh=UP8fTIm/A9
	RmLMrcxQ7uVoszK9+sESSBRPx0/wnmwoc=; b=jzRGt0LG3zXr9XK+e7WsnWSPVk
	cfOHpobmLCAVzFhoJWcc+B9rV9gWd7FhgJHO1ugM9qVThMZLyWdy0ZyAap95FBuA
	ThP3vj3fgtMdcebv0HycXrzqeK3g1SR5RAbEqeFDakHKRh1VCxxabq1vhVGXhnQv
	5edidxLuUf0rJuO8D+UlEpHU3BwsGS1n0No4e4lz8g+0vIo0ENPgdrwitEjbNUhL
	h1DmM8yKwN0cqM94fAKk75zsFB/jv5Tk9XSavnxmohhXzeQXxPI2BzlfqUrxpgw1
	Rfkd42bbemxjegszbLHJRX8McBmNyqlNtvBoRevFJrTlyCU2owfcSzXlW8Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1748032976; x=1748119376; bh=UP8fTIm/A9RmLMrcxQ7uVoszK9+sESSBRPx
	0/wnmwoc=; b=gNj5sn5H0GP/6GqJORpFCnvATFQJyD1KJ7QyV4bh7rnF9KnHj/t
	x2kzNhJ6lwtJLm7wW0HqmVwp401l392UBT9KXuiF2jL7xfL/UhD+POD0hrQzAhhq
	Mks1N701tQc2CN2BI4QLbKc1kLnxM9pl8DaFMQaxyPlJNi/IPqBuK1cda82cojBT
	1fmMyWFJFbXbDTBF8pPPI2xgs6fHgyjltglxM6RN0/Luy3ZlW1YB8diUmR3WW4JS
	1hHjGzd0uRoYz6aLY8Yn3/j64jFWsucQHlrjwVaiJGLNS7kQqTPO7XAhlCVLFQDf
	gk4EvNCBWNOQbpAYb2qRSW9tsx5D2r2iSHg==
X-ME-Sender: <xms:0N0waMyiSz6yJOQEAkwxpR3P5IQxBzs_y3z8QtltOkk2zSZXvb8iUA>
    <xme:0N0waAS1fb5aitJC_SABEDKlha8dp_K6sNOzlOAOaydgild2iN3y55qF8RpB7qYWr
    X3cJRjz-_l8WSmAjg>
X-ME-Received: <xmr:0N0waOUCOFsdMgI-Xp6a5fFtC__pxMEtRVQINLPClFv7dj7RKTqGYaQwEQGC-4rdCSXiYPYKF4_Q81PS0DIN_eFsZ3oWItvMOALvj_M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdelkeegucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghfkgff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeetleevffeg
    gfelveeujeeiiefgiefhveelgeefudelkeettedvleffudegffdtfeenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohep
    mhgrrhhksegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:0N0waKhlcq_UUpKpGHRF0LCEeeEylnIcmmragDKnu4GPxNWnYjqrhg>
    <xmx:0N0waOD8LR68GKRM53Cafqkzx5-rIaoGsFSFDZns4mWbCF9wpAXPgw>
    <xmx:0N0waLKHLArsLROsL2lTct3JgW5K8Ss5C9_pZFv3gNsT9uW_4Hl67w>
    <xmx:0N0waFBElT0d4k74qi1r2kgW5uIMMVIky977ZzWPwv6RqWFwSApsoA>
    <xmx:0N0waEP3Nvp83XUsbqECZgpFHZ2Cki2cT5_BCQRvIErccjbxRWVmhFi9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 16:42:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Mark Mentovai <mark@chromium.org>,  Git Development
 <git@vger.kernel.org>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] t7900: use pwd -P in macOS maintenance test
In-Reply-To: <CAPig+cRpS=t-wNLxdV_WoKF0Wzy-S1oLUEyS18S9r-4OBQ87VQ@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 23 May 2025 16:08:02 -0400")
References: <20250523193722.68344-1-mark@chromium.org>
	<CAPig+cRpS=t-wNLxdV_WoKF0Wzy-S1oLUEyS18S9r-4OBQ87VQ@mail.gmail.com>
Importance: high
Date: Fri, 23 May 2025 13:42:54 -0700
Message-ID: <xmqqsekvvz1t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

>> -       pfx=$(cd "$HOME" && pwd) &&
>> +       pfx=$(cd "$HOME" && pwd -P) &&
>
> Okay, this seems like the minimum fix[*], and -P is POSIX.
>
> However, have you tested this on Windows? I ask because, despite the
> test's name, this and most of the tests in this script, are actually
> run on all platforms, and because `pwd` is overridden by a shell
> function for MinGW on Windows:
>
>     # t/test-lib.sh
>     ...
>     # git sees Windows-style pwd
>     pwd () {
>         builtin pwd -W
>     }
>
> My quick testing suggests that this patch's change might be problematic:
>
>     # on Windows
>     $ pwd
>     /home/me
>     $ pwd -W
>     C:/msys64/home/me
>     $ pwd -P
>     /home/me
>     $ pwd -W -P
>     /home/me

Because pwd emulation we use on Windows ignores -P the updated
caller, pfx with this change would not change the existing
behaviour.

How would one test this situation on Windows, I wonder?  Create a
directory that is pointed at by a symbolic link, and use it as the
test directory (either have the checkout there, or use --root to
have the trash directory there)?

> FOOTNOTES
>
> [*]: In the long run, a better fix would probably be for the tests to
> sanitize the output of the Git command, replacing (via `sed`) the
> actual emitted path with some placeholder, such as "%HOME%" or
> something, and then have the tests look for (`grep` or whatnot)
> needles using that literal placeholder rather than trying to perfectly
> match the path emitted by Git. This approach makes sense since these
> tests are about overall functionality of git-maintenance, not about
> the specific path in which the person happens to be running the tests.

Another approach may be to do a form of chdir that forces the shell
to figure out where it really is upfront at the beginning of a test
script, perhaps inside test-lib.sh which happend before anything
meaningful happens in the test (i.e. "cd -P ." or something).
