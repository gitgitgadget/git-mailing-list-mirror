Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2BE13C3D3
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 23:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732144868; cv=none; b=gYwRyB+DOotqkxOnWIxUQ4laUXnR+6KQ0KzCrK4KmDwhnF38sQywhq3hAX3aBiWyPzf5Od8Ki9wgwe7g1OU5feA5xcEXUCk5WGnDQDGYIjlaJFc6UyLT8KGHWTj3wKkaezCoYUiZIZOQwS8vTmODbMFYvOFFBf//Ty1KCxcXDFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732144868; c=relaxed/simple;
	bh=yBKs42vhcHQvB4GZnCpjWxQJCoD2iUcZxnXRKQCM9Qk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sIHFOt1OMXoVVB9LsXBScUvE4Gwshz39kt3npX8sktaqjglXjXBa9OixPfdhDNlBhLJL8BKa8gWr/p90doapKlWGZO0zIGMEa061PJLRS8yn0Nqk4xUPxY3Xd3Vf6dgOOP+xfNTM+akkKUwi9trQd6MK38Rn4/X7iXaG+C7tdjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HmJ8tm3F; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HmJ8tm3F"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 264F4254015A;
	Wed, 20 Nov 2024 18:21:03 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 20 Nov 2024 18:21:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732144863; x=1732231263; bh=S9K4sqtJ2CadnNA8qr+8PzqfOdVy2bc+flA
	91aeEPvQ=; b=HmJ8tm3FMC2Hh0kYEqwtYmpLjAmxlAXSuB1ICRJlM1j/p4wJvYl
	jkI1p8CnHpciswzb7Yqr0jFWomZXFY/arztHVOeKTtV370yqwaO2jlFUPvz3aheY
	jWZXgeCxeeM5wTgldiA9xjcZAE0Nh1DvScOl2MK7up34iUwQcIWRW3M0NJIj1r5X
	MVERXLcfrwmj8CjaqCbFgkN+eEY6BdDZoheyb++u/DRDBFKWrLJpb3Ku4Dqrd3T0
	QlyGNkIjI1zemzu4Ps1xssoBdddFbZtuQMTPYT/1ZaGS+Z0EQyXG+zTpXmU1jgHY
	IlWcpYQVQJz1lGRxtbvtA7/w+LPMhGag9Tw==
X-ME-Sender: <xms:3m4-ZysnSAp2sooJ6Ezm9UrIdXztix1o-34P-5osLopcXvAWnIOwXQ>
    <xme:3m4-Z3drg-FYtZS5PYacLQfweV9INAoLbuydZN1sYV9t0Tz9EUuDU0dzFXgC6h9O0
    NxE2-hWQD4ETB2TqA>
X-ME-Received: <xmr:3m4-Z9wDllLvdbYDPWjnu3Uar8Cz3N5pGvK_dAaxceaf4a-iSB04fnfCAmmU-EJcdN-xRfbR5C0Jt9syBaMd35JxheWVayBVHCre>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeehgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:3m4-Z9O4Co3bB08WctFaNIjjRsncnup5ksl7ORrOKz79crKWsIGuIQ>
    <xmx:3m4-Zy8IZkh8V3hY8WHCTqeb0MppK0J_Mes8kmDvPmfzxRfk4BeY7Q>
    <xmx:3m4-Z1VSBk0po2TcnUeTu8zb-LzpLB82cnmFRzsClqC7DuKlX95APA>
    <xmx:3m4-Z7f9ooiCdlFkZg63xUfcSO2VFUaccSzmL9LTOcsmJG8hiam5cQ>
    <xmx:3m4-Z5lB-ERITj_SOj4pikt4G-rU8JYNs-VBLKWyy-m8oYpBPjLWOASG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 18:21:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v9 0/9] add ref content check for files backend
In-Reply-To: <Zz3xpMdzeeUssH6n@pks.im> (Patrick Steinhardt's message of "Wed,
	20 Nov 2024 15:26:53 +0100")
References: <ZzYqoai8X_Wdtbmt@ArchLinux> <Zz3MON9_9DGD6nsy@ArchLinux>
	<Zz3xpMdzeeUssH6n@pks.im>
Date: Thu, 21 Nov 2024 08:21:01 +0900
Message-ID: <xmqq8qtdijaa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Nov 20, 2024 at 07:47:04PM +0800, shejialuo wrote:
>> Hi All:
>> 
>> This version fixes two problems:
>> 
>> 1. Remove unnecessary space.
>> 2. Drop extra "strerror(errno)".
>> 
>> Thanks,
>> Jialuo
>
> The range-diff looks as expected, so this version lokos good to me.

Thanks, both.  Looking good.
