Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922CB230987
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 04:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732249371; cv=none; b=t97S8Act/XrCvAWG3dmKGEAv6no4cjdd+p6t4iWDscDQlGr4U7Euwmw12ve6BUXJ+f56N28O+oqbtJ3oq7VK+LsgxbNjJ0+6scB316KtONyXeQ1XwXaAjekktl0t3RmH9R3yBU5342YSDkM+vNQ/MCdICd6fuMoNg7lfg7kjyig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732249371; c=relaxed/simple;
	bh=W40ZwccDezuu+3EViLohw/XwqObff3ZmXooQZ9r0xiA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ly04c3nBjNbvwayizZZuNU9hJfH4ubj6wpdsAIEhXryUhxzGFEbNkp52l3/belXCDNTvwYIn/QlKcZNENQPjb7w9g3KxqfBaYQP6LaGfopj71mPEiZFChjYvLkax8vFrlZAAXAMcENyNcYPSJTdotAh1Lw7ftdYLIBqoi++1bWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xrPI6Mb5; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xrPI6Mb5"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 76C12114010A;
	Thu, 21 Nov 2024 23:22:48 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 21 Nov 2024 23:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732249368; x=1732335768; bh=ZvqqcXU2F1tw0HDIjysM+RKW2rSFXMAkhOT
	HaaGLOp4=; b=xrPI6Mb5qCIX6lT0Yipq76UlbqcXBbW/848x0HBcpRLgoodqXQW
	KHNUEZxz5mAp1yk7Ts9sxF+EfEmURTWgoepPDf2VLWnXBGcXhtWeIuOyLwnmvf6p
	N8erYvjvoSoEJUqsNor3Hy1Jx9o03CARebuf57IYdh6dWjVW4ZdcA6l1Opt+cv1a
	MvMXcEE/Jfe7EgeDmbb7kAQ09ZsUpsyWM/hdvThf88l7hGRdLqKDVbvlnHDSPlbS
	w+zu2yin04/8RXRx0S4DfO1iXnMaWL/F06cXpQkFcbzIIfEq0QSzEzF5EctbscLT
	4CH4sa4tykq0VSeqvZBQBxixWlKT1k5Wv1Q==
X-ME-Sender: <xms:GAdAZ6y-uIAgO7cgEQccM3HvTS6ZwU6cfevirK8R79dkch7zky5Axg>
    <xme:GAdAZ2TTfQAnGf1NPaXbGHVrNN7mgK-m1HhWzSVnnmo3NMt-OFHKna64nKOJKmEkN
    zDukgFzuX1b9n4L_w>
X-ME-Received: <xmr:GAdAZ8UxD9ExLlF2egsYCV96Mbh7pLJaWncr-hc39VMojYvtIVv2heMD5u9LFr3MPW4woySIMKvEA3gV6jkBcaYzusH0n6bYi7Xu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeejgdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhonhgrthhhrghnth
    grnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvght
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdgu
    vgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohep
    jhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:GAdAZwibrqatnL3On-ruI_hDop7Y3rA1PDTbW1grLrhvxB-60ux6Fw>
    <xmx:GAdAZ8D2RO_bbwekXg1yWrqkKHtEvni8IG4BmYsQIpjyYXCQNwOpsQ>
    <xmx:GAdAZxIs9E9fMaLKxq_1p6a5NCipF4zEhmkENvwtzQiFC0gIf11kAA>
    <xmx:GAdAZzCBxBnMhuGdlaslgUsoNpBnosJSyCnFXDM2_25io1IDbBImbQ>
    <xmx:GAdAZ1JnFSyZeQ6ikTKKbsCoJ9yDjkugsU5Ovf2HO3Kc-gBzhzWOZRVP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Nov 2024 23:22:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  ps@pks.im,  me@ttaylorr.com,  johncai86@gmail.com,  newren@gmail.com,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/7] pack-objects: Create an alternative name hash
 algorithm (recreated)
In-Reply-To: <xmqqiksgas54.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	22 Nov 2024 12:01:27 +0900")
References: <20241121235014.2554033-1-jonathantanmy@google.com>
	<xmqqiksgas54.fsf@gitster.g>
Date: Fri, 22 Nov 2024 13:22:46 +0900
Message-ID: <xmqq1pz3c2y1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> ... (if we were to do so, it might be more efficient to
> shift in from the right instead of left end of the base and hash
> accumulators in the loop and then swap the whole resulting word at
> the end).

That is garbage.  We could do the "shift in from the right and then
reverse the result" for the hash accumulator, but not the "base"
one.  Sorry for the noise.

