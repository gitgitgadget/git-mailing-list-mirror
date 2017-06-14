Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 690EC20282
	for <e@80x24.org>; Wed, 14 Jun 2017 17:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbdFNRO6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 13:14:58 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34275 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbdFNRO5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 13:14:57 -0400
Received: by mail-pf0-f173.google.com with SMTP id s66so3307574pfs.1
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 10:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2OAP9Sn7I5pp0Xz1g3FEzQSuSubqf0nWaza5emHsLOE=;
        b=CuDEWIRsNCrNAAlVHWSLNp9YI+H8HM1aSniMDRlLDzVkar+qIb/62aWgx0WOVKoHX9
         U9Sv53+CowwamzPccIOqTR1pEUhWSmJmwgf3K3QtCsmGNqNBr2+Y2XGPaEtcEOI/Xgzp
         Mov1FUU60nhzpYXF7pzRqnGmkExlmSIr5RitHbBg/JFcahEE7Y6OjAZh59pDznyW3d7t
         uflNGLZtEl5SeUSxhVIBd/9jw8ajbafyDG8E37qH13kPvVVg3g60LJGdxywEz+pb++bs
         UVbQ3x5JpCxztyHGlV6DmvJxW6ZO1Z8hROlKXm6ARAS2wtgaXEKCdd31J6PvCwuvbYgk
         J36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2OAP9Sn7I5pp0Xz1g3FEzQSuSubqf0nWaza5emHsLOE=;
        b=c1itJ+x0Azw7Vdsg5G9jFx5jNrdmRskgjhuVP2oPkNggx1zhgTMzQHFnXZ6YXLCQUQ
         8PEOMJEvtsJCHswT8X/B3rPNaZzHe+q1OcSgSq4sHmt2EfhJeEReDkERtauOBYbv3QVU
         ky00QQUZSEbT6gP+hUgWGVhV/0xtu5NalIIFaC9KGC4Ygz5wSLXQoy5ZzN6Affyc+mab
         3yZC9FB50q5sTVdJh3JOyLq+5d3SpOa/I3m8I/uaEsUySsS50soADce9u1LPO9QfTjuS
         PKE8QYn4x5LeQED4/tmByXifk90FExZrelpPmKSAtWMIFvEHv4u/P+U/SSzFXszdETc+
         iisA==
X-Gm-Message-State: AKS2vOwO8IB50M3lGANS7zmhXqHKvMUp7wjWGnRkDguabu1lo5NY48+h
        VmkCz4T+ZDWrytkb
X-Received: by 10.99.52.193 with SMTP id b184mr1028136pga.91.1497460496860;
        Wed, 14 Jun 2017 10:14:56 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:cd44:1c15:d824:b4e])
        by smtp.gmail.com with ESMTPSA id j71sm839074pge.63.2017.06.14.10.14.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 14 Jun 2017 10:14:55 -0700 (PDT)
Date:   Wed, 14 Jun 2017 10:14:54 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2 4/6] config: don't implicitly use gitdir
Message-ID: <20170614171454.GA55677@google.com>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170613210321.152978-1-bmwill@google.com>
 <20170613210321.152978-5-bmwill@google.com>
 <20170613210806.GJ133952@aiede.mtv.corp.google.com>
 <20170613213815.GP154599@google.com>
 <20170614062505.zojevt553sfhbt2h@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170614062505.zojevt553sfhbt2h@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/14, Jeff King wrote:
> On Tue, Jun 13, 2017 at 02:38:15PM -0700, Brandon Williams wrote:
> 
> > > The same comments as before still apply:
> > > 
> > > - this changes API to make opts->git_dir mandatory, which is error prone
> > >   and easily avoidable, e.g. by making git_dir an argument to
> > >   git_config_with_options
> > 
> > I still don't agree with this.  I have looked at all callers and ensured
> > that 'git_dir' will be set when appropriate in the 'config_options'
> > struct.  I find the notion ridiculous that I would need to change a
> > function's name or arguments every time the internals of the function
> > are adjusted or when an options struct obtains a new field.  Plus, there
> > is already an aptly named parameter of type 'config_options' with which
> > to hold options for the config machinery.  This struct is also added to
> > in a later patch to include commondir so that the gitdir vs commondir
> > issue can be resolved.
> 
> I've already said "I'm OK either way for this case", but let me clarify
> a bit.
> 
> It's not about changing a function's internals, or even the struct
> obtaining a new field. The key change here is that the _interface_
> changed. Callers used to be able to pass NULL for the git_dir and have
> the function behave one way, and now if they do so it behaves
> differently. That leads to spooky action at a distance. Code which you
> didn't know about still compiles but does something subtly different.
> 
> We can catch that at the compile stage, or we can catch it at the test
> stage, or we can decide it's somebody else's problem to deal with if
> they wrote code that the rest of the project hasn't seen.
> 
> But it is a real thing that comes up in a big, open project. There is no
> "looked at all the callers", because you can't see the whole universe of
> code. I do think it's a much bigger deal in a project like the kernel,
> which has hundreds of long-lasting forks. Git has only a handful, and we
> don't necessarily need to bend over backwards for people whose code
> hasn't been shared.

At this point I'm done arguing, I'll rename the function and drop the
'git' prefix as that's the only sensible name I can think of.

> 
> > > - the commit message doesn't say anything about to git dir vs common dir
> > >   change.  It needs to, or even better, the switch to use common dir
> > >   instead of git dir can happen as a separate patch.
> > 
> > There really isn't any switching in this patch.  One of the following
> > patches in this series addresses this problem in more detail though.
> 
> I would have expected that patch to actually come earlier. That fixes
> the bug there, and then this conversion patch becomes that much more
> straightforward.

True, I can reorder the patches in v3 so that this change flows better.

-- 
Brandon Williams
