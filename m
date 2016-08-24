Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 866061F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 16:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756518AbcHXQPO (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 12:15:14 -0400
Received: from mail-ua0-f169.google.com ([209.85.217.169]:36846 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754739AbcHXQPN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 12:15:13 -0400
Received: by mail-ua0-f169.google.com with SMTP id 97so36813517uav.3
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 09:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HNtx9+68+gSl7gma9REujzOH9JkjaA4Eq7KcGjBzNYg=;
        b=isDDpyrfjgyxwfX5NdyyzHvdBreFbfk6LBeOEOyOm6Ch+9F5Q5W7CV7z+ZwdUfjFxa
         GHe6VlQuBae5/mj5pTdTIWUFkLzAYfTJ4JKaMYYFsDEEVsfmfxNJo8tEVE6j4Ehvfrla
         p6eWWtFZsAuqPb3TLLW/W4Ztg2mLmnS1n1QYbCACulFI0AkgRO/QEJ6oV03oFab2Zc2O
         jPegSWJ2OX/W7L9nQB8AdG/uCW7d9QNed6Kf9u6GTfyQrnRro8v1YNoGoRLIesdGr/k7
         TCPwtQRoLsG2V5yn367E7x6NTI85S6YPsEIK6cLPNDN61r04ZNDCLT/Q/KUevx1Owtl7
         ACXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HNtx9+68+gSl7gma9REujzOH9JkjaA4Eq7KcGjBzNYg=;
        b=WNh3lvcGrBYCtV4gltqFHXju+SO51lP6WvThBc6pzwpIVS9h/HliLyelLAskMz8w+l
         QRr6DS+L7onCP5ZvIJBM/eQmKzw3B9QI4hWARl0clIbt4u46zLGQr3+FTQ3bl5GXaUD5
         AFjkkgQlta7TLMe6KGnwuQHtPPPg9yGUh+uaxN2gfQpLZafZi+GJzfVDL9skWTvLA7wJ
         ZuB1HsU1phDQ8uvfgTM5ZER+LMo4rHw3dQgkZLo8g6l97P5VLFy3vzutagBXvfXxQd4+
         OGZNvUfPYwQgCulbXuKKfZaR8wDwUzB4MZqt+kRck+xaF3nrACwnIyeYB+SrdtEMLGeR
         y0GQ==
X-Gm-Message-State: AEkoouuCOCNGgZFDYUKwQr/zmaPtXAM+IaJGyrFLwFJIxh5b6w6Y/LW2HyplkBWXKpuLJDM3Bg1iPAMiox5rrA==
X-Received: by 10.31.87.194 with SMTP id l185mr2166427vkb.32.1472054819798;
 Wed, 24 Aug 2016 09:06:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.47.140 with HTTP; Wed, 24 Aug 2016 09:06:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1608241740320.4924@virtualbox>
References: <alpine.DEB.2.20.1608131214070.4924@virtualbox>
 <xmqqshu8u0px.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608171507530.4924@virtualbox>
 <xmqqeg5nbehc.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608181022250.4924@virtualbox>
 <CACsJy8A3tkMY-iLPCDj9sqB4HpAK_cxsUu5Z7fsGcCQEORyxUg@mail.gmail.com>
 <alpine.DEB.2.20.1608231553030.4924@virtualbox> <2a6d2230-90ce-0f54-c7ae-a5aa595a2f73@drmicha.warpmail.net>
 <alpine.DEB.2.20.1608231736180.4924@virtualbox> <alpine.DEB.2.20.1608231758260.4924@virtualbox>
 <xmqqzio3uw31.fsf@gitster.mtv.corp.google.com> <xmqqa8g3uppx.fsf@gitster.mtv.corp.google.com>
 <CAG0BQXmmW_0n4OMQVsVQ5+OKbNVpgXmXeExFUOXqY8nH=sg3Jw@mail.gmail.com> <alpine.DEB.2.20.1608241740320.4924@virtualbox>
From:   Dakota Hawkins <dakotahawkins@gmail.com>
Date:   Wed, 24 Aug 2016 12:06:59 -0400
Message-ID: <CAG0BQXmovWAjn8sE=CFGMXguRpEqU3xUbF03aSEN4OLxNc9oZg@mail.gmail.com>
Subject: Re: Git for Windows documentation, was Re: [git-for-windows] Re:
 [ANNOUNCE] Git for Windows 2.9.3
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Duy Nguyen <pclouds@gmail.com>,
        git-for-windows <git-for-windows@googlegroups.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 24, 2016 at 11:41 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Dakota,
>
> On Tue, 23 Aug 2016, Dakota Hawkins wrote:
>
>> I use GFW almost exclusively, but I pretty much always consult the
>> upstream documentation anyway (because I find it easier).
>
> Oh... I thought that typing "git help git-commit" opening a nice HTML page
> in your favorite browser was good enough.
>
> Do you have any suggestion how to improve the user experience?

Just a small one, and that's that I'd prefer the option to have help
display in my terminal (that option might exist and I don't know how
to turn it on). That would be very convenient for me.

Opening a nice HTML page is probably nice for a lot of users. What
frustrates me about it is that I don't know which browser window on
which monitor (of 3) it's going to open in, so it's a context-switch
to a different window somewhere that I don't have much control over.

The thing I find easier about using the upstream documentation is just
that I can pick the browser window I want it to come up in, and it's
usually faster enough for me to just google "git-whatever" or
re-purpose an open doc tab. I don't prefer the _content_ of the
upstream documentation, it's just less frustrating for me to use, if
that makes sense.

-Dakota
