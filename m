Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EA431F404
	for <e@80x24.org>; Fri, 31 Aug 2018 10:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeHaOhM (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 10:37:12 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:45192 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbeHaOhL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 10:37:11 -0400
Received: by mail-wr1-f46.google.com with SMTP id 20-v6so10729871wrb.12
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 03:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zvRU1gQZQMtAs3JVjeWYhqZwkC4SrTc08hy67spG+zA=;
        b=tRk4yS1OQekGY/S7F/3kpk83QSEIiFb4/J2eN/TavIvO2Ov6X4nJkev1o2mWI4JTtC
         3S/xo9Dg8vRvAYkb12CTV1p5dTdA1S6G7b+UUt//9/oZZTIdEC4GCixtNElaXKlCsa/8
         Yz/TpDKY8z5FeuDRIqQ/otAmLAk4nfjo1nTpjlu38AQk88roo5x/6VtxCRhK4NyIzss2
         OO7ikwV7thDLH7OsxEWemcMhu1trMMYm/YPWJvWTa/T7iDVE96Itq2v0I+OZS8VKQkZt
         tPVFDEixN2gKiRbepM+B8ETLAxdJ2XiuvRQTf8NwgcvTC0pZcqttQ8wDx5eKC/Mcl2al
         FsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zvRU1gQZQMtAs3JVjeWYhqZwkC4SrTc08hy67spG+zA=;
        b=NnYvuxJRHxn90T/EAPMiyzKh6LcPRaLV7LG3sKLjIehtwra6JTfaQNVAyPzFumIY0G
         1/3KZqappQIeRzDA55ws/MHkn+rxDbjlwbZtD3PQELSrIE223gCtx3rL8gmO9HGyWPx0
         Tmb5UwisDJEjVuwdKAwe/rxldFHKDS805JZZpEHegKHx0NHojOHAK76HNZgJn8yDslOb
         cbAxCekjBd3M0sgD9IsIg54IbysLS+umltcJkGrru7dSuBaHvBGA7cm3acAGYxE8EQtX
         BvUANwienYxoRVH0e01qh30aAjCR6VX0jbv/qCARtA08CnT27Dkao5CNGus21T6BcXdy
         5Z4g==
X-Gm-Message-State: APzg51D3N7T0YrkkhcNa1Iz5ZwuksPjf2a89JN1qjl5V4ji4tswOPNSe
        H1IvlYlnrdYLRX+Ica/dLbRTUKMIDSVhNDaSjlVTiQ==
X-Google-Smtp-Source: ANB0VdbmeLdCKylZSZ2p5WrEi6NRUVGMMT38K55tQp++XjWtSgvhrWqcQQQLkhVAuLTl7PuOSIuJ0VxSHv8N6g6PtbY=
X-Received: by 2002:adf:a789:: with SMTP id j9-v6mr10432964wrc.277.1535711420028;
 Fri, 31 Aug 2018 03:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180828151419.GA17467@sigill.intra.peff.net> <8736uxe2pm.fsf@evledraar.gmail.com>
 <20180830031607.GB665@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1808301340280.71@tvgsbejvaqbjf.bet>
 <20180830192453.GC19685@sigill.intra.peff.net> <CAP8UFD0AnS1Zp2QdqtLTqBrsUiogODC_apG-vumxRuoijW=r4A@mail.gmail.com>
In-Reply-To: <CAP8UFD0AnS1Zp2QdqtLTqBrsUiogODC_apG-vumxRuoijW=r4A@mail.gmail.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Fri, 31 Aug 2018 13:30:05 +0300
Message-ID: <CAL21BmmmD1V+EWFevNT1t9M+nwrN9GR_PTx981ji_zGwfbpd_A@mail.gmail.com>
Subject: Re: Git in Outreachy Dec-Mar?
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        avarab@gmail.com, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

I was Outreachy intern last winter. I guess I need to speak up: I will
be happy if my feedback helps you.
At first, I want to repeat all thanks to Outreachy organizers and Git
mentors. That was unique experience and I am so proud of being a part
of this project. But, I need to say that my internship wasn't ideal.
Mentors, please do not feel guilty: I just want to improve the quality
of future internships and give some advises.

I guess some of the problems aren't related to Git, and it's Outreachy
weak points. Please forward this email to Outreachy organizers if you
want.

1. The main problem of Outreachy internship is positioning. I mean, I
had strong confidence that it's an internship for newbies in
programming. All my friends had the same confidence, and that's the
reason why 2 my friends failed in the middle of the Outreachy
internship. Load was so big for them, noone explained this fact in the
beginning, noone helped with this situation during the internship. I
was thinking I could be overqualified and I took someone's place (I
had 2 other SWE internships before Outreachy). The truth is that my
skills were barely enough.

2. Please tell more about minimal requirements: write it down on a
landing page in the beginning and maybe repeat them in every task. I
guess it would be the same this year: good knowledge of C, gdb, Git
(as a user: intern needs to know how to work with forks, git remote,
git rebase -i, etc), Shell, base understanding of Linux terminal,
being ready to work remotely. It's good idea to mention that it's not
100% requirement, but anyway at least 60% from the list must be
familiar.

3. If you decide to be a mentor - at first, thanks a lot. Please be
ready to spend A LOT OF time on it. You need to explain not only the
task to your intern, but also how to split the task into subtasks, how
to look for solutions, how to work with the terminal, how to debug
better and many other questions. It's not only about solving
internship task. It's about learning something new. And I did not
mention code reviews: there would be many stupid errors and it's a
talent not to be angry about that.

4. I fully sure that you need to talk with your intern by the voice. I
mean regular calls, at least once a week. It's good idea to share the
desktop and show how you are working, what are you using, etc.
Ask your intern to share the desktop: you need to feel confident that
they understand how to work with the task. Help them with the
shortcuts.
Remote work is so hard at the beginning, I feel alone with all my
problems, feel ashamed to ask questions (because they are not "smart
enough"), sometimes I didn't know what to ask. I need to mention that
I had almost 1 year of remote work experience, and that helped me a
lot. But other interns do not have such experience.
Actually, I am sure that the only reason why I successfully finished
the internship is that my mentors believed in me and did not fire me
in the middle. I personally think that I failed first half of the
internship, and only in the end I had almost clear understanding
what's going on. (My friend was fired in the same situation.)

5. In the ideal world, I want to force all mentors to get special
courses (it will solve problems 2-3-4). Great developer is not equal
to great mentor. And, if you work with really newbie, it becomes so
necessary.

I hope that was useful.

In the end I want to say that there's no special requirements to
involve people from unrepresented groups. I see no racism or sexism in
mailing lists, my mentors were polite and friendly, I can't say
anything bad here. Please keep this safe environment and explain your
colleagues if you see something bad.
In my opinion, the problem is that Git is not friendly with newbies in
general. We do not have task tracker, regular mentors (without any
special programs: just some developers that are ready to help with
first patch). The code is not structured properly, this is additional
difficulty for newbie. This system with mailing lists and patches... I
understand that it's not possible to make all processes perfect in one
moment, but at least we need to help all newbies to solve all these
problems in the beginning.
I guess that there are only 2 scenarios how to become Git developer.
First one is internship. Second is to ask your colleague (who is Git
developer) to help you.
I don't want to speak on behalf of all women, but I guess many girls
feel not confident enough to ask for such help. For me the only
possibility to start was the internship.

Some personal info: I am in the process of changing jobs. I wish I
could help you with mentoring (not as a main mentor, maybe as a second
or third one - my experience as an intern could be useful, I could
help other interns to start), but I can't predict my load. If you are
interested in my help, please write me. And, by the way, please delete
my task from list of internship tasks, I will finish it by myself just
when I have some free time :)

Olga
