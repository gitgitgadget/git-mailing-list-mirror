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
	by dcvr.yhbt.net (Postfix) with ESMTP id 119311F453
	for <e@80x24.org>; Wed,  1 May 2019 20:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfEAU0E (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 16:26:04 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35809 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfEAU0D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 16:26:03 -0400
Received: by mail-ed1-f66.google.com with SMTP id p26so277633edr.2
        for <git@vger.kernel.org>; Wed, 01 May 2019 13:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ryJplpuvXck9mwHqLS2pTBzZnld4C69eohrfdFKFAJ8=;
        b=XKUOmfUKfkuPyxJJ2LzoreZmDzzDsROJy140cQJHpMmV2lkn5/6BoRTbAj9P/lcR0h
         57uF4tst/Eq7Idy+b/QkExJa7JTx9JPq1IH7+idIfJk7HOBW/tYsI6Vb4FVNvIpF1x4m
         oFiSCWSeqyOx1FzASCjelsN86CBix3IJcGxs/kC09HnGipL47zYq6QeIg5xLLNIFq7fU
         Mtwuz6uImgxaA0UU0PlFZ8EOVeC2rhdmrjfUpVbbpwuy1SpaO4JSmnyeloao6ty63fBn
         Xbpt96d4/+7gpESufKYCIRVCqO2jRpOA2zdVkW1rX8/2f68uOGDpxjw3S4FaeQetGezo
         142Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ryJplpuvXck9mwHqLS2pTBzZnld4C69eohrfdFKFAJ8=;
        b=q7GoFkARIgPJf9AGC2nOFV/wHz4dZQbbb+bEIjAedt/qJOWM/VKTQnmgLP3ox7iATP
         tFk04a/sfWmfVWF8XsULpS+lrgbgJbgMQcWYfbYFFfLXjmJuukJ4s4WnIVkCpm7S3/nD
         ZxVwZKXYIZx065xTjpwHCG/B4CjPDY2j7U8NFPnSyeIBHJh3wj1dSRQoeb97+sO9kr+x
         xGnrJVG4b0pZW391k1Gfs4OTpMtGi1WjyG6NCmqJ2ZpXfap4c2NhTMnUlbOtF3/fOdAI
         wHYeaXIgF00Tz9y1MFENcBQYBH/h+R7qjp+nYCbjVNWIbK39ycPHphtBd9PW901mKLuP
         6Sew==
X-Gm-Message-State: APjAAAVjFFAS/P2pz/ZMclm8bfAlipWe1p+0m9FrLySDwbC2x0jRRQ+r
        wVBjxbrbkQm2h2Q4BVISACg=
X-Google-Smtp-Source: APXvYqyRwPj7CUG7SLC7ie4PhCoZtsLIaHfrEjzXOH7eGvN0hhJV0fKMsFfAZNNjerLbh5lNMhGswQ==
X-Received: by 2002:aa7:ce07:: with SMTP id d7mr84703edv.294.1556742361392;
        Wed, 01 May 2019 13:26:01 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id u47sm1196667edm.86.2019.05.01.13.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 13:26:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/6] Create commit-graph file format v2
References: <pull.112.v2.git.gitgitgadget@gmail.com> <pull.112.v3.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <pull.112.v3.git.gitgitgadget@gmail.com>
Date:   Wed, 01 May 2019 22:25:59 +0200
Message-ID: <87lfzprkfc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 01 2019, Derrick Stolee via GitGitGadget wrote:

> The commit-graph file format has some shortcomings that were discussed
> on-list:
>
>  1. It doesn't use the 4-byte format ID from the_hash_algo.
>
>  2. There is no way to change the reachability index from generation numb=
ers
>     to corrected commit date [1].
>
>  3. The unused byte in the format could be used to signal the file is
>     incremental, but current clients ignore the value even if it is
>     non-zero.
>
> This series adds a new version (2) to the commit-graph file. The fifth by=
te
> already specified the file format, so existing clients will gracefully
> respond to files with a different version number. The only real change now
> is that the header takes 12 bytes instead of 8, due to using the 4-byte
> format ID for the hash algorithm.
>
> The new bytes reserved for the reachability index version and incremental
> file formats are now expected to be equal to the defaults. When we update
> these values to be flexible in the future, if a client understands
> commit-graph v2 but not those new values, then it will fail gracefully.
>
> NOTE: this series was rebased onto ab/commit-graph-fixes, as the conflicts
> were significant and subtle.
>
> Updates in V3: Thanks for all the feedback so far!
>
>  * Moved the version information into an unsigned char parameter, instead=
 of
>    a flag.
>
>  * We no longer default to the v2 file format, as that will break users w=
ho
>    downgrade. This required some changes to the test script.
>
>  * Removed the "Future work" section from the commit-graph design document
>    in a new patch.
>
>  * I did not change the file name for v2 file formats, as =C3=86var sugge=
sted.
>    I'd like the discussion to continue on this topic.

I won't repeat my outstanding v2 feedback about v1 & v2
incompatibilities, except to say that I'd in principle be fine with
having a v2 format the way this series is adding it. I.e. saying "here
it is, it's never written by default, we'll figure out these compat
issues later".

My only objection/nit on that point would be that the current
docs/commit messages should make some mention of the really bad
interactions between v1 and v2 on different git versions.

However, having written this again I really don't understand why we need
a v2 of this format at all.

The current format is:

    <CGPH signature>
    <CGPH version =3D 1>
    <hash version (0..255) where 1 =3D=3D SHA-1>
    <num chunks (0..255)>
    <reserved byte ignored>
    [chunk offsets for our $num_chunks]
    [arbitrary chunk data for our $num_chunks]

And you want to change it to:

    <CGPH signature>
    <CGPH version =3D 2>
    <num chunks (0..255)>
    <reachability index version, hard error on values !=3D 1 (should have s=
een this in my [1])>
    <reserved byte hard error on values !=3D 0 [1]>
    <hash version 32 bit. So 0x73686131 =3D "sha1" instead of "1">
    [chunk offsets for our $num_chunks]
    [arbitrary chunk data for our $num_chunks]

Where "chunks" in the v1 format has always been a non-exhaustive list of
things *where we ignore anything we don't know about*.

So given our really bad compatibility issues with any non-v1 format I
suggested "let's use a different filename". But on closer look I retract
that.

How about we instead just don't change the header? I.e.:

 * Let's just live with "1" as the marker for SHA-1.

   Yeah it would be cute to use 0x73686131 instead like "struct
   git_hash_algo", but we can live with a 1=3D0x73686131 ("sha1"),
   2=3D0x73323536 ("s256") mapping somewhere. It's not like we're going to
   be running into the 255 limit of hash algorithms Git will support any
   time soon.

 * Don't add the reachability index version *to the header* or change
   the reserved byte to be an error (see [1] again).

Instead we just add these things to new "chunks" as appropriate. As this
patch of mine shows we can easily do that, and it doesn't error out on
any existing version of git:
https://github.com/avar/git/commit/3fca63e12a9d38867d4bc0a8a25d419c00a09d95

I now can't imagine a situation where we'd ever need to change the
format. We have 32 bits of chunk ids to play with, and can have 255 of
these chunks at a time, and unknown chunks are ignored by existing
versions and future version.

We can even have more than 255 if it comes to that by having a special
"extension" chunk, or even use the existing reserved byte for that and
pull the nasty trick of putting another set after the existing file
checksum, but I digress.

If we ever find that we e.g. don't want to write SHA-1 data anymore but
just want SHA-256 we just write a tiny amount of dummy data. Older git
versions will shrug at what looks like a really incomplete commit graph
data, but newer versions will know the real data is in some other chunk
they know about.

Ditto this "gen numbers or adjusted timestamps?" plan in
https://public-inbox.org/git/6367e30a-1b3a-4fe9-611b-d931f51effef@gmail.com/
We can have a chunk of adjusted timestamps into the generation number
chunk, and even start adding chunks of other side-data, e.g. the path
bloom filters...

This E-Mail needs to stop at some point, but as a brief aside I don't
see how this die("commit-graph hash algorithm does not match current
algorithm") plan makes sense either.

The hash-function-transition.txt plan describes how we'll have an index
of SHA-1<->SHA-256 object names. Why would it be an error to read a
SHA-1 commit-graph under SHA-256? Won't we just say "oh this graph lists
the SHA-1s" and then use that lookup table to resolve them as SHA-256s?

And as discussed once we go for extending things with chunks we can do a
lot better. We'd just keep the SHA-1 data segment, and perhaps (for
"just commits" cache locality) have another chunk of SHA-256 mappings to
those SHA-1s in the commit-graph file.

1. See feedback on the v2 patch in
   https://public-inbox.org/git/87muk6q98k.fsf@evledraar.gmail.com/
