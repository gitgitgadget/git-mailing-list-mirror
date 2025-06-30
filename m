Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912E118FDAF
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 09:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751274025; cv=none; b=P45ELohFj7rCRPZIeFJEJr15Lf3SkM0xUxqBIHsWTDidSrD2HjbOu7gHGetHpTvCLQuZGjQ30YPUecxs1zuAmMqVpp2NQKnbBPlxvkt0KLd8WX401Kns5pV141Rc/jiwWI5oij323BSyIuk34cwAAp04ks63YkMqlgdDelCLqS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751274025; c=relaxed/simple;
	bh=CIfxQ5g7NeyA4bO6rMk+nbI/+cgi6djpjoW7+h8GmRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sRb+IylAHL5pOouOp30hydzuCP66MiQk6oCKO4Gba67LuIu0NZqeYGAh2nuaj34krIR7OL5fIAJW51cuL8vNBewPPAe6tzhlAsjEjOwHzJeCY1IVqxUppNgiIf76y1qn8fRukItQYzhM39QEXMLEK2zq2djC8ICoiCNOWYnWdPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crlTU+Kj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crlTU+Kj"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so28274095e9.1
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 02:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751274022; x=1751878822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f0bEVWoq6kb2Kvv/CH4x1zonrJeCl6bDz5hh5ntprCg=;
        b=crlTU+KjHtXPnfQNWpDYyDOl2r74Kcb5ebVV89Up39Dafn2srcVKlzSKu1L3UYr8YT
         4p77BKuxa4bJlj2hSe6sKuqp5FS900TWt5pWzSQeDbsdm27kAZ8XFpTygthkuuZEVhm3
         LEeTgOyCY7MmI6fmwAqVfO8QX1dnuHVMgARF5weE2gxmtA/Pe+GdJMok5pDE534WIwAm
         OnVbTck+/Jw9eKStGb5+x3jfRPP0a+sV2ul6nPxVIyhynJugOUxWRDTLm9HIZ1Mg9iKq
         sItNYDmu+48wfY+7m6Q5nPWw8Ot1Rawigem8PLCzGTSQ+PI/tO9caTUJZj1/Whwd30qI
         XRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751274022; x=1751878822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0bEVWoq6kb2Kvv/CH4x1zonrJeCl6bDz5hh5ntprCg=;
        b=nFjisE6k0RTt3PX2em/CCLsFbJ2iGLKWPL4AatnH8VXB7H9naGwdpoiwovuEACsoe5
         XR52QVxPzEXF++4ShyDxoK0vxe0ek0qk9OW/feV5EX32Z5wyqnDTT4zKwaseI3oM+AMY
         b7gcB/pf3D5UwrEdy0J3LWZ0H7P/yIvAmav9yZ81IHns9k4GJV94uq7q1W+zHn+tVMAJ
         tm1403qSDZtjl5NsefrmTqBRVg3lnLMFyiLA8XGm2KlO7/gf8qwUDgZ2dL7ug7y4U+1W
         RBrHd0K06Tsrn6RwnvXXsqY+tI3un7jgdLw32RS8Z4Ph46SHisOsBYf91FQF4xq5dTc6
         Gb3w==
X-Forwarded-Encrypted: i=1; AJvYcCUBee3JIMqcgJtjFR1GN2bci/SvkqzuU4GVl2rdIlSyYJhERTU8i+q1tZ/lU+OaFaJLTpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9YUvsDs95S2FiuEDwBtGvw3lMJTbfuaaVfpAAROLQb73KDByW
	9MyBxfZmaNlBTs65uftP4BGDZ3ucExOmloYsIkgoa+ZHWhAyToBy9UGl
X-Gm-Gg: ASbGncveG/YiTv4cFL/UsTdn0WKqelZXeXSLRbdJq9z46zSEP/HyaXHclGlOvG6mwrx
	J81i83JWnvS0nU+CbqR82kfS9R2VsNo+3uA5G+kIhVCUDVIDnm8q0bAhcMtrg8D1vH4MsnQsH90
	XWdFX/AZ51wiuw/gvTJbqpq0AX/ehvtoCeS2j6oux2QDxVOvjF4kykl5q+jldGt9dIzdFsgGPFv
	qOiiDLcgHntAg6MnX0YqmlXVNyaYVrIXY0tYtKthd5C+nApA2HwGgSmPOYAnx8uK3kmAb2HY1+h
	eY2EbZtV7uEErDGHpXeXhZVhCuJ3ifyDmuXgfS9RVfr/+zXZej+Y+sSRhFnMGduk0ySlvsXtG0X
	U7UjWtptVE/zK2aerwmY58owOSTFFktzV7jdk5Q==
X-Google-Smtp-Source: AGHT+IHJ8Ztd3pALP2KOeADkBUDHrZBXs06ij5G8lWJ7ldYAR77tpee5rpkw8fJrTSQVS2jf3Q/Zgg==
X-Received: by 2002:a05:600c:1c0a:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-4538f2bfab9mr117429565e9.3.1751274021558;
        Mon, 30 Jun 2025 02:00:21 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823b6d50sm160417635e9.30.2025.06.30.02.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 02:00:20 -0700 (PDT)
Message-ID: <0d507273-8b8c-42d9-a14f-27a5da0dac27@gmail.com>
Date: Mon, 30 Jun 2025 10:00:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] daemon: correctly handle soft accept() errors in
 service_loop
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 git@vger.kernel.org
Cc: yoshfuji@linux-ipv6.org, kristofferhaugsbakk@fastmail.com,
 gitster@pobox.com
References: <20250626172159.87204-1-carenas@gmail.com>
 <20250627231404.27100-1-carenas@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250627231404.27100-1-carenas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Carlo

This looks good

Thanks

Phillip

On 28/06/2025 00:14, Carlo Marcelo Arenas Belón wrote:
> Since df076bdbcc ([PATCH] GIT: Listen on IPv6 as well, if available.,
> 2005-07-23), the original error checking was included in an inner loop
> unchanged, where its effect was different.
> 
> Instead of retrying, after a EINTR during accept() in the listening
> socket, it will advance to the next one and try with that instead,
> leaving the client waiting for another round.
> 
> Make sure to retry with the same listener socket that failed originally.
> 
> To avoid an unlikely busy loop, fallback to the old behaviour after a
> couple of attempts.
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>   daemon.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/daemon.c b/daemon.c
> index d1be61fd57..9ac9efa17c 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -1153,11 +1153,19 @@ static int service_loop(struct socketlist *socklist)
>   #endif
>   				} ss;
>   				socklen_t sslen = sizeof(ss);
> -				int incoming = accept(pfd[i].fd, &ss.sa, &sslen);
> +				int incoming;
> +				int retry = 3;
> +
> +			redo:
> +				incoming = accept(pfd[i].fd, &ss.sa, &sslen);
>   				if (incoming < 0) {
>   					switch (errno) {
> -					case EAGAIN:
>   					case EINTR:
> +						if (--retry)
> +							goto redo;
> +
> +						/* fallthrough */
> +					case EAGAIN:
>   					case ECONNABORTED:
>   						continue;
>   					default:

