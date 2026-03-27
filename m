Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E083845B3
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 20:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774644188; cv=none; b=UC0SH0lOsCkcDGG12mkN8XgjlP9xYfw2HJroA3SsimTNv7nryyzHFiftFglmmVI7WtgviHCqSw8wHeelhL6VLtYetIvakRzdI63zRFqkYa3ct1aODWRRbVHJRZn01agvklri2OF1eRgWuox1cBLO9WFNeuAu3eSiYSR0DjFmyTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774644188; c=relaxed/simple;
	bh=aemiwvLaPpNAbXg2ZY9G6KRsGqLIXcSqB/3HCQyQ/e8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sT5n49ojutv5N9ixQ79vpkXDU4Etap4bjQJccxqYq1d9iRPL7KiWR6SqgvRr5CinEfFABqbVGu3484Sqnlzb+h/1p4tSLtdXHgyFuCVToG/FRt69rlp5qdbXsWcLTEITWlotxBmH0uTTmZtokcw6M91PTJcw/HS1c7wREjtq/so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FiDfo1jN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kSMb1DWB; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FiDfo1jN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kSMb1DWB"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7CBAA7A012F;
	Fri, 27 Mar 2026 16:43:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 27 Mar 2026 16:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774644185; x=1774730585; bh=NaiDM1UO31
	uiVIVJZKLOW0qSO8hMhbZLmP9koZDiY88=; b=FiDfo1jNwb+F1TQLZrAn4CkTkx
	AQXOBrmdJVAPuv3Ls1/FWchZ6qfImmQ8AbZgOpxnZJjt4RzpNBPuglmwRb7MJIh1
	DAW6k/74NcUN9S4LsH21P8y5/Xz+U1m/VF9RLMpVc+qjQ+NMPV1apebqPT8IlK9C
	AsakfEc4RSai8SB8o3TygxWWtwJvpWRZu15fVza7NSACSzbjzqMIBHbcz86X07f4
	10ZwJCUYLxNacVK/cOZLPIu5FEX5iMfi2TUx8AjrM3tL7K6/WBxTWygrMJO61YWh
	1DM42JCW0mqj+F22XEWF05E63E9Kq+fkmcVF5c/6SD4rd0oSUx9ebTQpdDgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774644185; x=1774730585; bh=NaiDM1UO31uiVIVJZKLOW0qSO8hMhbZLmP9
	koZDiY88=; b=kSMb1DWBxlWAXa5rvEWjtAFilSEZwy8b8Q/hIXz/Mj9zKbl1u5t
	scSXm2rnQ7xnpNpCMjH9MtSxFX3PCTYuUZoV1eNrw+UQ5n2kNPRw3Odf9uvC/7xC
	Y3ErUXw+/0SJa5uytHL5O4Lb/lF7ZQtOK8hFuIb+2KArb9R90zFBgxpDX/4I+35j
	o6gV0u9BPmnPU8lO6z2/Llgjn67bsPDX/Idj04RitQFX565389SjEL70tmG8xsJs
	eoqjrJaIC+jObMemIP6UZi1On+Se3eVCSQ4eQngYAJ+s9+w9kCUSQDDkJzMZQLD6
	JUsfsvKtT1esCHsDlcL7PAmNCjwyX2P1YbA==
X-ME-Sender: <xms:2evGacSywjK_xerfpYWN_ct-MJJ-BRliFc9RgdX_NUbHLORQWQ0-hw>
    <xme:2evGacA5AE0OMxmXQTkk2XjYpdhr0kc4fKu3aOerQ5xSz8LZNR9ww9A5_zQ8OUS-9
    2xicdbXtyZSP3ft9SyQFX7yIgz08HE56gwbmKsbhuR56iuzyVARuw>
X-ME-Received: <xmr:2evGacHyPqX8PrykEpB1KRpMTKtvCj1Kjr09eY8yaSkqBjnhFjzdVyBNdgBQEgyFxzvS4-KwiR4KAHcuOQtruzVgsnYES2bVaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeduvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtph
    htthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:2evGaWAwgqAiQ5_3WQ_qlD5Grcl0ZgOJjHGzjEcTLO8GgTWk5OU1Ww>
    <xmx:2evGaUWtGW_BrIignMSQNBtEdhT1Q_LoOwGbrhx-FXeCHrZCPi3qYQ>
    <xmx:2evGaSokhEP8Wsxrg_umGYItWNbZ6XqO7DK1ag0QR9xnV9VRCgn1-w>
    <xmx:2evGaYR9U65IdaTJqHl0fi73gx-IV50siko_9BO11HtYR0R4mDESSQ>
    <xmx:2evGaUrYQhjbxxOETyD1TJyM7NNNk7w8owUYCYiJeLfCWit8C472SWNo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 16:43:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Elijah Newren <newren@gmail.com>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v3 0/5] pack-objects: handle excluded-but-open packs via
 `--stdin-packs=follow`
In-Reply-To: <af5babcd-34ad-4933-a4dc-8c9a9fd59bd2@gmail.com> (Derrick
	Stolee's message of "Fri, 27 Mar 2026 16:16:41 -0400")
References: <cover.1773959041.git.me@ttaylorr.com>
	<cover.1774641999.git.me@ttaylorr.com>
	<af5babcd-34ad-4933-a4dc-8c9a9fd59bd2@gmail.com>
Date: Fri, 27 Mar 2026 13:43:03 -0700
Message-ID: <xmqq341lj960.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 3/27/2026 4:06 PM, Taylor Blau wrote:
>> This is another small reroll of my series to fix an issue where MIDX
>> bitmaps fail to generate after a geometric repack in certain scenarios
>> where the set of MIDX'd objects is not closed under reachability.
>> 
>> The main changes since last time are:
>> 
>>  * Named enum stdin_pack_info_kind.
>> 
>>  * Refactored how we handle reading incoming packs via stdin.
>> 
>>  * Fixed a nasty case where sorting the packs in order of mtime happened
>>    to work on some systems, but ASan detected a very legitimate bug.
>> 
>> As usual, a range-diff is included below for convenience.
>
> Thanks. This version LGTM.
>
> -Stolee

Yeah, these look good to me too.  Thanks, both.
