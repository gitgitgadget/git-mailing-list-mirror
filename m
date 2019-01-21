Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AACA31F453
	for <e@80x24.org>; Mon, 21 Jan 2019 10:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfAUKGY (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 05:06:24 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53683 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbfAUKGX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 05:06:23 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so15680870ita.3
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 02:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lS1vbWpE+umFE6pR5pFxvEMDscSNGl2gAPpj+kqKC/o=;
        b=Qz7pE0Z1dn0UM0gSA/1CFghR6wvtu2NpM9eQJywV6A+Lxl2BPwEdbNGIctAopI0+RW
         i3XdZJht479msT+NMH21SM4Y/6hCqmGQ9jlfBVsj2iq6Vp3F7Yo3sygQSgvoEWnnhZfV
         5elR5gUNZjMoCmPC2USX5v2Qx9JbAK3v5Q9dH5egOoj/Jjb9izwWlSBNrLTjAotqaFfZ
         NdsbseJXp8vl00yUMjBdqlEmQAfDL7HWodwnSt/odPaZWoGwCuMV1b1J2N+ObQkIhqMw
         JzXwHIYG/7wBGXwAXxcxkRzF9LI4E8Ci+E7fsE3/JGnERB0NjQsb/Z3d8auiTHnZOI63
         hAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lS1vbWpE+umFE6pR5pFxvEMDscSNGl2gAPpj+kqKC/o=;
        b=Gdvdhlf+nOD52jMKF51gRnt5CLkCHYXV/r0xUoFoPHOywzTNybQoNtfjxQdrkjdcwS
         ti2OLXgvoW5fWqmpigt3pMpwELldv9vdKvHfm7fcXK+w+EIbC7oMwo2HQ1HiaMerClLT
         aK5QGeSHsLXSJHMUSj3fofhHQvf/a12yhhYBe6D1XFqYb6uQ3UIwji8Fck15e+9BF0O6
         43LZMsItuJOtdd32R53FaYEweKKBK9dGAL4adt5+hauGD7RgZlXb7sNLPrzzLpzVRQme
         yzHWSUhtBMrt0Hf7mUDhQyN8wtqYklzUX4jVUa+QU+rvehgZ2Z6TN88v1yIld+z05Pby
         HWog==
X-Gm-Message-State: AJcUukeLZqzeWJa6D9Jgg/GkQJGljrxioJtSRQWTe/tQHuMnYPCDt/Cf
        xhoeVZMuCuwsgG/mxBYNtJGNXPS99MGWfKQZrgs=
X-Google-Smtp-Source: ALg8bN5d+swNvw7LxyEb/LrRaJ5k+knWtFWx98IFkIOPS3a583gwVzkhVfpjgSrk1hy0I3UI/u6tiuOcH9H1mibmqA4=
X-Received: by 2002:a02:183:: with SMTP id 3mr17378272jak.130.1548065182706;
 Mon, 21 Jan 2019 02:06:22 -0800 (PST)
MIME-Version: 1.0
References: <CAK3b1G+88a=xfO=6wfRi1SMy3xtca2NcFyxuBLKwSifb_L9xwA@mail.gmail.com>
 <20190117160752.GA29375@sigill.intra.peff.net> <CAK3b1GJPZ5X3uEP1a-NF9PZkE0tTKVLda5hM32jExVz_OD2E=g@mail.gmail.com>
 <20190118165800.GA9956@sigill.intra.peff.net> <20190118213458.GB28808@sigill.intra.peff.net>
In-Reply-To: <20190118213458.GB28808@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 21 Jan 2019 17:05:56 +0700
Message-ID: <CACsJy8DFX2P6nF200YV_3VjXiags0W28awbSAwc9ztfEZPbJ4g@mail.gmail.com>
Subject: Re: [PATCH] attr: do not mark queried macros as unset
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?S=C3=A9rgio_Peixoto?= <sergio.peixoto@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 19, 2019 at 4:35 AM Jeff King <peff@peff.net> wrote:
>
> On Fri, Jan 18, 2019 at 11:58:01AM -0500, Jeff King wrote:
>
> > Now, on to the actual bug. The simplest reproduction is:
> >
> >   (echo "[attr]foo bar"; echo "* foo") >.gitattributes
> >   git check-attr foo file
>
> Actually, even simpler is to just "binary", which is pre-defined as a
> macro. :)
>
> > which should report "foo" as set. This bisects to 60a12722ac (attr:
> > remove maybe-real, maybe-macro from git_attr, 2017-01-27), and it seems
> > like an unintentional regression there. I haven't yet poked into that
> > commit to see what the fix will look like.
>
> So here's the fix I came up with. +cc Duy, as this is really tangled
> with his older 06a604e670.
>
> -- >8 --
> Subject: [PATCH] attr: do not mark queried macros as unset
>
> Since 60a12722ac (attr: remove maybe-real, maybe-macro from git_attr,
> 2017-01-27), we will always mark an attribute macro (e.g., "binary")
> that is specifically queried for as "unspecified", even though listing
> _all_ attributes would display it at set. E.g.:
>
>   $ echo "* binary" >.gitattributes
>
>   $ git check-attr -a file
>   file: binary: set
>   file: diff: unset
>   file: merge: unset
>   file: text: unset
>
>   $ git check-attr binary file
>   file: binary: unspecified
>
> The problem stems from an incorrect conversion of the optimization from
> 06a604e670 (attr: avoid heavy work when we know the specified attr is
> not defined, 2014-12-28). There we tried in collect_some_attrs() to
> avoid even looking at the attr_stack when the user has asked for "foo"
> and we know that "foo" did not ever appear in any .gitattributes file.
>
> It used a flag "maybe_real" in each attribute struct, where "real" meant
> that the attribute appeared in an actual file (we have to make this
> distinction because we also create an attribute struct for any names
> that are being queried). But as explained in that commit message, the
> meaning of "real" was tangled with some special cases around macros.
>
> When 06a604e670 later refactored the macro code, it dropped maybe_real
> entirely. This missed the fact that "maybe_real" could be unset for two
> reasons: because of a macro, or because it was never found during
> parsing. This had two results:
>
>   - the optimization in collect_some_attrs() ceased doing anything
>     meaningful, since it no longer kept track of "was it found during
>     parsing"
>
>   - worse, it actually kicked in when the caller _did_ ask about a macro
>     by name, causing us to mark it as unspecified
>
> It should be possible to salvage this optimization, but let's start with
> just removing the remnants. It hasn't been doing anything (except
> creating bugs) since 60a12722ac, and nobody seems to have noticed the
> performance regression. It's more important to fix the correctness
> problem clearly first.

But muh optimization!!! You're right of course, correctness comes
first. I did try to look at this code but it's been a while and I'm
afraid I don't have anything valuable to say. I'll dig in more in the
next couple days.
-- 
Duy
