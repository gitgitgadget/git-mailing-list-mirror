Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AF572036B
	for <e@80x24.org>; Tue, 10 Oct 2017 18:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932520AbdJJSj2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 14:39:28 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:44065 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932499AbdJJSjX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 14:39:23 -0400
Received: by mail-qt0-f181.google.com with SMTP id 8so8453845qtv.1
        for <git@vger.kernel.org>; Tue, 10 Oct 2017 11:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=phD/rzoFosUqIx8oBQ/JyE9cxU5IVE0jz3nRcCVv/Fc=;
        b=RsD0cMw6/2QOce5Zy8lWMK/U0QO8V0Qr1/4FLqGLetbYa6D0didAyJOciV4o1k7E+N
         a2gJ/4Z3y/jZG1pQClbtcBUSLaaGvHVyyAbXWVAePAVtnPk7EzWFBZagMYrs2fWflxkZ
         gzVqjfRbOnACqCA+O0luiTVmV8mHUPN6SE4taEg08VJBodeXjio+nbxNOqjSU7YX+12T
         CQU4U1yUs7ch3hbJN5S5mabuuhtTU94/5d22LliaJRvL00dNi6EXPYniCg4CRgKNS6rW
         bRuiW3I4zaGF3bRc3R1mvJFTzOQmHu9sOhuXr1q0yUQ16kROrQY4lPZxG0S4CDLFIWtG
         GtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=phD/rzoFosUqIx8oBQ/JyE9cxU5IVE0jz3nRcCVv/Fc=;
        b=EyaAxiDaKWdsuke5nW/UEpElV9nxrwNsWNjcVMnwlGzmtzYVr3ebNql402Z94XXK/U
         fd2NCHxGZQCAi7uJoSnc3Fnv6WxFknKv2/EVRgvkxHtPwOg8wKjnoyNCyV/e1yLtYdne
         TB51uQTx22uG0jutblnQGqzBBa9mj3eF8OsdvsnFsQXM8XxuV4P6FFletAd5i9pDD8NG
         XmhAFS0hhlAXZwSQPO/4zUxptX8K79Vjnl4iU64RspyvwuXrCONdVp5fPEM4CfR8da8R
         4ZeK4rntdlNgM7v8JWueqGxPChLDtQinEJfLeBn4lDO0l5WOti7bsFLs1NLfzjkpKmRh
         dZOA==
X-Gm-Message-State: AMCzsaXgBPqbwsL/wngkbXFRng5n4KxQIC2US33sc/umfLI0Vt6ff3O7
        B0Tx5mf79DZEKoLsWfPzaZCsXyl9cxw3a/hM8PksPp/5ngk=
X-Google-Smtp-Source: AOwi7QCAW/mLEw33xHYhdNlGdWCtkLDYeutKCGU97F6gwAWKTK1qjaiwsxTbgU8SvFI6bkQXzklgVjnKwCsoUZsZ9zE=
X-Received: by 10.200.36.175 with SMTP id s44mr21246732qts.298.1507660762083;
 Tue, 10 Oct 2017 11:39:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Tue, 10 Oct 2017 11:39:21 -0700 (PDT)
In-Reply-To: <20171010130335.GB75189@book.hvoigt.net>
References: <20171006222544.GA26642@sandbox> <20171006223234.GC26642@sandbox>
 <CAGZ79kZqaC-hFAa3dc7_j8Ah94Ua0+sAjcDUYBL0N-C_J4Bx4A@mail.gmail.com> <20171010130335.GB75189@book.hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 10 Oct 2017 11:39:21 -0700
Message-ID: <CAGZ79kZFtMxD8wf59SViOOc_mrhwTVr6v0ucAePp+-8hg_im-Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] change submodule push test to use proper
 repository setup
To:     Heiko Voigt <hvoigt@hvoigt.net>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2017 at 6:03 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:

>> > As mentioned in the cover letter. This seems to be the only test that
>> > ensures that we stay compatible with setups without .gitmodules. Maybe
>> > we should add/revive some?
>>
>> An interesting discussion covering this topic is found at
>> https://public-inbox.org/git/20170606035650.oykbz2uc4xkr3cr2@sigill.intra.peff.net/
>
> Thanks for that pointer. So in that discussion Junio said that the
> recursive operations should succeed if we have everything necessary at
> hand. I kind of agree because why should we limit usage when not
> necessary. On the other hand we want git to be easy to use. And that
> example from Peff is perfect as a demonstration of a incosistency we
> currently have:
>
> git clone git://some.where.git/submodule.git
> git add submodule
>
> is an operation I remember, I did, when first getting in contact with
> submodules (many years back), since that is one intuitive way. And the
> thing is: It works, kind of... Only later I discovered that one actually
> needs to us a special submodule command to get everything approriately
> setup to work together with others.

I agree that we ought to not block off users "because we can", but rather
perform the operation if possible with the data at hand.

Note that the result of the discussion `jk/warn-add-gitlink actually`
warns about adding a raw gitlink now, such that we hint at using
"git submodule add", directly.

So you propose to make git-add behave like "git submodule add"
(i.e. also add the .gitmodules entry for name/path/URL), which I
like from a submodule perspective.

However other users of gitlinks might be confused[1], which is why
I refrained from "making every gitlink into a submodule". Specifically
the more powerful a submodule operation is (the more fluff adds),
the harder it should be for people to mis-use it.

[1] https://github.com/git-series/git-series/blob/master/INTERNALS.md
     "git-series uses gitlinks to store pointer to commits in its own repo."

> If everyone agrees that submodules are the default way of handling
> repositories insided repositories, IMO, 'git add' should also alter
> .gitmodules by default. We could provide a switch to avoid doing that.

I wonder if that switch should be default-on (i.e. not treat a gitlink as
a submodule initially, behavior as-is, and then eventually we will
die() on unconfigured repos, expecting the user to make the decision)

> An intermediate solution would be to warn

That is already implemented by Peff.

> but in the long run my goal
> for submodules is and always was: Make them behave as close to files as
> possible. And why should a 'git add submodule' not magically do
> everything it can to make submodules just work? I can look into a patch
> for that if people agree here...

I'd love to see this implemented. I cc'd Josh (the author of git-series), who
may disagree with this, or has some good input how to go forward without
breaking git-series.

> Regarding handling of gitlinks with or without .gitmodules:
>
> Currently we are actually in some intermediate state:
>
>  * If there is no .gitmodules file: No submodule processing on any
>    gitlinks (AFAIK)

AFAIK this is true.

>  * If there is a .gitmodules files with some submodule configured: Do
>    recursive fetch and push as far as possible on gitlinks.

* If submodule.recurse is set, then we also treat submodules like files
  for checkout, reset, read-tree.

> So I am not sure whether there are actually many users (knowingly)
> using a mix of some submodules configured and some not and then relying
> on the submodule infrastructure.
>
> I would rather expect two sorts of users:
>
>   1. Those that do use .gitmodules

Those want to reap all benefits of good submodules.

>
>   2. Those that do *not* use .gitmodules

As said above, we don't know if those users are
"holding submodules wrong" or are using gitlinks for
magic tricks (unrelated to submodules).

>
> Users that do not use any .gitmodules file will currently (AFAIK) not
> get any submodule handling. So the question is are there really many
> "mixed users"? My guess would be no.

I hope that there are few (if any) users of these mixed setups.

> Because without those using this mixed we could switch to saying: "You
> need to have a .gitmodules file for submodule handling" without much
> fallout from breaking users use cases.

That seems reasonable to me, actually.

> Maybe we can test this out somehow? My patch series would be ready in
> that case, just had to drop the first patch and adjust the commit
> message of this one.

I wonder how we would test this, though? Do you have any idea
(even vague) how we'd accomplish such a measurement?
I fear we'll have to go this way blindly.

Cheers,
Stefan

>
> Cheers Heiko
