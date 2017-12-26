Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C9E61F404
	for <e@80x24.org>; Tue, 26 Dec 2017 21:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751266AbdLZVHc (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 16:07:32 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:39970 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbdLZVHc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 16:07:32 -0500
Received: by mail-io0-f173.google.com with SMTP id v30so1798032iov.7
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 13:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecbaldwin.net; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7gdcf/xDjv9xi1KwVkwJ5C9xC8133u08RZ0H3aaOWz8=;
        b=bU07bV0VslDy2IeUMEnjAf2d59+rxt6QeoqPTJVgSIahGwHoqugWpyi8BRXbovFWy/
         uwInut8ht3DwPTtOv5DmxSqIa5K9Z1WqqPjz5w9rCKt6f0QK/V4AjTAb2ZshyOqjYOd3
         hr+v+M6ZS+JpBOXYIPhklvGtzHTrZRCnPyvoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7gdcf/xDjv9xi1KwVkwJ5C9xC8133u08RZ0H3aaOWz8=;
        b=TE3BDirTrzadxxxZkbU3UMvZ3Z6PKkk/yjeiRMi7Gi5OabGqjeLFuBtzw/u/7BcH8I
         kNIEaG5XA8YB4MODzgI5t+Wv7XFKedHV74JJuXPOHtsfDnyo7NvlAW7j8cISnpu4p5IC
         TbOncDfIHutMjzvAAs1DBT86KP31GGOstd0FK9lATQMW5Sy1t9XosSDSwQDyx7PVoIDO
         Nbel/mO/7NLjLXPhEkRCfun4CGl1Y/UK3+0nQ9+sZqcU0Jwgz2p4TzO1egAiauv/s0Ba
         XHpXXVEOodNFMgbDULUr1HAaSjy8IuiPdWpc1wLnwcKOTnai6lNwwVRB8PjFvdx4DlRJ
         2M7g==
X-Gm-Message-State: AKGB3mJX5QIL0wWeIv3lFiNJzrY8Lh9MYVVwTN97Nr/aXCU3WgzgDr69
        YNOynx9IzEG2Oro6sVbVRXaHhw==
X-Google-Smtp-Source: ACJfBosV1Bao7jDjlB2mPrMmX/PoipVt026d27w5fCDHlBs3hhuQP3hl1ZgHMjHqzVdJCtvuLv5QQQ==
X-Received: by 10.107.158.193 with SMTP id h184mr35205099ioe.256.1514322451231;
        Tue, 26 Dec 2017 13:07:31 -0800 (PST)
Received: from Carl-MBP.ecbaldwin.net ([2601:282:8001:ffba:59aa:140c:4d30:a473])
        by smtp.gmail.com with ESMTPSA id j81sm6944147ioi.9.2017.12.26.13.07.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Dec 2017 13:07:30 -0800 (PST)
Date:   Tue, 26 Dec 2017 14:07:29 -0700
From:   Carl Baldwin <carl@ecbaldwin.net>
To:     Paul Smith <paul@mad-scientist.net>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
Message-ID: <20171226210727.GB22855@Carl-MBP.ecbaldwin.net>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
 <877etds220.fsf@evledraar.gmail.com>
 <20171223210141.GA24715@hpz.ecbaldwin.net>
 <87608xrt8o.fsf@evledraar.gmail.com>
 <20171226001622.GA16219@Carl-MBP.ecbaldwin.net>
 <87vagtqszf.fsf@evledraar.gmail.com>
 <20171226194408.GA22855@Carl-MBP.ecbaldwin.net>
 <1514319542.2717.406.camel@mad-scientist.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1514319542.2717.406.camel@mad-scientist.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 26, 2017 at 03:19:02PM -0500, Paul Smith wrote:
> As someone working in an environment where we do a lot of rebasing and
> very little merging, I read these proposals with interest.  I'm not
> convinced that we would switch to using a "replaces"-type feature, but
> I'm pretty sure that the "null-merge and rebase" trick described
> previously would not be something we're interested in using.

In the near term, maybe. I'm still working with it to be sure I
understand it right.

> Although "git log" doesn't follow these merges (unless requested), all
> the graphical tools that are used to display history WOULD show all
> those branches.  In a "replaces"-type environment I think the point is
> that we would not want to see them (certainly not by default) as they
> would be used mainly for deeper spelunking, but since they just seem
> like normal merges I don't see any way to turn them off.

You've touched on some of my concerns with the null-merge approach. I
want the end result to be as clean as possible which I think is what
lures many to the rebase methodology in the first place.

> If "replaces" was a separate capability then it could be treated
> differently by history browsing tools, and shown or not shown as
> desired.  For example, a commit that had a "replaces" element could be
> selected somehow and you could expand that set of commits that were
> replaced, or something like that.

Exactly!

Carl
