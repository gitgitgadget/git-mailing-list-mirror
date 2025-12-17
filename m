Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E5133121F
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979179; cv=none; b=HQQdHRNWIFlIWWk21F35+A4Dy0kD/Ry2Pckje3ZgjNxVrz9sj7aQzcv4cHfAdPEk6qRUfv4/HClAARB5yHF+yno3/bPedgVe9eynF5gd+GYeEE0js2VkWoR5eEcgiRZ3RoKVGrwTvKwxdNZeHDSrhNFwL9H2GRGDWx0fRyIGNJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979179; c=relaxed/simple;
	bh=00kSSm3OXpbuHp6NR+Ux4XDfz8VwjtjI6gKGXn1DYro=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gytbx1q1UC0L5zg5mWMUFnzBunDp5w0kUhwPFs3Xe6qipJx78Ka5DVGMls2kADSqev+gACEz/wEc5TtHUn4s2JlrR6kwApsZH+5igVgPh6sffSGtQUFOFQzInnwInj2na7SeHZqSayeYeqCALTOREq2aRCM/rc2yXEbj0T/A3/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eAxW3ZTH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aX6ZqVuc; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eAxW3ZTH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aX6ZqVuc"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A528B7A026F;
	Wed, 17 Dec 2025 08:46:15 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 17 Dec 2025 08:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765979175; x=1766065575; bh=/RIU/kKGog
	0v4/0sAvzmITNF54wRfSU8P9b1GiQnw2w=; b=eAxW3ZTHTgV0vjeKCqt654ISrW
	Hki5riCr8RS8WZG5K7YMOVUGwPe/G6mepIguYQSaWR96AlzZLIhU/rZ0ut+fANP5
	RmQVA+B++rgk9j/TctqlyVb/Xd0/FGqOWTpYF9H7xLl0mQfFwsPMD7qAVPPJg5I0
	6j39YlnSTPLaF7bldU2BwARBgFGi6Gpv2EOvEJqABhpGSMu3WSOuPr/sE8cURC/z
	V+60VPmyW1B9Wil63DTVMoSLvlIIsalvF2eGRJ9GmpLuCsTwYyjouKZxYBRp+7D6
	O3+2+egmJ6oMdd4TDxs3DMIQkT3p58xMF512uICjkeOIUNW0ka7YYeCHn8Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765979175; x=1766065575; bh=/RIU/kKGog0v4/0sAvzmITNF54wRfSU8P9b
	1GiQnw2w=; b=aX6ZqVucKxOY/yHfG8ai6z5yubMJ6O4NHHBtwT9zUzgbxupqGMM
	kHaRyaBbtMsvK+1dFmi+MeYb95CFrWSdUOrEF7BMJ/que/yqxyWqrca0w6tESYlK
	DWZfyxwhILc2PHvyla9nA8cbr20qkTTgZLP6mjA4UCia9GzZqcihIg4iq/fPeOEK
	qPQXMPf4qlHNjdzhVbyRHuPnKhWuRd/A4CUv+6xCACM1BMMCPF0LwSEtKcrw/cRQ
	uglMOVxNSPpMJCK8zRcp0wICmQoDbWPcemoCZxcqvN1rK1vCzz2a9E3wed6SgBGV
	QeFvfZU3M12rUPSg9QoeRWm6DD4NWQ48gfw==
X-ME-Sender: <xms:J7RCaWG3B9Buu6VoCjsM9vECBbApkVe76y20poOEJ2J4vNPfFqlvUw>
    <xme:J7RCaeX6pBDwcTY81GlJLOux0nte2iAWbhqnHF-4kSO5Ds3MmAVXYZJ6wIhAgl2An
    TX0D8eEj5qzQ3bWdP5KIJRvuDbSRf-uNp0cSOSQ0Oz9qhAS7Ze34kM>
X-ME-Received: <xmr:J7RCaVKfrp6B_DvtPKZUaBMG-S9r_MmHwLQB3zbBS3ia4_YjyVtYgEejLs-01E9PduwdNZ-ZDpG1y29C3YTcy4Dl6jJ5pc-eIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegvdejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrphhlrghtthhnvghrsehnvhhiughirgdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:J7RCae-PNUirPbXrmF4IiR_xLzwiLqLxuq3dEzq3oktxP9wHtEgdQQ>
    <xmx:J7RCaYI4tH2vOALXBzYkMHVaZgkvjTLVxyr0xQChGmkpBHPLR8ZAfQ>
    <xmx:J7RCaTkp75JBXIuxC5oK0hO_EdBI8U1HditjtmPRZP8CmuiuaoZifA>
    <xmx:J7RCacPWVGU0gHODSfw--Kr4Nx7jmGBhylsaRrIBzTWyPHl3zRZwyQ>
    <xmx:J7RCacZHQNCYr3XZXvtVT7FL4pfgCXKuoWwvbOkwXz6d8QIiai03ztXc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 08:46:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Dec 2025, #03)
In-Reply-To: <9a318697-4bf5-4ac9-ab9f-f9851da7c54f@nvidia.com> (Aaron
	Plattner's message of "Tue, 16 Dec 2025 21:20:05 -0800")
References: <xmqq4ipwc7y2.fsf@gitster.g>
	<93afac3c-c532-4183-a1fd-7e2322ee912f@nvidia.com>
	<xmqqecot3dm1.fsf@gitster.g>
	<9a318697-4bf5-4ac9-ab9f-f9851da7c54f@nvidia.com>
Date: Wed, 17 Dec 2025 22:46:13 +0900
Message-ID: <xmqqo6nx1asa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aaron Plattner <aplattner@nvidia.com> writes:

>> Let's mark the topic for 'next', then.  Thanks.
>
> Thank you, I appreciate it!

;-)
