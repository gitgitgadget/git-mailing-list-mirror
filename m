Received: from mail.comstyle.com (speedy.comstyle.com [206.51.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E48B129E6E
	for <git@vger.kernel.org>; Sat, 31 May 2025 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.51.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748722693; cv=none; b=EfRv2rjjYpz2pPbKsPczwlpczQWyC+g7TvUwVjsvzQaGRQsRuD4k6thbbDywwIbRtqCpe+JHZcXxuuIPo3XIJt/y1C6d7PhvW62GBJoMSQ/shHLH4ORo7ZeCwxxmKUaPwTyW3/DnPLKEXtm1d4Rrh9jlbca9d/X/MNSQ3HCbI1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748722693; c=relaxed/simple;
	bh=mKmBydgLRFr4dzRG+DGhn6X6Z+vgG7Ndwbo7kCweAT8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=VLNZEW2i4LQJYorX3WnNoMrWJOTWn5Cfq9w18/VTX8zYGt8M9KpE9qzn7YYbVATYw8dNJ3KcTR+zAtLermldQkH6VlGft82tp1dRWe7K/uMBX9/T3dGU1q77/wtBEg4UH6AHPtRGi1Hxhg6UFZQfHthph8ZzOzoTOWm21P0AYWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com; spf=pass smtp.mailfrom=comstyle.com; dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b=ES/FWW8h; arc=none smtp.client-ip=206.51.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comstyle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="ES/FWW8h"
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id 4b8ryN6SSxz8PbP
	for <git@vger.kernel.org>; Sat, 31 May 2025 16:18:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=
	message-id:date:mime-version:subject:from:to:references
	:in-reply-to:content-type:content-transfer-encoding; s=default;
	 bh=mKmBydgLRFr4dzRG+DGhn6X6Z+vgG7Ndwbo7kCweAT8=; b=ES/FWW8hDdSm
	dZuOP2dM2L/iP/H2kQQAkyqWwqB9A1iVD/TNcTslWfQtOzSdifS0qiyyJMcbT0EA
	zlFH+KaazdGAvGK/yyR7HfUZmSmbhME/YhhKR+tXvZKLz/cGDnRF4Nu+IX0mqM3d
	5VaOCj43wXD5qrWFSPIGb7VbyFzPvos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=message-id
	:date:mime-version:subject:from:to:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=default; b=HrE
	BE2PHI6sjV6YX0G47ES2kN/rtHYbs5UKKTG1yjW7CYferZq5Fxmh6owVsBpqNwYd
	reEDd5dUuKcFNTw3OmyDgJDZp7nF33AjnDadPz/E3aSzIkfEFrxuFqZ/9cuJNG1w
	tSBjcnVDirmzg4c9gnFlWOVFHQlnI++iTcIbRITE=
Received: from [IPV6:2001:470:b050:6:cc31:46d5:f26a:a82b] (unknown [IPv6:2001:470:b050:6:cc31:46d5:f26a:a82b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 4b8ryN3bRCz8PbN
	for <git@vger.kernel.org>; Sat, 31 May 2025 16:18:04 -0400 (EDT)
Message-ID: <f929a4b5-1011-42dd-ad86-bb654d170db2@comstyle.com>
Date: Sat, 31 May 2025 16:18:03 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thread-utils.c: detect online CPU count on OpenBSD /
 NetBSD
From: Brad Smith <brad@comstyle.com>
To: git@vger.kernel.org
References: <aB2c-W0V83aVDpZr@humpty.home.comstyle.com>
Content-Language: en-US
In-Reply-To: <aB2c-W0V83aVDpZr@humpty.home.comstyle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

ping.

On 2025-05-09 2:13 a.m., Brad Smith wrote:
> OpenBSD / NetBSD use HW_NCPUONLINE to detect the online CPU
> count. OpenBSD ships with SMT disabled on X86 systems so
> HW_NCPU would provide double the number of CPUs as opposed
> to the proper online count.
>
> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---
>   thread-utils.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/thread-utils.c b/thread-utils.c
> index 1f89ffab4c..374890e6b0 100644
> --- a/thread-utils.c
> +++ b/thread-utils.c
> @@ -46,11 +46,11 @@ int online_cpus(void)
>   	mib[0] = CTL_HW;
>   #  ifdef HW_AVAILCPU
>   	mib[1] = HW_AVAILCPU;
> -	len = sizeof(cpucount);
> -	if (!sysctl(mib, 2, &cpucount, &len, NULL, 0))
> -		return cpucount;
> -#  endif /* HW_AVAILCPU */
> +#  elif defined(HW_NCPUONLINE)
> +	mib[1] = HW_NCPUONLINE;
> +#  else
>   	mib[1] = HW_NCPU;
> +#  endif /* HW_AVAILCPU */
>   	len = sizeof(cpucount);
>   	if (!sysctl(mib, 2, &cpucount, &len, NULL, 0))
>   		return cpucount;
