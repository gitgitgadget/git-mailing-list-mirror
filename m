Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8402D9787
	for <git@vger.kernel.org>; Fri, 15 May 2026 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850645; cv=none; b=F+rPCg1FVDE4pJPHSutZHp5mTVja9inw/5xxMUSHWAfbJQ+ZwbOtnGtcZPlPcGV/f5QILXGk03yIf7Yn8S3K2reglhU7n3+c1yg+FpvyNPojVXaJ+31vP1HTKlarsnt3WlioI+p7xwZO2cFR4hGWP54RWHCBb0exNRiVBqUw+qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850645; c=relaxed/simple;
	bh=zGOOqDKjY271d11OYEWCJDH/ME15ORdMlePyWePny+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ipDyvOv7ohofOpumuQ4UNwYbBJh5UnraRH6QaY125jkKK0+lhMY3wuzND1pdKtD6DKlGlbzE/qPpMIXvx8mTOh2+nvD9Til+aSSFXqbvtggR00Fntn8bDvD/I+70Lu5O5sFvH0YqmYOyA7xjguxxqlXXQxfAXM+fbInggGxSW04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r3YZA4X+; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3YZA4X+"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-95cc1a5fe9cso2692995241.2
        for <git@vger.kernel.org>; Fri, 15 May 2026 06:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778850643; x=1779455443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gIQVAYBmsTvJe0zMQzfUDmjkHTkR3zEuHrP5NDyYJag=;
        b=r3YZA4X+84Tl38va5lVdKGtSsU56aG/jrCtXXubdwNhzirv35BCIvVZkPNSX/3MjU5
         UvQC0q7+1wBJ9Imy31LPFJyUZr9m8ieTFBXMznS5ux/vGA3y8JO8cHwpfHQK8t49nEjL
         W+XYN/xhGLJ6Agj/a5ksCM90Ctx2/PXzabKJ1hbey5gH7fcc+OIoTssJdLWE6NXdHCEG
         csoDx+N0dlpKRQ0R5p1Y8GjAIPJtY+8CA53fmQfTsmGCuvWB8/w9B1C5cVZp0sR674dM
         Slxvu6AnZtQGkI/rCyAOqRNGdhO3KsFVz1eg2Imvbo3S22KDqmjSpp6G/qBQ8XNws2F1
         LRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778850643; x=1779455443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gIQVAYBmsTvJe0zMQzfUDmjkHTkR3zEuHrP5NDyYJag=;
        b=Xd2NRPq859qQS01rvhQQDkdxXf4r7oG65hvY5tGPPGl+/sNq+T4W9mGit6klLunb5t
         8v6EhyH2kM+NC1/cGddGabiZXOTvl6bJGUq2vsHKamDnaa7dCrGApSXNjY/6YanhkZ5q
         E9YoKx7gdcyP6jsZSAeGSqD7pQJxCLXW4tZ/DxjqHJPq2I3tKcb1cR9jagTcLTyt0eg4
         JKmGwtbl1wQEtcFiWwENjHBx1YsLP+fzx1FAt51onGM8TtCZwARSKKmD/ty8Ws0NeaKw
         ljv3MoIqNeJ6hFt0gg6TKovndZKYVfk0k594DttAC8YP3Qf2FE1n8Qj+6MZ2FhHhgF8V
         6y6g==
X-Forwarded-Encrypted: i=1; AFNElJ//XXVhjkpwPqXuYVwW3aTY4rhSdbGkXu22C1ee5QjhHY6E6sX5mopjxYTaZH5aslE56lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXRaUec3lo6irW6A4wnkzwzisNZH1E9znlrXn1Bt7G7iSHbpr/
	kbedb/IdS7gH6RK0Ii/z9C16yWXlbIxhueKlvXEoSH2wYOegsokJw5N3v+blkRQl
X-Gm-Gg: Acq92OFiW6fmRpwOr8gPRcCQBgWO0/YZesnjVD1XAaVxllYcBW728vhRTJU0K9DLrRY
	LjKTudVwT2rwfMZiGHaUEhD8Udx+A0q4h8/K3beLkvrO78I1QhozXIPSQ4ksJ2wtqbDpg5Qmpei
	S2WGrM487Fhg26DfpKWHhabKexbLWL8Td5TT2Hmoe83J85J21Zri0+0cT1TwJkD4cZeRElW0so1
	ye3Zvys+usp76xLjrdxmRujj/69BXel60wjrGIpP5bHBOG0kgbQ41lsqeArH1Jv8GWIlOBsfXKt
	g4QMARE54SYZ3NDDGOO10Btb0sga9m+1PmbDI7kJABWsxZLCpV3+or5UKXsSpmHdZg2YL3xzBQf
	mkY5QbjXDyIZi/IhCUKxDgb34a8F72pOfOiuQVndK7+6RY+g6epJFMbyjqOGRr6mjo7l5RKSnMK
	NLjh2rib46wdf+HFLJsLb9+mJTb8V0SopGvpZ50UBLC+PdXS8/1xqsAYSc2RSCkXOIsZ6jkVfqM
	Gg7gJZD
X-Received: by 2002:a05:6102:1512:b0:633:bc46:c1f2 with SMTP id ada2fe7eead31-63a3cc0b917mr1778488137.2.1778850642614;
        Fri, 15 May 2026 06:10:42 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c908e1194csm56912906d6.12.2026.05.15.06.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 06:10:41 -0700 (PDT)
Message-ID: <aad34ac2-4cd5-4c85-b8ff-14c0caaa1c7b@gmail.com>
Date: Fri, 15 May 2026 09:10:41 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] revision: use priority queue in limit_list()
To: Kristofer Karlsson <krka@spotify.com>, Jeff King <peff@peff.net>,
 Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2114.git.1778777491939.gitgitgadget@gmail.com>
 <20260515041641.GA81292@coredump.intra.peff.net>
 <CAL71e4Mfq3SCO7vnTbFCxpzH9txWPTencV-vq-aQ=wJ7dPMV2g@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAL71e4Mfq3SCO7vnTbFCxpzH9txWPTencV-vq-aQ=wJ7dPMV2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/2026 3:47 AM, Kristofer Karlsson wrote:

> Unfortunately git.git's mostly-linear history doesn't
> trigger the quadratic behavior (the queue stays narrow). Even with
> 5,584 commits in the symmetric diff, `--left-right --count` finishes
> in ~0.4s on git.git for both baseline and patched. A 50-pair
> interleaved run shows no statistically significant difference:
> 
>     git rev-list --left-right --count v2.47.1...v2.54.0 (git.git, 5,584 commits)
>     50 interleaved paired runs:
> 
>     baseline: mean 393ms, stdev 13ms, median 392ms
>     patched:  mean 396ms, stdev 14ms, median 393ms
>     paired t-test: +2.9ms, t=1.16, p>0.05 (not significant)

Thanks for sharing these details! Consider my curiosity sated. 
> The existing t/perf tests don't cover this path. p0001 doesn't
> use --left-right and p6010 is merge-base specific. I could add a
> perf test, though it would need a merge-heavy test repo to show the
> difference. Would a synthetic one (like p6010 does) be useful?

I'm usually interested in encoding ways to repeatedly exercise
these performance gains and preventing regression in the future.
However, you've demonstrated that not all repositories have a
data shape that reveals the performance problem.

If you happen to find a publicly-available repository that shows
this improvement, then documenting the performance benefits for
that repo would be sufficient. I'm familiar with performance
work that doesn't reveal its most important gains until working
with private repositories at the proper scale, so don't sweat
not having a public example.

I don't think it's worth constructing a synthetic repo to
demonstrate this issue. I was hoping that it would be low-
hanging fruit to cover this in the perf test suite, but that
does not seem to be the case.

Thanks,
-Stolee


