Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004792E5404
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750943517; cv=none; b=PqKodcg7b3J8U0TimfWVdwAS8NGfoYZs4qIZ9g4YGHW6Cz9rkT1/qmA/1ZgNb3sy8Y7NIF/WMHqwit054d9mzakkVz2MvSyosZFtMFHq1RpkFzPSCFGccefrtz3rMZW7qJo/CrZrlovcDw+ctCV34TyZqRexZNRDaNPrNIQC+JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750943517; c=relaxed/simple;
	bh=3A1PV0qiyohFAw3WCn/uJZLRIRwm04aOrDxzL2E4qWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZqf2Kdfd/TD/e1xxofzDSLdjc6SADr9FWiBVApe2zwym8pi2FLdhnme9bZMOTGlp1AnlvmJbS6JDhzfoZIAJUpXqmnr6Z2kd2iCUtX2dOBcDCS/1ikY6rYk8VEuOx7K4NNY8nOiiwBhIeo55NnhyjcZ4HOd9XndDiTBU0gMZ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cT0es+dO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cT0es+dO"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-450cfb790f7so7826715e9.0
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 06:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750943514; x=1751548314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DyrdtqymwUCsstmFFJjtyr4VlkxR61/M46rfyh4L7ss=;
        b=cT0es+dOAS7v0TcgbRKfj188inTbcYLxM2k7y1TdKA4REm+Y6ihlnYMFoHXcCli8Uv
         UC7O18g9C4QzxTWuyoJjavvNsU3TdTcb54JtzOcnLsvgqGe+BcOYUAYx4VGjyilGyyw6
         nRycA80a1g3TZWFrHaji9O7b19iiNpUO7sMCaWDYxW7CdHRSEm+m/GXmBZPjK3szKfXx
         wd5F7xwpBjSsul0FkeNa1AvBHjnjASdp/EOm30J5qc5Vj8f06J93z0yIBvNK2eqsv7PG
         MLsTE2dWGGM1U3hT0KTt9hSn5rT1uLveFaCgmfRYbALKxv+Eq4vHAavW4j9FvvQBmKsa
         uThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750943514; x=1751548314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DyrdtqymwUCsstmFFJjtyr4VlkxR61/M46rfyh4L7ss=;
        b=ga+rR6I4uGh5LZVxR8PXyfGXxxvgwGcvEaaGjER1hH3hm61Dw89xrLlC6cGpbRU1OT
         DnG6FKCRJVHHzUbigM99zn15IVVb/Fe4LJbKABrygsbVv6lUIg3IzXQvoe4m8O/dHhLj
         uo9Xso8V6CL3GeRNnExpA126YFUwQK7LGxruYtzOnCoOoAPsDRhd5edoK+BteJ3nS7MA
         3sUYo3qEIR5KSHogOG7eznZWpNE/Js3J/gp0w7KNLrZHM0A+gzID3PKrfz63nZZZBOYu
         pQDpwN9HhJaeRmod1iFihaWsSycvtIZOz9CeWkgO4KOfI4y63pXRVC/5bFTQIDzzoDwn
         Z/Ww==
X-Forwarded-Encrypted: i=1; AJvYcCX3DrbzZ3Jzo8vT0yz36vsifvA4GTXlAcf+MNPoiJcBTAXS4km0O3rWn06y+PlnEBPNUVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoAJPT/2g5CwKs2FBCTrNaoEt4YPlwQX3EZWaEWnodlKP0dErL
	Rp8LwflU2gAbWuCrqTSveFMGJ/PEFfN79bGfyAUrS8O0Sa6Nl1Zh+JKf
X-Gm-Gg: ASbGncuKUta1NEJsdi2nEeTSYKCCl4x8lT/gKA2YsP9kONtwM9RQ1B3OpIU+bk8qX4Q
	7V3HTgOPbA9caizqr6f3VM4X6WTIAI9wn/Fgzgha411PafIotrjcxQf86Hssb6rTawTmrhTyiHG
	nqSvaHvDXduRrCf2ucNBp8mRtT78tCbJyTw27a40RXAhlvoQma8TdOyHiaVcgR6vzTVX9k6NwEs
	dCMbyiNwP7VfNBKOWCWjvncmv4dFeBeZRVuct2JsHmlbne5FHFji1JeF2U1pqUtQmz56tjvRR+q
	4SPhlLzh1JbWELAh32FlEli6JqiBY6ceclWGMQeK5X/rPSFAop1As3YhCPf35W2UwRfMhCiV0qe
	mwYhGaYMuDr2HXl7dP1mCPC16dbFXYEB0NjiazCkKqzF/
X-Google-Smtp-Source: AGHT+IFIib5lyzIacLwvL/84PzRDUTXXcgHhhciQtptHvmmTkocDirEIR1C4cZZHAEn8GHf5Gq2BOw==
X-Received: by 2002:a05:600c:8b2a:b0:43c:ed61:2c26 with SMTP id 5b1f17b1804b1-45381b0f38fmr77909545e9.17.1750943514002;
        Thu, 26 Jun 2025 06:11:54 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:f8e3:1d9:71a8:62f5? ([2a0a:ef40:700:a501:f8e3:1d9:71a8:62f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c5fasm51292635e9.8.2025.06.26.06.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 06:11:53 -0700 (PDT)
Message-ID: <d7c86948-e0b0-4864-88f8-fd1222e0dffe@gmail.com>
Date: Thu, 26 Jun 2025 14:11:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] daemon: use sigaction() to install child_handler()
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 Chris Torek <chris.torek@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
References: <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
 <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
 <c66bda461f45791d278779fb0021f1e0369fe889.1750927989.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <c66bda461f45791d278779fb0021f1e0369fe889.1750927989.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Carlo

On 26/06/2025 09:53, Carlo Marcelo Arenas Belón via GitGitGadget wrote:
> From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
> 
> In a future change, the flags used for processing SIGCHLD will need to
> be updated, which is only possible by using sigaction().

Only because you have chosen to use SA_RESTART here. I think it would be 
better to drop that and instead say something like


POSIX leaves several aspects of the behavior of signal() up to the 
implementer. It is unspecified whether long running syscalls are 
restarted after an interrupt is received.  The event loop in "git 
daemon" assumes that poll() will return with EINTR if a child exits 
while it is polling but if poll() is restarted after an interrupt is 
received that does not happen which can lead to a build up of 
uncollected zombie processes.

It is also unspecified whether the handler is reset after an interrupt 
is received. In order to work correctly on operating systems such as 
Solaris where the handler for SIGCLD is reset when a signal is received 
"git daemon" calls signal() from the SIGCLD handler to re-establish a 
handler for that signal. Unfortunately this causes infinite recursion on 
other operating systems such as AIX.

Both of these problems can be addressed by using sigaction() instead of 
signal() which has much stricter semantics and so, by setting the 
appropriate flags, we can rely on poll() being interrupted and the 
SIGCLD handler not being reset. This change means that all long running 
system calls could fail with EINTR not just pall() but rest of the event 
loop code is designed to gracefully handle that.

After this change there is still a race where a child that exits after 
it has been checked in check_dead_children() but before we call poll() 
will not be collected until a new connection is received or a child 
exits while we're polling. We could fix this by using the "self-pipe 
trick" but do not because ....


Then we can drop patches 1 and 4.

Best Wishes

Phillip

> 
> Replace signal() with an equivalent invocation of sigaction(), which
> has the added benefit of using BSD semantics reliably and therefore
> not needing the rearming call in the signal handler.
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>   daemon.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/daemon.c b/daemon.c
> index d1be61fd5789..155b2e180167 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -915,11 +915,9 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
>   static void child_handler(int signo UNUSED)
>   {
>   	/*
> -	 * Otherwise empty handler because systemcalls will get interrupted
> -	 * upon signal receipt
> -	 * SysV needs the handler to be rearmed
> +	 * Otherwise empty handler because systemcalls should get interrupted
> +	 * upon signal receipt.
>   	 */
> -	signal(SIGCHLD, child_handler);
>   }
>   
>   static int set_reuse_addr(int sockfd)
> @@ -1120,6 +1118,7 @@ static void socksetup(struct string_list *listen_addr, int listen_port, struct s
>   
>   static int service_loop(struct socketlist *socklist)
>   {
> +	struct sigaction sa;
>   	struct pollfd *pfd;
>   
>   	CALLOC_ARRAY(pfd, socklist->nr);
> @@ -1129,7 +1128,10 @@ static int service_loop(struct socketlist *socklist)
>   		pfd[i].events = POLLIN;
>   	}
>   
> -	signal(SIGCHLD, child_handler);
> +	sigemptyset(&sa.sa_mask);
> +	sa.sa_flags = SA_NOCLDSTOP | SA_RESTART;
> +	sa.sa_handler = child_handler;
> +	sigaction(SIGCHLD, &sa, NULL);
>   
>   	for (;;) {
>   		check_dead_children();

