Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F2C3F58F5
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781786556; cv=pass; b=MwHv6822XKRWw/RgeBaGb85iwGZEezY531o2+Mi3hz3GM4mxNpNaC1hJQgBrzn5XL4f+qvObD7gTuSS8+zX8N245/UkL/2c2MJbHPVNAi51MBGRqj8pDGXjWrhOpseg8sWxW9JcrCN4tMcsybV2nWt91nmRB4fmS/c9EqWi7roo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781786556; c=relaxed/simple;
	bh=JsC5pK65T4mDVfW6Ce+3xjZU5zKkUwqCyVd5FeKSMb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HOTCmt5LLCHbiJ6u6nXJyNuJiSiRtg3gwtPYu393UGElKDtIQFriv9nZIaurQgRg0FzEoJ3R1zO+ms/T/ua4BgvI9q53NKfx7iKKdlyMSOVfyizJJLTMq4Z6ZC6BAaf+iGoecYJFKasYz8DMmZtMZZ/bc0GGZvzu/dbLFSSwlbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyYIoSBH; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyYIoSBH"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-662bcc30fafso940198d50.2
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 05:42:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781786550; cv=none;
        d=google.com; s=arc-20240605;
        b=FVV1iHn3zWcI9bXrke7qwRjcZW3aJITwZHHdDuzq+UQFSEESk4HybwFGxD1VCe3ljc
         n4Nq5ol0+MWPHd1LkJQbmJjgz232QP+FN69jM3zhx7ExC1fWrIWs8jv7F1aQ97AIjR7w
         GwvXxIDoX7a+kTzFb/ln4LyqTpF9St04Ujw0esX6DSykEy1mhhOY9Mzn/VqXtTkGeaE1
         WUHeWOGgA6MkBASbzKy0JysDw/GF7s3beB4OiNn5TdJKANZKmHiUYr1z5SAujYf7MV5C
         TnvdfV5O6IE1J2WpjmCnmKz8zGx4L5QB+QMqwZdXa+pYlw7lEXCgZAccOUMnFhmHH6NO
         TlRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DiPs7uGk2bRdBizdq/dDsZ/flVNlypZRrepsmddPOD8=;
        fh=cZBByUo7rLZEQ1iQnPdEqG97JwM4d+gjJ4TvD0JaSKk=;
        b=Rl1QqwWiv+hBkx/UNT/i50/6jCrYVf+TQIluEzAqwWqvF1ixxHufLdm1pU6M9nQoq3
         G7TIgyfs05Q/JMoX3gHiMhPa5MqwwXWVBuSc7DR2QseMWamFcNTIUv88pHq9XoeGFr+8
         ccNexgdlBm3c+yLkZyj1iJJxwzqaDElSpIFH86I1MWK2PN8F2sqHHoe0BxlQmracQilk
         IRngirzrTEdjZJhsalYwyH0nF/sKoKlX55zs5s7De7hBot1oEzem+dg07RTiyr3K9GOt
         hf6Y1PsdMCpCb0+rydhUdPzYH64Q2YppiWUk557eyxP8Hi7SXvGSMxJ/NFebWhnNobfT
         BW6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781786550; x=1782391350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiPs7uGk2bRdBizdq/dDsZ/flVNlypZRrepsmddPOD8=;
        b=HyYIoSBHi/jzZaiik4fcS0F3ANizDm6ObwafDnfklIiaRbSEuZttfvvW33pnoY6cRJ
         1mQg5IWvaK4abLy302JRFpK7sBJOBzx2H2frnI7oFlRjT/8eRXHO8mnmdSwYRFcm9apo
         lLLX/qzTgTT+yqpp/rURKZSCCo59WR8xeUFtjEWPxEOdBIaM0hSriuue/XtX03G+MbIp
         yVYLBMRRu7cYonRramUdV2RbrckH0MUaLHV89Kxlq9M92iCuUDDGoFi0VteMNqrcX66h
         vK9AqXmM9XX+CdEeNU2GCWLneCgYOiPIXxVuVuXjjAR4YXT5g7OCBhw7LGPIvBQt9Fw4
         W7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781786550; x=1782391350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DiPs7uGk2bRdBizdq/dDsZ/flVNlypZRrepsmddPOD8=;
        b=m9U58nm5AjVMe9BoeZ3da0haRtaPRfixg6vktmxaoG8nmky3kz9EuULIl+nKKN5ri+
         msoAGRMIeYMtJxOK10Bw9/lYFY0xwXBAqlFIl3OE72sJK0dZXGdQWlh961UeBMx40ojW
         1XWTE4FgNWyiTzCdGlk42uOmmLr8w+kb/dHIO04+nW1bRVLg0nMyeVVZYpLfyqQZcOKU
         4CQ8qjDAIsJ0iPGpsYBs7jAW3yGejsuoVmchtCrTWEf+y6uFzK4ApDJiobdBPRtGDjSK
         owAnb74FkIOD0M8fB0erYorNiYDZBkw73GRL8YNfylbIcCdYh9269d1H/Lgxuim47PWZ
         F2lg==
X-Gm-Message-State: AOJu0Yzl7WAIohBYzM0YqBmU4QI6LDT/ioDD2dl4CorQIN6PwEJZtsB1
	Uc1RbJgydQ/YNIbOo4cktPojMQmKx/GY/7NN8L8FVbMwBEJwuEbTO8qfzTGQMT6/+/6jiFZ84oP
	TaNazLqUmPbCClcHpa3xt9hkbPewRQyioVbrA0O4=
X-Gm-Gg: AfdE7ckpYdejmeuezV3WGeQxwcSYYwexstJSYMpMepAgQkrlWv21ATfSpQg1/FVb7xU
	SHKblfEPkFr+0CjGv3wpA1YT4m+k0KtJ+EQOkqeVNUpDhXHcgMc8qDO5KyFdmKGkcVMWz6S1Cwr
	/WZdrro4MXAMNYmxUzsJXjb8L41WtuTzK8Tpt+W0gTvlOAV7afsmkBEl3jzTzAbioGVATsu+qNR
	hAHwNXPvBg0nHR87oe1irDWPpV1lrE6G2pHD480eKJ8wc7T5NUAHmCDvEpZ85s1F7LjPjrqzGzU
	L6vmd69j1y/gesA7M+a+RkvQ2RuHqFZRfd3unZ3s+tzF2lkKKl5vmejUKIpqbick3RHrgaAmYey
	J2mHX/xwxRjyMnYjrOlrUSa4cjoWcMCTtV7D7pMEhnYPz7n9/0GXY0PHHevc7wn4aBgpO
X-Received: by 2002:a05:690e:b89:b0:662:cf82:711e with SMTP id
 956f58d0204a3-662cf82c2e3mr7437859d50.0.1781786549493; Thu, 18 Jun 2026
 05:42:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612-ps-pre-commit-indent-v4-0-e8492037ebae@gmail.com>
 <20260613-ps-pre-commit-indent-v5-0-8d308efea63d@gmail.com>
 <20260613-ps-pre-commit-indent-v5-2-8d308efea63d@gmail.com> <20260617202744.GA3465855@coredump.intra.peff.net>
In-Reply-To: <20260617202744.GA3465855@coredump.intra.peff.net>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Thu, 18 Jun 2026 14:42:16 +0200
X-Gm-Features: AVVi8CfT0A_p_rex6XL374v6O3CL2FFFhxx-W8XegajlX3xFrvLTYKxilHPtIA8
Message-ID: <CAN5EUNSQY2oK7BE4J9Y8APfkP6eJxta050OUu=RoJYhXOjX_OA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] graph: indent visual root in graph
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, ayu.chandekar@gmail.com, chandrapratap3519@gmail.com, 
	christian.couder@gmail.com, gitster@pobox.com, jltobler@gmail.com, 
	karthik.188@gmail.com, phillip.wood@dunelm.org.uk, 
	siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mi=C3=A9, 17 jun 2026 a las 22:27, Jeff King (<peff@peff.net>) escribi=
=C3=B3:
>
> On Sat, Jun 13, 2026 at 09:09:16PM +0200, Pablo Sabater wrote:
>
> > +/*
> > + * Iterates the commits queue searching for the next visible commit, o=
nce found
> > + * sets visibleness and visual-root flags.
> > + * Knowing if the next commit is also a visual root avoids redundant i=
ndentations
> > + *
> > + * NEEDSWORK: The queue is actively being modified by the walker, for =
each commit
> > + * its parents and itself get simplified and their flags set, but for =
the next
> > + * unrelated commit or the grandparents they are not simplified yet, w=
hich means
> > + * that a commit whose parents are all filtered will not be marked as =
a visual
> > + * root candidate at the lookahead.
> > + * This causes the lookahead to fail, failing to set the cascade flag =
to avoid
> > + * redundant indentations.
> > + * See 'test_expect_failure' at t4218-log-graph-indentation.sh.
> > + */
> > +static void graph_peek_next_visible(struct git_graph *graph,
> > +                                 struct graph_lookahead_flags *flags)
> > +{
> > +     struct commit_list *cl;
> > +
> > +     flags->is_next_visible =3D 0;
> > +     flags->is_next_visual_root =3D 0;
> > +     flags->next_has_column =3D 0;
> > +
> > +     for (cl =3D graph->revs->commits; cl; cl =3D cl->next) {
> > +             if (get_commit_action(graph->revs, cl->item) !=3D commit_=
show)
> > +                     continue;
> > [...]
>
> I have a feeling this may interact badly with the prio-queue introduced
> by dd4bc01c0a (revision: use priority queue for non-limited streaming
> walks, 2026-05-27). In that commit, get_revision_1() sucks all of the
> commits from revs->commits into revs->commit_queue, and then traversal
> puts the parents into that queue, not the commits list.
>
> So during the traversal, revs->commits does not hold the complete queue
> anymore. I think it does see _some_ commits, since some get placed
> directly into revs->commits and then later moved next time
> get_revision() is called. But if we instrument the code like this:
>
> diff --git a/graph.c b/graph.c
> index e0d1e2a510..8a5f17a089 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -926,6 +926,10 @@ static void graph_peek_next_visible(struct git_graph=
 *graph,
>         flags->is_next_visual_root =3D 0;
>         flags->next_has_column =3D 0;
>
> +       warning("peeking at visible commits: %d in list, %d in queue",
> +               commit_list_count(graph->revs->commits),
> +               (int)graph->revs->commit_queue.nr);
> +
>         for (cl =3D graph->revs->commits; cl; cl =3D cl->next) {
>                 if (get_commit_action(graph->revs, cl->item) !=3D commit_=
show)
>                         continue;
>
> and run something like:
>
>   ./git log --graph --oneline -- Makefile
>
> we can see that we're always considering just one commit, while there
> may be dozens or hundreds in the queue.
>
> I'm not sure what the solution is. This function wants to peek ahead in
> queue order, possibly through multiple entries. But a heap-based queue
> inherently only supports peeking at the first entry.

Hi Jeff!

Yeah, I haven't read dd4bc01c0a yet but from what you say it prob
won't work anymore, I didn't know about that series, about the
lookahead I think it could still work with some tweaks, the important
part is to set the three lookahead flags.

From what I understood, we can only get the direct next commit, but no
more reliably ordered.

The flags should be fine:

- 'is_next_visible' could need to traverse multiple entries, but it
doesn't need them to be in order. We just need to know if something
will be rendered after.
- 'next_has_column' only needs the first entry.
- 'is_next_visual_root' only needs the first entry to know if it could
be a visual root, and also if it is not the last one (but we don't
need them to be ordered for this last part).

Should I work with 'next' as a base to have dd4bc01c0a? (Sorry I've
just worked with master).

I'll try to make it work but if not, the lookahead works to avoid
_redundant_ indentations, but it would still work correctly without
it.

>
> None of the tests seem to fail, but I'm not sure if that's because I'm
> way off base in my analysis, or there's a gap in the test coverage, or
> if this case is part of the expect_failure ones mentioned in the
> comment.
>
> I noticed because I have another topic which drops the revs->commits
> list entirely (and just always uses the queue), which of course doesn't
> compile when merged with this (I merge with 'jch' for my daily driver,
> which now includes this patch).
>
> -Peff

Thanks,
Pablo
