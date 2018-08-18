Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF6B71FC7F
	for <e@80x24.org>; Sat, 18 Aug 2018 20:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbeHSABW (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 20:01:22 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:42561 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbeHSABW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 20:01:22 -0400
Received: by mail-vk0-f66.google.com with SMTP id t4-v6so4820006vke.9
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 13:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P/qv8r33yyWFzhZeaU9tB0heeiNVeWQNPWDjnfpZXOQ=;
        b=Aq45duhyiMPV+6U6kKPqwHWSzltNetgRCPAEt28cbG0wn3w7vhJ5rS4bAAGjt+umXG
         6An0EiA2P0u4pozEQOWKMw718i/vJEe51gw8xpeLxvZ+16hoolnl2uzYOz5VszH6e8Ms
         Ck53trITYiJeTZFrGNEJkH1GA4UYUtpElx48KZ5yjFNKbMg/VG5OWso66TzUSKbTLMn+
         C1ekcE0pZhugkbKN81m8jeL3vDng9K2Wn2zO4vXltFpzTncs0nWeZOSbY6UXUPPI/jyw
         C0jP+cRQyBUM4bYP6faLAIdroAgjHlk6H/2vVrI2h6aeijnhMOAivtVGDRjfP6CgWOUm
         wbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P/qv8r33yyWFzhZeaU9tB0heeiNVeWQNPWDjnfpZXOQ=;
        b=q/7hZBQt1dWEIxrLQ5Z+DQR1qAgm/7SccHW1kd7IlUWPzN7LvIXpwph8K7CHVGywjQ
         AgHR3WO60q4ygy5REvI8bEIaeRgNHW79PpayEclyRtd87sYNo29g972GUvcjsITXEE8g
         d5Fz6BVkuIvo5LeQEzXWGwHRDPm+/2JVabgDJw3TZBKK3VYGfRNuf2ypiLUQFuxQwwwQ
         u+8wzXr+ti3Gvm8HsUqtoUQF4NM5J5fLPJvi61S2+Yyrp5Cj58wzNaGLnPzkJAlNy8am
         sNuuhg1Fxy3/tFPG/1o8hbLck2f6PPyJLF4r+/X0jL5HYJtT2mltqCzWF6zxw95e+TlG
         6ltw==
X-Gm-Message-State: AOUpUlFaqhYht96/FD1mtUl2KyADWu+zEJyeb3zn8wd/Us6AiZe+8jl9
        a9vrHJgjetBlhjJJJ1J4fjon4ostrZsc7jHKoPk=
X-Google-Smtp-Source: AA+uWPwG6YeMAbq3xo9/3KJK0/lK9vNH3Hknf/S/UxGgUVt3qMeqIXcllRx2FRZi+YnvIj+2fb8YjjpVEyTVy8nIu5U=
X-Received: by 2002:a1f:5c7:: with SMTP id 190-v6mr26286841vkf.47.1534625542513;
 Sat, 18 Aug 2018 13:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180806152524.27516-1-newren@gmail.com> <20180807164905.3859-1-newren@gmail.com>
 <CAM0VKjn6QAp-hQa3Qp07qZ2unNk20SXYoPwwFbpiLfqqx+KV+A@mail.gmail.com>
In-Reply-To: <CAM0VKjn6QAp-hQa3Qp07qZ2unNk20SXYoPwwFbpiLfqqx+KV+A@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 18 Aug 2018 13:52:10 -0700
Message-ID: <CABPp-BG2q9b1og50auV6-u6hV7Vht8Dxojk8E1802pDpCNnObg@mail.gmail.com>
Subject: Re: [PATCHv3 0/5] Simple fixes to t7406
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Aug 13, 2018 at 1:28 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
> On Tue, Aug 7, 2018 at 6:49 PM Elijah Newren <newren@gmail.com> wrote:
>
> > Since folks like to notice other problems with t7406 while reading my
> > patches, here's a challenge:
> >
> >   Find something *else* wrong with t7406 that neither I nor any of the
> >   reviewers so far have caught that could be fixed.
>
> Well, I'd hate to be that guy...  but since those who already
> commented on previous rounds are not explicitly excluded from the
> challenge, let's see.
>
> - There are still a few command substitutions running git commands,
>   where the exit status of that command is ignored; just look for the
>   '[^=3D]$(' pattern in the test script.
>
>   (Is not noticing those cases considered as "flubbing"?)

Hmm, borderline.

> - The 'compare_head' helper function defined in this test script looks
>   very similar to the generally available 'test_cmp_rev' function,
>   which has the benefit to provide some visible output on failure
>   (though, IMO, not a particularly useful output, because the diff of
>   two OIDs is not very informative, but at least it's something as
>   opposed to the silence of 'test $this =3D $that").
>
>   Now, since 'compare_head' always compares the same two revisions,
>   namely 'master' and HEAD, replacing 'compare_head' with an
>   appropriate 'test_cmp_rev' call would result in repeating 'master'
>   and 'HEAD' arguments all over the test script.  I'm not sure whether
>   that's good or bad.  Anyway, I think that 'compare_head' could be
>   turned into a wrapper around 'test_cmp_rev'.

Ooh, that does sound better.

> >     - You get bonus points if that thing is in the context region for
> >       one of my five patches.
> >     - Extra bonus points if the thing needing fixing was on a line I
> >       changed.
> >     - You win outright if it's something big enough that I give up and
> >       request to just have my series merged as-is and punt your
> >       suggested fixes down the road to someone else.
>
> Well, there's always the indentation of the commands run in subshells,
> which doesn't conform to our coding style...
>
> Gah, now you made me that guy ;)

I read this on Monday and got a really good laugh.  I meant to fix it
up, but fell asleep too soon the first couple nights...and now this
series is in next anyway and there are a couple other git things that
have my attention.  You have pointed out a couple additional nice
fixups, like you always do, but I think at this point I'm just going
to declare you the winner and label these as #leftoverbits.

Thanks for always thoroughly looking over the testcase patches and
your constant work to improve the testsuite.
