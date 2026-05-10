Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2633A1A58
	for <git@vger.kernel.org>; Sun, 10 May 2026 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778429298; cv=none; b=Ax3M5tWOAJUKxDgPlKjQf40HeRgKH0OdBrVC9tEdIpIeeek+TW0R40ph9olNyTvDAbxLmZFp8AeG3U/cRdbFHcjrmDqaDvpoh44jhZz27mZJ2PhZFsYKFNoJ4+i+gcqoOQ7qKgd2FHeezBMRoW92au9m6sEWEBrtiTyY87hUm4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778429298; c=relaxed/simple;
	bh=Z3yHr8n2iTyRu2FA6XAkCLYB04dI/pvBcyGK3r0YNs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCZIi3cjvRieXxTow8RPyI2AtonY4rO1drdtILkR81hAtLZI8rP22GuJldFjnzhjsfxpHUAJH26D3UAKLgsdmQCrfuVI2UL31R71PETw3p2SEy6YmbN777oOT0wZTvvGerGGldZ+QqFK8lKjY1cM+NAVU2+pDx4tmk23t5iAjhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3FPn6p6; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3FPn6p6"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8e8c0c2d2bcso483343185a.1
        for <git@vger.kernel.org>; Sun, 10 May 2026 09:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778429296; x=1779034096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+qHYRf5Jlhpk1ZJxQ0x+SWIh6uUmI3Ww+fIns6WDUHg=;
        b=C3FPn6p6jGmggpcoIor79OIfMjEuVnpNbZTb+0ntNwLnFziUpLKIBevJeMxEEichnU
         piLIAYMyI5f8ltc8xq7KqGIECtSAlVREgpxo5MHXwurn+wInYj1sCNBf0L+lVS+ybaYp
         kYqkgtNeTV29G6LY/1VT5V/wISoRoHtS6PmKIK83Gf8dZr+VD4G9PFpKBajeVDyrHrIx
         NRol1o6s/NQOTboWdStXmnvUFkOjTlG9w+eyQ9cUJfd0yqgJ/JpvwhYW7VkJ8n6sNr9z
         6V7jghlssrsfTtxgS7i/PocnL+LAmuQiSC25UQBTYktk0V87esXVHU6ixXWgWSR7H2/P
         AAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778429296; x=1779034096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qHYRf5Jlhpk1ZJxQ0x+SWIh6uUmI3Ww+fIns6WDUHg=;
        b=Z/XlivgeZ829PeWtTamyAJK9Bjhu2JJhzQIHX9f+VljwvK76iP9Y35CwSluRFO7UjF
         Hh/9KrqK1ba5GwJr3P0ZHtaj8t74QEdksvrjLNQPvUSgcz2JueOtiAQoObYNa9nL0Eq2
         Mm/oHrsCDvilefO8mPv1W0WW2hqt2LoNsX0Kr2T+bJl8bX+z3EenHlOCEKzu7Eb1Tipk
         2wKasGWNY87X/PcZ3qtmLUhqo2wHLhzIDSbk6ncu8lSZbF0sGKLgD3a99hVNLA9aYaZJ
         D4yClHhQLU3JSlMbEqgX4999Ji4J0fInyl2ogrWCVxRSwSr8lbPELVm3v4g12Y/QtmFb
         S7FQ==
X-Forwarded-Encrypted: i=1; AFNElJ//+fkWi9Fw9evU6sqL3FaaQM16NG5hT/uF4Z1dNlnktMPwwAkm5mfPqtA6X9+vT3RSf4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHKErBAdUSpwr32Me3Q7/GE9ZwJRiSBumiKBYsGL6vWnH4RfOL
	tARr6xdia0AcjnQyT/L3X4X7iLB6wyFqootFlgik8Xy8zxWHnJ9N7ap8
X-Gm-Gg: Acq92OHWTjlrQjO8MaaDEsIjWQMtspFaIXn8lFMLSF1SEh3OfRFdSJT4YRRzoaWMXb7
	ekILVxX0Jz26wb8j088gDtnf4g5oIM6UhY584TXLKT9y+4vqRKBqywCE99GasNsM5gCi36ND9mq
	nh5JfXX2ql84jSJ/vLIMwFE2qC1VB8SgEmYDtr4x1IL1zn1vTA5kOv8e/tgWeG6yVx0wfdRqldw
	QDsPiuhLeftdT4uTyxjQ8osLHNxMIIqMoYEEKTL+h+rY+4Nc+EZmiN8+ctZRaoyDwq3ZFkCpnf1
	sYVyUrTdrRXgSgae/exCFeaNkUyuShFHYGbBQbS6BrCVfy7I/VGPhvfxP5QRMimaxMjAr+SfRzB
	vju1Wpqa2LaDHOTEaMAX1IJx6yfUVj5fgmWdYqHblLsrMkxa3NDkmSE5doFkyMY/Ko6WA4KBHIq
	48RL/grp5DmBps7gINE71agPtvDM/hA61hl1DVeOixZCTgFe+g9r4+bjX9/M2FyD1nI+B9dyAJo
	ORTRZ2FahDqM2yFpr97+PpDrflnIsDNkA08BEFPTIuw/u2o
X-Received: by 2002:a05:620a:f0c:b0:8f0:7516:da99 with SMTP id af79cd13be357-904d70c4701mr3056164885a.60.1778429296092;
        Sun, 10 May 2026 09:08:16 -0700 (PDT)
Received: from ?IPV6:2605:a601:9b88:8300:bd3d:511d:814f:3a8? ([2605:a601:9b88:8300:bd3d:511d:814f:3a8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2cd04de9sm2894746885a.44.2026.05.10.09.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 09:08:15 -0700 (PDT)
Message-ID: <9ddfd37d-7d71-4359-b9be-d993fbfd138c@gmail.com>
Date: Sun, 10 May 2026 12:08:14 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: unexpected auto-maintenance, was Re: git hogs the CPU, RAM and
 storage despite its config
To: Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Cc: jean-christophe manciot <actionmystique@gmail.com>,
 Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <CAKcFC3arsYExb5dCMQspo4V9UFDadFaj8Q4PUsMWZJw_eYrMzA@mail.gmail.com>
 <20260508180341.GB737125@coredump.intra.peff.net>
 <20260509175249.GA2336928@coredump.intra.peff.net>
 <af+snTGFeoUUyfPU@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <af+snTGFeoUUyfPU@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/9/26 5:52 PM, Taylor Blau wrote:
> On Sat, May 09, 2026 at 01:52:49PM -0400, Jeff King wrote:
>> I don't think this affected the old "git gc --detach" because it takes
>> the lock after daemonizing[1]. We can't do the same here, though, since we
>> need to hold the lock for the foreground tasks. So either we need to
>> release and re-take the lock between foreground and background tasks, or
>> we need to teach the daemonize() function to update the "owner" field on
>> all of the tempfiles to the new child[2].
> 
> I agree. We can't simply do what was done in 329e6e8794c (gc: save log
> from daemonized gc --auto and print it next time, 2015-09-19), for
> exactly the reason that you stated.
> 
> Dropping and re-acquiring the lock is possible, but it's racy since
> there is a gap during the critical window while we fork(). I believe
> that the only airtight way to do this is to update the owner field of
> the tempfiles we want to pass down during daemonization.

I agree that this drop/reacquire pattern would not be a safe choice.

> (As an aside, do we want to do that for all tempfiles? It might be nice
> to have a "->reassign_on_fork" flag or something on the tempfile struct
> in case there are instances where the parent wants to retain ownership
> of the tempfile after fork()-ing, but I can't think of any off the top
> of my head. If we do introduce such a field, it should probably default
> to "true" to avoid any foot-guns.)
> 
>> Ultimately fixing the lock bug will solve that. Though if doing so is
>> too complicated for a quick maint release, I'm tempted to say we should
>> consider reverting 452b12c2e0 for a potential v2.54.1 (as there were a
>> few other regression fixes so far, I assume we'll have one soon-ish).
> 
> I think something like the following (untested) would do the trick:
> 
> --- 8< ---
> diff --git a/setup.c b/setup.c
> index 7ec4427368a..c07aeac4f7d 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -22,6 +22,7 @@
>   #include "chdir-notify.h"
>   #include "path.h"
>   #include "quote.h"
> +#include "tempfile.h"
>   #include "trace.h"
>   #include "trace2.h"
>   #include "worktree.h"
> @@ -2162,12 +2163,17 @@ int daemonize(void)
>   	errno = ENOSYS;
>   	return -1;
>   #else
> -	switch (fork()) {
> +	pid_t ppid = getpid();
> +	pid_t pid;
> +
> +	switch ((pid = fork())) {
>   		case 0:
> +			reassign_tempfile_ownership(ppid, getpid());
>   			break;
>   		case -1:
>   			die_errno(_("fork failed"));
>   		default:
> +			reassign_tempfile_ownership(ppid, pid);
>   			exit(0);
>   	}
>   	if (setsid() == -1)
> diff --git a/tempfile.c b/tempfile.c
> index 82dfa3d82f2..f0fdf582794 100644
> --- a/tempfile.c
> +++ b/tempfile.c
> @@ -373,3 +373,15 @@ int delete_tempfile(struct tempfile **tempfile_p)
> 
>   	return err ? -1 : 0;
>   }
> +
> +void reassign_tempfile_ownership(pid_t from, pid_t to)
> +{
> +	volatile struct volatile_list_head *pos;
> +
> +	list_for_each(pos, &tempfile_list) {
> +		struct tempfile *p = list_entry(pos, struct tempfile, list);
> +
> +		if (is_tempfile_active(p) && p->owner == from)
> +			p->owner = to;
> +	}
> +}

I worry that we're assigning _all_ tempfiles to the child in this
case, not just specific ones like the maintenance lock. But since
this is specifically called only in daemonize() then it may be
fine.

Is there any concern that since the child didn't create a tempfile
that the atexit() may not be initialized in the child process? Or
will that carry over from the fork() automatically? (This is hard
to test without something causing a die() in the detached process.)
> That's not too terrible to write, and I would feel OK about putting it
> in a 2.54.1 release soon-ish provided that others think it is reasonable.

I'd rather revert the geometric maintenance default for a point
release and let something more complicated like this percolate
until the next release window.

> Simply reverting 452b12c2e0 (builtin/maintenance: use "geometric"
> strategy by default, 2026-02-24) feels somewhat unsatisfying, since it
> is merely making the bug less likely rather than eliminating it
> entirely.

It does limit the behavior to those who previously chose to opt-in to
this behavior, and likely that's a low number or else we'd have more
bug reports.

> So in that sense I would prefer to "fix forward" here rather than to
> mask over the bug. But even the relatively short diff above is not so
> straightforward to reason through, review, or test, so I'm open to other
> ideas on how to proceed here.

I initially worried about cross-platform support, thinking that we
needed to pass file descriptors / handles and Windows always has
issues with file handles. But we aren't actually keeping a handle
open but instead a record that we created the lock and should delete
it when everything resolves.

For me to be convinced that this forward fix is the right direction,
I'd need to see a test that proves the detached process will clean up
the locks on a normal process end and an early exit.

Thanks,
-Stolee

