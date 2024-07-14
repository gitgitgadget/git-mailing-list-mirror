Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FF72C9D
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720952245; cv=none; b=esX9zP/F9r3tQtvMkHdvywT2GLgvT76RPzizlcV9XDaC863Cv9sk+HDmd1dCSxcYWcA5UYFd7Ua7R1KYDegolLIR3TdCF305vSAA+73s957Zg9yQC5TPmxPfhzrTKkjMX2D1z7lLdGvYoJ8aPRKuQvBdji+qEzbYMMcrgvxgNzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720952245; c=relaxed/simple;
	bh=hbCD0KXynFZ+BBiANAujVJJWhQQIPPOklVM3Gd428KA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kD9BR0K52/BQvFjxepdXrBYzhDSDT//gI26VOXu3y0zjsp+nFUvfO1tz4m4B3f+Y7pEFM9GHGlscGWO4W69MUsDkE0wtNWpJB3MOAYjZ8EKpdT8qM5YSbK/CaDMvBp/o/05Qe/PkZFTlgdZqDMGQh25nsodzqJk2t0kqz04ONbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=XNvlKDY+; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="XNvlKDY+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720952230; x=1721557030; i=l.s.r@web.de;
	bh=2gqdWVRKXGSYsluRh2G2i38T+rf27Mmu8TwheiZmaE8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XNvlKDY+he6yy6Z390vsrN9d01NqZKZf3fGj3Onh2rPcyeKQq4qUcOAD5r5bCOPG
	 cLPsmvtlJQq+gRzllEmaflfOd341Hpr5e9cC0nht70oOUfm3xgs1eutv2IrTIhcV0
	 TTd+/5aR8cAZYnhak9YomiWu5Yu1MsbPfQu/5VwXTS809tJV1jOdwuUre28IqoJr9
	 NmMEXTW2g2y+PI0UNMag5a+ZpgghCDnEZSwjSLWTE0MYbpiIZLccUHrVvwkiqFNTY
	 f4SHqt2Pb11n2fLAsPPuVZV0Mht6rTYovPo6Bq/FcEkBcq060yNCWEu24A0U8CuU3
	 q9YfJAVrhiXPCCTIug==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4bUg-1sTUFn43L4-0000Sj; Sun, 14
 Jul 2024 12:17:10 +0200
Message-ID: <442b692d-a51b-4f45-a131-a44ac08c431b@web.de>
Date: Sun, 14 Jul 2024 12:17:09 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH v2] t-strvec: use test_msg()
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <35b0ba6b-d485-44f2-a19f-3ce816f8b435@web.de>
 <983be396-f47c-4573-8c33-af8367f8ddbe@web.de>
 <20240709113201.GA994226@coredump.intra.peff.net>
Content-Language: en-US
In-Reply-To: <20240709113201.GA994226@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jj83k2q7m0R1oTUOH8/N9yC2jy6uS830EX67S9/f37DryMrhOxA
 R8pDrTNlSieLoEBg9/BrYB9vF6SmO36M2uG++B2qRl0EOyQbISh0XTH0F5a8+T4ZpJzLQ+R
 shQlwn17TKYMfsx3u4wucQOoJYZK2ToyzsTiZdUDhlvQtM3Ll+WcmeKK/9BXDMUTiGpPpfy
 WyxeQKg/MMUMSxl8bkVRA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JvFgvqSHp9Q=;c8NPefQnj8lmYYh002y/ueDS51E
 7HzsNZa3NFhMCKBSkwiEYbvdPP0gB+EsF+z/e1uKe8VbItzizchHDllSnctOU77uPHWkjTZac
 EulknQhjfdBXXG9hsQRVFjxWEpw9O3+bu7Aa5XijTBm7qB/iIOplFBINzFkUSNWyx2jlmPSyD
 MsqNgzNEPjbnFNj8CD+LL4HNz4GahzADwoSpFyDGAjj9BE6qmAMSUzNh/zG8UTGxBs3S1bYAO
 x8aU4oDMTIJnORiI6NycJcaWW07o0DXjw1ByB/pcB/ULl9vRDbZxUGRrFXfIyHHQIhfnGV3n7
 Vk+xZ6V7RyV3lop8eD+WQM80dWikNsmzRKSTYW7Ya8ySaC2JapcPZWsbreFeyxACch5/mn6k2
 Ei9Vx7uRh0HoVNlrDDektXbH4N5h1ftLWf0k6daJOCMnzURgvVeGMIkDEe+cgSNC7qo6vfxV+
 VNyhWNIGnz45SEmyek3nmU3xRv5lVXgSiN2YVCZxA19bgpmgW5vOFsi5LMiiUsAhl2TGlVB5n
 OOi8pksSxypNuoOkXXtsNhQvVzxTzkY4zVOLj5AvD4Ofp3lzZ7Ka29lXNXgCWZshOFduMiT3m
 7z8pTIWniFtMcWD/LfdW9pD7flK+ijCo9pqmRBWh3IM6dMaKYNqXp0O0QnY+OTt7vrWXbJrh4
 hA21WbRORtX/mXQxgP5G6L0WOZVVygaRPTXCqfxZnCfRqPYzQysG2A8iefhqa+RJFDZvLKxxi
 IlqcUw631hCgGdAV4aDbu/mXPui5Pu7Wwn4RFI8bPvSLg9UbwyG79505J4XgYAKMTGjG8oODa
 MWD6PAUdQVrOFZUi7u+0gk6g==

Am 09.07.24 um 13:32 schrieb Jeff King:
> On Fri, Jul 05, 2024 at 07:03:36PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> diff --git a/t/unit-tests/t-strvec.c b/t/unit-tests/t-strvec.c
>> index d4615ab06d..236203af61 100644
>> --- a/t/unit-tests/t-strvec.c
>> +++ b/t/unit-tests/t-strvec.c
>> @@ -17,12 +17,12 @@ static void check_strvec_loc(const char *loc, struc=
t strvec *vec, ...)
>>  			break;
>>
>>  		if (!check_uint(vec->nr, >, nr) ||
>> -		    !check_uint(vec->alloc, >, nr) ||
>> -		    !check_str(vec->v[nr], str)) {
>> -			struct strbuf msg =3D STRBUF_INIT;
>> -			strbuf_addf(&msg, "strvec index %"PRIuMAX, (uintmax_t) nr);
>> -			test_assert(loc, msg.buf, 0);
>> -			strbuf_release(&msg);
>> +		    !check_uint(vec->alloc, >, nr)) {
>> +			va_end(ap);
>> +			return;
>> +		}
>> +		if (!check_str(vec->v[nr], str)) {
>> +			test_msg("     nr: %"PRIuMAX, (uintmax_t)nr);
>>  			va_end(ap);
>>  			return;
>>  		}
>
> The "loc" parameter to the function is now unused. Should it be removed,
> or is it a bug that we are no longer reporting the caller's location?

It's a bug.  If only there was a way to detect such an unused parameter
automatically.. ;->

> Should we be using check_str_loc() in the post-image?

Yes, and check_uint_loc() and check_pointer_eq_loc() as well.  Which
would be a pain.  Or we drag everything into the macro check_strvec and
get the caller's line number for free.

Ren=C3=A9
