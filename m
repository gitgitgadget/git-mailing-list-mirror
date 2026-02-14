Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C0F1A9F96
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771087413; cv=none; b=QmWJtzUjfjUVptxYL7vhI536UKC7s23L3qGf1JMS3Y+JpxAWj6eBR8xjeQnVBfuZkhhPxo9RdxQCI4a6dWHjT5rGP3Ry5FakhV7ySpZAflMnnj+HdmpSdJQzg4BbftnvJo/B9X24NCKyTEA9pCQYHUQcJ3KQT9Nejg3WXeatd8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771087413; c=relaxed/simple;
	bh=dXZ5qTLOXIr7uDzS95GsdErenVUJW7fsT1JJ1zE+8GQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kT5gX8TIl8XKHzX3FUZRnxFWdrXZkxvcGe8DIM/qMP+6IxgrtDjbbuUmwxvX8rWB5ILxitwHakiA6HH/CZm6tF2tFSj+IhbMAfYKQ7+6LoRZQwn0InvqKmEQBpD4MSFJ0wQqKQ4FR127axIo6SuWcw4PAB9JuElnZvul7Et9BRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4QjyXfd; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4QjyXfd"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-48378136adcso7671315e9.1
        for <git@vger.kernel.org>; Sat, 14 Feb 2026 08:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771087410; x=1771692210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dJk5L52tZzELO8bJppXXD+zm5XeRFg27JRXbEwfHi3k=;
        b=B4QjyXfdYVMaJENlYkPZw/1iWC4e/gEwmfvMA0v3frZoY0g/x+Dp31cf5xElfNzHqY
         Isp1fJfdHecA23FaYet9jwIsgmlqFaBYvluZvv6dg8Crvle+KlR3ZwG8p+1nqiojtZ9y
         JQSg5GxWEcNmupQRZ5gX2GjnLKPjosOC2063q9RDOSoMkDfJzG0ZXtU1inaz5I0dzgs8
         R7ipXyr7JfjLUT7nhf/Gw+wnGP/ksoqN53j48Kqw2aW7hXi9VMmsl/YhVm7HiXDe2CMg
         7+atubjYGrtppWrf2+vDhYe8dpjSK38SfW19Iw+IrS/ujblPUW5JXpE9AZm9Wz+Ay+8c
         uxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771087410; x=1771692210;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJk5L52tZzELO8bJppXXD+zm5XeRFg27JRXbEwfHi3k=;
        b=GVChf6uFBKHxrsbrNQZyWmPaLoVM5+eDL1H+csn+D7K9fTiv5NinyDo6RRdIEzS2D8
         lwdKrERkW6a/iMhn9Tk7Z8ivlDOzQTygsjuyWB+IOFFGGcEhJc47q5xWx7O17ldn8C4q
         1PPpHK7AAzVOE0E63i7vGlrrvHNnxdZ7Q9lYthBn0kPQMIATrwgu4DZgt+wJfizf3ti1
         D08bCLtiYm8de9Jka8eO4VYu8/lAZ/q+bwqAxwt5Po7lyQHGsCIdI6ZDdjsQRp4r+rsz
         xbQeAGwAw8ZtQY/w/L1sprtaQiD2pqV1aRcEk1b4nCj5AbpwnvftikRcOyj2MRbe9OHl
         QFlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC/geZ3UvrGiVdMaoO/mWuFuPHT+qTRdN0VS06vx8LQXtpAQwUzxbXSuSKdhnoYXZxo8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyewRirpoNMLA3ONqH6HVZToOeffi2sN1xFG/DjD7CeceHX3a9k
	K/ro124T7o1XrooTTxPiYg2o8bCl14zgDDx6RcW2l+GqLyRAfCby3Boo
X-Gm-Gg: AZuq6aJlXQ+EZIFjh69Kt9VpHoZp5Qq71AIO8zBO4cFN1GgCdhCpNo5kpupVbFihxDJ
	QdFOz/KD4eD1EC5tQWf5DwvLIt7pso1xmjBvZ3PC4cT8qdlCdgJCjT4yFONgFLR75KMdF7AUZKZ
	5ZJfete7ifV08Ccr4/f+Kl7sdHg4Gms9/r/hqReO/8Xqp1CFqf2M8CiCuOlDa/GjCZHcXWpj3Jz
	fdQlY0jpHC54/EVWbZaPJzUPyDk3UDIM7/XOs7pc4KnU+/z/H4fVFjES6f+vGsL1oGgHrKD1nGs
	5wJICrlBjbA/1AtyRZQyk5QeVWySGEfn66N/Ir6e7t7VWapK0Ehhho5Vnkj+efuGOL6z1kUaTbv
	YCCmcy7EOJFUiLbJ3dcNtafz93VDUH63u1Y9sF5wKtuHq9ZXCMDGF1Ir4Gsi1cxnpVMyFZvuY2Q
	4yqrp9h+L79T9Hvg+Jg+mbGr9ihzZR9+SNW27mRcP8spsCnIS20d3JY0j7P5929yGRtkThLiE6e
	pX+xg==
X-Received: by 2002:a05:600c:1c07:b0:477:561f:6fc8 with SMTP id 5b1f17b1804b1-48379bac86bmr56845965e9.5.1771087410359;
        Sat, 14 Feb 2026 08:43:30 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:68d:f601:6840:9d65:3109:8533? ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4836aa0847asm263583315e9.3.2026.02.14.08.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Feb 2026 08:43:29 -0800 (PST)
Message-ID: <bf0b3c41-9784-4494-a932-68abfa60cea6@gmail.com>
Date: Sat, 14 Feb 2026 16:43:27 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] copy.c: use `sendfile()` for in-kernel file copying on
 Linux
To: George Hu <integral@archlinux.org>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20260213124656.218396-1-integral@archlinux.org>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260213124656.218396-1-integral@archlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/02/2026 12:46, George Hu wrote:
> The `sendfile()` system call copies data between one file descriptor
> and another within the kernel, which is more efficient than the
> combination of `read()` and `write()`.

Does git copy any files big enough that this makes a noticeable difference?

>   int copy_fd(int ifd, int ofd)
>   {
> +#ifdef __linux__

Our normal practice when a function has platform specific 
implementations is to host those implementations under compat/<platform>
(see the implementations of trace2_collect_process_information() for an 
example)

> +	struct stat ifd_st;
> +	size_t ifd_len;
> +	ssize_t ret = 0;
> +
> +	fstat(ifd, &ifd_st);

What happens if fstat() fails?

> +	ifd_len = ifd_st.st_size;
> +
> +	while (ifd_len && (ret = sendfile(ofd, ifd, NULL, ifd_len)) > 0)
> +		ifd_len -= (size_t)ret;

This does not propagate errors to the caller, if sendfile() fails the 
function returns 0. write_in_full() handles non-blocking writes, we 
should do the same here if we see EAGAIN. The man page lists various 
restrictions on the file descriptors passed to sendfile() - I'm not sure 
that they affect the uses of copy_file() in git but to be safe we should 
fall back to the read()/write() loop if we see EINVAL.

Thanks

Phillip

> +#else
>   	while (1) {
>   		char buffer[8192];
>   		ssize_t len = xread(ifd, buffer, sizeof(buffer));
> @@ -19,6 +34,8 @@ int copy_fd(int ifd, int ofd)
>   		if (write_in_full(ofd, buffer, len) < 0)
>   			return COPY_WRITE_ERROR;
>   	}
> +#endif
> +
>   	return 0;
>   }
>   

