Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D4561F404
	for <e@80x24.org>; Tue, 20 Feb 2018 16:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753224AbeBTQ26 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 11:28:58 -0500
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35134 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752920AbeBTQ24 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 11:28:56 -0500
Received: by mail-lf0-f46.google.com with SMTP id 70so5060906lfw.2
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 08:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ANGl7pnWXxgjg1XKVVksIyKUypn2svqrc5A56pVtPMs=;
        b=p+q0y76unlr50Dn/V6A0KOFRnT0Od+S0ljGD+NVfb3rp8c4Fsp4IfQjDNHL/LxTnt4
         lQThn7AvdSvEx/ksn4QiG/jlZiyXPugO0odYk8/FJk52WCT1xFgwlSw5WVzGV9AUWWTj
         QIkKd/pv+xp8auoUFjUQZZwCQGCXI0WqJfYW2yQvj1t88q50mjSTQpiJCy/98W9gnVCl
         KNLHskcT2tSBVJasSxAayTsf1aQGqDN/cM8qdUCLTBuDx6An9mBDnEDHFWuicFoFE6Jh
         b5XEu7T3HzyeW5ezru8yvmbUfZDwsyFbW0U2ZHtMCpT68bqI7090KVsMCFNZ9WH46/iK
         iZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ANGl7pnWXxgjg1XKVVksIyKUypn2svqrc5A56pVtPMs=;
        b=DAv/4Foi6jcXB291k0RNaOfIq/31VDaNoWPbUln1dFV8YsOCQ240KaThQlX9WRSVdC
         88IMmN2OVezIf0oYpg4YIZOQuPLRnYN1mxyKjJuZgQPRyEDXjktUQOme63HcidT5RLJ6
         CtHButGgoQsPbAx7+ZEJk8BwWML3b8pQle+ssLBA72bXH5XEfm5tZJA6P7KoOG7hfrHC
         VDtHhmmni+Z4jq9lYHtoHC0KaVpYT/uhgLLMVL8WBRcBrpY40f1n+Bk2aCy24GFYia3/
         /ZmWvGSUVnlu6/693EME90P4bh8t+q6UNIqY3QwJEePzlRObxN0FhcPWV7i+Z4sz+rxc
         yHwg==
X-Gm-Message-State: APf1xPBwieDqrwjFfxh6cTVv285FsBrzELwhgBUwyg7XqxM7Ydds9JKb
        Tu6P+dlifgFQZiHLDuuEwJ6/mpwhLnYuefQBGwg=
X-Google-Smtp-Source: AH8x2268ISDGQ9Ip/O5yFotzNzc78AFzaiGwb0q8ufU06sX0F2y/LLGaR4rcN2++mCzMI/RCjb4wcO7w4GppJ5Jp/yI=
X-Received: by 10.25.252.4 with SMTP id a4mr142203lfi.43.1519144134905; Tue,
 20 Feb 2018 08:28:54 -0800 (PST)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.46.114.19 with HTTP; Tue, 20 Feb 2018 08:28:54 -0800 (PST)
In-Reply-To: <CAG6xkCa_nKtzhJJq=v7gazWe+8FnN3mz1vDftzZw2WUFqJ1bzw@mail.gmail.com>
References: <20180123001648.24260-1-isaachier@gmail.com> <675fa58d-bff3-d7e4-5fac-ecf1401932f4@jeffhostetler.com>
 <CAG6xkCbe+pLwTCButZGdPucHoRCq-a8mWfifd6z2bzGZNseE9A@mail.gmail.com>
 <ee5185b1-7820-b2ac-1bde-da1c761fa594@jeffhostetler.com> <CAG6xkCa_nKtzhJJq=v7gazWe+8FnN3mz1vDftzZw2WUFqJ1bzw@mail.gmail.com>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Tue, 20 Feb 2018 10:28:54 -0600
X-Google-Sender-Auth: IvMEiSqq578bpuYjFSGyZskoeZU
Message-ID: <CAHd499A+TT4zWPvW84B8XpmCdvoJCnSOZxY98MKZUO3h7cwo0g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Implement CMake build
To:     Isaac Hier <isaachier@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 25, 2018 at 6:21 PM, Isaac Hier <isaachier@gmail.com> wrote:
> Hi Jeff,
>
> I have been looking at the build generator, which looks promising, but
> I have one concern. Assuming I can generate a CMakeLists.txt that
> appropriately updates the library sources, etc. how do you suggest I
> handle new portability macros? For example, assume someone adds a
> macro HAVE_X to indicate the availability of some platform-specific
> function x. In the current Makefile, a comment would be added to the
> top indicating when HAVE_X or NO_X should be set, and that option
> would toggle the HAVE_X C macro. But CMake can test for the
> availability of x, which is one of the main motives for adding a CMake
> build. The current build generator uses the output of make, so all it
> would know is whether or not HAVE_X is defined on the platform that
> ran the Makefile, but not the entire list of platform that git
> supports.
>
> Bottom line: should I add the portability tests as they are now,
> without accounting for future portability macros? One good alternative
> might be to suggest the authors of new portability macros include a
> small sample C program to test it. That would allow me to easily patch
> the CMake tests whenever that came up. In a best case scenario, a
> practice could be established to write the test in a specific
> directory with a certain name so that I could automatically update the
> CMake tests from the build generator.

Isaac,

I'm very happy that you have started support for CMake. I have a lot
of experience with it. I'd love to help contribute. Do you have a fork
on github where this code is? I'd have to figure out how to apply a
patch from email, I haven't done it before. I think the goal should be
to replace the existing build system (this can be a transition that
happens slowly). I've been in situations where multiple build systems
are supported in parallel, worst case because of split personal
preferences on a project. That is more counterproductive than asking
the team to just compromise and take the initial hit on learning
curve. Ultimately that's up to the Git community, but that would be my
recommendation. But I think making CMake as complete as possible will
help build that confidence and trust. I can completely understand the
complexities and concerns they have.
