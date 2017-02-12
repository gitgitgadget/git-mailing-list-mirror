Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CEC61FC45
	for <e@80x24.org>; Sun, 12 Feb 2017 19:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751304AbdBLTaV (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 14:30:21 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33603 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbdBLTaU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 14:30:20 -0500
Received: by mail-wm0-f65.google.com with SMTP id v77so15568049wmv.0
        for <git@vger.kernel.org>; Sun, 12 Feb 2017 11:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lo52DfPHKJqGsPYnfptTY0ZTT8Gl7o4kj3t53NYH4Ng=;
        b=EHfX3IE/vFM/VGqO26i39kWu7zKoBcOMEGT86wB0WnSAcI8mPfkN2Rd0WjIuGWuI6o
         JexaVgEFa2PZkMYsKHi1b+RH+YhW5irdeVSYz6UbIPvmVD8/OFxv+vANKDh8mnb8isRb
         vBcmQrO9yjOdAJB7fbEGlwC54BTGK0kqz9Bzvv/fgZ9SEJVtsu8yHGGkKObBa6G4AEOH
         lEdVBV5U5anb8ZtZV177p13MspMewOqt3C9ydzN7mRfgbkoYtJGrgpR+TKsTUXHNDu1j
         bMHVJ6Xftw7zI6tD4Nv4H6vYEw+j5nvwiqH2NfsQs0EY9DeqMeSrmBeSM7q8kgJMQ6s+
         U/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lo52DfPHKJqGsPYnfptTY0ZTT8Gl7o4kj3t53NYH4Ng=;
        b=ohuEQmv9dQS+8uGCXvTUH9QFoxsVW+ev3y6Xbt2Yd3tA4yml2qsRQqs/XCfKdYuXCy
         jl8XsVlUH0xjGUfmmPQOaqz6OWIKIfqSfXQfxU0cQJEeG3c5W/Xl6NH+UpFz9ji4ZUhi
         JtBufC42sGEXZ5YH+M1GdBCRX5OB1LdVtVUqplyyOrM36FPc3xTpyTFTV2xWd2EqI4uX
         QwcA9HZN5FBWqkL/SUvegy/qHYlwWMYOe647rYHRC/gDGJytbDAZNLHJk5UYStVC+oH/
         KWiAIrs1nYrj2ACTa1KDXylZ7JBxbK0PztyMxL/dvIhE4jWKoRp13LFGuQtS2mBrVj/A
         hY4g==
X-Gm-Message-State: AMke39kU+x/1L2eGqH0zjLmRtwYzsDo9CGGG7yPJDLTBLsyht2Mt85kYK7GOg+iBwoul+w==
X-Received: by 10.28.210.65 with SMTP id j62mr15576695wmg.9.1486927818399;
        Sun, 12 Feb 2017 11:30:18 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id q4sm10974518wrc.35.2017.02.12.11.30.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Feb 2017 11:30:17 -0800 (PST)
Date:   Sun, 12 Feb 2017 19:30:50 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?=D8yvind_A_=2E?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH v3 0/5] stash: support pathspec argument
Message-ID: <20170212193050.GA652@hank>
References: <20170129201604.30445-1-t.gummerer@gmail.com>
 <20170205202642.14216-1-t.gummerer@gmail.com>
 <20170206161432.zvpsqegjspaa2l5l@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170206161432.zvpsqegjspaa2l5l@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[+cc Matthieu Moy as author of a patch mentioned below]

On 02/06, Jeff King wrote:
> On Sun, Feb 05, 2017 at 08:26:37PM +0000, Thomas Gummerer wrote:
> 
> > Thanks Junio for the review in the previous round.
> > 
> > Changes since v2:
> > 
> > - $IFS should now be supported by using "$@" everywhere instead of using
> >   a $files variable.
> > - Added a new patch showing the old behaviour of git stash create is
> >   preserved.
> > - Rephrased the documentation
> > - Simplified the option parsing in save_stash, by leaving the
> >   actual parsing to push_stash instead.
> 
> Overall, I like the direction this is heading. I raised a few issues,
> the most major of which is whether we want to allow the minor regression
> in "git stash create -m foo".
> 
> This also makes "git stash push -p <pathspec...>" work, which is good. I
> don't think "git stash -p <pathspec...>" does, though. I _think_ it
> would be trivial to do on top, since we already consider that case an
> error. That's somewhat outside the scope of your series, so I won't
> complain (too much :) ) if you don't dig into it, but it might just be
> trivial on top.

Hmm good idea, I think it would indeed be nice to add that.  Theres a
few things to consider though.  First, we need to switch git stash
without arguments over to use git stash push internally.  This does
introduce a slight regression as we currently allow git stash save --
-fmessage, (only messages starting with - are allowed).  I think that
regression would be acceptable however.

The other question is when we should allow the pathspec argument.
3c2eb80f, ("stash: simplify defaulting to "save" and reject unknown
options") made sure that all option arguments are treated the same.  I
think we could use the usual disambiguation of -- to allow pathspecs
after that, so stash -p wouldn't be treated specially, otherwise the
rules could get a bit confusing again.

The other question is how we would deal with the -m flag for
specifying a stash message.  I think we could special case it, but
that would allow users to do things such as git stash -m apply, which
would make the interface a bit more error prone.  So I'm leaning
towards disallowing that for now.

> A few other random bits I noticed while playing with the new code:
> 
>   $ git init
>   $ echo content >file && git add file && git commit -m file
>   $ echo change >file
> 
>   $ git stash push -p not-file
>   No changes.
>   No changes selected
> 
> Probably only one of those is necessary. :)
> 
> Let's keep trying a few things:
> 
>   $ git stash push not-file
>   Saved working directory and index state WIP on master: 5d5f951 file
>   Unstaged changes after reset:
>   M	file
>   M	file
> 
> The unstaged change is mentioned twice, which is weird. But weirder
> still is that we created a stash at all, as it's empty. Why didn't we
> hit the "no changes selected" path?
> 
> And one more:
> 
>   $ echo foo >untracked
>   $ git stash push untracked
>   Saved working directory and index state WIP on master: 5d5f951 file
>   Unstaged changes after reset:
>   M	file
>   M	file
>   Removing untracked
> 
> We removed the untracked file, even though it wasn't actually stashed! I
> thought at first this was because it was mentioned as a pathspec, but it
> seems to happen even with a different name:
> 
>   $ echo foo >untracked
>   $ git stash push does-not-exist
>   ...
>   Removing untracked
> 
> That seems dangerous.

Ouch, yeah this is clearly not good.  I'll fix this, and add tests for
these cases.

> -Peff
