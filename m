Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1096E34CFC5
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768928734; cv=none; b=JgZ2h3wMmY+KXPLoHrGHn071YfHAegJ9APk+9V3k+8UASAubAKmUViERBL4Z2X4zfzPdqCyemNrpf9+lI9TBYPMWG9HLIVtSuj7yJDSKKh4eoveephCuiOPb0q4sQtQ0tqxFcv3OIyHFjhaHWa+gp1wM0C1dCjTzmQsgBse5isw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768928734; c=relaxed/simple;
	bh=Bl03wCLq9epEfS25IDJ6hb15IW3DRZwzEtNfNL6Hwuw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b1pIiH6xYlUSR4nZR3yAf3gZODQ0hxLO0wEEQ8Y7J+AxmmYnJwGYooVDhdTiyQS8B7oaQuFheBPUgfYp8IF9W0SYVv4CaFsyFGG3pb8A1fN0LdElIL49gOT6Fec0sGdy4JTcWuvgqB4DJkBR7henGAkjnQgsCAKVbGbnKJdnhVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=klRvpY0+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SDMFM74L; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="klRvpY0+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SDMFM74L"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C77CA1D00094;
	Tue, 20 Jan 2026 12:05:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 20 Jan 2026 12:05:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768928730; x=1769015130; bh=n7XDvak/n1
	3QpuJ4wEQ8jVCe3p8M16vS+K2pUG4UnRE=; b=klRvpY0+KdyRD0FiHH6oXO5NsU
	LDwnTaZ3hSFG7160uvTgCXOtTHr/uUKGO3jd4ajdBLXMDFDB31LoG8O1XMeSx6km
	5fhQg0Pl9Xx1Coe2Mt/IXDGSWAjF/xdazfWtOEwaR520zCBA18EWBio/S/E/zhkB
	Xdymz65LJSWjLKckCap7FVLzwriA6gLBwEROrIWq3pYb2icNI2HUCpRPd8TGZ2br
	kft1wvAjysLN1RSjyA3+x8qSYFrIgej5HQFDKIYTSbD6bemZJbV5QFzYtb4ANaxU
	3O940klZWOYXfWbXJbNE3arToCGaLBGxVsOkkJUmw03hL++DhRN1Y78aqNEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768928730; x=1769015130; bh=n7XDvak/n13QpuJ4wEQ8jVCe3p8M16vS+K2
	pUG4UnRE=; b=SDMFM74LJQjWoRI22/CWHt25Z0JVGDaCV5m5VvrAfAmutsgNQwc
	kfWdwL8e4xVXLfsLYYydErZWQoXyGMPnpZEYi3W+5TY73CVwBslXtCVmq1YYB2eH
	pOISfw1t6Lir1i0n4agWN1eVtYZUwE23A6Z4rSspvlGq3ckvJzzL/syyo+tDlBG5
	A1Ca7Iqh5OSAJ90GHRf9Ol3FoNxKZuYarjoGBALZJ3mIEDkO7ySBQUT3mEXWhHw2
	IKO4A78U6vsd3wTblc2BXlDUNKhcSHdtEXlkTOYX7vs4cqSZhj+WoL7pNOGtLVer
	bWvnTaRC4ZQQ8IQRdca95aULDx0fq2y4kMQ==
X-ME-Sender: <xms:2bVvae6y-urLLJdfT7p130wx-RHvduBR0bEWFY8Kh1LBhQ5v266esA>
    <xme:2bVvaUfqsxhhO9caHgP6aSmt8BbMnz9N1npRuHqy7xotNRioYN4DjcSwfwCOaUagm
    g9jyzqbE2HSUIKN2dqttXSONDhLZ67i0qmTKqg9OHEtOUvDyZbk1A>
X-ME-Received: <xmr:2bVvaR7DMChT7e9C4WboBRnj881TDEvXpdR2RYAzXUHONccIGtHsWQNMFf6zgjSBOKowraRXe6bmF0EHgY0PQR_-sK-VnXgdpk5dXxc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhph
    grshhtvgdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepohhp
    ohhhohhrvghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrsh
    gthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhn
    vghtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgthhifrg
    gssehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:2bVvaR8JLQBP2m5DKZwkoAapSi6epca42NJIOC5n1T6Y667bnguRJw>
    <xmx:2bVvaTGUEDCoqr6t5gvd8mxRNj1lpcN_jIMJzdd2BE8wUFDg02z5ug>
    <xmx:2bVvaWWWYVAuIG798klUXRc-L0Kx5-bw3YfdJ3s2FW1sQlxZGQ9Xcg>
    <xmx:2bVvaf8viLX0IluG972PwC3bS97P_Cuxf5utharnvgDJjdsrkSdFzw>
    <xmx:2rVvafmKNEEIYMSuRHPVqbs1iM4otoD0uTAN-icdHB_efZim54Dekzkf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 12:05:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Patrick Steinhardt <ps@pks.im>,  Ondrej Pohorelsky
 <opohorel@redhat.com>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Jeff King <peff@peff.net>,  Johannes Schindelin via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood123@gmail.com>,  Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2 4/4] sideband: add options to allow more control
 sequences to be passed through
In-Reply-To: <aW6tMtg0pEKq23TX@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Mon, 19 Jan 2026 22:16:18 +0000")
References: <fe109cd3319a5e3a1d1982a53963a601bb62b81f.1765981422.git.gitgitgadget@gmail.com>
	<aWD2x154F5f-c3pL@pks.im>
	<aWKLrIefrcSwReu2@fruit.crustytoothpaste.net>
	<20260115211448.GF1053259@coredump.intra.peff.net>
	<xmqqa4yeblsx.fsf@gitster.g>
	<c0af9072-cf21-a7e2-5b78-eb70217b462c@gmx.de>
	<aWnekt4ESo0bKpOT@pks.im>
	<CA+B51BEs7kuJ7s+K2vbZLSoaq3krGrqVncQAaTjSSNazFLY3tw@mail.gmail.com>
	<xmqq3445bn33.fsf@gitster.g> <aW3bSYCIPMhJT1mf@pks.im>
	<aW6tMtg0pEKq23TX@fruit.crustytoothpaste.net>
Date: Tue, 20 Jan 2026 09:05:27 -0800
Message-ID: <xmqqa4y81ag8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I'm not opposed to adding support for this as an opt-in feature for
> those people that want it, though, and I think that's the right path for
> including it.

Yup.  I am hoping that there are no folks who think that forcing
this filtering on everybody is so important that it must not go in
unless it is enabled by default.

I however wonder if we need two different levels defaults, depending
on where the user is going, to make it less painful to configure
things.  I would imagine the remotes one would interact with fall
into two quite different categories.

 - The ones that you talk with every day, essential in your work,
   would be something you would have to be able to trust and if
   these trusted people want to give you a bit more colorful output
   from their hooks, you shouldn't have to manually configure "I
   accept colors from them", for example.

 - There are others that you will visit for the first time as you
   try to discover new good things.  These you may want to be extra
   cautious about than the familiar remotes in your everyday work.

Perhaps "git clone $URL" should filter the terminal output by
default, but once inside the resulting repository, "git push" and
"git pull" from the established remote that is used by default when
you do not say whom to talk to, our default can be more lenient, or
something?





