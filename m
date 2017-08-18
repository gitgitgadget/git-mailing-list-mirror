Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F4CD208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 22:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbdHRWGl (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 18:06:41 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:38034 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752457AbdHRWGk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 18:06:40 -0400
Received: by mail-pg0-f47.google.com with SMTP id t80so44398615pgb.5
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 15:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oevYRxWPA23/N5+MCHjRHoTecz+A6wyPqO4ggpYDhXY=;
        b=QuwD6TZboY9VjtOUhOz8jurAFinMAR1AdnlXW7xzPG1jBFaWxZGlRtzFs10bb+EEnn
         XZUIyDs7J+RDabND3Ie7ftvHd/CW2D5tJvJdFHe8HfIQrqrbupXJJMQK74ZPhVivbRDU
         RUJ/XR2/XyK3x1a3klA0jVibbVaP0UKXHpaD7/XT1KpALTy8l4Ex+l93aPo4IZkA7htv
         Tz/DhKUIjLaMrcoB3Oj/F4qMMecQAptWPmYY9+V+5+sAlQfJ8Xej2PTWAEwGYGhEbeh2
         +WN8LP73fihO58I+qpwAT2CkRONnUqUznSRvZEqhwW8LF+ta0x44dpEFh4LaVUObVW5P
         xOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oevYRxWPA23/N5+MCHjRHoTecz+A6wyPqO4ggpYDhXY=;
        b=Kqt0eN0Lt8VMW2gvKi3tX4aWF1k78/9qaiqcJBu4xwKQNBKyHqUEKQUWLWWo4QSebo
         O2ZxoK04hSrm6DAGmGyPhDFkeO+3J9xWu86YMwBj5mGKE9TlYR85DRXD3/I424wso+5V
         85BNhBn6LqZwg/rLRous2+/reagPJKu5vm8UeyhoHmyXl8stgz9bf1vLuxwkd2ydgAgT
         6qoq2M5M8mW4qkS3Uix9iZXnKlDtXrKEe3bzQJVIpJkjr8Q9qPdksEbZlbu6sd5OTuyx
         WJbvnLUBjrhXj0e+mEN57aWHomTCuGxtuaMPTM39YTANAQr3nCHhXFFK4VgFOijhJb/T
         flag==
X-Gm-Message-State: AHYfb5gifvbnxJHE0g++yt6igsRRknWHDf7eiG1q+UevYLhUwZAqaNAu
        tz5LE7BeW/YWgirK+OY=
X-Received: by 10.99.149.73 with SMTP id t9mr9574185pgn.227.1503093999675;
        Fri, 18 Aug 2017 15:06:39 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:70fd:e2e5:b6ce:5065])
        by smtp.gmail.com with ESMTPSA id t22sm12024547pfi.68.2017.08.18.15.06.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 15:06:39 -0700 (PDT)
Date:   Fri, 18 Aug 2017 15:06:37 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, Mike Hommey <mh@glandium.org>
Subject: Re: Revision resolution for remote-helpers?
Message-ID: <20170818220637.GN13924@aiede.mtv.corp.google.com>
References: <20170818064208.plkppke7efpucuwm@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170818064208.plkppke7efpucuwm@glandium.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Mike Hommey wrote:

> My thought is that a string like <helper>::<revision> could be used
> wherever a committish is expected. That would call some helper
> and request to resolve revision, and the helper would provide a git
> commit as a response.

I like this idea.

> The reason for the <helper>:: prefix is that it matches the <helper>::
> prefix used for remote helpers.
>
> Now, there are a few caveats:
> - <revision>, for e.g. svn, pretty much would depend on the remote.
>   OTOH, in mercurial, it doesn't. I think it would be fair for the
>   helper to have to deal with making what appears after :: relevant
>   to find the right revision, by possibly including a remote name.
> - msys likes to completely fuck up command lines when they contain ::.
>   For remote helpers, the alternative that works is
>   <helper>://<host>/etc.

Hm --- is there a bug already open about this (e.g. in the Git for
Windows project or in msys) where I can read more?

> Which leads me to think some "virtual" ref namespace could be a solution
> to the problem. So instead of <helper>::, the prefix would be <helper>/.
> For e.g. svn, svn/$remote/$rev would be a natural way to specify the
> revision for a given remote. For mercurial, hg/$sha1.

I see.  My naive assumption would be that a string like r12345 would be
the most natural way for a user to want to specify a Subversion
revision, but you're right that those only have meaning scoped to a
particular server.  That makes the svn/ prefix more tolerable.

> Potentially, this could be a sort of pluggable ref stores, which could
> be used for extensions such as the currently discussed reftable.
>
> On the opposite end of the problem, I'm also thinking about git log
> --decorate=<helper> displaying the mercurial revisions where branch
> decorations would normally go.
>
> I have no patch to show for it. Those are ideas that I first want to
> discuss before implementing anything.

One additional thought: unlike refs, these are not necessarily
enumerable (and I wouldn't expect "git show-ref" to show them) and
they do not affect "git prune"'s reachability computation.

So internally I don't think refs is the right concept to map these to.
I think the right layer is revision syntax handling (revision.c).

Thanks,
Jonathan
