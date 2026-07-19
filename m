Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089DE24C06A
	for <git@vger.kernel.org>; Sun, 19 Jul 2026 05:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784440561; cv=none; b=fJwsNKcrz3mK3jcR0I59SLHDwsRuEN5PNYchWK0nNW5cyf0g3Nsn4ReHLLkq6Wj4k60fhPYoEqvQY4wDmUzd3yi68BxoNLja97PVhozSJC0DIOXvtsj8dxZN6GdyF9DwQstmxkmsiwvxNMKZYMcf1FnyAfJDXipAKQ5mUYD8LIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784440561; c=relaxed/simple;
	bh=uRpOeMIvP2QonGTy8Ve49gXfw5+XsR9457RFLO+AAek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jye5DrQMMcPlJ0q1kiOgkxiiup5rf8XtxnMUu6Sao+rsAI0Ro79IqQJ9ccyqUYR7A5GtWx3w+auCcNoaC1YKVXBOuXy5wLSXQL+UKMAGwugOWOt0mq1G7xlhDvzqLrnEhk89dZ8lw72HgC33fKQukj2ePj1Cwim6vtYGxr0xn9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Umfe2/sQ; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Umfe2/sQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784440549; x=1785045349; i=l.s.r@web.de;
	bh=exYKTAycmECA5IP5mSnJs4d/eJUPWoY1hhccv/ugE2U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Umfe2/sQSanzM1K8HjiN0F2mJVZMbRyrHc07x7SvLybLbAhVkvVgHShhwIMcwamQ
	 Sf8NL8Rz/01f7N0YCh12XqYnAl6qokv3KjIsuQYM9V5g6Xo1mLDUIehpeDl3HQ62Z
	 Ikyf7oK590MI8fkEdHYx1d91BQIRFfMiZBmaAneC3p5SCHc6rAhFGsaMDVo+N4dUi
	 5Mu+A4FEigNY3nYCj79BgSJFNNHW5otGkyXiHtMOAjndMoRgiLgDQS2lRju0KfHyL
	 QuU9I8pWc3Ze8lmEDN1llU8S+e8AHxFikxPcPxKZCCN0j3cazMj6VLESOuScm5Yis
	 BXzsOXxGI2ZbBJFC3w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsrhK-1x0nzJ0FEe-010AQ6; Sun, 19
 Jul 2026 07:55:49 +0200
Message-ID: <20acbbc9-67e0-4b9e-9e4c-9f5dbebccc58@web.de>
Date: Sun, 19 Jul 2026 07:55:48 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] branch: report kind of checkout when rejecting delete
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, Toon Claes <toon@iotcl.com>,
 Patrick Steinhardt <ps@pks.im>, Git List <git@vger.kernel.org>,
 stsp <stsp2@yandex.ru>
References: <9865fc6b-e3fe-4614-9ffe-71af776e1796@web.de>
 <xmqqjyqsqk1a.fsf@gitster.g> <c7357faf-3d2b-46c6-99e7-88d3e2c72a77@web.de>
 <xmqqa4roq7a8.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqa4roq7a8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jUL3lrRK0yxShnRR4kvz1JBGB0MDl6jbwCF8CGB6fp5EN7JY6qa
 IofcqaEiNKD9dHsLaC1NK1BaXPhxzri9LvgvJrX8BfY+O/qwv2Svu+tPrIXfegJwGPLaZgE
 ae3ak7Tx2sJ9wbyw8uH1OGzM4PPQawV3CvedXKltB25fmPp8la1GI1ubqnzteSa1nYcIFx8
 d7H5g624j7I1RdpkZTA0Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Tz0j/WaPv7c=;kJ7RyeWscsJelpmi2JF8PMb185p
 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
 DKwO4fAYDyjeI8ozTmOeo

On 7/19/26 12:09 AM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>>>> +				int kind =3D branch_checkout_kind(name);
>>>
>>> Not "enum branch_checkout_kind" but "int"?
>>
>> Yes, it doesn't matter for the switch and is easier to print.
>=20
> I do not understand the "print" part.  I was probably in the last
> group of people who was forced to switch from CPP macros to enum
> and their argument was always "'print kind' in GDB gives symbolic
> output".  As "enum" is an glorified "int", wouldn't=20
>=20
> 	int i_kind;
> 	enum branch_checkout_kind e_kind;
> 	BUG(_("we did not expect %d %d"), e_kind, i_kind);
>=20
> do just what we expect?

True, integer promotion makes this work regardless of the underlying
type of the enum.  It was easier for me to make that conversion
explicit than to remember the conversion rule.  Which isn't that
complicated, though, admittedly.

Ren=C3=A9

