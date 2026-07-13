Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67FF356760
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 20:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783974538; cv=none; b=DtpfUXVVD+/IR+lofmcCINbGOygUllSWVIKg7JqsqVFailO1ACxbSnH6Ytc5ttPfLduwiB0Gn2uWzbBiwrHgPHYT73MoO8hk0bSxjx9IL9uPkn+mBbAEhkc3Rpje0EXS/x3j+pZdRzGqcD/cXPs9tP2dJ15KTjBs1g834lGTug8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783974538; c=relaxed/simple;
	bh=WyaTd6ph7Z6Fy5SiDMfYuvhExN04/8TvCsP8r8+v3BY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c2h/xKKLXZ9++QWJuetZ5QGULEPVbFHAij7hzEfyOOVfZGf0KT25Q9wqCeCVxpBcLj4vHzHTaXrMeiLezeDMTjRVrxNWj3fmd6OjDblmGlRrxZaUoWHG/rWmGo2u4m7t43zp9iwifSPpj7Sn2k00GK4kj1xw9A9yn/b6b8iHDnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=tF7IOEMo; arc=none smtp.client-ip=212.159.14.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="tF7IOEMo"
Received: from [10.0.2.15] ([195.99.11.174])
	by smtp with ESMTPA
	id jNGlwZYb49RfhjNGmwJ9YI; Mon, 13 Jul 2026 21:28:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1783974533; bh=pOqnUfhloHE4rnlrLI+lK1uMDjraBkfsCGPTxda5fgU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=tF7IOEMoXTDIQxlKX/nYeFJnkMueOxasvso5fcbuQ1JeG/89qkFCdIPSxjzGTkB0O
	 zj7R9D9lUCEX5unPxkbMKKBAaAdDJvTUzEgX12RUttsffEDCXijR6Fi/peLrtzOMnZ
	 1krEkDVzjcxTj3qJDjm+Z1p4//AUvaQnYgZhz7mgp7kjTtbKiAuN7dOzQYjAJkUFDZ
	 qpckuNJYfNe38Za+d6pkePwtKpfvZQ7aV5wxYVpwJ+tiC5k9oMK1Zf48gJGx6yQIdr
	 IaxmrjjzqBTt8kqXEpjjQNcEjz1eBz8wpCRHHF6IAdd4gQR23ftUFXzutPddsdHYtw
	 d/X1Xn9L93URA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=S5R6w5sP c=1 sm=1 tr=0 ts=6a554a85
 a=rWEfxJwGD0TuYe46u5FB7A==:117 a=rWEfxJwGD0TuYe46u5FB7A==:17
 a=IkcTkHD0fZMA:10 a=N476XJ2OcQ-mrgMozTYA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <910f130f-ea0b-4086-a43f-3842b0df0fce@ramsayjones.plus.com>
Date: Mon, 13 Jul 2026 21:28:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cygwin v2.55.0 test failures
To: Patrick Steinhardt <ps@pks.im>
Cc: GIT Mailing-list <git@vger.kernel.org>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
 Adam Dinwoodie <git@dinwoodie.org>, =?UTF-8?Q?Torsten_B=C3=B6gershausen?=
 <tboegi@web.de>
References: <f65466c9-bede-472e-ad57-e72a5289be27@ramsayjones.plus.com>
 <alTGqS2_RmfGHvfV@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <alTGqS2_RmfGHvfV@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFpUD4bK5hGZmjFzrf0xscPync0/CftGf5eLkezD90NKUp9a/+eea1+NcpRduDJgcCT8IHQCaeX01Fx6S5IUW3OaeIqVOoeNKO9iem4iJj6Vb7JwlRfy
 /gyRwy3HqHtcLEer0snxvDr9Wt0Eowm3bbzJh8mBTy3FjxMLJTC20TPuN8bPxS1vfbh15Gju+K+jQWa0VP7J92n4E6sEehEMg/M=



On 13/07/2026 12:06 pm, Patrick Steinhardt wrote:
> On Fri, Jul 10, 2026 at 07:32:23PM +0100, Ramsay Jones wrote:
> [snip]
[snip]
> 
> By the way: I was pondering multiple times over whether or not we should
> add Cygwin to our CI matrix. It seems to be sufficiently different from
> both MSYS2 and native Win32 to have its own set of compatibility issues,
> so that could be worth it?

Hmm, I don't know. It is a distinct platform with its own set of peculiar
issues. So, it may be worth it. However, I wouldn't want to expend CI
resources on a platform which has an unknown user-base. How many cygwin
users are there? (it can sometimes feel like there are very many, sometimes
maybe just a handful!). ;)


> For the record: I don't really have much of an opinion on this given
> that I tend to not use Windows, except when I (once again) break some
> tests there. Especially the path handling si something that tends to
> cause lots of confusion on my side.

You are not alone!

ATB,
Ramsay Jones


