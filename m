Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A757B2E3EB
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 23:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731973158; cv=none; b=oK7oEMc0hEQAw754MeI/cf5YJ8FtCJFwssdGrtXTUVsNUinLbepUqkhTZ5jMWRwY2LwixkZcuPwkeqOXRiLvgY1Adq0VbyKlgHRUsIf86RnaDbY80XY0dKEWA+69wUQqcReg309f13QpwYp5qF1OqqDHjB3rvb3f+bOzKmzahUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731973158; c=relaxed/simple;
	bh=EbGx1vBfQkqaUWR5g+ikKyxKDkNXKNM77M3g8nSNe2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KCx1Vyfz2fb8tiUyWg+6iNqBmQUOW4viScqwsNbnZSDcpVhTsdWXZ+wKfOxER5D24r3cpLMMBw24LVoFpVgG8xLkCwKMX5SI6Ncxe20/vnF4HuNS1b+olKhAo55vSlaT1KBYu98w9zr9wlS4fWdPWOHYIcgLFGV3XmDFn7fUlMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A2Dt150z; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A2Dt150z"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 892AA25401C8;
	Mon, 18 Nov 2024 18:39:15 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 18 Nov 2024 18:39:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731973155; x=1732059555; bh=Vm2p8oAzzaehCPwxED+XNfidnQnILYJmjDX
	H7+v1NAQ=; b=A2Dt150z6Gp0g9z1c3A81mhC4uK+2hf/9ZplBp6Hyzyb7k0u9Es
	P0EX4ejrmU2IM+zztzEIzeHXFMmlBdrY6Oz2jLy4TBIOaCQBUNX+tkPYZaV+mj0n
	cuOs3B5w40LONC9MU4Pmj2x6399woHFO1fEkTpUqP8/WYKtwseKS9qHhKSHWlWjO
	gXjfTu7b2A/lOlkO1NO+Lkdwxqt6Dc5Ziu/LQrO7Yojc5iyu6fUeo7CBq18YcljJ
	x4LKZD+7simW+pVDD516ttp8AMPIlZhgH2fq0YbB6nlrs8NIkYAaimm44K7kDx1+
	heK7oKAaFQgQeLkvPr6S2Gy5KCv9B2+CQIQ==
X-ME-Sender: <xms:ItA7Z0p4v95oWqHR9C5a-2Hp9APOt0T5bt0WbVOSEN-KMwPs9AsaKw>
    <xme:ItA7Z6rPxjW1wsWweDukn8twb_q3oNDniijDQkw70QSiGExsWUbQF4asxYyUaadk2
    8Tu-5cGdw2pX2gDjw>
X-ME-Received: <xmr:ItA7Z5N_UVisuxYQpjiJ871Io2oq7W2ZpC8yvYLkxeS1Fjg2AUVqlekhJO4kZtEv1COhTJz0GhgqtvJA0tpr5F8KPKX_8NhKfHq0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedugdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehsuhhnshhhihhn
    vgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:ItA7Z77PuC3HX1sps4OcEgoqQ73SRynAM2FvNFL-3S88qnYuZsxf2g>
    <xmx:ItA7Zz7swAW2FFPwfcBKdual5GfN2ov4rZkTxFTnMqgDDtBAagw3Zw>
    <xmx:ItA7Z7jmctUQ7bEl3PA0xyiUTlxsabIFTwpVkwritSBi1zuyVPogzg>
    <xmx:ItA7Z94dc9GyfFqd5E3H1HkMim6ucebShEKfd7-WeWzFdkaTD1SsJw>
    <xmx:I9A7Z3gX8OHhohyR1SdxvVtInd36yFhXt7U0XJZ2OxfP4SSNLEPpX4bO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 18:39:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,  git@vger.kernel.org,  Eli
 Schwartz <eschwartz@gentoo.org>,  Eric Sunshine <sunshine@sunshineco.com>,
  Phillip Wood <phillip.wood123@gmail.com>,  Taylor Blau <me@ttaylorr.com>,
  David Aguilar <davvid@gmail.com>,  Jeff King <peff@peff.net>,  Christian
 Couder <chriscool@tuxfamily.org>
Subject: Re: [-SPAM-] [PATCH RFC v7 00/22] Modernize the build system
In-Reply-To: <Zzs7gerRLH0WlM-j@pks.im> (Patrick Steinhardt's message of "Mon,
	18 Nov 2024 14:05:05 +0100")
References: <cover.1727881164.git.ps@pks.im>
	<20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
	<b9e0f631-b2a3-4c48-8745-a4b1e3f58ad0@ramsayjones.plus.com>
	<ZzsJRFQ2KaJCiOyG@pks.im> <xmqqfrnok8s9.fsf@gitster.g>
	<Zzs7gerRLH0WlM-j@pks.im>
Date: Tue, 19 Nov 2024 08:39:12 +0900
Message-ID: <xmqq7c90jen3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> But for the second group I'm sceptical whether these really should be
> configurable by the developer. Why would you care whether you use
> `uintmax_t` provided by the system or by Git as a compat macro? I don't
> see a strong reason to let the developer override this in a build system
> that knows to auto-detect the availability of such features.
>
> Now as said, there may be cases where it indeed is useful, but in
> general I don't think it is.

I think we are on the same page, then.  When you said "detect", my
primarily thought was "uintmax_t and the presense of OpenSSL are
both auto-detectable, but the latter is a choice---forcing folks to
fight again to support the choice is unnice", while auto-detection
of the former in my mind was a given (perhaps think of "make +
autoconf" in an ideal world as a baseline for comparison).

There may be cases where it may be handy to pretend that types and
library functions your system offers do _not_ exist, for various
purposes like test-building or performance tuning, but these
purposes are of lessor importance than exclusion by policy, I would
say.



