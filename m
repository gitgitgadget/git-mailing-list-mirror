Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179791DDEA
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 01:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757281; cv=none; b=kh8y8rjbsjUZi1bbgdeg2oV8YcmfYMGGY2oKux1PyjseIbUj9bq6xAz+Pb8buIc/pX//+X64zH+CpMdMYfVMrbWyekGZknbGBRSMZpbgj+spkLtostg+tIoGJNEqKOAcAvjCMF0C4JPuiPPvCe4Rt46ZuIXsxozR8tRDMEutK68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757281; c=relaxed/simple;
	bh=OC8ViqEtxWnHPCRsea2m5gd5txLgZ4w3lzHHCCdyOXA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gssTiwILXAbvXocShftWk33DFk+2WrUY7phnnsGifr1k73vz0tZHGpAJ5oFmlcKB+REoUkeqpRSvu5ZC1onV/YlvStj7OSDu3d6LHWUoFsTz8hHEunJLNxS2HhDPYaife2p3VyBEQuzTeUu9I60xSnR4Vha5lfjhWEqLjgNxOcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u2dtAIgp; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u2dtAIgp"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 00CE825401BA;
	Wed, 27 Nov 2024 20:27:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 27 Nov 2024 20:27:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732757277; x=1732843677; bh=Aha7TvzdvCvgwGCv0nEktWX0MUCwZNV8Qyc
	kKKplcUM=; b=u2dtAIgpy8NfssahIIlmy4bbNFCPMhpCRRbCvbxs6axkIQseCaI
	kKGXsNPtKvQ4SUSbX+JWZW8uzeWZp+J1gI0HHy03ttKqJsnjvaOwhOqlXVOqlkIm
	m64//Y5FAAsbrVtdZLyVvF9UF5f3QV071HMp2D21kf5V0mQ0u6NPkE61Heafz9ef
	R06yRrUqOvVrWeXsuOqtDPGeeAidBiDts96HUto2G0ooXVCYDmsMF2E8HkWjfPor
	645Pes66OF+pJ9TSI83mD08v7juWea5gyOG6LneyTlmBh9dMte1qtjFIrLHWarvE
	odYhJ2clQvpia61YQL3bmfbKPcRXHaTJesw==
X-ME-Sender: <xms:HMdHZ4-pwEv_AspT1x_xqPxlLVFDcMb8OpJFtCwAsZZUEhG0wbMV9Q>
    <xme:HMdHZwvIKPPGdFASoZxpkgfv6dF4T356vCPc1x1zYKRXsosqSCPnxpxqgW5cUmEb3
    LF1MTRCmLzHvjWhNw>
X-ME-Received: <xmr:HMdHZ-BmmxeOOAhIKJmUBYr5l7KrV2O0-MVCZ3vlzZtI4QIcwHysOZa946HxGTHPRSzn-7TrSLEYyBInLm9cZGgpGEd-OndbWgHZjs8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedtgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeevteev
    veeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:HMdHZ4d5-wY3ZS7WRrRRRrviit8TNDWKXHVrAY72tylS5w_JOPtJ_w>
    <xmx:HMdHZ9PM-T5f4p6ZsOFaIo7dk7JtNmV4Ee2MwQOz9jAlC1lRZp6GyA>
    <xmx:HMdHZylkzIvLS3ZoU282ugK5RQdp5jzlCwOiSLABMxVq5jonipj2AA>
    <xmx:HMdHZ_sMbX5M7ANgykGsIaQcbtOQ1rv8ffa8BDCGCtfF3wi1_AmWKA>
    <xmx:HcdHZ5CQd92TFj5-6KfwZvrBQCRl4_FfVG1X0aYRaolVMWw3Tsi9hJY_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Nov 2024 20:27:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  me@ttaylorr.com,  shejialuo@gmail.com,  Christian
 Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 0/8] Change midx.c and midx-write.c to not use global
 variables
In-Reply-To: <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-0-c5a99f85009b@gmail.com>
	(Karthik Nayak's message of "Wed, 27 Nov 2024 17:28:25 +0100")
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
	<20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-0-c5a99f85009b@gmail.com>
Date: Thu, 28 Nov 2024 10:27:54 +0900
Message-ID: <xmqq5xo8qh9h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Changes in v3:
> - Split out the first commit into a separate series [1].
> - Improved some of the commit messages to be more descriptive.
> - Merged the 8th and 9th commits together, since they were similar.
> - v2: https://lore.kernel.org/r/20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com

Merging either v2 or v3 to 'master', together with their
prerequisite topics/patches, seems to result in identical trees,
which is fine if reviews on previous rounds did not find any bugs.

Will queue.  Thanks.

