Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D09B61FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 19:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753429AbcH2TQy (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 15:16:54 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:34688 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751271AbcH2TQx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 15:16:53 -0400
Received: by mail-lf0-f52.google.com with SMTP id l89so107915612lfi.1
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 12:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LkwMbcAUam6UxyRD3PiSI/nrpRPJCVGoS2t8lgDICW8=;
        b=AZsU6dUjEVlJFFdAKoLO56dqtTh0jSnAmF0ZSTXPoV+FI0cDg2ScalStx/wHZlh2t/
         ablfJmOpWUDxNRIp+ykLc/NM5f0oPGaySnybZJssnp7vuBlwwDVUsPsxu7fQnTjfyc3j
         xXnEJnNQfXsFThLgenVnUBigrc8N0/IDZ+GA9WJ7aQM/sXIU9uro8lvFuDkYy3HAzYiQ
         enFdPlyPI/uiQvAAedaRhYo6r7ZF+H34IX7gpZQezby8KI6LAKdI9xM2xEbEZjLo81VW
         hfWwmcmBv+bagBSSiDoCZFYeNu2+CEIuhGgvWoi63L2hewdz2806dskCo1hAgdRplek/
         4x5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=LkwMbcAUam6UxyRD3PiSI/nrpRPJCVGoS2t8lgDICW8=;
        b=nHTnPJ2+flwetlSyt2R633BDrM9tdffU8a+l0mbVCBHWe/faFLzXUsLYgWIXvcVUAo
         Qatm/NErV0fDZHoKwkKGpjsLo9dE+oRmZsZXMZZSx6CK4zKdZ4ymPXX7U/lb+KO7B/JI
         rruKQRXhF79VLL4xCHsodFoj5H/mBwOkEogIGf9AVnhbvWAZ2ZTpU/CV0o6OYrc5iY4w
         BGo+lMtJEvZ2DACypbft14vhfswAdGsV4ihTN6fzwhwAGP6lGnvh7YoF18A/cHqhiwgB
         aUOzvDM11+MNTzer7JBrd4821rjQOvNJMRPDcbyThG/ryjyx/LlTL5EIeAjrQAUj+K6M
         BHnA==
X-Gm-Message-State: AE9vXwOHR8zQZP363raIMcpyYj9gPx8Xu5SamKBJqtteLOZxnsNoOIBk9keu0ZZqdcqyyJhefPFSo4GVKVcfWA==
X-Received: by 10.25.24.233 with SMTP id 102mr5101297lfy.187.1472498211368;
 Mon, 29 Aug 2016 12:16:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.114.78.226 with HTTP; Mon, 29 Aug 2016 12:16:20 -0700 (PDT)
In-Reply-To: <20160829054725.r6pqf3xlusxi7ibq@sigill.intra.peff.net>
References: <CAFMAO9y3LsrAb_jp8XVq2mexaA4bBqmWFwJu55r4S6Dxd2-zxw@mail.gmail.com>
 <20160829054725.r6pqf3xlusxi7ibq@sigill.intra.peff.net>
From:   "W. David Jarvis" <william.d.jarvis@gmail.com>
Date:   Mon, 29 Aug 2016 12:16:20 -0700
X-Google-Sender-Auth: T8U8wcrVLPaPZRXbPZswmK7R18Q
Message-ID: <CAFMAO9yUMY5dqw-oWpKG1H-xska1AtDyt31_WaeJDyTieQLChw@mail.gmail.com>
Subject: Re: Reducing CPU load on git server
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> So your load is probably really spiky, as you get thundering herds of
> fetchers after every push (the spikes may have a long flatline at the
> top, as it takes time to process the whole herd).

It is quite spiky, yes. At the moment, however, the replication fleet
is relatively small (at the moment it's just 4 machines). We had 6
machines earlier this month and we had hoped that terminating two of
them would lead to a material drop in CPU usage, but we didn't see a
really significant reduction.

> Yes, though I'd be surprised if this negotiation is that expensive in
> practice. In my experience it's not generally, and even if we ended up
> traversing every commit in the repository, that's on the order of a few
> seconds even for large, active repositories.
>
> In my experience, the problem in a mass-fetch like this ends up being
> pack-objects preparing the packfile. It has to do a similar traversal,
> but _also_ look at all of the trees and blobs reachable from there, and
> then search for likely delta-compression candidates.
>
> Do you know which processes are generating the load? git-upload-pack
> does the negotiation, and then pack-objects does the actual packing.

When I look at expensive operations (ones that I can see consuming
90%+ of a CPU for more than a second), there are often pack-objects
processes running that will consume an entire core for multiple
seconds (I also saw one pack-object counting process run for several
minutes while using up a full core). rev-list shows up as a pretty
active CPU consumer, as do prune and blame-tree.

I'd say overall that in terms of high-CPU consumption activities,
`prune` and `rev-list` show up the most frequently.

On the subject of prune - I forgot to mention that the `git fetch`
calls from the subscribers are running `git fetch --prune`. I'm not
sure if that changes the projected load profile.

> Maybe. If pack-objects is where your load is coming from, then
> counter-intuitively things sometimes get _worse_ as you fetch less. The
> problem is that git will generally re-use deltas it has on disk when
> sending to the clients. But if the clients are missing some of the
> objects (because they don't fetch all of the branches), then we cannot
> use those deltas and may need to recompute new ones. So you might see
> some parts of the fetch get cheaper (negotiation, pack-object's
> "Counting objects" phase), but "Compressing objects" gets more
> expensive.

I might be misunderstanding this, but if the subscriber is already "up
to date" modulo a single updated ref tip, then this problem shouldn't
occur, right? Concretely: if ref A is built off of ref B, and the
subscriber already has B when it requests A, that shouldn't cause this
behavior, but it would cause this behavior if the subscriber didn't
have B when it requested A.

> This is particularly noticeable with shallow fetches, which in my
> experience are much more expensive to serve.

I don't think we're doing shallow fetches anywhere in this system.

> Jakub mentioned bitmaps, and if you are using GitHub Enterprise, they
> are enabled. But they won't really help here. They are essentially
> cached information that git generates at repack time. But if we _just_
> got a push, then the new objects to fetch won't be part of the cache,
> and we'll fall back to traversing them as normal.  On the other hand,
> this should be a relatively small bit of history to traverse, so I'd
> doubt that "Counting objects" is that expensive in your case (but you
> should be able to get a rough sense by watching the progress meter
> during a fetch).

See comment above about a long-running counting objects process. I
couldn't tell which of our repositories it was counting, but it went
for about 3 minutes with full core utilization. I didn't see us
counting pack-objects frequently but it's an expensive operation.

> I'd suspect more that delta compression is expensive (we know we just
> got some new objects, but we don't know if we can make good deltas
> against the objects the client already has). That's a gut feeling,
> though.
>
> If the fetch is small, that _also_ shouldn't be too expensive. But
> things add up when you have a large number of machines all making the
> same request at once. So it's entirely possible that the machine just
> gets hit with a lot of 5s CPU tasks all at once. If you only have a
> couple cores, that takes many multiples of 5s to clear out.

I think this would show up if I was sitting around running `top` on
the machine, but that doesn't end up being what I see. That might just
be a function of there being a relatively small number of replication
machines, I'm not sure. But I'm not noticing 4 of the same tasks get
spawned simultaneously, which says to me that we're either utilizing a
cache or there's some locking behavior involved.

> There's nothing in upstream git to help smooth these loads, but since
> you mentioned GitHub Enterprise, I happen to know that it does have a
> system for coalescing multiple fetches into a single pack-objects. I
> _think_ it's in GHE 2.5, so you might check which version you're
> running (and possibly also talk to GitHub Support, who might have more
> advice; there are also tools for finding out which git processes are
> generating the most load, etc).

We're on 2.6.4 at the moment.

> I suspect there's room for improvement and tuning of the primary. But
> barring that, one option would be to have a hierarchy of replicas. Have
> "k" first-tier replicas fetch from the primary, then "k" second-tier
> replicas fetch from them, and so on. Trade propagation delay for
> distributing the load. :)

Yep, this was the first thought we had. I started fleshing out the
architecture for it but wasn't sure if the majority of the CPU load
was being triggered by the first request to make it in, in which case
moving to a multi-tiered architecture wouldn't help us. When we didn't
notice a material reduction in CPU load after reducing the replication
fleet by 1/3, I started to worry about this and stopped moving forward
on the multi-tiered architecture until I understood the behavior
better.

 - V
