Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D41C21F461
	for <e@80x24.org>; Mon, 24 Jun 2019 07:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfFXHQ2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 03:16:28 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41313 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfFXHQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 03:16:27 -0400
Received: by mail-ed1-f66.google.com with SMTP id p15so20200973eds.8
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 00:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A2Nm4ueIK6poK1Iu1yBTcrAKI0JLT8vIJDXw/L2iJoA=;
        b=PyRzbpOzUagq+0FFKo/qxq+FlvHRoe+JqzK1tyhONy5Nl/bTF921g4u7NEk2WX9sHb
         p58P7cwcxwQttKU295td33QwSi6RZ7KSzIqSEUhG6Qu06BzyrISd9lp1gC7gf+AfshbY
         JcDu4f3iEBsyzbuiFkLHcc2QFK0kRXMl6yoTA/U0KvqLgu3bPW7OaWOxRhEL03BlcLty
         OjPyqrXblc+qAqgxmcR6cwyRNsGLGD+0aY524lJFdcIkwg3y3BkKB+30U6uSvtmP3BMg
         84/ykLRDLPqPLIRIy4ibzEIpTZ43uceNFbIjWfVtzrJp0kyKpuZSN5A9NRb1qdSU58w8
         FNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A2Nm4ueIK6poK1Iu1yBTcrAKI0JLT8vIJDXw/L2iJoA=;
        b=Ot2APjmpFoX6drg8+eVn5b8VkHKQo6kCDv3X+iuBLJo1PljgqdtHsaAmsUqyREWwNT
         X9cotYOgYmMGd8uwCUgShMrCNM9V5Z5i4qoNctogfhZgbg3LZ0rr2SnBU4gxLpodobAn
         wtE29XT69FDZwIx9TQ2wTzuDxPvIr2k9+fdrny/XxC1/mAlPU5s6rJh6jREIxb0A1tgi
         qBRBx6zIN9WTa1SqRHMmDjooB6B06R6MLcm5eeugeJfEYScBwhSOpQYKOiJmDnd2i667
         2obNJnqxxTCryQFIWfMEjBF7Pb+6Jyw3gE8FxGwOizaa2wrVZ32ZdKZqFreR5EL+awce
         S/dg==
X-Gm-Message-State: APjAAAXoam/WXv295aPacttoqABKpz/pz6J7bWq7BXB+9YG9L5S+jRPW
        m8jnyGb50l76bj1UiXcnaf8vDZafLIcrI5eBv1g=
X-Google-Smtp-Source: APXvYqwKSzVSABN1ls/UuntEyzf39GGpfBZW68bt58VrWQmRhMJNYd0CwAz2BaK57+kBy9G5pmaX2aDYE+Lzcztfwdg=
X-Received: by 2002:a50:886a:: with SMTP id c39mr117303405edc.214.1561360585251;
 Mon, 24 Jun 2019 00:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAC_CU1iWBCTt5jLQ0Zp2HoyA0oFgG3shDB2rLfOsmC+x67NdAw@mail.gmail.com>
 <xmqq5zp9wdjb.fsf@gitster-ct.c.googlers.com> <CAC_CU1hHK5n4GcETbWFLBeqT_Y9LV6N32Rv0F0+OCXH2G0qg8Q@mail.gmail.com>
 <20190623224935.GD1100@sigill.intra.peff.net>
In-Reply-To: <20190623224935.GD1100@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 24 Jun 2019 09:16:13 +0200
Message-ID: <CAP8UFD1gWnkJZSzjOxOHdS4R3GCUSDgC9X85y_Yvc0LmyK19Cw@mail.gmail.com>
Subject: Re: git bisect should return 1 when the first bad commit is found
To:     Jeff King <peff@peff.net>
Cc:     Pedro Larroy <pedro.larroy.lists@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 24, 2019 at 4:51 AM Jeff King <peff@peff.net> wrote:
>
> On Sun, Jun 23, 2019 at 01:32:16PM -0700, Pedro Larroy wrote:
>
> > Thanks for your answer.
> >
> > I was expecting the HEAD to point to the first bad commit.
> >
> > In mercurial, the exit status tells you information about the
> > bisection process:  https://www.mercurial-scm.org/repo/hg/help/bisect

It's not clear from he above URL how that differs from what git bisect
does. I only found "Returns 0 on success" there which is not very
explicit, and we could argue that it's also what git bisect does.

> > Sure one can parse stdout, it's just more tedious than just checking
> > the return code and having the HEAD left to the original bad commit.

The git bisect documentation says:

       Eventually there will be no more revisions left to inspect, and
the command will print out a description of the first bad commit. The
reference
       refs/bisect/bad will be left pointing at that commit.

So you just need to parse stdout to detect that it found the first bad
commit, and then you can use refs/bisect/bad.

If the return code was used, how would you distinguish between a
failure in the command (for example if you give bad information to
`git bisect good` or `git bisect bad`) and the fact that it has not
yet found the first bad commit? Anyway you would need to add some
logic for that.

> I think it might be nice for Git to write a well-known refname (like
> BISECT_RESULT or similar) so that you can refer to that instead of
> having to read stdout (whether by machine or by a user
> cutting-and-pasting). And I cannot offhand think of a particular reason
> why that could not just be HEAD (instead of something bisect-specific)
> after the bisect finishes.

If it would be HEAD, it would mean that git bisect would potentially
have to do one more checkout so that HEAD points to the first bad
commit. This checkout would sometimes be useless, so it's more
efficient to use something like refs/bisect/bad rather than HEAD.

> We do not promise any particular value in HEAD now. The only downside
> would be the minor cost to checkout the working tree of the known-bad
> commit if we are not already there.

Though we might not explicitly promise in the doc that HEAD will stay
at the last commit that was tested, I think that's something people
can expect from the way we describe how bisect work. So I don't think
it would be a good idea to change our behavior.
