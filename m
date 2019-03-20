Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5908420248
	for <e@80x24.org>; Wed, 20 Mar 2019 14:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfCTOVf (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 10:21:35 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:37360 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfCTOVf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 10:21:35 -0400
Received: by mail-ua1-f68.google.com with SMTP id x1so827371uaj.4
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 07:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=50jdAyB5zTIcL0aFdbwyWFwWMtpuuRGfA7FRVv0sHaE=;
        b=mK2ulXSiRF9ZZedPqomK9gSApLoh8SH8AdN8DXG1z0ZrzKJ7N9FX3rJ0p7KilN56Wx
         f7oBnkbf2FVY3/4lGaodYQ89UHvTxlXVY4a3HpcilO8Ttlpc5zymcAEssXUcDx5B7Fe0
         YHO1LqsM2XaPjOqZUGxqPbaNRi/+IZUvx8pxj0VAkYg85DurH6+xTLL2ifPNpSivprAu
         SUn9y9zTBG/vEwygayM/V1mnDCruTc8mOjVUXLohtGshmuF4lxDcAJxaXRwWLWHaIDg2
         PV+ObQhDawEKTui3q1gmmQNUlDW+mXBl9Y8z2X/EgZUkJjweh1IIlLzo4oi7iCUZTVyW
         MGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=50jdAyB5zTIcL0aFdbwyWFwWMtpuuRGfA7FRVv0sHaE=;
        b=F4FpvfkW3jDYupCm3yKLfl0/xWjACnhtCsR45dOf5g2nLHImjEGtv1VDvBifMKxucV
         pGgxLImj5a21AhrP+YQqhABCAR0gBpjA+LnqzQqk1T+UzQs1kaf1z1siLkfPdZ/EiCpl
         49zU7N/WsnlIQSbed/J75aCMukfP4ROX7g4ZyfhTb5yu3FPdYkeaxFafZMVqjcYTVB5T
         dcR1ZCZC3XSp9Ur/POxYJ/vFm12DaJY/lAMJYJ32v7mPe79Hw3ugcX/3rgrocCrXfkDM
         dP8wwvRYRf1KJozxgEb7aHZpCb5fxMd8+7m0hbVRfKN9Fz1lWhkWMzMPNiu0JMyGywh5
         SYuQ==
X-Gm-Message-State: APjAAAWXc0cY/dEhPrcObaww1wL0t92O8WKb4M7uF6M1Bh2Se0EUaf8W
        4CURDmy4TLt0F0Mw7ltTKPiQycfiryUXVKRHs+A=
X-Google-Smtp-Source: APXvYqxM8euIRn5kLnb9LRD0ZU4siaSSdbOaCWcdU/16prs/OmkTLU+/YY9S4hxN+dRqR72hqfunseRq8hIh2hbBFJQ=
X-Received: by 2002:ab0:6144:: with SMTP id w4mr4428518uan.135.1553091693749;
 Wed, 20 Mar 2019 07:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <bc7c3f9d769b2d5a108ff4cdc3c7277e112fdb56.1552820745.git.liu.denton@gmail.com>
 <87multaaac.fsf@evledraar.gmail.com> <CABPp-BGijBpyV9n4VxNi3QCddO-_4B-E1TUTi8wiqjQmqpU+Nw@mail.gmail.com>
 <87mulsdmsi.fsf@evledraar.gmail.com>
In-Reply-To: <87mulsdmsi.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 Mar 2019 08:21:17 -0600
Message-ID: <CABPp-BGymk=FLvC7m4WB3vVi3oObgNkOPQ_TeOWEC=L0kZaRsA@mail.gmail.com>
Subject: Re: [PATCH] git-diff.txt: prefer not using <commit>..<commit>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 18, 2019 at 12:07 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Mar 18 2019, Elijah Newren wrote:
>
> > On Sun, Mar 17, 2019 at 6:41 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >> On Sun, Mar 17 2019, Denton Liu wrote:
> >>

> Some of this thread's confusing, and on re-reading I see my reply hasn't
> helped much.
>
> To clarify. There's at least these things to consider:
>
> 1. What should the semantics of .. or ... be?
> 2. What semantics (regardless of syntax) should we recommend for common c=
ases?
> 3. Depending on #1 and #2, can we make our docs less confusing?

That's a good framework; thanks for clarifying.  Junio has weighed in
already, but there were two other things I thought I'd still comment
on.  First, I think this list could use another item, related to #3:

4. Given backward compatibility and existing use-case constraints, is
there at least a way to warn users of possible confusion besides just
the docs?

I suggested one answer elsewhere in this thread (cf.
CABPp-BEy9nN=3DaV8Y+ueYqv299umHoF2E=3D8D7heJARM4Qa7P5JQ@mail.gmail.com);
not sure what others think of it yet.

> Anecdotally I've seen ".." in all forms be *way* more common among
> users, even though if you sat them down and explained to them what it
> does v.s. "..." they'd usually say they wanted the latter.
>
> I did some brief scraping of .bash_history on one of our big shared
> servers just now that has a lot of users (100-200) using git for daily
> development. I've got many pages of things like "@{u}..",
> "<tag1>..<tag2>", "<rev>.. -- <path>" etc. against just a couple of uses
> of "...". The "<rev1> <rev2>" form gets a bit of use, but maybe 1/2 of
> "..".

Wow, that is extremely surprising to me.  I have no mechanism to
access any such data (nor any mechanism for pushing new git versions
out to users other than sending out an email about new upstream
releases and asking them to update).  So, I did the next best thing
and sent out a poll to developers (all of whom use git daily); there's
a self-selection bias in the responses that probably tilts away from
novice users, but it's all I had:

Which do you use the most?
1.`git diff A B`    `11`
2. `git diff A..B`    `2`
3. `git diff A...B`
4. I never use any of these    `5`

The responses were 11 for #1 (with a number expressing in follow-ups
that it was the only form of these three they ever used, though some
still used other forms sometimes), 2 for #2 (one of whom responded to
requests for more details and found out he was using it wrong and that
he could save a character by using form #1 in cases where A was the
merge base, which he was happy about), 0 for #3, and 5 for #4.

That was still a lot more voting for the '..' form than I expected,
but still far less than what you have seen.  I wonder if there's a
regional difference?
