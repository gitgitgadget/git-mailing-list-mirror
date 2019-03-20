Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C86C20248
	for <e@80x24.org>; Wed, 20 Mar 2019 21:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfCTV7U (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 17:59:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51219 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbfCTV7U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 17:59:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so264545wmf.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 14:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ih7wZ9cYqZIusLcmjVL9OgQJnyHAuR9ctwPuofXC6AI=;
        b=FiiMchUfyyaosP03qoxXEgiaON/vnbkZKMZ0XryO85J+ISYrIe/XWmtU+0x/cAeSJd
         ku9Iot55B/ExeYkeNuvLbC4QTaF5Hn0nePUbcc6N7/8BS5wxsWMiU6P1Og2KuTQ3cS3L
         k+26CS4nMyORAwchidDKV3+Yc116qpeLdVQ/lhJrvKKGC6tmcKUnFH+gOYtO1uiNWRCh
         JjDO0AkyNthN+t/zV204D33MA5wtidLD+Wd4ccmYJoGqGiWfu0s36XgRuqEuAncXCFie
         OoNp1UrDXlLPeCr/Ufnla4XIhTZexyCrAWNMtYB0iKNUeRXJvEeFkx9uxpTYdQkownQa
         pVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ih7wZ9cYqZIusLcmjVL9OgQJnyHAuR9ctwPuofXC6AI=;
        b=kbHx0S9rnQ9gHA/AFZWUpr55AnKz98IisbtqDBrEid2GXM/G01gIGhqlWTzbZM8gx0
         Pt+UG0Y6gqSGyEjT9pfcK7Qi5Mnlb/wnpA4J/7Dha8rH+wg8ZYckD86lXsC5D4s8q+ol
         iOwZAo8Klb+pz3lbs0/1Rd0THO9Md7+mEW++IVsI6vvukClHaGYW+1X7pqBla3oAD0sU
         WU2ZPgT/HHB6s36QSmMSPF2lmEUPGNi4GvXDvh7AguY8RQ4RINVOUYNrjm/miMVMP03m
         A0xlarxnQCSTtuXfe8MXHT0OqU3GHKsdoX0+NQLaZxiiOI3FVcr9LcmLG/axkpQiguTB
         jvJg==
X-Gm-Message-State: APjAAAUZPG/L+Ukv7XBYIe1shWHZZSSBJWTGi35Ni4kdpIROnnAnRbI/
        fOm81eSRaqUajXZjpeWfWmgYBVrQ
X-Google-Smtp-Source: APXvYqxtlgQ4yk4jJPWGGL/INZGfw5fk8mGYK7jUq9imllft4nYCON/hu3i/coJROq62DV1SZbq39Q==
X-Received: by 2002:a1c:1dc3:: with SMTP id d186mr289602wmd.64.1553119158622;
        Wed, 20 Mar 2019 14:59:18 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id z1sm2697545wrw.28.2019.03.20.14.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 14:59:17 -0700 (PDT)
Date:   Wed, 20 Mar 2019 21:59:16 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Matthew Kraai <mkraai@its.jnj.com>
Subject: Re: [REGRESSION ps/stash-in-c] git stash show -v
Message-ID: <20190320215916.GD32487@hank.intra.tgummerer.com>
References: <20190319190503.GA10066@dev-l>
 <20190319231826.GB32487@hank.intra.tgummerer.com>
 <20190320050449.GA6401@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320050449.GA6401@sigill.intra.peff.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/20, Jeff King wrote:
> On Tue, Mar 19, 2019 at 11:18:26PM +0000, Thomas Gummerer wrote:
> 
> > From a quick search I couldn't find where 'git diff' actually parses
> > the '-v' argument, but I wonder if we should actually disallow it, in
> > case we want to use it for something else in the future?  It's not
> > documented anywhere in the docs either.
> 
> It's a bit interesting, actually. git-diff uses setup_revisions() to
> parse its arguments, which picks up any diff options, as well as parsing
> the revs and pathspecs.
> 
> But it also means we accept any random revision options. So nonsense
> like:
> 
>   git diff --ancestry-path HEAD^ HEAD
> 
> is accepted, even though nobody ever looks at the flags set by parsing
> that option.
> 
> And "-v" is mostly in the same boat. It works more or less like --pretty
> (try rev-list with and without it), and does nothing for an endpoint
> diff. What's a little interesting, though, is that it was originally
> added as a diff-tree option in the very early days, via cee99d2257
> (diff-tree: add "verbose header" mode, 2005-05-06). And the reason there
> is that "diff-tree --stdin" filled a "log"-like role; it didn't traverse
> the commits itself, but it was responsible for showing them.

Thanks for the explanation!

> Most of that is historical curiosity, but I think the takeaways are:
> 
>   - we probably should use a less bizarre option to demonstrate this bug
>     (Junio suggested --patience, which makes perfect sense to me)

Yep, that should make the test a bit easier to understand.  Will do
that in v2.

>   - we may want to teach the "diff" porcelain not to accept useless
>     revision options. I suspect it may be a bit tricky, just because of
>     the way the code takes advantage of setup_revisions.  It would also
>     be nice if "diff-tree" in non-stdin mode could do the same, but I
>     suspect that is even trickier (we do not even know whether we are in
>     --stdin mode or not until we've fed the options to setup_revisions).
>     So I'd guess this is not really worth the effort it would take.
> 
>   - "-v" is a real thing; we should consider either documenting it or
>     deprecating it.

Makes sense, I don't have a strong opinion on which way we should go
here, but I'll leave that separately from the bug fix either way.
