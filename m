Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16B381F404
	for <e@80x24.org>; Wed, 14 Feb 2018 01:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966382AbeBNBqg (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 20:46:36 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36986 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966364AbeBNBqe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 20:46:34 -0500
Received: by mail-wm0-f45.google.com with SMTP id v71so19242868wmv.2
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 17:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UvLqXDQtZt21r0ALbke8kdQf0+yAUqCOFI4iEJEkxWU=;
        b=jyV4VDSbHga4q+hJd957+ORUolV/2oXka8AWCWt9qMoc8+72VPJ1n3U7BZg3KyzFwf
         Nr//ILFywVCDXRt7uBCnnNGqoQOQrOuWjdeWuI5TcaEpS74M3hXSLOhRe+22kFHyukTL
         lv/dylHedNEYa/epUPREUh//YqCJlWExr0dBRWslQRe4hGxuJsrKxiw+LZfEq/FIreMt
         pzj3PE9GkfTOnUmj9FbEn6fFJ1k2rSDnqTrSOUaUcqgA5V5vECahGCOzhpwc6uEzGSvU
         X8KZIrnBpy5nIoPY1MbcuVtkvyWE1JGE6f5kjepHFQLSeUjCIaOj66nHyyYVcVzWFGL4
         hH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UvLqXDQtZt21r0ALbke8kdQf0+yAUqCOFI4iEJEkxWU=;
        b=iFT1x8lp+uVPqJoTbC2G8izjgbLRp/ix7+o3tFlsei1TJPDP2ukKb3gYDpC4ec1Wvn
         HTO6LqWpKQFWKVUJW5fMdj4tEACrQ/UZon6WVnUce2eVywiqS1RhfRoy9Cvrf6lM2JKg
         llO/hG76+4ANjDY3hMp9UCjbKIaycJQINJ85JTi8YAFpmN5LLMqDPd6zpNfofuc4ML6d
         bbfuDc0A1p6ZGD0TRdT4dxSXfICR+Ct8HA55xAkt+bMlikxvYZuE1p6IbOkVHCmmxQY5
         SH0CTawHGjuGrva3gty16i1xLK8ODKV9M8D1GF6bDUUWCeJK8LvG/mNY0/nJrfIEj77E
         NL5g==
X-Gm-Message-State: APf1xPDoZF03XWH0HUZ230cV6bAydj5TUqltsV34lQVhxAOPy/7LzBjx
        rqA2xa6Oje/TGcXY6eXvP8m04LnU0zjAxAr9BaM=
X-Google-Smtp-Source: AH8x224JhnSPhJDUvrQrzi2EHYgPLlYVv7AbUZT0QnqDM4Rknb7XvjfKTTVhBQN0Gy9rQw//fvOiRSBeKSKvqJUZiYQ=
X-Received: by 10.80.184.77 with SMTP id k13mr4592509ede.187.1518572793703;
 Tue, 13 Feb 2018 17:46:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.149.220 with HTTP; Tue, 13 Feb 2018 17:46:13 -0800 (PST)
In-Reply-To: <20180210122131.GB21843@sigill.intra.peff.net>
References: <c8d1eb4d-c3d2-5834-a46b-931e825315aa@gaspard.io>
 <20180208153040.GA5180@kitenet.net> <871af155-a159-2a29-2e48-74e7a98b60d4@gaspard.io>
 <87bmgzmbsk.fsf@evledraar.gmail.com> <fa470be4-75fb-76ed-ed93-5c10fcfb8842@gaspard.io>
 <87po5dbz1a.fsf@evledraar.gmail.com> <20180209223011.GA24578@sigill.intra.peff.net>
 <87e7c3b8-3b3c-1cb0-9b11-e4bf3044e539@gaspard.io> <20180210001317.GA26856@sigill.intra.peff.net>
 <3de8dec0-12c9-56e2-5902-97755f78ab50@gaspard.io> <20180210122131.GB21843@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 13 Feb 2018 17:46:13 -0800
Message-ID: <CA+P7+xr5FfP=mnkhgC1AjxLQn_=X3m5o4caGmqjePqqj9FEG6w@mail.gmail.com>
Subject: Re: Fetch-hooks
To:     Jeff King <peff@peff.net>
Cc:     Leo Gaspard <leo@gaspard.io>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Joey Hess <id@joeyh.name>,
        Git mailing list <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 10, 2018 at 4:21 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Feb 10, 2018 at 01:37:20AM +0100, Leo Gaspard wrote:
>
>> > Yeah, tag-following may be a little tricky, because it usually wants to
>> > write to refs/tags/. One workaround would be to have your config look
>> > like this:
>> >
>> >   [remote "origin"]
>> >   fetch = +refs/heads/*:refs/quarantine/origin/heads/*
>> >   fetch = +refs/tags/*:refs/quarantine/origin/tags/*
>> >   tagOpt = --no-tags
>> >
>> > That's not exactly the same thing, because it would fetch all tags, not
>> > just those that point to the history on the branches. But in most
>> > repositories and workflows the distinction doesn't matter.
>>
>> Hmm... apart from the implementation complexity (of which I have no
>> idea), is there an argument against the idea of adding a
>> remote.<name>.fetchTagsTo refmap similar to remote.<name>.fetch but used
>> every time a tag is fetched? (well, maybe not exactly similar to
>> remote.<name>.fetch because we know the source is going to be
>> refs/tags/*; so just having the part of .fetch past the ':' would be
>> more like what's needed I guess)
>
> I don't think it would be too hard to implement, and is at least
> logically consistent with the way we handle tags.
>
> If we were designing from scratch, I do think this would all be helped
> immensely by having more separation of refs fetched from remotes. There
> was a proposal in the v1.8 era to fetch everything for a remote,
> including tags, into "refs/remotes/origin/heads/",
> "refs/remotes/origin/tags/", etc. And then we'd teach the lookup side to
> look for tags in each of the remote-tag namespaces.
>
> I still think that would be a good direction to go, but it would be a
> big project (which is why the original stalled).
>

I want to go this direction, but the difficulty has always been
limited time to actually work on such a large project.

Thanks,
Jake

>> The issue with your solution is that if the user runs 'git fetch
>> --tags', he will get the (potentially compromised) tags directly in his
>> refs/tags/.
>
> True.
>
> -Peff
