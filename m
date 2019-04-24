Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3CF91F453
	for <e@80x24.org>; Wed, 24 Apr 2019 18:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388029AbfDXSg1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 14:36:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45296 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbfDXSg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 14:36:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so26491720wra.12
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 11:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sdVfNR5dRMvBG6fvzMewfmyg1nLJIuwfIKA+lLQwSdY=;
        b=hXYgI13Fia4FXNP5Y+A4oxpUavarNGN9hRutWt6sFrHJV48ldveLToipVwt8PjI/cc
         beVPPqMG9MbDG8OIuI1XO1YBVmauSEuxtoJbECkqlz+Yk9D1a6UmQQrgOg4OygeDgL6h
         9EtoNBiIdjGxRCm6NDlaOHpzKK3/sBwM78JtNuBsCKGeRgu3fdoFaFoiIVv7Z+fd/LxN
         DUuWtqY9SjQwhr7+nD3UKYXvPOkx+awLpFzm+WMp9+zeIDncR8km5ubcnwvPRs7/nq3S
         WT9+5w6OKo8k+BlhfeS3yaIXFOIMwWJ7BblEoiWv5Q1leHTVC2egQGl7j/DgcyHcXtvA
         T4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sdVfNR5dRMvBG6fvzMewfmyg1nLJIuwfIKA+lLQwSdY=;
        b=aaKW1RBREJJx5YVk3aHQCWRoRZG+Ejrll4roXJNFRZ72lzns6Rehik+wdjjHWoo2NE
         ASTWIAVOyqvaLlf6Z5/C3qz2yxzIPmP+p6ryfasqxfHVDDSQia4YopxFVbbnO74pULnC
         mdZrKvXgMBP+EUaxWY55jkRtkevqmRGDUZD/3hSKFMQIQVkOlaZgJwB4BgcixfDmI2nH
         Ph5YSAeHqLNFxhOQgAsN0rBkXSVleSDrhuVMZOaDCLOgUz8kfiLjBg8Wn7eRahJzfC7d
         AgQ4xb93mTfCmkGkQox5wCj5dJm6QF56b4bxah/9IH3CPQgCN3/2xrNnpEq5sBuoVpPh
         7+hw==
X-Gm-Message-State: APjAAAUKHn4kxRA8fe2+jIVhJv0WvXuWuFZyMgtI8RoJM6pKoBu4uKzE
        +5zThF65TACH+hhiv32qdrc=
X-Google-Smtp-Source: APXvYqxm+qXZqv1+tqjoh67e6jCko/yJNcm9auApgNFxRIhpeKkCQIl8PeCVoxzv0bvQUzU9CeLhUQ==
X-Received: by 2002:adf:de0c:: with SMTP id b12mr690335wrm.297.1556130985051;
        Wed, 24 Apr 2019 11:36:25 -0700 (PDT)
Received: from localhost ([2.25.81.3])
        by smtp.gmail.com with ESMTPSA id c11sm11737899wrs.86.2019.04.24.11.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 11:36:23 -0700 (PDT)
Date:   Wed, 24 Apr 2019 19:36:22 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Kernel USP <kernel-usp@googlegroups.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [GSoC][PATCH v5 3/7] dir-iterator: add flags parameter to
 dir_iterator_begin
Message-ID: <20190424183622.GB2068@hank.intra.tgummerer.com>
References: <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190330224907.3277-1-matheus.bernardino@usp.br>
 <20190330224907.3277-4-matheus.bernardino@usp.br>
 <20190331181209.GT32487@hank.intra.tgummerer.com>
 <CAHd-oW7yPj5Ons3kfdEHtFgowc=F=2BD9EvU+fJbHe9=UXhx1g@mail.gmail.com>
 <20190411210927.GE32487@hank.intra.tgummerer.com>
 <CAHd-oW48+cEqSMDFF3PXuOnzUvptM6q5Ba_Zb8gGhqa1bGNwZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd-oW48+cEqSMDFF3PXuOnzUvptM6q5Ba_Zb8gGhqa1bGNwZQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/23, Matheus Tavares Bernardino wrote:
> On Thu, Apr 11, 2019 at 6:09 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >
> > On 04/10, Matheus Tavares Bernardino wrote:
> > > > > diff --git a/dir-iterator.h b/dir-iterator.h
> > > > > index 970793d07a..93646c3bea 100644
> > > > > --- a/dir-iterator.h
> > > > > +++ b/dir-iterator.h
> > > > > @@ -19,7 +19,7 @@
> > > > >   * A typical iteration looks like this:
> > > > >   *
> > > > >   *     int ok;
> > > > > - *     struct iterator *iter = dir_iterator_begin(path);
> > > > > + *     struct iterator *iter = dir_iterator_begin(path, 0);
> > > >
> > > > Outside of this context, we already mentione errorhandling when
> > > > 'ok != ITER_DONE' in his example.  This still can't happen with the
> > > > way the dir iterator is used here, but it serves as a reminder if
> > > > people are using the DIR_ITERATOR_PEDANTIC flag.  Good.
> > >
> > > This made me think again about the documentation saying that
> > > dir_iterator_abort() and dir_iterator_advance() may return ITER_ERROR,
> > > but the implementation does not containing these possibilities.
> > > (Besides when the pedantic flag is used). Maybe the idea was to make
> > > API-users implement the check for an ITER_ERROR in case dir-iterator
> > > needs to start returning it in the future.
> >
> > Yeah, I think that was the intention.
> >
> > > But do you think such a change in dir-iterator is likely to happen?
> > > Maybe we could just make dir_iterator_abort() be void and remove this
> > > section from documentation. Then, for dir_iterator_advance() users
> > > would only need to check for ITER_ERROR if the pedantic flag was given
> > > at dir-iterator creation...
> >
> > Dunno.  In a world where we have the pedantic flag, I think only
> > returning ITER_ERROR if that flag is given might be what we want to
> > do.  I can't think of a reason why we would want to return ITER_ERROR
> > without the pedantic flag in that case.
> 
> Ok. I began doing the change, but got stuck in a specific decision.
> What I was trying to do is:
> 
> 1) Make dir_iterator_advance() return ITER_ERROR only when the
> pedantic flag is given;
> 2) Make dir_iterator_abort() be void.
> 
> The first change is trivial. But the second is not so easy: Since the
> [only] current API user defines other iterators on top of
> dir-iterator, it would require a somehow big surgery on refs/* to make
> this change. Should I proceed and make the changes at refs/* or should
> I keep dir_iterator_abort() returning int, although it can never fail?

Maybe I'm missing something, but wouldn't this change in refs.c be
enough? (Other than actually making dir_iterator_abort not return
anything)

	diff --git a/refs/files-backend.c b/refs/files-backend.c
	index 5848f32ef8..81863c3ee0 100644
	--- a/refs/files-backend.c
	+++ b/refs/files-backend.c
	@@ -2125,13 +2125,12 @@ static int files_reflog_iterator_abort(struct ref_iterator *ref_iterator)
	 {
	        struct files_reflog_iterator *iter =
	                (struct files_reflog_iterator *)ref_iterator;
	-       int ok = ITER_DONE;
	 
	        if (iter->dir_iterator)
	-               ok = dir_iterator_abort(iter->dir_iterator);
	+               dir_iterator_abort(iter->dir_iterator);
	 
	        base_ref_iterator_free(ref_iterator);
	-       return ok;
	+       return ITER_DONE;
	 }
	 
	 static struct ref_iterator_vtable files_reflog_iterator_vtable = {

Currently the only thing calling dir_iterator_abort() is
files_reflog_iterator_abort() from what I can see, and
dir_iterator_abort() always returns ITER_DONE.

That said, I don't know if this is actually worth pursuing.  Having it
return some value and having the caller check that makes it more
future proof, as we won't have to change all the callers in the future
if we want to start returning anything other than ITER_DONE.   Just
leaving it as it is now doesn't actually hurt anybody I think, but may
help in the future.

> There's also a third option: The only operation that may fail during
> dir_iterator_abort() is closedir(). But even on
> dir_iterator_advance(), I'm treating this error as "non-fatal" in the
> sense that it's not caught by the pedantic flag (although a warning is
> emitted). I did it like this because it doesn't seem like a major
> error during dir iteration... But I could change this and make
> DIR_ITERATOR_PEDANTIC return ITER_ERROR upon closedir() errors for
> both dir-iterator advance() and abort() functions. What do you think?

I think this might be the right way to go.  We don't really need an
error from closedir, but at the same time if we are being pedantic,
maybe it should be an error.  I don't have a strong opinion here
either way, other than I think it should probably keep returning an
int.

> > Though I think I would change the example the other way in that case,
> > and pass DIR_ITERATOR_PEDANTIC to 'dir_iterator_begin()', as it would
> > be easy to forget error handling otherwise, even when it is
> > necessary.  I'd rather err on the side of showing too much error
> > handling, than having people forget it and having users run into some
> > odd edge cases in the wild that the tests don't cover.
> 
> Yes, I agree.
> 
> > > Also CC-ed Michael in case he has some input
