Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AF331F404
	for <e@80x24.org>; Mon,  2 Apr 2018 21:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754178AbeDBVEO (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 17:04:14 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35127 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752321AbeDBVEN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 17:04:13 -0400
Received: by mail-wm0-f66.google.com with SMTP id r82so30251222wme.0
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 14:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fSlCIkQBgVw5qxOODEwgC3w+w7yLdzFKsRZzRTQPi9s=;
        b=dbPWig7IJEh3fuq4V1wjPwrWXWXpPL/dB32Jywwz7B3gEpjU7q+/cC9ZJgvGc1smK1
         vdKYI8+6w272LUEma3UrcPf+EDdD7sKWBO/yDqgxwi3H2/l4NgmER7qwUfnasASKPGHA
         BclKdA/h7FIMrY6h7NF0FVYyTTEQjjp4ol4YoAU4eTLr3BUMUfx+DaKZh+6q93CaXF0u
         iCKv+BrFfAb9/+yNxGA31JmCN0hg9w+KAno6nU7Lp4RWTyQnRgu98X+UbdtlwDJJuqjA
         2p3eDGqof4WbKEwkTw5EC28ZK83Mrn7InCxul24XsQwWvQBqWLRVj6HpaaH5PxtS0Jfn
         fWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fSlCIkQBgVw5qxOODEwgC3w+w7yLdzFKsRZzRTQPi9s=;
        b=kucPRYxeQcXs9MaYh7ABICLobiXvyBBwHRoKxhwXc/0s8MNs7n+lVgi3VUwC6JT4Qv
         1AKKC7zrB0RS1O7wtaclTkp0zCbEdo/Q4s7udnfYoOb2vCIpwqNvhnq6Pg2fY/GwcRbN
         M0NDFbmZBMIhCqHDrp4wUITkuqHu8xZwOJVw5+dIFL7KvXyLQdN+oL1c7vMiRLRAzbvr
         2XbplMi5zNfAUvNmbkYLNboRrj0T3Lk1YDDtdxN3ktnsUlS0yj6qdNLdWqIvJNR4g55o
         b3NkFJdfl28rkHL8T8qhgMkEEHZ+1hlxOC17bTZW+6Viut0IfmzLOgxacZJ6DftXW1hl
         HMiA==
X-Gm-Message-State: AElRT7H9K1oSEUH9bJhG5dpEGhyBx9uvwriE/cC8iYPLWJPIN2M9d4UN
        oU3tg/2Peoi3xJ7+I/bCj6w=
X-Google-Smtp-Source: AIpwx4+ST6KMpfHeHjHOjK3RscSUmuWChqSsJiUmhCQkenafO/t/VNyjG8wCfEfKkG5b2bWMUTWwVQ==
X-Received: by 10.28.228.9 with SMTP id b9mr2059393wmh.131.1522703052461;
        Mon, 02 Apr 2018 14:04:12 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id b34sm2764991wra.21.2018.04.02.14.04.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 14:04:11 -0700 (PDT)
Date:   Mon, 2 Apr 2018 23:07:41 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v6 2/6] reset: introduce show-new-head-line option
Message-ID: <20180402220741.GG2629@hank>
References: <20180325134947.25828-1-t.gummerer@gmail.com>
 <20180331151804.30380-1-t.gummerer@gmail.com>
 <20180331151804.30380-3-t.gummerer@gmail.com>
 <xmqqwoxpxsfv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwoxpxsfv.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/02, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Introduce a new --show-new-head-line command line option, that
> > determines whether the "HEAD is now at ..." message is printed or not.
> > It is enabled by default to preserve the current behaviour.
> >
> > It will be used in a subsequent commit to disable printing the "HEAD is
> > now at ..." line in 'git worktree add', so it can be replaced with a
> > custom one, that explains the behaviour better.
> >
> > We cannot just pass the --quite flag from 'git worktree add', as that
> > would also hide progress output when checking out large working trees,
> > which is undesirable.
> >
> > As this option is only for internal use, which we probably don't want
> > to advertise to our users, at least until there's a need for it, make
> > it a hidden flag.
> 
> As a temporary hack, adding something like this may be OK, but in
> the longer run, I think we should (at least) consider refactoring
> "reset --hard" codepath to a freestanding and silent helper function
> so that both cmd_reset() and add_worktree() can call it and report
> the outcome in their own phrasing.

I agree that refactoring this would have been nicer.  The biggest
obstacle there is that the 'git reset' needs to run with a different
"GIT_DIR" and "GIT_WORK_TREE", which is not easy to accomplish in the
current code.

It does seem like something that would be much easier once we have
'struct repository' being passed through everywhere.  I'd rather wait
a bit more for the 'struct repository' series to land, which will
hopefully make the refactoring easier (although I didn't have time to
follow the series closely).

> And I support the decision not to advertise this as a new feature or
> an option by implementing it as hidden-bool.
> 
> This is completely offtopic tangent, but I wonder how hidden-bool or
> hidden options[] element in general interacts with the recent
> addition of helping command line completion.  Are we already doing
> the right thing?
