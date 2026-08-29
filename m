Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C686208D0
	for <git@vger.kernel.org>; Sat, 29 Aug 2026 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788026673; cv=none; b=QTMJPSf3wOjRIqIWZqOGBLv8tEQC7aZwngr+3dWqGZtRpQu/GEkmFiFVMstsL44ItDwYdRsEig+FVBgOsbeUlIGy0VOpA07VTBLWZbh+nVDqN99WM5NbQG1NKHCWwWQxrqCLS0Cw1Xu3Dyfn5+S/p4S5QSOmzlQl3aRsym6uaUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788026673; c=relaxed/simple;
	bh=JljD0poqEny/T3jS8DrBLhGPiBOyp/hU/WoGhRliL5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t3FOywOfolq0RSKcnL8K815RXovB8ODUKRUcwoCeqiZoCdpJkd8ApX8ZTyxr68irV8UhUqb7CvGDCMEU3wTAQGV56tgpkhWgQPnguTxB2XnJC/3hKcq2ShvBRUIrnYs2q/njgT/N7Yum0ymBMEMpklbGR3dua0al8n+qQv/yu/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=msNSn8k3; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="msNSn8k3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1788026662; x=1788631462; i=l.s.r@web.de;
	bh=g6yoZ/AwndxUyyTD0VMmMc7iuY3LDpSRjzI+wXKcuIg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=msNSn8k3InlajeX5niklrelN6LELu998I6tBUk8pbVjl+3ppirityceybU8f4R1i
	 BhIy0+i71J988fWi7hVVjTnrm/zebwhaMN+3WcivAHvsmX3bCsfKK4+rgrk4JUTFW
	 eUfmewAF55fMXpWfIX8eYA6e7bi7xMRmymsWDKzrd07p9gW6wr9q/HeeXXU9rxM3+
	 RR2KzPiQWpfQo9SCpFXM6wTbALUh/kzYVxTz6s565hd0YKA+dE9oUqxckU4AQl/rl
	 2o9ktYEnYDE85CConCHSFRrTgDlNCKpbGXbxgw5joKBGkva/pmlDy/kjWHo9u8mPq
	 SCkNjQTO6/Ws3jfSkA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqqTb-1wVSRL00yf-00avQm; Sat, 29
 Aug 2026 20:04:22 +0200
Message-ID: <5d5b1f26-192f-457d-bc18-499a3d7507fa@web.de>
Date: Sat, 29 Aug 2026 20:04:21 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] die_for_incompatible_opts(): accept more than four
 options
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <20260826233152.1703497-1-gitster@pobox.com>
 <20260826233152.1703497-3-gitster@pobox.com>
 <20260827045515.GA176544@coredump.intra.peff.net>
 <xmqqv78vbphh.fsf@gitster.g> <20260829111418.GA40814@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20260829111418.GA40814@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jY3lgv1V1T/IWMxvUhMxWDJFssfvUhYPYyJ96XJtTdvSJIB6Lb5
 brRkEzRm7c/HO95UyVsC6e0Z2b5Fs40b7RxJwHKuMVkWv84i1v6vJLepoZinaVBYyGtvSUf
 g2QM271KisGMDqGUOeY6e+D2tSUielubO5yPKFfK2NhIdhWDiCULVp+8CTGktSa6hD8yqo4
 yIkmFNniUNl4xqmnjo0Yg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:umRipBil8fg=;nQtKtGmvlXT/nPDb27yBpkG7mnt
 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
 xG5GLcZ5KgAUsTOwdP1s=

On 8/29/26 1:14 PM, Jeff King wrote:
> On Thu, Aug 27, 2026 at 07:35:38AM -0700, Junio C Hamano wrote:
>=20
>>> So that makes sense. Of course the follow-on question is whether any
>>> callers actually want to pass more than 4 options. I don't see any
>>> patches adding new calls.
>>
>> There isn't.  While I was writing [*], I wondered if the two calls
>> next to each other for opt3 and opt4 want to be combined to opt7.
>=20
> OK. I wonder if we're approaching churn here, but I don't have a strong
> feeling.
>=20
>> I think I can do without [1/2], by the way.
>>
>>  - die_for_incompatible_optN() (2 <=3D N <=3D 4) will keep accepting N
>>    pairs of <int, const char *>
>>
>>  - die_for_incompatible_opts() will take pairs of <int, const char *>,
>>    expects "int" to be 0 (not set), 1 (set), or EOF=3D=3D-1 (sentinel).
>>
>>  - static inline void die_for_incompatible_opt2() emulation layer
>>    will call die_for_incompatible_opts(!!opt1, opt1_name, !!opt2,
>>    opt2_name, EOF).  Similarly for opt3() and opt4() variants.
>=20
> Yeah, but then you can't get good compiler support, since I don't think
> there is an integer equivalent to LAST_ARG_MUST_BE_NULL. So the varargs
> interface feels less safe (and strictly worse since we are not actually
> helping any case that has more than 4 items).

You can still use LAST_ARG_MUST_BE_NULL if you require EOF _and_ NULL.
Looks silly, but could be papered over with a macro:

#define die_for_incompatible_opts(...) \
	die_for_incompatible_opts_internal(__VA_ARGS__, EOF, NULL)

With such a macro you don't really need LAST_ARG_MUST_BE_NULL anymore,
though, as it already guarantees termination by construction -- as long
as the internal function is never called directly.

It's still less safe because it only checks the types of its first two
arguments.  On one hand this might suffice, because the rest of the
arguments just need to continue the pattern.  On the other hand it's
error-handling code, which tends to be tested less, so a broken
pattern might be overlooked.

Here's a type-safe variant, but it looks a bit odd with all those
mustaches:

struct used_option {
	const char *name;
	bool used;
};

#define DIE_FOR_INCOMPATIBLE_OPTS(...) \
	die_for_incompatible_opts((struct used_option []){ \
		__VA_ARGS__, \
		{ NULL } \
	})

void die_for_incompatible_opts(const struct used_option *);
=09
static inline void die_for_incompatible_opt4(int opt1, const char *opt1_na=
me,
					     int opt2, const char *opt2_name,
					     int opt3, const char *opt3_name,
					     int opt4, const char *opt4_name)
{
	DIE_FOR_INCOMPATIBLE_OPTS({ opt1_name, opt1 },
				  { opt2_name, opt2 },
				  { opt3_name, opt3 },
				  { opt4_name, opt4 });
}


Ren=C3=A9

