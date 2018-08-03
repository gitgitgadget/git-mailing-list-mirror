Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA3C31F597
	for <e@80x24.org>; Fri,  3 Aug 2018 16:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbeHCSsw (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 14:48:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46835 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbeHCSsv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 14:48:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id h14-v6so5973791wrw.13
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 09:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=z/+JbdR2jdEN1XEEPKeTuOahxkh103GDhFrqzVmLITg=;
        b=gJiIn5rXs23QYc5LIMuIy42rY1Hx3TulwDFHnVNsyveOZV0UQnIj4+gWd9cOVDrW9N
         +Bir5OYkZYXnVMg8EE3HjM8WHxqH0+uniqWQCeln4o942ZCO5mvAmhH+VuzR5pllldrU
         XesipE2USrsC4O2wGCbDVjI3SlhHAq4qg0mSNfgY2QVaT/18/4eYCQVPAVl9QNmM5Pef
         /SmgieXqtnxH0ayY/MpVr76emt5sbLjH6saubQmBiy+mWje654JzHopcv/+npv3zRQoS
         qdZU1KgAqnpT5Xtg96KxLO01ps7sxafC4DYNxa0zsoXEQPDVYAx7MolEnO5zSI5+WAF7
         yX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=z/+JbdR2jdEN1XEEPKeTuOahxkh103GDhFrqzVmLITg=;
        b=B+xXfOa0QV3x/0ylEis+GRQ4IWilN6CHkwsycyAA1mi/nXRY6gDVa/AAlOwZ2h7Uz8
         8XGtVPr1t+GNHgJrWX7vrOtSAvfA4U0BqT6Nu5DA8JtWbIkytrLZ0GKaHjmfdEkr7QIJ
         +XkgmhAkzh2iyfdSgZijBmXk75FjwTWTYwmZj5CJMXBzQhKmlg8aiA7ZmzPOPX96Mhlg
         lO5VbewZwR065rqUdMUPitip30BslLts7V6mi9Kfcpl8sTVjNdtpxfcIj1QR3JgOaTj0
         c6ST5CUfD1P1Xdiz1J+yUxspLkinZm0kcG/dxPxm3NJWFke4B4FQhgoKAEsBjMyE+YWe
         Y3Kg==
X-Gm-Message-State: AOUpUlGjFqvpq0Rm2ckSajoI1PIrVhi/0z9N5Zzh3OztJaMyg0nGRWPG
        C5q+ClEE+7LQ92OrpEsNHec=
X-Google-Smtp-Source: AAOMgpftXWEGkswmDkrZ53PsKM31lNvPyi9t0ULr35bEHVOaEsKh8BUj2cPb5cDZnHJh4UzNisdPtQ==
X-Received: by 2002:adf:ce88:: with SMTP id r8-v6mr3059430wrn.112.1533315104131;
        Fri, 03 Aug 2018 09:51:44 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 200-v6sm5054307wmv.6.2018.08.03.09.51.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 09:51:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>
Subject: Re: [RFC PATCH v5 0/4] add -p: select individual hunk lines
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
        <20180726155854.20832-1-phillip.wood@talktalk.net>
        <874lgjv8h0.fsf@evledraar.gmail.com>
        <d622a95b-7302-43d4-4ec9-b2cf3388c653@talktalk.net>
Date:   Fri, 03 Aug 2018 09:51:42 -0700
In-Reply-To: <d622a95b-7302-43d4-4ec9-b2cf3388c653@talktalk.net> (Phillip
        Wood's message of "Fri, 3 Aug 2018 11:01:38 +0100")
Message-ID: <xmqqy3dnxujl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> ... [I'm beginning to see why all the other programs I tried while
> writing this (tig, gitg, gitk and mercurial's version of add -i)
> don't make any attempt to stage modified lines correctly, though I
> think git should have some way of doing it.]

Yes, this is a kind of feature that one can propose and implement
something that works well for some of the limited cases one uses,
but not in other cases, and it becomes very hard to explain how to
work around the implementation limitation---that is why I stopped
at "split this hunk?" and did not go beyond it when I designed the
original "incremental add" feature.

I think the real reason why it is hard is that there is no good
definition of "modified" in "stage modified lines", and worse, there
is no good way to mechanically figure it out, because a patch only
gives you "these were deleted" and "these are added", without giving
you "this line in the deleted block corresponds to these two lines
in the added block" (i.e. "this original one line was modified into
this thing in the result").
