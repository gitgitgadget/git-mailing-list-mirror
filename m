Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ED8624
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 00:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733271519; cv=none; b=WBwZjDW85NLwbC2XwjgDiorxEkerQGHENLAdPgaAmyy3KQY6serjTS9Xq7RxzbEg+MPIrFAYc6PGMnL1RlcREKPM0GSHFr/JO74LvzF0b9p4wLOEI3e2flKQkGi2CgIvsJ86yynplAMvbFc1jjIdjQqWScFvMby1P+XZ8R3IWig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733271519; c=relaxed/simple;
	bh=7us4tWRzW//i7H46CZG3/szEXSJDBOjJqEvPZDS7XGM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dWtvrNYFl23zFQLENy5Wsqx/d8/1vgmdlq86nQFM08pbU/+Zao8Q3JN4Hm1tcmhqpJtIC74GQWWN0+w09X70+A8LGJm0W+3DVLdkhv4abfwFk5BtnFMeMChBMCIhapjwZAOyXkRcdsgv7p8N8KQbfo86kyZ8Y8hINrwAOago6OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CNEMoBwE; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CNEMoBwE"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1FBFE114020E;
	Tue,  3 Dec 2024 19:18:36 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 03 Dec 2024 19:18:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733271516; x=1733357916; bh=gU4zm0qFOVvz3lEWtBEIt3t/PdKRDRrbuSe
	rV8ko9XY=; b=CNEMoBwE3gBCGdBCVWPFr5xmB1v9PHZ56f9FLmo0MUmR6SEedWl
	olZkvYJnM7ISrLhWBwAkzE73PKwP+rE2KuubS3T4u2a6t+tn3cPkJIOKgHQTvZEH
	KhhWuMD66TkrCO1872E1LibiHbqkayOzdE6sYeJ1mk+6ZrEukHYv9AK1730q+8mY
	P/xKfKdzuEXoqf1quTazwZcaWyHjILEPciHtGE4vCajUFp23TZuRfWFxfDDvY8RE
	ADDn+9wMVfjZS9L9N+orS/frEO0+w2VIpbDzssOa+xlyG79RuRrdWVGHSE30aehl
	o7JO407kYZ7U4Nl+C/CCNwL4Av1355bVeNg==
X-ME-Sender: <xms:259PZ_pnOW5S8kOsrGALINnKi4ILKTtLYlgLyZgouaAueWPzzR1G4A>
    <xme:259PZ5r9SXCsOz417jD9gQw6yOrUqWLW9lLaaIjgRLcJBxNO5Zjuy76fJKAJWF6Df
    Nuvm4fy9YWYiDTugg>
X-ME-Received: <xmr:259PZ8OusZaUQpjy2kfInsG4n-gE4W8Zr8nPKfUtd6seBO0ARzfxj6B-wyBCMFaOz4mVSUnxSinRCFNMgulTSfc1rwCeXjMuLcw6YxY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeggddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohephiehtgeglhefsehprhhothhonhdrmhgvpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvth
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:259PZy4HUkeInchX0o2ZBIOPsvQUZfFM8kDqt77NaOSPu6pwU2RZgw>
    <xmx:259PZ-4mDM9DfgnO5JOYynU0s-usytqGJYxLJuTrq0nY14SbYKx98w>
    <xmx:259PZ6gDddsyczRX40ZNy1mWoJ3t_tD2Il6J_7l5kG2Q8zz68Dwhog>
    <xmx:259PZw4QmRNRdGhHYspdoopkiZrX0qIWVRbLHALO6d1VlldmXyUoBw>
    <xmx:3J9PZ7u_GPhQR_Va-x7IbRoxFJdosdr9rgvcsfijX4HaJyyBJ3snzedb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 19:18:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Philip Yung <y5c4l3@proton.me>,  Taylor Blau <me@ttaylorr.com>,  Y5 via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] diff: setup pager only before diff contents truly ready
In-Reply-To: <20241203212441.GA1424493@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 3 Dec 2024 16:24:41 -0500")
References: <pull.1817.git.git.1729370390416.gitgitgadget@gmail.com>
	<20241019211938.GA589728@coredump.intra.peff.net>
	<UZMh2lyzbLOgsf0PXfMnq6HnWVnCK3y36jY3IMKUykPi74ztNucf8bgywoeO0DdeApq31JDDGMZiEya99zAcI3l8y_zcVqiN8FpEnT1DRZU=@proton.me>
	<20241021190045.GB1219228@coredump.intra.peff.net>
	<ZxatqdBiB+NoMP+j@nand.local> <xmqq34jpl5sl.fsf@gitster.g>
	<20241125113105.GA1070162@coredump.intra.peff.net>
	<xmqqo71tcovl.fsf@gitster.g>
	<20241203212441.GA1424493@coredump.intra.peff.net>
Date: Wed, 04 Dec 2024 09:18:34 +0900
Message-ID: <xmqqa5dc712d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> I am not all that convinced that sprinkling setup_diff_pager() call
>> all over the place is a good idea from longer-term maintainability's
>> sake to begin with, by the way.  What problem are we really solving?
>> Folks who run "git diff --no-such-option" see "behaviour inconsistency"?
>> All I see is "error: invalid option: --invalid" followed by a help message,
>> which is quite expected.
>
> I think it is just about not starting the pager when there is no useful
> output produced. Depending on your pager config, it is a little nicer if
> we avoid it for a one-liner error. E.g., I do not use "-F", so "git diff
> foo bar" drops me into the pager with a single error line.

OOok...
