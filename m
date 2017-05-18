Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 974BC201A7
	for <e@80x24.org>; Thu, 18 May 2017 00:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753723AbdERAHj (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 20:07:39 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34356 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753789AbdERAHi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 20:07:38 -0400
Received: by mail-pf0-f173.google.com with SMTP id 9so14868112pfj.1
        for <git@vger.kernel.org>; Wed, 17 May 2017 17:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=guxgc0OcYVtpCOWu4ThTohL2Jd3G8SWIESnE9jSqewU=;
        b=E0BC2k5pGWoEVjHdw7J0oDXU/L13RhnHS80/VQakQu5RBIW9GlCM/QXSNZg016+6Lr
         Tb+xDhP4Hjn+f2xVL/2OR8m498nsCfUEhiiNhHygeFs9R7QaTbkGavh7jf//s7OIbtu5
         R4NORDLO/ec+cHFOysY3OyfBb40R/X6+Bgw/AHwjkQGnoqv+m01OMCkruXnaGW+8ntKs
         tUe8WlU0N7HbQ9JU4d0SV15WrprsGyMNfS8XD6SlPQRANfOh1a+5qxZ85Hd/A9MXFmMc
         dDfvNvthxTX+RsqXUADEcJKl9lqfitO/pBfRSCmkprPvjwkFUOidxab6bpLdbsfszkNv
         96Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=guxgc0OcYVtpCOWu4ThTohL2Jd3G8SWIESnE9jSqewU=;
        b=Y1JXcP2c+YqAzDw4IyP93z54HivFL2DHViN7l4ctYIjDTVNA1D8TFH8ELwNvws0F0I
         0yIgnz0gatY+lA+49wgpADSbsnmnQHwrszda0imUwgcrw4Hww9ak07EGKaRtRwdQsVMe
         9arzW1i8dVs3yNozg7TJASLh8N9dxSs6MLgc7JWzpNQM2G79bLCO43mOZYD2benE3/Wa
         WE0tm/hVXDB7QU7KzdDTYrWqhkTBTPq7fPrVDQfHxdrhnsY2u+jsEgOB3h7zvZQ/QFvk
         osyVbJEDpHHwetgIyN0TRf9/7rglI7AsnTV7ogZdDbiyG0pfd9Kc4hBVfG0RA8TTN+mz
         XEyg==
X-Gm-Message-State: AODbwcB1ykZD+/lvQeutColNkO2wlFPCae3GGmKZQJjQdtME+qoBGt/I
        3v/3V6K/mdpt9LimYDXCvQ==
X-Received: by 10.99.111.140 with SMTP id k134mr1306495pgc.20.1495066057344;
        Wed, 17 May 2017 17:07:37 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:1838:1185:c4dc:8c8d])
        by smtp.gmail.com with ESMTPSA id 20sm7371616pfq.42.2017.05.17.17.07.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 17 May 2017 17:07:36 -0700 (PDT)
Date:   Wed, 17 May 2017 17:07:35 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Manish Goregaokar <manishearth@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] refs: Add for_each_worktree_ref for iterating over
 all worktree HEADs
Message-ID: <20170518000735.GD185461@google.com>
References: <20170517002825.GR27400@aiede.svl.corp.google.com>
 <20170517005041.46310-1-manishearth@gmail.com>
 <CAM2h-yfRc69W8f=inRRjtyBh4EZWJk6W2gCTM=S=ifJn3g8auA@mail.gmail.com>
 <CACpkpx=usSnEBPPPppdeaM+HUNc06ZuN3mrfN4Nemspn96K9dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACpkpx=usSnEBPPPppdeaM+HUNc06ZuN3mrfN4Nemspn96K9dQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/17, Manish Goregaokar wrote:
> Oh, btw, refs.c needs an #include "worktree.h" to work; I didn't get a
> chance to test this after rebasing onto the maint branch.
> 
> (There's also another fix it needs to have no warnings, but that's not
> going to affect building). I have this fixed locally, but I'll wait
> for the rest of the review before pushing them up.
> -Manish Goregaokar

Just as an fyi, its usually fine to send out a path RFC (request for
comments) or WIP (Work in Progress) which compiles with warnings (or
maybe not at all) and which doesn't pass all tests.  If you do that just
make sure to indicate as such.

Though if you are sending out a patch which you want to be seriously
reviewed and ultimately merged then the best practice is to ensure that
it compiles without warnings and that all tests pass.  I'm definitely
guilty of this occasionally (no one's perfect!) but I'm just hoping to
provide you with some of the expectations we have.

I'm assuming you're newer to the community, so Welcome! Take a load off
and stay a while :)

-- 
Brandon Williams
