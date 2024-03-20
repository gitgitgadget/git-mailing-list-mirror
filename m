Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943CF4F8B2
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 22:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710973468; cv=none; b=mS1SMs2R1T6XCUT9jsQweIh8D7/SAMsSCEkCdPvJNJdjqSPsdsK31GfEIXAIAljoX9bYbEWFb0710rCcAXCM++3qBzol7pwj/MudDwGp2Fo1fWKANi3xFL8iZlwh3Wmn2OtGwy38VGFSrTlkCMuL1JO4MyUe3hbGfO49NOnOR8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710973468; c=relaxed/simple;
	bh=L6SYprEY/8BPam6sC7g40TLoqNw+F2fgQToIBedygvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=f6Sc0VkXnpUcXJGXYQXLOx4IVNBbuk+cbcwxbHBLOhlh/ibDwG3zggX2THdKlzMwsqwK2Pd3c2T41SxeGnTKi95rslwoZat+kQzDuycTvzOBQ6inSHdkFGJTvY5aqDYH+3z/RvqKJnuAdaHNCoV8PrO7ozr9zpQXQTTgtsxx7Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ttu39fLp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ttu39fLp"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4146feb33e1so2537715e9.2
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 15:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710973465; x=1711578265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2RnjcJDj3dgHP3fWW+JmdHkdCuUY/AkVjVbY5PQgk7Q=;
        b=Ttu39fLp3NMiQzYocP8dHjZteR8SBpS4G1lL7fz8mt/0thJ0Chfk8Zk4sypPtdPeVf
         pEtGiV7V+igwAxsBIKxd3SQbqS5XeM+Bn/z0sRz0RCBwkWdAWjlU7gIZ78dmH0hKnhP/
         CZVt1vEsphHJ8XhZNcsKFNjaHTEVWvCGPJb5JwooriCzN3s4t6km7QLvdQr543QhCPIk
         h38nfi94Zlzu71mhwKI3RvKxyODpuHChsI3yDktYPZueQFpSNZPKdlGIBmes/3vPCTCk
         s5zjxeDDzObmjTUM4AMnKOulwOFSU3t9wMHOLHbOY90h6y2nXY4TYMoLPPjtqRV+xHqW
         fsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710973465; x=1711578265;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2RnjcJDj3dgHP3fWW+JmdHkdCuUY/AkVjVbY5PQgk7Q=;
        b=wxj0Gi6uVf7M/8fq0F0bbyUFE17KNR/JTL+fg0YZcaZt9rL2ONmLVM9169lt6jw0iz
         3DKLtL62owguU1XFCK2R4rRwkY6qcCFgo898Fbe/LVtfwhkdMtFbJZGBEPgAbAUNcgga
         mZKCBYsJrYeuPxWoBrH4EK3Rj4iAx+Q3ljYBdP0WiVOLztfbzxLYLijDYQJRTMpAuLSm
         Ni8JJYrBzuj5etrAY8PYTAVxRD7MJPassM/ftnQwru3uVzKAiHLyuJOzvkECFbYXXOzR
         h7l0nvQjJYOIy+VKjcKqVArVKsf+J8D/H7/qI6BHML56dmhtVQOyIbk0vXbKdaQ9tR44
         4SFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1Bwyb/P4Qh4JwrYoOPkqxFzqtPGWYhcYfy4RhTooccDqsBueCC88BR9wNAEEzOEStlrgezJAOvS9ds+R8reubgYZp
X-Gm-Message-State: AOJu0YyYGu9AGlEDCZYF6T4I54BAuJTDXTitvtcZIHyNhrMpEjoxdBlx
	b34XAmudUUUedvwcl9k9LNsY0JcNLOYuHEcnqLYeKCiCiEWB/P5hK7i+4Hnv
X-Google-Smtp-Source: AGHT+IELV9Rl2H9y3WujHENBzskjZPaYJoKxRsqjNEkZ+3TRsDUANlGIfyoEzvERuol4oTgznrE4jQ==
X-Received: by 2002:a05:600c:524e:b0:414:1117:fcae with SMTP id fc14-20020a05600c524e00b004141117fcaemr5370058wmb.32.1710973464773;
        Wed, 20 Mar 2024 15:24:24 -0700 (PDT)
Received: from gmail.com (70.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.70])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0a5500b004146f728906sm1571656wmq.7.2024.03.20.15.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 15:24:24 -0700 (PDT)
Message-ID: <63dda239-1205-4aae-a3b2-10365147751c@gmail.com>
Date: Wed, 20 Mar 2024 23:24:08 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Feature request: highlight local worktree in `worktree list`
Content-Language: en-US
To: Matt Hickford <matt.hickford@gmail.com>,
 Git Mailing List <git@vger.kernel.org>
References: <CAGJzqsmy9RcWJeFLkZjCrrhv_y5q_R3yYUMhcyafY3jOUJFxOg@mail.gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
In-Reply-To: <CAGJzqsmy9RcWJeFLkZjCrrhv_y5q_R3yYUMhcyafY3jOUJFxOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, Mar 20, 2024 at 08:00:00 +0000, Matt Hickford wrote:
> Hi. `git branch` lists branches. It highlights the current branch with
> an asterisk and (for me) the colour green. This is handy for quick
> reading.
>
> `git worktree list` lists worktrees. It would be neat to highlight the
> local worktree.
>
> Another idea: `git branch -v` shows the commit subject and
> ahead/behind counts for each branch, eg. "[ahead 1, behind 1] avoid
> RegexReplace". It would be neat for `git worktree list -v` (or
> similar) to show the commit subject and ahead/behind counts.

Both ideas sound good.  And so do what Peff has suggested.

I want to point out that maybe "git branch [--list] -v -v" has gone
unnoticed.  It does not fully meet the expectations expressed in this
thread, but perhaps it can be of some help:

    $ git init -b foo /tmp/main
    Initialized empty Git repository in /tmp/main/.git/
    $ cd /tmp/main
    $ git commit --allow-empty -m test
    [foo (root-commit) 87382f1] test
    $ git worktree add ../wt
    Preparing worktree (new branch 'wt')
    HEAD is now at 87382f1 test
    $ git branch --set-upstream-to=wt
    Branch 'foo' set up to track local branch 'wt'.
    $ cd /tmp/wt
    $ git branch -v -v
    + foo 87382f1 (/tmp/main) [wt] test
    * wt  87382f1 test
    $ git commit --allow-empty -m test_2
    [wt df39c54] test_2
    $ git branch -v -v
    + foo 87382f1 (/tmp/main) [wt: behind 1] test
    * wt  df39c54 test_2

"git branch --list" has a much richer machinery than "git worktree list".
Perhaps the display machinery of both commands can converge in some way.
