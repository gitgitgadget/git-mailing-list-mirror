Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7B118C004
	for <git@vger.kernel.org>; Sat, 18 Jan 2025 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737220658; cv=none; b=k3TzuaLJ5nPNqHwMGMzCv+W0bzeB8p+TXV2Ptv2GwVQPNfzx/YdWh6ahOPr/bsex9lxvdeNivMxocd0ZHXttsuIAnqQAgVr7tDrEoKNYunPUK2i74pSN/BtyOh3RUcVr/rtSye5W1M4UK7uW0bpyRMkFQEDiVk9ZcLafF1O7Nig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737220658; c=relaxed/simple;
	bh=ZJmRFeLa/r8x1gRWyUkCwoB68j4Sgyl1jJyYiwXjQ6E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c8A/yAv6zzJvPjmttSf8egnF2X0+BDA0GkbnZLYa6dGPGpcpTxTK5MRHYzpc1JOnvAlBX7PWMJWKHAS/Lyt6UnwkR2vz+CqOENzKgs1yObfH2cK/lMEFzvoajsAVZCQqzwug5CrpRVJyAFvZ8TsexTOdSZE6GsyIAdX7Okdkryg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=5vDcE+4u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QJddunfv; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="5vDcE+4u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QJddunfv"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 865361140091;
	Sat, 18 Jan 2025 12:17:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sat, 18 Jan 2025 12:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737220654; x=1737307054; bh=rTGgowUa04
	wx7Rkmdosv7vbUHwJVS7MP0imGwrAJISw=; b=5vDcE+4uCl4qT4bvrx62tJ5SkE
	wdIDErt1gcU5OZRnzx2Wdk+z9qF5bqoD9+n/lTIF4iPg49b8ubQB8LN/+VIBaDc+
	At2TzOIDcSFkpjD6XoHuer1nT7jaS9sX6H7pzbfu2EkDwTo8mzN9qIl7RdtTLAQa
	924wICfG34le2rdn0UrggJPivG1YMsrIS8DsvV7HnwgovfNwuaSs5LTKmnGtUxIk
	ms0TAa5xWGaSpjc2xr5NqLu7Miokv3FT4VHDU9biylUgAclFQCN5fEjRkYTP38TF
	xs4iLbMsWv6Dnr26tvcWVE7PbwA1PtkTfEr8/Gt1Le3pPc5Z8GTBty9g6bKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737220654; x=1737307054; bh=rTGgowUa04wx7Rkmdosv7vbUHwJVS7MP0im
	GwrAJISw=; b=QJddunfvJGd0Ar1hrhBd7h/AgdOIRW+kFnrksGYQy0Y5Q0sGU1g
	CpHqfqUY+MqHtNFSHaxy7CNY6FfgpVbw2XYesgjFZvpfrr/X/wV1C0LBRfrY1YSR
	p+o+q9P1UyIl1U75BOPpVq+YspiiT84Us2igsrBa+V6yB6hZf3UBcHkSdfjBMZxp
	cW0gk9NDP4wP/dZAz+h7GVfMji0vHQPSz642fIaVslh0CdowUuwc9vEGwvw5/pqL
	RA+c+2GCDI4B3bVFeD1bXbl3zo0lwOWgLSs+EsFp3Sx0KYVSkU+c7eMwS8NpQnDw
	mCIIhtQh6wY2W+bsDOMOIdIYHqbYbF0zztg==
X-ME-Sender: <xms:LuKLZ9OlgOuqnajl23Pa1um_iICVYYyemzogO-RhP-6EWGICY7Nb0A>
    <xme:LuKLZ_9IPPs8DceYza5aetHLkvNMBDh4K5wktlrMk0jUZXjhS67joYSTlEV7f8Ecc
    VOZEIG5WV93XjHkRw>
X-ME-Received: <xmr:LuKLZ8SGtIYrRR9p9mW6u2Lw2BAY71i6vAu36NKVy0bLaD9Q7XHpfEJFyTkGtOKYGkyOj86qLdEb2ol7Hz2MBBpPGlm0ojM6qTCE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeihedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:LuKLZ5vlhAUoucKKvEQook4vqJV8KSB-U5xKJDou9Vt8W6vkDU7QTg>
    <xmx:LuKLZ1fJBhFATDmf9Py352j82SPy9faiXb_04SAzYK93Mh9vpB7Ypg>
    <xmx:LuKLZ12A4ucZIHTQ2rioFme_gB5guAtSjco7z7DkUCd1PNA7VD_0gQ>
    <xmx:LuKLZx_HHalIHW4HchHpACnP_5mvaw4-6cl01FHF2uMtPEfbjV86HQ>
    <xmx:LuKLZ560BchlRzUJbjGwbuc4wYi1jAQc7MqzlGtEkrhpKyNCCdXI-k3k>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Jan 2025 12:17:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #05; Fri, 17)
In-Reply-To: <20250118131507.GA387197@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 18 Jan 2025 08:15:07 -0500")
References: <xmqqwmetgdgm.fsf@gitster.g>
	<20250118131507.GA387197@coredump.intra.peff.net>
Date: Sat, 18 Jan 2025 09:17:32 -0800
Message-ID: <xmqq34hg3utv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Fri, Jan 17, 2025 at 04:42:01PM -0800, Junio C Hamano wrote:
>
>> * jk/pack-header-parse-alignment-fix (2025-01-17) 3 commits
>> ...
>>  Will merge to 'next'.
>>  source: <20250117125207.GB2356599@coredump.intra.peff.net>
>
> I was planning to re-roll this with your sparse fix included, and adding
> another patch to do get_be32() on the reading side. So maybe hold off
> for a moment.

Thanks.

> (I'd also be interested in any comments on the "maybe we should just
> align these buffers" approach; I'm undecided on it).

Unless we have the buffer _inside_ the helper function that may
perform the possibly-unaligned access, I am not sure how it helps.

I guess that we can align buffers used by two existing callers,
document that the helper function takes an aligned buffer and that
it is a fault of the caller if somebody passes an unaligned buffer,
but I am not sure if that is where we want to go.
