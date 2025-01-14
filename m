Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358B054918
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736819404; cv=none; b=qx0UsVbi+59hqDCT4aqNDZNlIh3F6gPFi81c2WDeU1hHt4/kX+YgRR7p42D1ZQa8bOFg0SN3rjrpyWhPdfYWF7fV0Ug+rc1zd7CFLD/C0n3neW/70qGMkwf8JxHo9o/BBZ4DKCylg+lBEkKkOH1/3URkDT6JAi0CDgsI2qxEDdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736819404; c=relaxed/simple;
	bh=u3v3pay5+12bYsKBjd5INco2Sh4vQN9tnjCOHlnYwR4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kkZbbB5T9VbIuYHX1W6zhIsiYtnbQt7HtEK+1D5VE48Ag+szPigwNTdTHY7YnSlCDS6J615tDsWwwTwHvl/+MpHm6EPeT6URQ9jchW58vuHjg48GseYbzqUeLh0ZN6oDxWp5qXiAL6YctH+JnUw2rKOoiHFaj1/aPpyWFzjiQ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PlNE+vrz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wllXcNBP; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PlNE+vrz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wllXcNBP"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 35570254019E;
	Mon, 13 Jan 2025 20:50:01 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 13 Jan 2025 20:50:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736819401; x=1736905801; bh=FJK/y5g/qU
	rHBoCpOKqO4ht65ijAoSxnRyDr2Y0btZA=; b=PlNE+vrzQSW4jr4yz3aOonTcPn
	rkx35xv4fzULyiLLEmSfFoLOLaJM0pZCzfdwcasWIMNR8zzH+IbPOw1mPvDiMkgq
	sPm0JJMHWuP/e3kt7Cil71+Gc2CYlzvvac2Tbou2JYuNqOjxJKYV0M8YFRSvDoWg
	7fjqw5JHXrIUHeXobPcHErjv89OLHzT1Fddwz94+54dqBDBXDvAMeJAaekSLPcKB
	77SHlFuLnuqpzC9HGumjb5SpJZo/IetHL5wYpWafGFTmBMdfTPBn2MmqIykqZCKe
	ntMX+mGSMAzIi+0E09SJyyjn9hFmcgrHoIDlrPfGtYXWwtwx+3Uhj7wFrVGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736819401; x=1736905801; bh=FJK/y5g/qUrHBoCpOKqO4ht65ijAoSxnRyD
	r2Y0btZA=; b=wllXcNBPHaSR/X3T4jmzX+qNu0ryWlOyYQ/mU27KpNoI2zvaW2f
	votw1iOKii5XnZ6L9F5Z6bi25ahmt7tNYg9mIehCr9PAdTNNZXzlQWVnmfv0TP2f
	IwZeGpPSjw3hZ/PzxS7S4POcv4z2LIjnyEJhU30jqv/EoccspQbr37gYEWQ1uyuw
	ONCtHvyrjYdT8KlFTojf/ennQ6IDmRvGxC7HhIGPFCFzQhdZuwCBWXbFVsthCx3U
	nmSveHtw+cXwBH8G4N358NXkG94sFXprgwPvWXW7VR/E/R+oc6DHy+uB4BE1eL2l
	NaDiAxYP8b5JhTvG0KsqMpFVDzTJKIwPbIQ==
X-ME-Sender: <xms:yMKFZ9Am9es-crgzaelp5KnOpKuopAkvvfI9uR4pUqKxbIUX76HpbA>
    <xme:yMKFZ7iC9idnGTYZZ4k6_zAQA7WfBqn-K1G20wd1ZvVg0zs3AKdsSJ9CcGCr8eU4D
    qY19S_lJMFah0WFzw>
X-ME-Received: <xmr:yMKFZ4lQZ4Yv--TtzNSQlXxpcgmhA-LQeKbrnNpHuSOUcKN0bkfiGcb2f7eOEdfPu9fcVkElG_CFKLpCHiB7PfjYpjFgh2lXytZ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehhedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihsehrrg
    hmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehpshesphhkshdrihhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:yMKFZ3zMh10UPMVERH2XTv_WbCsXPazjdvzvUdnigUrxMsLfxLI8IQ>
    <xmx:yMKFZyQ9HRuT3PaH3FhM2X_1YQVS39m_osA7afCJk5Ef9DdjmqNftw>
    <xmx:yMKFZ6b8d-YKd0wPgLCX0FWY3pd2qvDqCdWbG81SZR5AzAEvoGpFwg>
    <xmx:yMKFZzRIuT3pKDs9kPNtydtskapkoYZ6cGUydd3Oex5vThvqcpKhMg>
    <xmx:ycKFZ4MpMBkUdFWsyXvj0XO9jwfDZpEFEIITZ-zetdztrtOkLY91xQ8Z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 20:50:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Patrick Steinhardt <ps@pks.im>,  GIT Mailing-list <git@vger.kernel.org>
Subject: Re: 'seen' branch identifies as v2.48.0
In-Reply-To: <6c5d0f90-79f0-4fba-8edb-f80d0665873b@ramsayjones.plus.com>
	(Ramsay Jones's message of "Tue, 14 Jan 2025 01:16:01 +0000")
References: <6c5d0f90-79f0-4fba-8edb-f80d0665873b@ramsayjones.plus.com>
Date: Mon, 13 Jan 2025 17:49:59 -0800
Message-ID: <xmqqr0566u60.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>   $ cat GIT-VERSION
>   v2.48.0
>   $ 

This came from semantic mismerge with Patrick's latest round of
build updates.  Usually I try to review very critically parts of a
series that can negatively affect those users who do *not* use a new
feature each topic tries to add or improve, and it means for this
topic, if it breaks builds that do not involve meson, it would
automatically qualify the topic to be ejected from the tree (side
note: if a breakage is for those who use meson, as long as it is not
as grave as running an equivalent of "sudo rm -fr /", I'll let it
through), but this time because there was no textual conflict, the
hardcoded GIT-VERSION unfortunately went through.

I however somehow thought that those who are building from a
repository should get "git describe" name instead of the hardcoded
fallback name in GIT-VERSION.  At least, it is my understanding that
is the intent of that series.  Or are you building from a tarball
extract?

> I normally like to find solutions before posting problems to the list, but
> unfortunately I don't have time to look into this at the moment. Sorry!
>
> Just a heads up.

I'd throw it back at Patrick, at least for tonight; the topic is
more or less hot off the press and it should not be surprising it it
needed immediate fix-up and reroll.

Thanks.
