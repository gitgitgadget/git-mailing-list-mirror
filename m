Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E65C202AC
	for <e@80x24.org>; Fri,  7 Jul 2017 09:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750883AbdGGJyU (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 05:54:20 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:36383 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752123AbdGGJyT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 05:54:19 -0400
Received: by mail-wr0-f177.google.com with SMTP id c11so39361249wrc.3
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 02:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=asF2greNkwvrzziGRsd39MAhBz6qZm48SYbPFPra96s=;
        b=Zdga6o/L3DF8k63U38bBZP4WJwNuyO8gA8Cfu8t7p55AV07kIjIjNL8JXZOKSdISfK
         ujOBxmlvjl9UpRgWG8zDJ+s8+0+EbNiS0OMW0ZHu42bYh/I2+gxHpfabx2Fs+2HcKPK/
         mK+BWtwgzMH08rYZOMV9qeE9X8muW/3miW9K+X/Pm5NQKfIVPrJYnAT6tghBxzMGY9mS
         HITy07BbSUylALbXcWL3LyCBXI9HomiCXFvXVbPAHwiePLq+InsOOxdI//Pn96EqQ5Fu
         4HDRKvM7iCHstT50OFT8ratEFYF0nD5KIMxwWNvOEhA0SIjtPH3D4XGYoVzB9y9mmDBt
         U2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=asF2greNkwvrzziGRsd39MAhBz6qZm48SYbPFPra96s=;
        b=OkGKWF3J8+xZrz9UHnhM+oWbstnrtRsj1wlJD6+USK2Y+YRo4dchUAXs92C6bo2RFP
         8U9e4gUK5u3f7uy5dHhn057t+yIdm2Bvb3wsoNWOW+S+xRNOuivCsO6CwAw3SHaCWU4A
         buEmlgD5UgPdtM9ApmvPn9/PaMY99NuuhmBm5Jh8Kh400bezubDbC7ug7q+kc6V0bS7x
         TQMrdf80v4EVFhXzSh/SGHvJI//8mLVg4BJufJAZz43f2DuS0ZeQFxlbQgepYhaMXINc
         or+xSgJktjrz9rGVDPUzkPLN8J7MN1EWccfQJum1Gu/W5v4jZyoZC7UhuOObBBlX8uxd
         AD/w==
X-Gm-Message-State: AIVw112oST6k6bURljrA/+kEjsTd9qWsJ77nNdBgX0WKTK1rI2dXIX5y
        BuIy/CAKuSXSAQ==
X-Received: by 10.223.182.170 with SMTP id j42mr270701wre.87.1499421258053;
        Fri, 07 Jul 2017 02:54:18 -0700 (PDT)
Received: from snth ([5.57.20.48])
        by smtp.gmail.com with ESMTPSA id o131sm3139097wmd.26.2017.07.07.02.54.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jul 2017 02:54:16 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dTPxn-0005ac-TK; Fri, 07 Jul 2017 11:54:15 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stefan Haller <lists@haller-berlin.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Mike Rappazzo <rappazzo@gmail.com>,
        Francesco Mazzoli <f@mazzo.li>
Subject: Re: [PATCH] push: disable lazy --force-with-lease by default
References: <xmqq37a9fl8a.fsf_-_@gitster.mtv.corp.google.com> <1n8sh3u.1lsabkd1pislrwM%lists@haller-berlin.de>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <1n8sh3u.1lsabkd1pislrwM%lists@haller-berlin.de>
Date:   Fri, 07 Jul 2017 11:54:15 +0200
Message-ID: <8760f4bmig.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 07 2017, Stefan Haller jotted:

> Junio C Hamano <gitster@pobox.com> wrote:
>
>> It turns out that some people use third-party tools that fetch from
>> remote and update the remote-tracking branches behind users' back,
>> defeating the safety relying on the stability of the remote-tracking
>> branches.
>
> Third-party tools are not the only problem. They may make the problem
> more likely to occur, but it can also happen without them. (See below.)
>
>> Let's disable the form that relies on the stability of remote-tracking
>> branches by default, and allow users who _know_ their remote-tracking
>> branches are stable to enable it with a configuration variable.
>
> I'm wondering if people who claim they know they are safe really do.
> Elsewhere in the other thread somebody said "I only ever explicitly
> fetch, so I know I'm safe". Are you sure?
>
> Consider this example:

Both of your examples explicitly fetch. Yes this could be confusing to
someone who doesn't understand that "git fetch" doesn't just fetch the
current remote branch, but all branches.

> What I'm getting at is that there's a lot of things that you have to
> remember to not do in order to make --force-with-lease without parameter
> a useful tool.

Fully agreed, it's confusing, but it's less shitty than --force.

The concern I have with Junio's patch above (but I like Francesco
Mazzoli's approach better) is that the safety of the various --force
options, from least safe to most safe, is:

 1. --force: You blow away the remote history, no idea what's there, or
    if your local ref mirrors what you just wiped.

 2. --force-with-lease: Even if you have a `git fetch` in the
     background, at least if you wipe a remote ref you have a copy in a
     local reflog to restore it.

 3. --force-with-lease=master:origin/master: More explicit, but still
     subject to the caveat with background fetching.

 4. --force-with-lease=master:<manually copied sha1>: You know exactly
     what you're wiping, and have likely reviewed that exact commit.

Yes, #4 is the safest, #2 & #3 are similar but subject to various
caveats with background fetching / users not realizing "git pull"
fetches everything etc.

But I think we have to keep our eye on the ball here. Which is to enact
a net increase in user safety.

Right now most users who want to force a remote branch just use
--force. E.g. Stack Overflow shows >100k results for git + --force, but
just 500 for git + --force-with-lease.

You and others are rightly pointing out that --force-with-lease has lots
of caveats, but that as an argument-less flag is something we could
(with Francesco patch) turn on by default as a --force replacement.

This would leave users better off than they were before, because now
when they accidentally wipe something they at least have a local copy if
they did the wrong thing.

Moving everyone from #1 to #2 would be a net increase in user safety
without more complex UX. Not having #2 would, for a lot of users who'd
otherwise be happy to use #2, mean they'll just use #1 (the least safe
option!) instead of the more ideal #4.

Which is why I think we should take Francesco's patch (with fixes from
feedback), instead of Junio's.
