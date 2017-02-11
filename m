Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FB211FAF4
	for <e@80x24.org>; Sat, 11 Feb 2017 14:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750761AbdBKOu5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Feb 2017 09:50:57 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34546 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbdBKOu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2017 09:50:56 -0500
Received: by mail-wm0-f67.google.com with SMTP id c85so11108157wmi.1
        for <git@vger.kernel.org>; Sat, 11 Feb 2017 06:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SnOxU8nTOzcTGfWdJxOamtcBmFKPzQtF++91B6IUhVM=;
        b=Od+6r8kMabOvbOPrUovYSVkACxjVmZ7iWqAxVq4SYiZz4D4jKqo4/iQCzppMNoOsPx
         /uHP7gwunorN0xQwauS/G8JNANrevs3+6HwDB9vaAgop80oXJyM0gpgGwQbRrZL5UeOF
         IOUmAVjlReLHr2Y6gNRvkz7OrwLgR8kUEIBoxWOHp7wyvBF/r0wpohTLXq0SEY3DCnYx
         jCvzWLpeioWo/9Er93fvleEuznmsHj6q0pMq6SUZbNKh62cmCC5tuMOw6aEOG8ZDeNBu
         eaTKps93DATyNycIRFtiEVad01M3igO3FGeQ4DD/HwMQN1r4DDEpUlYlzo8c7e5LtVFt
         ucNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SnOxU8nTOzcTGfWdJxOamtcBmFKPzQtF++91B6IUhVM=;
        b=GxBLXbqmKqQ15uJHFEu9E00acpFSFWk8hd6Np1Ot7mOuJxMtFZFVywRGbKYCHupZOF
         iG1W/N4pPvZ2K3ghjiz58cej0wXBb3VBUcMQP3495bXUXiA5xO9r+duPd25Hb4FsmyZ0
         40r/GhH6Mv3Uy85AMgVKvN3EQfjhFDNeoAJFykMBe+E10OxkFoTWEQKGu7NvlXq9s0EN
         OeNFyUHmRQ+1WUpFnmDN2Po5diuWFonBRu+w3EEvax9yExrRX31aAxWw8c+hoAJqbu4Z
         XcuIyoih8ulSrUb8L6ZNB6RMS2Zs3hvf38wgY+DRMbBzvlAEVtNPYydYnhi8auHWTsBH
         UrEA==
X-Gm-Message-State: AMke39mblb2Av6jZ+KJ6QlMG42Y58LVYGrmU9NaQIsIB48nj3TFxUHwpjlfvUcLfqm4g8Q==
X-Received: by 10.28.37.195 with SMTP id l186mr29830904wml.73.1486824654901;
        Sat, 11 Feb 2017 06:50:54 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id 10sm5376835wmi.23.2017.02.11.06.50.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Feb 2017 06:50:53 -0800 (PST)
Date:   Sat, 11 Feb 2017 14:51:27 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?=D8yvind_A_=2E?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 4/5] stash: introduce new format create
Message-ID: <20170211145127.GA23081@hank>
References: <20170129201604.30445-1-t.gummerer@gmail.com>
 <20170205202642.14216-1-t.gummerer@gmail.com>
 <20170205202642.14216-5-t.gummerer@gmail.com>
 <20170206155606.xgkmhg656vuc6uki@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170206155606.xgkmhg656vuc6uki@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/06, Jeff King wrote:
> On Sun, Feb 05, 2017 at 08:26:41PM +0000, Thomas Gummerer wrote:
> 
> > git stash create currently supports a positional argument for adding a
> > message.  This is not quite in line with how git commands usually take
> > comments (using a -m flag).
> > 
> > Add a new syntax for adding a message to git stash create using a -m
> > flag.  This is with the goal of deprecating the old style git stash
> > create with positional arguments.
> > 
> > This also adds a -u argument, for untracked files.  This is already used
> > internally as another positional argument, but can now be used from the
> > command line.
> 
> How do we tell the difference between new-style invocations, and
> old-style ones that look new-style? IOW, I think:
> 
>   git stash create -m works
> 
> currently treats "-m works" as the full message, and it would now become
> just "works".
> 
> That may be an acceptable loss for the benefit we are getting. The
> alternative is to make yet another verb for create, as we did with
> save/push). I have a feeling that hardly anybody uses "create", though,
> and it's mostly an implementation detail. So given the obscure nature,
> maybe it's an acceptable level of regression. I dunno.

Right.  So I did a quick search on google and github for this, and
there seems one place where git stash create -m is used [1].  From a
quick look it does however not seem like the -m in the stash message
is of any significance there, but rather that the intention was to use
a flag that doesn't exist.

I *think* this regression is acceptable, but I'm happy to introduce
another verb if people think otherwise.

> But either way, it should probably be in the commit message in case
> somebody does have to track it down later.

I'll add something there, thanks!

> -Peff

[1]: https://github.com/Andersbakken/nrdp-scripts/blob/1052fc6781c36c4b227c7dd4838a501341b0862a/bin/git-rstash#L81
