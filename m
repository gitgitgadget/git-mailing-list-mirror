Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CF021A458
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 08:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751013521; cv=none; b=HKhjDpJGy9hc5ypVqWnsFkSmdF6x8VKi4epIazVrlnelIGj1AjmkzKQAP4Sm9ybYXH1mH8tN1BHdvfMv0jQtRRxMROs45l+lVvgNYPLCCX1PYy4pN4DVsytZB5sTlJshUYVfWGRzFnTrQ1bSqLWFQ8D3KahQpdhlroEC23iBLo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751013521; c=relaxed/simple;
	bh=OAKo/Y7puZA44VwXTtrNCXF5VvOfMrVHileC4jApFj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swYNYQ+TjLvpNQ3u98dAo0FY/3fJ327SzgvALnNX8wBCEDiw2raS6TVS1yru0TGcCLmy7cUmmLz3I44n6kRnL6LG67gTnBymfa5Drupfsqvs6Q8fIL9DX8GW+s6pMyasbymLsEU+DvtX5LlgT5lnoxFE6c5ji9NogEoysKCNuWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JukRkblq; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JukRkblq"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-453608ed113so18124245e9.0
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 01:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751013518; x=1751618318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9gkVL9MV9qBzqXyQ4E/b6Y000RXzC6u07SI16w674MM=;
        b=JukRkblqFH10tLGIkrKpkBnNa1idTEDCFE2zc7fcFjo/eTvZv3hiT2KBGV+ydpSJCz
         sOLko9z2cjffgUDMcDvKkDnEpSZJ0tJTG2sa9zxQvTvsqvUjW81HOqfmFcMxHPQd1K32
         YNAXzOkGQbnAP4mcs+jtgDuDdNEVL+xNdzs60g4JpUMeAfXxpetns8hbY0zVvlS2pVOO
         WQKyo0cN5J0+P3CPTDelWOHqhpZVYaoPw/VwMiNo2Yle6AcoLC9EU3hMIZwXNEFyYV2L
         ptFWfeIdLHU0tgzmhwvLDfxVhhw2R+BwQgNiHurmf8ALnHe5qmC2qoGyKPSMKs5LJTGS
         hWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751013518; x=1751618318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gkVL9MV9qBzqXyQ4E/b6Y000RXzC6u07SI16w674MM=;
        b=nNfj59msQqdXUsHBVKZy2q2y7G0qrCAfzJ2lsOL2ugzsMh9fQRR9F1vWJ3om63ueo2
         obztLlbvV8fixrOOr4ZXxQs83LMROBuEVr6kucFEa9sMnKcCknk2w+Je+07fM5a8tABo
         fhTPPKwiEsavZO9vrFzULzCi+CPPrblnMQyfXQ/LtFbKJfWLIErkl1tW1Of2LQTqk5sR
         hZDWSiZ3CKQfkdUIReCRVyUR1o5XJdFGNl9XQB+WUjnNJgufarjdni5LAwGijgi9dcJ6
         l0XXxq3+KTbIlz8u/mx0Ro+a6qMQ961EARrptxC/xgzVIFpqwI3DSBBxtx4KOzBYeue9
         xqsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVA/8hCa22kzf75yMmvBXSlxYGu64Lxom+rLWAfiWfX/lYSlHvH1w7Hvprc4pXI9aR4zU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUelF5FtvcnfQmAbq4CqutEo+aqHMV45JFUQuOFnivP8yuXCUI
	zbOxP7CWJXwY1ci3wqT+N3GwvXDeKlRHKnssnswL+KihTlqQEp0mVCWG
X-Gm-Gg: ASbGncsMBtM2LhAFfnJz/Pi18H/6OzoP6XqHXSoCjGzkBGbaROjXLOXKdHosNs0Kcml
	2X5HGUGOe3AD61xCvyONqe5ggY+yP/AnaU6bNbvIRpBdwaXFhoxys3YKQkMDfCeLQrePoHbaeNd
	rUTZzPjrJFknRxXKFpyu/q4mZjB8RnLdu/pTV2+9BVzw9AZRDG0c3dGqKM+KC9CPglxtffHjvL8
	XCFfrb69zlOEBWE8imTTOpyZu3fONYgT1PIP20h2Q0AEAR/Qe4vuhSs3XYtNjE9QT4+afAwGjgS
	Rg3S9UMeHwUBppADJaCAgfTcCzRzhTC/0FbGYqvkX+orPw847o+IuP43qDErVPyqvAHec8D9HOg
	ZRwibsux6caySNdegCqigc37NMrfoCrFSX5qC2g==
X-Google-Smtp-Source: AGHT+IFELcZNsqmLjPCt+iQpYqCWHXBkCHlanv9FOHFI2Hj04+1/dijABk7f12VBN8golaGO+qOaSQ==
X-Received: by 2002:a05:600c:19cd:b0:43c:ea36:9840 with SMTP id 5b1f17b1804b1-4538ee712a0mr21260005e9.22.1751013517797;
        Fri, 27 Jun 2025 01:38:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e72b6sm2107150f8f.15.2025.06.27.01.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 01:38:37 -0700 (PDT)
Message-ID: <59087d2d-6034-44d4-9fa0-c51d4bd60683@gmail.com>
Date: Fri, 27 Jun 2025 09:38:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH] daemon: add a self pipe to trigger reaping of
 children
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 git@vger.kernel.org
Cc: chris.torek@gmail.com, gitster@pobox.com
References: <c314cd2d-8fdd-4386-bda0-881ff87d9204@gmail.com>
 <20250626182432.87523-1-carenas@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250626182432.87523-1-carenas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Carlo

On 26/06/2025 19:24, Carlo Marcelo Arenas Belón wrote:
> There has always been a small race condition between the time a
> children status is checked, and the arrival of a SIGCHLD that
> would alert us of their demise, hopefully interrupt poll().

The race was introduced by 695605b5080 (git-daemon: Simplify 
dead-children reaping logic, 2008-08-14). Before that children were 
reaped inside the signal handler so there was no race.
> To close the gap, add the reading side of a pipe to the poll and
> use the signal handler to write to it for each child.

As well as closing the race this fixes the issue with poll() not being 
interrupted when a child exits. It also allows us to move the re-arming 
of the handler into the event loop which would fix the infinite 
recursion on AIX.

> Suggested=by: Phillip Wood <phillip.wood123@gmail.com>

s/=/-/

> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
> Implements the "self pipe" trick Hillip suggested.

I've never been called that before :-/

> 
> I tried to make self healing and optional, as I also presume the race
> condition it is meant to address is very unlikely.

I see this as an alternative fix for the other problems you've been 
working on as well.

> An obvious disadvantage (at least of this implementation), is that it
> actually doubles the number of events that need to be handled for each
> children process on most cases (ex: when `poll()` gets interrupted)
> 
> I suspect that if fixing that last race condition is so important with
> the current foundation, it might be better to reintroduce some sort of
> timeout to poll(), so that they will be cleared periodically.
> 
> I had a prototype (only the bare minimum) that I thought was more
> efficient and that would instead remove completely the need for a
> signal handler which I would post (only for RFC) later.

I'm not sure injecting an fd into each child process is a good direction.

>   daemon.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 46 insertions(+), 9 deletions(-)
> 
> diff --git a/daemon.c b/daemon.c
> index d1be61fd57..d3b9421575 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -912,14 +912,17 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
>   		add_child(&cld, addr, addrlen);
>   }
>   
> -static void child_handler(int signo UNUSED)
> +int poll_pipe[2] = { -1, -1 };
Maybe call this signal_pipe? I'm not sure what poll_pipe means.

> +
> +static void child_handler(int signo)
>   {
>   	/*
> -	 * Otherwise empty handler because systemcalls will get interrupted
> -	 * upon signal receipt
>   	 * SysV needs the handler to be rearmed
>   	 */
>   	signal(SIGCHLD, child_handler);

I think from Chris' email that it is conventional to do this at the end 
of the handler. As I said above we could add an additional commit that 
moves this into the event loop to fix the infinite recursion on AIX.

> +
> +	if (poll_pipe[1] >= 0)
> +		write(poll_pipe[1], &signo, 1);

write() might fail so we should save errno around it. Conventionally one 
would re-try on EINTR as well though in this case the most likely reason 
for that is another child exiting which means the pipe would be written 
to anyway.

>   }
>   
>   static int set_reuse_addr(int sockfd)
> @@ -1121,20 +1124,43 @@ static void socksetup(struct string_list *listen_addr, int listen_port, struct s
>   static int service_loop(struct socketlist *socklist)
>   {
>   	struct pollfd *pfd;
> +	unsigned long nfds = 1 + socklist->nr;
> +
> +	ALLOC_ARRAY(pfd, nfds);
> +	if (!pipe(poll_pipe)) {

If we cannot create a pipe here then things have gone pretty badly wrong 
and I think it is unlikely we're going to be able to accept incoming 
connections so it would be best to die(). Relying on the signal pipe 
would solve the problem of children not being collected until we receive 
an new connection as well.

> +		for (int i = 0; i < 2; i++) {

The body of this loop is quite indented - I think it would be better to 
turn it into a function.

> +			int flags;
> +
> +			flags = fcntl(poll_pipe[i], F_GETFD, 0);
> +			if (flags >= 0)
> +				fcntl(poll_pipe[i], F_SETFD, flags | FD_CLOEXEC);
I think we should probably close the pipes if we do not set FD_CLOEXEC.

> +
> +			flags = fcntl(poll_pipe[i], F_GETFL, 0);
> +			if (flags < 0 || fcntl(poll_pipe[i], F_SETFL,
> +					       flags | O_NONBLOCK) == -1) {
> +				close(poll_pipe[0]);
> +				close(poll_pipe[1]);
> +				poll_pipe[0] = poll_pipe[1] = -1;
> +				break;
> +			}
> +		}
> +	}
> +	pfd[0].fd = poll_pipe[0];
> +	pfd[0].events = POLLIN;
>   
> -	CALLOC_ARRAY(pfd, socklist->nr);
> -
> -	for (size_t i = 0; i < socklist->nr; i++) {
> -		pfd[i].fd = socklist->list[i];
> +	for (size_t i = 1; i < nfds; i++) {
> +		pfd[i].fd = socklist->list[i - 1];
>   		pfd[i].events = POLLIN;
>   	}
>   
>   	signal(SIGCHLD, child_handler);
>   
>   	for (;;) {
> +		int nevents, scratch;
> +
>   		check_dead_children();
>   
> -		if (poll(pfd, socklist->nr, -1) < 0) {
> +		if ((nevents = poll(pfd, nfds, -1)) <= 0) {
>   			if (errno != EINTR) {
>   				logerror("Poll failed, resuming: %s",
>   				      strerror(errno));
				sleep(1);
			}
			continue;

We need to drain the signal pipe on EINTR. I think it would be best to 
do that just before calling check_dead_childern() above. We can avoid 
calling check_dead_children() if we don't read anything.

		}

> @@ -1143,7 +1169,17 @@ static int service_loop(struct socketlist *socklist)
>   			continue;
>   		}
>   
> -		for (size_t i = 0; i < socklist->nr; i++) {
> +		if ((pfd[0].revents & POLLIN) && pfd[0].fd != -1) {
> +			if (nevents == 1 && read(pfd[0].fd, &scratch, 1) > 0)

There can be more than one byte to read from the signal_pipe - we should 
drain it until we see EAGAIN. As I said above I think it would be better 
to do that just before calling check_dead_children(). Here we can just 
decrement nevents if poll tells us the signal_pipe is readable.

Thanks

Phillip

> +				continue;
> +			else if (!read(pfd[0].fd, &scratch, 1)) {
> +				close(pfd[0].fd);
> +				pfd[0].fd = -1;
> +			}
> +			nevents--;
> +		}
> +
> +		for (size_t i = 1; nevents && i < nfds; i++) {
>   			if (pfd[i].revents & POLLIN) {
>   				union {
>   					struct sockaddr sa;
> @@ -1165,6 +1201,7 @@ static int service_loop(struct socketlist *socklist)
>   					}
>   				}
>   				handle(incoming, &ss.sa, sslen);
> +				nevents--;
>   			}
>   		}
>   	}
