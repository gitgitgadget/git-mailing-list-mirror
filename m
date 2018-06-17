Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA64E1F597
	for <e@80x24.org>; Sun, 17 Jun 2018 02:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757056AbeFQC5k (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 22:57:40 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:56062 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756945AbeFQC5j (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 22:57:39 -0400
Received: by mail-it0-f66.google.com with SMTP id 16-v6so7681986itl.5
        for <git@vger.kernel.org>; Sat, 16 Jun 2018 19:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DMiWlyTq6TwoSw+NVB0VzHpvfIW2XgzbXziApW+PuT4=;
        b=vbJjmnXOsgYeUsuVnn2bk7/OhutoO8Q7bDCT9BSZ8s9woMdMyqN2iMxjNaWaMCNiLm
         wo+xUiz89Hfc6hyzmx7VUayq00qw/mgcVLiuAD9KhPweNFQto6tO47dJpAb48DmXNTkk
         RRpQDS7u84Y1YwpcwN2qX5uRu9nyLfDmqTFd3aHv+3Ha4hEuO2zKqriU4epN3hs0uskA
         LRBroUl64S18R0YirHmxsv/uK8KCoekAN+aKAXpkvn9Y+E5m8AqEnI5nu4hzBzj6ftwY
         HY3VETxGkj5RAPZcxMg8mfze4ycZWDCHrcept3pvIYlmVNVz7/V1mpOp0rLlIuaxeFrk
         kN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DMiWlyTq6TwoSw+NVB0VzHpvfIW2XgzbXziApW+PuT4=;
        b=KXdnQC09Fr6SVr6su7csAy3mM0f4O/gzCerQZr3VjbZU0iB7m4n8aSgAdHUcnxfLBx
         ZMfxZo9BdayF17wi384EyS4er/ZgDFNSPCvcq+w105hDbIcYSK2GfHcUdE5w52x9bpPu
         yxdNiUJXhwbJulIRZAQ2xgur1DW7a41IXgckNK6uf7rfRlTX9rkdn2bxGl3qXEZ5WtOC
         5Wudetnjm4nwLmxtKwVci3DhekatDWz2xthdSBPLpADKKfWISlMC+ryWJCP2mtz99c+o
         J8NSSOVJkr2f7w5LGgQWtr80VHW5EobJqmAFFGhMF3L8z8VxOaVNpSqX10N+8X/gwbDs
         4P+w==
X-Gm-Message-State: APt69E3+zbpNNLY0J+kKypgkFTUXuZqciUuBz0ZXm8xOlufutzpJCqqv
        rDyXz+yL40sEw/M5EhmRMqvoU8yJNbkqR2zzPCU=
X-Google-Smtp-Source: ADUXVKIaVztEYJJZm1qJPcn2b86MojjgDEH/6Q63udt4VY5+l1OoAhclteTK+iy+PDmaZLjxKLjYwRdNyNwbw0NZJ2A=
X-Received: by 2002:a02:a999:: with SMTP id q25-v6mr5743969jam.47.1529204258867;
 Sat, 16 Jun 2018 19:57:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22d0:0:0:0:0:0 with HTTP; Sat, 16 Jun 2018 19:57:38
 -0700 (PDT)
In-Reply-To: <CACcTrKePbgyCbXneN5NZ+cS-tiDyYe_dkdwttXpP0CUeEicvHw@mail.gmail.com>
References: <CACcTrKePbgyCbXneN5NZ+cS-tiDyYe_dkdwttXpP0CUeEicvHw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 17 Jun 2018 04:57:38 +0200
Message-ID: <CAP8UFD2SJF_gbP-mdXoAH0t_OmLjRbPuVK5vZZjgs2N9eJz5KQ@mail.gmail.com>
Subject: Re: Is NO_ICONV misnamed or is it broken?
To:     Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Cc:     git <git@vger.kernel.org>, "Fernando J. Pereda" <ferdy@gentoo.org>,
        Joachim Schmitz <jojo@schmitz-digital.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Jun 15, 2018 at 12:47 AM, Mahmoud Al-Qudsi <mqudsi@neosmart.net> wrote:
> Hello list,
>
> With regards to the Makefile define/variable `NO_ICONV` - the Makefile
> comments imply that it should be used if "your libc doesn't properly support
> iconv," which could mean anything from "a patch will be applied" to "iconv
> won't be used."

b6e56eca8a (Allow building Git in systems without iconv, 2006-02-16)
which added NO_ICONV says:

    Systems using some uClibc versions do not properly support
    iconv stuff. This patch allows Git to be built on those
    systems by passing NO_ICONV=YesPlease to make. The only
    drawback is mailinfo won't do charset conversion in those
    systems.

> Based off the name of the varibale, the assumption is that iconv is an
> optional dependency that can be omitted if compiled with NO_ICONV. However, in
> practice attempting to compile git with `make ... NO_ICONV=1` and libiconv not
> installed results in linker errors as follows:
>
> ```
> ~> make clean
> # omitted
> ~> make NO_ICONV=1
> # ommitted
>     LINK git-credential-store
> /usr/bin/ld: cannot find -liconv
> cc: error: linker command failed with exit code 1 (use -v to see invocation)
> gmake: *** [Makefile:2327: git-credential-store] Error 1
> ```

Yeah, this might be an issue with the Makefile options.

> Am I misunderstanding the intended behavior when NO_ICONV is defined (i.e. it
> does not remove the dependency on libiconv) or is this a bug and iconv should
> not, in fact, be required?

It's difficult to tell from reading the comments and commit messages.

I think 597c9cc540 (Flatten tools/ directory to make build procedure
simpler., 2005-09-07) which introduces NEEDS_LIBICONV is even older
than the commit that introduced NO_ICONV (see above), so you might
want to play with NEEDS_LIBICONV too and see if it works better for
you.

(I understand that "you might want to play with such and such other
options" is perhaps not as helpful as what you expected, but I
previously tried to tighten the way we handle dependencies in the
Makefile and it was considered "too heavy handed". So yeah, we
consider it ok if people have to tinker a bit when they want to build
Git.)

I CC'ed the people involved in related commits. Maybe they can give
you a better answer. It might also help if you could tell us on which
OS/Platform and perhaps for which purpose you want to compile Git.

Best,
Christian.
