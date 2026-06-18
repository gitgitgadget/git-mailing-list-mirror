Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FAE1DF980
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795335; cv=none; b=sSSPlUSqaf7PjjJUgE7YyKKNh9tjL1oCN2E1txZ6de1+76uVrQUvdCT5RbMpRSVAZCkQEr+C6agcP+YFMowvPBvH0ZyP/oGSOQLwUsClsQG7VDWgL2mfEYJgy4tLn0uMhIoqw3aJZoahf/8jAvACDaZ4MQRIc9F85IaJBbldUFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795335; c=relaxed/simple;
	bh=w9dDxEC6y4ZIOPbDIh+0R/0rToU513C/t4K3xC1TLRY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IIdCKQ9N0jvjQOOyvYNZ/MdC7wjG03rSJy2E37SddmuPXmd7j5OYb95YLRVjrCsa3ZHCokoOsSQcYE3XckwtGv1s6frK6hSkJekN2fG6I4IV9Jlb7NdC4WAHPCEukjupXT3OsXbqVYEQTAifgGDRE5tXu/UnhpACYk2CKT0QmYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GyTtosiw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=egIbgBig; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GyTtosiw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="egIbgBig"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 35A40140014E;
	Thu, 18 Jun 2026 11:08:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 18 Jun 2026 11:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781795333; x=1781881733; bh=vxzRqxmQ5l
	21QQUzW26wgAmFn2qasNWZSUUH3C6ZgpI=; b=GyTtosiwwZgolToDZHZ4hY8p05
	vRO70dytYP0qZoi7zBhccbtowTVPK6ey+MsE7m9SKCOCth+fmnl9y8T3cqod70xD
	94fXff0RFmOWnpszHjtcbVyypya0zQi/uWsbPGhnAJS9MZWXNTNBFbvj75PDGJ+Y
	OVDlv8S5peQcYFwLK43+qADETF+5xHiKgSStXoElTT9t61Bi1j1V2+0cHweC13mp
	zE4zodGdxLsWI+xWLrVlj8U5/yyCIXpEzdgy+EY88HJZdxI0sJHhwZl5MFA7JoGi
	voUmxZzXx+vh0HtSrmsk7MtZcPIxdnMEwIoR8OPmtKdHium17pXyd5gDjXDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781795333; x=1781881733; bh=vxzRqxmQ5l21QQUzW26wgAmFn2qasNWZSUU
	H3C6ZgpI=; b=egIbgBigsvz2vSGS5YokZ4X4Zqe+FZ5MCUvPT+LDPHwHlfjyzY4
	rd9nnn6B5KdZSGFk7/DilEwHaamJGfxq5otDo89AX5zUo9wNobe7gl7Y2wLpvjEE
	oKuikiW/5aI0kdFRtZK/9UhaVn5xjdcYXnN/3JgbtYSKUrWxiZaJozFwF2JeUIWo
	XjMF/L6bj5OIceAnFOHrG0gxS6pJHZTWmzEXGOCCPjNZGxcgfPgCe6VCC9P2W7q4
	knndFjPsMa1CouSLY5gQFgYmmKoSXbl+YiC3w2Le9rRhqcsDpT8XHUeFAeG/FHw2
	t2NITcfkZQD+Ut6tUubSbE73NtLEX5QenlA==
X-ME-Sender: <xms:BQo0atHOdSOBbd870JCVTuLLJEpWGqx_2EE5fjKOrWdodL35-Yfu5Q>
    <xme:BQo0apO70fICrQiIw05364J2vriLYi0NrRwtZzL86Fskx0h2mz3qtQzg5BkBSbV44
    biAzNdjWSzSz9oKSZdlRcN932iZRKtFj3bhCkTrcH_QJQqhVgj4cA>
X-ME-Received: <xmr:BQo0aneCadr-XSP3vsaKdlcGUDOuHogHQOz1jN_eIq69kAT6jyOCW8XFN-oV7iJys_dZ4u0heDtWycoBQ1tMziHpoFciWqQ8P42_>
X-ME-Proxy-Cause: dmFkZTFjdiA/Tsw1A5uPq9/tGeFhsh/BdJvYxdMmmOcytfTLadGnqrvRdK+xC5FnkyDqiy
    d8c33N6cGvjrm0KCMHlDRqFOGdGTz+JVKNRb2mgUgkY7JhxJM6GJRFnwvoG19NEFxuyIHW
    vdm6b5NKGc91LazJ3c0s7Bhxjf8cZ9yKOaxC8P1rzad7EMIgP4hvxtAL9g8kbLFfRhc1E6
    nRmrvXCeoIThLfu0Vq9dbb9/qzZZjYZjpqh8bAxBpus0IQHdQUp6UqoYx3henpl6cjFm6N
    c/gBKC8agKtZpr4GjCvHU4+C732NGn4K1YmVWJXAi4MF1aIrggYCBJNtid7RKPL92gTWi/
    Lrq67TTj9icvyw9+UTSEvxojSgBHYP5Zr4z8wFhirMUeAoRv8yXcwSF6gKgtmHeCr0y7qp
    FGVvSp5gi7REsHAtY0+A/KfEp1o9R5hLRpqlxTwPgCiqpXo/ED67mwmhDVVKNHqmCutPvG
    yL24DwBVE9zFUVMu1eGPEqePiKnQ4jrY8v0VJSlkEsjU9DPlhZybcrvcFG00mSqeZTTXxp
    KYvJrlEaqZ35je4sK4fgBdIQY8iHIhTuRFnG3W/Ww8UAhW8vAbrx/oP+eLEJOAsnObEr9m
    Ckoa2wkd6g1wAC3B3MczR+meULNDj+J3W/lkeXPPwQTfl21ADfFJsEH69mFA
X-ME-Proxy: <xmx:BQo0auugeMfpdngiuWqEL14uS7-1de_D4Y733Ymbu9F0Hd5edEw-Tw>
    <xmx:BQo0agljqaavCnMzfnQwLwwgWahTc3WTLOp_3MORfM1hraqJ0iNH9Q>
    <xmx:BQo0aoyaYUPdCsEwmKvJPkHx5FV92tNKQcfoJ1b2-038PxCarj8YxA>
    <xmx:BQo0aqPdsZjt29cUEcHwMqh4JzJpJe6u-2M4IGTFrXJSEYMn6mSCyQ>
    <xmx:BQo0anCUP6GZhi0-8rhbvJ0erW7S0eyCZaWxI0W1gKkPNpJ_qm-CG204>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 11:08:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: Silas Poulson <silas@dyalog.com>,  <gitgitgadget@gmail.com>,
  <git@vger.kernel.org>
Subject: Re: [PATCH] Fix typo in MaintNotes regarding versioning scheme
In-Reply-To: <20260618114837.0_RVf%taahol@utu.fi> (Tuomas Ahola's message of
	"Thu, 18 Jun 2026 14:48:37 +0300")
References: <pull.2209.git.git.1771774770368.gitgitgadget@gmail.com>
	<882432fe-30f5-46c5-9efa-5b8a047283b6@dyalog.com>
	<xmqqfr6czmye.fsf@gitster.g> <20260618114837.0_RVf%taahol@utu.fi>
Date: Thu, 18 Jun 2026 08:08:51 -0700
Message-ID: <xmqq1pe3ubr0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tuomas Ahola <taahol@utu.fi> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>
>> Silas Poulson <silas@dyalog.com> writes:
>> 
>> > I'm aware this is a very minor change, but it would be good to not let 
>> > this fall through the cracks.
>> 
>> Thanks for noticing a typo.
>> 
>> Will update before the next issue is sent to the mailing list.  No
>> point in changing it before that.
>
> On that occasion, please consider also these fixes:

Thanks.  Will squash in.  The next issue of Maintotes will come
right after 2.55 final gets tagged, so we have a bit more time.


