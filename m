Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC3561F403
	for <e@80x24.org>; Mon, 11 Jun 2018 16:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933479AbeFKQZT (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 12:25:19 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41393 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933365AbeFKQZR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 12:25:17 -0400
Received: by mail-oi0-f67.google.com with SMTP id a141-v6so18409097oii.8
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 09:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u0BqHpsIHKmBwwz2EgRqpzhAv2tOeLp6P7Rbp8p3pCs=;
        b=j4kvp/kpmGngJI3qIEbAt7esWtnXdzTaStwixyWiyTPlj9laW5CCFliMJkhzW375HJ
         wf+YWqe2yrvORrIditJFn/Dk9BAyY/e07iidvwQNfOBPt0ogz2Ni0+4Tvg3vEUvNKl/P
         smYiRd/9ZghxvnaCbHa471qewjEZh8N6JX6YlxHKywmS4snK/SYkncCbPsCtASuNssx3
         w2U08GLyvMj08SW2N2J+SjWilmJDNGoKcoKnrwi6RddO+FiFrYH+v3Vw16JtQl/YF4UM
         aUeSxQE1ZEk2OrdqvdD2tkiHGQWKDtvxkjMc6TVZvpKYkcd8gprZCQsmpblgYRq+beBD
         gCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u0BqHpsIHKmBwwz2EgRqpzhAv2tOeLp6P7Rbp8p3pCs=;
        b=qoQCEVfT9eAktwR3MKPVO6ItzXgfuyK50hxOSF4JUHH2YNSMKmuwVVpcTo9u4+h06s
         nD/Z+cXRntq3e7toaIcESlEfQP+khj4Jec0qH5B74/b0a6e5cobH7hLZHsrN2KzfgcME
         9Kwf2Tv1s9qnfhZBB9dUo4D3UHqvOpP2FkWTct5+eg6oYoKi24ugrr3Gaf65NYaJT+ih
         bds7rPlUpZ4k1Gev8fi/4RF2/WRyM4yygFxHAS10MsrRfUCeglnhSOR+g9B3C9Og2iXg
         iw6jZijR6jjQl4L+A2+VZdU1tYKDtnByZVvb/Y2zipt6XKtwj6HgvhVwZuEikWZwmkJz
         ygSw==
X-Gm-Message-State: APt69E1i4on+igKDwlrn7I9//U+OnejY1AXQLxStOMFFm9e2SbzHLtKJ
        c2b5qYDSlNyMnVObbAqdj+zDjYeR+gAJK7RaTsE=
X-Google-Smtp-Source: ADUXVKJNOlNeuQKaaMXAvAG+eu85p0+iqfB7HyuZZj6PRLaAqNGFclh3N7Jge0DwpN1pzimAah7j4d6epxMOyu8d5QU=
X-Received: by 2002:aca:52c5:: with SMTP id g188-v6mr9238431oib.228.1528734317261;
 Mon, 11 Jun 2018 09:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180606073933.14755-1-pclouds@gmail.com> <20180606165016.3285-1-pclouds@gmail.com>
 <CABPp-BEngspJMEpwoiTq7SCdsQt7fOT_uePS3c6nRxTVqOnNeQ@mail.gmail.com>
 <CABPp-BGa+v2x1oeitVDMkQf3qFWx6kUT4wdWhCxjWwPyaW=3bg@mail.gmail.com>
 <CACsJy8Ba74iSPf4_zFxuV=_uNJgL6Z2QunOvAvi3qab-6EWi5g@mail.gmail.com> <CABPp-BHYm57n=ufg_SqmA-UnOEMivWJZytnPPSU3WSYNeEph0g@mail.gmail.com>
In-Reply-To: <CABPp-BHYm57n=ufg_SqmA-UnOEMivWJZytnPPSU3WSYNeEph0g@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 11 Jun 2018 18:24:50 +0200
Message-ID: <CACsJy8AOzwu+GJLTsGtN0dCnwxoRBQYpM6gzVebN++zjpXNu7w@mail.gmail.com>
Subject: Re: [PATCH v4 00/23] Fix incorrect use of the_index
To:     Elijah Newren <newren@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 11, 2018 at 6:11 PM Elijah Newren <newren@gmail.com> wrote:
>
> Hi Duy,
>
> On Mon, Jun 11, 2018 at 9:05 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> > On Sat, Jun 9, 2018 at 9:58 PM Elijah Newren <newren@gmail.com> wrote:
> >> I read over the rest.  Found a small grammatical error in a commit
> >> message.  Found multiple places that still need conversion, from
> >> pushing up &the_index usages to callers of ll-merge.c and sha1-file.c
> >> instead of having them in those files, to mixes of _cache_ and _index_
> >> functions as in apply.c and merge-recursive.c.  However, Duy pointed
> >> out there was more work to do,
> >
> > Yes. This is just fyi, 40 patches later, i'm down to leaving the_index
> > in three files outside builtin/: merge-recursive, notes-merge.c and
> > transport.c. Even after the conversion we may need some more follow-up
> > patches because it now shows places where we should _not_ touch the
> > index at all, which may involve not simply passing NULL index_state to
> > some functions, but fixing them up to tolerate NULL index_state. So
> > it's going to be a few patch series until the_index is gone for good
> > [1].

And I forgot one thing. There are other hidden dependencies as well.
Like hold_locked_index() will assume $GIT_DIR/index, but when you take
an arbitrary 'struct index_state *' I don't think you can make that
kind of assumption. This is mostly a note to myself in case I forget
it again.

> >
> > [1] but like cheap horror movies, there's always a sequel:
> > the_repository is still spread in many places and hides dependencies
> > in the same way. We can't do anything about it though until struct
> > repository conversion is more or less complete.
>
> I was just about to send you an email to ask if you were continuing on
> with the series.  I need diff-lib.c converted in order to make the
> changes Junio suggested to index_has_changes at
> https://public-inbox.org/git/xmqqvaaz5jcv.fsf@gitster-ct.c.googlers.com/.
> Since you're already working on that, I won't duplicate your effort.
> Thanks for tackling all of this.  :-)

I'm not sure if it's possible to cherry pick this patch to continue
your work (because of dependencies between patches) but it's
https://gitlab.com/pclouds/git/commits/really-kill-the-index, commit
"merge.c: remove...".

Or you just leave it to me, update has_index_changes() to always take
'struct index_state *' and just pass &the_index in all uninteresting
places. (Or not update at all if it's really not needed for your work)

What about merge-recursive.c? Given that this whole thing will take
many release cycles to finish, your work may get merged before mine
and I could do the conversion now (and resolve conflicts and resubmit
later). Of course if you like to keep merge-recursive.c the_index-free
now, I will not stop you ;-)
-- 
Duy
