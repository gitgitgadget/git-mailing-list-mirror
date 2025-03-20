Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065A9BA34
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 01:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742434308; cv=none; b=s4UAIypJ9AIGlbePfSGMHAID8/r2e92lqtHwxXvK64jFoJI9jm+VsOc/e5+jiMEWa4e2cpxuJVnStCHzVKySDY6PZq54jfor77OYjxTWxm0q7gf9fphKWXDbnrX73mD3nKKOdXaEq0A5UbvhVaMKKpmmKta89x3adXPg2ZjnO+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742434308; c=relaxed/simple;
	bh=5jy0fwajJbbiG7YUrktGpRpBXnKoOoCx+49DEPADEAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jFowrD6oBg7YTMJ5cHXHckyXE+HDDWpJHtQq7cbsqa4iifjo2FCDuSVT2n1EaSiIXuvU+nkT7Al+zaUx9LsUm9CYf/Q2odco8Tn7ZkwfKnHY4JIYATi30fPzHUxaMdsjFnjcY4H5NmEE6B/BzPPryXyAiX6qrM/ljV64xp1/CJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=d4YQDwM2; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="d4YQDwM2"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id v4hztxwMpbpaNv4i0tlrfk; Thu, 20 Mar 2025 01:28:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1742434114; bh=3u95huR2vrfT0v8xQ8OgfAGsUcbiubWuyI3aFInnK2E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=d4YQDwM2WvFDsZ0rAbmQxTUR1D12awA1IrDER/odPvNh5qB3p6cpKHbF5+bF0y7yb
	 hg9Ss+DR4VUL20ShP9uxXIrXxr0X5KU+yDgDSb9STCQWICz5d+Ws/hHuD84z4uRk/c
	 jstaVnd/d9Jz8G9nHRvHubvToxXFPC5ncLpNN0gZAyLtVFDo/a103BNK+4DiLhlxPf
	 lCb3ccCy8MXp0gISgBYvdRaRXOSh/n+LGIWM535qV9YTgptflXl54uscI0Z55eRPl4
	 begMR7/+jf9MWN+kXpRpcB49drEQNIBMZrVBBjOtWufEXeG2oCERGvBOC5g5+oXfV9
	 ztRWzPeN65+WA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=frZ/Z04f c=1 sm=1 tr=0 ts=67db6f42
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=8VpDeP3kAAAA:8 a=CCpqsmhAAAAA:8 a=iKrn8l-KAAAA:8
 a=KRg-NW-S1eV8qHJdAMEA:9 a=QEXdDO2ut3YA:10 a=x58pXJj3Pl9T3GLWE5Uy:22
 a=ul9cdbp4aOFLsgKbc677:22 a=vz8bQswTWcriz0i0jksL:22
X-AUTH: ramsayjones@:2500
Message-ID: <74b2838e-1d7b-4ee0-a4a7-e3d21f4e6597@ramsayjones.plus.com>
Date: Thu, 20 Mar 2025 01:28:31 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] config.mak.uname: add a note about CSPRNG_METHOD
 for Linux
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
 GIT Mailing-list <git@vger.kernel.org>, Adam Dinwoodie <git@dinwoodie.org>
References: <8c8e16ae-87a2-44bf-a87b-7422eb04fec2@ramsayjones.plus.com>
 <Z9YbJFJjtXNYnTzk@tapette.crustytoothpaste.net> <xmqqr02wbtdn.fsf@gitster.g>
 <Z9rG3JVA5vSoYynt@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <Z9rG3JVA5vSoYynt@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfA1PPWeZfuuO8jVQRzCfyiVS7svi9udX5xnR80Lxb1UBnAmWzeXjIxXbcSq9WivAV/mGxMIVOIewcPUX5QHvA/765HNH4f++US6eV79Xc3hRt05yGdQx
 pHby45AXnRmHDWAiqKFvdlFTHCZ2FBUf5p56bve9jxtXXZ5YrDmjTBv2QkoGhnnAfORrEKHGWnubn9d6piHUuvsr3j8yVii9GvI=



On 19/03/2025 13:30, Patrick Steinhardt wrote:
> On Sun, Mar 16, 2025 at 01:41:40PM -0700, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>
>>> When arc4random was added to glibc, the Linux kernel CSPRNG maintainer
>>> argued that it was not a secure approach (I disagree), and convinced the
>>> glibc maintainers to just make it a wrapper around the Linux kernel
>>> CSPRNG, which it now is.  So there's no actual benefit to calling
>>> arc4random versus getrandom, and since it's newer and less commonly
>>> available than getrandom, as well as slightly slower (because of an
>>> extra function call), getrandom should be preferred.
>>
>> This
>>
>> https://www.phoronix.com/news/GNU-Glibc-arc4random-Functions
>>
>> was the first hit of my search in the area, but I think you are
>> referring to
>>
>> https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=eaad4f9
>>
>> that happened 5 days after the thing got in and the code there tells
>> me that your summary of the situation is quite accurate.
>>
>> So I agree that dropping this patch makes sense, but do we want to
>> do a bit more to improve the situation?
>>
>> Here is an attempt to improve what we have in Makefile (and possibly
>> the Linux section in config.mak.uname, but that is improving what we
>> do not have) to tell folks that arc4random in glibc is only for
>> compatibility and they should pick getrandom() until the situation
>> changes.
>>
>> --- >8 ---
>> Subject: config/Makefile: a note on CSPRNG_METHOD choice for Linux
>>
>> arc4random() was added to glibc in July 2022, but quickly replaced
>> by a stub implementation that wraps around getrandom().  Hence there
>> is no actual benefit to calling arc4random() over getrandom() on
>> glibc based systems, at least for now.
>>
>> To avoid enticing Linux users to choose arc4random(), leave a note
>> that their arc4random() in glibc is not the same as what their
>> friends use on other platforms, and guide them to use getrandom()
>> instead in the meantime.
> 
> Makes me wonder whether we should also change the order in which Meson
> auto-detects functions. That is, do we want the following patch that
> favors getrandom over arc4random?
> 

That was my immediate thought also. :)

ATB,
Ramsay Jones


