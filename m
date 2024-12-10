Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D25241C6C
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733791841; cv=none; b=M4jRORZdZg3wuoi05CZ+cujSZ+w/i6aFkmL+GatEE+F526ud4RFk/rAwuNGgdCuDkqZ40+JZTzhe2OJOaVoD5HZDYHt60JhS6uMxG76mAefdv3OUKPjM5LMYmJA2P2swZQ7/B1XpXNku6f4khZwjj2Edr16tovELSVCnK1ubUeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733791841; c=relaxed/simple;
	bh=4zVrWFvNde3wCgUSoGfnbe7pbN4vgDcUI1uJWTX59dE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XcXNtPPnkcGWgcTS1tk3Dqmz6eMvzy6saf7ZRYmeD3H2o9l6mSKvfeFliFT3IdxU284UHE2yvMzPzOE62fuULNjlwePl+RS3yFrla+liH7wDk9xxarq4faYgDzFOiUcrysUjhCpweFrlK/W+/Eq5p8PnBhTAJ9X/zvTcSdZDng0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vbt3YMnw; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vbt3YMnw"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 29AFB1383ED0;
	Mon,  9 Dec 2024 19:50:38 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 09 Dec 2024 19:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733791838; x=1733878238; bh=tCXDmDYGsRtJ9+vgfV1G5pp8+KMvamdaDt7
	zc8588Fw=; b=Vbt3YMnwP+pHOFvgS3nvWh6iP1HvJkrLBR9VbXWn6SPsWsjxqLW
	uER6YO/nPDoYCHz8o2PzI41iD4GHLBuZxfTf85YGB9ZC0FvYcVxmF5RfDBSMjhUa
	UhtwN8Dkqg+R2bpqcAZ1WiNUKXybdL2NboaTeVVkjnga9hBJSr327m8NP8ajf1uo
	FvtNRfKmH2jBc0lfA1y+WxEeaAU6e/spJleC9YUveIzbiyCt/NFYIb7vTu39f08Y
	2NKiT29rXpHGDdAxeycHTuBGmM8JfHg6mdztNzUSGZ216MVYvG4POxPhV5Au/Sqo
	y6KpP2j9nQLLzCHpekVTNogSL02WNl0JK/A==
X-ME-Sender: <xms:XZBXZxj8t0EyWcZVILJVN6BJD2C-j-bsn53NEKGsUUE3B0BbOJ85eQ>
    <xme:XZBXZ2AC6sVK3L2XdkKd_uwRgMv8VPpk6Rj0OLXONMMkGE4opkhFVyp89b0AHPIsm
    FH6jhyMuYVJW73QxQ>
X-ME-Received: <xmr:XZBXZxGbperz7kYDTBsHs2q9e4Bc4oLNeYsUkQl3yMGM6X7dnm7E1QpAeaBBS25UdCPj2rLdW7rQP8s9a_F2kTR47TV8fo4_JD0n6O4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeejgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrohihvghluggrrhdtse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehjoh
    hhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehsuhhn
    shhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:XZBXZ2S4Y6hz9-9o2-dmZwka_yLf9p_8HXLHEzKZ3FoYTQOBEymIBA>
    <xmx:XZBXZ-wekzq8FSpdluWghAts4WEW3n1xzl_oxF5fWZPcmJ7XjBNs7Q>
    <xmx:XZBXZ87O4sg__M1lf33S6Ml4YjWAvV4P7lHlIYnGH-K3jzXGMZlYYw>
    <xmx:XZBXZzyz5ArIrLUksiuCBZCOcqGBlCiOp1uScgnjseaac9b6poG_rQ>
    <xmx:XpBXZ1mX_AVk5T66cKrDkLGyDfeUk7cMr2NOPMElYin1YyxYW0ubhzuf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Dec 2024 19:50:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Roy Eldar <royeldar0@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/8] git-submodule.sh: improve parsing of options
In-Reply-To: <xmqq1pygo2ti.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	10 Dec 2024 08:26:49 +0900")
References: <20241207135201.2536-1-royeldar0@gmail.com>
	<20241209165009.40653-1-royeldar0@gmail.com>
	<xmqq1pygo2ti.fsf@gitster.g>
Date: Tue, 10 Dec 2024 09:50:36 +0900
Message-ID: <xmqqa5d4mkdf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> After reading this, it was confusing to see [1/8] still doing "1 or
> empty" boolean, only to be further modified in [7/8].  We prefer to
> see a single series stumbling in the middle and changing the course.

Facepalm.  Of course, we prefer _not_ to see such a change of course
in the middle.

Thanks.

> I am assuming (but I don't use "git submodule" very often, so my
> assumption may be way off) that there is no such variable we need to
> pass, but if not, we may need to reconsider and use the "variable has
> only value of the option" for at least some of them.

