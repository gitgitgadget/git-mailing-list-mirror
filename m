Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662922F7AA9
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352859; cv=none; b=NBm/GkVG9q6B4/BQD5YNfELEbvjSe+FpAkP7Vntw6Tk+sNDEboVMaaka4FuSJkMbMqeJJVaGTDkUBxlqmjj2nU2FKhLjxccimDI5OaRQsbmkwwU7JPTGkjStI3D3Qe1RaaYFWDXbS4rHEhsUyYVJkEo67jvtYVlj/sStHPiagFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352859; c=relaxed/simple;
	bh=/11VWiHOb4mXb+5zFYosZ8dmHJkZuIznxornnbPkJnI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sWPS9m8QZty4Z9v4MxxY7scjqDuBQ4bP1IA667kokTTrwe2AM8IC9d/EfgVx4FYEfi52QIf94URvdHT8QmvvcqFyrDbHc8CGEtcf/RqMCZ8VtAnsk3b+jcOHsnYpt6iS4XeZe/lD1U89On7AGe29yn9sDMRt6nL9nNt2HIwhIAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sU4U0xQD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OWC8wITp; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sU4U0xQD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OWC8wITp"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 421B77A0110;
	Mon,  8 Sep 2025 13:34:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 08 Sep 2025 13:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757352856; x=1757439256; bh=A5mXqhybZy
	J5n7yp7UzCDzN/zW7aiXlZrL3tAzAJ+RY=; b=sU4U0xQDrLv0m/yqX5xI5rAiEf
	Jg4vNUv8NEd+s9Qt5GeYvDsRz92AFOTrbffIq2IvqH6sUUUeLvHzx20cC5i/drW5
	AivPk6a1/pPAkdMPoVgmreq26wtAbPjSMmRgrB+8CuETPTQqfIfVKvcPX1kY5kDp
	vby4M18IyhEy/reZXiyZtwzzsh3TCIghKMI0zkk8U8DVPOVyl+Umy6tC+R6PIepw
	rYpHSdD4BaXBX/AjbmACCf0+vXmgqTEim4Q+SIv4wlbAVfm5n5iBlNNgkTjgeptX
	R/kMhi581nZmSl9ajqxkELCmiFCMGzjuh52HEgLWz9Azu7nU4Ol2kSDAtDwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757352856; x=1757439256; bh=A5mXqhybZyJ5n7yp7UzCDzN/zW7aiXlZrL3
	tAzAJ+RY=; b=OWC8wITp2WMCfpsBTAJFf3yO3wwiA/6f56cGxB2EAaZB8KYxFT1
	qXaVzIDC1fw4Gm+MF8avKSfoqlkBjVKAgmzjQyIh5Lwqt+5pCgYzyorurIex/pPM
	+RvQZlf4dPDxOGY0nfOz9uFgfdvi1Baui+Ak2igjmqwWf3vI18OsLIQpxnWLT1TO
	qF0OcpSJJV53pPFqWzypi7E7/iim729XfFnyG70b4s8JNXMkyGrNm5iO/T9HSL7p
	RtuFq0m1YzlxfTM0TOSNw0w75oWqxYld/tFVTEzW0/xKMkJcLLtwIjA4Pk5HYsiL
	MHNHImQ6jddKucstVDhLMYx4C1ViKgw29Ww==
X-ME-Sender: <xms:lxO_aGbB29hB93sAZmBuL9lJbQmc6sWRmGZtfGZC3_mlYIJE45AwvQ>
    <xme:lxO_aGW65xZLzTIS3brWFxL3dPOaAoZAMCIBqzKom5-sssPFAMSKoCdGnmyAcCMKu
    wEm-WskAkTnSh8CjA>
X-ME-Received: <xmr:lxO_aMk4JtJp8WZrLKOq3Ex2-PebDW1nBNZiNDZ2GBTLriRt52oG5xOA5L2rOT1vuW4KU3g9x6IVHiBWYSSdjDgyVR-DVjiAQiEv5sc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvih
    hlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:lxO_aBBS1aDdRQRhoJqPumP2FMSx300FKDRGtJoGUsGQCKlqx8_9hQ>
    <xmx:lxO_aLhOBoqkzJZ8RIgZvKRck5ffZat_eMJo64pQRnlk1wx1rXDxQw>
    <xmx:lxO_aOwkzBOmMh72Kp8ummZHwkoF5DSSfJYbSUHhouHSImWEBMm5rg>
    <xmx:lxO_aM2gW7vgD1Ue3quOuo6Fnwe3Su8VE1h_3p_WnWdEPVXZPltdgA>
    <xmx:mBO_aBG1NYLsWYrzJQKTy-yqajg__bCqWMrg38j4UAfFlzDoBnYOzq8u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 13:34:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Karthik Nayak <karthik.188@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>,  Jean-Noel Avila <jn.avila@free.fr>
Subject: Re: [PATCH v8 0/7] Make the "promisor-remote" capability support
 more fields
In-Reply-To: <20250908053056.956907-1-christian.couder@gmail.com> (Christian
	Couder's message of "Mon, 8 Sep 2025 07:30:46 +0200")
References: <20250731072401.3817074-1-christian.couder@gmail.com>
	<20250908053056.956907-1-christian.couder@gmail.com>
Date: Mon, 08 Sep 2025 10:34:13 -0700
Message-ID: <xmqqqzwgx2zu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> Changes since v7
> ----------------
> ...

Thanks for a detailed write-up.

Will queue.  From a cursory look, these all looked sensible.
