Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEF641F453
	for <e@80x24.org>; Fri, 28 Sep 2018 16:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbeI1Wz1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 18:55:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53469 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbeI1Wz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 18:55:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id b19-v6so2830939wme.3
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 09:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ysEEeZ+5Y0H6+6NcxiBm9rW7JJ8KDuau0gCsDX8C9JM=;
        b=UXA4nfWj9kjIx381PMz4IxJOQVGMgqSOQhINDFQN95T83wvJRMGVNr7jEULlCd6yem
         j9y3+nAhlqWBaK01G9c6dHbw0LwdM4eVFmEGMxyqfHCeiT2tbMr4bHUzOW4wk/7F0oDE
         /NN8oyimVZZrUxCOOAn3n/gumYr1mwlRuWrmRZRgUfs78Bq0Xzd0veeZJIPLQXIDymV2
         0CLh5e1pu/TAsFNMCeeZ4ftxBcA/NEEW0gC51mVZCiVHQYA1ZqH+yMG5+Tdbfc47XAkU
         nnzuwt6GRMlBBGZWE7/uX8t2TMYCN+cWMApC/3gRFMwpNfc9G8GB+Yhob5bvmqjL4/fx
         Y5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ysEEeZ+5Y0H6+6NcxiBm9rW7JJ8KDuau0gCsDX8C9JM=;
        b=FXtv/LZyPpmjgm5bHv5QPue0e4+ldyaNhyNQzIcR5dbnfgn9rIQ6l8KNYrAk+imSxx
         qTc89iNWDfn66wQrS9ikbGKFTWkOIyQy6/NywpE40x3gYS9a0rrnxdCmGcjfJf6Lzn0j
         Vy4GEBadrlxwvCIa3vyBJsiQfyHVtzzqkpGeQFT4qf1+rZT5lezrqXKwVmiEugZInKQF
         4bQqnDVS71TIlYP5bg5345qyePo3pV1M9K5HGc/g7Vj+mvOUuqHBQz4n9sy1LlxW4iVO
         Q8J0VXEMu1RYFNNPR+Bzs0uoOg+G0P0yZIMKgTSjozDV600ES4zpYOUVP+GEy4DyGChL
         SvMw==
X-Gm-Message-State: ABuFfoj36HQe/iMsyfxsBNbYlG9ofYIq9m8UKyCg/1kCSecQoncqyXZy
        aW/OC/GGSNlPtDBYFzX2IpQ=
X-Google-Smtp-Source: ACcGV60XhRjM3Rs1I1r+Jni/dra1J1nGSnG1/FN/JGRGs2B8Aoz3McDW1FLCVmTmg2Bne2lpr7B1Sw==
X-Received: by 2002:a1c:1a49:: with SMTP id a70-v6mr2247701wma.91.1538152252715;
        Fri, 28 Sep 2018 09:30:52 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u191-v6sm2663896wmd.31.2018.09.28.09.30.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 09:30:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] git help: promote 'git help -av'
References: <20180922174707.16498-1-pclouds@gmail.com>
        <20180924181927.GB25341@sigill.intra.peff.net>
        <xmqq4leesjdc.fsf@gitster-ct.c.googlers.com>
        <CACsJy8D1EMCqvBdxbta4oocMF33jwDf1=opXwZ0aRN7LYu=JXg@mail.gmail.com>
        <20180925174451.GA29454@duynguyen.home>
        <xmqq8t3omam8.fsf@gitster-ct.c.googlers.com>
        <20180928023724.GA89283@syl>
Date:   Fri, 28 Sep 2018 09:30:51 -0700
In-Reply-To: <20180928023724.GA89283@syl> (Taylor Blau's message of "Thu, 27
        Sep 2018 19:37:24 -0700")
Message-ID: <xmqqefddeg90.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Sep 26, 2018 at 10:28:31AM -0700, Junio C Hamano wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>> > Here's the patch that adds that external commands and aliases
>> > sections. I feel that external commands section is definitely good to
>> > have even if we don't replace "help -a". Aliases are more
>> > subjective...
>>
>> I didn't apply this (so I didn't try running it), but a quick
>> eyeballing tells me that the listing of external commands in -av
>> output done in this patch seems reasonable.
>>
>> I do not think removing "-v" and making the current "help -a" output
>> unavailable is a wise idea, though.
>
> I think that your point about having to react in a split-second in order
> to ^C before we open the manual page for a command is a good one. So, I
> agree with this.

Responding to a wrong thread?  

I thought "now I need ^C within a handful of deciseconds if I want
only alias?" was not about the change to make "-v" default when
"help -a" is asked, but about what to do with "git foo --help" that
only gives "foo is aliased to ...".
