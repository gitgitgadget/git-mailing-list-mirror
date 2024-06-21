Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1284842045
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 21:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719004272; cv=none; b=q6TgkyYt/Dq6eEBSWd6d5C82WlLJVNPtAOVobgUHE/GI2G75f9kzx81vhxTbGJOf1OkA6HP1zh8y6tsVcI91okGqZL0PmEFgtWqFnla2UPcWTS3WhMoCwuLLk2lu2zLCQAtAs4vTY/31WeQQc2ENXTvLopXiYbIC4sG1JPuRMoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719004272; c=relaxed/simple;
	bh=6y/uSJvsweT/ql83FanxpTNkShabQoCf+WnF781M1lU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZPXH8ogxhLTN6o6rB1rxKvOYicHX7KztOoyHTUy6iebxIpASkjIyeqEdFXRu+Y+bDa9+3i4oGPYoA+vaaT8CvFNm+bTuPGrG0+kz2QqjSMl5MVAiZWLKOhNqEH6qzZnh9edXbJVl2/r1CbUSiX7C6dRrXeCKOEbTkae0+p6gQMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMYhgvJT; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMYhgvJT"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3650f2e540dso1535080f8f.0
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 14:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719004268; x=1719609068; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WFOxuRv9blbV/yrkmNvscDLkiqbtPVFH5EhXuMnN7Hc=;
        b=dMYhgvJTDu9gasLryrh/H13Qrigt2lB5tqxCjZ9eKYID/yRR3TO6E9uNm7HPygsw1L
         K0p680SsAicEg+51f+e6FgYIop2w7VxVtkpkmzvzOMhdMatR8ES4Yqk2gGA4tCMlqIer
         pAJXRE0wFfVl3CgXIVrpyUU3Qn4J2W+DlFW+EqwLXsjoBBbdlfOqeVFfs9b/vzJJ2Iff
         vjGYy+GV/EY8e8y9ZJ8wl8fsD6qI/j2B2I4z5wTUi7G5NfLn3m5I7ZVDR5k2IwFp1ZFx
         NWPl0tI/AxusaZw3+iZ18D5fUHUgUDQJ/Zu/x/2tQ+rQj/tBAF6+6lrD3R2HCzUTUEVW
         iwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719004268; x=1719609068;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFOxuRv9blbV/yrkmNvscDLkiqbtPVFH5EhXuMnN7Hc=;
        b=sK2Gy0/IGsrxCSOrL1gKTtJFLbULMjKXjetjbpCkHGrMBBm/FaWJ2jUAVw2TA5dhSA
         RoCuzCD63j5Uvjk9HspyhBpNxPANO12dbPFKsWnrf56tXFpfUrpMIJKRtDm1f0rz1Bs3
         K0i8Kmtlc6CfKIWSFfzwpvE2+WTvSiepI5Z/1Y+AcpGBxSShBFt8io5zCNKKyADA5/6s
         FIRZadYFSt8RUcRJoPwueq3yQvETiunWs/w9FUYl3U5PEEIS1jTl0c1kChKXZX1ogyBk
         nS9n0Gd5wv9qGjksEvY1vsW+mtxczWLQvA+nQURnVTiI8Di0nH9YPS2QPV4MUMB9u7AT
         tNAw==
X-Gm-Message-State: AOJu0Yy4llWDSxoVwT4OuG7deMyUj0K4tq0F8qIJah2iTKb4+hkcu8k6
	cD8Ge9K7T/reejbW65M4PevA7700/6Q0o+1j1F2YTyW+zQq550/bWTjAzA==
X-Google-Smtp-Source: AGHT+IFuea/iajzlvBAl4NnDSi439+DHuk4QVsXg0y3sKu/s3pOsWPX9JB11Y8UYwHFN57lYmvQkIw==
X-Received: by 2002:a5d:4390:0:b0:35f:2369:19f4 with SMTP id ffacd0b85a97d-36317b83148mr7020931f8f.34.1719004267950;
        Fri, 21 Jun 2024 14:11:07 -0700 (PDT)
Received: from gmail.com (179.red-88-14-203.dynamicip.rima-tde.net. [88.14.203.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366389b863fsm2752707f8f.47.2024.06.21.14.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 14:11:07 -0700 (PDT)
Message-ID: <7c749c2f-803d-4e97-b4f4-a97c681ed102@gmail.com>
Date: Fri, 21 Jun 2024 23:11:06 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pager: die when paging to non-existing command
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
References: <f7106878-5ec5-4fe7-940b-2fb1d9707f7d@gmail.com>
 <20240621064020.GB2105230@coredump.intra.peff.net>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <20240621064020.GB2105230@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Fri, Jun 21, 2024 at 02:40:20AM -0400, Jeff King wrote:

> > When trying to execute a non-existent program from GIT_PAGER, we display
> > an error.  However, we also send the complete text to the terminal
> > and return a successful exit code.  This can be confusing for the user
> > and the displayed error could easily become obscured by a lengthy
> > text.
> > 
> > For example, here the error message would be very far above after
> > sending 50 MB of text:
> > 
> >     $ GIT_PAGER=non-existent t/test-terminal.perl git log | wc -c
> >     error: cannot run non-existent: No such file or directory
> >     50314363
> > 
> > Let's make the error clear by aborting the process and return an error
> > so that the user can easily correct their mistake.
> > 
> > This will be the result of the change:
> > 
> >     $ GIT_PAGER=non-existent t/test-terminal.perl git log | wc -c
> >     error: cannot run non-existent: No such file or directory
> >     fatal: unable to start the pager: 'non-existent'
> >     0
> 
> OK. My initial reaction was "eh, who care? execve() failing is only one
> error mode, and we might see all kinds of failure modes from a missing
> or broken pager".
> 
> But this:
> 
> > Finally, it's worth noting that we are not changing the behavior if the
> > command specified in GIT_PAGER is a shell command.  In such cases, it
> > is:
> > 
> >     $ GIT_PAGER=:\;non-existent t/test-terminal.perl git log
> >     :;non-existent: 1: non-existent: not found
> >     died of signal 13 at t/test-terminal.perl line 33.
> 
> ...shows what happens in those other cases, and you are making things
> more consistent. So that seems reasonable to me.
> 
> > The behavior change we're introducing in this commit affects two tests
> > in t7006, which is a good sign regarding test coverage and requires us
> > to address it.
> > 
> > The first test is 'git skips paging non-existing command'.  This test
> > comes from f7991f01f2 (t7006: clean up SIGPIPE handling in trace2 tests,
> > 2021-11-21,) where a modification was made to a test that was originally
> > introduced in c24b7f6736 (pager: test for exit code with and without
> > SIGPIPE, 2021-02-02).  That original test was, IMHO, in the same
> > direction we're going in this commit.
> 
> Yeah, the point of f7991f01f2 was just to clean up the tests. The
> modification was only documenting what Git happened to do for that case
> now, and not meant as an endorsement of the behavior. ;) So I have no
> problem changing it.
> 
> > The second test being affected is: 'non-existent pager doesnt cause
> > crash', introduced in f917f57f40 (pager: fix crash when pager program
> > doesn't exist, 2021-11-24).  As its name states, it has the intention of
> > checking that we don't introduce a regression that produces a crash when
> > GIT_PAGER points to a nonexistent program.
> > 
> > This test could be considered redundant nowadays, due to us already
> > having several tests checking implicitly what a non-existent command in
> > GIT_PAGER produces.  However, let's maintain a good belt-and-suspenders
> > strategy; adapt it to the new world.
> 
> OK. I would also be happy to see it go. The crash was about reusing the
> pager child_process struct, and no we know that cannot happen. Either we
> run the pager or we immediately bail. I think that the code change in
> that commit could also be reverted (to always re-init the child
> process), but it's probably more defensive to keep it.

Yeah.  The name is what took most of my attention, I have to admit.  A
test named like "check that it doesn't crash" is defensive. ;)

Let's keep it.

Thanks for your review.
