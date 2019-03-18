Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AAED202BB
	for <e@80x24.org>; Mon, 18 Mar 2019 17:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfCRRqk (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 13:46:40 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36477 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfCRRqk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 13:46:40 -0400
Received: by mail-vs1-f65.google.com with SMTP id n4so931154vsm.3
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 10:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WeMaiOpO56TeMz9TnLRTExfg6BnfwurcZ/mEYd+EgeQ=;
        b=fJr6yhZuTzF0xfEh2iv3Bivl/1GerGnBo7VTw81n5TqFabUITppr8bJQOmyfV9N+Tc
         Lk8XdWtx83a4DaaHCgeXcarpzxyN+ThUgsF3Qqp/HakVaTZMEMpxQS9KxCk1etTH4fSo
         kuCXPstfToHxoO+yDDVZ4OSPCw78GDQdAnvPfB/bKz9MReoNpx7YZONIeZJQbPEAEBFn
         fHN32a1rz1UzIZmlSziWCIxjYwBXHY2qRtzuZDnue57N0oglY2mNwMjkCBXkQwZKMQJN
         kqgpUQQxApo4OIHaSsxPCwyHACJsmpLALmYM1HSk10kFxJz75GOfp+CyMcsUtZ6V1G4N
         TQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WeMaiOpO56TeMz9TnLRTExfg6BnfwurcZ/mEYd+EgeQ=;
        b=YVC2EDJahUAvV2jpWVhYF6Tr2UCYe7SCSn+8m0MEnxWY/w+oqRE+ROSjdsOOTAfOAy
         gn+LHMoaDsdHIPfCJwG7vlSota70RxgAwOPUfUMKtjvbaqrlEC0gzp0U5X6DPsXDNX+K
         3yKKvAVSG4JaASFalIEVvoVml96lkMLrXkhDRhDsczP0SzJhtPXjylVIY0CWP46IYGN4
         aUAvmFMYNgWYhfegxlQED7140EHxhUKw+lYV6cajBuavi22D9x16j0/CQcGjRT35njyl
         ynovO0irLfUqXJZMs7/Jf/q3tqo5LznSebl0Klw8XevFSQKlXLpPb/SJ9e0vlPRP0JHB
         b/vQ==
X-Gm-Message-State: APjAAAW+jUzsPeuGpqzZMcS2+A14eIWbDhA00+MGRMZF3RLP4Pxe9COU
        AR+qLKApUhR8SRupdjHIy8yYms5OvLmSJybTtUg=
X-Google-Smtp-Source: APXvYqxo7E2ccW3JmZbXugcYf9EsExu0DNVLjE9dJTEon/xS0dcorGV/sDrChup3kak8viXFq8DYAC1WGNb5sWkzIOs=
X-Received: by 2002:a67:b145:: with SMTP id z5mr9399271vsl.53.1552931199219;
 Mon, 18 Mar 2019 10:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <bc7c3f9d769b2d5a108ff4cdc3c7277e112fdb56.1552820745.git.liu.denton@gmail.com>
 <87multaaac.fsf@evledraar.gmail.com>
In-Reply-To: <87multaaac.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 18 Mar 2019 10:46:27 -0700
Message-ID: <CABPp-BGijBpyV9n4VxNi3QCddO-_4B-E1TUTi8wiqjQmqpU+Nw@mail.gmail.com>
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

On Sun, Mar 17, 2019 at 6:41 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Sun, Mar 17 2019, Denton Liu wrote:
>
> > diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
> > index 72179d993c..10c7a2220c 100644
> > --- a/Documentation/git-diff.txt
> > +++ b/Documentation/git-diff.txt
> > @@ -63,7 +63,11 @@ two blob objects, or changes between two files on di=
sk.
> >
> >  'git diff' [<options>] <commit>..<commit> [--] [<path>...]::
> >
> > -     This is synonymous to the previous form.  If <commit> on
> > +     This is synonymous to the previous form.  However,
> > +     users should prefer the previous form over this form
> > +     as this form may be more confusing due to the same
> > +     notation having a logically conflicting meaning in
> > +     linkgit:git-rev-list[1]-ish commands.  If <commit> on
> >       one side is omitted, it will have the same effect as
> >       using HEAD instead.
>
> I think we're better off just consistently recommending "A..B" instead
> of "A B" and "fixing" any occurrence of the latter to the
> former. I.e. not taking this patch & going in the other direction.
>
> As noted in the thread you linked we'll always need ".." when one side
> is "HEAD" implicitly, and that's a really common case.

By "really common" do you simply mean it is used by enough people that
it should be supported, or are you trying to claim something about
it's relative usage compared to "diff A B"?

> So as confusing as the whole ".." v.s. "..." is in diff v.s. log I think
> we're worse off with "A B", since we'll *still* need to document the
> likes of "A.." and how that differs from log "A.." or "A...".
>
> So sometimes using the whitespace form for two revs and then the ".."
> when we just have one side makes things more confusing, not less. The
> reader will be left having to juggle more complexity in their head, not
> less.

Here I think you are implying that "A.." or "..A" is somehow on a
similar magnitude of usage as "A B".  Is that accurate?  If that
reflected real-world usage, I would be more inclined to agree with
your course of action, but I can't fathom them having similar usage
rates.  Personally, I don't think I've ever seen any user use "A.." or
"..A" (well, except me), and only rarely even use "A..B"; with users I
have worked with and supported and taught, I'd guess "diff A B" is
used far more (at least an order of magnitude more) than any other
form, and that only some of them and only occasionally want to use
anything else, such as diffing against a merge base.

This whole topic came up again, IMO, because for the occasional
usecase of diffing against a merge-base, people's intuition leads them
to '..' instead of '...', and we wanted to fix or help avoid that
problem.  To me, your solution sounds like you want to instead embrace
the confusion: force people to deal with it early and often so that
they become trained on it and can articulate the differences between
'..' and '...' for both diff and log.  Is that accurate, or am I
misunderstanding/mis-stating your strategy?
