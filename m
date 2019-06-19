Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 056F41F462
	for <e@80x24.org>; Wed, 19 Jun 2019 15:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfFSPw4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 11:52:56 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:53872 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFSPw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 11:52:56 -0400
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x5JFqk6e000362
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 00:52:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x5JFqk6e000362
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1560959567;
        bh=dHcJ+xcCxjinKk/kstPSN8zmJx1+fzyd/ZrN5zb0O/Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C8OYxBKY5iIWBiuW0QsqRxlbMcwtY7KI24GJFQJvZIrdxOuhjpSrKy1MAIWzCGz0V
         BVUXnA77DtQV30GNP+H3G8l8lqrLEBz4PYnqrsxNkz3muIjBcbUZ0y9EqvqAWlCD+d
         XX/LBO/G40vuVoTGKn6kJTr2EmyorRL1WJm65hZgSZpVqfY8ydE1qZL5jmCUrVMcQY
         N08Ak5dQyypIUnYFJJh8Z4OaAEz36jn+NvzKSGg4993C3tS44KFSPKoSJEgrkjMjWP
         EzlAs2FpTakQLfVDA3/61NBiNL5trhDkIU0Nm4rWZxzDlljxbk3K9y/TV2w59PHgEY
         Ok7KswaWo7k4g==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id z13so10354040uaa.4
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 08:52:46 -0700 (PDT)
X-Gm-Message-State: APjAAAX0yyFn/L7BeTYnIStnQIk7GVF/ZXm+wzaij2rKxDyUaE5QTLMc
        Sx9g9i9NR69O5Mx2FBlCTfoZ1NNkYqPbzruEohg=
X-Google-Smtp-Source: APXvYqzNsYeyZ4bbHrYmfihY9CvgZ/K7JMHoALqkkX46nWzMqmGqeWapuDT73MM+4qWwutWthk84qbbkB4vfiMj68Kw=
X-Received: by 2002:a67:cd1a:: with SMTP id u26mr28349372vsl.155.1560959565530;
 Wed, 19 Jun 2019 08:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAR=KhTZRFFXTbcZwe-+65fGnVB7NbmVbQ7ymbmChDuhAg@mail.gmail.com>
 <20190614150758.GA22984@sigill.intra.peff.net> <CAP8UFD2dhGqOxXJMTZhNSM5G4sp6PvKF+0R5KVk6YjAQi3Sccw@mail.gmail.com>
 <20190619033728.GA29027@sigill.intra.peff.net>
In-Reply-To: <20190619033728.GA29027@sigill.intra.peff.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 20 Jun 2019 00:52:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQW9ObWv5WiiRk9dxrxoQgU=LoEP9FrTzmOTO5XF89aVA@mail.gmail.com>
Message-ID: <CAK7LNAQW9ObWv5WiiRk9dxrxoQgU=LoEP9FrTzmOTO5XF89aVA@mail.gmail.com>
Subject: Re: [PATCH] interpret-trailers: load default config
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 19, 2019 at 12:37 PM Jeff King <peff@peff.net> wrote:
>
> On Sat, Jun 15, 2019 at 10:41:44AM +0200, Christian Couder wrote:
>
> > On Fri, Jun 14, 2019 at 5:10 PM Jeff King <peff@peff.net> wrote:
> > >
> > > On Fri, Jun 14, 2019 at 08:35:04PM +0900, Masahiro Yamada wrote:
> > >
> > > > Perhaps, 'git interpret-trailers' should be changed
> > > > to recognize core.commentChar ?
> > >
> > > It looks like the trailer code does respect it, but the
> > > interpret-trailers program never loads the config. Does the patch below
> > > make your problem go away?
> >
> > It seems to me to be the right analysis and the right fix too.
>
> Thanks. Here it is (below) with a commit message and a test. I tried to
> build on the existing comment test, but the resulting diff is hard to
> read due to the indent change; try it with "-w".
>
> > > I do wonder if the trailer code is correct to always respect it, though.
> > > For example, in "git log" output we'd expect to see commit messages from
> > > people with all sorts of config. I suppose the point is that their
> > > comment characters wouldn't make it into the commit object at all, so
> > > the right answer there is probably not to look for comment characters at
> > > all.
> >
> > Would you suggest an option, maybe called `--ignore-comments` to ignore them?
>
> Yeah, though I think most callers of interpret-trailers would probably
> want the existing behavior. I'd be more concerned about the internal
> callers to the trailer code, like "git log --format=%(trailers)". I
> doubt it's that big a deal in practice, though. As I said above, the
> idea is that comments would be removed before making it into commit
> objects anyway. So we shouldn't be seeing comments, and so the code to
> recognize them is not likely to trigger (and I think it would be
> reasonably hard to trigger a false positive accidentally).
>
> If you or somebody else wants to dig into it, be my guest, but I don't
> think I'd prioritize it.
>
> -- >8 --
> Subject: [PATCH] interpret-trailers: load default config
>
> The interpret-trailers program does not do the usual loading of config
> via git_default_config(), and thus does not respect many of the usual
> options. In particular, we will not load core.commentChar, even though
> the underlying trailer code tries to do so.
>
> This can be seen in the accompanying test, where setting
> core.commentChar to anything besides "#" results in a failure to treat
> the comments correctly.
>
> Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Jeff King <peff@peff.net>

Tested-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks.

-- 
Best Regards
Masahiro Yamada
