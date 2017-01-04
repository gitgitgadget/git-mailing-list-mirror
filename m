Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4EE820756
	for <e@80x24.org>; Wed,  4 Jan 2017 23:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754824AbdADXKj (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 18:10:39 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:36300 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754514AbdADXKg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 18:10:36 -0500
Received: by mail-qt0-f181.google.com with SMTP id k15so266044987qtg.3
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 15:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hcw+PxVzDmPUKd9xg8fY1nBnFTW9+5mevcG14Oscgoc=;
        b=iNfC/524tSxOUu1zCgJ4o5MNKV2Pe2HZrs26IG8CGcmz9Gc8hWDtUVO98D+WL6IjFH
         4Q+575LHk2gANViAvpJfSJFaq7QICWVYQBgZRkTZCiRaUZ4O/lqOQiv+0k16tE5V87uL
         teYFMYdt37MUaPGJFJAPgRqDql2bss+PtzlYAVfyvJGP5YtOJGAi0vR6IMEx/woHjyGo
         +EMXtIAGY/Gj8vU70hs1O3dar9GkIlErKG7omtIpG1SQ1ORacn+MjyqnhuOeR73enJmR
         Udxmvkqwaxoh54yVOPuMMMz4Ad9WJ9OxSx1ctSQr/8a+ioLx0GwifWKb+kWwyjsgrK0b
         hC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hcw+PxVzDmPUKd9xg8fY1nBnFTW9+5mevcG14Oscgoc=;
        b=mPmLmo0uUNwcSuZDnhxf72AN/x8BCaZIn9hTMz9bknIPcqJO2peQW3BcV0NWxiqLdt
         KsJ6uzJY18v59iiPavy+wa9oldL6m7CegKsl5s93otsl7l9eM795CEQL+Yd/M2knz0yx
         zzHV7jxPVV22sWUIiAyjSo2Gpu7V8KmfoEIxbEwq2OxXGXQasu7nvedwwayFSZD9QZJy
         8GsJ6kOOisxUzwSMGFta0EHGPZw0//7yonLlynsKfsbXCnI1Pho4QUvpHce5brfqR9KA
         jJGWIU5z0q4/B/RfWwyd7TYmWoA+uCx0PvnUOfEx1mWjmQUTyZhSrsDmdn62HfiD/Zka
         YrQA==
X-Gm-Message-State: AIkVDXKA+uOHXAzGUo0Qi07TqWpufvPXK4U7L0AZSBbcw41omZIffqQJEUV0oaNKMynBvMrFHi9MFB0/JsLKq3WY
X-Received: by 10.200.58.65 with SMTP id w59mr61870758qte.54.1483571415301;
 Wed, 04 Jan 2017 15:10:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Wed, 4 Jan 2017 15:10:14 -0800 (PST)
In-Reply-To: <20170104075506.sa5oa5bheykswkwn@sigill.intra.peff.net>
References: <20170104014835.22377-1-sbeller@google.com> <20170104014835.22377-3-sbeller@google.com>
 <20170104075506.sa5oa5bheykswkwn@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 4 Jan 2017 15:10:14 -0800
Message-ID: <CAGZ79kagAX-ZjO_k7LxQNHp=Le9C=WzYQxxe-bRFneHjDwnqSw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pathspec: give better message for submodule related
 pathspec error
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 3, 2017 at 11:55 PM, Jeff King <peff@peff.net> wrote:

> As this last bit is quoted from me, I won't deny that it's brilliant as
> usual.

obviously. :)

>
> But as this commit message needs to stand on its own, rather than as part of a
> larger discussion thread, it might be worth expanding "one of the cases"
> here. And talking about what's happening to the other cases.
>
> Like:
>
>   This assertion triggered for cases where there wasn't a programming
>   bug, but just bogus input. In particular, if the user asks for a
>   pathspec that is inside a submodule, we shouldn't assert() or
>   die("BUG"); we should tell the user their request is bogus.

alt. cont'd:

We already would do that if PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE
is set, but we had to ask for this examination via a flag, because
it is expensive. At this point in code we know there is bogus input,
so all we would do is error out. For that case we can assume that the cost
of the expensive search is negligible compared to the users head scratching
that follows.

(This will appear in the patch I am about to send out)
