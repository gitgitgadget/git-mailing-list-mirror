Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C448136672
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751013532; cv=none; b=ll3KzJ717m+od8QNSs1P4EPkVVBw2thP+85J41Xh2sVaoIgZxW4rnMLTo3ZK/Bb0IiKSZ9iTxRhZSwooQf9H1fXqKL1rYOhO/OxLCA+Yg/SszBqm+t+6GXRTUJtu/z36SNYnk1T6gssNmMQRt4HwJNbDxrdJz+dVgzNKZYognwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751013532; c=relaxed/simple;
	bh=prkSy4Y9hDy1ppev5kXArvcLRht+FdNkNvtkOdtoOiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jb2USA68GDxX+jUo3btLCCXnwgtSvTrRZ51xZNm63Ieeg04ZGe/Tiz3Rz58PlT7bJVnoJxLQmaWgErbGYSYEsZXjJ+8XNkvp5XD9g16xbi/643R+D2Ldo+qwDPvnXByKcB/cRQOl/+OWzfboRWkd0qNqBOLkbb8l/QwOPr9NXUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gu7j45nH; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gu7j45nH"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a6f2c6715fso1999719f8f.1
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 01:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751013529; x=1751618329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PX5sEgI3yHFHk0OG9aul2BTytzqD7xE2BhpPuLsqopI=;
        b=Gu7j45nHLXqcgaRRY8C27SXNKfe6yIERsGlm6GnRtF0E8ZG7kHc76ZYURGQL0K7rlX
         xIaXgj8zjce09JQFY1b5Mmx3+AepwjWbO1N9tKo9LmVfcTQ8DksJ2XVjQpeU24WP4inQ
         LsCuGKUHucaVO+nUPL/DrsKK4jXMBXat0umKIvQQpV6BfTwXwpViJqj3wfg/bvGI8a5N
         Rg9Q2OVa0Yz/GII26uBHJS8Xc3HqxiMvd+lq7P97BB7KCMK7XkgwiwLkLXH3ZKtbmllQ
         0dgfTxc/Ggqwm+D9kNrNrIi60nVkqTVTQjf9YSr492gy4Mw3X0ArfhyCxrq73PxZZLAx
         it4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751013529; x=1751618329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PX5sEgI3yHFHk0OG9aul2BTytzqD7xE2BhpPuLsqopI=;
        b=WbEzssrxLWz452e1bYtoV6P5QbSCHBwGmZ/Q2+jxliIhyC0RjAW1Ft/h04PiOAdtv6
         L8cpLr2+O9PhE1UvLsJ8d17stVP3CzmHzqmODBkKPbHFtLqJTt8Bi0IKO6qPylkoE0XH
         t+pAPCTw5OgtcDY3Wji6HmG6xXCBO9UKjUIhPwkL2lQZKfT6wnK2idXMcTpTLO1e4vyR
         K4w2E3vgNWOVThFJc8uePKx4/Bzc9oOtzis/aMSRrEWtFh+7dTnk5v0uQnj72ZmCF5oC
         RJI2TE6/Sffw7/7y3I0sybCgUy1rRwTlkkkhfU/NMHa99tUwA1kYikSB91RiHogizowP
         mKvA==
X-Forwarded-Encrypted: i=1; AJvYcCW9pFnL3MsM1fCzDAhl4zvqq2+I9s1iDTpjMcOpDYJl1Rh43V3g25R9xOpTr9ClUTxf9QM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxDEyCepWrgeYta63w1ZHfqrvIwcB4e6gkz5dWQmb13hPIKDwf
	8Uq0Qrvo0d0lEuSVIDj9AwpAKbwDX+nEqFG6TjYFgFAPS5oXjdC5AXG+9Xbs4g==
X-Gm-Gg: ASbGnctVpIfafDOCKYuWbrk1FxfT+Xi+aojTlae3+TXasenX1kOGuKJRFNMXSW5d+yS
	ahDleRA/eTbNxCasyuyoT/4vw0/gFWgxn0Z96ZTKvN9gufuumKOOc0tEnxJipqEJz/GK8jK8eM/
	iTL5oPghHPmE6povBpxjg4MNADGVRxT3kNlAFgWAq5rQDwwqa0rVS69v7dQfjaqr+LpvBnJUFgq
	UyUO61hNcCjWSb5UcXE2DvZBO8UVvUhlgrNb6lAcXiIMVCSWPbY1QJceuGkEvnZTZNxklkYnDsV
	9IBoytjWFXdHL8/UOyfT1izT3Ra1YAq+b5Iet4myfbkON6acxblaUPQW8Q4baZAdorKwGk21uQT
	LOyzT3/AuOFw+0AAvsJxTIhHleQ1fNTpK6xt+jw==
X-Google-Smtp-Source: AGHT+IFI/tWXf/BWvW2hu/aP6xgv2wlUQdPgQq2Eg291VFT1InV64IPC3NH3pSN4CKY8OJVcLjtz9g==
X-Received: by 2002:a05:6000:2a81:b0:3a6:ec1d:1cba with SMTP id ffacd0b85a97d-3a8f482be0amr1627445f8f.20.1751013528607;
        Fri, 27 Jun 2025 01:38:48 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a390e20sm44070405e9.5.2025.06.27.01.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 01:38:48 -0700 (PDT)
Message-ID: <08804dbe-56dd-4c0e-b36b-a82768b0aa29@gmail.com>
Date: Fri, 27 Jun 2025 09:38:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] daemon: correctly handle soft accept() errors in
 service_loop
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 git@vger.kernel.org
Cc: yoshfuji@linux-ipv6.org, kristofferhaugsbakk@fastmail.com
References: <20250626161038.85966-1-carenas@gmail.com>
 <20250626172159.87204-1-carenas@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250626172159.87204-1-carenas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Carlo

On 26/06/2025 18:21, Carlo Marcelo Arenas Belón wrote:
> Since df076bdbcc ([PATCH] GIT: Listen on IPv6 as well, if available.,
> 2005-07-23), the original error checking was included in an inner loop
> unchanged, where its effect was different.
> 
> Instead of retrying, after a EINTR during accept() in the listening
> socket, it will advance to the next one and try with that instead,
> leaving the client waiting for another round.
> 
> Make sure that the loop doesn't advance

That makes sense

> and while at it, make sure
> that any possible completed children get reaped earlier.

What's the rationale for that? It means we end up calling 
reap_dead_children() twice which sounds inefficient. If it is important 
then I'm also struggling to see how it fits in with the proposal to use 
SA_RESTART

> To avoid an
> unlikely busy loop, fallback to the old behaviour after a couple
> of attempts.
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>   daemon.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/daemon.c b/daemon.c
> index d1be61fd57..f113839781 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -1145,6 +1145,7 @@ static int service_loop(struct socketlist *socklist)
>   
>   		for (size_t i = 0; i < socklist->nr; i++) {
>   			if (pfd[i].revents & POLLIN) {
> +				int incoming;
>   				union {
>   					struct sockaddr sa;
>   					struct sockaddr_in sai;
> @@ -1153,11 +1154,19 @@ static int service_loop(struct socketlist *socklist)
>   #endif
>   				} ss;
>   				socklen_t sslen = sizeof(ss);
> -				int incoming = accept(pfd[i].fd, &ss.sa, &sslen);

Why is the declaration of incoming moved but retry is declared here?

Thanks

Phillip

> +				int retry = 3;
> +
> +			redo:
> +				incoming = accept(pfd[i].fd, &ss.sa, &sslen);
>   				if (incoming < 0) {
>   					switch (errno) {
> -					case EAGAIN:
>   					case EINTR:
> +						if (--retry) {
> +							check_dead_children();
> +							goto redo;
> +						}
> +						/* fallthrough */
> +					case EAGAIN:
>   					case ECONNABORTED:
>   						continue;
>   					default:


