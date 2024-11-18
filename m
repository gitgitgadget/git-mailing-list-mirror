Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D091DA21
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 01:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731893578; cv=none; b=GHuIcCm0z8X1j7Dhf3NyXq74boZfBjkvhAvJyi251LFeh3kKBudmEg+O1uYooXCsah+8nEptKAKpX/W8ZUSfAFK03KDDpxYrWK5riSsSw7ij0bVlS2opB+nPV80TMGz9vin3k7V+2GBIx7VqzEo66tU//TgS73MIX1lwZrQTfyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731893578; c=relaxed/simple;
	bh=Rh+ggu1TYUMwC2g7yu4angpWgKTEIfZZzg9BUSFdUxo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mWHzXM3DAa2IQ0yIrKlhT/QQ3UdEMDz21QKS8c/potg2kcrmaXY0aRvXgwy+fJUGhP/8TIdOLFgSqHntQvcVAlaxtPtY81oNIiyz9CrdP8tueDVMYdrdsIKjEVHBlvSuWdMsGrVb8ARSwlPTqsa8Ajtml7JHTxH3C/mS9W9RxX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YoVW1STK; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YoVW1STK"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 1F5EA114011D;
	Sun, 17 Nov 2024 20:32:55 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Sun, 17 Nov 2024 20:32:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731893574; x=1731979974; bh=Rh+ggu1TYUMwC2g7yu4angpWgKTEIfZZzg9
	BUSFdUxo=; b=YoVW1STK5iKvPQPn4BdMxobkgWvpRdRAT/3L3S/8eo/Oh8X90xN
	WaxEHQX1+4hH/2B3INXPbn8urc/WPNScdyfBkgs//a+ONsHPIS7fwCgagkKiGayj
	Smaj+VA63VfsVlz6XE4vrwpPthDiH7NpTDMBMd9CWhIG8rfOQ1DANkHtj4jglOOv
	KzwvXrY+y3SAAI6GETtfUv08nCdS65aQ1PWqF/faYp5vmHW42TQDqKPLS6JvLRcD
	VqbIE4mUkONCEx5MTjojEXPMSFsh5m37KtnHWiKWJbYa6/KRQm5f2KPm/GtnBsIj
	AlrWc6GCpapVytB/ycTtWSgvOJOtC3gwHXw==
X-ME-Sender: <xms:Rpk6Z8tmMm3Mvqko70eBHMnq16tqvmkiEhdUDacD0b6uIKSW_Vtj1Q>
    <xme:Rpk6Z5dC6tsIiH-eiw5MgfauNFI6Uc_6JgqSiBTa9MfoYGCpH3bqizzb39f6nx3om
    FUmBPxEJKz0AVQ4Ng>
X-ME-Received: <xmr:Rpk6Z3xcJmcIbSoEasVBXJSZ5dXYudmvA32BP--dHRLqgheBW8h44oQoRih5QhgelNGXYlr3gdpGEes3KPRh9jcEAht5j0vSfFwP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghlvhhinhifrghnse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvmhhrrghsshesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehsthgvrggumh
    honhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:Rpk6Z_M0oHGttpsJIeoUxJuY0Q74NFrT0d7NAxlm2ePhB17iF7eAVg>
    <xmx:Rpk6Z8-hEBeLJx-pY8HX5lOeQzixeKbelwiPgJ4j96DUWimFsRULvw>
    <xmx:Rpk6Z3V7L_H1GI83G7XpW40t2mdMVQrshOBKmfLdZ_n5CkHWjx89ow>
    <xmx:Rpk6Z1dAnBKo9rH59eJL9G7CB_W-IiAIO0cCwzqVacy5tHCtdMa4gg>
    <xmx:Rpk6ZwRcVR3CQq63uq5-8VS50WwkllzaIJMIHdVedp9Im3Oo4yxGwMLS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Nov 2024 20:32:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Calvin Wan <calvinwan@google.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,
  emrass@google.com,  me@ttaylorr.com,  stolee@gmail.com,  Josh Steadmon
 <steadmon@google.com>
Subject: Re: [RFC PATCH 1/1] maintenance: separate parallelism safe and
 unsafe tasks
In-Reply-To: <CAFySSZBioOrfk5O7oni3LRLWasFo6DsuyW7icDDVkiUxq4fNOQ@mail.gmail.com>
	(Calvin Wan's message of "Fri, 15 Nov 2024 12:13:24 -0800")
References: <20241108173112.1240584-1-calvinwan@google.com>
	<20241108173112.1240584-2-calvinwan@google.com>
	<ZzGtD4Jz9Wj6n0zH@pks.im>
	<CAFySSZCzxfqpMWH5ORv8fYb7f5WU3Fc2N99fW33wD9JOcYVrVA@mail.gmail.com>
	<ZzL1jy3plVeld_3m@pks.im>
	<CAFySSZBioOrfk5O7oni3LRLWasFo6DsuyW7icDDVkiUxq4fNOQ@mail.gmail.com>
Date: Mon, 18 Nov 2024 10:32:32 +0900
Message-ID: <xmqqr079jphr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Calvin Wan <calvinwan@google.com> writes:

> .... I think for now it makes sense to hold off
> on rerolling this series (at least in the form of auto
> backgrounding/foregrounding tasks) since the purported benefits
> currently aren't worth the churn. Thanks again for the comments on
> this series

So, we'll place this topic on hold, or even eject from the tree to
be revisited later?

Thanks.
