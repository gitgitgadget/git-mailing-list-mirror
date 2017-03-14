Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DCF820951
	for <e@80x24.org>; Tue, 14 Mar 2017 22:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751172AbdCNWfg (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 18:35:36 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34324 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbdCNWff (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 18:35:35 -0400
Received: by mail-pg0-f53.google.com with SMTP id 141so110385pgd.1
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 15:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=njBnPGS3qHzIV5+X1aRh2J3vR1oa2u6Pox5Uw9Xz7WM=;
        b=pUDiiiqnFNVxAdfNuHZjsozFIFTtpFWlhevLbxjyxN+oXL80RtYwNgoKofOL1l2+3T
         kXsHo6vRPpmit1HyZno2lZUUTFdU5uhcYmWuZMROBQPerPbiDPajoPUss3CN6fLrpz/m
         WZ4piXz9/5yRg0tMQsI017ewKi8B1vlkZ3mxlJpdMsI8XzpsqHv0qwA+4gywIOHJZCPZ
         O/ahquP4gTqGpEE1siS9kSeyz3YI3FISXydrABY5CpxSBHLCoOTXrWVOyMNczD3vm9r5
         uVVpAtazSVv5b/OEEvQEo3qL8aVUKa/d9fSCLrc9qqroM1R+Fo5pskeYUtuY6FTpN/fG
         UgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=njBnPGS3qHzIV5+X1aRh2J3vR1oa2u6Pox5Uw9Xz7WM=;
        b=iWpbz+qYDhaZ5ukuyzIV7ltB/5VH5oduHFhVus1dH/OuokuqOWCwVl9o3DRfqmjq/4
         4QVEfajaoL8+YYXaIFx3L57q8G8iKceUtuJXC/aDnzu30FcjScz8z6JBLO6+IwFg63EU
         2mHC0zyUOLrdYj4nf4UdfWwvu6ehcc6kPXE1FYtw6M0TsrQQfWl3JjjVEk0jtfgKGnGo
         xmk60B3+HVQmi8Mw4fsPGShLNvgORgj7WnpPOG/dbM2hgmb32CmkXv3P7i7iq4Xg5kdM
         b8cZ19JZS7J1EI3XEZ3ED/5P8XxFLYwlaWI4vMZuJCcOKm42d03Lj7uSWVv0uQg63+UX
         9IIw==
X-Gm-Message-State: AFeK/H3GZhimyfcU+ieeycm5MnnRkaltCu714srTVF3YpPS9pJx4xjGHro2zKuiGDD6y7oje
X-Received: by 10.98.110.193 with SMTP id j184mr19213pfc.228.1489530934129;
        Tue, 14 Mar 2017 15:35:34 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:491b:baa8:63f0:3cf1])
        by smtp.gmail.com with ESMTPSA id z26sm3211pgc.57.2017.03.14.15.35.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 15:35:32 -0700 (PDT)
Date:   Tue, 14 Mar 2017 15:35:31 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        peff@peff.net, pclouds@gmail.com
Subject: Re: [PATCH v2 2/4] setup: allow for prefix to be passed to git
 commands
Message-ID: <20170314223531.GB168037@google.com>
References: <20170224235100.52627-1-bmwill@google.com>
 <20170314221100.24856-1-bmwill@google.com>
 <20170314221100.24856-3-bmwill@google.com>
 <alpine.DEB.2.20.1703142326460.3767@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1703142326460.3767@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/14, Johannes Schindelin wrote:
> Hi Brandon,
> 
> On Tue, 14 Mar 2017, Brandon Williams wrote:
> 
> > In a future patch child processes which act on submodules need a little
> > more context about the original command that was invoked.  This patch
> > teaches git to use the prefix stored in `GIT_INTERNAL_TOPLEVEL_PREFIX`
> > if another prefix wasn't found during the git directory setup process.
> 
> Missing SOB ;-)
> 

Thanks for that catch.  I'm expecting some discussion on this patch in
particular (and cc'd you since you've been working on this area of the
code) so I'll make sure to add it in the next reroll.

> > diff --git a/setup.c b/setup.c
> > index 8f64fbdfb..c8492ea8a 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -940,8 +940,14 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
> >  const char *setup_git_directory_gently(int *nongit_ok)
> >  {
> >  	const char *prefix;
> > +	const char *env_prefix;
> 
> I'd just append this to the previous line (`const char *prefix,
> *env_prefix`).

That would be cleaner.

> 
> >  	prefix = setup_git_directory_gently_1(nongit_ok);
> > +	env_prefix = getenv(GIT_TOPLEVEL_PREFIX_ENVIRONMENT);
> > +
> > +	if (env_prefix)
> > +		prefix = env_prefix;
> 
> The commit message claims that env_prefix is used if no other prefix was
> found, but this code ignores any prefix if the environment variable was
> set.
> 
> Which version is correct?

Well, as you can tell I flip-flopped on what I thought the best course
of action would be.  For my intentions (submodule-centric) I don't
believe they would ever both have a value so it doesn't matter to me
which it is.  Though future users may want a particular order of
precedence.

> 
> Ciao,
> Johannes

-- 
Brandon Williams
