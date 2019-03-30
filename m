Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED52320248
	for <e@80x24.org>; Sat, 30 Mar 2019 05:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfC3FcP (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 01:32:15 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40001 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbfC3FcP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 01:32:15 -0400
Received: by mail-it1-f194.google.com with SMTP id y63so7297820itb.5
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 22:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1P+9FK0Vn5XkBSAoqrYU6n4THNdZK/CuQMNctNAv9gs=;
        b=sPzsD3BigxxmD7hRHfl3n22U+gXUn5ewQLc+sHXXKJxrYbfKHXnmvY6QoE5kj0YkdS
         u630VLTUzHDGxODXBshZFqdEgMzZNfb56LJQaUSzf7YeP3WGEH0MgJGYRjMCASdUPkZq
         vDwZ7aP9B5Y7B+7QlCRSaMHsS19hKdw+vCSSviHO+hObKdfsjm/Sk7QZi6ozGrRLmksG
         wSuP8qxAjXNsxzXqkia7wdgXFG/eipwNTa7grLWqhMdVY9aBXScKYC9GSMdhpm2LtkPZ
         baRAYY7hi5fzb3w8HYUQdZBC/C8ABV8Q2J40Oci7hYcwZAbrlkxrU/TXqWLd2ewXeF3h
         5/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1P+9FK0Vn5XkBSAoqrYU6n4THNdZK/CuQMNctNAv9gs=;
        b=mAETQ0YGfv9HY7f0LAL6U4j1n7K2kA2qOJsL2PM4+fEOmUdSq+AvLPu/ASPT8m7U7j
         k8H2Pc+skHJmdOupxxfMjAFgz0+3MUCddrJlndjKvxZwMPGnMnkp+zhwy8pPhqx/DQax
         N9yaCGLuk9ezwj9ocx57YtW7AVEJxntWV2DzT7c7OTRUqcbgV5LnIK1ZAXQ/xVTJv/Tu
         Ew/dIMN3TINDbbSC7j7I8gA1UVF0xEaCQ8u53+vMAsh1doM+aWdTdtmbDVJgfuQNx2ZE
         nXOEY9NqYjIiCpEcLnzQHZWQ8q2ZjfOhzmoqNi9cyty6C921/Rs/Sh5EjfHtHwCFKo1r
         199g==
X-Gm-Message-State: APjAAAUMNKY1+QPPo8gpzbzQXUH8+KQA7WJMw2NV5EnFQx0AT4uoL8iL
        rDGSyTWtJgiFi54YoNyTLD9RUb8pgheZFpxUfKtf1w==
X-Google-Smtp-Source: APXvYqz/Eo6csu1/24I9TOtYYDTHPNAl8X5y2yERXvBMjmtlcswHu2qF3xxrRKBdLtwBno/jaDopClJBOEUQz4StBBU=
X-Received: by 2002:a24:e4c6:: with SMTP id o189mr2274319ith.4.1553923934456;
 Fri, 29 Mar 2019 22:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190226122829.19178-1-avarab@gmail.com> <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190322232237.13293-3-matheus.bernardino@usp.br> <20190328221049.GK32487@hank.intra.tgummerer.com>
 <CAHd-oW78Cwhq8sFFjOX4c6kS8JsEUUd_RGgheJhdN6MLAr+G2Q@mail.gmail.com> <20190329200517.GO32487@hank.intra.tgummerer.com>
In-Reply-To: <20190329200517.GO32487@hank.intra.tgummerer.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 30 Mar 2019 02:32:03 -0300
Message-ID: <CAHd-oW5aTyr7OmYwETLHYbHbRYgcUPuHpt2eN=Z2FWrqUQTzJQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH v4 2/7] clone: better handle symlinked files at .git/objects/
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Kernel USP <kernel-usp@googlegroups.com>,
        Benoit Pierre <benoit.pierre@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 29, 2019 at 5:05 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> On 03/29, Matheus Tavares Bernardino wrote:
> > On Thu, Mar 28, 2019 at 7:10 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > > I notice that we are currently not using 'linkat()' anywhere else in
> > > our codebase.  It looks like it has been introduced in POSIX.1-2008,
> > > which sounds fairly recent by git's standards.  So I wonder if this is
> > > really supported on all platforms that git is being built on.
> > >
> > > I also wonder what would need to be done on Windows if we were to
> > > introduce this.  I see we define the 'link()' function in
> > > 'compat/mingw.c' for that currently, so I guess something similar
> > > would be needed for 'linkat()'.  I added Dscho to Cc for Windows
> > > expertise.
> >
> > Ok, what if instead of using linkat() we use 'realpath(const char
> > *path, char *resolved_path)', which will resolve any symlinks at
> > 'path' and store the canonical path at 'resolved_path'? Then, we can
> > still keep using link() but now, with the certainty that all platforms
> > will have a consistent behaviour? (also, realpath() is POSIX.1-2001)
> > Would that be a better idea?
>
> Yeah, I think that is a good idea.  Note that 'realpath()' itself is
> not used anywhere in our codebase either, but there is
> 'strbuf_realpath()', that from reading the function documentation does
> exactly what 'realpath()' would do.  So using 'strbuf_realpath()'
> would probably be the right thing to do here.

Thanks. While I was looking for realpath() at git codebase (before I
saw your email), I got a little confused: Besides strbuf_realpath() I
also found real_path(), real_path_if_valid() and real_pathdup(). All
these last three use strbuf_realpath() but they also initialize the
struct strbuf internally and just return a 'char *', which is much
convenient in some cases. What seems weird to me is that, whilst
real_pathdup() releases the internally initialized struct strubuf
(leaving just the returned string to be free'd by the user), the other
two don't. So, if struct strbuf change in the future to have more
dynamic allocated resources, these functions will also have to be
modified. Also, since real_pathdup() can already do what the other two
do, do you know if there is a reason to keep all of them?

One last question: I found some places which don't free the string
returned by, for example, real_path() (e.g., find_worktree() at
worktree.c). Would it be a valid/good patch (or patches) to add free()
calls in this places? (I'm currently trying to get more people here at
USP to contribute to git, and maybe this could be a nice first
contribution for them...)
