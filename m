Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8782282F2C
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485597; cv=pass; b=DZyrS5c0n97nYbNfvZaHcS8jNJ5VX8RerYVWqLqMvxGClph4y6KvFaKYeRlCq8seBs1yhLvP94Ybw1XcCHiRbUQv/8vxsBLtENicmv1VaAuggapXUVwIaXKBApBr09UcMueI/2NNmqvk3RMSw9Z39KtslJjWc3U6DU/BCbJL9Iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485597; c=relaxed/simple;
	bh=RXTEdy9rtd9bGwRqeJcLaF5GQtg+hgZm9KD2LCiZv7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzIlUUKiNTWj+mR9IqftQG8AnO7KLiQfQuXCeyetuJ8Z80kDwZkZZqhpzPfBLJm30HjFOKB3nhCt8uJB+pLyhMsnnyuOeHwUOOhCj9rj27NSlCwy/3S0HDWCQt5y2lCEmKX/gxC3wG7+/O5k5D0HPEEyCIdY6QSGO2vimQC+YeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=Tbd5LMBT; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="Tbd5LMBT"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-662fa4a4470so1235719d50.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 07:53:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782485595; cv=none;
        d=google.com; s=arc-20260327;
        b=Gsvkt6QhNJgDeblmnBN+fh7I7LM+JqHGBvwXqn128kLmmsF7Cub9FnHtHalgkZnsTP
         9eKhhoEf5xZp/0HA/jOeW4sKq4er4HkfiLqfvbFbQ9aryr6zFF3LCz3txQVK+sO2Zc6J
         Iy5oMccxdrW8x6N9mnoYllIlfysSe8Xe4Azpz6GyKt2WmUEfcQQS3jJ2E4hg9rhYwT2b
         9//8a2AB8UmNgACpLB/GoX2gUhBvR44lRdmMfYw4Q3Zpi6qGgut0U55AHmcH7rlySNQf
         G+a9Gi1Ts5kmeNYRBnP9XYJ/RU8bC5Z3IC9U9UOS8ss/MpEU+U/NYocLN5NKsSF371tv
         eGMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PjQDEtIx4LX/v8sQ9a7ftrWWoBv4SBI2Z4RpyHzrCJo=;
        fh=mGdw1r4geSqKZj0eUeaHamXL+EH6MGxOJnp4uCeI8as=;
        b=eE0yM0Y+yVl9yjh1fOTes7liZMsdUvCIvKaFquWNlZrDG5To/VUorJ7DXtlQG9ptJK
         g/SQcwaxftwa/npTBuW6jX7zH/mhxArRNQ/2b0ifqj/+HvvgqmvapsA6Ke7DADEBXHTi
         iHFHPYTymUp769Rv/9G5sJSosgoahNLv957OLho1ztBxu3ezYL/bHBIyPIYne6CEG97Y
         AST+j22djNqtqLV3uhmt8CuBV7EvSo8YoZYR4rRdIb25mgBxVEU1/8pq63CbUlK/nNCU
         EwVFP4DIJKzLQbL28jwwrKJXUU8OllyINO6IAOMYkqRIQ5NVkzYaxC44WB7TvBvoISAU
         L5Sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782485595; x=1783090395; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PjQDEtIx4LX/v8sQ9a7ftrWWoBv4SBI2Z4RpyHzrCJo=;
        b=Tbd5LMBTMDe0d2dgifX2Yq/QFzZz/2rNenhsis8r8RP8w6IQ/AhnVoF7EmYTCw9ECQ
         o8YY2eiErg46545LsUVRX2E73WJo5WVvsVPucf7yne/nrvPvcUr0KlcLvXkZe3yAfGsj
         2y9LCw+Gw4EMIejDWB+2oJ0A5g6qv15Ob4cJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782485595; x=1783090395;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjQDEtIx4LX/v8sQ9a7ftrWWoBv4SBI2Z4RpyHzrCJo=;
        b=ijOoVBU3kIvD0b5t+2S6ceZw3mih5Q5XYpxtJmvP1oJU0yNX6dibrp850P4GOU4JXA
         Kt8Rx2HdAys3UhXBNc3sP7cW6GhKzMaRuzc0O2CHYo+ZrKgkqm1CagM5UT2s8U0Biall
         ioZCd2GVMtMyxcSrXorEBKXzDbFbJf3i1/z+SiCAUoYej1MrlIIG0H8S0JViOp08lAIL
         MUqayoCEk5iDOBsx4VtjLblse9hpcaeF+7unrOnzESD1oe/uxPUMjSNAcexwuws5LXTZ
         enrTmWQJ9kEJKffbtY7tf4K+sOnQ7aZVw0XXpky7FdJNOGuP29NKripdh7DtlNKzRD/S
         ovcg==
X-Forwarded-Encrypted: i=1; AHgh+RqezXKDYBs3HAf7PJwPQDDPbVNGHh3SB4G1pWQWagyY7Bog0uUM7iTCGn9FEyluC1ue/J8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxadFc/6t1dtujAfwcYgLNTfCkyaE9ZyJ2mMEGuhIsEKPZAn3pb
	yP9AuGz4v3czpKdqQQU8JL+rjzi7yZkrY3yl6L8oHDD74pm9ML3tYNTqsTojXEF/p9p54voH3Kv
	QYRu9RaWC6WgSC4KYRlKwVBaJmMtPd40vDNR5lZIGuw==
X-Gm-Gg: AfdE7cn76PWn2SgT+Whx2BbzyedP8QUgUdO1XF3P3klo9GSwHSP3mRc/KVY4+U/nXI/
	3Mp9w/3Mi512CBjhvERVDVtX5EAEi/P7/DhZcMH5IH3OAbNLYU4dfzdRX/O6PzZ6L7n8It15HnI
	X5TnPHyiHyKjRrZcqevlcTuQLWdNutS7CloTT8CECMW8DtZF/zKE1M32DH3/4Po6V7tF+hghtXp
	zDj2LcM1fbfw24SAhFHe1BMlESTBHouaFovXYo5/uIopHDbwzHAPDhpziXlrB18kGB5dqlzkQ==
X-Received: by 2002:a05:690e:128c:b0:664:8d90:25db with SMTP id
 956f58d0204a3-6648d902b19mr5014918d50.61.1782485594675; Fri, 26 Jun 2026
 07:53:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
 <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com> <4b9f192d98b8e8f2d30eed4261a73e766eeafcc2.1782479286.git.gitgitgadget@gmail.com>
 <34ff8be2-1b3c-480f-ae27-9d65875e6e62@gmail.com>
In-Reply-To: <34ff8be2-1b3c-480f-ae27-9d65875e6e62@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 26 Jun 2026 16:53:03 +0200
X-Gm-Features: AVVi8CfcxqM41sQWIlqH00he5k5WMPArXrhaS-iWGdHUXGyaBcLgJYOivNwoPoA
Message-ID: <CAL71e4PWmVjh5pQATGj1GrwgtWDZOeawKUXbKZ7DZX-DcWuCfw@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] commit-reach: move min_generation check into paint_queue_get()
To: Derrick Stolee <stolee@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jun 2026 at 16:42, Derrick Stolee <stolee@gmail.com> wrote:
>
> > +  4. Generation cutoff: the dequeued commit's generation is below
> > +     a caller-supplied `min_generation` threshold.
>
> Technically, this was always a termination condition of the walk,
> but now we are correcting the documentation to match. It was just
> not part of the termination in the dequeue method until now.

You're right, I should perhaps fold it into the first patch instead,
which would be logically more accurate. Would be an easy thing
to fix for a v4.

> >               flags = commit->object.flags & (PARENT1 | PARENT2 | STALE);
> >               if (flags == (PARENT1 | PARENT2)) {
> >                       if (!(commit->object.flags & RESULT)) {
> > @@ -219,7 +224,7 @@ static int paint_down_to_common(struct repository *r,
> >                                * descendant of this one.
> >                                */
> >                               if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
> > -                                 generation < GENERATION_NUMBER_INFINITY)
> > +                                 state.last_gen < GENERATION_NUMBER_INFINITY)
> >                                       break;
> >                       }
> >                       /* Mark parents of a found merge stale */
>
> And here's another termination condition. We are now leaking the
> abstraction of the 'state.last_gen' which give me some bad feelings.

Yes, this is one of the minor annoyances I also noticed,
but it's not too bad. I think a followup could be to either:

1. remove this optimization entirely (though I will have to spend
some time reasoning if there are realistic use cases where this
would trigger much earlier than side exhaustion.

2. tweak the logic to instead halting on exactly this commit,
instead halt inside paint_queue_get if:
   generation < INFINITY && !FIND_ALL && num_results >= 1
This would change the semantics slightly (but for the better?)
in the the found merge-base could be in the infinite region but
near the finite region and thus would unlock the optimization
as soon as we pass that boundary. But I did not want to include
that change in this series, which is perhaps already getting
too complex.

> We are getting to the point where I'd leave such a thing for a
> follow-up, but since you are needing to re-roll, then this is
> another case where we can move this into the paint_queue_get(). I
> don't think this is me "raising the bar" from earlier recommendations,
> because I was asking for all loop termination to be in the get()
> method, if possible.
>
> But also: I'm not looking at the full method right now to see if
> terminating _at this location in the loop_ is critical. So it may
> very well be impossible to move this into the get() call, in which
> case please ignore this suggestion and use state.last_gen.

I think it's not critical (as I mentioned above) and I think I will
need to follow up on this later.

Thanks,
Kristofer
