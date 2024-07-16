Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0A91DFF0
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721148205; cv=none; b=Q1YQqG3Tz99l9/j6tzJyEkJ0PD2mLGoErcye4mLXayfngf3pRFGTf9gEfBkvtGe2sMECTiUBwjtzPmjL6HQfNDfJLH63PdMyijepigGBx/OO0GO+Ix4lNZs0ATy1+maFPi4T4FuZIfpolIX1wuFlh7pmgjOrJVrB2Z3tgLZBFyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721148205; c=relaxed/simple;
	bh=/AeHEUwWusigrtK69n+awY2S1JjCaADhsPvyncUmusw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1xGFHgfPrdxqt3s3Oetr1+MUGT0rTOH0TZ+A1MtqpYWk6ACrNWamtZ9yGsWaqh6A2D6/kvLpg5mL5+pR7mZKTKASbTMvL4+NHxziyy/3i2eDO/BZqeqADpXVwLWs1I5qAXYJvchwHbIFGlcLuJfHCdp4dCyoRp2mwlqsep4abM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=E/V4Jjh9; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="E/V4Jjh9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721148187; x=1721752987; i=l.s.r@web.de;
	bh=jlVzfwzZK5XISVFz2lcFuD5rpDJrSUyl+ViMybKigCY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=E/V4Jjh9nalnwQtjRPpj1aHsEBotWIDmgJfBTsCWYS2lgHw4hyv9gUtAwZheMqPk
	 F7y0eTQ6scKtiFUSUGQl3tR+K7jY+UuVdQ/ZBgJ0DrI57OuwK1m9b0b64YkU4TmsU
	 bcW8nfia1YdejevmeuSANc9JW8SXUVdOuG/fM8B4tQraR4bMAeEk/PRWa/e+0jTAI
	 21wghJ0zd5PaR7XDEg4RQpBQth2awaKfjkkVkdBQKCQu/0XNTlUWouDa83UiK4SVW
	 1L8t+h+9yeNdgtMe+9E6T4ujq8STykWhBrZTKg/OlLCdxcdQJQGLJN4WW8tEXwbn/
	 pfo7+YX5efQ0Nx5JEg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1d7i-1sN4Hy3cl6-011RNJ; Tue, 16
 Jul 2024 18:43:06 +0200
Message-ID: <824ecb8b-b786-4220-a6b4-598a818bee52@web.de>
Date: Tue, 16 Jul 2024 18:43:06 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] t-strvec: use test_msg()
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <35b0ba6b-d485-44f2-a19f-3ce816f8b435@web.de>
 <983be396-f47c-4573-8c33-af8367f8ddbe@web.de>
 <20240709113201.GA994226@coredump.intra.peff.net>
 <442b692d-a51b-4f45-a131-a44ac08c431b@web.de>
 <20240716014330.GA639947@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20240716014330.GA639947@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KuZFEaGDxiqeNts7YgbFDOLqWbdPKmN4Yzazi0mGBlFNKoLJy2f
 kjz5ZoVpt5diUAtYn+IzKV8eeH+Ov8dpuilAs66/ZBqwocFrZ62oBQ51HVh3207M7QZdUYn
 BMP0ZwXEQRmIcCE7PEgXQyMZ+zdRhHY0j2f+YFrzHjvATVF1P02mpoqxI74niAT4AWryIfK
 GEtzE4eR4vppkcCy4IG0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:f9hzoVLgh0c=;bjZ/l9lca8WnhpCn3v7JexeGZJb
 VjgHQRHPkw+Oz5hg9i7MOMdVJyIyooau0ybfQBJJ8IfMxLvRw98B5YsHkquVQFdOMBt4TVRUL
 q0YCO2Ql9cL4Sb3vsQ70Y1LVLDoE79QoWE0xszra2WDkYg3bZYkXjlAmuN+5NSOLaLw0urlDD
 gIIzEN4NU1ASbTgFofoPmErdqjryEXw4lZiHidGxHljcr0HpjM1W4jhCRqg6PkMVtlOPHBMVo
 BtP43zHgCIHxTt9D6clVmw3qfK7yi/kRHby6F4akiIzm6RW1L9GbDycRSmZ/41+tIV3bLfTgq
 jSXRaPlmg2kcqPgrqe1mY2y/cdofpDhXALFHmpgvnsk+p0KND/4O48PHVkAZVZRGETbtgPYKD
 0j7JjdPVnIA0C7u+GccvOn9/v1+pAlkbMf9TAWE6jc6b5QuyFGTu21xbmLVaM0SbzC28EA5GM
 EzIDK1bAym97aUSIaBCY5qaR0JtSdgtzMqowaMRrzoFZFoTqfHWHOP2lXQBHTqhdJfvXdtTTP
 lzBs3dhlQIibiMZjvRT8qGWFHwLBGFsx/8Y8qLieBaKglxGDD//izqCBcdYijuxAl8eot7q2b
 SX8w39CvjUmKhCDbaThjBgT2iJKhEmNyyJGjUJ7cJVcu5l7eSCgEyUJqdwO+kSiU6CBUf9QKX
 JbgtE+1cZKvdHBSM49/dJwPUePa87/EQLK2XtDvM3S+JKUkiStsXDWd9fG2BtITWrTnTNFPeH
 W3fCCpcUjOS46ScusTYl2IQLd4F3OPO8JvITc6PNzLAFNeP7TtYgmLIoS2B3j3t0gbYA5B5kC
 AQcr0S/FoNq25BXhYyA8tClg==

Am 16.07.24 um 03:43 schrieb Jeff King:
> On Sun, Jul 14, 2024 at 12:17:09PM +0200, Ren=C3=A9 Scharfe wrote:
>
>>> Should we be using check_str_loc() in the post-image?
>>
>> Yes, and check_uint_loc() and check_pointer_eq_loc() as well.  Which
>> would be a pain.  Or we drag everything into the macro check_strvec and
>> get the caller's line number for free.
>
> Is it that big of a pain? It's mostly just passing "loc" along to the
> relative functions.

That part is bearable.  The pain comes from the need to pass in
arguments multiple times, for the stringified check description, as part
of the check result and as separate values.

It could be mitigated by adding a new macro that takes loc, a, op,
and b, perhaps called CHECK_UINT_LOC.  That additional evaluation step
doesn't work nicely with arguments that are themselves macros, though,
like NULL for string or pointer checks, as those will be expanded,
changing the message.

> Are the unit tests themselves multi-threaded within a single program?

No, and check_pointer_eq, check_int, check_uint, and check_char use
shared global variables to store temporary values (comments rightly
warn that "this is not thread safe").

> I'd think not. In which case, I kind of wonder if a simpler pattern
> would be to just set a global "location" variable (probably as a stack
> of strings) that all of the individual check functions used. And then we
> could set it once at the top-level of the test which wants its location
> reported, and any helper functions that get called in the middle would
> not have to care. And existing check_foo() functions could use the
> current file/line location if the stack is empty (so code that isn't
> using helper functions can remain unaffected).

That doesn't sound simpler to me, quite the opposite actually.  To the
point that I don't dare to ask for a demo. o_O

Or perhaps I need to revisit it when I'm no longer tired and hungry.

Ren=C3=A9

