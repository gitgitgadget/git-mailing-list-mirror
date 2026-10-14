Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16597440627
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 11:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791977886; cv=none; b=EejzTcPhQvJ1PQWHVQccvWZ3Vzc/E2mMZr6HJegtkXcwo5CjsokUCqrU9GT+hswsqg/fnXjgvLsUbAzs7S22GvoxBH68xp5etWGwoLuGbLojTA7yTN9HEwFGRedF7bSCJGs0S2tzwXMhsCOuO7gX6A0/CGzi0I9g0cq4fzfjAgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791977886; c=relaxed/simple;
	bh=Z6LN/kWNcZ2XAy320IuBCNxkN69rvnyZrIjL8G90VaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iaEeSzeYaejeyykHb1Mq1zHLoJ1D+24kw+eigLgqgFLB2Ve97qS2V5xs/4sGOHHza6rFI9odsTZUhXgswxJTRG3OoM1g2Y/O37Hw3mwn/i1HJdY+c2IvJe/ZAWtSTlc23b4jX5H5GQxFQLYiZogOFdFZDMU+GDHZVhrVfmg8GMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFv1esJH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFv1esJH"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a16c399641so39466675e9.2
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 04:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791977883; x=1792582683; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6Zl7rQpxFB2Von9tjOt1y2p6zQ6e/TGAIede+D+soY8=;
        b=lFv1esJHOALyAv220Ywtwx5hRzCs1g6P5uZCs+9BePMjU9PJWyc796waGJk8U6mMRc
         FaMOfgR2SqwD5GGPkGb1fR2+ozLu52AFcKAAM0mTgbGvLv+Gzef9aDmtOm5XV9l6zg/3
         McOB81J7R7u7g8KaTfOQGUJxMOfVmKvPe7xFrS/JZQunk4YHzyFO2m7YjhMPZDKwTB/8
         25bx5pOFZbCw/xSGK3HHxbzPfWjsVZlLcv5FsaYu72xOrMZL/FOSIvdsxDim+3UzFkTZ
         YtPKrzkujFPbgsHkHX4T1t0m4afIL79KRLW3yqDg4RZ7OKFXEgpHDJyiDZyztueY2Loi
         2wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791977883; x=1792582683;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6Zl7rQpxFB2Von9tjOt1y2p6zQ6e/TGAIede+D+soY8=;
        b=URbKahB0XZHVdAQrQXxvoPO3dl+1lzCN6V1neRceBEAmSnV4vXiAQD/TLTyy9zilOp
         5JxMCDjEDTK8ce4KE1jLyUcLnJJQTb8MpvzWF/nscm6Zje5iLcsPO15ptDx6zOGcw2nC
         D6Fgc+jhN1ts+98Hb/Xs9gj5uVM+rGNQ8w2Ko2rikd+PEBLbkwpBjF1226W5pufO/Ig4
         TAbXAvmp4NcH6SOGmjB5BXMpfGKfBj+efbt94QIaJwiJAmbVrKKyDjJTKKZvqnrGG2pt
         JhspiDHzagYtoyS+wpqgcARF7kKmlHPOc7pxkWkxSOUYZoQwaK+SLyh6A4Yzn8mkuFg1
         6vqg==
X-Forwarded-Encrypted: i=1; AKwUvBzv1rW8XhIQpMdpn1KzwcffRKm4Ov60w5bcavs2Mx1QRHOvkaOaJAZCJkpWxYyjAYozRhU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAkypRmsVqvHuQIEx/x1gtTLLf7zJoqmZd7MUIimiwHOd/GvuF
	3wP9xqwAyVIGioS0thsnkMk8oM0KEvb6guQzofsT/YWopGHPX5+fBuMNw6I0Bw==
X-Gm-Gg: AYBFou01P2MbTYvmcp1DWdTz3KhzVIObqnSQxXGwFc6COqlTT5Q5KyN4Swez/TgybI+
	5RJfC3GNFR3GYzj1/eroeSaJOMLTW4E7kNmlL/l7jEBcamd1eYhppH/Y060RS43Un1hV729AY7n
	/nNSsDQsnRc6CF5Ru1faG45lUKOyDqwmsTBIlrxEUSZqoA53pPPpOHNuuK1NlNQDAGzp7kntouF
	+7cuS0eKGxPu1UShv0Pu6bWFmBXyGmNo5ioS+gJDgXHACbjnAtJ6vkKIZzi5RDEeFzG0z/ZOee/
	8zMLP25TQOQFHSS0CB4kWEXYKrPhE66ssJDSQL4e4UPgzYbDBFOyvNqruEHtudJla8vYdVumleB
	2VhAEgi7jVor6qFAzCntgaKl4Hs7n5zsNp9IdfAv7V2DEmpEWCaIRpKokCyuAHYkqOAgjIrZUl0
	ZzNMv2oVp/tOcGZxGjKq0B6jwZPtr6j35aMWaZzejZF9hPfj23p15hgM8ipTD94kl8mcr7x2kvF
	xvzEq49ha6Pgj2r8aC+nZtpttfFAfk4oraNEJFYXcQds9Bv8OdY
X-Received: by 2002:a05:600c:46cf:b0:499:b65e:49c9 with SMTP id 5b1f17b1804b1-4a18e47ad5fmr340972725e9.10.1791977882882;
        Wed, 14 Oct 2026 04:38:02 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a199e5db12sm347118375e9.2.2026.10.14.04.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 04:38:02 -0700 (PDT)
Message-ID: <96c1d112-1b05-4663-90c6-33374dccd764@gmail.com>
Date: Wed, 14 Oct 2026 12:37:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/5] wrapper: reject insanely large byte counts when
 reading/writing
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
 "Randall S. Becker" <rsbecker@nexbridge.com>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
 <b1ed701935027a83574fae753e5cc11d23f0ea4b.1791958171.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <b1ed701935027a83574fae753e5cc11d23f0ea4b.1791958171.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes

On 14/10/2026 07:09, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Both the `read_in_full()` as well as the `write_in_full()` function
> accumulate the bytes transferred count in a variable of type `ssize_t`,
> but accept a `size_t` count parameter. When count exceeds `SSIZE_MAX`,
> that total count overflows after processing `SSIZE_MAX` bytes, producing
> a negative return value that callers interpret as an error (or worse, a
> small positive value after further wrapping).
> 
> In practice, git never passes such large counts because file sizes and
> buffer allocations are bounded well below SSIZE_MAX on all target
> platforms. 

Are we sure about that? In the past we've had bug fixes such as 
c14e5a1a50 (transport-helper: use xread instead of read, 2019-01-03)
on platforms where ssize_t is narrower that size_t (POSIX does not 
require them to be the same width). I've cc'd Randall to see if ssize_t 
is still narrower than size_t on the NonStop platforms git supports.

Thanks

Phillip

> The POSIX specification for `read()` and `write()` also
> limits single operations to `SSIZE_MAX` bytes, and git's
> `xread()`/`xwrite()` wrappers further clamp to `MAX_IO_SIZE`. But the
> accumulation in the `*_in_full()` wrappers means that even with per-call
> clamping, total can exceed `SSIZE_MAX` when count does.
> 
> Reject a total count that exceeds the range of `ssize_t` upfront with
> `EINVAL` rather than silently producing wrong return values, matching
> the POSIX convention for invalid arguments.
> 
> Pointed out by Coverity.
> 
> Assisted-by: Claude Opus 4.6
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   git-compat-util.h |  4 ++++
>   wrapper.c         | 10 ++++++++++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/git-compat-util.h b/git-compat-util.h
> index a0f901ce79..afce8b85b8 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -740,6 +740,10 @@ static inline uint64_t u64_add(uint64_t a, uint64_t b)
>    */
>   #define DEFAULT_IO_BUFFER_SIZE (128 * 1024)
>   
> +#ifndef SSIZE_MAX
> +# define SSIZE_MAX ((ssize_t)(((size_t)-1) >> 1))
> +#endif
> +
>   #ifdef HAVE_ALLOCA_H
>   # include <alloca.h>
>   # define xalloca(size)      (alloca(size))
> diff --git a/wrapper.c b/wrapper.c
> index 05a9cd369c..ea9c14f834 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -288,6 +288,11 @@ ssize_t read_in_full(int fd, void *buf, size_t count)
>   	char *p = buf;
>   	ssize_t total = 0;
>   
> +	if (count > SSIZE_MAX) {
> +		errno = EINVAL;
> +		return -1;
> +	}
> +
>   	while (count > 0) {
>   		ssize_t loaded = xread(fd, p, count);
>   		if (loaded < 0)
> @@ -307,6 +312,11 @@ ssize_t write_in_full(int fd, const void *buf, size_t count)
>   	const char *p = buf;
>   	ssize_t total = 0;
>   
> +	if (count > SSIZE_MAX) {
> +		errno = EINVAL;
> +		return -1;
> +	}
> +
>   	while (count > 0) {
>   		ssize_t written = xwrite(fd, p, count);
>   		if (written < 0)

