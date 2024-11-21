Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A901D271C
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732193978; cv=none; b=W7MZ2Oqf/x71p4EjTXDsOvmLWKDZJJC104Ky/Vy4OgCDRiV+U+h6nd8wDJ8uWenssJyxeLuAmWEnnSBQhQQbg/8ZbgTnH0lF9ZZXCZJZsyeP0kKXmxGd4mh32kg2WB+/PlFOft9VJBdQE+JZAuUpMj/CClhqYbK6C2XzfoyPHsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732193978; c=relaxed/simple;
	bh=F+bfLpElUMKFfpkkZ0SUNEsM6m0TDFw9YSNMDsrFPkI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NcPGxSS0ia27Klha17z9P8gvphdTRZhuTznqiWn8izeYNXbqtyz2BdegT5Je/1vKcsDYq+aX6pb/kZpeeNeW3jQ+CmX0Hcqq0Fa065hcG7yDT8R+cxholF1NDF14aHPOtMoCdIri3c01LVC+2e7DHiaV/zzH137sod1O8boxf8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rfhAZj21; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rfhAZj21"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4A3F111401BD;
	Thu, 21 Nov 2024 07:59:34 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 21 Nov 2024 07:59:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732193974; x=1732280374; bh=U23W5f36mRo9EDHvCPsGQE9uDfNHROka0SA
	nHd9K/8E=; b=rfhAZj21WH05GQyv9lm64Da+LGybfVBCohWZd+IbpSs0Os7Bml/
	O2FTIOVwEgQvzM2UOZN+2MsOEFNiADgxRAfooGtHLJrxzWCYiJGnpebHwMTn5lVY
	gDULoSE50gV8p30smxHE7M5S5kTVzEtwTF0OuOH/hdF8Q27AcpF9LNptumbyEq8H
	opj4qyTRs4Do/uEQNGhrOlZDE0wJSRe/KKaHO5nqrROA0ZLpZi61IUim+DYRvknC
	3699lj8qziByqSmeSZ4hRPb1KlCkn/h2Sa+e90ZZIG7OaWVvXXpUOqFjdhf7gpBO
	iA+V85Rsxm8UoSpxdi6AxcAfwi6HNzERpUg==
X-ME-Sender: <xms:ti4_Z_bfL-6OPHodiVLZyLSoft1l4qX2LzVmsZ-a7-1NlOOdP_FUmg>
    <xme:ti4_Z-Z7V4Aq-p6hThDj3YW8IavbB0iu5gKRFTCO0IfcBvJwt8MAnJLk2yoJWMh2G
    xR5AZZTy27OxpKSnA>
X-ME-Received: <xmr:ti4_Zx-9-OHFcWaDFSXg9W-q_QVpNbNeOQJzepF629HyI6lnjkE_gca-dEr0uTPfYCFW8DDiHxaWmG9Sq6KmAQ8ZkFaoqEg4nGv_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeigdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:ti4_Z1rMSTA673wJh0O_x-lY95L5sYvWcr7hP1V-x0SUqAc1m88p3g>
    <xmx:ti4_Z6qiQIizBCnM3xg-tvhhCZGRKDRQLpaf5spEQdEmiZEOjOcwcg>
    <xmx:ti4_Z7SaSPdNc-UOjlUBVpe5MMgd4SVOlxNFv_RHjcBZogM1rqL18w>
    <xmx:ti4_Zyooda2S_7MRmVuZ3EjDnEqmJabeA2E6G-dICYHnKc9DLbe5MQ>
    <xmx:ti4_Z9UiHgb3-XA5H1Bw7FU4-_OMg4JyfL2tqa_pFPNtDxHhknJ6XW_b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Nov 2024 07:59:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2024, #07; Wed, 20)
In-Reply-To: <a340dfc9-bc3a-40d2-a8ec-fc47c00d1305@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 21 Nov 2024 09:26:53 +0100")
References: <xmqqo72ai929.fsf@gitster.g>
	<a340dfc9-bc3a-40d2-a8ec-fc47c00d1305@app.fastmail.com>
Date: Thu, 21 Nov 2024 21:59:31 +0900
Message-ID: <xmqq5xogg2to.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> What should be done about what one might call a
> trailer topic version for simple topics that might get included in `next` soon
> after being proposed?

Sorry, but I do not understand what you are asking here.  Can you
elaborate?
