Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F33231F404
	for <e@80x24.org>; Tue, 14 Aug 2018 22:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbeHOBXt (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 21:23:49 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34262 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbeHOBXt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 21:23:49 -0400
Received: by mail-yw1-f66.google.com with SMTP id j68-v6so17487353ywg.1
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 15:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tJw9h3xSZOViRhKFipUvJxBbU1oYKnwzEjEF4f1+e9g=;
        b=lw6FKeADwuKFjTtjHK7kwj8x6CmdyfSSFLbzD1oXFxMLHrUUVVFXVJMu3KEyFOFWna
         Z4sguqLF1NYl18LsDGIwVkkd6NsPpUdOWnl9DfuW0U9tRsuUnYnWCTY/o5GzH603Aknh
         w58j2tsYAqH+eOWMYmE1Vdt7A/Wy8IiK87r1kPqxybYRVV0H61Gdft0X9IC0T5JgpUWs
         sL2dJSc+E+shMRj9T8Y73OyqIbgdfTgI6BozZZNxXBOeuKWEdywmBprv1cEbe2E7uSR0
         lt+fAeqiaBCu2BkfbzXArvWOHvrA3u4pT7WR/fSGrY7xiGsr3fZr4yOHT/be5o+SlEPS
         cw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tJw9h3xSZOViRhKFipUvJxBbU1oYKnwzEjEF4f1+e9g=;
        b=SxQGC2nKWJ9MvqhIeSpO4o4t/gqtver++iXZe3IOtUiJiKVy1hGaphujF64gr3mQnk
         Mpobp1WepUZ8F9HaICOFeOe+9wyX1a+aUfw9VwR5KKz698HzyugBjiATF+k+FJ/yB+8S
         tgbdu68HoWyWI0DdcJ4NsIddVxJj/MMyyXDmOI84Jo0JVeTW7F/eKUUr0Xo6oSg4GXak
         kYvcsAWMNH8XrZV8bBR//RtMffrQGqAw+twS12gKA5jY9XyUKApgSK4G4bJwukqzPF8u
         47fiZiDRkEkvWIZFX5dhasPshxbx1o1oSjXVhHX9XKhgtK/pnLGD3I7GvreULT0I1SqX
         Dw9w==
X-Gm-Message-State: AOUpUlEP4TDqEHvkACAjWM6dHMNlgiequYvDGlz7XzWgTiX/Rcuw9jOB
        kBgSsD9k0hEwhMLO/+jMGKNMMAEGp6bmJYI1eJsukg==
X-Google-Smtp-Source: AA+uWPw7qDsYnjKytm01RcQZBBVFuaGvCWRRs0G1LLpiZnvQYpOU4LFm+cNi9dRCiuIy3WFkzalVAzSnDeL+TxD3UcI=
X-Received: by 2002:a25:cc03:: with SMTP id l3-v6mr12602570ybf.334.1534286069991;
 Tue, 14 Aug 2018 15:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180807230637.247200-1-bmwill@google.com> <20180808223323.79989-1-bmwill@google.com>
 <20180808223323.79989-3-bmwill@google.com> <20180809212602.GA11342@sigill.intra.peff.net>
 <20180814180406.GA86804@google.com> <20180814185743.GE142615@aiede.svl.corp.google.com>
 <CAGZ79kZUq5jPqyb=B1ppEi1QhNGmhLXeV6vPn8ouR=YGEN32pg@mail.gmail.com> <20180814211211.GF142615@aiede.svl.corp.google.com>
In-Reply-To: <20180814211211.GF142615@aiede.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Aug 2018 15:34:18 -0700
Message-ID: <CAGZ79kYfoK9hfXM2-VMAZLPpqBOFQYKtyYuYJb8twzz6Oz5ymQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] submodule: munge paths to submodule git directories
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, Jeff King <peff@peff.net>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 2:12 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi,
>
> Stefan Beller wrote:
> > On Tue, Aug 14, 2018 at 11:57 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> >> Second, what if we store the pathname in config?  We already store the
> >> URL there:
> >>
> >>         [submodule "plugins/hooks"]
> >>                 url = https://gerrit.googlesource.com/plugins/hooks
> >>
> >> So we could (as a followup patch) do something like
> >>
> >>         [submodule "plugins/hooks"]
> >>                 url = https://gerrit.googlesource.com/plugins/hooks
> >>                 gitdirname = plugins%2fhooks
> >>
> >> and use that for lookups instead of regenerating the directory name.
> >> What do you think?
> >
> > As I just looked at worktree code, this sounds intriguing for the wrong
> > reason (again), as a user may want to point the gitdirname to a repository
> > that they have already on disk outside the actual superproject. They
> > would be reinventing worktrees in the submodule space. ;-)
> >
> > This would open up the security hole that we just had, again.
> > So we'd have to make sure that the gitdirname (instead of the
> > now meaningless subsection name) is proof to ../ attacks.
> >
> > I feel uneasy about this as then the user might come in
> > and move submodules and repoint the gitdirname...
> > to a not url encoded path. Exposing this knob just
> > asks for trouble, no?
>
> What if we forbid directory separator characters in the gitdirname?

Fine with me, but ideally we'd want to allow sharding the
submodules. When you have 1000 submodules
we'd want them not all inside the toplevel "modules/" ?
Up to now we could just wave hands and claim the user
(who is clearly experienced with submodules as they
use so many of them) would shard it properly.

With this scheme we loose the ability to shard.

> [...]
> > What would happen if gitdirname is changed as part of
> > history? (The same problem we have now with changing
> > the subsection name)
>
> In this proposal, it would only be read from config, not from
> .gitmodules.

Ah good point. That makes sense.

Stepping back a bit regarding the config:
When I clone gerrit (or any repo using submodules)

$ git clone --recurse-submodules \
  https://gerrit.googlesource.com/gerrit g2
[...]
$ cat g2/.git/config
[submodule]
    active = .
[submodule "plugins/codemirror-editor"]
    url = https://gerrit.googlesource.com/plugins/codemirror-editor
[... more urls to follow...]

Originally we have had the url in the config, (a) that we can change
the URLs after the "git submodule init" and "git submodule update"
step that actually clones the submodule if not present and much more
importantly (b) to know which submodule "was initialized/active".

Now that we have the submodule.active or even
submodule.<name>.active flags, we do not need (b) any more.
So the URL turns into a useless piece of cruft that just is unneeded
and might confuse the user.

So maybe I'd want to propose a patch that removes
submodule.<name>.url from the config once it is cloned.
(I just read up on "submodule sync" again, but that might not
even need special care for this new world)

And with all that said, I think if we can avoid having the submodules
gitdir in the config, the config would look much cleaner, too.

But maybe that is the wrong thing to optimize for. ;-)
It just demonstrates that we'd have a submodule specific
thing again in the config.

So my preference would be to do a similar thing as
url-encoding as that solves the issue of slashes and
potentially of case sensitivity (e.g. encode upper case A
as lower case with underscore _a)

However the transition worries me, as it transitions
within the same namespace. Back then when we
transferred from the .git dir inside the submodules
working tree to the embedded version in the superprojects
.git dir, there was no overlap, and any potential directory
in .git/modules/ that was already there, was highly
unusual, so asking the user for help is the reasonable
thing to do.
But now we might run into issues that has overlap between
old(name as is) and new (urlencoded) world.

So maybe we also want to transition from

    modules/<name>

to

    submodules/<urlencoded(<name>)>

Thanks,
Stefan
