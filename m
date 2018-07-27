Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64A341F597
	for <e@80x24.org>; Fri, 27 Jul 2018 17:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388332AbeG0SpM (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 14:45:12 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:40087 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbeG0SpL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 14:45:11 -0400
Received: by mail-yw0-f196.google.com with SMTP id z143-v6so2128297ywa.7
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 10:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NCk9OBE0aok5bmSfKQqXbdaaftwcxy/CeYoZP5C3sTQ=;
        b=mQcdmdD/0H8t3hmrRyc4ENgo6FTdEiHIpMkj5N5Gh0SRVrBFTHuIQJDVVkSjAj5o1Y
         gXKb0W3ynN8vcnY9VUkI37aEL7hPT3z7j7cT4bX2IwiDKVSXPQ1S3gv9Tq1xGC1ZRLqM
         71zcFsUmR8Bg9Tgdr+/oMpy8QqJuTVCeYmQ2mMHul+OKAY+nvnbxlp/DFfzvhrDxAKHL
         g5ZmNaKqqslO3vR4xcPj3yFlWu/NIRLARCGWBmJPDbxsc+AUd480uM6XKydwiN+QzUWr
         NQk5PltsxeizUx0B3KaU90/h53ywYGuWPj2aOdjDEueOF8wdJS+d0MvxESMDLu8CKHuY
         4wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NCk9OBE0aok5bmSfKQqXbdaaftwcxy/CeYoZP5C3sTQ=;
        b=AEz5/n7A9zi/j/t95106feHHzw37N6boTt2x9auONWhyg42ifu2LtzY/4wdlYD4inE
         XGEZ0xPhtJKMAcn4fyg6SDVaWJdA1V+vVy+He84Q9f5LwvYtlqACsmWJKl6n48wppoam
         eQXjdf+cEm8xyITuGSwmytVM6bpd2dkkPOWNXSCfI6iqfdRoLXScfgq/UwZFaPy204G4
         0kj+4bIEEbXFGZcZlQ1QLLDUKu8DdWi1WgxyE+QgewzFaj+f8x8xYLOYR1nsX0c81TbQ
         Xxrtbdx06ZHzchhg3+WrDoGYkGzaCpDvwsjanAi9AEbV/4tl+25CLgimvFJ9vvHZdoHB
         LJ/Q==
X-Gm-Message-State: AOUpUlHS6iTb40LociTrXBRMWQXwhcFt/WN6PFhAiKdwxotKBa75UGjB
        Hn4V+NCVgS3hxBtOjhEyeI6s6LoBavmriPjbiWqtOD6E6dw=
X-Google-Smtp-Source: AAOMgpeeiFgm8eaKOxLi/O2XnoEWyck1WhmiDXsEWhnsfVuuqjC6qFhoEZmfQNeb73Npt+jG/06I3GhPRyx3Sic2Bp8=
X-Received: by 2002:a0d:c5c7:: with SMTP id h190-v6mr3923007ywd.421.1532712140281;
 Fri, 27 Jul 2018 10:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
 <20180722054836.28935-4-chriscool@tuxfamily.org> <CAGZ79kbF7g3E4hBa0VqMqBoovbAb2dHaGFNRL=+f7Lce1AduVg@mail.gmail.com>
 <20180724095843.GB3578@sigill.intra.peff.net> <CAGZ79kZkagveB+jG9iLQ2ohaSfAzY5YtWC=BTdD1o9OQUrw90Q@mail.gmail.com>
 <20180727131333.GC18599@sigill.intra.peff.net>
In-Reply-To: <20180727131333.GC18599@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 27 Jul 2018 10:22:09 -0700
Message-ID: <CAGZ79kYK3QkaSEinuq_Js5thVgY2-MyrN60W-Dws1p4eK73hHw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] pack-objects: add delta-islands support
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 27, 2018 at 6:13 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Jul 24, 2018 at 10:20:05AM -0700, Stefan Beller wrote:
>
> > So in my understanding we have a "common base pack" and specific
> > packs on top for each "island".
>
> Sort of. This is another hacky part. The islands themselves are
> generally just about forbidding deltas, and not any particular kind of
> layering.
>
> But there's some magic layering only for the "core" island, which gets
> to go first (and makes a sort of pseudo-pack at the front of the one
> pack). And then everything else is written willy nilly. This is a hack
> to try to make the "blit the pack bytes out" code path for cloning fast.

yup, I do understand its purpose; we had the same discussions here
for the JGit based hosting.

So you are saying island hopping is disallowed, but the core island
has an airport using the spokes system to reach all other islands?
(I described the core island as sea bed before). Sounds reasonable.

> So no, we don't really layer in any sane way. If pack-objects were fed
> the topological relationships between the forks, in theory we could
> create a layered packfile that respects that.
>
> But even that is not quite enough. At the time of forking, you might
> imagine that torvalds/linux has the base pack, and then somebody forks
> from them and contains all of those objects plus more, and somebody
> forks from them, and so on. But that's just a snapshot. Later
> torvalds/linux will get a bunch of new objects pushed to it. And some of
> its forks will merge those objects, too. But some of them will just rot,
> abandoned, as nobody ever touches them again.
>
> So I don't think there's much to be gained by paying attention to the
> external forking relationships. We have to discover afresh the
> relationships between objects, and which refs (and thus which islands)
> point to them.
>
> One thing I don't think we ever tried was doubling down on the
> islandCore concept and making the "root" fork as tightly packed as it
> could be (with the assumption that _most_ people grab that). And then
> just respect the islands for all the other objects (remember this is an
> optimization, so the worst case is somebody asks for an object during a
> fetch and we have to throw away its on-disk delta).
>
> That would solve the problem that fetching torvalds/linux from GitHub
> yields a bigger pack than fetching it from kernel.org. But again, it's
> making that root fork weirdly magical. People who fetch solely from
> other forks won't get any benefit (and may even see worse packs).

Thanks for the explanation.
I think this discussion just hints at me being dense reading the
documentation. After all I like the concept.

Thanks,
Stefan
