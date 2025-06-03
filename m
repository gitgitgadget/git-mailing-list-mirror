Received: from mail.comstyle.com (speedy.comstyle.com [206.51.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7AF8821
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 03:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.51.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748923000; cv=none; b=FW+QpWGu4jWgEFrKmmHCibvbt1zPG6024Px7OQnoceCy0XiQnIa1t7PZkWKri20guCXiqhXtIHUOLFRXRZYlfd94MMA9D/GS7bAOChhN37JGxGTV2AtEEfgSPHd0RqcbNsqaL3fWJmWtt2gbyN4hj9z3ZslLmtMFL6ph7UE4VQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748923000; c=relaxed/simple;
	bh=jXHJaXOTfls6DetyyT7EH5Ou1sm3owk43fl2xg/EgyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ctd+3nVuO7Or2AkH4ttjk1Drgb1TS6frBmCqu+zodxpKAPMqyB2Ruq7Jneh5cBclJlHj1wKQ359iOiYAdzi3kZWAfwX/Dsr6xnRmxojzRVXUEr5xEakkJhF0em29szfMWPf2tyghRJZ/U6qT3IVveJ3P0fQdioy0b4cDsM7FZGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com; spf=pass smtp.mailfrom=comstyle.com; dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b=HedE+Pss; arc=none smtp.client-ip=206.51.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comstyle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="HedE+Pss"
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id 4bBH2R2YdYz8PbP;
	Mon,  2 Jun 2025 23:56:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=default;
	 bh=jXHJaXOTfls6DetyyT7EH5Ou1sm3owk43fl2xg/EgyU=; b=HedE+Pssyqup
	S4IMz+GTyuPpIUmUo985BXR2BqxEs+fWsrzcQETAoip8x6NIwqDNDYPL8xk/uO4R
	/WJ0a7GTsZ3ylHwIiJjQKs3maZL9EZOAbNYN84rZwQWsmPvbPpVZ8XCVHL2fMDN5
	uqDR/BTwVprV1yj6rObeaUMpZU2pzzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=message-id
	:date:mime-version:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=default; b=dQA
	l4gWqjT/aSkMYqSp8t2r5Lq8AsW/X5zZZn2yxavkpmTdWt2tPL2/xKmnERWqHRG6
	LrvAYOvmOAzjnsYMdKVJRqbq8H4BL7s+hei0L9Nf+YpUEksn1U3VVGohbGp1/ber
	WW/EnYB8GaFOZXf1f7XNt4+R4cemgo/Kk5pBvl9g=
Received: from [IPV6:2001:470:b050:6:9ce2:364b:2e24:44cf] (unknown [IPv6:2001:470:b050:6:9ce2:364b:2e24:44cf])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 4bBH2Q6XDzz8PbN;
	Mon,  2 Jun 2025 23:56:30 -0400 (EDT)
Message-ID: <47c58a78-d38b-4170-87fc-c9332618d0da@comstyle.com>
Date: Mon, 2 Jun 2025 23:56:28 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] compat: fixes for header handling with OpenBSD / NetBSD
To: Collin Funk <collin.funk1@gmail.com>, git@vger.kernel.org
References: <87wm9ut3uo.fsf@gmail.com>
Content-Language: en-US
From: Brad Smith <brad@comstyle.com>
In-Reply-To: <87wm9ut3uo.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-02 2:06 p.m., Collin Funk wrote:
> Hi Brad,
>
> You wrote:
>
>> Handle OpenBSD and NetBSD as FreeBSD / DragonFly are. OpenBSD would
>> need _XOPEN_SOURCE to be set to 700. Its simpler to just not set
>> _XOPEN_SOURCE.
>>
>>      CC strbuf.o
>> strbuf.c:645:6: warning: call to undeclared function 'getdelim'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>>          r = getdelim(&sb->buf, &sb->alloc, term, fp);
>>              ^
>> 1 warning generated.
>>
>> Signed-off-by: Brad Smith <brad@comstyle.com>
>> ---
>>   compat/posix.h | 11 +++++------
>>   1 file changed, 5 insertions(+), 6 deletions(-)
> I noticed this as well when testing your other fixes.
>
> Just one question about this chunk:
>
>>   #define _DEFAULT_SOURCE 1
>> -#define _NETBSD_SOURCE 1
> Why remove this definition? I think it might be useful on some older
> systems and seems harmless otherwise.

_XOPEN_SOURCE restricts the build environment. _NETBSD_SOURCE is added 
to counteract
_XOPEN_SOURCE. Not setting it in the first place provides everything by 
default.

I was removing it as it should no longer be necessary.

But as said, it is harmless. I can leave it in if desired.

> Other than that, I tested on OpenBSD 7.6 and NetBSD 10.0 and this patch
> fixes the missing declarations. So:
>
> Reviewed-by: Collin Funk <collin.funk1@gmail.com>
>
> Collin
>
