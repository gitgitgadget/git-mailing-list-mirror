Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F31917993
	for <git@vger.kernel.org>; Sun,  2 Feb 2025 23:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738539191; cv=none; b=o2qDap/kashXcHZbbjWvyh0fqHRBs4x3YKeZsvA0VkYf1GKU2OCgtUX96PKaGAWslHDUWrjoReuIc8w0c3W0z/ADwVwFnDRxRjaISF2ezYVuKtluFvZ2unOBQow4emq9U/U1FZiM9dw/zUnIuQ65xazs+rrtPgkVJUsMkGL6Rqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738539191; c=relaxed/simple;
	bh=48rlALBzk9Drsla+gA3D+HwECLHbnu765+HgEkgyZN4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q3L34AUEU7xRp42IQdxX62QkAMXC47XlIl029NpcRkYTxdSBmtWtDOpTe8eiplRpQV7LOSQZWmkKFcwCFtVKA7bLp5saaqpZZq9pbcBN1Fvyn//4W5VWIMN6D34t/iI+v1+FNk0LYbuECqQC2fT7Yx6j/HW8xuM6rCPFH+CusGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DNz1jnG1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qWZ5oOFE; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DNz1jnG1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qWZ5oOFE"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 43B8611400EC;
	Sun,  2 Feb 2025 18:33:08 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Sun, 02 Feb 2025 18:33:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738539188; x=1738625588; bh=+J7sqkoTxN
	+lQQKaFvThj8dPwoEpkskIdR3PuFtaIIg=; b=DNz1jnG1JHK5jj4L1tFn7lIRb2
	MyxTs39tdvSP7nG0v8/gYKsViQZtxEJIyyfG2n/R/YyDQXidjEYIvmfTKrWEmWDn
	8UVVuhjcosmW04nU+S5XcQALcGTos5x7h3HltdWFSbBjWSLo5zyo5z2RNTZXIAK1
	p+e9Ijn9FDc7X6SglQbmIPx0yAzNarRqz9gesZTcEVXZWUdFGyt1oZzFvnr5Nsd2
	RiQbRwlTWAEicNvXl8cuIazBtIEBp5ljtNDnQ5UP+kFfdALAMYu5Q2Owqp3cci1b
	02EjZNfDT1uhLUcr9QZXQsBcxH/zrxYmlRqyx9dZ6NHtPQr3fJGAouYui2TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738539188; x=1738625588; bh=+J7sqkoTxN+lQQKaFvThj8dPwoEpkskIdR3
	PuFtaIIg=; b=qWZ5oOFEXSiA/IlEir8BYpcv1cmJ8PVks7W/xs04EI3zYLeeKYm
	/y9C8Cw2v5wYe/ro7IyLwwPh5/7w75IEzLAOLmKlGQSwtB3sPSpwaEMmWbwgOmSx
	hz4fJSCXZikRVdWkS8Qarm6en7CZE3KGXwz5p3eEygp4/sd12kqTj6tTPqCnvGh6
	99n9dXY8ghbNun7Zfb49/i7cYq0RZI4OJp7Hq/GXjojKn7+PKu5FaXScWnQ3zGPR
	MPqohYu9POHmPjaOHrA4fBqOGwMfWsY8PVB/tPKUQkLWwiuMoVBKY5mlWQ6lcSOS
	mzaFq35B1D1RK4ysJ166sQDJAtS3b29a4+A==
X-ME-Sender: <xms:swCgZ9G9ruSpbMWDeZJbv05DkwFBnrtPAHxVEqioAB2JDMnOPNb11w>
    <xme:swCgZyW0kt8iEgTnsmz5XrDHcMqZo1SjB2ZjzKeIQ9wmXI1bF6RTLqwFsRn6ya-mi
    gTl8CMS3i1hzUjxYg>
X-ME-Received: <xmr:swCgZ_JJzB7GX7Bt9dpU9f57mxx1bE65-Kcspmya4UqD4RRV6JcKqCPQMCQ9odRmC5YFdNdSUZ4EwNr6JKMUbg1nv7PCHKCDHthl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:swCgZzFUZvPlFQlgrQw0EgxpoyTS5HoGzXiuOXohQ2A5zdYsOsRWTA>
    <xmx:swCgZzWjpelMivg_HXMYsCjF4YruiAqwZkY-gqfeuEDk6e0X7zh-BQ>
    <xmx:swCgZ-O36jc_ZmgJ3e8GFLUO4_5n-gWIv8-Yg09jB7Ea8Q2TS4UTcw>
    <xmx:swCgZy3PB4IotuFVavdv2pXQWAaDzumJZpv9LTySSeR5y02GJd7oZg>
    <xmx:tACgZ5w2IdYnkJfOu5JHLt7RxoK_T0Ssnntxi7yv_kwGvJFR0GY_xzRp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Feb 2025 18:33:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Derrick Stolee <stolee@gmail.com>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #06; Wed, 22)
In-Reply-To: <20250131233452.GB3544301@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 31 Jan 2025 18:34:52 -0500")
References: <xmqqbjvyv510.fsf@gitster.g>
	<20250123003613.GA3900660@coredump.intra.peff.net>
	<xmqq5xm6uwip.fsf@gitster.g>
	<20250131233452.GB3544301@coredump.intra.peff.net>
Date: Sun, 02 Feb 2025 15:33:06 -0800
Message-ID: <xmqqwme73ost.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> Nice way to use extended context to show why the change makes sense.
>
> I've been tempted to support a:
>
>   Diff-options: -U10
>
> trailer, but that is probably overkill and full of annoying corner
> cases.

Do you mean to embed it in the commit log trailer and upon seeing
it, the log family of commands add it to their setup_revisions()
invocation, thusly affecting things like "format-patch" and "show"?

As a reminder for a patch submitter (i.e., communicated by you who
wrote the commit to future you who will run format-patch for
submission), something locally maintained might be sufficient,
e.g. refs/notes/diffopts that is not shared by default, but still,
this hint probably wants to be per-path (ideally per-hunk).

But I think it will make it annoying if you forced those who fetched
from you to use "-U10" when they do "git show", as the choice would
be strongly affected by personal preference.  And I certainly do not
want to see anything less benign than "-U10" silently forced upon me.

Thanks.
