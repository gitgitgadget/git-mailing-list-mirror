Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2E4720248
	for <e@80x24.org>; Sat, 30 Mar 2019 19:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbfC3T1n (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 15:27:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37420 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730713AbfC3T1n (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 15:27:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so6696225wrm.4
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 12:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5XEQFV90aPjdLv+MecW21b8I1Kvyk+/X8WCU6O8wp4U=;
        b=q4D57YebMWDO2sYt/Z3DGEQLtr9rJ3vIApeEpKGczCmcVSqYCicF9AFJwkUn8habUB
         fLWT4XDYOIJZwpsKtdHx82i9DU+ogAfJTAH3SWKxsUwlno92KgJz86zBMRj2GRnC+EC7
         pl3uUAronU1sNF2CCtKgt+M88ymBFlgnDgVRiQG9DtHIbxNunAZI/RHnvQRfG8SwrgVq
         5Ry48rXYMq+3WBo9O2ZYnptidHF68MVTtZTgJyVSAnQHVwuJ4u6jAKPgO2+aYhQZb8I/
         ORltAJz4146vQLqQNL9Ml//wVuk+l99axzRU8TFg9L4kMZidS5Y1bO9pXX7B93WLqudX
         H+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5XEQFV90aPjdLv+MecW21b8I1Kvyk+/X8WCU6O8wp4U=;
        b=rwDAUK+IFreoMFipPSo+t26ooNWBN8bnb+mwgE/RFCFqNzg5SGjQPi3eJXJJJPkOrN
         VmqFNKSCwFj+zKgI+EyAF9cAKcg1Z39XfXrgiKEDlIntx4f8Hbq7oPjhXXdYrbfD34Q1
         fYLowIsHIk8pEllPjOcUwyu1W3lGgt5hbW6dXpTDCx7T4tNq12S65/IBmnqCB43H1JIO
         isvAX2Ja1UD95xRz1IUOhoxdTENNjlIoMm78h3FtP6JuzQ0ALxU1qmiHdnWEpnypX8gr
         m28UN2Cz3B7X0V6IL3kLuSLt0EBmvkOhVtAao22G94B4iU4UzUr+K+3Bb+9rQ1kk7mrk
         Chzw==
X-Gm-Message-State: APjAAAXtNkNjFuw4wzBzWULm1stDdsbvgZB8VKSR1JtYoQDgSOSpegwt
        4vOFdBX6/QtKyQUorQv/zZ4=
X-Google-Smtp-Source: APXvYqyyw6w6Bx63o7x2irRhFZeHZk+9rrLJgeodLuBCK19ghHJvQhFMNfm57ul2B6Qf/+Z5kCdv+g==
X-Received: by 2002:adf:ec11:: with SMTP id x17mr34230758wrn.120.1553974061013;
        Sat, 30 Mar 2019 12:27:41 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id q3sm6769438wrr.75.2019.03.30.12.27.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 12:27:39 -0700 (PDT)
Date:   Sat, 30 Mar 2019 19:27:38 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Kernel USP <kernel-usp@googlegroups.com>,
        Benoit Pierre <benoit.pierre@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [GSoC][PATCH v4 2/7] clone: better handle symlinked files at
 .git/objects/
Message-ID: <20190330192738.GQ32487@hank.intra.tgummerer.com>
References: <20190226122829.19178-1-avarab@gmail.com>
 <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190322232237.13293-3-matheus.bernardino@usp.br>
 <20190328221049.GK32487@hank.intra.tgummerer.com>
 <CAHd-oW78Cwhq8sFFjOX4c6kS8JsEUUd_RGgheJhdN6MLAr+G2Q@mail.gmail.com>
 <20190329200517.GO32487@hank.intra.tgummerer.com>
 <CAHd-oW5aTyr7OmYwETLHYbHbRYgcUPuHpt2eN=Z2FWrqUQTzJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd-oW5aTyr7OmYwETLHYbHbRYgcUPuHpt2eN=Z2FWrqUQTzJQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/30, Matheus Tavares Bernardino wrote:
> On Fri, Mar 29, 2019 at 5:05 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >
> > On 03/29, Matheus Tavares Bernardino wrote:
> > > Ok, what if instead of using linkat() we use 'realpath(const char
> > > *path, char *resolved_path)', which will resolve any symlinks at
> > > 'path' and store the canonical path at 'resolved_path'? Then, we can
> > > still keep using link() but now, with the certainty that all platforms
> > > will have a consistent behaviour? (also, realpath() is POSIX.1-2001)
> > > Would that be a better idea?
> >
> > Yeah, I think that is a good idea.  Note that 'realpath()' itself is
> > not used anywhere in our codebase either, but there is
> > 'strbuf_realpath()', that from reading the function documentation does
> > exactly what 'realpath()' would do.  So using 'strbuf_realpath()'
> > would probably be the right thing to do here.
> 
> Thanks. While I was looking for realpath() at git codebase (before I
> saw your email), I got a little confused: Besides strbuf_realpath() I
> also found real_path(), real_path_if_valid() and real_pathdup(). All
> these last three use strbuf_realpath() but they also initialize the
> struct strbuf internally and just return a 'char *', which is much
> convenient in some cases.

Right, feel free to use whichever is most convenient for you, and
whichever works in the context.

>                            What seems weird to me is that, whilst
> real_pathdup() releases the internally initialized struct strubuf
> (leaving just the returned string to be free'd by the user), the other
> two don't. So, if struct strbuf change in the future to have more
> dynamic allocated resources, these functions will also have to be
> modified. Also, since real_pathdup() can already do what the other two
> do, do you know if there is a reason to keep all of them?

Right, '*dup()' functions usually leave the return value to be free'd
by the caller.  And while 'real_pathdup()' could do what the others do
already it also takes more effort to use it.  Users don't need to free
the return value from 'real_path()' to avoid a memory leak.  This
alone justifies its existence I think.

> One last question: I found some places which don't free the string
> returned by, for example, real_path() (e.g., find_worktree() at
> worktree.c). Would it be a valid/good patch (or patches) to add free()
> calls in this places? (I'm currently trying to get more people here at
> USP to contribute to git, and maybe this could be a nice first
> contribution for them...)

Trying to plug memory leaks in the codebase is definitely something
that I think is worthy of doing.  Sometimes it's not worth actually
free'ing the memory, for example just before the program exits, in
which case we can use the UNLEAK annotation.  It was introduced in
0e5bba53af ("add UNLEAK annotation for reducing leak false positives",
2017-09-08) if you want more background.

That said, the memory from 'real_path()' should actually not be
free'd.  The strbuf there has a static lifetime, so it is valid until
git exits.  If we were to free the return value of the function we'd
actually free an internal buffer of the strbuf, that is still valid.
So if someone were to use 'real_path()' after that, the memory that
strbuf still thinks it owns would actually have been free'd, which
would result in undefined behaviour, and probably would make git
segfault.
