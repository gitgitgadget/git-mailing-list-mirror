Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2512F20248
	for <e@80x24.org>; Thu, 11 Apr 2019 21:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfDKVJf (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 17:09:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38282 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbfDKVJd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 17:09:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id w15so8351801wmc.3
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 14:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b8Ktjstfzz1a6AjWM9Tb1pTxAFWA/C5BfCYyVmaCREQ=;
        b=RPhIYfpyZpiDkR364FhZxYEkH9R53U0OrL8WUvOMBKEFT6UDOFBcRhIhsVtTfVFENG
         2+JH0VcvpdLUj/Y1NMrde1/8n+2i6aGH8mGCbLVu9nwRkVNzRK1Y3WHgd4JHQTFY/uPG
         U4egLYpblX4HO0Qg4Cw2r+/VWAIf1mA5obG3LHc5yTe7UMg8UBUi5f2OSUfUrRfMj3ab
         jbl5D7velqE5w8Vfe2m1isyEJCmhDF0ISObVceiOuarbOmf/XKZ0crtKAi4ql4bfk/04
         mVXxLgPH1vc3rOLyPLnNrQYsTv7+L1jEKzrQnZjZvRPWsVd2M3Laj4a1Vx0MuIyYy8UK
         xpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b8Ktjstfzz1a6AjWM9Tb1pTxAFWA/C5BfCYyVmaCREQ=;
        b=eAOhJRuT9HVfAjmUUb4te4AcQCxMOYaXNUkIkwlFPp1Tn1ygmSyU6k7RPkKjXNxDIT
         h8SxSfscW/VRq9vuY6KIUD3XQVYW9VYc8Sjm+77SowsyXCcmPo5aVAwnDR0w1+GdftB2
         34OzuKJiQuxZD7wRp27uj/ZxUbms3gvSSs0fTJTuyFjG8owUcd2I2lxrZVUfi81x1aSy
         lt9MCEhLkFDAHBmDweATeEMdGno60oPsr5gQ0VimCFXPG7Kh2SjhLyJhMp8/P2YVt1Cv
         +47T403UvQwJsQz+KmxFRME3qjBPKQhP/utCdTfK1RmzRUFZdzzcwLBX7z6kMK2csenC
         s1RQ==
X-Gm-Message-State: APjAAAVnw1pc78KRGniiuvx4NtMZtfvhDpFCYtZ6/kncPZEY9joPn7O/
        JVuYOFDry5M0YOOiz1whrgA=
X-Google-Smtp-Source: APXvYqy+Zb2DOEnSCJphdMkZ6XwKZlojv2EhQzTMVQwn2hBJhx1U5DbzBT0/gszDyyM0nlyTZ8v5sg==
X-Received: by 2002:a7b:cd08:: with SMTP id f8mr8327241wmj.86.1555016972260;
        Thu, 11 Apr 2019 14:09:32 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id y133sm9663725wmd.2.2019.04.11.14.09.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 14:09:28 -0700 (PDT)
Date:   Thu, 11 Apr 2019 22:09:27 +0100
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
Message-ID: <20190411210927.GE32487@hank.intra.tgummerer.com>
References: <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190330224907.3277-1-matheus.bernardino@usp.br>
 <20190330224907.3277-4-matheus.bernardino@usp.br>
 <20190331181209.GT32487@hank.intra.tgummerer.com>
 <CAHd-oW7yPj5Ons3kfdEHtFgowc=F=2BD9EvU+fJbHe9=UXhx1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd-oW7yPj5Ons3kfdEHtFgowc=F=2BD9EvU+fJbHe9=UXhx1g@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/10, Matheus Tavares Bernardino wrote:
> > > diff --git a/dir-iterator.h b/dir-iterator.h
> > > index 970793d07a..93646c3bea 100644
> > > --- a/dir-iterator.h
> > > +++ b/dir-iterator.h
> > > @@ -19,7 +19,7 @@
> > >   * A typical iteration looks like this:
> > >   *
> > >   *     int ok;
> > > - *     struct iterator *iter = dir_iterator_begin(path);
> > > + *     struct iterator *iter = dir_iterator_begin(path, 0);
> >
> > Outside of this context, we already mentione errorhandling when
> > 'ok != ITER_DONE' in his example.  This still can't happen with the
> > way the dir iterator is used here, but it serves as a reminder if
> > people are using the DIR_ITERATOR_PEDANTIC flag.  Good.
> 
> This made me think again about the documentation saying that
> dir_iterator_abort() and dir_iterator_advance() may return ITER_ERROR,
> but the implementation does not containing these possibilities.
> (Besides when the pedantic flag is used). Maybe the idea was to make
> API-users implement the check for an ITER_ERROR in case dir-iterator
> needs to start returning it in the future.

Yeah, I think that was the intention.

> But do you think such a change in dir-iterator is likely to happen?
> Maybe we could just make dir_iterator_abort() be void and remove this
> section from documentation. Then, for dir_iterator_advance() users
> would only need to check for ITER_ERROR if the pedantic flag was given
> at dir-iterator creation...

Dunno.  In a world where we have the pedantic flag, I think only
returning ITER_ERROR if that flag is given might be what we want to
do.  I can't think of a reason why we would want to return ITER_ERROR
without the pedantic flag in that case.

Though I think I would change the example the other way in that case,
and pass DIR_ITERATOR_PEDANTIC to 'dir_iterator_begin()', as it would
be easy to forget error handling otherwise, even when it is
necessary.  I'd rather err on the side of showing too much error
handling, than having people forget it and having users run into some
odd edge cases in the wild that the tests don't cover.

> Also CC-ed Michael in case he has some input
