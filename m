Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0109D20248
	for <e@80x24.org>; Wed, 10 Apr 2019 20:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfDJUZE (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 16:25:04 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40904 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfDJUZE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 16:25:04 -0400
Received: by mail-io1-f67.google.com with SMTP id d201so3342896iof.7
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 13:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rlv19dkwc0zxaRqbFpZI0/uT4+rH3UNLv3KNMfEU9lU=;
        b=kimTiGhxA5WzU5/57d/hFwR8nt8FKxnqmDpfRzzNmY942jiIxc6Q4eLkeHwuwW0jMe
         pIF88j4NfIxMbNwisTQqJyGhKYUL6eG/gby0C4vOL18uqkIV+WIWwVapa7JzNgdd0oYl
         dWWmgaG/uocaiinqZReFF2phTfo4WOFmMImhlaqPFxZ4EDb2ZbI5vHdUK6jUmz0dhFtk
         jRez6WNwkZ+MXdeP5lzfnboys+J/oXCHlXw6RCHRaeyGnT9yLWf+ejUKrgndYvivlUbu
         RjR0LbsDFXWVDJkT5yLb1PU7L/a0rEpRjCaiIIRnlu4zz3iD7w+484B1rSyl07CNF/eo
         TwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rlv19dkwc0zxaRqbFpZI0/uT4+rH3UNLv3KNMfEU9lU=;
        b=lx2eUPG1WTbjPm9EHWy3hTq7sIhl81VKgWKLHGSSPfZ0vXJMfvI7+wQz42ebTRCPo3
         8OveZy5yjIKMX65xVBsCQIfSRhhR68dIxqwvVTW1BHI1y4ld/HDB0m+xyIY002qM5Cki
         Lk6H5yFF2mz+3qBNi/WXTPBBAfOBOYfgfwlAEcXHMp4+1Wj8K8EF8FBZYAa8+SGiqIV+
         Y9jyCZJWiJ9aNweWI/RvuKj/OrrEIX2glE4Ga34NUEqqE8CYgNdALGfBeN+4/2k874J4
         q+/80H5Lk1PsP/7DIQUOxyWn2RbOrBq2Mvm61blL7aJjDaTzz4iCj5TN3+i45coqayGJ
         GUng==
X-Gm-Message-State: APjAAAWPbgrtsIgJj+rpfLEJ6J1v/l8okA+fZ+ooXpWIJocBbPUfk6bt
        Cp3fcxDgDvs8Oc2TGt1+7SvRtikNbCLRh2mdxy9G+M9l/0o=
X-Google-Smtp-Source: APXvYqwlZQnfv55nnFerO9/bFmkXfJQJeqIr+ZZHwf8VTcYYm3CoLZKWN4CWIJ1QIZB4mymbY61zFAfAaMwlOvjXOX0=
X-Received: by 2002:a6b:7218:: with SMTP id n24mr28227008ioc.112.1554927903181;
 Wed, 10 Apr 2019 13:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190330224907.3277-1-matheus.bernardino@usp.br> <20190330224907.3277-4-matheus.bernardino@usp.br>
 <20190331181209.GT32487@hank.intra.tgummerer.com>
In-Reply-To: <20190331181209.GT32487@hank.intra.tgummerer.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 10 Apr 2019 17:24:51 -0300
Message-ID: <CAHd-oW7yPj5Ons3kfdEHtFgowc=F=2BD9EvU+fJbHe9=UXhx1g@mail.gmail.com>
Subject: Re: [GSoC][PATCH v5 3/7] dir-iterator: add flags parameter to dir_iterator_begin
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kernel USP <kernel-usp@googlegroups.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Thomas

Sorry for the late reply, but now that I submitted my GSoC proposal I
can finally come back to this series.

On Sun, Mar 31, 2019 at 3:12 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> On 03/30, Matheus Tavares wrote:
> > Add the possibility of giving flags to dir_iterator_begin to initialize
> > a dir-iterator with special options.
> >
> > Currently possible flags are DIR_ITERATOR_PEDANTIC, which makes
> > dir_iterator_advance abort immediately in the case of an error while
> > trying to fetch next entry; and DIR_ITERATOR_FOLLOW_SYMLINKS, which
> > makes the iteration follow symlinks to directories and include its
> > contents in the iteration. These new flags will be used in a subsequent
> > patch.
> >
> > Also adjust refs/files-backend.c to the new dir_iterator_begin
> > signature.
> >
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > ---
> >  dir-iterator.c       | 28 +++++++++++++++++++++++++---
> >  dir-iterator.h       | 39 +++++++++++++++++++++++++++++++++------
> >  refs/files-backend.c |  2 +-
> >  3 files changed, 59 insertions(+), 10 deletions(-)
> >
> > diff --git a/dir-iterator.c b/dir-iterator.c
> > index f2dcd82fde..17aca8ea41 100644
> > --- a/dir-iterator.c
> > +++ b/dir-iterator.c
> > @@ -48,12 +48,16 @@ struct dir_iterator_int {
> >        * that will be included in this iteration.
> >        */
> >       struct dir_iterator_level *levels;
> > +
> > +     /* Combination of flags for this dir-iterator */
> > +     unsigned flags;
> >  };
> >
> >  int dir_iterator_advance(struct dir_iterator *dir_iterator)
> >  {
> >       struct dir_iterator_int *iter =
> >               (struct dir_iterator_int *)dir_iterator;
> > +     int ret;
>
> Minor nit: I'd define this variable closer to where it is actually
> used, inside the second 'while(1)' loop in this function.  That would
> make it clearer that it's only used there and not in other places in
> the function as well, which I had first expected when I read this.

Right, thanks.

> > diff --git a/dir-iterator.h b/dir-iterator.h
> > index 970793d07a..93646c3bea 100644
> > --- a/dir-iterator.h
> > +++ b/dir-iterator.h
> > @@ -19,7 +19,7 @@
> >   * A typical iteration looks like this:
> >   *
> >   *     int ok;
> > - *     struct iterator *iter = dir_iterator_begin(path);
> > + *     struct iterator *iter = dir_iterator_begin(path, 0);
>
> Outside of this context, we already mentione errorhandling when
> 'ok != ITER_DONE' in his example.  This still can't happen with the
> way the dir iterator is used here, but it serves as a reminder if
> people are using the DIR_ITERATOR_PEDANTIC flag.  Good.

This made me think again about the documentation saying that
dir_iterator_abort() and dir_iterator_advance() may return ITER_ERROR,
but the implementation does not containing these possibilities.
(Besides when the pedantic flag is used). Maybe the idea was to make
API-users implement the check for an ITER_ERROR in case dir-iterator
needs to start returning it in the future.

But do you think such a change in dir-iterator is likely to happen?
Maybe we could just make dir_iterator_abort() be void and remove this
section from documentation. Then, for dir_iterator_advance() users
would only need to check for ITER_ERROR if the pedantic flag was given
at dir-iterator creation...

Also CC-ed Michael in case he has some input
