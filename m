Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDC11F4706
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 22:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741903763; cv=none; b=c9Jcwd11llBZpcd48G3beiF03K+RZ+v6gQVrJtB0tlcXMvCOqEhNJwAV8kJ9KaFjNzS1n/DcobIpevmtzdZsQVtdKTQbE8Rh010TjDnlxQxvvKUzdcalyPGtaa+ujpVuj5YJ8Cvw2l03AvBs9YxlN3HQaWP7IYRT7ACOSdEiGlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741903763; c=relaxed/simple;
	bh=rVqKgTMVOj5VWLD06gHpyJyQDysURdHQFDJ7tFEI/BE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=et1vZv1YQ1MrH/pOWf1Ex2M9h0w1qKsWSUURB8ohZP4Kdxq/FFmyErg2zSNx1PSlPf84ExfLkgHZupzGx6gZBrdBRrbnMsGPJbifEKT1y6FAcUdDyl/bFRci/knDdH9jp8oMzx8T6VhfM2U7l0hLb3mN6eNlwlaUAKtIGlxHLkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Yr4db8k4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LxmHlgcO; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yr4db8k4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LxmHlgcO"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 66EFE11401D0;
	Thu, 13 Mar 2025 18:09:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 13 Mar 2025 18:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741903760; x=1741990160; bh=Pf8Et+0Bwp
	ncnmjoL680Qt8GQKlq1i086kDVbSd+ziw=; b=Yr4db8k4IddANTI1R/KTpC39K7
	MHoQNWGzkg1VznDfzFZrmdl+0YCuDSqSFcQATDS3yAltOAw7orbLJTipFEnXzAf9
	zVx07VGC8ly3QOL9wQWdDKO6Vukjq78tr1X2oJasd0Z7QIThTPg3xknEOS3Kqjbi
	fbhM9Ca+46ImXdBfmBA1Cd7O7JpCJbX4QLXLZlUtzX5kVa2ZFiuLDTxqo8k0eMB5
	N6hfOnw4uhHhI4UqfYaeUlEUvlDacPC6B3GqTq8SJaUm4FLj010ntJdLQ5ncG1o0
	Wxo/m3uo03WgyVSgeGhuCA31wzhDQRDL+GIodKEnlkfRcIh08VZFteVWZ43A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741903760; x=1741990160; bh=Pf8Et+0BwpncnmjoL680Qt8GQKlq1i086kD
	VbSd+ziw=; b=LxmHlgcONubIaZ+eSoog4TA1Yfm+Zlt9xSk3RjKTF3CYK4mW4j5
	hh9kREf6atBr38pPmtO/iTD4lji3n0HN/SUsl5vH5hFBfB2sDI5JrZJj24Y/LyGN
	8DZkqAOBEfriZfj5SI8AmthUzi3ORNCE/i+cWWMqKeR+q2HEcfuE7YoPEcWHEJA1
	3tXSER01YBI//9SoaeOoUUf7NvOLAxDw27lWE6tntFU9lWenWq4InDS5uN6QyeFd
	1TS0ThC2Zh0V/0WdYxIM6HfJSj6GqYOSiqofgZJDDPL8gO5pFhgjjjC7TcKmpL5b
	PL4uY+kBirzVFCRF0CRvnw/TOixOpi1Af+Q==
X-ME-Sender: <xms:j1fTZ1oUlKxeIuDoCkE-RzvtLxokpXJxGrmMOsbZZV0HCKSUvf8y1w>
    <xme:j1fTZ3qiQ5xQPK_WIqaglA31Qb_3AHyKkn72KpMjOOgo2U4d4XaDnhExoY0i7oruA
    b-YNeyLH0dpXaxFRw>
X-ME-Received: <xmr:j1fTZyMintjMGjihg9V0NnX0MAVmvhXZbzlq6VnSwX_Zx-zBmnx2DmG-xfF6cGlwkXBdk_YS8fCTbOQO3gwUxvOo8OFKKpyXS9tdYME>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdeluddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhpvggtthhrrg
    hlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehsihhmohhnsehjohhsvghfshhsohhn
    rdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:j1fTZw5nJ2WPfUMk1sCeq71FuneLEKgRn5VGLHi66dAFTDjMqLgLgQ>
    <xmx:j1fTZ045idl3zpKiBPYf6CkTAX4sBXkWfppfCbTcy71vK_E4nNypUg>
    <xmx:j1fTZ4gWuOGqGGtB_h6WwaP_PAWNLhyW2D_n4S2wC766MbCfLpeDVg>
    <xmx:j1fTZ25Znact6-75oKDZjO-y5Plp5TXroStfCzxt86ZRfSCuWVGRLw>
    <xmx:kFfTZ-SK7fSjW7aspdpZpu47aCnYGG-5bw7gQY5jKIfy6KOOR7QcDrOH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 18:09:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>
Cc: Simon Josefsson <simon@josefsson.org>,  Jeff King <peff@peff.net>,
  git@vger.kernel.org
Subject: Re: Making bit-by-bit reproducible Git Bundles?
In-Reply-To: <CAO_smVgSRaYqNrA4c1yeu-cpj+P36MY+bsQT=8K0SXpWHkaWCQ@mail.gmail.com>
	(Kyle Lippincott's message of "Thu, 13 Mar 2025 14:07:16 -0700")
References: <871pv2jx4a.fsf@josefsson.org>
	<20250313051538.GA94015@coredump.intra.peff.net>
	<87msdo1yal.fsf@josefsson.org>
	<CAO_smVgSRaYqNrA4c1yeu-cpj+P36MY+bsQT=8K0SXpWHkaWCQ@mail.gmail.com>
Date: Thu, 13 Mar 2025 15:09:17 -0700
Message-ID: <xmqq5xkcmvle.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kyle Lippincott <spectral@google.com> writes:

>> > But that implies you trust Git's object hash algorithm.
>>
>> Right -- I think anything but bit-by-bit identical files is going to be
>> too complex to verify.
>
> I'm curious what specific attacks you're trying to catch here. Because
> to get into a situation where you unbundle the bundle and have the
> same commit hash but different contents, you would need to have a
> collision in the SHA-1 hash for some object (or SHA-256 hash if the
> repo is using that). If you're also providing the instructions (or
> even just the commit hash and server to clone from, and linking to
> instructions maintained elsewhere) to validate the bundle is
> legitimate, it seems MUCH easier to just replace those validation
> instructions to point to a commit/server that has already been
> backdoored than it would be to generate a SHA-1 collision that would
> go undetected.

I think there are two levels of "verify" involved in this discussion.

There are those who want to trust bundles and and place enough trust
on whoever created that bundle.  They are happy as long as the
bitstream they received the first time does not change when they ask
for it for the second time, because they at least know that the same
input would result in the same output.  To them, "attack" is what
changes the bitstream while they are looking the other way.  They do
not like the fact that there can be more than one representations of
the same thing for this reason.

Then there are those who know Git enough to know that they do not
need to trust the middleman who create bundle files, and they do not
need to trust exact bitstream that is contained within these bundle
files.  They can extract the bundle to verify the tip commits of the
history (by comparing their object names with published hashes, by
verifying the embedded signatures, etc.), which is what ensures
integrity in Merkle tree based systems like history stored in Git.

The latter folks may worry about the "attacks" you mention here, but
the former may not necessarily do so.
