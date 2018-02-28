Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DF381F576
	for <e@80x24.org>; Wed, 28 Feb 2018 11:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752328AbeB1LY7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 06:24:59 -0500
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36056 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752124AbeB1LY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 06:24:58 -0500
Received: by mail-oi0-f50.google.com with SMTP id u73so1498839oie.3
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 03:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QULPIrFZ+ilTfzc9jjR62mxJgpS1rW7TOh1vZObjuIY=;
        b=UYHoEN9wZ71YIR09l+GEh6+ZUBptJDz4U1wjMIq4gA2ZczTnGaE2WqKR3YaAkKDGOr
         HFjwMQnrthtI1EpHds3a/5qj3G6hPNx+oFVvBQtll9Wnq0Cea1jcQVICvTz/ozXoz2HV
         5cPkTdalpXw2Wfnu5O7Rrefj34zTO9gDTmFliayaGTaM2n2DLJ7edOjAJd+7/RKGo0eB
         Th3Jy98/r433hi26g0TFYpHkTmTE9g4RgJ8rTtiXdop0bxvJ0TUYZNof8iHm67VMb9Gr
         CLWRZjcS13q2uhPivY8XWbUCvMWKj11OC9bvCzpfJ/BbvmFdkXYbNUXl6aOu3ViNOY77
         p2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QULPIrFZ+ilTfzc9jjR62mxJgpS1rW7TOh1vZObjuIY=;
        b=JP3AHV1KrN58TEHSv2fspwobgRmNMvsRUMX8EFRDDLB1aduN9UKrNgaAdGiIjW3F9e
         rQhMfDhEAloOIHMsoPkLBW4FPkPEsSgC0Tgm2Kf8BZIPLafSCfNMJ7us7n1hRgM9esKu
         fH0VPODOXnzQUxr1cC3b6bHXiC5obSy9HL6Rmy8cd2kZvyhi/eGD0ikvfOahkJ+oM5DV
         JaB3bewGddBeOUgJzDp+tnP6MPmN09INsA9VZSeL3CmmMHxpccUsjtQLDoFHo8Opjuzx
         LttMrlY8ZoJfyjvvaOYMl7OYZ+rhdhC91Nz14zzu92VlJ+mdPtF0dprGwjbOJUdOI9bG
         Fnug==
X-Gm-Message-State: APf1xPDiwcinLiS2vFjouLHnOYA7ybrBUBm2nxcwoJGPfAds/KrVms5X
        GrsvU7w50dqo3m5lQCuHXBVIyatJz7v/dGpRGUk=
X-Google-Smtp-Source: AG47ELuJD2EpspxP/EaazAXufeJgqWFtY8kND4+0OmICtSjxwxWFOfj341UNPTBvdxwF1hQI4POWNTkKinHbuVKCIEk=
X-Received: by 10.202.206.71 with SMTP id e68mr11634613oig.34.1519817097646;
 Wed, 28 Feb 2018 03:24:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Wed, 28 Feb 2018 03:24:27 -0800 (PST)
In-Reply-To: <20180228111121.GA8925@sigill.intra.peff.net>
References: <20180228092722.GA25627@ash> <20180228101757.GA11803@sigill.intra.peff.net>
 <CACsJy8Bg_oNj7mJ2PE5AWQ2awf434R9fHXQq-OxA3_0wJN16vw@mail.gmail.com> <20180228111121.GA8925@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 28 Feb 2018 18:24:27 +0700
Message-ID: <CACsJy8ASFF-82jcm3nNBsjFGpxwUNJZT+3kE+buuZt0mtG6KfA@mail.gmail.com>
Subject: Re: Reduce pack-objects memory footprint?
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 28, 2018 at 6:11 PM, Jeff King <peff@peff.net> wrote:
>> > The torvalds/linux fork network has ~23 million objects,
>> > so it's probably 7-8 GB of book-keeping. Which is gross, but 64GB in a
>> > server isn't uncommon these days.
>>
>> I wonder if we could just do book keeping for some but not all objects
>> because all objects simply do not scale. Say we have a big pack of
>> many GBs, could we keep the 80% of its bottom untouched, register the
>> top 20% (mostly non-blobs, and some more blobs as delta base) for
>> repack? We copy the bottom part to the new pack byte-by-byte, then
>> pack-objects rebuilds the top part with objects from other sources.
>
> Yes, though I think it would take a fair bit of surgery to do
> internally. And some features (like bitmap generation) just wouldn't
> work at all.
>
> I suspect you could simulate it, though, by just packing your subset
> with pack-objects (feeding it directly without using "--revs") and then
> catting the resulting packfiles together with a fixed-up header.
>
> At one point I played with a "fast pack" that would just cat packfiles
> together. My goal was to make cases with 10,000 packs workable by
> creating one lousy pack, and then repacking that lousy pack with a
> "real" repack. In the end I abandoned it in favor of fixing the
> performance problems from trying to make a real pack of 10,000 packs. :)
>
> But I might be able to dig it up if you want to experiment in that
> direction.

Naah it's ok. I'll go similar direction, but I'd repack those pack
files too except the big one. Let's see how it turns out.

>> They are 32 bytes per entry, so it should take less than object_entry.
>> I briefly wondered if we should fall back to external rev-list too,
>> just to free that memory.
>>
>> So about 200 MB for those objects (or maybe more for commits). Add 256
>> MB delta cache on top, it's still a bit far from 1.7G. There's
>> something I'm still missing.
>
> Are you looking at RSS or heap? Keep in mind that you're mmap-ing what's
> probably a 1GB packfile on disk. If you're under memory pressure that
> won't all stay resident, but some of it will be counted in RSS.

Interesting. It was RSS.

>> Pity we can't do the same for 'struct object'. Most of the time we
>> have a giant .idx file with most hashes. We could look up in both
>> places: the hash table in object.c, and the idx file, to find an
>> object. Then those objects that are associated with .idx file will not
>> need "oid" field (needed to as key for the hash table). But I see no
>> way to make that change.
>
> Yeah, that would be pretty invasive, I think. I also wonder if it would
> perform worse due to cache effects.

It should be better because of cache effects, I think. I mean, hash
map is the least cache friendly lookup. Moving most objects out of the
hash table shrinks it, which is even nicer to cache. But we also lose
O(1) when we do binary search on .idx file (after failing to find the
same object in the hash table)
-- 
Duy
