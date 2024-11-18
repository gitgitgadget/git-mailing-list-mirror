Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC017483
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 00:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731889957; cv=none; b=ht44SMmM8JL/acuq3JMHMQWT2oky9IKThB+5VPk2ATcwvfkuGm3Vu4fWb2ACPbB2D4F+1MZAvc0wDOdH8jGLlLMyVjQqXFdu3ww2zPG5uBuTgHD+3UAR0wQZ4Fl+fwRXVgztdSTaQwFBwIB/peUrQ547gF+S2UOMiDo9cBki3Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731889957; c=relaxed/simple;
	bh=f1tA31WfXF5RedKmr6cAkZbpLV9Ou1NgqAaKSXTfEus=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bu3p2l7gcZOnUnoBv8SSGu6slRc3XkIBLxFb26kBXXDfHxoG7VIS24zwhYDvufLw4U9CdOauO70SsnEfgqPAAzRSFBLBTHs7yJ0x//2DesHgKOUrbyPskdPwCn5H1zaS5wiDd4ToikdWSok5fj36f5AuvaS1JQyl2z/+FZS/IIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pc2yCjmh; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pc2yCjmh"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9CE8525400CE;
	Sun, 17 Nov 2024 19:32:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 17 Nov 2024 19:32:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731889954; x=1731976354; bh=6MC9RUp21CkmqEDEQCoBwiYZ3UWh+rwC/Vh
	M2RyrAoY=; b=Pc2yCjmhiyb2+AJcrj825XciSJtY6hXOLoxVjt5D1AC+meSrnBn
	VXj4GmiZZfh2S/3tvEuUM8zAMDDe9CoXnX3izUQQv2FL8C3PUK6yXprmlL8rOtQi
	g8VKYJ8MZrAI4mhjalbjGDSaM5JTdlXIgqRfIgXCDLl57BxR6kmqfrEUcTAYTSFa
	IIaXmfqMw0bjCSMdOmyM2m+4uM4BH7xIBssoQyXSeGiyo4saG2t4SFd4vutwR0qh
	IZI7W7nGjzGffZ8HHvkaRvw4ABbEl17QbDJRnzABdb4bLrVVcq1oswzI3Jj+5Nbq
	Al9aMv1XcU2j6FtgMfqTkPA9hO+/phgp+Jg==
X-ME-Sender: <xms:Ios6Z58ugvOSPqi4q_ZTg9jU-6_Vthuil0esAkURCtDyJ2IpJFQeHg>
    <xme:Ios6Z9vP2sgaOfDMaWm4YqGWEpEh65TRxJc79Qun0NOHybzKHRcVpoe4yog7o4oVZ
    AuaH_kHGWJMKaaz1w>
X-ME-Received: <xmr:Ios6Z3CaLZvph9fquzb_eed3S3GzF245_KM50nJTMC-k6Qd8AjtkL4tPb_YiMX8tB18s0M80Z-2D4OsX6S8zqahz3xtzU2zCg0L3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefjeeiudduteffkeelheejgeehveehieefvddu
    ieejheektdffgffhgffggfduteenucffohhmrghinhepghhithhhuhgsrdgtohhmpdgtoh
    guvggpohhfpggtohhnughutghtrdhmugenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprh
    gtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhp
    rdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprggpsghughhhuhhnth
    gvrhesphhrohhtohhnrdhmvgdprhgtphhtthhopegthhhrihhsrdhtohhrvghksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Ios6Z9fNTs9sgKCHr3EiCiSgrnOyHEzQrjiOetmVcfGKrT4cVnQjEA>
    <xmx:Ios6Z-OS9IFED0E4o6Yu4t1U5kTQtGSa8UOJwxl_VwfbaMPRXFlFxw>
    <xmx:Ios6Z_kYRdUqlPzLuKvcdFl2A4mfThHNYBwEroqmrXVQy9BaHfYuGg>
    <xmx:Ios6Z4vpBElEiqioSi-_14SX9iV0kc2WYMGJuudInvXbVfXD0eMz_Q>
    <xmx:Ios6Z12H8701McHbDF2bgVqQM_kApE895CCHLq9Gzl7TT78mj5MgNpn->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Nov 2024 19:32:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: A bughunter <A_bughunter@proton.me>,  Chris Torek
 <chris.torek@gmail.com>,  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What is the diff between a --soft and a blank reset
In-Reply-To: <5f401732-9b3d-4c45-88a8-a9e3d9d14fd9@gmail.com> (Phillip Wood's
	message of "Sun, 17 Nov 2024 15:21:30 +0000")
References: <myxdTw4K7jcrlKX-HC0edNKB3mgkjGJPAejkxWTcab03uT9uROZlO28zjhmnogOvGCJkag5q_Zvbok0VUyVjlkw5Goz3Gwe3l636lCYnGic=@proton.me>
	<CAPx1GvfT1iNnpJ0Jv0vhdHrwD-pDOK81MnUW2-Fk_zcJkW9PUQ@mail.gmail.com>
	<82f3cj_ASv_HNkdAe-1doxp6Vii0saBTB2wYbcwCEC3vDJpiwXvN6a6Agw7qNhKsGpBD8EbDC2u4VipTDJNr19nYcVV4BqV4GgNG9ysr5y4=@proton.me>
	<5f401732-9b3d-4c45-88a8-a9e3d9d14fd9@gmail.com>
Date: Mon, 18 Nov 2024 09:32:32 +0900
Message-ID: <xmqqr079xty7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Messages on this list are expected to be constructive and respectful
> to others. I strongly recommend that you read the code of conduct [1]
> and urge you to remember to be constructive and give others the
> benefit of the doubt when posting here in the future.
> ...
>
> [1] https://github.com/git/git/blob/master/CODE_OF_CONDUCT.md
> ...
> Please remember that the person you are replying to is trying to help
> and has given up their time to do so. I think that rather than copy
> and pasting a manpage Chris has taken the time to write some bullet
> points to try and explain the different reset modes.
> ...
> Telling someone that they need to learn English or get off the mailing
> list is completely unacceptable.

Thanks, I have not much to add.

The code-of-conduct does make it acceptable to tell those who
deviate from acceptable behavior on the list to get off the list, by
the way.  I cannot yet say with 100% confidence if it is merely
misunderstanding due to language barrier, or somebody is trolling
others, deliberately, but perhaps we a few exchanges, we may know.

