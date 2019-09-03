Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 646FE1F461
	for <e@80x24.org>; Tue,  3 Sep 2019 18:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfICSRR (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 14:17:17 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36860 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfICSRR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 14:17:17 -0400
Received: by mail-vs1-f66.google.com with SMTP id r1so9166775vsq.3
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 11:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0R4LRj4zqBjnTHsDLrHzjdJBrbX5I/S75TTH2Mg+uNg=;
        b=SxIppOnAhQnuTfOZ9AJ5jDYMGlpbY0DKrlSmC0gaAgGb38DYeF/H7ty8ro8k5FpXSi
         kBeXiUAXAwk9BpGwCmXi1GX+H7tb/7X4oKdhx+Fm/Eu5DZoNgFV2Ps2nHzQvakg9ZCsm
         IhNhEiv5YbOwysIIoYy3hznTYjfuXGZ6XvpQwl5y++0pEPxc8LnwjSWFcOMOV1YCELk9
         3QHDtiz1ULZ+XSUjCqRfL32mevM2blfebv4byumrfLYS97aHnR0lAzItOR2I3z8PZQ59
         Z8u2md/+W07Jwt74wHJiNAS+zIqq9M4iZQ8YNBOzbJ1z5r0TZzg5EHjJe4wWlm7sdqVK
         IFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0R4LRj4zqBjnTHsDLrHzjdJBrbX5I/S75TTH2Mg+uNg=;
        b=q5PwGZ69GHxdoim4ph7qMVGXLDwWYAkRMBZvx1AlWLt2Ak71mYuvVNUd1oWqmiR5cI
         vV/KSnJlYRjCthyvyvDYzAo7oxd+RBzqv3BmxEtCffCWRR9TVbfEWsJTfZn9u9oyyVD3
         DZ+q2CXUxfTDMmWB4IVVBkb+axD6M58rN2RL1bdMmy4S7KsrfLeMy3wllkSvC5R1DXZ/
         FC9XX/M8HAiIa7X9o4u/R4KFbFnhInRe+RAEsHyJ1++f0BN6CSS7EteiCWbIBsJNUZWk
         X1yP/9mVzGJ3TfTcBtANHSk1i5ZkghdibSei/qXV9IDpPtRRf0NMqy0qmbKQrT1wmLuB
         rMyg==
X-Gm-Message-State: APjAAAWdOsQm1FeM4yt6dnVBFiLhytu+eohLR9B/Z78oJ63j3dp/CJ7+
        sMrjGY30dbH2R7e3kvJzXxdXQMC7rn20F4hwjGFTmg==
X-Google-Smtp-Source: APXvYqxqnWkqNXnf8xlcypq6ni6okDQSnvcggyTEHNaXJSGhPW0MOxJKu1DCIsx+ESyUSL2dczhou4U4nf43638DFDk=
X-Received: by 2002:a67:e886:: with SMTP id x6mr11053297vsn.117.1567534635673;
 Tue, 03 Sep 2019 11:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190815214053.16594-1-newren@gmail.com> <20190817184144.32179-1-newren@gmail.com>
 <20190817184144.32179-9-newren@gmail.com> <nycvar.QRO.7.76.6.1909030043460.46@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1909031532160.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1909031532160.46@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 3 Sep 2019 11:17:04 -0700
Message-ID: <CABPp-BF4yjZrD7-bXLa9tHgEws2zvN2zJxqnMqgtY6zm2Lvk3A@mail.gmail.com>
Subject: Re: [PATCH v4 08/24] Ensure index matches head before invoking merge
 machinery, round N
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Tue, Sep 3, 2019 at 6:34 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Tue, 3 Sep 2019, Johannes Schindelin wrote:
>
> > On Sat, 17 Aug 2019, Elijah Newren wrote:
> >
> > >   * t3030-merge-recursive.h: this test has always been broken in that=
 it
> > >     didn't make sure to make index match head before running.  But, i=
t
> > >     didn't care about the index or even the merge result, just the
> > >     verbose output while running.  While commit eddd1a411d93
> > >     ("merge-recursive: enforce rule that index matches head before
> > >     merging", 2018-06-30) should have uncovered this broken test, it
> > >     used a test_must_fail wrapper around the merge-recursive call
> > >     because it was known that the merge resulted in a rename/rename
> > >     conflict.  Thus, that fix only made this test fail for a differen=
t
> > >     reason, and since the index =3D=3D head check didn't happen until=
 after
> > >     coming all the way back out of the recursion, the testcase had
> > >     enough information to pass the one check that it did perform.
> >
> > I fear that this test is still broken, it is a Schr=C3=B6dinger bug. Wh=
ere
> > `qsort()` is the cat, and the property "is it stable?" instead of death=
.
> >
> > In particular, at some stage in the recursive merge, a diff is generate=
d
> > with rename detection for the target file `a` that contains two lines `=
hello`
> > but has two equally valid source files: `e` and `a~Temporary merge
> > branch 2_0`, both containing just the line `hello`. And since their fil=
e
> > contents are identical, the solution to the problem "which is the
> > correct source file?" is ambiguous.
> >
> > If the `qsort()` in use is stable, the file `e` comes first, and wins.
> > If the `qsort()` in use is not stable, all bets are off, and the file
> > `a~Temporary merge branch 2_0` might be sorted first (which is the case=
,
> > for example, when using the `qsort()` implementation of MS Visual C's
> > runtime).
> >
> > Now, the _real_ problem is that t3030.35 expects the recursive merge to
> > fail, which it does when `qsort()` is stable. However, when the order o=
f
> > `e` and `a~Temporary merge branch 2_0` is reversed, then that particula=
r
> > merge does _not_ result in a `rename/rename` conflict. And the exit cod=
e
> > of the recursive merge is 0 for some reason!
> >
> > I don't quite understand why: clearly, there are conflicts (otherwise w=
e
> > would not have that funny suffix `~Temporary merge branch 2_0`.

So, there are conflicts in the inner merge, but depending on the
tie-breaker for rename handling when two equal matches exist (the
tie-breaker being the order of the filenames after qsort()), there may
or may not be conflicts in the outer merge.  Ouch.

I suspect such cases are pretty rare in "real world repositories"
because (1) exactly equal filename similarities are rare, (2) "slowly
changing trees of content" implies that most files will only be
modified on (at most) one side of history, (3) when files are changed
on both sides of history odds of conflicting changes rapidly go up
making conflicts likely.  You essentially have to thread a needle to
have the end result ambiguously conflict like this.

> > The real problem, though, is that even if it would fail, the outcome of
> > that recursive merge is ambiguous, and that test case should not try to
> > verify the precise order of the generated intermediate trees.

Yes, it is ambiguous -- and the problem is a little deeper too. It's
not just "does-this-merge-conflict?" depending upon the qsort order,
it is also about whether file contents after the merge depend upon the
qsort order.  Whenever there are two filenames that are equally
similar to a rename source, picking one of the two equally similar
filenames for rename pairing means we are basically choosing at random
where to merge the changes from the other side of history to.

Unfortunately, changing this might be difficult to enforce with the
current merge-recursive structure.  For example, what if there are two
equally similar filenames for us to choose from, but the other side of
history didn't modify the rename source file at all?  (e.g. on one
side of history, user leaves A alone, on other side of history, A is
copied to B and C and then A is deleted.  B and C are identical.)  In
such cases, the choice of which of B and C we pair A up with happens
to be irrelevant because we'll get the same result either way and
there should be no merge conflict.  But if we error out early or throw
warnings and conflict notices because the intermediate internal choice
was ambiguous, then we've created useless conflicts for the user.  I'm
worried we have more cases of this kind of thing happening than we do
with ambiguous pairings that change the end result.

I think I might be able to do something here with my alternative merge
strategy, but I haven't gotten back to that for quite a while, so...

> It might not be obvious from my mail, but it took me about 7 hours to
> figure all of this out, hence I was a bit grumpy when I wrote that. My
> apologies.
>
> After having slept (and written a long review about the
> `--update-branches` patch), it occurred to me that we might be better
> off enforcing the use of `git_qsort()` in `diffcore-rename.c`, so that
> we can at least guarantee stable rename detection in Git (which would
> incidentally fix the test suite for the MSVC build that I maintain in
> Git for Windows).
>
> What do you think?

Ooh, absolutely, we should do that in the short term.  Not just
because it fixes the testsuite, but because it increases the
likelihood that folks can reproduce each others' merge problems.  I
want to be able to help users on Windows who report problems and
provide testcases, and making this fix reduces one hurdle toward doing
so.
