Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81C891F462
	for <e@80x24.org>; Mon, 29 Jul 2019 12:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfG2M4i (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 08:56:38 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:38345 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbfG2M4i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 08:56:38 -0400
Received: by mail-ed1-f54.google.com with SMTP id r12so24431732edo.5
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 05:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=+A4yycgwbPGbiQ9R24gMaAJIjBbKovI6ThJQgbAwONY=;
        b=BXcHq59mVV138EUee4WXkR46FFVWLDofgQNNE2Y4OlZrqL/3qKMhe8tcfTAO/HsPWB
         eCZmhZykGPhS0hK6qzwe7+4edNZaoby9eCJ8yrd9NNaL7+f0lMG2eK+P/BbkjtSzAXfm
         kRe+AgzIhRabXoCdJButczNiT+eNAlA/4xJPxg2kLUcGT1HDtLrVj4KQY2dhK7G4IDER
         ao6DaDV2ifH7jugpR5B+wog0H8LuF2yzL4p5VTuUR8S1RT1xDTQkEAsEgUaFI5Zy27tF
         UZchpzc0GCPuRnWfhwc2FrISC12X+aGIo4MPCgmKf1l2ITCq40d/Zsyt3Hsmcuzty+Ry
         qMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=+A4yycgwbPGbiQ9R24gMaAJIjBbKovI6ThJQgbAwONY=;
        b=PyaOg26c80JDGB6DDVBVvEVOGuvD92fAXpFmV1YrhpPOwN89Mz/PDigcHyGCqSKUuc
         A88CaJm5Vd94Q5xTw01N24bPzpF6O+RSnbsJA0p43jmsVfsLUA23jUc79tgaee67zlcS
         rXrIeSnmqFHBAPrhEEG5s22JXjhio8GqT3zjMa4E393xuKjwPEVlxVaDRcZ8UsHHGgGa
         LzeAMM0pL5zJ5Dz/QYXxklqfFZLZLLu36OJmbFyqT9HCrtXkXM//x/i+y30XZlFqOqk2
         dmakNfa89G2eH8DS59THiwwxf7O95OoDJEqsjvMB5hE5S7N6ZehI4YYMSiBJ87EIX0FW
         YDBw==
X-Gm-Message-State: APjAAAXSqQp/fPOX43X6QICRLZs7UJ+LOACVAF7cllSdh4becyixeBVh
        p5SqzQreXNPKGYA1EbhPfik=
X-Google-Smtp-Source: APXvYqyMBDO+sP1hN6b6IUPE/+DrH3kOM2oD4GPsDx7RzSH+eiMYUW2DZQ+olFUIsXcN2D1IpFuxRA==
X-Received: by 2002:a17:906:94ce:: with SMTP id d14mr86307881ejy.251.1564404995717;
        Mon, 29 Jul 2019 05:56:35 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id z20sm6763575eju.19.2019.07.29.05.56.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 05:56:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     ardi <ardillasdelmonte@gmail.com>, git@vger.kernel.org
Subject: Re: Settings for minimizing repacking (and keeping 'rsync' happy)
References: <CA+fZqCXBjA5jsYg7L7X1VhJZXrp9NP+dR1SQWK9fAf9b1jgpCg@mail.gmail.com> <20190729094229.GA2415@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190729094229.GA2415@sigill.intra.peff.net>
Date:   Mon, 29 Jul 2019 14:56:34 +0200
Message-ID: <87tvb55799.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 29 2019, Jeff King wrote:

> On Sun, Jul 28, 2019 at 01:41:34AM +0200, ardi wrote:
>
>> Some of my Git repositories have mirrors, maintained with 'rsync'. I
>> want to have some level of repacking, so that the repositories are
>> efficient, but I also want it to minimize it, so that 'rsync' never
>> has to perform a big transfer for the repositories.
>
> Yes, this is a common problem. The solutions I've seen/used are:
>
>   - use a git-aware transport like git-fetch that can negotiate which
>     objects to send
>
>   - use a tool that can find duplicated chunks across files. Many
>     de-duping backup systems (e.g., borg) use a rolling hash similar to
>     rsync to find moveable chunks, but then look up those chunks in a
>     master index (whereas rsync is always looking to match chunks in a
>     file of the same name). This works well in practice because Git is
>     not usually rewriting most of the data, but just shuffling it around
>     between files.
>
>     In theory it shouldn't be that hard to tell the receiving rsync to
>     look for source chunks not just in the file of the same name, but
>     from a set of existing packfiles (say, everything already in
>     .git/objects/pack/ on the receiver). But I don't know offhand of an
>     option to rsync to do so.
>
>> For example, I think it would be fine if files are repacked just once
>> in their lifetimes, and then that resulting pack file is never
>> repacked again. I did read the gc.bigPackThreshold and
>> gc.autoPackLimit settings, but I don't think they would accomplish
>> that.
>>
>> Basically, what I'm describing is the behaviour of not packing files
>> until the resulting pack would be a given size (say 10MB for example),
>> and then never repack such ~10MB packs again, ever.
>>
>> Can this be done with some Git settings? And do you foresee any kind
>> of serious drawback or potential problem with this kind of behaviour?
>
> You can mark a pack to be kept forever by creating a matching
> "pack-1234abcd.keep" file. That doesn't do your automatic "I want 10MB
> packs" thing, but if you did it occasionally at the right frequency,
> you'd end up with a bunch of 10MB-ish packs.
>
> But there are downsides to having a bunch of packs:
>
>   - object lookups are O(log n) within a single pack, but O(n) over the
>     number of packs. So if you get a very large number of packs, normal
>     operations will start to suffer. This is mitigated by the new "midx"
>     feature, which generates an index for multiple packs.
>
>   - git doesn't allow delta compression across packs. So imagine you
>     have ten versions of a file that's 5kb, and each version changes
>     about 100 bytes. In a single pack, we'd store one base object, plus
>     9 deltas, for a total of about 6kb (5000 + 9*100). Across two packs,
>     we'd store ~11kb (2*5000 + 8*100). And the worst case is ten packs
>     at 50kb.
>
>     As a more real-world example, try this:
>
>       git -c pack.packsizelimit=10M repack -ad
>
>     In a fresh clone of git.git, the size of the pack directory jumps
>     from 88MB to 168MB. And in a time-based split (i.e., creating a new
>     10MB pack every week), it may be even worse. The command above
>     ordered the objects optimally to keep deltas together and _then_
>     split things. Whereas a time-based scheme would likely sprinkle
>     versions of a file across more packs.
>
>     It should be possible to loosen this restriction and allow
>     cross-pack deltas, but it would be very risky. The assumption that
>     packs are independent of each other is implicit in much of Git's
>     repacking code, so it would be easy to introduce a bug where we
>     generate a circular dependency (object A in pack X is a delta
>     against object B in pack Y, which is a delta against object A --
>     oops, we don't have a full copy anymore).

The thread I started at
https://public-inbox.org/git/87bmhiykvw.fsf@evledraar.gmail.com/ should
also be of interest. I.e. we could have some knobs to create more
"stable" packs, I know rsync does some in-file hashing, but I don't
if/how that works if you have 1 file split into N where some chunks in
the N are in the one file.

But it's possible to imagine a repacking algorithm that would keep
producing entirely new packs but arrange for it to be ordered/delta'd in
such a way that it optimizes for page-by-page similarity to an older
pack to some degree.

So e.g. in the examples you mention break the delta chain at 5, then
pick it up again once it's 10 etc. So the intermediate packs where it's
6, 7, 8, 9 would have the new stuff at the end.
