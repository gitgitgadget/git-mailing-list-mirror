Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AC591F404
	for <e@80x24.org>; Wed,  5 Sep 2018 18:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeIEXUE (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 19:20:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38777 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbeIEXUD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 19:20:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id w11-v6so8740509wrc.5
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 11:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OpcgfMColFA7BX7xXbZ7RIafQk22Y7yY8nX4REOG+LU=;
        b=rxIL4KKXTTkcQ34/xrf6hmtkRvtlDkGlKjRt7WAdvV3WKSwp0blw61xr7kDGixM3ev
         J8BUCjwLVZt0PjGymEJiyfBuHyQnFZNHQfGF790F77ARzmkCz7MrGH/Pd2yYQvdNb2ZO
         tOlzIC+FTSfTqysOtU7Rfgzu1HfVD3Q18xPR+lld8XB/s291Ec7/175iPnhiss8ZcBuA
         k5UcgcpcYndifPDY5I8GEMElWP67RTqqklaiIfLLfL2QOT771479dOBg6WRA+Cjx4EmC
         QLVLVZ8kJlNLbIeY4L1z2cGHIHSNQTSlBpRbMibJEdPPY088daDPD9Y+l2XF4rRyn/tG
         ITuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OpcgfMColFA7BX7xXbZ7RIafQk22Y7yY8nX4REOG+LU=;
        b=ScGiZHYYAJ+dPEjjSQsDe9s5xHH01aHKRJp+VjIPH3S19EA1fuCCDMNolsBXcut4Ii
         m1B0rZUCay5zead/J/uc9011xegrPX6hRgZ+thaCUqxdXJ5mLVeBuineUV3CjYGgCSZC
         1P6YPIsuFhPXUroO5FZchONfkh14ekL5+P6xzfY6G/4GriR8vHLpx7SHRqrGNg58kfsE
         F/iDjRB1+gUV+4JNUbCEtwH+lIKRFK+0G89Dj7prXf/sQ3pgZbhDCjaM1dkOp/RQXEt7
         SBNLy13FTa66sKhhcbCQL6t0eZ3Nq/z/psWUcFuVzYDM3ej6Qk5lxdxPgjIxx2H/nqyf
         Kk7w==
X-Gm-Message-State: APzg51DSjI7AC5zeNr8uYV+Fxkib14RLGV3FNBpMPKZ9rfz3+kUqJ9mF
        EavUmUYox9oGavgXvWv632M=
X-Google-Smtp-Source: ANB0VdYfeuLHp2/NeIriBKLY+OIWqmjjl5Ce9BlLjbznpc44tCJfMJGvJoLcpLKeGw3GGuzM9FKA1A==
X-Received: by 2002:adf:9142:: with SMTP id j60-v6mr28254736wrj.180.1536173316275;
        Wed, 05 Sep 2018 11:48:36 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4006:df00:b45a:4246:cb70:58f7])
        by smtp.gmail.com with ESMTPSA id 14-v6sm4251685wmp.32.2018.09.05.11.48.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 11:48:35 -0700 (PDT)
Date:   Wed, 5 Sep 2018 20:48:34 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH] reopen_tempfile(): truncate opened file
Message-ID: <20180905184834.ihpjardxnny6d54p@ltop.local>
References: <20180901214157.hxlqmbz3fds7hsdl@ltop.local>
 <87tvn8c166.fsf@evledraar.gmail.com>
 <20180902050803.GA21324@sigill.intra.peff.net>
 <20180902071204.GA2868@duynguyen.home>
 <20180902072408.GA18787@sigill.intra.peff.net>
 <xmqq36upcl1s.fsf@gitster-ct.c.googlers.com>
 <CACsJy8AuWKxAdETaqYmcSY2VeLeWFyjnSYrK4GJeyG5ecv3OcA@mail.gmail.com>
 <20180904163807.GA23572@sigill.intra.peff.net>
 <20180904233643.GA9156@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904233643.GA9156@sigill.intra.peff.net>
User-Agent: NeoMutt/20180622
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 04, 2018 at 07:36:43PM -0400, Jeff King wrote:
> On Tue, Sep 04, 2018 at 12:38:07PM -0400, Jeff King wrote:
> 
> > > And just to be clear I'm looking forward to a patch from Jeff to fix
> > > this since he clearly put more thoughts on this than me. With commit.c
> > > being the only user of reopen_lock_file() I guess it's even ok to just
> > > stick O_TRUNC in there and worry about O_APPEND when a new caller
> > > needs that.
> > 
> > That's the way I'm leaning to. The fix is obviously a one-liner, but I
> > was hoping to construct a minimal test case. I just haven't gotten
> > around to it yet.
> 
> It turned out not to be too bad to write a test. It feels a little like
> black magic, since I empirically determined a way in which the
> cache-tree happens to shrink with the current code. But that assumption
> is tested with a sanity check, so we'll at least know if it becomes a
> noop.
> 
> > The bug is ancient, so I don't think it's important for v2.19.
> 
> The patch below should work on master or maint. We could do a fix
> directly on top of the bug, but merging-up is weird (because the buggy
> code became part of a reusable module).

It's great that you were able to create a reproducer relatively easily.

Thank you, guys.

-- Luc 
