Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F7E47A57
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 11:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYSEkwll"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d60c49ee7so45871445e9.0
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 03:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704886761; x=1705491561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I887O/VdpYjIH6kzrGmqJ/znmzIL94DJyNMQi1jXvm8=;
        b=GYSEkwllWbVqjMLNwRhhBPAjaACoh2SgCfT+O1eE1wZgz4phPBS+dgo9GLLD7u6w/p
         xnSaJDnCmJzSk8f9S2vE2xOxVKXRWKZMT1PUM8V0pqrJ9rzIDrSMDvYYrEMtddmoUjKp
         zLmhix3m05bJEawjYaTIncqb3M0pGaAgSywj6uzILytSlig6s/WhXHkIP7sbQKq2t6J5
         TAKOCn64/qgmyp96n1EGnIvpSn3WRJP4SpBz3PXsT7qK/SBUrxrZHS3yWgxntURlw3IT
         l3NoynGEtM8IOryCxsW24X0djedneXNu15HPF8kgIK2IUm6qazyigHiZceg3FxrEl2Ft
         fCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704886761; x=1705491561;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I887O/VdpYjIH6kzrGmqJ/znmzIL94DJyNMQi1jXvm8=;
        b=pffp6NPo2YsUFEXN5kEdWLoebuQs0+evsYbgXQRDe9n0B8QkPk3RP6l7WWI6a1cFrg
         bF9H49rdJ3kb8nnOPLBeTRpj2S1IxRPpzXEr3PKGZKSMCS/GE4NYI3mmgCPU5Kf0fnxl
         A0gtxt4p1TT2+0ojlxUwSR9xkw71GWLZ8ycF9NplCqKsn2yv8Q2wUfwuUc3Au0X49kI7
         72BFnASX17R8/f3BuO+1JjQ8VonhQg6xgk1LtMB/tiglkWfwzoBUfe6M1SFxzvG0xkdq
         qaL5nTpNu6SfF4VWBn0tEa1DfqU5WbSyBNxB29L3qYMnxIj/k7FbfODsiBoTmxZDc9MT
         Pp6Q==
X-Gm-Message-State: AOJu0YwtOfMDgXIChy69O1N5qW1nV+iCVlbkfvN+Olf1NztQVqOthVTS
	dj4QURJJ1ZLJQBNiruRzckY=
X-Google-Smtp-Source: AGHT+IEiiVvPqh4TBtGBnbYEHjAsgJI+vRrc+sHPyZFoudkE/wjHrVcWAXzeKFgLKHcLRwV6nw45mw==
X-Received: by 2002:a7b:cd95:0:b0:40d:891e:a0a0 with SMTP id y21-20020a7bcd95000000b0040d891ea0a0mr449742wmj.162.1704886760820;
        Wed, 10 Jan 2024 03:39:20 -0800 (PST)
Received: from gmail.com (166.red-88-14-44.dynamicip.rima-tde.net. [88.14.44.166])
        by smtp.gmail.com with ESMTPSA id e8-20020a5d5008000000b00336e6014263sm4674322wrt.98.2024.01.10.03.39.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 03:39:20 -0800 (PST)
Message-ID: <40325650-166e-4936-b2ca-542a6b1f9936@gmail.com>
Date: Wed, 10 Jan 2024 12:39:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] advice: allow disabling the automatic hint in
 advise_if_enabled()
Content-Language: en-US
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
 <d6099d78-43c6-4709-9121-11f84228cf91@gmail.com>
 <20240110110226.GC16674@coredump.intra.peff.net>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <20240110110226.GC16674@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10-ene-2024 06:02:26, Jeff King wrote:
> On Tue, Jan 09, 2024 at 04:30:16PM +0100, Rubén Justo wrote:
> 
> > Using advise_if_enabled() to display an advice will automatically
> > include instructions on how to disable the advice, along with the
> > main advice:
> > 
> > 	hint: use --reapply-cherry-picks to include skipped commits
> > 	hint: Disable this message with "git config advice.skippedCherryPicks false"
> > 
> > This can become distracting or noisy over time, while the user may
> > still want to receive the main advice.
> > 
> > Let's have a switch to allow disabling this automatic advice.
> 
> If I'm reading your patch correctly, this is a single option that
> controls the extra line for _all_ advice messages. But I'd have expected
> this to be something you'd want to set on a per-message basis. Here's my
> thinking.
> 
> The original idea for advice messages was that they might be verbose and
> annoying, but if you had one that showed up a lot you'd choose to shut
> it up individually. But you wouldn't do so for _all_ messages, because
> you might benefit from seeing others (including new ones that get
> added). The "Disable this..." part was added later to help you easily
> know which config option to tweak.
> 
> The expectation was that you'd fall into one of two categories:
> 
>   1. You don't see the message often enough to care, so you do nothing.
> 
>   2. You do find it annoying, so you disable this instance.
> 
> Your series proposes a third state:
> 
>   3. You find the actual hint useful, but the verbosity of "how to shut
>      it up" is too much for you.
> 
> That make sense to me, along with being able to partially shut-up a
> message. But wouldn't you still need the "how to shut up" hint for
> _other_ messages, since it's customized for each situation?
> 
> E.g., suppose that after getting annoyed at advice.skippedCherryPicks,
> you run "git config advice.adviseOff false".
> 
> But now you run into another hint, like:
> 
>   $ git foo
>   hint: you can use --empty-commits to deal with isn't as good as --xyzzy
> 
> and you want to disable it entirely. Which advice.* config option does
> so? You're stuck trying to find it in the manpage (which is tedious but
> also kind of tricky since you're now guessing which name goes with which
> message). You probably do want:
> 
>   hint: Disable this message with "git config advice.xyzzy false"
> 
> in that case (at which point you may decide to silence it completely or
> partially).
> 
> Which implies to me that the value of advice.* should be a tri-state to
> match the cases above: true, false, or a "minimal" / "quiet" mode (there
> might be a better name). And then you'd do:
> 
>   git config advice.skippedCherryPicks minimal
> 
> (or whatever it is called) to get the mode you want, without affecting
> advice.xyzzy.

Your reasoning is sensible, but I'm not sure if we want that level of
granularity.  My guts doesn't feel it, though I'm not opposed.

In the message before yours in this thread, Junio proposed a similar
approach, and I've been thinking about it.  Let me answer to your
comments from that message too.

> 
> >  advice.c          | 3 ++-
> >  advice.h          | 3 ++-
> >  t/t0018-advice.sh | 8 ++++++++
> >  3 files changed, 12 insertions(+), 2 deletions(-)
> 
> Speaking of manpages, we'd presumably need an update to
> Documentation/config/advice.txt. :)

This has made me jump first to this message in the thread  ... I missed
this.  Thank you!

> 
> -Peff
