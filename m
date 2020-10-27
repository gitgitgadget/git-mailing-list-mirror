Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616FBC388F9
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 07:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 121F62225E
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 07:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508407AbgJ0Hys (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 03:54:48 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:36486 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508404AbgJ0Hys (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 03:54:48 -0400
Received: by mail-ej1-f68.google.com with SMTP id w27so861447ejb.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 00:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JVHSiNmW40XxhaDVQaB+aRSMGHVaI9NCWLNaw9l9ONg=;
        b=WsFqxVuFJmsrhe0MeA7kEGmtmd2aGQ3MovxDWllINZclYXHyalU0YKrdg3QCCM63t7
         I5SXqcmw4+ttRreOzQ6DL63J5dV5yEtE6CJvCCC9I11WXWUYY6HohzF0M1F3Mnmhf9mc
         sO5fPSG643rJOa0+pfy5qr2+zANY79rRCtGwT7mnwCOnvMA5FNFNfF408Z2+t7IL4x2W
         lzFrxhlD0ZmiipCmV3V1iKuqsXqBGn9Of2XyNG/jbT3otqVx0IynXcz06eFeWNGVNEvt
         YIR3pBQ8mdhO+MV9k9hKrZYAoVIJvsU5nr3fCpXHtlYCCqP7qt1VgZ9izexwrbMiMMwm
         oqsQ==
X-Gm-Message-State: AOAM533AzZRADqewlgwT3bY3FhJfKIcZK+6EV/x7Yee6x3jlHk2RJegJ
        yoatTHdqOTc/bxAjz1sGOIIhMLvrXgkRIfwEKDgZx1+u
X-Google-Smtp-Source: ABdhPJx1iT1nAoaCk2OIwyI+N+S+JkheFUo357EHGpHaX+zGJjAayWo5cOykwxrKX21HdlmMP7rhlHV4VwQwn3B6nHM=
X-Received: by 2002:a17:907:435b:: with SMTP id oc19mr1080453ejb.311.1603785286071;
 Tue, 27 Oct 2020 00:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <pull.895.v2.git.git.1603731448.gitgitgadget@gmail.com>
 <pull.895.v3.git.git.1603764490.gitgitgadget@gmail.com> <3357ea415e3437966f15bf73fbbeb21cda3df592.1603764490.git.gitgitgadget@gmail.com>
 <CAPig+cTkxP=aaCi8YrxbSYptkgwSYG_sd+P6FiXmtA6xuXxGSw@mail.gmail.com> <CABPp-BEGG7GYH=1dWnC_vxQimB07xPAQHWYcL=yk3rcYOk5SkA@mail.gmail.com>
In-Reply-To: <CABPp-BEGG7GYH=1dWnC_vxQimB07xPAQHWYcL=yk3rcYOk5SkA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 27 Oct 2020 03:54:35 -0400
Message-ID: <CAPig+cQ2e4NF6GhRvCTgt1KpPG5Lw_ybPM5FeWtmc69rxvXFuQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] merge-ort: barebones API of new merge strategy
 with empty implementation
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 27, 2020 at 12:57 AM Elijah Newren <newren@gmail.com> wrote:
> On Mon, Oct 26, 2020 at 7:33 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > You forgot:
> >
> >     git merge -s newren
> >
> > the "NEW Recursive ENgine" merge strategy. I won't bore you with some
> > other backronyms I came up with[1].
> >
> > [1] Such as "Extended LInear Jump AHead", "UNabashedly Smart High
> > INtelligence Eccentricity" and "UNsurprisingly SHallow and
> > INsignificant Exception". Oh wait, don't read this if you don't want
> > to be bored.
>
> Haha, those are great!  :-)  Maybe we should come up with one for TUFF?

This "stuff" writes itself: Transitive Unified Fundamental Finalizer

Actually, I quite like "Extended LInear Jump AHead"; it sounds like it
could be a genuine algorithm. "NEW Recursive ENgine" is also
reasonably good in that it's a drop-in replacement for the old
"recursive" strategy, although a bit generic as a name and doesn't
give an indication of the algorithm like "Extended LInear Jump AHead"
does (even if that algorithm is fanciful).
