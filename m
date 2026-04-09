Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722273B47DA
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775728089; cv=none; b=bmT7SJkQmVp52OYQORA2Sn0HSv2XXLr3ZsSyNcGzHTycmz9SKR+7PGGU7qGiSvmZRepyNVsMfiR7d3ZMVQdBPeoHLDjd/ap4vMsd+z2eTVk/BN3cAIFtjXzy4eYfSenITLscywHXeqmdfQjUZTbcDPp55c66FEEYK7PnnLaHdB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775728089; c=relaxed/simple;
	bh=cAvagc781EJXN9+Q0Q/3gUS3fT1P7/Bks1wTllqIUVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W2gkpICKjpl8cngDy5URRb0LSc2czc715jkYSGMyKWzPyMjxamwq+Ynpobf+BKtTGFRznQhDGUmzG/HrqzCDKL0EoXf7e9fVbu/EXSCj4ZCC7BcaBS3YgCHDKI+XJ3b0/B8SzeBvws7WPs4IdaVjX2Sji0ENK9WGNvnbEjgG2sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7XRhPA/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7XRhPA/"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso5142555e9.0
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 02:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775728086; x=1776332886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5h4bWQuf2muIvVB6V8tOCjPFSMwT5hVY09jNB3gyfBw=;
        b=J7XRhPA/O/Zh02YbnyZH3C1TFAIUL8i7ybC34OUs16dPje07epSS7T87BvvtWkQavW
         32KguxTDjM+PMHf/GbzDWlwijMZDJsxVf/GUlGSZ/q92S9lDAo0Ez5yTepE/HFHXA4Vi
         mvqLczGc6qj1t2QtGpiEoKjXBEUr2+omEEmqUq6RjnjjzKXYMIEPVf1BD3d1Vx5OouTz
         5+axg7NL2g2KDnc5pv8nLh9xUH7GHQKqp4owc0LjVkt4b5hqRZ94Zef+AocJYZXaFXOK
         OTqzktMhjaXbZdFBONFixTrMSKxJnsJry6RtPhqDfCzhxKUqqMSa9UPZ5NKGkblxjDhi
         pHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775728086; x=1776332886;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5h4bWQuf2muIvVB6V8tOCjPFSMwT5hVY09jNB3gyfBw=;
        b=At0oDmHVxOIcc2TSY+kSV3UnVYK86Zlr4XjseCJVN6C30CpN9vOLJQSyh9e3DK3h7z
         F82FFARqh3eeuIDeRJ1ai+SqfK4Jbq84grOtgB4h0m0eKsP9oCGltX7XvQRvED01mrMZ
         Tb5hucob+UD/CgpU4ZcS9e0yUO0nIY4Y6GkaHIEYHjD78veEX7hjdyuwPVr0PL98BhsD
         jaOdAknSxvZFwBh1885ayTQw53vsVutKXPMklZgZ6KD8g9keFaoL7fmOoMQFgKW5uMEO
         ZIAQO1BIHiTc76BiP7UhNRyy6YtunPuBMH3VIXDc7zITv8k1cnudhbwzzu052POCWQaU
         GLew==
X-Forwarded-Encrypted: i=1; AJvYcCW7qAbKE40guK19/zAOJM/XgUDd3lDe1ILr17QgSzchL2aU5i7LqIVtzcCUwsST/iKGD+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOCwAfDpCJZY6Kib/Blk3CwCJlEN6Q+LHddtDjAWODC5lNBslF
	B/e0do8/LP/3DNql4y/hl3uVjGVGYH6zRYqXxi8um9RPD4bFCCxYHMNR
X-Gm-Gg: AeBDieuPA/AIv5+y2KpW11zHAETe+fImSAOFPfcIyKLkthz+/1/Mh+mrMNppye/SZJA
	PI26NaN8ShXB0AxfqJK7V34JUO0AYSbarCc59xlB9VeqsTwoBAW6bq2QnTsK3JS1E8UKr4L6jD+
	CpONXKL09ZQkLTA8eTaSpPKhbe97L/zjDoMPbh/kixU9/4XmIW/nFq+1gu0bmM5BiBZQDYgpoqY
	G0GX0OAsvjJQGz7UkpdEhoq95iyXCQu0/mPueIyrCqgcsVkuiw3k9ZiMrVYE2vjfNe5/u1+e+IU
	mA4TE48RLZPNrww932P5Fyeg5Qm3eKt/zN6ClTdW0+cNxtGL7W6Hs3MX/O/sTGqVaPCm7cNq9Bf
	8TN6pG4GOSRPhpCMmVbXLlgqpFHMfrElDd31PlfyZn7ol6nC3xepz6WctS07IcnbzL5wyhIbM/g
	CZoHSuMfa+Fz/ZZ1JI6XZvoJ8pXqmRmfrM+BYmc4vE9zcbEi2RDqxVUQh2wX1m5it/kj+yX8Paj
	a2GCD9BH+x3Pg==
X-Received: by 2002:a05:600c:348d:b0:488:be21:54b9 with SMTP id 5b1f17b1804b1-488be2155c0mr154925475e9.8.1775728085477;
        Thu, 09 Apr 2026 02:48:05 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cd18de6fsm19427585e9.25.2026.04.09.02.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 02:48:04 -0700 (PDT)
Message-ID: <90c6112d-6447-45e0-8d15-a0a3f1f25013@gmail.com>
Date: Thu, 9 Apr 2026 10:48:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
To: Patrick Steinhardt <ps@pks.im>,
 "brian m. carlson" <sandals@crustytoothpaste.net>, Jeff King
 <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
 git@vger.kernel.org
References: <011701dcc767$8c2ab400$a4801c00$@nexbridge.com>
 <013301dcc774$5e9fffb0$1bdfff10$@nexbridge.com>
 <20260408173949.GB2850002@coredump.intra.peff.net>
 <xmqq4illz5g9.fsf@gitster.g> <014e01dcc793$8a9bab90$9fd302b0$@nexbridge.com>
 <xmqqqzopxkxa.fsf@gitster.g> <016b01dcc79e$87472860$95d57920$@nexbridge.com>
 <xmqqcy09xh53.fsf@gitster.g>
 <20260408223233.GB2873736@coredump.intra.peff.net>
 <adbwyvQ-R2Ag1vox@fruit.crustytoothpaste.net> <addgkjiB80pgKw69@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <addgkjiB80pgKw69@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/04/2026 09:17, Patrick Steinhardt wrote:
> 
> One question to Randall though: does MAX_IO_SIZE apply to the overall
> size of the iovec or to the individual iovec entries? 

In <014e01dcc793$8a9bab90$9fd302b0$@nexbridge.com> Randall says

     Specifying  the sum of the iov_len values in the iov array greater
     than the OSS I/O size limit for that open causes the  writev()
     function  to return  -1  and  set errno to [EINVAL].

So it is the overall size which fits with POSIX limiting to overall size 
to SSIZE_MAX.

Thanks

Phillip

> I think it should
> be the latter, but I cannot easily verify and couldn't find any docs
> around this. So could you please try the patch at the end of this mail
> to verify that it works on your system?
> 
> In any case, I've tested that my patch also works when defining
> MAX_IO_SIZE to 128 bytes on my system, which hopefully demonstrates that
> it works as expected:
> 
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 4b4ea2498f..8e02b5f673 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -690,14 +690,8 @@ static inline uint64_t u64_add(uint64_t a, uint64_t b)
>    * to override this, if the definition of SSIZE_MAX given by the platform
>    * is broken.
>    */
> -#ifndef MAX_IO_SIZE
> -# define MAX_IO_SIZE_DEFAULT (8*1024*1024)
> -# if defined(SSIZE_MAX) && (SSIZE_MAX < MAX_IO_SIZE_DEFAULT)
> -#  define MAX_IO_SIZE SSIZE_MAX
> -# else
> -#  define MAX_IO_SIZE MAX_IO_SIZE_DEFAULT
> -# endif
> -#endif
> +#undef MAX_IO_SIZE
> +#define MAX_IO_SIZE 128
>   
>   #ifdef HAVE_ALLOCA_H
>   # include <alloca.h>
> 
> I'm happy to go either way, but think that we should definitely aim for
> the below patch eventually. Just let me know which way you prefer and
> I'm happy to polish up the patch.
> 
> Patrick
> 
> diff --git a/wrapper.c b/wrapper.c
> index be8fa575e6..645dbc5f20 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -323,21 +323,50 @@ ssize_t write_in_full(int fd, const void *buf, size_t count)
>   	return total;
>   }
>   
> +ssize_t xwritev(int fd, struct iovec *iov, int iovcnt)
> +{
> +	ssize_t bytes_written;
> +	int i;
> +
> +	/*
> +	 * We need to make sure that no individual iovec entry exceeds
> +	 * `MAX_IO_SIZE`. If there's any entry that does exceed this limit
> +	 * we'll pass all entries up to it to `writev()`, and then process the
> +	 * exceeding entry via a call to `xwrite()`.
> +	 */
> +	for (i = 0; i < iovcnt; i++)
> +		if (iov[i].iov_len > MAX_IO_SIZE)
> +			break;
> +	if (i < iovcnt) {
> +		/*
> +		 * The first entry exceeds MAX_IO_SIZE, so we pass it to
> +		 * xwrite, which knows to handle his case.
> +		 */
> +		if (!i)
> +			return xwrite(fd, iov->iov_base, iov->iov_len);
> +		iovcnt = i;
> +	}
> +
> +	bytes_written = writev(fd, iov, iovcnt);
> +	if (!bytes_written) {
> +		errno = ENOSPC;
> +		return -1;
> +	}
> +
> +	return bytes_written;
> +}
> +
>   ssize_t writev_in_full(int fd, struct iovec *iov, int iovcnt)
>   {
>   	ssize_t total_written = 0;
>   
>   	while (iovcnt) {
> -		ssize_t bytes_written = writev(fd, iov, iovcnt);
> -		if (bytes_written < 0) {
> +		ssize_t bytes_written = xwritev(fd, iov, iovcnt);
> +		if (bytes_written <= 0) {
>   			if (errno == EINTR || errno == EAGAIN)
>   				continue;
>   			return -1;
>   		}
> -		if (!bytes_written) {
> -			errno = ENOSPC;
> -			return -1;
> -		}
>   
>   		total_written += bytes_written;
>   
> diff --git a/wrapper.h b/wrapper.h
> index 27519b32d1..a6287d7f4d 100644
> --- a/wrapper.h
> +++ b/wrapper.h
> @@ -16,6 +16,7 @@ void *xmmap_gently(void *start, size_t length, int prot, int flags, int fd, off_
>   int xopen(const char *path, int flags, ...);
>   ssize_t xread(int fd, void *buf, size_t len);
>   ssize_t xwrite(int fd, const void *buf, size_t len);
> +ssize_t xwritev(int fd, struct iovec *iov, int iovcnt);
>   ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
>   int xdup(int fd);
>   FILE *xfopen(const char *path, const char *mode);
> 

