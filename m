Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A1117C98
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 00:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731891311; cv=none; b=AlkyrTxD4GBOndWqsXopSSt93HTrrZ3dJtwp/I1VZJICVhQRBDPhBa25dY0bdNO15WhDHExiNE0QefNHaCTcF4dQlL3ZQtq39llQhLUR4H0/49krVc6wQ4zY3wTBb893BFXxN5dTpIsYkuRMiKkDuIgQkQJ1ags4VfqmPiHXwiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731891311; c=relaxed/simple;
	bh=9qdhKNvysX2/ZYddOl4GMgzlK/Ob/8K7pMKPq6UgbYI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PzpAOQJ46Opycloo1pLWxfslSMGTsYHdCzOfhOw9Jd/oJ5ospshV02Zr2EN+eBBs+Wiw+LJycP0vtbfU2cI8u7BGSBHoOhonyC+jr79pj4pKUmhPv6jyNMHgma2KXjk2SOi852tHFDkdvyrjE05GwIFfOiZoFYgwQfrNlwyVI2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lISdAOfM; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lISdAOfM"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5AF5025400D2;
	Sun, 17 Nov 2024 19:55:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Sun, 17 Nov 2024 19:55:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731891308; x=1731977708; bh=9qdhKNvysX2/ZYddOl4GMgzlK/Ob/8K7pMK
	Pq6UgbYI=; b=lISdAOfMCVjAJtdWVqHC5vJVBrC0mkR9OiryzW+KBSSM+BLja2w
	9VLrW3IGg+mKmQYEYUN8ykjTOMZ8p+1oROQC3sHcBxTws+ITCLX3C1XLsX44XPkE
	rpYkS19L+UT/Z4yBdxDPfaCazsOKASoQLR4Jw1aC+o3p3qnOjDSmEjJjyTGLVjWf
	qBigQdC2BBzgVRaa2rs9Qem36wEDYRefNNS7k4KTCBS6arqGhxpldrq8e/aWromU
	XiMnLH244TTYmxVc+dKxc4N3NhdAp8d1xUBXdrWer2rANumyugrdCJhafPlvKH4E
	ceA/zUnhKErsmrr5ax71LD1Gu18Z5+/DGMw==
X-ME-Sender: <xms:a5A6Z3xaFq7n-wTZvo2cWG9cQzrAnrXnLszKmbiDZxRsDQb3tt-7Aw>
    <xme:a5A6Z_QKFm_CiWM6PKfxMkFBGuQkpy0JA_r1Vu5aejbqLB-xmNReED-8WruUaacTH
    _O2-k-Rw7553Am2IQ>
X-ME-Received: <xmr:a5A6ZxU6isKIRRoUTXdos4aNA-nBP-Fa3MvMbjWfnRVmt8IJkW1GoG63Z743YF5dP3elsC2zu5BJCoH6HBJGoyo99Wnr02c5qnjN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopeih
    hegtgehlfeesphhrohhtohhnrdhmvgdprhgtphhtthhopehgihhtghhithhgrggughgvth
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:bJA6ZxgFSQvlmjgORgNbCAss-2WmW9usoeJbpu70BctcgoAOlYgz6A>
    <xmx:bJA6Z5B_DicfWLcGnrzg6Rc3ln6NS9-H-S513wN7fRQyvytPZnbkYg>
    <xmx:bJA6Z6JMbqFE-53TzKt-ny7qHdaQKtUG0NbrXEW9dDOVPup07-k5pw>
    <xmx:bJA6Z4C-xWga8C_VWCc97QOi6eKcecHrQRs2UgZrvGnJl4bj3Vx31Q>
    <xmx:bJA6Z71W_4vXWPqlPcwfk-HVYz3J2ZF0bS5MRiqFPItJiHSW8wCmcplE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Nov 2024 19:55:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jeff King <peff@peff.net>,  Philip Yung <y5c4l3@proton.me>,  Y5 via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] diff: setup pager only before diff contents truly ready
In-Reply-To: <ZxatqdBiB+NoMP+j@nand.local> (Taylor Blau's message of "Mon, 21
	Oct 2024 15:38:17 -0400")
References: <pull.1817.git.git.1729370390416.gitgitgadget@gmail.com>
	<20241019211938.GA589728@coredump.intra.peff.net>
	<UZMh2lyzbLOgsf0PXfMnq6HnWVnCK3y36jY3IMKUykPi74ztNucf8bgywoeO0DdeApq31JDDGMZiEya99zAcI3l8y_zcVqiN8FpEnT1DRZU=@proton.me>
	<20241021190045.GB1219228@coredump.intra.peff.net>
	<ZxatqdBiB+NoMP+j@nand.local>
Date: Mon, 18 Nov 2024 09:55:06 +0900
Message-ID: <xmqq34jpl5sl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

>> You'd need to identify all of the possible diff code paths in order to
>> add tests for them, which is the same thing you had to do to fix the
>> code paths. I was mostly just commenting that we're not likely to be
>> able to rely on existing tests to help us here.
>>
>> It might be worth adding a test that shows off your improved diff
>> behavior, though I would be OK if it was a representative command and
>> not exhaustive. I think adding to t7006 should be fine.
>
> Agreed.

It seems that this topic is waiting for a reroll?
