Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA7B31F45F
	for <e@80x24.org>; Thu,  2 May 2019 18:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfEBSC2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 14:02:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37077 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfEBSC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 14:02:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id w37so2925873edw.4
        for <git@vger.kernel.org>; Thu, 02 May 2019 11:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=SYiHi/WX+pk6LxWGQx/EcGceq2/ZfBW9AAVGUfvthjc=;
        b=gwab9yDfUU8mDdIKX+y4W28CElBwh+Ib6YiIogk4Pj4zmFp9ZA65GxiSLyrqn60iCM
         5u4gnxotoplzugjG8Z9x/4iRH55QWA1j+9TMvzXOg3vbASfKWmm75fs9Gmc8O3QrazFX
         OYkhFtO63k0QIyWemnP6EkWcdVgQm9FkJsjD+TOw0Chx0/4xEUD7YrvpiI6i5fOpxURT
         nLoLY8ALCy49YHIIL5wkm2vKLdBu97gaN8CRpDQYsG3avop7bPMf374uGWm/DwOr1G9O
         Xal559jErj+C02eL0g6kc2q5FMeXkCJOrkYq9PpQYPfle5lzojWMuwjKK2IRAaUm3csQ
         NmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=SYiHi/WX+pk6LxWGQx/EcGceq2/ZfBW9AAVGUfvthjc=;
        b=sGZe/1893ic7uqzy0NHaN9FMLTCHvtLAuJLcfkYZiopzYG/c4bAfhbUusFmyeV3qHD
         jhMpJqs69A4Yl4KvFpctIiCUHB/E4JXmLS7SKPjIj60OYjYpaMxHD3J/o3KndG6htNU7
         AZHbyXa7qdl3mkJj9QukgvAjRLl3cpRGNScR+5cTgCXHVaLaoQBLqX7VZFqWwHKxPwHh
         jJ10ZvEq8KsqOld/V2uFITtiCTW9PJtqwld2C7kCsba/XLUv87Vf47yAIQ9jjuFezr0G
         I9Iyk7Ye/rWr7bvtQFv4Pwhuz0QZ4mCb4d/FXDdcjOHy49MsF5pxcclPHxjyUYPzlDnd
         bepw==
X-Gm-Message-State: APjAAAUoBn+x2mMzt7jLZH4hZAB7Iu2CFtqNCgzEqyzd4WYHXLgiM24j
        vYX4f/1RLy12VfKuy9SX0eA=
X-Google-Smtp-Source: APXvYqw4z0J4KoEkQ6uVhwdvaLb/Plu5fvn/GrnZzlNgXjdfbYhVWkzTd51x3n+09W0QtZi3/ypg4w==
X-Received: by 2002:a50:cc0c:: with SMTP id m12mr3629306edi.8.1556820145706;
        Thu, 02 May 2019 11:02:25 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id g32sm5639316ede.88.2019.05.02.11.02.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 11:02:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/6] Create commit-graph file format v2
References: <pull.112.v2.git.gitgitgadget@gmail.com> <pull.112.v3.git.gitgitgadget@gmail.com> <87lfzprkfc.fsf@evledraar.gmail.com> <bb0c22f9-9d0b-0fa6-e826-8e2ac146c6f9@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <bb0c22f9-9d0b-0fa6-e826-8e2ac146c6f9@gmail.com>
Date:   Thu, 02 May 2019 20:02:22 +0200
Message-ID: <87h8acivkh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 02 2019, Derrick Stolee wrote:

> On 5/1/2019 4:25 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> I won't repeat my outstanding v2 feedback about v1 & v2
>> incompatibilities, except to say that I'd in principle be fine with
>> having a v2 format the way this series is adding it. I.e. saying "here
>> it is, it's never written by default, we'll figure out these compat
>> issues later".
>>
>> My only objection/nit on that point would be that the current
>> docs/commit messages should make some mention of the really bad
>> interactions between v1 and v2 on different git versions.
>
> Good idea to add some warnings in the docs to say something like
> "version 2 is not supported by Git 2.2x and earlier".
>
>> However, having written this again I really don't understand why we need
>> a v2 of this format at all.
>
> [snip]
>
>> How about we instead just don't change the header? I.e.:
>>
>>  * Let's just live with "1" as the marker for SHA-1.
>>
>>    Yeah it would be cute to use 0x73686131 instead like "struct
>>    git_hash_algo", but we can live with a 1=3D0x73686131 ("sha1"),
>>    2=3D0x73323536 ("s256") mapping somewhere. It's not like we're going =
to
>>    be running into the 255 limit of hash algorithms Git will support any
>>    time soon.
>
> This was the intended direction of using the 1-byte value before, but
> we have a preferred plan to use the 4-byte value in all future file forma=
ts.

Right, and I wouldn't argue about such a pointless thing for a future
file format.

But since the v1->v2 migration story is so unfriendly already for
reasons that can't be helped at this point (existing released versions)
I think we need to weigh the trade-offs of changing the header v.s. just
doing the conceptually less clean thing that allows existing clients a
painless transition.

>>  * Don't add the reachability index version *to the header* or change
>>    the reserved byte to be an error (see [1] again).
>
> Since we can make the "corrected commit date" offset for a commit be
> strictly larger than the offset of a parent, we can make it so an old cli=
ent
> will not give incorrect values when we use the new values. The only downs=
ide
> would be that we would fail on 'git commit-graph verify' since the offsets
> are not actually generation numbers in all cases.

Aren't you talking about how the *content* (presumably in the chunk part
of the graph) is going to look like? I just mean these couple of bytes
in the header, again as a proxy discussion for "do we *really* need to
change this?".

>> Instead we just add these things to new "chunks" as appropriate. As this
>> patch of mine shows we can easily do that, and it doesn't error out on
>> any existing version of git:
>> https://github.com/avar/git/commit/3fca63e12a9d38867d4bc0a8a25d419c00a09=
d95
>
> I like the idea of a "metadata" chunk. This can be useful for a lot of th=
ings.
> If we start the chunk with a "number of items" and only append items to t=
he
> list, we can dynamically grow the chunk as we add values.

Right. I like it too :) But right now I'm just using it as a demo for
how new arbitrary chunk data can be added to the v1 format in backwards
compatible ways.

My inclination for an actual version of that patch would be to make it
easier to read/extend (even just dump JSON there, or a series of
key/values) over micro-optimizing the storage size. Such metadata will
always be tiny v.s. the rest, but that's for later bikeshedding...

>> I now can't imagine a situation where we'd ever need to change the
>> format. We have 32 bits of chunk ids to play with, and can have 255 of
>> these chunks at a time, and unknown chunks are ignored by existing
>> versions and future version.
>
> The solutions you have discussed work for 2 of the 3 problems at hand.
> The incremental file format is a high-value feature, but _would_ break
> existing clients if they don't understand the extra data. Unless I am
> missing something for how to succeed here.

We would write out a file like this:

    <CGPH signature>
    <rest of v1 header incl. chunk offsets (but higher chunk count)>
    <chunks git understands now>
    <new chunks>
    <signature>

Where one of the new chunks could be INCC ("incremental count") or
whatever, serving the same purpose as the v2 modification of the header
to use the padding byte for the count. Then we'd have more chunks with
the incremental data (or pack it into one "magic" chunk with its own
format...).

Existing clients deal with the graph being incomplete, so the writer
could just not bother to update that part of the data and a newer
clients would know to find the rest in a series of incremental updates.

IOW an "empty" commit-graph now is 1100 bytes. Worst case we'd be
writing at least that number of bytes that would be mostly or entirely
useless to older clients, with the rest being new stuff newer clients
understand.

On the incremental format: I don't like:

 1) The idea that an incremental format would involve in-place
    modification of an existing file (or would we write a completely new
    one and move it in-place?).

    If it's in-place modification we get away a lot of things/avoid
    complexity with "we might delete, but we never modify existing" on
    existing *.{idx,bitmap} formats. E.g. mmap() is a royal PITA
    (more-so than now) once you need to deal with modifications.

    Also, if it's in-place we'd need to fully recompute the checksum
    SHA-1 as we modify the file.

 2) The assumption that we'd just have 255 of these, wouldn't it be
    reasonable to have a MIDX-like for it & write it along with packs as
    they come in? I.e. eventually have PACK.{pack,idx,bitmap,graph}.

    We support more than 255 packs, and it seems likely that we'd
    eventually want to generate/coalesce packs/idx and any other
    side-indexes on the same "gc" schedule.

But those are separate from any back-compat concerns, which is what I
think makes sense to focus on now.

>> 1. See feedback on the v2 patch in
>>    https://public-inbox.org/git/87muk6q98k.fsf@evledraar.gmail.com/
>
> My response [2] to that message includes the discussion of the
> incremental file format.
>
> [2] https://public-inbox.org/git/87muk6q98k.fsf@evledraar.gmail.com/
