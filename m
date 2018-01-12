Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64F811F406
	for <e@80x24.org>; Fri, 12 Jan 2018 14:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933905AbeALOXO (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 09:23:14 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:37479 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933687AbeALOXN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 09:23:13 -0500
Received: by mail-pf0-f171.google.com with SMTP id p1so4490512pfh.4
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 06:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MXkw+2iGkOyARYFx9P0QWHsSaKPZeAkw6bSwguhUhcc=;
        b=OgeX9NcIVfigryAmpiMtV3qohrpfJP8nIq1v5/ObTdj7cUSwYRh4n1mkJ9z19O9SaH
         N5Vdv/bMoMjonUKxwoRkdFNAlnIErJubnwkhYG3CkDqkrsfaD4HuvKHDxZON00EswSq0
         sv/Dn5zPnqTBahVt9bjjCVxlFpXTIH5Wrbaji3weFzj3kcTKv5p0A/DnJEOYDy++0MUo
         R5ui8D8+mBR7sKAMj6QsiyvTXK9Q8t9xWdni0H99CMxpMxhiLeJ6sgT/7zkj9PzxdYM+
         e2HHE2hRTHZk0/LDGKvk/+PZxB/JJqEKjvH1IWUEef0288tpXN+I/svo+p1SEtBhEtYk
         4UaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MXkw+2iGkOyARYFx9P0QWHsSaKPZeAkw6bSwguhUhcc=;
        b=b5cjUVkdDVz4mGhPIZot2qxvOJqkITLaqWPl7ttuo5Q0O+ag6z62r0h1pzYT7jhWZz
         CnrzW4Z73/8zpANbP0clGn6NlJV6xkeKGqRAWZXDK665ajUUhNDkk/oSiE/CbzF1DtPE
         ioBzFALTCMWqyEJ0M/aluwg9IWeLFvC+e/iX54wvhb2KqZtAvsmNkX9d5s4zru3PHycn
         3NNQc6naa7w5HilRaGtIyJasVeV9CvUX3BfmpZSsNnrVZwc98tfz1v3QDaqM2Ha1aXpn
         8+M+DQe/UlfhlW6reNtKVFG4dSeiznNZuQtSVXY5LSnaO+fyoAKi3y8wXKfYBClVCXVm
         8tBg==
X-Gm-Message-State: AKwxytfW4uLFchJaDSy6ByMKkV80zjxu4jTipysvSGnriPAWiF+QFOjv
        AdQyDQSVUas7/j7qXRZjKG/XTg==
X-Google-Smtp-Source: ACJfBosHt+1KP+ggZagj7InZFa0APpR70KciK8s6FkrgLsGz7oO7Qd+h4FO7UEq4UoPNag/uw6iL2g==
X-Received: by 10.159.242.9 with SMTP id t9mr5817422plr.201.1515766992342;
        Fri, 12 Jan 2018 06:23:12 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id y29sm23435926pff.24.2018.01.12.06.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jan 2018 06:23:11 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 12 Jan 2018 21:23:05 +0700
Date:   Fri, 12 Jan 2018 21:23:05 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: git gc --auto yelling at users where a repo legitimately has
 >6700 loose objects
Message-ID: <20180112142305.GA338@ash>
References: <87inc89j38.fsf@evledraar.gmail.com>
 <20180112134609.GB7880@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180112134609.GB7880@sigill.intra.peff.net>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 12, 2018 at 08:46:09AM -0500, Jeff King wrote:
> On Thu, Jan 11, 2018 at 10:33:15PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> >  4. At the end of all this, we check *again* if we have >6700 objects,
> >     if we do we print "run 'git prune'" to .git/gc.log, and will just
> >     emit that error for the next day before trying again, at which point
> >     we unlink the gc.log and retry, see gc.logExpiry.
> > 
> > Right now I've just worked around this by setting gc.pruneExpire to a
> > lower value (4.days.ago). But there's a larger issue to be addressed
> > here, and I'm not sure how.
> 
> IMHO the right solution is to stop exploding loose objects, and instead
> write them all into a "cruft" pack. That's more efficient, to boot
> (since it doesn't waste inodes, and may even retain deltas between cruft
> objects).
> 
> But there are some tricks around timestamps. I wrote up some thoughts
> in:
> 
>   https://public-inbox.org/git/20170610080626.sjujpmgkli4muh7h@sigill.intra.peff.net/
> 
> and downthread from there.

My thoughts were moving towards that "multiple cruft packs" idea in
your last email of that thread [1]. I'll quote it here so people don't
have to open the link

> > Why can't we generate a new cruft-pack on every gc run that
> > detects too many unreachable objects? That would not be as
> > efficient as a single cruft-pack but it should be way more
> > efficient than the individual objects, no?
> > 
> > Plus, chances are that the existing cruft-packs are purged with
> > the next gc run anyways.
> 
> Interesting idea. Here are some thoughts in random order.
> 
> That loses some delta opportunities between the cruft packs, but
> that's certainly no worse than the all-loose storage we have today.

Does it also affect deltas when we copy some objects to the new
repacked pack (e.g. some objects in the cruft pack getting referenced
again)? I remember we do reuse deltas sometimes but not in very
detail. I guess we probably won't suffer any suboptimal deltas ...

> 
> One nice aspect is that it means cruft objects don't incur any I/O
> cost during a repack.

But cruft packs do incur object lookup cost since we still go through
all packs linearly. The multi-pack index being discussed recently
would help. But even without that, packs are sorted by mtime and old
cruft packs won't affect as much I guess, as long as there aren't a
zillion cruft packs around. Then even prepare_packed_git() is hit.

> It doesn't really solve the "too many loose objects after gc"
> problem.  It just punts it to "too many packs after gc". This is
> likely to be better because the number of packs would scale with the
> number of gc runs, rather than the number of crufty objects. But
> there would still be corner cases if you run gc frequently. Maybe
> that would be acceptable.
> 
> I'm not sure how the pruning process would work, especially with
> respect to objects reachable from other unreachable-but-recent
> objects. Right now the repack-and-delete procedure is done by
> git-repack, and is basically:
> 
>   1. Get a list of all of the current packs.
> 
>   2. Ask pack-objects to pack everything into a new pack. Normally this
>      is reachable objects, but we also include recent objects and
>      objects reachable from recent objects. And of course with "-k" all
>      objects are kept.
> 
>   3. Delete everything in the list from (1), under the assumption that
>      anything worth keeping was repacked in step (2), and anything else
>      is OK to drop.
> 
> So if there are regular packs and cruft packs, we'd have to know in
> step 3 which are which. We'd delete the regular ones, whose objects
> have all been migrated to the new pack (either a "real" one or a
> cruft one), but keep the crufty ones whose timestamps are still
> fresh.
> 
> That's a small change, and works except for one thing: the reachable
> from recent objects. You can't just delete a whole cruft pack. Some
> of its objects may be reachable from objects in other cruft packs
> that we're keeping. In other words, you have cruft packs where you
> want to keep half of the objects they contain. How do you do that?

Do we have to? Those reachable from recent objects must have ended up
in the new pack created at step 2, correct? Which means we can safely
remove the whole pack.

Those reachable from other cruft packs. I'm not sure if it's different
from when these objects are loose. If a loose object A depends on B,
but B is much older than A, then B may get pruned anyway while A stays
(does not sound right if A gets reused).

> I think you'd have to make pack-objects aware of the concept of
> cruft packs, and that it should include reachable-from-recent
> objects in the new pack only if they're in a cruft pack that is
> going to be deleted. So those objects would be "rescued" from the
> cruft pack before it goes away and migrated to the new cruft
> pack. That would effectively refresh their timestamp, but that's
> fine. They're reachable from objects with that fresh timestamp
> already, so effectively they couldn't be deleted until that
> timestamp is hit.
> 
> So I think it's do-able, but it is a little complicated.

[1] https://public-inbox.org/git/20170620140837.fq3wxb63lnqay6xz@sigill.intra.peff.net/
--
Duy
