Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76A5B1F576
	for <e@80x24.org>; Wed, 28 Feb 2018 10:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbeB1K7X (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 05:59:23 -0500
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36037 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752149AbeB1K7W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 05:59:22 -0500
Received: by mail-oi0-f50.google.com with SMTP id u73so1449750oie.3
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 02:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KwN7/Cn89skXmAkZddU1iGsKeJABckBAHzk6hv8c6cs=;
        b=Q6dRel8LctRhM1g5/Etsstdxll/DHQwbWZpUOki4RhqieFi1fSrov0gVMDWCTAW/qH
         ilBXf6+W1JCdj8Cv4EN23on52npG1tecQ2DXLiloLg7z7k+SofTyBlXVMcZqzxecLZfK
         0R3iQjku3PCHarUKjX2q+tRnwQI+y3RjJvOVsZsKUVrtSN6QzucpmrM8P274uH6dLhDQ
         wtAyWbiKo5R6jO6o+qhtjOpYKrfD4Iw4VoBooJUpspJmPdIN1b25IEgwO3A7aChdW8q/
         WlWiAH1tjFkKSGRwRcWiF2Jwqnm1Rwl8+7u+JD7VhSJcAhlTM47NWuCWsTl/FICxKxGF
         U4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KwN7/Cn89skXmAkZddU1iGsKeJABckBAHzk6hv8c6cs=;
        b=MfaSXzZOrvsQ78Nn8+CE+IRw24SA08Uv5i368P1513nbmUz1qAdJ9WwQz6R8RZsDrA
         1ZgTzw9yRBJ1j4qnu7eeXYw+cLz8dHFSAYomX4gL/dkpKsS5gMqkiwEC52lHIPcm37yE
         WZ7AyocsX7FcDCNDF3LitFI/qFe9aFPmBJBEGPNbOHhANupLXCfF9z0VVTrH6jKzOsCZ
         fQY3KdCH2E3+Zh+I0i5f7VPOo9nXZB21dSMP5+UOTrQhKOOCJJ2/Bv5DugieRbTqMFQ9
         kSQsCPmdM/ra3yG3TSe6vCP1e+/KElO+7IL6IsTOS5rRZI0GZczgM2SAqWBhW+H/v9q2
         Tkpg==
X-Gm-Message-State: APf1xPBJMGxM152j2zTFtYa5tyeNF1Uxve+ZY0fTempZtZHM8HDRiVtI
        drVbxXnw6f4dssiW23eAfcHg3OdiVP2Affg3IZA=
X-Google-Smtp-Source: AG47ELsqd79RAufBWLjP3ZiwuXVIBhenrLJaQSSH5sdH9bunYy/qK4J43lgcdZbp75T/bjb1AV0+s1AlHGBh+53UWZA=
X-Received: by 10.202.64.85 with SMTP id n82mr636653oia.30.1519815561365; Wed,
 28 Feb 2018 02:59:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Wed, 28 Feb 2018 02:58:50 -0800 (PST)
In-Reply-To: <20180228101757.GA11803@sigill.intra.peff.net>
References: <20180228092722.GA25627@ash> <20180228101757.GA11803@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 28 Feb 2018 17:58:50 +0700
Message-ID: <CACsJy8Bg_oNj7mJ2PE5AWQ2awf434R9fHXQq-OxA3_0wJN16vw@mail.gmail.com>
Subject: Re: Reduce pack-objects memory footprint?
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 28, 2018 at 5:17 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 28, 2018 at 04:27:22PM +0700, Duy Nguyen wrote:
>
>> linux-2.6.git current has 6483999 objects. "git gc" on my poor laptop
>> consumes 1.7G out of 4G RAM, pushing lots of data to swap and making
>> all apps nearly unusuable (granted the problem is partly Linux I/O
>> scheduler too). So I wonder if we can reduce pack-objects memory
>> footprint a bit.
>
> Yeah, the per object memory footprint is not great. Around 100 million
> objects it becomes pretty ridiculous. I started to dig into it a year or
> three ago when I saw such a case, but it turned out to be something that
> we could prune.

We could? What could we prune?

> The torvalds/linux fork network has ~23 million objects,
> so it's probably 7-8 GB of book-keeping. Which is gross, but 64GB in a
> server isn't uncommon these days.

I wonder if we could just do book keeping for some but not all objects
because all objects simply do not scale. Say we have a big pack of
many GBs, could we keep the 80% of its bottom untouched, register the
top 20% (mostly non-blobs, and some more blobs as delta base) for
repack? We copy the bottom part to the new pack byte-by-byte, then
pack-objects rebuilds the top part with objects from other sources.

That would of course be less optimal because we can't make delta
against those objects at the bottom. And this makes the assumption
that these packs are generated using the same heuristics that we use.

> I think laptops repacking the kernel are probably one of the worst cases
> (leaving aside the awful Windows repository, but my impression is that
> they simply can't do a full repack at all there).

Yeah. My fear is "git gc --auto" kicking in. Even on a laptop we
should support working on a repo as big as linux-2.6 (or as smalls as
one from facebook/microsoft perspective). I probably will add a mode
that keeps the largest pack alone and just pack the rest in a second
pack in "git gc --auto". That might help (I haven't really checked the
details yet, but object_entry book keeping should go down at least)

>> This demonstration patch (probably breaks some tests) would reduce the
>> size of struct object_entry from from 136 down to 112 bytes on
>> x86-64. There are 6483999 of these objects, so the saving is 17% or
>> 148 MB.
>
> 136 x 6.5M objects is only about 800MB. I suspect a big chunk of the
> rest is going to the object structs we create when doing the internal
> rev-list traversal. And those duplicate the 20-byte sha1s at the very
> least.

They are 32 bytes per entry, so it should take less than object_entry.
I briefly wondered if we should fall back to external rev-list too,
just to free that memory.

So about 200 MB for those objects (or maybe more for commits). Add 256
MB delta cache on top, it's still a bit far from 1.7G. There's
something I'm still missing.

> Another option would be to somehow replace the pack_idx_entry with a
> reference to a "struct object". That would let us at least avoid storing
> the 20-byte oid twice.

20 bytes saving? /me drools.

Pity we can't do the same for 'struct object'. Most of the time we
have a giant .idx file with most hashes. We could look up in both
places: the hash table in object.c, and the idx file, to find an
object. Then those objects that are associated with .idx file will not
need "oid" field (needed to as key for the hash table). But I see no
way to make that change.

>> If we go further, notice that nr_objects is uint32_t, we could convert
>> the three pointers
>>
>>       struct object_entry *delta;
>>       struct object_entry *delta_child;
>>       struct object_entry *delta_sibling;
>>
>> to
>>
>>       uint32_t delta;
>>       uint32_t delta_child;
>>       uint32_t delta_sibling;
>>
>> which saves 12 bytes (or another 74 MB). 222 MB total is plenty of
>> space to keep some file cache from being evicted.
>
> Yeah, that seems like low-hanging fruit. I'd also note that we don't
> actually use all of the fields during the whole process. I think some of
> those delta fields are only used for a short time. So we might be able
> to reduce peak memory if there are some mutually exclusive bits of each
> entry (and even if there's some overlap, we'd reduce the length of time
> we'd need to be at peak).

Yeah it looks that way to me too. Now that we have packing_data,
splitting object_entry[] to multiple arrays (that is only needed at
some point) may be very nice.

>> Is it worth doing this? The struct packing makes it harder to read
>> (and more fragile too). I added some more artifical limit like max
>> depth of 2^11. But I think 4096+ depth is getting unreasonable.
>
> I'm OK with a limit like 4096, as long as we notice when we hit the
> limit and behave reasonably. I think the algorithm in
> break_delta_chains() may temporarily store up to uint32_t depth. But I
> think we won't ever write anything into cur->depth larger than the
> max-depth limit. So it would probably be sufficient to just check that
> the --depth argument is reasonably sized and complain otherwise.
>
> I do agree this makes things a bit harder to read, but I think the
> benefits are pretty measurable. And may make a real usability difference
> on a large repository.

Thanks. I'll go make real patches then (with lots more checks to make
sure we don't overflow in shortened fields like depth or type).
-- 
Duy
