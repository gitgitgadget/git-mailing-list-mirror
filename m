Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0010624EAA3
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 22:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751495801; cv=none; b=CK3E9/FTG2/AKR3wRXgzV2eSfCkXbEwZ3WPwnpE4DtlBZpUapMVXw7GnjDeVCvNpQNBoeN+dbRafAuSQ4y4CcOCLuc1CC5S5slFrJifD/Bt60zIjzfllbbMZVdtSWkrmoHNCvStSAQlKMFcThOTpR8LM1QjnriQweK1Q1QX16fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751495801; c=relaxed/simple;
	bh=dn8cMesrkevYZeOlKojAALmbptpJQoFNeK+dfpr1vCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NEiNY7Hl1Mdt5J0sQOIkElidBXPrRe8QNfnX/6pSe5iwdRqWhLkm05IN00hzkbBtGuu/dgvE9UZZ6dwzUEOq8MaNTYh1FFCSmj5wm9hYmitylU7kB5UfRRuKy4PK+SqH14LF/YB124u7tdKHKCsbbLfxNsuZufu38ZwLxiJ1y5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=WcJBpeC0; arc=none smtp.client-ip=212.159.14.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="WcJBpeC0"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id X615uyYC0bccrX617uWw09; Wed, 02 Jul 2025 23:33:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1751495607; bh=0uraSFsksJ/eXUvZOllxB3I4rIZUC0lAhJHXoAzsNnY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WcJBpeC04sM4cL6J2BqJoS/eHQuF8UE/aun7CfoCpoecxkye8hwJWAkS+PrYnlsKV
	 bd9zzUfkcWXYbYSTj2fAB+BAKLRanP/Rjal0q2V8XXnOXQ3mt5zrWReClQmMb+th0P
	 R98BlrsRn8fn5AMqISCCicMKQcuYqpl0Q/l2xRUX1GpWnmcjb7/Ol/slltnpqFaWvv
	 8Tx3+bGTMF5zDnRdebZSYr60Q6brL3JoZEb9L3AmBYtpwyigD/Gx1GO4ONhJYltpZP
	 yOKwBau+IU7JpIzG0hVnlbu8XXkUB5iW9X8yeAwnuZA18BDJN5zmdaFgu+8xNnjXOb
	 +NR3TWFQj8xZQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=T54vTOKQ c=1 sm=1 tr=0 ts=6865b3b7
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=9NbcCb7APlMhur2gfNEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <c8f4ae13-8578-4db3-bee3-1619f03428d4@ramsayjones.plus.com>
Date: Wed, 2 Jul 2025 23:33:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: build is broken on FreeBSD if libsysinfo is installed
To: Renato Botelho <garga@FreeBSD.org>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 GIT Mailing-list <git@vger.kernel.org>
References: <f32292e0-4c99-47d0-8eac-21dbc5aca302@FreeBSD.org>
 <9dce7213-0b8c-4636-ab37-4c26081aedf4@FreeBSD.org>
 <d3b912ca-ba5a-4b56-81d1-0e8a10055d83@ramsayjones.plus.com>
 <818958f6-7387-48f8-a0a8-c050af212069@FreeBSD.org>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <818958f6-7387-48f8-a0a8-c050af212069@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfI4vgZD2Zflq7Jd9dJ3LwxOlw3an4zG9HFT0rsQLGpvAsBn+kNZspRq2dQ/MMCDnyiDvN7mz5UsS758e5dxJpY6J3z258DBvMJb5epI1bvIRR0u8BPje
 TWZYvk/TccqDDXkTlZcSdaYWVmzpp9IPxDw3ACNYWv3KFTr3QYxsuuVqTfWJA1SDxH4JiE3sE/9/9stNGh249NA6SGPp0he8cLI=



On 02/07/2025 12:28, Renato Botelho wrote:
> On 01/07/25 17:03, Ramsay Jones wrote:
[snip]
>> The patch is below. (I didn't write a commit message ;) ).
>>
>> Does this work for you?
> 
> Your patch works just fine for FreeBSD.  I tried it with libsysinfo installed and it just ignored it, as expected.

Thank you very much for testing this, much appreciated!

> I didn't test meson build since FreeBSD ports is based on autotools yet.

OK, no problem.

> BTW, should I start moving the port to meson?  Is it the default build method now?

The git project only provides source code (i.e. the project does not
produce any binary distribution packages). So, each 'distributor' can
use whatever tools they prefer to create their packages.

[A long time ago, we had some support for producing Red Hat and Debian
packages (if my memory serves me correctly), but that didn't last long!]

If such a thing as a 'default build method' exists, then I would say that
the Makefile (without configure) is it! (Meson is the *latest* build system
used in the project, not the default).

>  Is there a plan to remove autotools?

At present there are no such plans.

ATB,
Ramsay Jones


