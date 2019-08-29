Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2A921F461
	for <e@80x24.org>; Thu, 29 Aug 2019 16:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfH2QoQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 12:44:16 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38279 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbfH2QoP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 12:44:15 -0400
Received: by mail-vs1-f67.google.com with SMTP id 62so2860671vsl.5
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 09:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=li2BTYLF3gPUffuIy3mrtDnWfyL/oCqbXqVF8/HifvU=;
        b=nE8Z4GZ+HDGjLvZU0MJcdaU1WOhTZ2GLch4XJxERa5MkqA/r8YFgqDryVn8swQEQoL
         hdcAGU80Qe5gunaq2MFgw516od1n+cZzPU2GP2NPyMSN99kbxFGabNH81Zjj4QNIDedM
         fqLgrWKqFkqChwUzHJezIBqSMlKLHicXuDyqCNNNx2wJ9j641Q/q/RLnxGVT71B8yPB5
         gHMyZB8jakiPTUfu7YB2dKTS3w61Q0NtpjTZOGXw6c2vQjPCSnbfFJ+ZZ4YRl3SnWe6P
         XSakPnu+FLuQ6k6kUqCBNOj5Tz3LmKIgiiPoaN/O3sQmckU306tDwgCDZg8TjvOcITTv
         bG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=li2BTYLF3gPUffuIy3mrtDnWfyL/oCqbXqVF8/HifvU=;
        b=TuIL31i9/rn3MASFofnwe5urIYG1PXrdgK+2/kM9ymASqwvf2TUpBntNNxMEMGmJzc
         WBGKPaJ6yS5wKaA6bCf9FVieaHpwG0750cxS0EsDdmVyk2ebCrCqDOZZgIndJUOhBwnd
         y0ckxsnbKik5uEKfnetJt7yNi59l+9G/nUlqpmDIy2QFWYYbBtf4djisRYEQobGGevpa
         EWcktR+wZPqLqMlZBS9/Tr7D74W7PBm0NoylX0a8kHUk4S2M7RyjBY2Ujn0bo8Kch4Xj
         HHV3BksF5HxENRsaSrx+k/20/LMr9keS78Uke3Kj0xrcJEFT0BjolUyvsyrqgI1PAwZu
         DzeQ==
X-Gm-Message-State: APjAAAUG7MKwMPmdGKivFmgrQW6Z1GT7mlLjJkp8UioRycQ+bv6Q/pyo
        Shwm8S6hCoWMIo4prgT/YfJ/TEGcYD0svU+yGoGb4Q==
X-Google-Smtp-Source: APXvYqz0fUU8qeLiop3FVQy0GOu6TEg1KR7jft9g9mcyBQxTJEffarKGGAdfi78ZsmNnrM3TjJYVVZmbRhGQXoq34YY=
X-Received: by 2002:a67:62c5:: with SMTP id w188mr6271193vsb.25.1567097054206;
 Thu, 29 Aug 2019 09:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566863604.git.matheus.bernardino@usp.br>
 <4920d3c474375abb39ed163c5ed6138a5e5dccc6.1566863604.git.matheus.bernardino@usp.br>
 <CACsJy8Dry7MfKBi5EKw4Ka9r63QVmDjPv9nAozS0mC6Z7-sG=w@mail.gmail.com>
 <CAHd-oW4h80xrp6y65dqZbq_a67ncArC9rrNq7F7rAhBbrALOkA@mail.gmail.com>
 <CAHd-oW6doh=06nxUkMLWZOwNMyUOogLRbLstD0bJVQxLauR_Aw@mail.gmail.com>
 <CACsJy8DpTxpejkOHCYPnt3saC-h-3Ez0TthAPnPvHHThaG64bQ@mail.gmail.com> <20190829140013.GC1797@sigill.intra.peff.net>
In-Reply-To: <20190829140013.GC1797@sigill.intra.peff.net>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 29 Aug 2019 13:44:03 -0300
Message-ID: <CAHd-oW6JdTSWHy6UwGhL5PUoiscayh9xVqs5ktsXzotg_vexmQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] config: allow config_with_options() to handle any repo
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 29, 2019 at 11:00 AM Jeff King <peff@peff.net> wrote:
>
> On Thu, Aug 29, 2019 at 04:31:34PM +0700, Duy Nguyen wrote:
>
> > > If so, how could we get R there? I mean, we could pass it through this
> > > chain, but the chain already passes a "struct config_options", which
> > > carries the "commondir" and "git_dir" fields. So it would probably be
> > > confusing to have them and an extra repository parameter (which also
> > > has "commondir" and "git_dir"), right? Any ideas on how to better
> > > approach this?
> >
> > I would change 'struct config_options' to carry 'struct repository'
> > which also contains git_dir and other info inside. Though I have no
> > idea how big that change would be (didn't check the code). Config code
> > relies on plenty callbacks without "void *cb_data" so relying on
> > global state is the only way in some cases.
>
> I'm not sure about that, at least for this particular git_pathdup(). We
> pass along the git_dir because we might not have a repository struct yet
> (i.e., when reading config before repo discovery has happened).

Yes, I think read_early_config(), for example, may call
config_with_options() before the_repo is initialized.

> So it might be that this case should actually be making a path out of
> $git_dir/config.worktree (but I'm not 100% sure, as I don't know the ins
> and outs of worktree config files).

Makes sense, config.worktree files are per-worktree, which have
different git_dir's, right?

> I'm sure there are other gotchas in the config code, though, related to
> things for which we _do_ need a repository. E.g., include_by_branch()
> looks at the_repository, and should use a repository struct matching the
> git_dir we're looking at (though it may be acceptable to bail during
> early pre-repo-initialization config and just disallow branch includes,
> which is what happens now).

I think config_with_options() is another example of a place where we
should have a reference to a repo (but we currently don't). When
configuring from a given blob, it will call
git_config_from_blob_ref(), which calls get_oid() and
read_object_file(). Both of these functions will use the_repo by
default. But the git_dir and commondir fields passed to
config_with_options() through 'struct config_options' may not refer to
the_repo, right?

I'm not sure what is the best solution to this, though. I mean, we
could add a 'struct repository' in 'struct config_options', but as you
already pointed out, some callers might not have a repository struct
yet...

> -Peff
