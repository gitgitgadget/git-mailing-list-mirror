Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43FB1547CC
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 05:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731649830; cv=none; b=Kk7y3getzPfnYencbjOvE+QSZnbtGt9Dq2nVwOT/YU+792CssH9AG+rp8F17WzkQ/25BK7Sgxk5u22wwR2agZi6F1b9fujdpxYN2HCltCV1+jfir3VVQS+6xwM801gEtt73xCnRKfTPwkOgmKp4iKBcxVeaFb1rFK+EIheH3Z5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731649830; c=relaxed/simple;
	bh=B+9SwOUTcKzRHvqW5FmtlvYXSUd105hgwcxhB40eEkc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kf8tuRXHJabadFeSL54A7JSUSn69K7bpvFcUQnW2Mk7l5EidV6/98PA+yYsLGY2O1krdt0mynOJtqpdpC7jGoURiTNZCSlLR20CuiGJ3Qtapa79ZE18FxtENIc5eXHqFF1qclHSKb7DICIAlubdev1DLSQ1G7pQ6uNT1KqhsLR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fr+z0xx+; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fr+z0xx+"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 978FD13802BE;
	Fri, 15 Nov 2024 00:50:27 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Fri, 15 Nov 2024 00:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731649827; x=1731736227; bh=Ek2iJLZR8EkHEzpNTGBa9g9UpJVYvgzCCtC
	silIvDCw=; b=fr+z0xx+Wp6SKdr/NcXqI+s3eYOvhsymt6qhRw8bVz8P2Cyvt0n
	25CroQ9ZJsGSbOUZPxK0bbZeWnP/VwE5JJC7vkOgdiG8nRaMSHsXa9cwjpBr9OR0
	Pzh925VddeCwhHelDp83CT/UYnvSw7gFX/tF0t3Plqz+k9VXAbcgWJ+pVvHySx7X
	AYr/9vsMpOdxhGtXDf77D+0EHT4EhU4SvqllmBi6NsFuNXZnMpgEJ9qzKdhxRiCa
	Oa3pUdIh/MXbX/Gar8b3o/1wGNsEK15Jry1wGXjSMLzKc3tGOoOImPAT4UQz1I42
	Bs1sXIbO6gxpfGZmuyyFf9Z7koqV2ukQ6Og==
X-ME-Sender: <xms:I-E2Z4m2H-fQqUa6_RHV7F2dFU3gbXPDNr98oRGC4b_90YeRQtqscg>
    <xme:I-E2Z33qwUIBWqMBTkTsM_2SmQcb02OHxdlp4h9IbBqQSBhAmeRyipNNyHjRId77f
    SI-bs4VIZFKcrnCGw>
X-ME-Received: <xmr:I-E2Z2p92S1a1h7LA8ugBhmNw6cObZRESn-HImORWV68zYNeisDMcUos6_dC6PVhPMOIoX4g46cwr3Fw-iUbEQYmB361ihMUBdOD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghntggvsehfvghrug
    hinhgrnhguhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruh
    hkpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepjhhohhgrnhhn
    vghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtohepfhgvrhguihhnrghnugihrdgsvghntggvsehtthhkrdgvlhhtvg
    drhhhupdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:I-E2Z0kO47rCCY_McMEprPjTKMgJWOHLV2FJmyO1VJDDTN0_SaTGCw>
    <xmx:I-E2Z21vEkePPYn3112qo3rLoqKlh7i9KrYfgpOkfrSxdoCCObzyMw>
    <xmx:I-E2Z7v7V5IXL-ueMWa42PoDoWTv0_BOq_ciF5ywiYJiy4ktwWNeUw>
    <xmx:I-E2ZyXCoQgwQk1AGtN724z3jbyWATNf19odfTenDiRHzHHfJT5BeA>
    <xmx:I-E2Z0xT7C_nIYqYL1XUHoqIgVexLrZfgbgfHkMnEjiMu3sV-5MYZa6V>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 00:50:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,  phillip.wood@dunelm.org.uk, 	=?utf-8?Q?Ren=C3=A9?=
 Scharfe
 <l.s.r@web.de>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 	karthik.188@gmail.com,  Taylor Blau <me@ttaylorr.com>,
  ferdinandy.bence@ttk.elte.hu
Subject: Re: [PATCH v12 3/8] remote set-head: refactor for readability
In-Reply-To: <20241023153736.257733-4-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Wed, 23 Oct 2024 17:36:37 +0200")
References: <20241022194710.3743691-1-bence@ferdinandy.com>
	<20241023153736.257733-1-bence@ferdinandy.com>
	<20241023153736.257733-4-bence@ferdinandy.com>
Date: Fri, 15 Nov 2024 14:50:26 +0900
Message-ID: <xmqqjzd511wd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bence Ferdinandy <bence@ferdinandy.com> writes:

> Rename buf and buf2 to something more explanatory.
>
> Instead of calling get_main_ref_store(the_repository) multiple times,
> call it once and store in a new refs variable. Although this change
> probably offers some performance benefits, the main purpose is to
> shorten the line lengths of function calls using this variable.

Also two strbufs are renamed, which is in line with the objective of
the other change---to make the resulting code easier to follow.

Looking good.

>     v9: - further improve readability by renaming buf, and buf2 consistently
>           with how patch 6 was already done

