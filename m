Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF3411F516
	for <e@80x24.org>; Tue, 26 Jun 2018 21:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752509AbeFZVQX (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 17:16:23 -0400
Received: from mout.gmx.net ([212.227.15.19]:47059 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752489AbeFZVQW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 17:16:22 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M3AWN-1gPTRZ1GZL-00srZY; Tue, 26
 Jun 2018 23:16:14 +0200
Date:   Tue, 26 Jun 2018 23:16:12 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Tiago Botelho <tiagonbotelho@gmail.com>,
        git <git@vger.kernel.org>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Tiago Botelho <tiagonbotelho@hotmail.com>
Subject: Re: [RFC PATCH v5] Implement --first-parent for git rev-list
 --bisect
In-Reply-To: <CAP8UFD1TeC4czp_8HCRw5CtjGO78A8gRezw_xspnm4MXuhQswg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806262256400.21419@tvgsbejvaqbjf.bet>
References: <20180622123945.68852-1-tiagonbotelho@hotmail.com> <xmqq4lhqpy80.fsf@gitster-ct.c.googlers.com> <CAP8UFD3oEjW75qsk4d_wqo2V8PmzMvZLshutw20CD7AU4b4ocg@mail.gmail.com> <nycvar.QRO.7.76.6.1806261540340.21419@tvgsbejvaqbjf.bet>
 <CAP8UFD1TeC4czp_8HCRw5CtjGO78A8gRezw_xspnm4MXuhQswg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Q+GqXOW/MDlkbLVGiCkKhiOD7gAyaKSwQZV/a5WURfEr9K8XiC0
 +CcVnxUyhd/VJvFKwnhcBOrSnwZfL9MkwO2SJq/o+fuNb/J9WFMzrfpE5DknQXHMzAh+Po2
 rjzSjDAQyWtesBJ4ZNV/Fp8L2rKK4wOEtgX2Wm1c9Bo//Q+s9KuoBZ3U6c3r2Z56W4wo17t
 KWsN88t5LOQ9stehi7YPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ut3Kii7z4aw=:2BLzHve33k45q7fXSUBAtl
 om2HyxgYn2Kp8IEU570o/9lutSiUVEqv4j8bRmwO0yX7rgQIzn+pxRsD3DvS+pJRJWk7pg7dz
 X5uVd6COCHEfb+NTo0T3D21/vM8AmGjpv6UtrVGl2S7Vp3l6OpFTJwfKqwCvBSbf3DWqP+gOt
 oFGZyL0xKpLROAcWyh1yzjZ63NyWOovtaaaIBiOIoVA0ppbC5qQOQP7DISX61s1tXbJXyuuqv
 Gw79GOiD4rNL87PywsPtK3t23SkKO46wkwrwtsikwKQlROhLzzw+wIoKK1Gs4kDYop8F6AerM
 JwRazuzu1+Y/GZr27bDULr82j5PjZP5l/yV/TdoVfaoBMkETy3SNVzKoVTyJgcRkROIilNJzp
 lQQoyYohiOHC7VtMbBuU7PxunX4Cfa6N3yaKhfWXp+vM+tf8b51zN6PaKRmbAWv0jWrHFY/dv
 PfDCfCRoGkt+ssL0685yO+uAkGcqGH1zXEZSQgryAIH8c47del7KQYqGXaew/MlrxVuaNcoUG
 n2MrM9J/FXA1AavOjjmqudh15c6/Y+aRy/zirlh32apQ27Lxnn0T5+YKEkr2gwPnP4RyXeEUZ
 XTZPYFy3sjttGJjJ5tQZ3EuvU1dpdY8y8yIGJWhB2w5ijDyyVAtJJANa6A08Sf+Hn0bMtzf+t
 yAf1dNiItVGSa0rl23062TM73MuD27rXug9ZRQ8eC/CHW/eCSKq1drOMh+srDKBdeFU+v66HW
 8hkB8W9jg9E+6Qpvg6KbExCCVLMBD1CfUYPinYfPxtPC+Rhxy4Wg7muBmSw0p5fgJAkoNRd5k
 EzWoFp1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris,

On Tue, 26 Jun 2018, Christian Couder wrote:

> On Tue, Jun 26, 2018 at 4:10 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > The point, for me, is: if this test fails, at some stage in the
> > future, for any reason, it will be a major pain to even dissect what
> > the test is supposed to do.
> 
> I think the test is quite simple and there is an ascii picture, so it is
> not so difficult to understand.

So I tell you that I find it hard to understand and you try to refute this
review by... saying that it is quite simple to understand?

That's not really a basis for discussion there, if you do not even
acknowledge that both Junio and I pointed out a serious flaw in the patch.
I have no idea how you think we can reach consensus if you just deny that
there is a problem *when I just demonstrated that there is a
problem*?!?!?!

> I know that we should try to do better, but here I am mostly
> interested in moving forward a feature that people have requested for
> ages, not cleaning up those tests. If someone else like you or Junio
> thinks that it would be a good time to clean things up a bit, then I
> am ok with it, but that's not my main goal here.

This test is not good. It is not good because if even a long-time
contributor such as myself finds it too hard to understand.

So you cannot just force it forward.

> > - the graph is definitely written in an unnecessarily different format
> > than in the same test script!!!
> 
> Just above you complain about things that are similar to the previous
> tests and now you complain about things that are different...

You misunderstood. I complained that things are *not* similar to previous
tests. I said the exact opposite of what you understood.

> > - speaking of the graph: there is a perfectly fine commit graph already.
> >   Why on earth is it not reused?
> 
> Perhaps because it is more complex than needed to test this feature
> and/or to understand what happens.

What? Have you even *bothered* to look at the graphs?

If at all, the newly introduced is *less* complex (except for the
pointlessly confusing commit names). Both graphs have a branch point, a
tip commit, and a first-parent and a second-parent lineage.

So the new test introduces new commits for no good reason whatsoever, with
a diagram that is unnecessarily different from the one that is already in
the file (horizontal layout instead of vertical, and the horizontal layout
disagrees even with the existing other tests' horizontal graph diagram).

> > In this particular case it even feels as if this test is not even testing
> > what it should test at all:
> >
> > - it should verify that all of the commits in the first parent lineage are
> >   part of the list
> 
> It does that.

Yes, it does that, and you can verify that it does by, uhm, spending 10
minutes pouring over the diagram.

In my proposed test case, you see the same after reading the simple loop
and from the comment and the line count test, i.e. after spending 10
seconds.

So your "It does that" is a bit inappropriate. Of course your test does
that. In a very convoluted way. And I demonstrated that it does not have
to be convoluted at all.

> > - it should verify that none of the other commits are in the list
> 
> It does that too.

Same here. You miss the point. It is obvious in my proposed test case that
it does that. In your proposed test case it is everything but obvious.

> > And that is really all there is to test.
> 
> I don't agree. I think that when possible, especially when testing
> plumbing commands like rev-list, it is a good thing to test as many
> things as possible at once.

Then you do not understand the main purpose of regression tests, which is
to not only catch, but also to fix regressions. And your test code seems
to be designed to make the latter very, very hard. Just like your response
to my review almost appears to be designed to be defiant rather than
constructive.

If you want to accept my help in making your code better, we can continue.
Otherwise I am afraid that your patch is stuck in the "not good enough"
pile.

> > You can even write that in a much
> > easier way:
> >
> > -- snip --
> > test_expect_success '--first-parent --bisect-all lists correct revs' '
> >         git rev-list --first-parent --bisect-all F..E >revs &&
> >         # E and e1..e8 need to be shown, F and f1..f4 not
> >         test_line_count = 9 revs &&
> >         for rev in E e1 e2 e3 e4 e5 e6 e7 e8
> >         do
> >                 grep "^$(git rev-parse $rev) " revs || {
> >                         echo "$rev not shown" >&2 &&
> >                         return 1
> >                 }
> >         done
> > '
> > -- snap --
> >
> > To test more precisely for the order or the distance would be both
> > overkill and likely to be unreadable.
> 
> I don't think the previous version was either overkill or unreadable.

Okay, this is too tedious. Seriously, why do you make it so unpleasant to
help you improve the patch.

> Yeah it had other (potential in my opinion) problems, but I was trying
> with my suggestion to find a good balance between the different
> requirements (readability, complexity, maintainability, testing many
> things).
> 
> By the way with only the 2 requirements you list above, I think the
> simplest would be sorting things like I do it in my suggestion without
> checking that the (dist=X) are in the right order with just:
> 
> test_expect_success "--bisect-all --first-parent" '
>     cat >expect <<EOF &&
> $(git rev-parse CC) (dist=2)
> $(git rev-parse EX) (dist=1)
> $(git rev-parse D) (dist=1)
> $(git rev-parse FX) (dist=0)
> EOF
>     sort expect >expect_sorted &&
>     git rev-list --bisect-all --first-parent FX ^A >actual &&
>     sort actual >actual_sorted &&
>     test_cmp expect_sorted actual_sorted
> '
> 
> > To test `--bisect-vars` here would be excessive, as the part that handles
> > that particular option is not even touched. All that is touched is the
> > logic in the bisect algorithm in conjunction with --first-parent. And that
> > is all that should be tested here.
> 
> I don't agree with that. I think that as we now enable --first-parent
> with all the --bisect* options, we should test at least once all the
> --bisect* options with --first-parent.

But why? Why, why, why? Do you touch code that changes all of those code
paths? No you don't. Not at all. You change a code path that is shared by
those options, so if there is a regression, it affects all of those
options.

Your proposed test is too extensive and therefore just *wastes space and
time for no good reason*.

> > With a test like the one I outlined above, I only have one more gripe
> > about the patch: the commit message does nothing to explain this part of
> > the diff:
> >
> > +                               if ((bisect_flags & BISECT_FIRST_PARENT)) {
> > +                                       if (weight(q) < 0)
> > +                                               q = NULL;
> > +                                       break;
> > +                               }
> >
> > And I would really, really like that to be explained in the commit
> > message. Because to me, it is completely opaque why this needs to be here.
> 
> This was suggested by Junio in a previous iteration and I agree that a
> comment would be welcome.

That is a very roundabout way of saying that this explanation is required.

> > The rest of the diff is pretty obvious, though.
> 
> Thanks for taking a look anyway,

There is absolutely no need to be flippant and disrespectful about this.

Ciao,
Johannes
