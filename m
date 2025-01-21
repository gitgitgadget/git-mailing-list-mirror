Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14071B808
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 20:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737491759; cv=none; b=BnAYufv1/yapvgLGtxpyM7oB35+K+8MooO61haeayYSgir+6hh26lp0iGShHtEBdENECzWF9jE93whZcso7GSvnN/8ETX6juYV5Gp1hWFUJqX2yWI9Uj36BICCTpkAcRU9mdLs9lE+n7b0CWXQ3fCiYhcRhw1xl+24N1kmF/lj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737491759; c=relaxed/simple;
	bh=rlMFAPeS6dRZBKdFw9u9r8t34sriCuE4vjwgl22DjSs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pa2HItfw6afszRdUHSWsibix4yorLcSpbbCfKLLj5WDU/HjPOCBx1wiD5Ce+ocRQefh8NckmF1FE6oimdRQ0Ifm4Aum1PeWilv8cntNAKWYYXceXPVy/ZAa0bZSUIdVUb44LvIgvcqR2+TgQGw01m5oHIIyPE0r39Kruxe4bfmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S2aUf5w4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FvN8tjxa; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S2aUf5w4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FvN8tjxa"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D417C25401EB;
	Tue, 21 Jan 2025 15:35:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 21 Jan 2025 15:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737491756; x=1737578156; bh=djVxZSqcJ8
	IpAxQelTFOm0kEIKfbkrHATdvMKAFf9As=; b=S2aUf5w4hIiZw8SUF9OZgPnKmo
	0d6CDTPCVbA4SRWDQQ6Tj3gZssIMRmim/ndEGN7rKtiyZ+gW5mrwqekKOhFTbWkk
	Sf9HmEjtyOBF9K/A3EXN2+fiaU1yHHC47WLwGhgDG3oCq4kvgBOFtGizXdj5K3Ln
	Gy7r0DgKcFxvPi1z3zvbpeE/GxQECU9HVOTu+FcfnaB6ltZPyVPdgN7MfRlQTZY9
	oTdl5HTJ+mXcDM+tkxpacuz/dm3uQKeS7UDg0hnh6amOM2uqJTIB2YV+frPMvpEi
	h6b0aTUiyXJDA0uHHWvEfmAoB5cABdg6gcaOIavjkWhjyI1ILAuhujQEd5Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737491756; x=1737578156; bh=djVxZSqcJ8IpAxQelTFOm0kEIKfbkrHATdv
	MKAFf9As=; b=FvN8tjxaJiL0QyQGk60E4Cgnv3DOHPN/JyiYnu256Ew+4mtPT6p
	/F2Ij1I7SNBHpc71/sZsmDpEDDnTgs96hvMIratsWLTdju5FoVGjI6snfRkmFGbO
	Gfq5fFCnyFRg75P1GfFOEUefX6pjG5SOY8lTS2oMxVlubqL3aSf2V/MC9cMaQCen
	9GOwGozv7e+vpTpiJo6VT0te55pz3XDVtW2GgjDTNDRqo/4+FW8HgFuw7NMOw9CI
	GBOZdighCg6tEY3QeuoZD/L9Ty+ndXBA+iN/1hyfF53YSD56i3dJlPcQ7qBSswyz
	H6T89AL9kM576i9AbkjUHpYbCfgnzgQ9MjA==
X-ME-Sender: <xms:LAWQZ_DdonBYAOiK54hHZPDkdWSRScZie4ixNy-3959GeUJnIJxOKQ>
    <xme:LAWQZ1g79EmXVxo_7ulg2_8E2TOruU3waJUEZc90ems3ScoRdkwelR2_6K4yk0zQG
    VxnBXQFllS3zs1wxg>
X-ME-Received: <xmr:LAWQZ6mszuYIBJThIoy1TbE_XxDDgbmIUmAgibA5sp1fWrDP5zfWtvohWdkxSIhpeNMvUTVW5m7kTYFLVCp8Qs5mJBd-FFy65UzW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejvddguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepkhgrrghrthhitgdrshhivhgrrhgrrghmsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LAWQZxzGzvOpFrnzxgMYjvzqBqsitSIZMz-wWlQxPTRZtDY29bSAdQ>
    <xmx:LAWQZ0RGG7vBKXibvu1hD_eLg3UCxquRQAlBCfiQS6Zjcfb33MFhhw>
    <xmx:LAWQZ0afVGtmb3d0vGPaxOl92cv4aG01vjUiKEpdISTibe-pYCVO1w>
    <xmx:LAWQZ1RGRrUD_DxzCsnqYaee8SgX-2hwTEAbarCZfsxrJQdphpRZAA>
    <xmx:LAWQZ5IcQhvMi_NazMQMLUJIru9A6uzA6lj5-kz-_4XysrFo0nWgzoQJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 15:35:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Christian Couder <christian.couder@gmail.com>,  Kaartic Sivaraam
 <kaartic.sivaraam@gmail.com>,  Git Mailing List <git@vger.kernel.org>
Subject: Re: Git in GSoC 2025
In-Reply-To: <Z44u7od-mDiKcKVZ@pks.im> (Patrick Steinhardt's message of "Mon,
	20 Jan 2025 12:09:34 +0100")
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
	<CAP8UFD3PkyaQBLYPryePk=e54VtsQwjbyvvTsKEBFJnns_jZyg@mail.gmail.com>
	<Z44u7od-mDiKcKVZ@pks.im>
Date: Tue, 21 Jan 2025 12:35:54 -0800
Message-ID: <xmqqr04vzyz9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I was wondering whether it might make sense to also move the list of
> microprojects into the Git project itself, e.g. as something like
> "Documentation/Projects.txt". This would make it easier for us to update
> the list of long-running projects whenever a new project is added and
> makes it easier for people to discover it.
>
> It would also help to document consensus in the Git project. The file
> would likely not always be 100% accurate, but it'd probably be more so
> compared to tracking it out of our tree.

I am OK with the general idea, with one condition.  Each item in the
list should have clear expiration date that makes it automatically
eligible to be dropped from there.  Another uncurated list of random
things is not what I want to add to and carry in my tree (the other
uncurated list of random things being the set of topic branches that
go stale without hitting 'next').

Thanks.


