Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3823130497
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711556443; cv=none; b=isKd0fQ91AcQvxfaiYdteHt4zKUYlpW6aKu9QnW5Xv2+zcAEogwFQGqukeGH57ehLSotJgKnW89xBBhj/gs2RECXxWwUAD3prglnhD9b6bC2YvRQLuqTu7Llsp1x7/fmn10k70gvKcw22MkIvHW+noRE+0jDd+21JLgBI7RoY4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711556443; c=relaxed/simple;
	bh=KKVqSoY0oU3Tfji0JWtbiwgheigXSd7q65OVK9ZsueA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=UwWnFdmmCbZbz4VEYGTjqPulyeYMEDaoJ50FDBvXhxUpbSkF98Mv4rpbcYH3e1Dbo/V67Flir8L2InQyjiqrHy1MNat7lx95CH5P5ER+1d6lq0JvdsyTa+g1vmNuL14Z0Z5LzHVjO4SsH1unzhoA4sZ1Aeo5RUUXm1mwaLWDvok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=SyCw3GFy; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="SyCw3GFy"
Received: from [IPv6:::1] (2a02-8440-3309-f888-694a-b4fa-82bb-551a.rev.sfr.net [IPv6:2a02:8440:3309:f888:694a:b4fa:82bb:551a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id A4AD66039B;
	Wed, 27 Mar 2024 17:20:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1711556430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KKVqSoY0oU3Tfji0JWtbiwgheigXSd7q65OVK9ZsueA=;
	b=SyCw3GFygaHNbFjywrFbKBH0OAofa7eyPVS26xvZGkdZvDKpw9cBeQTREqn9hQ/06pbdm/
	JEOROBssYdhaPYJrB5xz3CbtIQ0m5LOmRcvZV64B0Qdq0wx5vhUkHVXJvYVplzjchakNAU
	oU0WK0D7RBjthdqIUQO1yB7sQHu9IfkwS2LzerIoP+jYKuQUhqlUQ67NtoX+r5WaYWGo11
	7B/jbQMRarqxzTJACrsKYZQ3ENIDNF9cOrbIPoLeIxF0QFU9zn4uFDqYsLv4fSpRk1HsdX
	o2+Uc0Q/Q8gGCpyPv4ayDWX7DCtBsXDijms3fYpqTYf30TvK2fc3ObCDEVFzjw==
Date: Wed, 27 Mar 2024 17:20:27 +0100
From: Max Gautier <mg@max.gautier.name>
To: phillip.wood@dunelm.org.uk, Phillip Wood <phillip.wood123@gmail.com>
CC: git@vger.kernel.org, =?ISO-8859-1?Q?L=E9na=EFc_Huard?= <lenaic@lhuard.fr>,
 Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/6] maintenance: cleanup $XDG_CONFIG_HOME/systemd/user
User-Agent: K-9 Mail for Android
In-Reply-To: <cd7bc865-4a01-46f6-8d68-24f02fdabcb9@gmail.com>
References: <20240322221327.12204-1-mg@max.gautier.name> <20240322221327.12204-5-mg@max.gautier.name> <Zf636bsHs9woXRAS@framework> <1cce271f-c3df-432b-94ff-bf7b11c6924d@gmail.com> <ZgE3mHsPfKbuQLQP@framework> <cd7bc865-4a01-46f6-8d68-24f02fdabcb9@gmail.com>
Message-ID: <9426FFE4-09FE-4918-92A7-DE22648962D0@max.gautier.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 25 mars 2024 17:39:23 GMT+01:00, Phillip Wood <phillip=2Ewood123@gmail=
=2Ecom> a =C3=A9crit=C2=A0:
>Hi Max
>
>On 25/03/2024 08:36, Max Gautier wrote:
>> On Sun, Mar 24, 2024 at 03:45:45PM +0000, Phillip Wood wrote:
>>> Hi Max
>>>=20
>>> On 23/03/2024 11:07, Max Gautier wrote:
>>>> On Fri, Mar 22, 2024 at 11:11:09PM +0100, Max Gautier wrote:
>>>>> +/*
>>>>> + * TODO: in the future (~2026 ?) remove this cleanup code
>>>>> + */
>>>=20
>>> That is rather optimistic - users only run "git maintenance start" onc=
e so
>>> any unit files that have been written in the past will exist well beyo=
nd
>>> 2026=2E
>>=20
>> In that case, should we hook the cleanup (in it's final form) in more
>> place ? `git maintenance register` for instance ?
>
>I'm not sure if that is needed if we leave the code to delete the unit fi=
les in place=2E
>
>Best Wishes

But don't we want to remove it, eventually ?

--=20
Max Gautier
