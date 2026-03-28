Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9928727281D
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774734071; cv=pass; b=aYlc/lHVSs4PeOtOfylxDAk4vq+S773p/fB52AwZ+3uPU3DI0okhYaGTKFQePyrA9jJT3cwvMSPOraS6Vd21H4uAbT4yZfvigKBbOMbDmY4AQ4KZw/kSH9u8EHBKm/cIvYSBSMru1alkD6DUaJ4/102Z+ML6c0ykJfMNKp6ktMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774734071; c=relaxed/simple;
	bh=Ya6ZlaxgMEvjpSvyHfGjeCbdjor4gC1Itt9r9RQ5s20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SveQi7RsSCudj4dE+DrgvKorcC7On5MUEgpNYWL1vskt3iZGiKGI/WVU+H2PKYz44aM6JvwmAHvEPFJDw77JKZPnR2wmr/5a2roCn5vPjObR6YyxVFzQp/eXhAO1cIq+9JlWdnMcve0lnKp1o2WRz6NY6PBihEKUvRMQQ37c4Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTbYL+T8; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTbYL+T8"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-829a9d08644so1714643b3a.1
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 14:41:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774734070; cv=none;
        d=google.com; s=arc-20240605;
        b=c1G/71fBDIgMaxTRBrgP6Ez8bGTDQdrLAXHadVlp/zYtIIGRD050zxulunkRebKn1L
         cQ1yXgYPFzoqC21hH5x1ft+NkLu6WIp/lyx8ec7bhnP+rj8y4AEPwp/Z/N0f0DqvuLZz
         aS6KygnNw+bT0N5TalbEL8nQ/ipj9rFqdARzswpu5AajBus3Xv82hk/14IPSYZQsvUwd
         ruXiOpa0EYQPUCytGKuWhC+NZ3b8OBR2+86W1pQ6wVhjLre/88VazbEEa/v/XAzQBFK8
         OxLBYBWG2n9MsNtAL3/S9Xf37jDNIPEibLtIr+mKd0S1ycvtCN2t/qXvDwJw0so63qyV
         Tmmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vajLIF9GrRGiFp4nQ1HC/5EShlIwUzGkwPaq+/9lrmM=;
        fh=Wpv/KwkS9n8VKjvuWfcQBhEh3YhicLpzVjyQnnFoZhU=;
        b=U0glCxGmmXda7Sx3Gi5WVKm6txUyIzlKxvaFxr1U7lUkTesW5CzZ+5s/TnwLuKBZfC
         RTRk9ZMYJ45WPFgqkW3+4alDjMuup9yhvNOWRfoRoSM26ILengPBY5BZyxIM90xjmAyv
         rQzorBwsNGNO0yO/Lhme5drJmA1TjTeYQt1nk4cQ3FX5KkDM7H5CflFgKhtEonBbIk3H
         nN+hrpj6SmICA96C9Q7Rt7A31HfHBpA+OnbhTcW9yT+wfvAkxKUYlf9cSoMwR6+ZYIUG
         bO8DSGMzxVYskUIqbadLyJ7UHjdwqx0Tphlz9Y81PUBt0R58zNYJAqtdZWoTdvaOXdp3
         jLFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774734070; x=1775338870; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vajLIF9GrRGiFp4nQ1HC/5EShlIwUzGkwPaq+/9lrmM=;
        b=nTbYL+T8NuLZ27axwkEpsBu9Us5j7vwekGBjKJqM9Qi595uHCSEcqYWjcI3qJdtK8H
         kajw1m12fmwpLxq1u67/wE8SGFfxUi4SNFCMklf1T8yodOq2eG0geSiNfHS8fJV8tg2b
         7ssxMvR9Ngu6Vyfkduc0EFbAgFOBslleys3GmDKeQkuCi+/AYYKvJP094Itah5ubqovK
         GRgUi5sWonNjhoza9XAtMdP92Z+N3fd5EBykThhT3aEiRpb8jB4SPQSPjUAO0q1X/APz
         cVAbYz579scpowkeHtgYc7MzD2BGuMI4Z1C9cqO77ko0kptCscludmNnA+maSQLTDH7b
         5ffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774734070; x=1775338870;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vajLIF9GrRGiFp4nQ1HC/5EShlIwUzGkwPaq+/9lrmM=;
        b=HHnZdEkkpBo66Ju1qQ5UxmgmttDIQFfx9mLQ1P8Ewz9O+c1KFgjJrs0PwG/aRTvS3h
         SgYfxq4nwXqMu8Au5j1yu/Fzs0i7PtVzx8jMrzxDfsZn9JTTWR/NLfmSnvghwRzPoI4G
         M+PXoTIHTMofELuNev8FbQPfo1FGdpYOKAR692tdfV0iC0UoNIae3/Sj8Kzu0eRDOj80
         EnFN6bOkuAPD3Ft8sFD/LtY/D4BKdBqhAG/fHEx/pGoqk6X6iXJVRnCKmJcj52JBpNt3
         1WZtPAyYRtkBhO5BKpU+tJVKe0guF39Weu9x1AdL09sn574euk0LSR4hFjZpvsm0OmUc
         9zUQ==
X-Gm-Message-State: AOJu0Yx74gWsB7+3Ja0rbPAuYR2FOq/J1fNRqF0S9cm5FaldZ/Zt18Kh
	gPtSJHEulpMHHNdi9CdYiakEiWysjSdLji3cDuW7sJxnzpQUYfIm/WEaXt6+A6tNYaaBpuIZVlT
	uaHWGCmOiicvbNHB+Cg4QN0dD+BTmo8uImJeoE4A=
X-Gm-Gg: ATEYQzwmcGbKmMd6TFN3PtohVFZ8qKNzE8MuEPoefGEypJC+aMBuC+YEhoVsGxS52aT
	OrQIioVjiFN/nr+94NiA9k/ASvg9Y7/Lue0KnCCoftq7+q+b7fKtd2T1Zhfq43hVhsRLDy8RTTJ
	W7+aiXAd4ZhlJPaFRGlglV+uAf2+A9yNcyHzye0Bwj5dd/3Xdbj+PV7Jc9tiT9xpzsfwSMLsA+d
	5QFA+PEDNsqTgurvrPAeKiMLG2GQ6Z4GIsqSiCT/48GayCZ/h7So8K2Fevba1McDSfkm7f37AT3
	YOCFDX4g
X-Received: by 2002:a05:6a00:2d1f:b0:829:8cfb:df45 with SMTP id
 d2e1a72fcca58-82c95e4d40bmr6847169b3a.15.1774734069860; Sat, 28 Mar 2026
 14:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322065509.5384-1-mateopatinodev@gmail.com>
 <CAPig+cRAsEgeT+OgCSpTuY_Q6dMpXrfadrB=ujkAUyF-ocu2-g@mail.gmail.com>
 <CAFRsFoV+k-8GMf=62GJwxP=o0Fy5RRBGW+h4NqOLjFbU6z96tw@mail.gmail.com> <CAPig+cQcLJxxtsH0OeSP2DVUbSg8x95B-7n18fK9BVTJVywEtQ@mail.gmail.com>
In-Reply-To: <CAPig+cQcLJxxtsH0OeSP2DVUbSg8x95B-7n18fK9BVTJVywEtQ@mail.gmail.com>
From: Mateo Patino <mateopatinodev@gmail.com>
Date: Sat, 28 Mar 2026 17:40:59 -0400
X-Gm-Features: AQROBzCnuaDoYFtemQPpJhRedOs-8jnqLsAGKO4nMvuk35Anl8eXy2IaphIl0t4
Message-ID: <CAFRsFoWRRnbrJdp_HVuoW-AEMqz_XjoP5yFAFP73VVN9nhdp2w@mail.gmail.com>
Subject: Re: [RFC] [GSoC]: STRBUF_INIT_CONST: initialize `strbuf` to constant string
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, jltobler@gmail.com, 
	ayu.chandekar@gmail.com, siddharthasthana31@gmail.com, ps@pks.im, 
	gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

>
> But, having reread the threads which your initial email referenced, I
> think the bigger issue is that we're dealing with an XY Problem[1].
> The original problem "X" being discussed was how to achieve static
> initialization of some string variables while still allowing the
> variables to be later pointed at heap-allocated memory, but at the
> same time avoiding memory leaks when those reassignments occur. The
> proposed solution "Y" was to somehow employ `strbuf` to solve X,
> however, it turns out that `strbuf` is utterly unsuitable for this
> use-case. Unfortunately, this "Y" proposal was then turned into a
> GitHub issue[2] which has led to this email thread as well as those
> aborted and misdirected submissions which you referenced earlier.

I didn't know this concept of an XY problem. It seems very useful to describe
this kind of mistake in software development. I will keep it in mind from now
on. Thanks for sharing it!

>
> If we take a step back and focus on the original problem rather than
> focusing on how to twist strbuf into something it was never meant to
> be, then a potential solution becomes clearer. Let's restate the
> original problem:
>
>   static const char *global_var = "thimble";
>
>   void maybe_assign(const char **var, ...) {
>     if (...some_condition...) {
>       /* ??? free((void *)*var) ??? */
>       *var = some_heap_allocated_str;
>     }
>   }
>
>   maybe_assign(&global_var, ...);
>   ...
>   maybe_assign(&global_var, ...);
>
> When maybe_assign() is called, it doesn't know whether or not the
> incoming `var` points at a static string literal ("thimble") or at
> some heap-allocated string, so it doesn't know whether or not to first
> free() `var` before assigning the new value. To solve this, we need a
> flag which indicates whether the string stored in the variable needs
> to be freed before the variable is reassigned. So, this suggests a
> dedicated, simple structure and a few related functions and a macro or
> two. For instance, something like this:
>
>   struct str {
>     char *s;
>     int free_me;
>   };

Thanks for explaining the original problem in such detail, I see I really
hadn't completely understood what the original problem "X" was.

To clarify, you are imagining this `struct str` more as a "smart pointer"
than a full string abstraction, correct? I was going to propose including a
`size_t len` member for this struct, but after some thought, I feel like that
would somewhat transform `struct str` into a string abstraction, which `strbuf`
already is. The way you're imagining `struct str` could be used around in the
Git codebase is as a wrapper whose only purpose is to inform clients of
a string's ownership, correct?

>
>   /* initialize `str` from a literal string (i.e. "foo") */
>   #define STR_INIT(X) { .s = (char *)(X), .free_me = 0 }
>
>   void str_release(str *x) {
>     if (x.free_me)
>       FREE_AND_NULL(x.s);
>     x.free_me = 0;
>   }
>
>   /* take ownership of a heap-allocated string */
>   void str_take(str *x, char * s) {
>     str_release(x);
>     x.s = s;
>     x.free_me = 1;
>   }
>
>   /* assign a string literal (i.e. "foo") */
>   void str_assign(str *x, const char *s) {
>     str_release(x);
>     x.s = (char *)s;
>     x.free_me = 0;
>   }
>
> That's probably about all you need to solve the stated problem.
> Given the above, the original problem statement can be "fixed" by taking
> advantage of the above structure and functions:
>
>   static struct str global_var = STR_INIT("thimble");
>
>   void maybe_assign(str *var, ...) {
>     if (...some_condition...)
>       str_assign(var, some_heap_allocated_str);
>   }
>
>   maybe_assign(&global_var, ...);
>
> Clients which need the value simply access the `.s` member directly.
> And there is no need to have any functions to morph the string in any
> way. If a client needs that functionality, it is easy enough to create
> and populate a proper `strbuf` from the `.s` member.

So if we were to make this into a patch, would we implement this as a local
helper in config.c, where the original problem started? I imagine this small
ownership interface could likely be used in multiple places around the codebase,
so my first instinct would be to not restrict it to config.c. Would it be
too premature to give this `struct str` its own module? If so, then how would an
idea of this sort be first presented to the community as a patch?

Thanks again for the detailed explanations!

> [1]: https://xyproblem.info/
> [2]: https://github.com/gitgitgadget/git/issues/398
