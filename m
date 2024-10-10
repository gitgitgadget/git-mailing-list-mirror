Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D8C7462
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728579439; cv=none; b=ZFv7055f/IY1yb2GZmOj5PnnPAi7txoha1HoUTrwnvTESL6Olcd29rjWoxMW2uakwBC5H3CY+xfMcCYU4w43VHZP68Y+KnsKfIPiMhfP3TyQ4zM3ktCrNjS/jifngX9EJB5ZJvTd5stNItHH9vOtdJTofMRHWpXQ3TVrGJ7XeDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728579439; c=relaxed/simple;
	bh=rjqRvMIyAu3zNhIGNqlPMGoddf4xwHEyyfYrVFoDhvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c9nqd2BQ7xc98laVBKfAg+f2fRhuQUbhL8STBeDL0Fx3Q16+g85SxOSMKpjV4yUL7ymA87jW9PQD0qycSmeil9To0bKK/oDCwtT39hK58ZJFkGpFxmOpXyVz1VCuqBlGKXIX47mZSbT71cYo1beRus/Xpu+pVmypFdNjSWsBqw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=PDV/4hsF; arc=none smtp.client-ip=212.159.14.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="PDV/4hsF"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id ywQOskQeKx2dSywQPsy4Jp; Thu, 10 Oct 2024 17:54:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1728579247; bh=MkGP2cnR6X9Q3wmG+AVhrh/rbG7/AD6qZXPSGwoRzFE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PDV/4hsFuSNjrw7VEsrKgnXKNhwfstCjOHVhSRQgrehxjmOoIkJ9bLhZlRwhTvo12
	 8S/WQX5+tK80KfOD8IbLZii4nyd8m5nppDBcgjyAQY5e4NR4KQooQrfdg/U1WzfmZw
	 aW0gHk5yYnRxU0gg1tt1R275Xh5HKkJuXpTASaMnQnakh+dzs9NrK6p/6LF9hmExPF
	 b02kvdfz82xZh0OyoNU7GpYsxK//f2jblwJOSZZL9sFutuY7l5Aglj5v39tZ1amCjZ
	 K9LS62EH+gtGWx9w9LeQxlUjFrqQo5icx+fTYzMEqyuO9Bd+rl+UdbzTW35BXNrpXg
	 rWwwPLJzLDGKQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=GMarEfNK c=1 sm=1 tr=0 ts=670806af
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8 a=cMI7se6uAAAA:8 a=NEAV23lmAAAA:8
 a=4T-PPbLPzZviJ6YSvgwA:9 a=QEXdDO2ut3YA:10 a=0RhZnL1DYvcuLYC8JZ5M:22
 a=60UZMENMP0NzwrUPKbDS:22
X-AUTH: ramsayjones@:2500
Message-ID: <ebd5e3d4-7299-4cfa-a209-9399a1cd79fd@ramsayjones.plus.com>
Date: Thu, 10 Oct 2024 17:54:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] set-head: better output for --auto
To: Junio C Hamano <gitster@pobox.com>,
 Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk,
 Taylor Blau <me@ttaylorr.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <xmqq1q0xhu13.fsf@gitster.g>
 <20241009135747.3563204-1-bence@ferdinandy.com>
 <20241009135747.3563204-3-bence@ferdinandy.com> <xmqqjzehq9qk.fsf@gitster.g>
 <xmqqv7y0lzn5.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqv7y0lzn5.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfNE8XPXM+0F8O6uSxzSNn+eCpZwaHokiaR/MLVZ0n0QPBMagR0RS+boqlAAR8nrBoFBaD+qzoNbNjeRK254SUCfxiMcAsHl1DeEObgIismdTRVPaYxaS
 qQhb9xnuXRGiWb3gfgTVDEFHrayuGQ+uy+5i9s7xvl76gqW6VTaXI93gdSjGvyK5TJVC7z5ybKcSJkDhwoMS0cwRsEwe3dNbsIE=



On 10/10/2024 16:57, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Bence Ferdinandy <bence@ferdinandy.com> writes:
>>
>>> +static void report_auto(const char *remote, const char *head_name,
>>> +			struct strbuf *buf_prev) {
>>> +	struct strbuf buf_prefix = STRBUF_INIT;
>>> +	const char *prev_head;
>>
>> I think we need to initialize prev_head to NULL.
>>
>>> +	strbuf_addf(&buf_prefix, "refs/remotes/%s/", remote);
>>> +	skip_prefix(buf_prev->buf, buf_prefix.buf, &prev_head);
>>
>> If the symref was not pointing into the "refs/remotes/<remote>/"
>> hierarchy previously, skip_prefix() comes back without touching
>> prev_head (i.e. not starting with the prefix does not clear it).
> 
> The two uninitialized prev_head were also noticed by compilers in
> multiple jobs at GitHub CI.
> 
> https://github.com/git/git/actions/runs/11265515664

Heh, I was just about to send a patch to fix up these two warnings
(errors with -Werror), so that I could build 'seen'. However, it
seems to be well in hand, so I won't bother! :)

ATB,
Ramsay Jones


