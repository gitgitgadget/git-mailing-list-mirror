Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0927E25FA00
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 18:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914660; cv=none; b=M3UUn0U9yWraPpKsvFk7XuCUIM8UnBKg42k7LKKsGee3P59S4YtopWQUF7Rg3QLVZ5+K2EhXLGvevgFYDQJMej81R1ALbd3l9rVIf9N9MnR7iHpO8WVxc/gxbMLx3007/xzjpL0lp1gI1lOcpMELovV/spBfYc3b/9fKCK8oqt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914660; c=relaxed/simple;
	bh=X4c/AsoVoRVxsmFQ1wDPLVIkdmQqZFqoIAKpiC9u494=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cf6cSpXev4sFKGh2Wwu7eH2G9+wteO8H1hMeKQZRD5pse6sj/IsK3v0UcWaNNXVR92+k7riBVbEMhhQaZc06kGhngEJfnZMg3X2hoxspcwdkQjKkBYBP2surQ4pJxscx2QcFve8eb9fRjJfo+JmUCjoM87uaAFlHdio2N5Tc4wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=RQs+adIV; arc=none smtp.client-ip=212.159.14.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="RQs+adIV"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 5TxfuQzFVvxWA5Txguo4FH; Thu, 17 Apr 2025 19:27:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1744914467; bh=dYyMkeYx+Kpld2CpGXrAsDmVxUVsp6pDNz9XaAaZrGc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RQs+adIVGPDljfA4Bhsrh0vwT/veO2pvPIWzBBpDoO96ucYhKjCvGu0fn6arbSRo1
	 q/IhMvpFQRpeYekob1fqShd9uRWlrgJHksq6BoLRC1m08O5DIah2wWUH+rMMVmQL32
	 6WXk+klNWCxzaj5Vga+XGZ+8LCLVmVtbcm+iSqVbE0KBC1NQE1t/R0B+rIXIybs821
	 umi4POWV0ZG9EqDelxD20GM91Ft2aOEDBhrx1N1jCx+2uCd5/PWVP9uV7GI96k5saQ
	 9ZJM5e1QfcLmZlaJDYN6u3vVg0hJAqrE8JD6LLFk5YDgXtRUXsNanDHbAoVF69ayWm
	 16Hb4pPHYAZLA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=QbDFvdbv c=1 sm=1 tr=0 ts=68014823
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=N1ANU4bw5fSPn-QF8t0A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <aee15694-6a15-4409-9854-dad5f511dc48@ramsayjones.plus.com>
Date: Thu, 17 Apr 2025 19:27:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/13] config.mak.uname: set CSPRNG_METHOD to getrandom
 on Linux
To: Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Adam Dinwoodie <git@dinwoodie.org>
References: <cover.1743859985.git.ramsay@ramsayjones.plus.com>
 <20250416231835.2492562-1-ramsay@ramsayjones.plus.com>
 <20250416231835.2492562-14-ramsay@ramsayjones.plus.com>
 <xmqq4iymgadz.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqq4iymgadz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMqTgG37uvRZoc1nAdK3sQczeodAMRNjATA1PcRb0fhvXn1dHIx8d+Smv30Fy+agAqAc+MJGGv3+N6hXTsQRQHK9YVea3igytr1C6Ap5mHGf++bxjnlp
 MleLCwXxw5zZDdwByhPLZRRXLgLQmlGhJcSZjN3eu7JSc9a5NfUpJZXFBIJH+o+aqEKlEYLB5IhWT8T1OzzsrEdcLC+egA6qAKs=



On 17/04/2025 14:55, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
[snip]
>> The arc4random routines (ar4random_buf() is the one actually used) were
> 
> arc4random_buf(), if I am not mistaken?

Oops, yes ... an unfortunate tyop! ;)

Do you want a v4? (The cygwin v3 'make test' has been running for under
two hours, I could Ctrl-C it ...)

> 
>> added to glibc in version 2.36, while both getrandom() and getentropy()
>> were included in 2.25. So, some of the more up-to-date distributions of
>> Linux (eg Debian 12, Ubuntu 24.04) would be able to use the 'arc4random'
>> setting. All currently supported distributions have glibc 2.25 or later
>> (RHEL 8 has v2.28) and, therefore, have support for the 'getrandom' and
>> 'getentropy' settings.
> 
> OK.  This explains that getrandom/getentropy have better
> availability than arc4random.
> 
>> The arc4random routines on the *BSDs (along with cygwin) implement the
>> ChaCha20 stream cipher algorithm (see RFC8439) in userspace, rather than
>> as a system call, and are thus somewhat faster (having avoided a context
>> switch to the kernel). In contrast, on Linux all three functions are
>> simple wrappers around the same kernel CSPRNG syscall.
> 
> OK.  With this and the previous paragraph, we establish that there
> is no reason to use arc4random on Linux, while on BSDs and Cygwin,
> it is a natural choice.
> 
> Very clearly explained.  Thanks.
> 

Thanks!

ATB,
Ramsay Jones



