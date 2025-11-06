Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7811757EA
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 19:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762457052; cv=none; b=rIFC88lFLzgydyHTT68yz6/ECa/vCzgX5b7K2RzQWxg5e8JqryGcCiQuihRIrOY2Br0/l2FevVIcaMqqDW5ZAay77bquUVVDsIWpLPUXQkSy8k2LXyhVIS1DOJ9wkHI091MOEs4CJC4j7UMWMpDjO0+tMkVNIWlYKZcIGe3BtAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762457052; c=relaxed/simple;
	bh=GjMrbaiP3thrgRnwJ+RKg0hANvnBzmhBUsyic9MOs/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZprXxpxmIVzoRs7YkdJSf7dpVgdg7dDfRn6ZYDUUgPTUjIhcin9EzuehVybOU/TjYg0Yp9xV5Be71Dm8QOO5eKIEFxG7hmxkqpLL8dae3no+7suRJfLT9gEU0PgvS71NOl51K2IQ7L7FRMt89hdEvjxBAPMMYJKXWmGjx3sFpOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=f7NWf29b; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="f7NWf29b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762457041; x=1763061841; i=l.s.r@web.de;
	bh=pFMh16iyBdQUVE2w/gfpboGEoGrjYXP3G5mWhhEqdCg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=f7NWf29bmMfNXCoaLt349X8ZZA0pdzZ3/PJqjj6KvSlPzfAS2pSWgPl35h18c3VC
	 7/bWyFVIGSOx4JmRrMiy5eNOD+wy1rQ59Mjyuo200i1ovQZnMpVhJjwkBPw4wl6AT
	 J0Tyv1cZe/2+RIXuemX8KlzoPhX8KmlGu/1/NvccV9toK6ldhme4Yjgs5b3eB2c4W
	 GGqU2/f7yiSJu2IluR6Bx1BuZ3IbuNa4TW3SuusL4iA4SVbe2zZUGPP0MapQnw/rj
	 KSXfrLaaPJG48eLbuh5w9mVorzHEKQUxLIDaNF3jfZE4ZAWyiTO71i6Ko/TT+iDKj
	 BmCVmHfGottLy3ACyg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.30.88]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N2SP7-1wDyTm15vL-011uie; Thu, 06
 Nov 2025 20:24:01 +0100
Message-ID: <a2e85618-4878-45ce-b52a-8d045be3bf70@web.de>
Date: Thu, 6 Nov 2025 20:24:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] Git v2.52.0-rc1
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqqzubhyj9.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqqzubhyj9.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EsV8UKVr7lEJ7Nx7rRZOcLM1MaZZ+5/xGv8DCl/KDPg8zKshIp7
 LhM4YpE7uACIy4s6Jqi+If6qhuP9cFI7oq1oewcntbfE3e+uZDZ7oQQHQ25eBeqa6FZMClx
 Me7Rk3S30WWjFTyPDUJILKLuUeqsmq5lVcN9wpNbpEgD/RX2oNn59x5dxFU95KFy1nmHfM+
 OVoGg3lALI+xwsuyaYBZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/7CjI0XJ0Nc=;ksXWpBnqshYIYM84dRwGMrRg7IV
 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
 JuUgwTgVwiSoAw==

On 11/6/25 6:16 PM, Junio C Hamano wrote:
>  * Instead of scanning for the remaining items to see if there are
>    still commits to be explored in the queue, use khash to remember
>    which items are still on the queue (an unacceptable alternative is
>    to reserve one object flag bits).

s/bits/bit/

Also there are no new khash call sites since v2.51.0.  I assume this is
about 30598ccc4d (describe: use oidset in finish_depth_computation(),
2025-09-02), whose initial version used khash:
https://lore.kernel.org/git/9110f085-aec0-42e9-9774-b153ece6284f@web.de/

Ren=C3=A9

