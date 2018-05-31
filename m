Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B62491F51C
	for <e@80x24.org>; Thu, 31 May 2018 07:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753934AbeEaHFh (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 03:05:37 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34495 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753846AbeEaHFg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 03:05:36 -0400
Received: by mail-wm0-f66.google.com with SMTP id q4-v6so1658259wmq.1
        for <git@vger.kernel.org>; Thu, 31 May 2018 00:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6OLFhLSnZVuyU6XDqSRWnA1DyW8Nux/3J9+MQ00S5fI=;
        b=AmtWdn49lSFft93Ms2seaG5CBIH3gUonDSurUd9Yu3/AwdpOcmQRxG/TX8srsx/EwQ
         gB0JgZUfkNj08XPGbE94H2lFL/A87dRT5cX+iv0ENJjO6vk1k5KE5l1akRgLwyI6+b46
         /T7ZMTmN/ApswUXdRNdMpZ5hEyk06PxVsAXkAz1vIsE6zNbkXQf9cmuT391mLP7WzMAF
         1FwDi71tfjwPwIMhqdYudu1cdc5qkeTImzjh97PutBAEK6zJ0l8uo1Hg/V3S70kHll0n
         AIYUrSyrcx+JTr3q4AwPLjK7C6EbLqObQOcKXzQzlo1e+pfgWs1jixTmLR57YuWaertf
         GslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=6OLFhLSnZVuyU6XDqSRWnA1DyW8Nux/3J9+MQ00S5fI=;
        b=kXsLhdE+j4Fdk6uCY51rgDbx0YQFNlXbuhKHIa1BfTKjOodUO4ngJhYjWqKRzzGRc/
         VVb5wGoYj3xz184QnUmRGuluPv5DpyV94Tyrdn44e5TphHB3ay/YksLnftg3BgxDuuiU
         jKFYxlwVTTSTSBlTGdi9Lhio2flTQ1T1qRg/xwtkosZsfOEBKtv9dFZkQYlnYyDVUmJV
         GXrCniBW+CQ+RJ3R2tn0jmkXnPjLHce8PNAxKbXMWIWWH2v/gwHCS1aGS/yhVsWBA44E
         lgj+ZUwO1u1VCA+T0izWlXNolGuC8rlfTcC8Xajo8XtCrnXhw326+vDBQZVP21T31uzs
         tVfg==
X-Gm-Message-State: ALKqPwfiyvtA066Jqq3yw5uV2PecK1eccXC+fOWRWZpafmOB/R3zv/IT
        mI79IFVM7odiDxGtcXYd9Pg=
X-Google-Smtp-Source: ADUXVKIROhdJpFKIMsdKgCAUjTPiYNwzIVhomXTprFR1lypQGFL54/sTa5nRd3uNe4z8/pRmlWiUIg==
X-Received: by 2002:a50:a306:: with SMTP id 6-v6mr6588598edn.292.1527750335303;
        Thu, 31 May 2018 00:05:35 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id e56-v6sm9937258edb.31.2018.05.31.00.05.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 00:05:33 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 4/4] color.ui config: add "isatty" setting
References: <20180530210641.19771-1-avarab@gmail.com> <20180530210641.19771-5-avarab@gmail.com> <20180531053810.GD17068@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180531053810.GD17068@sigill.intra.peff.net>
Date:   Thu, 31 May 2018 09:01:49 +0200
Message-ID: <874liofgv6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 31 2018, Jeff King wrote:

> On Wed, May 30, 2018 at 09:06:41PM +0000, Ævar Arnfjörð Bjarmason wrote:
>
>> A co-worker of mine who was using UNIX systems when dinosaurs roamed
>> the earth was lamenting that kids these days were using tools like
>> "git" that thought they knew better than isatty(3) when deciding
>> whether or not something was a terminal, and the state of the
>> documentation fixed earlier in this series certainly didn't help.
>>
>> So this setting is a small gift to all the UNIX graybeards out
>> there. Now they can set color.ui=isatty and only emit fancy colors in
>> situations when the gods of old intended, not whatever heuristic we've
>> decided to set "auto" to.
>
> I'm having trouble thinking of a case where anybody would actually
> care about the distinction between these two.
>
> If you're not using "-p", then colors will kick in if isatty() is true.
> The whole "also check the pager" thing is only because we may check the
> color isatty() after starting the pager. If we didn't, then nobody would
> ever see color. If your pager doesn't understand color, then fine. Tell
> Git not to send it color with color.pager=false.
>
> If you are using "-p", we might send color to your pager even though you
> weren't originally going to a terminal. But either your pager can handle
> colors, in which case this is fine, or it cannot, in which case you
> would already have needed to set color.pager as above to un-break all of
> the non-p cases.
>
> Is there some case where a pager can only handle color if _it's_ output
> is going to a tty, and otherwise not?

Maybe I'm missing something but how is that something we can deal with?
We just:

 1. use isatty() to see if we're attached to a terminal
 2a. If yes and no pager is invoked (e.g. git status) and "auto" we use colors
 2b. If yes and we're invoking a pager (e.g. git log) and "auto" we use colors
     3b. At this point we're writing to the pager so isatty() is false,
         but we set our own GIT_PAGER_IN_USE and turn on colors if "auto"

I suppose we can imagine a pager that sometimes emits to a terminal and
sometimes e.g. opens a browser with the output, and we could ourselves
somehow detect this...

> And you'd want color predicated on
> whether the original output was a tty or not, even if you said "-p"?
> That's the only case I can think of where the existing config is not
> sufficient, but I'm having a hard time envisioning a practical use.
>
>> As noted here this is *currently* the same as setting color.ui=auto &
>> color.pager=false, but I think it's good to explicitly have this
>> setting for any future changes. The reason, as now noted in the
>> documentation is that the "auto" setting may become even smarter in
>> the future and learn even deeper heuristics for when to turn itself on
>> even if isatty(3) were returning true.
>
> Are we actually thinking about teaching it deeper heuristics? I think
> the fact that it _is_ based on isatty() is meant to be understood by the
> user, and we wouldn't want to change that. True, there is the pager
> exception, but the point of that is to maintain the "are we going to a
> tty" model, even in the face of sticking a pager in the middle.

As noted in the cover letter I started writing this whole thing before
understanding some of the subtleties, and now I think this "isatty"
thing is probably pretty useless, and was wondering if others wanted it.

Reasons to take it are:

 1) To make user intent clearer. I.e. we could just also make it a
    synonym for color.ui=auto & color.pager=false and those used to
    isatty semantics skimming the docs would more easily find the right
    thing.

 2) If there are any cases where isatty() is true, but we can detect via
    other means (e.g. inspecting other env variables) that non-pager
    output can't handle colors some of the time. Of course if we find
    such cases isatty() would suck more, but that's presumably what
    isatty() purists want :)

