Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E424A29
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 00:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733100520; cv=none; b=IdtR9RkPNJffiwE/6XCyCFocRV0J+SxuQ1F7aMe1SKaffFd3/IPhP05Gc0C25yBC0MumnjPstvu+82CV4OwvPIGMIqR8tfJ37k3yq+Rs8BFAEwcmTnFaMlRH8aLKA7JNZ59fizpOblqr73RR2/nJEE0M/QFw1D5uR+cT6dACW/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733100520; c=relaxed/simple;
	bh=qZF08DIwiJrFT6/5NYNO5l75MqR/EVyGa7PP+y18i0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q877qCjmT2iPUFikdqdZsk4tKP3dORFOL15R8/isRqb6oesHb/T9TNBm5cpGShMyReJ9fFOxsgLDrzM9setPfKC7wk+RUAt8kvLMrqTYq2A65lZs0aIR/NX3KZlF6YazF4JVgnEGekMJn+KlqG7b4PNwrXgumPWgGo9Kpu2TjOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=faQR16XK; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="faQR16XK"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3579825400E5;
	Sun,  1 Dec 2024 19:48:37 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sun, 01 Dec 2024 19:48:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733100517; x=1733186917; bh=d5xFf6LzWveWik6tN4UUTh2JVejBiE7g0ni
	Cg9s+Ucg=; b=faQR16XKQG054TjzqjApTfbnNGaMZBnvV/wKiLiqIBMOSM8m3dM
	Ge9AoAM0zGoLZM65BGeub9gDI8bIv5jFNjq3JE7UpLy5VNOF1ZW23d+obBlYlbC+
	t69Jj/gtUd9355pyG3J3Jc0POeVtD/+ch/yJJEVtZSX4xHV+UEgXjgbV30Vwzx9h
	qlQE7sK3UeqFb+Vr5M7Z2E9zHSxHbP/gc1YoSZ/FryC0mnVYvmj/TlWV/AMVZcmS
	OkJAQRFEno/d6B6xktTmht+cgTL25qmHQiZ2RTJPNszIpa7EWrbeY3DMeX5LnIag
	OIVGbZR30O7rjBFJr/RrvMI6LMKrg4LCuCw==
X-ME-Sender: <xms:5ANNZ5ydXNB4R0GXVw46O8Cm6F9KioWRMalzB6E43iORcsC3pbTg3A>
    <xme:5ANNZ5Rfz8il1mvOlLG7BntalbU8HLC5gjVJzVpZOe6e7E2XvEfsQ6V12P8qgWOIN
    pzT9NZ5RDskKZsWMQ>
X-ME-Received: <xmr:5ANNZzUC-zs60T0RgV1QCGejqbULxVTupqLGABKWhkGIHB-GbicvrkF8yD7PkQtNXPPe_xZnZRXcLcaGtToCDVHP4DMkBTWsoPE7IDM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheekgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeelffejfeejjedvheeuhfeifefgheeuuddvueej
    ledtlefgtedvhfegfefhffegfeenucffohhmrghinhepvggrrhhlihgvrhdrphhsnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5ANNZ7j6mlGtJIwue4rGbM0vXkmzohXjb0-eiTwWcqVfdvo6J6YDHA>
    <xmx:5ANNZ7DUIepPAyZz1juRABgQ0jTJcNHuBn3wk-1z_x9mOh3MqayGHA>
    <xmx:5ANNZ0JLpEhyrAb73GGdahDEOWCoi69j5e0Ghrfg0ygcFeq0uLVkjA>
    <xmx:5ANNZ6DoBpl1X6E693uxaMD6Wk6sK0ijXeAskCg763rhy82RXP-x8g>
    <xmx:5QNNZyMXHixuN5YDYEbcbdjZ9qLQibHAFqFVtLGZuWv6xFAdn-suiQeR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Dec 2024 19:48:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2024, #10; Thu, 28)
In-Reply-To: <Z0iWMKttvtpK6f6m@pks.im> (Patrick Steinhardt's message of "Thu,
	28 Nov 2024 17:11:28 +0100")
References: <xmqq8qt3q5t1.fsf@gitster.g> <Z0iWMKttvtpK6f6m@pks.im>
Date: Mon, 02 Dec 2024 09:48:35 +0900
Message-ID: <xmqqmshelxjw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> * ps/reftable-detach (2024-11-19) 8 commits
>> ...
>>  Needs review.
>>  source: <cover.1731943954.git.ps@pks.im>
>
> ... it depends on this series here. From my point of view it is ready,
> as well, and has gotten a favorable review by Karthik. So I wouldn't
> mind if we merged both series to `next` together.

Indeed this has seen careful reviews.  I should have updated the
status described here much earlier.

>> * ps/build (2024-11-26) 24 commits
>> ...
>>  Will merge to 'next'?
>>  source: <20241125-pks-meson-v9-0-1c6cf242a5f1@pks.im>
>
> I've got two small fixes pending, but other than I think the series is
> in a good enough shape for a first iteration. There's of coure a couple
> of follow-up steps that I plan to do, like wiring up CI, but I think
> it's fine to do these in a separate series.
>
> I'll send this version out in a bit. If you decide to merge, please
> note that the tip of the branch is only for compatibility with "seen"
> and should not be merged to "next".

Thanks.
