Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CCE184
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 00:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733271024; cv=none; b=BsSuWSQIlSL5RArf1EW2dMgMoODgrXpchKFmWofX5/gsggGxECF74z63Kg5Ri7MLdAK9k4a8EZCSXL0cTMLcPBRv/Ti9KM2bUsotNVYX3TSe+B6OM6fkgRhY+O1gcAGU/iOJrluzyMLbNuP0rc9xtjcbX1PYpLgJ/neRwPrsWZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733271024; c=relaxed/simple;
	bh=EcFwivZggsaVV0WH5nvC+8L8WB9Ef71qYs2XFQcN3Uk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=im3O5oWoRhl/4TJymN/Gm9WqnQatp9XLRJ8GCjDuQEOYPdv8v8ly0uSSOOL2VIrLg8sNwLQYTOXTmEPj9nLznQ7oyOHpBrkfUJPUyyt1W+TyVhBLoowgZsNDH/ikNkA1oGmZL5vRW04a0TBMAO5VIqBFIhJjlw+REcjhX/YgA2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IJK2IpI5; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IJK2IpI5"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1AA1211400B4;
	Tue,  3 Dec 2024 19:10:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Tue, 03 Dec 2024 19:10:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733271021; x=1733357421; bh=tZuMSjn8SZAH+iS1Qh76wfK7NgzQIQ7BEWc
	NyAStjec=; b=IJK2IpI5oc9rGFWyF3bYnsmOEf2Jjmd7wBOw+GKYZFRRWWTo2Yg
	RfRwIhKb+8NK+SiOoAZrdrIvm9UH9ex4rk9yz6Sr2sK5c0ISjMYa1GWhIRDy9UC1
	/DuYvnFiE4Sh+g4RoEmB9nVI+TME3ZsMGIQ9dyneysAIZL7Hmgy9qPmDkUeT7Gl6
	3fGCJ/Z4QkKAmJQe7l7ZOSzFSycrw4hc8NOz0pvpncTMeYF7L+Lq9+vFf/0jcUZV
	Di6X17zSFN98NqqsBNpQ81z8pUhaG+dhEQyWqt/xpWgOIArOoTIkzly8fGoAPJsk
	WtP6f5cEHNGuPRHBwqlgdmr7+6Xn1mfsy1Q==
X-ME-Sender: <xms:7J1PZ0sYcGEFIdGlI7fMjY3-aUxepo3ozR-f4VdzSVCHl7HMpbMHsg>
    <xme:7J1PZxfWp-n-5FiQSjV1-Ybx1kjfllxnvK1T3EVgSx71_KDalcQRYNJMLZ1IpeKhr
    uGcez3gh9dxSNBn8Q>
X-ME-Received: <xmr:7J1PZ_wpY40Utnq94iR5iW34L_SZhtYXdvl-rQXk5g9sAxPX7ODD92wxrCpxHYPnnxMH-4Yv6rCpzLdGzqqWVJY5_KTGBD4i2kPCskg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeggdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggugh
    gvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhr
    tghpthhtohepkhgrihhkohhpohhnvghnsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7J1PZ3O0JMyxvnyTTaXKtacqTRQqDhLNcepIgmr0vu4o7K-FW38ICw>
    <xmx:7J1PZ0_rBzaOagfkVCe5d0WHgwzZCxyL3cd_CHPE1JXYXWI8w3M3OA>
    <xmx:7J1PZ_XGgg7oLINHMyVbSeiqWWHZKioJWD3VstTiBczxuqLsSWj9Ng>
    <xmx:7J1PZ9dl6P4tOHLfH5UyiBtEqLKnZa8UqX879NN5OEPSI7HyY_z5bw>
    <xmx:7Z1PZ0wmEGv-uujk_TROU798DuzhbqlZigG6hybvukLHxI0jMjepyy5A>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 19:10:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kai Koponen via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Kai Koponen
 <kaikoponen@google.com>
Subject: Re: [PATCH] doc: mention rev-list --ancestry-path restrictions
In-Reply-To: <pull.1838.git.git.1733257083739.gitgitgadget@gmail.com> (Kai
	Koponen via GitGitGadget's message of "Tue, 03 Dec 2024 20:18:03
	+0000")
References: <pull.1838.git.git.1733257083739.gitgitgadget@gmail.com>
Date: Wed, 04 Dec 2024 09:10:19 +0900
Message-ID: <xmqqiks071g4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kai Koponen via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Kai Koponen <kaikoponen@google.com>
>
> The rev-list documention doesn't mention that the given
> commit must be in the specified commit range, leading
> to unexpected results.
>
> Signed-off-by: Kai Koponen <kaikoponen@google.com>
> ---
>     doc: mention rev-list --ancestry-path restrictions

Thanks.
