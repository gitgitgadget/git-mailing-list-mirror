Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C46011F453
	for <e@80x24.org>; Fri, 28 Sep 2018 14:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbeI1Upz (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 16:45:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39219 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbeI1Upz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 16:45:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id r9-v6so733424pgv.6
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 07:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lhCJi8UHfVvkBtq1XQUSk6rQinLogi32+GPv1kzEo5A=;
        b=vmNy9RyjrGHpOroup20Bp9m9D8+C22WrYWuo2cau1UpsjvLWZNhKJiYH7+his8Aw8c
         bk7oE/4czbFquOSlcXU61YRnsMS9nqFX/qOUEPQ6tQFKnoTG53b7+15cE8bAxbVeEnRI
         bw1eSKTA4gxuxybCi/tnH8bb6M6EYXqfqoKzyMsaAJdOc1lemVE7xp4Xz+DzdbbTU3XZ
         U0jL5khM/O/rgcFQ1tsiQvO2qL1Tf67Y7H3jHUH6yuUs+iitW5xJ+/eM23uYKPJwe5mt
         bE06Q9nkqJ2o3/9/9f1/rB4Do+LTgBM/yC+t47qE452PE9rKmhtlgAW1+6dlC7Ddl4Tk
         moiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lhCJi8UHfVvkBtq1XQUSk6rQinLogi32+GPv1kzEo5A=;
        b=VlUf8dkE2qrayK5NIVDXgWlbYuOiJmiKnNzV0pW+msK6r9BLby822hIJW8cd/ZOJu8
         whSXWqfKjqAGQq77VK6ZhLmWQlWn4qQH1ey8GyuKUlUbpBwhlouWh8BwrGBd+OBfxM9N
         4vu3TG+bKDSNbBpBbKCGBKDbEMOr4ZlPmV6yUkjDfbpYX5Qav2EGMAK/chr8BMkALpSJ
         BXrst2+4jtwtvBeVkZebi9Uh46MOg/DMV6KiVmNl3x8rt1B+wzGT3pf66gXeSKPSKQ1K
         4dYbKqGLPkhtM82MYgRxpTlebVF4mP2lAmNzxL5TAS6RqOAbF5wivlblJTQkMG8uVeSy
         k+sw==
X-Gm-Message-State: ABuFfoi1b8o0w5ShBIX2NJymtJXJncnh0zBY9l0DZ1BWy1xnL0eopMy7
        Lq3m7HuQLABf9HvbK2aDBPfZ3g==
X-Google-Smtp-Source: ACcGV63jVD0fVotBf48GKHq6FJMFY07EQ/qWKmWSFPb+mCczQJxuOmRJHbFUDHQYFPpJ4PDtZxctdg==
X-Received: by 2002:a63:2a0b:: with SMTP id q11-v6mr15026439pgq.36.1538144513341;
        Fri, 28 Sep 2018 07:21:53 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:1924:afac:8279:2210])
        by smtp.gmail.com with ESMTPSA id w2-v6sm3604304pfk.140.2018.09.28.07.21.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 07:21:51 -0700 (PDT)
Date:   Fri, 28 Sep 2018 07:21:51 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com, sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v3 1/4] transport: drop refnames from
 for_each_alternate_ref
Message-ID: <20180928142151.GD23652@syl>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1538108385.git.me@ttaylorr.com>
 <037273dab0f861e5f10241de1e32cddaabeab0cc.1538108385.git.me@ttaylorr.com>
 <20180928045858.GA25850@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928045858.GA25850@sigill.intra.peff.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 28, 2018 at 12:58:58AM -0400, Jeff King wrote:
> > From: Jeff King <me@ttaylorr.com>
>
> Pretty sure that isn't right. :)

Indeed that isn't right :-). I try my best to review my patches
diligently before submitting them, but here's an interesting side-story
if you're interested:

I use a script 'git mail' which is essentially doing:

  git format-patch --stdout >mbox && mutt -f mbox

So, by the time that I've reviewed the diff via:

  $ git format-patch --stdout | less

I assume that the patches are ready to send (since, after all, running
'git format-patch' more than once shouldn't change anything.) So, I open
mutt with 'git mail', write my cover letter, and send each of the
patches to the list.

It was during that last phase that I ignored the From: Jeff King
<me@ttaylorr.com>, which I agree with you is certainly incorrect :-).

I was going to ask Junio to fix this up when queuing, but it seems (from
a quick skim of the rest of your review), that we will reach v4, so I'll
see if I can't teach 'git mail' to do the right thing for me.

> The patch itself is flawless, of course. ;)

Obviously ;-).

Thanks,
Taylor
