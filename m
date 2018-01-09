Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EA101F406
	for <e@80x24.org>; Tue,  9 Jan 2018 14:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755429AbeAIO3f (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 09:29:35 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:41595 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753201AbeAIO3e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 09:29:34 -0500
Received: by mail-qt0-f177.google.com with SMTP id i40so17984155qti.8
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 06:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=duQ2dKrBwf87kEMRvkOF4F4Yo4cNpFimzNYtRu7gpb0=;
        b=aNtBCuS0gYG2RKnm3U4S5vu6gu+pxCRRRQ82uNAdePAcf6nHcWXvdiC60w3SuPgO8D
         AVLRhRf7TxAjew+xQSNKZGsoyUL7J3L3JqYqs636Nsxmk3g5dOsrj89VVpCOlrYphTG9
         M+s2Bke7WA1YvZsFBhRtSu5bWtQBf7JMpBTd0hmcvgUDCkaCMSIH9tMag7++Ut9RNbtl
         314MpndGy3u24QhgSJY2+uCMJKhLaFVc9bN6iSsUPOL3oEwEUt9rN7jD6u6yIKAyQ6pa
         PyeiwbYS7M5vfwlMZT3x0FzrsWyScfrPzI6J/tU0guGyUPaCB/Vn0Uym14CjELbk9BnL
         /u4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=duQ2dKrBwf87kEMRvkOF4F4Yo4cNpFimzNYtRu7gpb0=;
        b=g7nd3I8DcA3HwfKRaEvEPi1db38Ft8Ot27jqY1nlDK7aAph8+0jabvlXlA2kXIh+Lr
         +gmYooMthJ7HinexDB4/54DfEEjQU8LBEuk7l6A2pc97qFBiB4sl2DUANldo6dl6tKqg
         9oD5tlJ3NbOyrqmvO3IE4ZmcLi1VMb0+QO1BcJq/zqhIfZfiy00ZiIOJgCPdqdFF0+p0
         YHpOdjxMrZeiyGHuFsagwXi+GDXuNXPQ7oefgHWfVyAXHoD8jGivGATo7h2Oa24glKtu
         Fpq7ZxGbMWMRS004cD9Hyl4EJeCbDKn+x1ua7kCZfEiYBKshFZn5es+adODqJM1gmYip
         dGhg==
X-Gm-Message-State: AKwxytdAEDeDK1st/g2rdgBUFdKkmQHTqfBmm60SNqG5K+Ax/jx4Hv+w
        c5U4fN+eYeFZytPIEhqxRW4=
X-Google-Smtp-Source: ACJfBot+Ww9CzR+vyHIg1Fa44d0JonpCxm+d4vj+irnQSQ0FNsUrF7vatWQzUBwP9fznlgoP028Awg==
X-Received: by 10.200.19.202 with SMTP id i10mr22227251qtj.117.1515508173258;
        Tue, 09 Jan 2018 06:29:33 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id y65sm9287036qke.24.2018.01.09.06.29.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jan 2018 06:29:32 -0800 (PST)
Subject: Re: [PATCH v4 0/4] Add --no-ahead-behind to status
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, Jeff Hostetler <jeffhost@microsoft.com>
References: <20180108154822.54829-1-git@jeffhostetler.com>
 <7b759564-5544-8845-0594-e8342a0b4ba5@gmail.com>
 <8affe37c-d937-d7e0-fe06-cf7c8db173fa@jeffhostetler.com>
 <20180109072044.GD32257@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1801091407480.37@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c19f6469-190a-33e7-20a2-fcb17b8e45d9@gmail.com>
Date:   Tue, 9 Jan 2018 09:29:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1801091407480.37@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/9/2018 8:15 AM, Johannes Schindelin wrote:
> Hi Peff,
>
> On Tue, 9 Jan 2018, Jeff King wrote:
>
>> On Mon, Jan 08, 2018 at 03:04:20PM -0500, Jeff Hostetler wrote:
>>
>>>> I was thinking about something similar to the logic we use today
>>>> about whether to start reporting progress on other long commands.
>>>> That would mean you could still get the ahead/behind values if you
>>>> aren't that far behind but would only get "different" if that
>>>> calculation gets too expensive (which implies the actual value isn't
>>>> going to be all that helpful anyway).
>>> After a off-line conversation with the others I'm going to look into
>>> a version that is limited to n commits rather than be completely on or
>>> off.  I think if you are for example less than 100 a/b then those numbers
>>> have value; if you are past n, then they have much less value.
>>>
>>> I'd rather do it by a fixed limit than by time to ensure that output
>>> is predictable on graph shape and not on system load.
>> I like this direction a lot. I had hoped we could say "100+ commits
>> ahead",
> How about "100+ commits apart" instead?

Unfortunately, we can _never_ guarantee more than 1 commit ahead/behind 
unless we walk to the merge base (or have generation numbers). For 
example, suppose the 101st commit in each history has a parent that in 
the recent history of the other commit. (There must be merge commits to 
make this work without creating cycles, but the ahead/behind counts 
could be much lower than the number of walked commits.)

>
>> but I don't think we can do so accurately without generation numbers.
> Even with generation numbers, it is not possible to say whether two given
> commits reflect diverging branches or have an ancestor-descendant
> relationship (or in graph speak: whether they are comparable).

If you walk commits using a priority queue where the priority is the 
generation number, then you can know that you have walked all reachable 
commits with generation greater than X, so you know among those commits 
which are comparable or not.

For this to work accurately, you must walk from both tips to a 
generation lower than each. It does not help the case where one branch 
is 100,000+ commits ahead, where most of those commits have higher 
generation number than the behind commit.

> It could potentially make it possible to cut off the commit traversal, but
> I do not even see how that would be possible.
>
> The only thing you could say for sure is that two different commits with
> the same generation number are for sure "uncomparable", i.e. reflect
> diverging branches.
>
>> E.g., the case I mentioned at the bottom of this mail:
>>
>>    https://public-inbox.org/git/20171224143318.GC23648@sigill.intra.peff.net/
>>
>> I haven't thought too hard on it, but I suspect with generation numbers
>> you could bound it and at least say "100+ ahead" or "100+ behind".
> If you have walked 100 commits and still have not found a merge base,
> there is no telling whether one start point is the ancestor of the other.
> All you can say is that there are more than 100 commits in the
> "difference".
>
> You would not even be able to say that the *shortest* path between those
> two start points is longer than 100 commits, you can construct
> pathological DAGs pretty easily.
>
> Even if you had generation numbers, and one commit's generation number
> was, say, 17, and the other one's was 17,171, you could not necessarily
> assume that the 17 one is the ancestor of the 17,171 one, all you can say
> that it is not possible the other way round.

This is why we cannot _always_ use generation numbers, but they do help 
in some cases.

>> But I don't think you can approximate both ahead and behind together
>> without finding the actual merge base.
>>
>> But even still, finding small answers quickly and accurately and punting
>> to "really far, I didn't bother to compute it" on the big ones would be
>> an improvement over always punting.
> Indeed. The longer I think about it, the more I like the "100+ commits
> apart" idea.
>

Again, I strongly suggest we drop this approach because it will be more 
pain than it is worth.

Thanks,
-Stolee
