Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E773EBF3B
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 06:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.189.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771136607; cv=none; b=ovNRg6rol139Hjl2wftFffXWwoun3AUj1N51vwXPZa25X2EvmTv+TUwCGUEpWw0UF338trCyAYZvuOMgQHcVjk6mBH/bpBQk2H8hoqI+ne40VdTDWH82ugYpt6noMzr2irJqUhKD5CcEkPSLhCRPIDqTaADTv+FLjp+pRujLlyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771136607; c=relaxed/simple;
	bh=BbMvLvi0IOZYnbpOl1TIMY9KdJn2sJcA9QraZseZQnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOkogE9T9XYaSMYnjLo7ASs3EBmvc9OULnQJ2p7u0/8welRySDNCjRMKxRSj01qNWUUROEPiRuY9CRXq67j3MPTIEy+y/f/XGh3AJeukje/u+ArM5PY+pTdVMGB9xgn/7HDngMWlUUTG+PhyvBmmHaomw1WRGr1Nae/Ai6Nt5dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; spf=pass smtp.mailfrom=archlinux.org; dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=LwOQ5aEO; dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=7RByXgAM; arc=none smtp.client-ip=95.216.189.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinux.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="LwOQ5aEO";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="7RByXgAM"
Message-ID: <77a887d0-51bf-4bf6-af8f-d5555dab2fe2@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1771136602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mmQtOpBCJb+VGmbbrxj5bKEeiwcgCp3hO4y0DfAdi/w=;
	b=LwOQ5aEOQFBPzYrx/SrA1yKwgKMc7a28HCzOxykVo4rq3/DcY5rci60zhEddoHLwvgvzP5
	U1QOJBn8en1UKwGg7BMfiyLJ1qBUAEmOU9D9LHbTO/yW1RsjN36sRl8lo3HxsYRDMBrQRU
	yhL2C48C++jvC62TwnMNJgUseeyzYdjc5axw02Pfjtw5/l4xjj2ES6bQS9mOriTh243rgz
	EG9fEPPbNw++SufHtnCvQY8kpPhFKRgxTazi2GwcJU+ePjM0isidW3vqA8D+KsjHaaxmB8
	NU2+pdhcS8lSiaG7RW6faN+tG644Gm7YG9QXBMTFP55cb2meXEg+68b0VqHL5P9yafaW9F
	sR1IMffH/tFWYGh3U7Nxd0cQFirFCz0PViwxICkFA0COPUnLRFxr8LE0UoSKGWEkPJTUMg
	TemJnk0H792Jfgk/Kcftms2e1ZJaj9eB1jiQiuObCSEiWWXzGTDxWqR2+98dpbs/mzFmFN
	wgfk9tP1/60PQcACO89rlOU6qiAIhBTw5Kagv2mK6fF5ZSTNtGWkQfC0oN2t7ZmxBWhH5P
	EmkKbDcx0SJEVU8HRpWoYuRFDPDMK6JhZoVKE44LjAkeGeqCYDislWbP4xsfg4So5QGDG8
	Qup1k+huIzg6ZoDXQfwzNn2gwwyU4Zb15VhO52XU7hHPwVZLFs/XU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1771136602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mmQtOpBCJb+VGmbbrxj5bKEeiwcgCp3hO4y0DfAdi/w=;
	b=7RByXgAMb2dnRqW62rqnxBgLhadi2a1mzZeda//7LSxCax7So5o4Oi+s8/IY6h0qVzamxi
	NG9SdiwcItAtZNBQ==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=integral smtp.mailfrom=integral@archlinux.org
Date: Sun, 15 Feb 2026 14:23:16 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] copy.c: use `sendfile()` for in-kernel file copying on
 Linux
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20260213124656.218396-1-integral@archlinux.org>
 <bf0b3c41-9784-4494-a932-68abfa60cea6@gmail.com>
Content-Language: en-US
From: George Hu <integral@archlinux.org>
In-Reply-To: <bf0b3c41-9784-4494-a932-68abfa60cea6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/15/26 12:43 AM, Phillip Wood wrote:

> On 13/02/2026 12:46, George Hu wrote:
>> The `sendfile()` system call copies data between one file descriptor
>> and another within the kernel, which is more efficient than the
>> combination of `read()` and `write()`.
>
> Does git copy any files big enough that this makes a noticeable 
> difference?
>
>>   int copy_fd(int ifd, int ofd)
>>   {
>> +#ifdef __linux__
>
> Our normal practice when a function has platform specific 
> implementations is to host those implementations under compat/<platform>
> (see the implementations of trace2_collect_process_information() for 
> an example)
>

The Linux implementation of `trace2_collect_process_information()` 
resides in compat/linux with a stub version in compat/stub. After moving 
the Linux-specifc `copy_fd()` implementation into compat/linux, where 
should the generic implementation be placed?

>> +    struct stat ifd_st;
>> +    size_t ifd_len;
>> +    ssize_t ret = 0;
>> +
>> +    fstat(ifd, &ifd_st);
>
> What happens if fstat() fails?
>
>> +    ifd_len = ifd_st.st_size;
>> +
>> +    while (ifd_len && (ret = sendfile(ofd, ifd, NULL, ifd_len)) > 0)
>> +        ifd_len -= (size_t)ret;
>
> This does not propagate errors to the caller, if sendfile() fails the 
> function returns 0. write_in_full() handles non-blocking writes, we 
> should do the same here if we see EAGAIN. The man page lists various 
> restrictions on the file descriptors passed to sendfile() - I'm not 
> sure that they affect the uses of copy_file() in git but to be safe we 
> should fall back to the read()/write() loop if we see EINVAL.
>

According to the manual, `sendfile()` returns -1 on failure; a return 
value of 0 indicates EOF.

There are error cases besides EAGAIN and EINVAL. Maybe we should fall 
back to the read() / write() loop for errors other than EAGAIN?

Sincerely,
George

> Thanks
>
> Phillip
>
>> +#else
>>       while (1) {
>>           char buffer[8192];
>>           ssize_t len = xread(ifd, buffer, sizeof(buffer));
>> @@ -19,6 +34,8 @@ int copy_fd(int ifd, int ofd)
>>           if (write_in_full(ofd, buffer, len) < 0)
>>               return COPY_WRITE_ERROR;
>>       }
>> +#endif
>> +
>>       return 0;
>>   }
>
