Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6482942A
	for <git@vger.kernel.org>; Wed,  1 Jan 2025 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735750452; cv=none; b=rY9PYWKLa9/GjXIo1mmNqJXmyvG5uj9WyWRc856RSRgidhlRsjKHNpUyuaXZfEVlUoVq3TRxOuSeSBEn5Z1G8rqAK6ZlIkRl8CrsL0IiFDvP2KfDqiRGU5Da5PjwFK1nL9q01SvYaYLEyqj1Fh0XgcKEUyWPvR34Dawf6einp6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735750452; c=relaxed/simple;
	bh=x+C1Y2Pysqb5wVHdQlnGudfZ7gPd7cadi3OF273vGno=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IYWBw3kO3OtFqXPFCEQx0KQCYXlWYT7jbc+cmB679DOTudu3oaQAfVbNeeXxuPH3gg7PpoEshrE+0Zg8vTcyTkdgMzCMi+KZmRzePz92IIQyC3SuXpE4Iyu/ES3Bg0FmEmJKfIdVsuQ0cl7I+j4D+qdDpo/fG1LkcVEdrJ70iAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zPIZVxp3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AaZuEZCq; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zPIZVxp3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AaZuEZCq"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B5897114009F;
	Wed,  1 Jan 2025 11:54:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 01 Jan 2025 11:54:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735750449; x=1735836849; bh=x+C1Y2Pysq
	b5wVHdQlnGudfZ7gPd7cadi3OF273vGno=; b=zPIZVxp3fOTHy+DmOvtXCJknqS
	pGGLfjTmC9nayoXVIyJi5iHZgHeZv2Qyd/p25zyh+ztJmVwvdAAvVBvNvh9KPWaV
	hThWJBa6qrZ8xdT9Rfak2eqpYoqzZLhJko+AROnvU+WUMrufpBlsVLgUfZPzsvJz
	hHMMJr+RLOjlHQLyt7j+QPTwWe7cbKe+ikkPwmJoW08COZVQgWn1rgXDa/FueyKp
	kpUG5Ka1vf4OwnjXpHKVWBBHD8+Z21LCfyIhQUZN+jrWFlkfXZqLsqp5Ufy0qz5t
	UPgXasaupF+l7jiuj6YqEk/BRxDLtqYgR75kQos4UNnNXJcDogq9XZNqETKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735750449; x=1735836849; bh=x+C1Y2Pysqb5wVHdQlnGudfZ7gPd7cadi3O
	F273vGno=; b=AaZuEZCqmht6cqxh5kyOV4f4jY8fDnSSOyZsu+hjZta1zgJRzUm
	yHFL7MA02pAt+NFoLbMZCo1IHdPjz1yCrDV8orhSzgDVXSlPrCb7Gne6787cOBSk
	S4YrYuztikTkuPP+49Uur/M/tC85umrdycy01mjap6WA6Y3xBXUApMjQ1ql+bRmM
	e6rirJkSkGdFU6YBDiWevn1b3zy4eh/dOntg8wQMzQZccGFSaUUe1Fhis+de8n27
	TPMGmQ170rZDMeYyCueg024yEUIZDi7QeudX1RWxatVwzQhKcN54Mg+c3X6NGnyc
	TDZ3hhFJB+KrCMqz9Pm9wbnxG5EjgQdRVyw==
X-ME-Sender: <xms:MXN1Z2fkTYF32qyaRKOgZJJV8WMb7cxRqMaUhJ1Qn738csDbo2QpSQ>
    <xme:MXN1ZwPmSDI-q23SzefRIEuWUU3W881XTul2aFnab5KUFAVe58n0RWqRrH1YA4dkL
    PooM7sHxnxOv7C_GA>
X-ME-Received: <xmr:MXN1Z3j51IOc6-1_tx_j0uzGZ-N8T2DQ2_pc17MqPFvOpVVWtrnCyry4WvDQvfNzD_grmZHGBXj5VG1BPRfmqYe15nKDw8pWNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeftddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:MXN1Zz90U8mxccaSEal7oDZ7pszdQYoh4Ld_B8wKAAhvcKKDRJqY-g>
    <xmx:MXN1ZyvdULtj4z9in5xY4E4xmsBNnWXMfVDggmwqMX2H1xKfiejWsw>
    <xmx:MXN1Z6FprRbDM40R8NTxnPfrvU1_zWsqtNzo6BKYnwDtfqTpKE-Tsg>
    <xmx:MXN1ZxMxxuWLDged0_HUmZ8b-5KDXRRYOKyNnyhptOZmG9ACsgSZAg>
    <xmx:MXN1Z2IC48lpjc_qmMwIMQl0ZD-OVP-KUrWWA669HjoMlj35F5u_r8FV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jan 2025 11:54:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.48.0-rc1
In-Reply-To: <043301db5ba8$323355a0$969a00e0$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Tue, 31 Dec 2024 12:19:43
	-0500")
References: <xmqqjzbhxeho.fsf@gitster.g>
	<043301db5ba8$323355a0$969a00e0$@nexbridge.com>
Date: Wed, 01 Jan 2025 08:54:08 -0800
Message-ID: <xmqqwmfewk3z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

> On December 30, 2024 12:33 PM, Junio C Hamano wrote:
>>A release candidate Git v2.48.0-rc1 is now available for testing at the usual places.
>>It is comprised of 549 non-merge commits since v2.47.0, contributed by 81 people,
>>33 of which are new faces [*].
>
> FYI: NonStop builds/tests look good for this release candidate. Thank you for all your
> efforts.

Thanks.
