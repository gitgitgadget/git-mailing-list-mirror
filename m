Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0E181F462
	for <e@80x24.org>; Fri, 26 Apr 2019 04:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfDZEOD (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 00:14:03 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33781 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfDZEOD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 00:14:03 -0400
Received: by mail-io1-f68.google.com with SMTP id u12so1924227iop.0
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 21:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ey6Opi0u+jNrPxLTWyD3bPpIfgtpKtZkp7oHOP43h9Q=;
        b=QCc3UPjDFj9tJVzyLqblG3RpPxKmkTu3HnONpbHW10pRmQK2vwyYbBS2AevqHztgIF
         lLRMZPDVPmaedDJfiWImb/D3BKPT/4x0AFMkGdiIaVU4NRCLC9KKzjAMufMXK2MEsuns
         6c7oCMX5kfK8wzUZLtT/3zGvP7DUwmkWK42OtGM0EBjWhNJSaI+2tZMPongVGDSd7OQU
         L0g8g1nyOtpYEs375gKJLmfgA74EZbA3KcDHDNFgfsMnTDDcfGA2z+0zG3rOxT6muLSh
         voSU4IZ9X7HLRbv+CIpsVY9+FdVQtZI6uK1Ll2TJB87wP24hXq/+wCgE+nlTU/sfjuQw
         5faw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ey6Opi0u+jNrPxLTWyD3bPpIfgtpKtZkp7oHOP43h9Q=;
        b=Xi2p8fx08Z3N1RJI9bHP/FZM9y5LxPkFJ341TRmXPjDNu56r3jSOJMZe5J7cmdlGvn
         ZzLI2kUKULGgLJHOEsHWDmiou1v+MYZv7O3Ii+9tvgHANjGYUeuNpw0YCANwxpMpD2dQ
         RmATFfcKB9xF1NT8lQpiEZiEkbOdr503NkYhEL0YnhG2xulT0Lk9nPVBZVN4wdklKWbt
         KTSZaJP7Yvv4nnSHYY/woK/WlDbAroRanwD3eSLx9oFbxonbXbV3gQkA0VW19RqtP+Sz
         RLbnhXHSFa2zxA2hvRiiO3gINLJR2o1uS04JmfqJuki8Jr3zIj+3x5rhLozY2/nbJPQR
         FwZg==
X-Gm-Message-State: APjAAAXULm05QirnRV1aGKI74f4zDNe8GjvmHiNupX0Qn7qvbhufE91p
        Qp7RYLyiaKwnl6HPFtxcKHbNkd1BfBmdVaID4DSM5Q==
X-Google-Smtp-Source: APXvYqx5wqnq/4eMfwgKpP36yw5WaDIZqE+qImNqoA4fOlUCDdetZXyWN9/AwL1LqyCYAl0iNPFrqMM7u3ewTXu+K8w=
X-Received: by 2002:a6b:7f09:: with SMTP id l9mr18225436ioq.66.1556252041461;
 Thu, 25 Apr 2019 21:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190330224907.3277-1-matheus.bernardino@usp.br> <20190330224907.3277-4-matheus.bernardino@usp.br>
 <20190331181209.GT32487@hank.intra.tgummerer.com> <CAHd-oW7yPj5Ons3kfdEHtFgowc=F=2BD9EvU+fJbHe9=UXhx1g@mail.gmail.com>
 <20190411210927.GE32487@hank.intra.tgummerer.com> <CAHd-oW48+cEqSMDFF3PXuOnzUvptM6q5Ba_Zb8gGhqa1bGNwZQ@mail.gmail.com>
 <20190424183622.GB2068@hank.intra.tgummerer.com>
In-Reply-To: <20190424183622.GB2068@hank.intra.tgummerer.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 26 Apr 2019 01:13:50 -0300
Message-ID: <CAHd-oW4XCtGd=jK+17Ms24n1X7cbdm9Q42orpY=kabrDvYbCHA@mail.gmail.com>
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

On Wed, Apr 24, 2019 at 3:36 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> On 04/23, Matheus Tavares Bernardino wrote:
> > On Thu, Apr 11, 2019 at 6:09 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > >
> > > On 04/10, Matheus Tavares Bernardino wrote:
> > > > > > diff --git a/dir-iterator.h b/dir-iterator.h
> > > > > > index 970793d07a..93646c3bea 100644
> > > > > > --- a/dir-iterator.h
> > > > > > +++ b/dir-iterator.h
> > > > > > @@ -19,7 +19,7 @@
> > > > > >   * A typical iteration looks like this:
> > > > > >   *
> > > > > >   *     int ok;
> > > > > > - *     struct iterator *iter = dir_iterator_begin(path);
> > > > > > + *     struct iterator *iter = dir_iterator_begin(path, 0);
> > > > >
> > > > > Outside of this context, we already mentione errorhandling when
> > > > > 'ok != ITER_DONE' in his example.  This still can't happen with the
> > > > > way the dir iterator is used here, but it serves as a reminder if
> > > > > people are using the DIR_ITERATOR_PEDANTIC flag.  Good.
> > > >
> > > > This made me think again about the documentation saying that
> > > > dir_iterator_abort() and dir_iterator_advance() may return ITER_ERROR,
> > > > but the implementation does not containing these possibilities.
> > > > (Besides when the pedantic flag is used). Maybe the idea was to make
> > > > API-users implement the check for an ITER_ERROR in case dir-iterator
> > > > needs to start returning it in the future.
> > >
> > > Yeah, I think that was the intention.
> > >
> > > > But do you think such a change in dir-iterator is likely to happen?
> > > > Maybe we could just make dir_iterator_abort() be void and remove this
> > > > section from documentation. Then, for dir_iterator_advance() users
> > > > would only need to check for ITER_ERROR if the pedantic flag was given
> > > > at dir-iterator creation...
> > >
> > > Dunno.  In a world where we have the pedantic flag, I think only
> > > returning ITER_ERROR if that flag is given might be what we want to
> > > do.  I can't think of a reason why we would want to return ITER_ERROR
> > > without the pedantic flag in that case.
> >
> > Ok. I began doing the change, but got stuck in a specific decision.
> > What I was trying to do is:
> >
> > 1) Make dir_iterator_advance() return ITER_ERROR only when the
> > pedantic flag is given;
> > 2) Make dir_iterator_abort() be void.
> >
> > The first change is trivial. But the second is not so easy: Since the
> > [only] current API user defines other iterators on top of
> > dir-iterator, it would require a somehow big surgery on refs/* to make
> > this change. Should I proceed and make the changes at refs/* or should
> > I keep dir_iterator_abort() returning int, although it can never fail?
>
> Maybe I'm missing something, but wouldn't this change in refs.c be
> enough? (Other than actually making dir_iterator_abort not return
> anything)
>
>         diff --git a/refs/files-backend.c b/refs/files-backend.c
>         index 5848f32ef8..81863c3ee0 100644
>         --- a/refs/files-backend.c
>         +++ b/refs/files-backend.c
>         @@ -2125,13 +2125,12 @@ static int files_reflog_iterator_abort(struct ref_iterator *ref_iterator)
>          {
>                 struct files_reflog_iterator *iter =
>                         (struct files_reflog_iterator *)ref_iterator;
>         -       int ok = ITER_DONE;
>
>                 if (iter->dir_iterator)
>         -               ok = dir_iterator_abort(iter->dir_iterator);
>         +               dir_iterator_abort(iter->dir_iterator);
>
>                 base_ref_iterator_free(ref_iterator);
>         -       return ok;
>         +       return ITER_DONE;
>          }
>
>          static struct ref_iterator_vtable files_reflog_iterator_vtable = {

Yes, indeed. But I thought that since the reason for making
dir_iterator_abort() be void is that it always returns ITER_DONE, the
same change should be applied to files_reflog_iterator_abort() as it
would fall into the same case. And this, in turn, would require
changes to ref_iterator_abort() and many other functions at
refs/iterator.c and refs/files-backend.c

> Currently the only thing calling dir_iterator_abort() is
> files_reflog_iterator_abort() from what I can see, and
> dir_iterator_abort() always returns ITER_DONE.
>
> That said, I don't know if this is actually worth pursuing.  Having it
> return some value and having the caller check that makes it more
> future proof, as we won't have to change all the callers in the future
> if we want to start returning anything other than ITER_DONE.   Just
> leaving it as it is now doesn't actually hurt anybody I think, but may
> help in the future.

Ok, I understand.

> > There's also a third option: The only operation that may fail during
> > dir_iterator_abort() is closedir(). But even on
> > dir_iterator_advance(), I'm treating this error as "non-fatal" in the
> > sense that it's not caught by the pedantic flag (although a warning is
> > emitted). I did it like this because it doesn't seem like a major
> > error during dir iteration... But I could change this and make
> > DIR_ITERATOR_PEDANTIC return ITER_ERROR upon closedir() errors for
> > both dir-iterator advance() and abort() functions. What do you think?
>
> I think this might be the right way to go.  We don't really need an
> error from closedir, but at the same time if we are being pedantic,
> maybe it should be an error.  I don't have a strong opinion here
> either way, other than I think it should probably keep returning an
> int.

I know I suggested this option, but searching the code base I saw no
other place that checks closedir()'s return besides dir-iterator. So
maybe the best option would be to keep dir_iterator_abort() always
returning ITER_DONE, even upon closedir() errors. Them, I can document
that the pedantic flag only affects dir_iterator_advance() behavior
(but closedir() errors wouldn't be considered here as well).

I got stuck in this for a while, but finally this option seems good to me now...

> > > Though I think I would change the example the other way in that case,
> > > and pass DIR_ITERATOR_PEDANTIC to 'dir_iterator_begin()', as it would
> > > be easy to forget error handling otherwise, even when it is
> > > necessary.  I'd rather err on the side of showing too much error
> > > handling, than having people forget it and having users run into some
> > > odd edge cases in the wild that the tests don't cover.
> >
> > Yes, I agree.
> >
> > > > Also CC-ed Michael in case he has some input
