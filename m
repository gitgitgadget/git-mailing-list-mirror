Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DC221F462
	for <e@80x24.org>; Mon, 29 Jul 2019 10:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387441AbfG2K0z (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 06:26:55 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35424 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfG2K0z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 06:26:55 -0400
Received: by mail-io1-f66.google.com with SMTP id m24so118800154ioo.2
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 03:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gI7Li7SbkWUZ9JbWBKxitcoNXzVkAzm1DcxKYzMM1f4=;
        b=Pma6VyoYli6crFnCeNeTK4JtCmlst1zoC0ALHt3cx2u2xmS41A+A8iPGm7AV1qYybE
         3FUFyUr1XYUFl3TdyvN7qqeVDTV6kF8Vq/5pob/QM+0LkHX1SVKMDnRpGQKaHViPYLaW
         5qxkzJvoHFfUK275UgMo47Y3bslizPqNC8RcC9TA5fgfoWkJF3kmqRjNPRfWF9q3hvEe
         vh9QSJc4wqj919Pe6EcFuPXpyAJH82pkW98WtMmjyS2tZMI+kpsn5UgS/sNCyRhG6lBA
         0leW00ex+vmrcsPe/J3MZ1VsMWy+KWb7LEjxFB8bu3mq8RKOdmp9RcLtXTrz8wMsyhUt
         w3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gI7Li7SbkWUZ9JbWBKxitcoNXzVkAzm1DcxKYzMM1f4=;
        b=NFfimR8I+04lmqrbjo8KTQE8FfhvSoabEQ+HffgW1FDyPwrtqdUUJyBxey7XGBmh0U
         3+xJ0/O49YR2UwfQo/tPkYth8iunRMt33W6ZXNAGZYT0Fki4ytwvhD432C3/SubA6Evg
         BXtToq3sby1D/9Y9dy19OjjIcZy8wrNRBv6tQiW0AzWFW8+gdMjdZep5gHlpubofdil7
         nKp3nmTNd4uWzOplhRyXBbPrCx0OEFqbjfFvy3rll4EjX+T9gkVUW/5oeUGBlb6INSOI
         2WH2fejZXZK89GLxAzK7zvC6/NSKYo3uc/orMLbApE3YsBn97Tw0s7kXVjcsnbab4CxD
         a6Mg==
X-Gm-Message-State: APjAAAVEj02wgl0CSUZYnh34tTJ8CHcfl9RVJxhZN7BCY2kEh4mdDhco
        giAALxUE8pUQW3CYQrixUprSB77QBwgGdURZ7m4HhxipV8Q=
X-Google-Smtp-Source: APXvYqx8Ks1z1hZCPm+AqMXod5jVGQU+eR2BNh0HsKqI2nSironAcJo5PvuxE3eSgpTj4p0kqd+2yXky9INC1/vrf60=
X-Received: by 2002:a02:b016:: with SMTP id p22mr27292062jah.121.1564396013371;
 Mon, 29 Jul 2019 03:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190728235427.41425-1-carenas@gmail.com> <8736ip6wzk.fsf@evledraar.gmail.com>
In-Reply-To: <8736ip6wzk.fsf@evledraar.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 29 Jul 2019 03:26:42 -0700
Message-ID: <CAPUEspgQNCENviPYP6X790DvSgj_RpJVo2KP_39voLQnVc65pQ@mail.gmail.com>
Subject: Re: [RFC PATCH] grep: allow for run time disabling of JIT in PCRE
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 29, 2019 at 1:55 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Mon, Jul 29 2019, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>
> > PCRE1 allowed for a compile time flag to disable JIT, but PCRE2 never
> > had one, forcing the use of JIT if -P was requested.
>
> What's that PCRE1 compile-time flag?

NO_LIBPCRE1_JIT at GIT compile time (regardless of JIT support in the
PCRE1 library you are using)

> > After ed0479ce3d (Merge branch 'ab/no-kwset' into next, 2019-07-15)
> > the PCRE2 engine will be used more broadly and therefore adding this
> > knob will give users a fallback for situations like the one observed
> > in OpenBSD with a JIT enabled PCRE2, because of W^X restrictions:
> >
> >   $ git grep 'foo bar'
> >   fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'
> >   $ git grep -G 'foo bar'
> >   fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'
> >   $ git grep -E 'foo bar'
> >   fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'
> >   $ git grep -F 'foo bar'
> >   fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'
>
> Yeah that obviously sucks more with ab/no-kwset, but that seems like a
> case where -P would have been completely broken before, and therefore I
> can't imagine the package ever passed "make test". Or is W^X also
> exposed as some run-time option on OpenBSD?

ironically, you could use PCRE1 since that is not using the JIT fast
path and therefore will fallback automatically to the interpreter

there is also a convoluted way to make your binary work by moving
it into a mount point that has been specially exempted from that W^X
restriction.

> I.e. aside from the merits of such a setting in general these examples
> seem like just working around something that should be fixed at make
> all/test time, or maybe I'm missing something.

1) before you could just avoid using -P and still be able to grep
2) there is no way to tell PCRE2 to get out of the way even if you are
    not using -P

you are right though that this is not a new problem and was reported
before with patches and the last comment saying a configuration
should be provided.

> To the extent that we'd want to make this sort of thing configurable, I
> wonder if a continuation of my (*NO_JIT) patch isn't better, i.e. just
> adding the ability to configure some string we'd inject at the start of
> every pattern.

looking at the number of lines of code, it would seem the configuration
approach is simpler.

> That would allow for setting any other number of options in
> pcre2syntax(3) without us needing to carry config for each one,
> e.g. (*LIMIT_HEAP=3Dd), (*LIMIT_DEPTH=3Dd) etc. It does present a larger
> foot-gun surface though...

the parameters I suspect users might need are not really accessible through
that (ex: jit stacksize).

it is important to note that currently we are not preventing any user to us=
e
those flags themselves in their patterns either.

Carlo
