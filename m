Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43EDF1F597
	for <e@80x24.org>; Tue, 24 Jul 2018 17:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388447AbeGXSps (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 14:45:48 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:40274 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388434AbeGXSps (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 14:45:48 -0400
Received: by mail-yb0-f194.google.com with SMTP id y11-v6so1943179ybm.7
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 10:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/JIPgDhCOvjaXs1bFXrE5vZmugB970MiwlU5FZVu/W8=;
        b=GWjogrL1pMTcpROgMwVsuk9tbMsuVAu3+w39caPzgRN/Z786yOolLyAMnn24RfF/a4
         j0Qo759efLtudJUVdk/uAAyvdLS4/jXvPRaaZ9BLtU7yXIO7c9w8GAP4mphpSljKg26W
         k04dFvVOzfalvjLmbsMHtGNIVm5FjxaKwHZ5qvR7tF4ng6Kh3kVUzE2oXz4v6FW4wT67
         lOx149E13rb5CwRQlRg0gzn7r95xjelOXpMvR0nt7CZb47rjhVg9hpgO2YKJhzqD/7ZJ
         eXtaU+OQRDzSIUMXYx9EV1mcBRdNCYGYKh4k9FtTIlRVAXWfZ2+STT60xE7AZy2eg0U2
         UORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/JIPgDhCOvjaXs1bFXrE5vZmugB970MiwlU5FZVu/W8=;
        b=IAR1rfV/xDdYra4L7vYHcbk3J132wMJCSPfGP4XqV1kJlp2sw5RZnAaTSgWClR7iWJ
         87pUDKh683eDMamb+EyK8exJ9/iCGzavx8ClsZqmjXhTdrkpY2iPH/JT+OWrBWdMG9AS
         6k6SVoZOv0pJHghWCPG9spHENt3Hi0NHSafcpYtLoVEKpKT0ekbU2oqmVaRaHXd6Lv+i
         3/Cv/QqllyIPUVgtBgsoacpucOiOpyJyHvS95yxOfIa1ITWcVuDmtOZAiqwjBCGFGTkM
         aHXLj5/nn85+2Z950+0UNedn/XcoRMJo6f7ou4Sh/WFFcP5/gNe8HV7R7jEahqyatdOw
         bEmg==
X-Gm-Message-State: AOUpUlG1HLYWS6SaRz+WY2GvFWbdEc1T3mPF8eoNzr6o+qo4DH4jtwN2
        wTGsNb7DhvKgltOnW1LRGjaqlLzf9PpEZiHGi6g5UQ==
X-Google-Smtp-Source: AAOMgpf/bMQ8za9jZ2neW1VhjBwmcllaQ/YEj+xwL1rwuwEs+6AZghsee2IlijSIn1FwRsx2c21cn8eIokm2GLW42jo=
X-Received: by 2002:a25:84d0:: with SMTP id x16-v6mr10156829ybm.307.1532453894207;
 Tue, 24 Jul 2018 10:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180724003619.185290-1-sbeller@google.com> <20180724044051.GA208393@aiede.svl.corp.google.com>
In-Reply-To: <20180724044051.GA208393@aiede.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 24 Jul 2018 10:38:03 -0700
Message-ID: <CAGZ79kap9TovN2ia4pEgz33dh=9y89cVYZWnB_1e6iHpR=kDOQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation/diff-options: explain different diff algorithms
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 9:41 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi,
>
> Stefan Beller wrote:
>
> > As a user I wondered what the diff algorithms are about. Offer at least
> > a basic explanation on the differences of the diff algorithms.
>
> Interesting.  Let's see.
>
> [...]
> > --- a/Documentation/diff-options.txt
> > +++ b/Documentation/diff-options.txt
> > @@ -94,16 +94,34 @@ diff" algorithm internally.
> >       Choose a diff algorithm. The variants are as follows:
> >  +
> >  --
> > -`default`, `myers`;;
> > -     The basic greedy diff algorithm. Currently, this is the default.
> >  `minimal`;;
> > +     A diff as produced by the basic greedy algorithm described in
>
> Why this reordering?

because Myers (below) is constructed from minimal + heuristic.
Before this patch we say Myers is myers and minimal "spends
extra cycles", which is true if you read the code, as it just is

    for (...) {
        test_path
        if (need_min)
            continue;
        if (heuristic_good_enough())
            break;
    }

https://github.com/git/git/blob/master/xdiff/xdiffi.c#L152

So the "minimal" algorithm is the basic myers algorithm,
and the "myers" algorithm is the extended version (extended
with a heuristic to be fast in corner cases, still producing good
enough diffs).

>
> > +     link:http://www.xmailserver.org/diff2.pdf[An O(ND) Difference Algorithm and its Variations]
>
> This URL doesn't seem likely to stay stable.  Are appearances
> deceiving?  (Maybe so, since that's the same host as libxdiff's
> homepage <http://www.xmailserver.org/xdiff-lib.html>.)  It might be
> worth mentioning the author and date just in case.

I though about it and did not mention it, as the name
"An O(ND) Difference Algorithm and its Variations" is already
enough to find that paper quickly.

> > -     Spend extra time to make sure the smallest possible diff is
> > -     produced.
> > +`default`, `myers`;;
> > +     The same algorithm as `minimal`, extended with a heuristic to
> > +     reduce extensive searches. Currently, this is the default.
>
> Amusing --- this means that the Myers diff is spelled as "minimal"
> instead of "myers".
>
> >  `patience`;;
> > -     Use "patience diff" algorithm when generating patches.
> > +     Use "patience diff" algorithm when generating patches. This
> > +     matches the longest common subsequence of unique lines on
> > +     both sides, recursively. It obtained its name by the way the
> > +     longest subsequence is found, as that is a byproduct of the
> > +     patience sorting algorithm. If there are no unique lines left
> > +     it falls back to `myers`. Empirically this algorithm produces
> > +     a more readable output for code, but it does not garantuee
> > +     the shortest output.
>
> Probably also worth mentioning that this was invented by Bram Cohen
> for the bazaar vcs.

I tried to balance the part that reads like a history lesson and the
immediately useful part (why is this better, when should I use it?)

Mentioning bazaar probably makes sense. Not sure about the author,
but I'll include him in a reroll of this patch.

> >  `histogram`;;
> > -     This algorithm extends the patience algorithm to "support
> > -     low-occurrence common elements".
> > +     This algorithm re-implements the `patience` algorithm with
>
> What does reimplements mean here?  Do you mean that it is a variation
> on patience?

It is supposed to be a variation of patience, but as it comes with its
own implementation which I would not fully trust (as it was ported
from JGit, and reading the comments over there, a misunderstanding
of LCS made it possible to have only one midpoint before recursing)

So it is not just taking the patience algorithm and adding support for
"low-occurrence common elements"  (what does that even mean?
patience already distinguishes uniques and non-uniques), but
its own implementation, hence it is not bug-for-bug compatible.

> > +     "support of low-occurrence common elements" and only picks
> > +     one element of the LCS for the recursion. It is often the
>
> Does LCS mean longest common subsequence or longest common substring
> here?  Probably best to spell it out to avoid confusion.

When writing the patch I meant to refer to longest common subsequence
from above, but by picking just one element, this algorithm understands it
as longest common string.


>
> > +     fastest, but in cornercases (when there are many longest
>
> s/cornercases/corner cases/
>
> > +     common subsequences of the same length) it produces bad
> > +     results as seen in:
> > +
> > +             seq 1 100 >one
> > +             echo 99 > two
> > +             seq 1 2 98 >>two
> > +             git diff --no-index --histogram one two
>
> I wonder if these details (about all the algorithms) should go in a
> separate Diff Algorithms section and this section could focus on
> what use cases warrant using each, referring to that section for
> details.  What do you think?

Yeah I thought about putting together a
Documentation/technical/diffs.txt that talk about all kinds of diffing
(basic diff algorithms, options, how to diff trees), but considered
rolling this as a band aid until that document fully materializes.

Thanks,
Stefan
