Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9153F8F5E
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 07:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752131898; cv=none; b=OCM0vFKGuD5s5t9KWK4JnDDt7TTYc5uRLCkm3o/zXJnFWfEe7pLqAfVFeXjU4ZFwpj4WEyAw9QJOQ1Wvxv5IOI2F7efEt8R6nhztdM/CkTWmLlcYiDms9l4bK8OzzWsnWeING370HVGUptZMe2BOKA8fFhSwTt8GZdrRyczK6OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752131898; c=relaxed/simple;
	bh=7E+pWUsfluOo7Z+vSNPTdOC377p6zpI8w0vEg+OkjD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+58F8GDGXhT7DdNf7euJ8xBuW+XJvdYiDVuIr9UJz+a5V8DHDKXiQZY3zZWLFwDdCS8yww+NOmXsSs45rrmJRDxtiAhVnUI+R7CjPzxE9B1X5VR/5dEOlJrCjdcFVEQ8MjZR0/C3vXrKK096h73M+Ssim25x7KswwuTVkQcr5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.103])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4bd5m44lt8z7QTmF
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 09:18:12 +0200 (CEST)
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4bd5lw39XXzRmxp;
	Thu, 10 Jul 2025 09:18:04 +0200 (CEST)
Message-ID: <51208670-eccc-493f-8a60-2bc9e3a70801@kdbg.org>
Date: Thu, 10 Jul 2025 09:18:04 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Jul 2025, #02; Mon, 7)
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com,
 Junio C Hamano <gitster@pobox.com>
References: <xmqqplebzgm7.fsf@gitster.g>
 <vl7ahhcqgci3xemqhtdugdhar24ewl7mu4wqwxnc3jag5blpoo@l7b24mahadyi>
 <668ce4d4-3b60-47e0-a4a5-dbf73efd1e75@kdbg.org>
 <tuglsm3r64mkgzdh2zdrewpzydz7xmyatqxwbbzpqmltwseefc@65cbcs3pq2qg>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <tuglsm3r64mkgzdh2zdrewpzydz7xmyatqxwbbzpqmltwseefc@65cbcs3pq2qg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 10.07.25 um 06:25 schrieb Carlo Marcelo Arenas Belón:
> In d28250654f (Windows: Fix signal numbers, 2009-01-22), the value for
> SIGCHLD was changed from 0 to 17 mentioning some sort of POSIX system.
> 
> the relevance comes that if I build a program in Windows that calls
> `signal(SIGCHLD)` using that number I get an error back, but nothing
> on errno, but if the number would be instead 20, like in Cygwin/macOS
> suddenly the behaviour changes and we get the expected EINVAL(20) in errno.

> So do you have any objection on changing the value (which should be otherwise
> unused, and irrelevanted as you pointed out) to 20 then?

I do not object to change the number. Nevertheless, I would like to
understand why it makes a difference. (Currently, I am unable to look
into this myself, though.)

-- Hannes

