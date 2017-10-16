Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79B15202A2
	for <e@80x24.org>; Mon, 16 Oct 2017 23:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932573AbdJPXAc (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 19:00:32 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:51236 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932440AbdJPXAb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 19:00:31 -0400
Received: by mail-pf0-f176.google.com with SMTP id n14so16873996pfh.8
        for <git@vger.kernel.org>; Mon, 16 Oct 2017 16:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D/ZpvMbXZTIu6DbvVH4m8Vn+dI6Awuyl4V8G8ZL+00A=;
        b=CA2VmAzvSbzejaXC10nZIjT1ePMgE9xgCxD/jsQbCVyTCEvzwRBACso/AZjWQFeV0H
         xxLLhfm9nuoZu8jRxIH9vjvPQ/S6D18+129DHxTPSNjOUbdjbPWVKLX8lMkh/Dh+24M+
         XWNNFuUw/FlzYc0w9KxVj5wvc3NjA+74xWRBZLhq12vI8DFo+5H6DPHSe2mzjf3Za5/P
         2w/2Mpbpk4uNc3Th50IgBN/5QHMmDd+XbNqB4T640NkdyXlp51qd9LfGB5jl2bOjhOrl
         hYjTq8ChehBiAYSx59/OxmGxHEyK6RiWTuYB49P6M1vJARnxgoMA/9kr4i9Iv1gwEcbE
         GS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D/ZpvMbXZTIu6DbvVH4m8Vn+dI6Awuyl4V8G8ZL+00A=;
        b=UyJfPek84YoWw16Hi5mSuKaehp/r32BPj6Ov3pza2pXGNgs1aPU46GRq3hpl7GW1aT
         ITaXhkhf3MNQA6dU0r2O+cx0A3r35mNA/6a6nDbH6DRFjWMtntM28s4tjy5sYeVthxQ7
         n0Bnfiki1Nc9qbNpvOkzcOAT/CrTCVsNZxZ/z7NVNpeGLZfJsH5pa2JJqEsedIXmgaG5
         eYrNLZX+tntWEhloAWfLZPVFWVLqNzr5m90tpMFa0XO7g4bmdF2LSou8k37iW87fkPlU
         gvsNkcu0whRfD3MmHJ04hKLB6h8FE4fr3gpfdid7RCU7rfxXykP0e8mLuHxPzvnnWimn
         lfCA==
X-Gm-Message-State: AMCzsaVc1M3wWHKX42MRMkibXdGjnMzpLJBzSPspiW4bn3P9CGNDYxuM
        o3KYUMRidzgW8r7TukA9mDfLIR0l
X-Google-Smtp-Source: AOwi7QA06T9tn6tzaIuuiiiink8U4kB0b+5viKttloqrIsdwIjd0AIgowLd4kL+62dzUD098LiHcxA==
X-Received: by 10.84.174.67 with SMTP id q61mr10458441plb.184.1508194830757;
        Mon, 16 Oct 2017 16:00:30 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id v14sm13644149pgc.78.2017.10.16.16.00.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Oct 2017 16:00:29 -0700 (PDT)
Date:   Mon, 16 Oct 2017 16:00:04 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Marko Kungla <marko.kungla@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] check-ref-format: require a repository for --branch
Message-ID: <20171016230004.uhsyhvtltorjwu5q@aiede.mtv.corp.google.com>
References: <CAKY_R-uk9hpR2hbkPsw2cqoMo6bQKoyp6cWTO20L3fOWfLW2-Q@mail.gmail.com>
 <20170714180313.apsnbnw7no2nvtf5@sigill.intra.peff.net>
 <20170714181831.fvi2coppzhm747mk@sigill.intra.peff.net>
 <20170717172709.GL93855@aiede.mtv.corp.google.com>
 <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>
 <xmqqinffsibr.fsf@gitster.mtv.corp.google.com>
 <xmqq1sm3s751.fsf@gitster.mtv.corp.google.com>
 <20171016224512.6fhtce5anmff577b@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016224512.6fhtce5anmff577b@sigill.intra.peff.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, Oct 16, 2017 at 07:45:46PM +0900, Junio C Hamano wrote:

>> Here is to illustrate what I mean in a patch form.  It resurrects
>> the gentle setup, and uses a purely textual format check when we are
>> outside the repository, while bypassing the @{magic} interpolation
>> codepath that requires us to be in a repository.  When we are in a
>> repository, we operate the same way as before.
>
> I like the state this puts us in, but there's one catch: we're
> completely changing the meaning of "check-ref-format --branch", aren't
> we?
>
> It is going from "this is how you resolve @{-1}" to "this is how you
> check the validity of a potential branch name". Do we need to pick a
> different name, and/or have a deprecation period?

Sorry to take so long on picking this up.  I'll try to make an
alternate patch today.

For what it's worth, I don't agree with this repurposing of
"check-ref-format --branch" at all.  The old command already existed.
No one asked for the new command.  At most, we could get rid of the
old command after a deprecation period.  I don't understand at all why
it's worth the confusion of changing its meaning.

Thanks,
Jonathan
