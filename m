Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4252F21A0C
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 19:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719256552; cv=none; b=tSCBxJRFp3xDzfIHH4dapHNyZu0G8uQ1RSZ3auGER1cBzAKvRfp5u4HIrJL6UtYT8p0grdY2tqVz2CQ/Oer/i4ldr1gIe0ZQOU3qM614EzyTleMSmYThxr12nYchjm1+5e3fnXXqWFbe82GN/cUypt6dVZPX5EzmQJvqKYXE7kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719256552; c=relaxed/simple;
	bh=RbEpD3vp/751J7Fpmau+Nz3WsNDRxAbim46HSIiwXus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9aeHD+PLUBMluqdMDu0YZPppNVzeny8DB1ftJlLgptjRO5oLWA0n6CxlGAA4o266n7DbYIXlV3iHkdUYXwuTMilJqK6AnDVrJCR+HuOT5c5YlqHrUpCT9jWbdKUxYu+o6nxWH3WxdSD7aupdVaJUBrhJI9Xvdv3r86GgieZ4NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=odaR3BdX; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="odaR3BdX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719256543; x=1719861343; i=l.s.r@web.de;
	bh=6Tp1Roxgq1b6RZ5cWTWu9/VXrPkQLZY1qD75plcHVdc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=odaR3BdXHvzKnY8MkjR4uX0vnMKs0U7xBnIOJEfiAv+RBAKNU04sWqtaqTugs1nu
	 XaZQskzs/ngcSPwtn9hxbfOksxt/TgmCX1IoutNYRgEbhZAaYNeblBX3Tlbz7oP/G
	 /2a9S9jMT7XPvZB73OonlfJsyHE5NIq7+4XMci/d4UQgtNjvIlQrVeo/yVU3KqyPg
	 wZoiqDlaoAmRSn/qxxhu7+BI5yHHc0Qe5PyqSPjPBCP0RPauIvMbClnNw2Q6rxRyf
	 YL3e27LWobnXwVhDbvC9rRfJ6K7CZP04qmwIK13nQeX7jTDM1e55p8Xj9gfV4LY0B
	 TbCYy0G+cNXm1oOytQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3oyy-1sUS23367k-00u1Jb; Mon, 24
 Jun 2024 21:15:43 +0200
Message-ID: <48948980-ac98-452a-b2df-11cd81de56da@web.de>
Date: Mon, 24 Jun 2024 21:15:43 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] diff: allow --color-moved with --no-ext-diff
To: Junio C Hamano <gitster@pobox.com>
Cc: lolligerhans@gmx.de, git@vger.kernel.org
References: <trinity-acbdb8fc-3dc3-4dca-890c-8bcb37405782-1719050465639@msvc-mesg-gmx004>
 <8a8bd51e-9ce5-4a68-bfbe-f16dcbb7e89c@web.de> <xmqqsex2cnwk.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqsex2cnwk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6XnBgU9aaDY7fvDkdZiHE8ShyM3eYi4Xt/1RdaJdZFmMu6P7bQZ
 WPrciRWX/qiULzxQ7xsY36Rs/vs2jOJmwBSY81HK6igBHU+E9tWpvwh5bxM2tOa/TNkqzsc
 SJegJhgjBX1tPFzNnIzwZPyDewoPlTixlyBAmQsSgFWsHCwN/4b0elTGMV23ykBG0CUnH/f
 4GfsCeeprEhTSKKPz4KrQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HMfNXdsZxwA=;2h4B90R4HBdyFLB1qdXCDLGAs+s
 ojKDUeYzZoXz+wHX3rwkGQPR7JkWLXcacol2TPOV1GxRKVZFe2/Py3LiY7LbxiEh/ZNvV+CHj
 Hyq7wKjW9ilDELleyUWXfCTLn/3lfjwphVKRFJorKNwTrppmMS9PkBijV3C/dKnpLsnAbftsW
 vzRNlTR53IekJIlgtQEN2zqPQwqJYtxZDsUjubmE9zRM2Ox58BQhzTe4lNea69Cazenq06ZK+
 ZhuIhVNe/ezDf5S83NabWSutmAj7ZYsrvRHAwFD07DLRW91KOIGkLYbDNAk+hA8O4r/sfTzdU
 J2eJC5QeqKJ+x8Ui/gP/tLNz4Yu+RcIe1QW+V2kVXWXfjKJKuluLLvellZtV14SCg1tVXJAof
 hGxj8eNlfZkPgyxIgeIZMG77+p0+xTqulmLVituuRzsTP0vtuc8g8K/2O8veCaOnHdDx5liYo
 JtP11KawAI+JOiLQdmt5QRZSnz7tqSQubrFPs+J72EBQ5Z3leFX8vuVfz61HHEvKMfVuxDey4
 zMqj1BEQrocUhfYKjJnEpz6fHWF/r/MqgK2DsEYTIOlYRc4+dPsoN7J+COtWc24uhSq3/tp5Q
 Ase0pKzsKCgzciGDYrRvsCba1JUL9nqV4GQDQ5hUG2K2lPPj3N53+6/LWZ+3LJuWWvYrX7tCW
 84fYAytxUyW0FEZsBwnV3UxfChQThSa8X/xbkRXxdvU/8ELM+y/WmMWl3chgBl+9+Uudx1NkI
 2ViawXhQZqn9MBGikqL0ljEjksxaZi0G+aKOGIPH835HyJPCILB61pAvm0xeRM0IUBH+vGa3R
 newVqrLWVkBR7oCCfKF9RSxeDq9HtaGnVEWQeChQOM7ZE=

Am 24.06.24 um 18:21 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
>> index b443626afd..a1478680b6 100755
>> --- a/t/t4015-diff-whitespace.sh
>> +++ b/t/t4015-diff-whitespace.sh
>> @@ -1184,6 +1184,15 @@ test_expect_success 'detect moved code, complete=
 file' '
>>  	test_cmp expected actual
>>  '
>>
>> +test_expect_success '--color-moved with --no-ext-diff' '
>> +	test_config color.diff.oldMoved "normal red" &&
>> +	test_config color.diff.newMoved "normal green" &&
>
> We are making sure we won't be affected by previous tests.  We
> assume that we did not set color.diff.{old,new} to these two colors,
> but that would be an OK assumption to make.

The previous test also uses test_config to set these values, which means
they get cleared at its end.  We need to set them again to reuse the
actual.raw file.

>> +	cp actual.raw expect &&
>
> But then this introduces a dependence to an earlier _specific_ test,
> the one that created this version (among three) of actual.raw;>
> If we did this instead
>
> 	git diff --color --color-moved=3Dzebra --no-renames HEAD >expect &&
>
> it would make this a lot more self-contained.

Oh, yes, good idea!  We'd still rely on there being staged differences
that include moved lines,

>> +	git -c diff.external=3Dfalse diff HEAD --no-ext-diff \
>> +		--color-moved=3Dzebra --color --no-renames >actual &&
>
> Also, please do stick to the normal CLI ocnvention, dashed options
> come before the revs, i.e.
>
> 	git -c diff.external=3Dfalse diff --no-ext-diff --color \
> 		--color-moved=3Dzebra --no-renames HEAD >actual &&
>
> Our tests shouldn't be setting a wrong example.

I mimicked the style of the previous test to hint that we do the same
here, just with the diff.external/--no-ext-diff noop on top.  Not close
enough, perhaps, but also hard to spot with 40+ lines between them.

Ren=C3=A9

