Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86E831F428
	for <e@80x24.org>; Sat, 30 Dec 2017 12:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750806AbdL3MdL (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Dec 2017 07:33:11 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34587 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbdL3MdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Dec 2017 07:33:09 -0500
Received: by mail-wm0-f65.google.com with SMTP id y82so8175334wmg.1
        for <git@vger.kernel.org>; Sat, 30 Dec 2017 04:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:subject:references:wfrom:user-agent:in-reply-to:from:date
         :message-id:mime-version:content-transfer-encoding;
        bh=MpjcoHb95Z0ATJGw88gdp97pA3MOcpuW951w8iR7Juw=;
        b=pX3Cz9jfox8b8wNtlI/o3zbfkeJtXh9EkmhRwRWMkYg49FRDIYoKHdpAL9SoxjcJKx
         blLFB77ju8U0DP54h1ErXDvzF7k1gRx6gIjdzM/oRhekAgPrC4v83t4coszkGy0owcXr
         1b/JavC+xv2vNVSJ3024w1ljESR9olr+d9OJQ4JJOnKdUPppU2fDwsZRI1PrDCJvbzUQ
         1QC3oEs6+OuzThbc7MMbqTBsySeYOdYXbKPJs87JfpEbsBsQ/oeNcYSY2+wo58BFvSAH
         NRHIYFzk2vK/08cF22t1Z8j1zKuYFNj7BsWOSsBJDnwNpoPf5+v4H6NIdcEfXXXi7DP4
         s+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:subject:references:wfrom:user-agent
         :in-reply-to:from:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MpjcoHb95Z0ATJGw88gdp97pA3MOcpuW951w8iR7Juw=;
        b=jFWDNrFUYTGWRh2Xee/ZuvoA7y4iqrVooxa/tpE88oOCdmQMoZsVlSOkwuYZmN9nal
         Zog3tMfpiCfnnuxNqE1vzSjTDTkB7wNPWFNPhI7YB4FwUQqgiWmwxWTQ2wrzocawzSO0
         rmPBbXqP/3pEErkxPAuacneJvwlO9XpGxEFKGCUNwoHCt/GXX3jc5rzUOi+JNOfAoeYW
         LtM9Z9bZ6yEgOU7RRX5PjitvxZ4N+lHDoZXg6P9FDY1+XT1iRyfzauD3MVILARp6KJoc
         YTjSXIa5N8RPfUcc3fp/V1/4S1cVLlhRUIW3pAk7BP/MhRLEzc1LXma+X7Pooe80lxen
         YjWQ==
X-Gm-Message-State: AKGB3mKzAwjEBX/IhTV/Ivmzai1Jjjp7PyCYHXZlHaAN6ueRuF/Eq3Ru
        UbxGy4lwxew1wQlGWgSiVQY=
X-Google-Smtp-Source: ACJfBoueNus9pzihGUaTR2bE2ZsAnqpdJlj2DvJt3uF4Jj8id+9oQ1KINUw3WyjSKjrAyB26ORIGVg==
X-Received: by 10.28.63.14 with SMTP id m14mr29634041wma.116.1514637188446;
        Sat, 30 Dec 2017 04:33:08 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id 47sm68182131wru.27.2017.12.30.04.33.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Dec 2017 04:33:07 -0800 (PST)
To:     Jeff King <peff@peff.net>
Cc:     Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, Zefram <zefram@fysh.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] diff-tree: obey the color.ui configuration
References: <87zi616vgf.fsf@evledraar.gmail.com> <20171229225121.13805-1-avarab@gmail.com> <20171229231631.GS3693@zaya.teonanacatl.net> <20171230015533.GA27130@sigill.intra.peff.net>
wFrom:  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171230015533.GA27130@sigill.intra.peff.net>
From:   avarab@gmail.com (=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason)
Date:   Sat, 30 Dec 2017 13:33:06 +0100
Message-ID: <87tvw875vh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Dec 30 2017, Jeff King jotted:

> On Fri, Dec 29, 2017 at 06:16:31PM -0500, Todd Zullinger wrote:
>
>> Ævar Arnfjörð Bjarmason wrote:
>> > No idea how to test this, in particular trying to pipe the output of
>> > color.ui=never v.s. color.ui=auto to a file as "auto" will disable
>> > coloring when it detects a pipe, but this fixes the issue.
>>
>> You might be able to use similar methods as those Jeff used
>> in the series merged from jk/ui-color-always-to-auto:
>>
>> https://github.com/gitster/git/tree/jk/ui-color-always-to-auto
>
> Yeah, test_terminal is the solution to testing. But...
>
>> He may also have some ideas about this issue in general.
>> (Or they could be tramatic memories, depending on how
>> painful it was to dig into the color code.)
>
> Yep. If we make diff-tree support color.ui, it's going to break a bunch
> of other stuff (like add--interactive) for people who set color.ui=always.
> I know this empirically, because we did that in v2.13, and a bunch of
> people complained. ;)
>
> The root of the problem is that the plumbing diff-tree defaults its
> internal color variable to "auto" in the first place. In theory the best
> way forward is fixing that, but it's likely to have a bunch of fallouts
> itself (scripts which use plumbing and where the user _does_ want color
> will stop showing it). This bug has been around since v1.8.4, I think,
> so it's hard to say how many people are depending on it at this point.
>
> A hackier option which would probably make most people happy would be to
> have plumbing respect "color.ui=never", but not any other values.
>
> I think the history of the back and forth is:
>
>   - 4c7f1819b3 (make color.ui default to 'auto', 2013-06-10) introduced
>     the problem of plumbing defaulting to "auto". This was in v1.8.4.
>
>   - we did something similar to Ævar's patch in 136c8c8b8f (color: check
>     color.ui in git_default_config(), 2017-07-13). That shipped in
>     v2.14.2, and people with color.ui=always complained, because things
>     like add--interactive broke for them.
>
>   - we tried fixing it with 6be4595edb (color: make "always" the same as
>     "auto" in config, 2017-10-03), but that broke people doing "git -c
>     color.ui=always" as an equivalent of "--color". We talked about
>     making the "-c" config behave differently from on-disk config, but
>     got pretty disgusted at the weird hacks. And so...
>
>   - we ended up with 33c643bb08 (Revert "color: check color.ui in
>     git_default_config()", 2017-10-13), which just reverts the whole
>     mess back to the pre-v2.14 state. This shipped in v2.15.

Thanks. What a mess.

I haven't tried that add-interactive case you mentioned, an earlier
version of this patch where I tried adding the color detection in
git_diff_basic_config() did break one of its tests, but not my ptch, but
it's probably still broken with =always (haven't tested.

> So I don't think we want to go down that road again. If anything, we
> want to either fix the original sin from 4c7f1819b3, or we want to do
> the "respect only never" hack.

Getting back to the bug report that prompted this whole thing, wouldn't
the easiest solution just to run "git show --stat $commit" instead of
"git diff-tree --pretty $commit" when bisect wants to report the commit
it found?

I've always thought the output was a bit ugly, it's plumbing command, so
why wouldn't we just show the commit as the user usually prefers to see
commits?
