Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011A88460
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733267184; cv=none; b=sV+WneZFcdlow/viWoY6aLpE9WkkIqspBohzB4ZBT65KZ3Zc+YOJ/50BaKCIQt93rZ1yOOyAHW8zyl9UX3XRMHBz7rt/Xl3GWWhiCpbxe7wfZfyguUysq2ZjvF5CnIcEOBmkaHOEbPt7pVnw4LpVR8f9w6Ameg9iFxQhNM16ZOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733267184; c=relaxed/simple;
	bh=AMzJB2scshSuIQNIcAjfcYj1/dZ4wB6OgmF1ZSRm43c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SRsQio7/9ImOrLrH74S1X97ZFfGZBdthM4zcAuyMy27brUluYkkdmRrDVPMdXXwX4ZjSzrAvcS+sb1FDwOQ+7jDdRn7/thlEajr4Ck6WSCgRj2z6yu5EJ2kLSErdldQ6HBHlQ+4g90snn2GS2IooT3kU0CIKdtLyGd6tSRk+x4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U+uNM8CU; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U+uNM8CU"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E33E81140083;
	Tue,  3 Dec 2024 18:06:20 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 03 Dec 2024 18:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733267180; x=1733353580; bh=HAFr2KKCQtVbLcdGZsAapLsBPxSFAnoRDMP
	wPp0fg38=; b=U+uNM8CUT2DteG3Gxz+vGUqy1ZKy8GiQl24AYyRh93X8ax3PpXX
	nLnWZPk4Tixs9EdT1r9FiAWfe3UrKaFEGsB9XZq/7qSwCTcgVhIwMbIn21A1wJj0
	bd8mn9apQxZkSr0f94DiCuls701cTG56JZM88Li+CVJMdE2cZTBTRXKCPxSh+De/
	b2DtOH6pP0k6fAQNlcVBtnce1CNxSrCLYxkeuXkbw5UAeQJhlVPSYNaqsphmrJhL
	suZQHdVu1CoCZo3A3uuL4OeOUjNexWfVGNKS7WIMW4Nztlvc9zKx0wmZaxonAGtN
	FL9I89Ej7Mv/qg1HwHHoNTwPWIDHaZdA+aQ==
X-ME-Sender: <xms:7I5PZ7ajtj1fwB0SdjSzHKzmlcUxrQT1rV5dnSS13NBZj9qdNIFUEA>
    <xme:7I5PZ6ZUl2V0QxXGY7SYD4tV464JQBiigbY6Tx3qEZNApBIBdr3wb2W8KsSjigNlX
    ttNLobJNTdMRvG8mQ>
X-ME-Received: <xmr:7I5PZ9-G5CtPS5Ga1M4u519GXW_1WRszumgFXQ_-YZs7hw9oHiGPLOxSfWX3nHccEVtVaFcVJdGva9Njos8SBlMV0U-u9_stxqoEFbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeggddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhm
    pdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7I5PZxoz8f2GeKRaLDHaXzehC8mqmybumNoHdfMQfx-VQZsYkeJkyA>
    <xmx:7I5PZ2ri17eGFlPX9U5w-v9wuz3O5tGfMRAP-ZNi9mJNU5vk41gy8A>
    <xmx:7I5PZ3Q_9WJyhFLD3S-AMcub7WMi95OZdPpmvMiDeQLsaasqT4YDJQ>
    <xmx:7I5PZ-rN-wKDlcqo0dKOfUBHeMpVBzNfTg_S0x55pvUAjsHslfDA_g>
    <xmx:7I5PZ2JUt4f-Gh6cq7P-65opnyFpPsWN6JAGMEF9832xH_SItRUpnBum>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 18:06:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  me@ttaylorr.com,  shejialuo@gmail.com,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 0/8] Change midx.c and midx-write.c to not use global
 variables
In-Reply-To: <Z07SsWL6sExkYUdi@pks.im> (Patrick Steinhardt's message of "Tue,
	3 Dec 2024 10:43:13 +0100")
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
	<20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-0-c5a99f85009b@gmail.com>
	<xmqq5xo8qh9h.fsf@gitster.g> <Z07SsWL6sExkYUdi@pks.im>
Date: Wed, 04 Dec 2024 08:06:18 +0900
Message-ID: <xmqq7c8gbc45.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I've had another read through the series and couldn't find any issues
> with it. I also scanned through v2 to see whether there was any feedback
> on code, but it seems like the only complaints there were about commit
> messages. So I guess it is expected that the trees are identical.
>
> So this looks good to me overall, thanks!

Let's merge it down to 'next', then.  Thanks, all.
