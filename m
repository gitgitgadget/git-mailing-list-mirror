Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5E9283FE6
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 19:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782156333; cv=pass; b=KiVWuZss/Bn/RTY5R35+u4xeWpKifwPfmI9xRi+80qQEI8Bs+AyVr+9AWdQ9I/sU9AAMgYek9C/tKsXzDOaWw0EKfNbqmV2hNhsZsoOUjrLGkYDBDZiw/jwfxg8PKkzzVozKKOEb+k7M4Y0lA6YdHPxoM0m3C7DIFj1RLfcKIvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782156333; c=relaxed/simple;
	bh=avGmZL+HOBwsnx/5fDgRKhYZgDa+OFQJmP8xTvjhk2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/2+TsEDmKVMkORHbVqFjhFp9a8PI3qdux/Xq7SHBef9SjkhZVkqRYffZ/9zAIPM8OiL0iMcH1j+gewtQ6P5Ig5Y/UKPu9ojwl55q75A5UWsNLGRG7jG6GS/BEsrS/42cJcT9dMfXTpLSxdhtu4r2nvP5mxq3IGQVBqWBm+2wzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=PPxnMggd; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="PPxnMggd"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66061993121so4718618d50.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 12:25:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782156327; cv=none;
        d=google.com; s=arc-20240605;
        b=HxSwh8EdMfH3g+5npGoFeQYyOcCcXJx5ehCeJPPT6p48oUNQLjfxqr9vPcEEr6ql+F
         PDH7M344vXSFg9gknE0hfq11qjsP4k8UH3oIHLT27V4tg+Xxye3oLpT3ZCoidXI/GFx6
         kAsEUDIsfzszbczWFklwfBF3E64x+UncbFoZqQsRd9Hy14eHuaVGc2OsRnYZsjRxbE9I
         cfKAu4FWUBgp+YK0ZqqgSenvECs/Hf/Ec7j+T9EVIMti9wqjEPoWUpl/gOPgeTYVuv+r
         Bir9VCDeWuVUY9KrDJ5U6x47I+CoSR0nHpRsY5MEw6lE6KbbChYkP57Ejrz0y3itPVBE
         xUXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=avGmZL+HOBwsnx/5fDgRKhYZgDa+OFQJmP8xTvjhk2w=;
        fh=FUl2YcOqGVPD/UMyZITRPO6CESutlQJjPFWvxafa6g4=;
        b=e/VdoARx0EG2ZgIXBu4BwEEUyRY199cJLA5nwB1LhmIygpFCAiShB+dm1txw2cWD3f
         k2lvczbIe3qUQX9jtFWSaOvEq3MynyMl0ngwnRG7TzHKlvl4hfJQrGsQRL6lWXjVxPcc
         wA9bONrFQV3s3Oj5a++Kw6SSJL/Ri6T6fFJLows7GaXZP/NQvpTWcQk3eZAj3VLHW9nH
         9lk1bMAu9VWjk5rpNlyV+gwtK0w0QQ6pFzHc2t+jFxsV5MI1f2rk5CtP0R0d/GIoyF55
         tau/swhxqfDlbddiJB6hO4uzXuCRXLAPaSdcpoLvbjjkMboyRTD/lY48XRHDDOR+AAG8
         itRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782156327; x=1782761127; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=avGmZL+HOBwsnx/5fDgRKhYZgDa+OFQJmP8xTvjhk2w=;
        b=PPxnMggd6ltcOu2t2nT55QtFDBOt4TJiIYVy/KUlQ97XumQDMQcQGaWCXYqjZEMd52
         XuBpeR7KQ43eX1H2DMHPSgHNxqvZG6+tZ9kSU6HXPi779AvDtTep0yASKjfPd1VKbQLQ
         PS9rH6RcuVg18BzhdRkkf4Vz0f6qYxiFOBdLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782156327; x=1782761127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avGmZL+HOBwsnx/5fDgRKhYZgDa+OFQJmP8xTvjhk2w=;
        b=g4kOtwwPFKRb1ploSJrdPjvyRdoZ4sdTUPV9K9gS67I4AZ8/ryP8zShsEUc1F2KicB
         S6BPeXavNskxGrdwZMeM4ivapiQxa/ZuTFDP/76ZXbIA3NmZZhXwc6faUgDjUji3VGa2
         1ceKaW7VM/88yUvEz59fhRgK6ly40hP4LwImHkn4oaX2kIGK7AwWcrGv/BKx5Z+So/DZ
         iG5NVNavnJv+w6giV23yCWJ/aNEo00p5dM1ZQxprI6JPqPN6ARGKgz0F7ncMmwLRj9p0
         w8PlojtGn5t0KLjh0Gx+soEbDZCJ/qgfqfoPTPfV6V+l0+ZVP1pjtl7ZaBp+pzrIgClb
         chRw==
X-Forwarded-Encrypted: i=1; AHgh+RqzDiJTOLKT4kVhdGmHFlGO02d/8XLJkHad1IbH3lSyE8KrsddMsGSKVjIBE1t6bkJDdg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxreO6jXpg8i7Y0c9RbUIhhJ/34PdBkrpHYVW2NqvRgGXZtXty9
	ecninK4qpbA0qY27f0Nb1DKAAvE5aFlqYvGxYjY6M0hnvZZf3YpHYxLzZVhBjaEgNrArV/SawDe
	s+KsdqFRrHjenLD+goBNU5ov29sJLdhgHHzvkNh9fp/i5xu71D3gZbpU=
X-Gm-Gg: AfdE7cnYI2xaR7veQXsyNNhYh6746Bh71RGq0Zt0oSFMGMoqSrySy/PUUoTpIzxZ4ql
	V018K8o1V7I16kMXcO334yiFJ4pS+4WLFXq+cBUXqHVsau2IshN4InT6IOk+w0tMjSX22xUHwHH
	1RQcv2wKIxzd5lB+GPpDkjliiVF1o2eyYBmSkRPIyZkvelbKUsfR7rPsu5mzDbA0+vv0dIIkk5v
	1mXIVAaepAuA2H1OKj05B2hPlwR+DPF8KK4GiVCFG0E00u9+VIBT4rqk+uLxQQQk9u/p0OzrhwW
	vFBFStsZ
X-Received: by 2002:a05:690e:169a:b0:663:1548:9022 with SMTP id
 956f58d0204a3-6631548a442mr10521596d50.12.1782156327584; Mon, 22 Jun 2026
 12:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <91372b975fbe102538c05c7d2cdae356539d1bbd.1781951820.git.gitgitgadget@gmail.com>
 <1588b53d-9576-4752-9459-da48276e4b2a@gmail.com>
In-Reply-To: <1588b53d-9576-4752-9459-da48276e4b2a@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 22 Jun 2026 21:25:15 +0200
X-Gm-Features: AVVi8Cc-py1KZdt_z8yCurP3-xoxXjK9iL1apaUcIzk5dmjp1rWEWFpcv8C20Fg
Message-ID: <CAL71e4M0T4fFG4JuYTp_ZPHzNcHXf342Xkh0n0dt4LVKsuSu2Q@mail.gmail.com>
Subject: Re: [PATCH/RFC 4/6] t6600: add test cases for side-exhaustion edge cases
To: Derrick Stolee <stolee@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jun 2026 at 20:15, Derrick Stolee <stolee@gmail.com> wrote:
> It's usually my preference to see these tests show up before the
> new code arrives, that way we can see that they already work with
> the old logic and continue to work with the new logic.
>
> It's minor, but putting them after your code change may be adding
> enforcement of a change of behavior.

Agreed, I actually also prefer that in practice so I am not
sure why I ordered them this way - perhaps some attempt at
making it easier to review (show the idea and change before
the verification). I will reorder to put all new tests as the first commit
(or second, if I will also introduce a status-quo technical first).

>
> One thing that could be helpful here is to consider tracing a
> count of "commits walked" in the merge-base code, then you could
> have these tests demonstrate the performance benefit by checking
> for that number changing.

Good idea, I actually had some of that locally when developing it,
but I removed the ugly traces before submitting this. I will try to
re-introduce that in a nice way. It would be neat to let tests
inspect that side effect, though in the worst case that could make
it fragile. At the very least it's good for human debugging though.

> In t6600, that tracing number would not be the same across the
> three different data shapes (full graph, half graph, no graph) and
> that could be valuable to demonstrate in tests.

Agreed, the number of commits visited would be more interesting
than the relative performance numbers since it's an algorithmic
change rather than a micro-optimization.

Thanks,
Kristofer
