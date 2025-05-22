Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5461329DB67
	for <git@vger.kernel.org>; Thu, 22 May 2025 19:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747940895; cv=none; b=De58P1eOYEQj/w12mMXRhUlE4ilD3F7HsFC9PCCSRTRJekxLA8HMD8VFkDhWe4uegi1y/mNPbMiDHqUMTswd+8uMaLCnpYBKlJQDARe4rXVAsmYj3mD9pMblvx+kJxFIBpVtSUFHEjDo8pp3NigZW94irrohRMIz9DBMcj/aptE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747940895; c=relaxed/simple;
	bh=U3pXRRCuXcghGaUjZVTx3tG1G7kiL87OhQuDSPOYOCA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ikVZoP/6qst5Omhb/9U4pdAMmB06w2oFfrMNIpJJ9l2d4hWuJjlEyJUCAZMZF769TZcjUQfwVtVJ4wLe4XBtvj1CcK2bQQsLeLWOcVpD+Cu7ynVTsPfao50aQgjI09qP63JvRNuaLBIcn+3HvTYGtztIgunAZkl77FniZrVLCak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WgXYoHB3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oNmqgfDt; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WgXYoHB3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oNmqgfDt"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4A44E2540116;
	Thu, 22 May 2025 15:08:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 22 May 2025 15:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747940892; x=1748027292; bh=nbkCV9xA7C
	UmfAzu9AwDkL4mC+Uk0goSTRlUfYxNfYs=; b=WgXYoHB3+v1ZvYv28nd/UjCBOU
	HIKR26Or2Uu1t9CJ1PE5egkZaBE++GE+N108LZ9oAIoG+0JOrDxJviTuIp2A6izP
	wLP5gXjJ5fidZN41PagSDMLyQp5IQ++nPaTLv02CBpGVvAjKkiMXBPeTefXMJVj9
	TlNbosJzuRo/aXqUuvTHVShXvxzOYXG6UX4dEaqI6w9LYZ+WRxuUCOHXP1KvslBt
	m6pNGR6vuxHhqtcMIC/Bq5eJIYe5wvrSx0tmgsXkgpjDf5C0A4btdIklkn3OJ2+i
	PfubfSn4aFm0dbcsGdBeT0EQGfZ8BPv6c3bGpXAdCsEHZ53yy0lGia8LrQ+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747940892; x=1748027292; bh=nbkCV9xA7CUmfAzu9AwDkL4mC+Uk0goSTRl
	UfYxNfYs=; b=oNmqgfDt/ZsBXtD6z/2g4QKXc8g+PZwr1G06sM3n8T8wNWks2XA
	tttxrldXGDo0BnpCfqaFRShnRTKgvy34Tdu2p3HHdibXFdOF2/IfXM0JXqoMD7MW
	D0P3KzMC9y1DREytS2vTjYrJid/alcenDcpiKtPd+FWCO3vxA33EVYBc7hBI+QYM
	Py5h1X56cEECzQfXUYGv9CFDeommYaRIm5dQWQqJbN5Q9963OcYnzTwtJN7gxG76
	mvIj6l9v8nD0IlFRzmF4uKQcqR5c3RBbtD+fWQce01ipr/MRkOJKJ49FXvRuAUZj
	csb4o2saR6jBJi37JcT5vqhgPupSAX64ogQ==
X-ME-Sender: <xms:G3YvaCj7c34up2y7JM5ik2H4gJfZUG-JFNp_5lHD3tGj-FJy46SB-A>
    <xme:G3YvaDD83Yt1vURkfR8NRbIYHMrjjEaYhFfFy8Bu5AqGEA82lFNuBotlu9Q-1iPNT
    dqaU_v1z1pNxABYmg>
X-ME-Received: <xmr:G3YvaKHYtxHNiHXtbY4_QG5f3rVEbiyRE4KFZTOWgT0KFrUDjSOVygrJ5414Mp5zEykOMfL-xRUDDM83MclFZZkVfPPFT6J6cbRqfYI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeijeehucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpfihoug
    guseifvggsrdgtohguvggruhhrohhrrgdrohhrghdprhgtphhtthhopegsvghnrdhknhho
    sghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehlvghvrhgrihhphhhilhhiphhpvg
    gslhgrihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:G3YvaLRON095iAm2c9WN07n5z0IHCafLTdpXf6aN5HVGxDasdmLoMA>
    <xmx:G3YvaPz-dU3VPl0WPxz_ZSmU7TRpFdoyFo5umnq4RL7nVEQ0qR-Bvw>
    <xmx:G3YvaJ6Vihejd5f3YKKSAjcQUMZ5Y1Auu9JxrEVnaO-qFEtsIwRLJw>
    <xmx:G3YvaMw5s-zNngnMhIWFAOH3YtcUw_OZfpBMHAB_pcGlCChKjDzlIQ>
    <xmx:HHYvaAopXS6m85KrT79weGcETRd9b7StB3Hj9eWt_VaxX517zZfvvowd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 May 2025 15:08:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org,  pwodd@web.codeaurora.org,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] Makefile: avoid constant rebuilds with compilation
 database
In-Reply-To: <aC90SzSUkhVvahvU@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 22 May 2025 19:00:27 +0000")
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
	<20250522185524.18398-1-sandals@crustytoothpaste.net>
	<aC90SzSUkhVvahvU@tapette.crustytoothpaste.net>
Date: Thu, 22 May 2025 12:08:10 -0700
Message-ID: <xmqqh61c5uqt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-05-22 at 18:55:18, brian m. carlson wrote:
>> Many contributors to software use a Language Server Protocol
>> implementation to allow their editor to learn structural information
>> about the code they write and provide additional features, such as
>> jumping to the declaration or definition of a function or type.  In C,
>> the usual implementation is clangd, which requires compiling with clang.
>
> Oops, my apologies.  My patch directory was unclean.  Junio already
> picked this up, I believe.

Don't fret--mistakes happen.  880146ae (Makefile: avoid constant
rebuilds with compilation database, 2025-05-09) is already in
'master' as of a few days ago.


