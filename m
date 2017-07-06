Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A65A202AB
	for <e@80x24.org>; Thu,  6 Jul 2017 15:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751751AbdGFPmv (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 11:42:51 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34993 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbdGFPmt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 11:42:49 -0400
Received: by mail-pf0-f195.google.com with SMTP id q85so761691pfq.2
        for <git@vger.kernel.org>; Thu, 06 Jul 2017 08:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MLKDaMofDyN48zgfc0cbSfakFG/JGh0wNnCUasKdgXE=;
        b=XTFT8txTuiJjv9Spoo1KOYXdTneNzIrgT0qmimxdu7glJYW5hPmRYc44oY28Wydwjx
         zvCg7NYcLOxaXqNQwVxqC1hgfTz/OJuJG9FT/UZ0BGd7ENGKQaw0aoEwZ2J/yeMJ9iqO
         /CuVBYTNS3zWiFFBKEC8ESGsvWi3alE3rU/S9VaFxbMa6c2TbLXQ/FkI4q7x82oXtB/B
         3tBfE5MOf8IKkE5QOO/Bn3tsHP33nkuqLb3KoDsb5rLSncc8gYRyL1GN1UXm3YKVdoXo
         2tfQndKVmreq80tJQKLz/G146tKjSYl+IVRcz70Z22JUex33uSo+3PhuqgHVZpgxIfnZ
         LwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MLKDaMofDyN48zgfc0cbSfakFG/JGh0wNnCUasKdgXE=;
        b=L1pvzCqFXIfLKgSafYPsJ2oFIDDyUJKcXx+0doBc0Y8tYX6d9rIMJCC8FREIbkaJuh
         3EX8LNQYkkADW7MFTjzZ4ypBy3jC4mUwIqpHsWA/hxRpwoTWiqbcUwK4NW2YNLbG0FXj
         vFHUhbc1gWqkSKGQkGQMQYqvbQlnuAQ42fTa/Ty/p7WzTvU7eSYAyKN0rQ1PgCWSU47z
         mfPUkaCKuequjUcA2e0RT6Rt4p8npgcQ9Lqw/ZpRm4gFP3F6wCVDjsNP5U13FOKmB4nY
         FK82Obrpx6EoOWK1e1i5EdEldRKn7j9H4OAYO0vgkQ82wFVFqZE4O/KR258HodaCRsl0
         xB1Q==
X-Gm-Message-State: AIVw110Fy2g9xDDtzZiu9IhqFa4U4V0sfvZMp59qaT7adHLsuxzk2xjo
        WCYdEKlZe5M793GpCr0=
X-Received: by 10.84.233.131 with SMTP id l3mr29455168plk.298.1499355769054;
        Thu, 06 Jul 2017 08:42:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f878:6796:f790:dc38])
        by smtp.gmail.com with ESMTPSA id e13sm813833pfh.96.2017.07.06.08.42.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 06 Jul 2017 08:42:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>
Subject: Re: [PATCH 2/6] t1414: document some reflog-walk oddities
References: <20170705075508.c5ul23vivzpklpy6@sigill.intra.peff.net>
        <20170705080036.qxzy7havcy72mvff@sigill.intra.peff.net>
        <xmqqh8yqix7p.fsf@gitster.mtv.corp.google.com>
        <20170705212757.3ygxiasbi2e7v27p@sigill.intra.peff.net>
        <xmqqa84ih5ao.fsf@gitster.mtv.corp.google.com>
        <20170706071606.doxirwm6cqx3duzg@sigill.intra.peff.net>
Date:   Thu, 06 Jul 2017 08:42:45 -0700
In-Reply-To: <20170706071606.doxirwm6cqx3duzg@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 6 Jul 2017 03:16:07 -0400")
Message-ID: <xmqq1spth8qy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jul 05, 2017 at 03:45:03PM -0700, Junio C Hamano wrote:
>
>> > I did make the ordering intentional. We process each reflog sequentially
>> > in turn. I don't think it would be wrong to interleave them by date, but
>> > I actually think it's useful for somebody who switches that behavior to
>> > consciously update the test. Maybe it's worth calling out in the commit
>> > message.
>> >
>> > I stopped short of actually documenting and guaranteeing that behavior
>> > to the user. I don't know how comfortable we would be changing it later.
>> 
>> I somehow feel that the "showing all entries from HEAD and then
>> showing all from side" is simply a buggy behaviour.  I do not think
>> our users would terribly mind if we changed it later.  But I may be
>> missing the reason why (sometimes?) the sequential behaviour may be
>> useful.
>
> If we think it's buggy, we can fix it now. But I'm not convinced that
> sequential iteration is that bad. It's at least _simple_ and easy to
> explain.

Yes, I agree that sequential is easy to explain, but only when I
consider use of "log" family without "-n 30" or "--since 3.days".
It still is easy to explain---we show from one and then from the
other, but because we stop after showing 30 of them, and the first
one has more than that, you do not see any from the latter.  

It's just the easy-to-explian behaviour is not very useful and very
hard to defend.

> The only other thing that would make sense to me is sorting the
> entries by date (reflog date, not commit date) and showing them in that
> order. But that gives rise to some funny corner cases.
>
> What do we do if there's clock skew within the reflog (e.g., somebody
> fixed their skewed clock such that HEAD@{5} is less recent than
> HEAD@{6}). Do we show them out of order then (even if only a single
> reflog is being shown?).

I would think the easiest-to-explain thing is handle clock skew just
like how clock skew affects the traversal with commit date.  At
least inside a single reflog, there is no need to sort---its
append-only nature gives a reliable "newer to older" order.

> But maybe we could do a pseudo-list-merge, where we treat the reflogs as
> queues and always pick from the queue with the most recent timestamp.

Yes, that was what I had in mind.  An entry with an artificially old
timestamp due to clock skew would clog the output and prevent the
entries behind it on the same reflog from getting shown before
entries from other reflog, but that is the same as what happens in
the normal traversal to sane parents that can only be reached from a
child commit that has an artificially old timestamp.

Thanks.

