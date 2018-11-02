Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06C4C1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 17:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeKCCwm (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 22:52:42 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:40549 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeKCCwm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 22:52:42 -0400
Received: by mail-wr1-f48.google.com with SMTP id i17-v6so2793470wre.7
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 10:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=xY34eWaGvxQUsZEqOZDOZXII9CHdy+Qb6FpxVsqvACA=;
        b=LtOdeochmGrFescdEbgEcsgBTdqUgG9gh9FbhXGSVbY1lLe3HOdhVGABHgZST6U9d7
         RbgmoJ8VINNw6mkQWQslnpihkpD3ZoAq55yLWyNUY8y8hTHbcXtKJRwsvgVl5LKHtgze
         znqR6DPsuQJeVkJjfTiclnFh4w7JIJ+SrTNcv1R31Owww/6OweLa2r1x7wVbr4FbA0Hy
         beI83GufQ2Ot6+wqeYg6CvJ00ytzEH13lkIJ/ZLSY89IStL59zwGKqRkJ+nNpA26SPka
         mW2qoQSLLmftYR6vqy8B9EQDW8tQUwGcP3i/J74EQzx1josgCBVXUwaGKm4UOXX9ROZM
         37Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=xY34eWaGvxQUsZEqOZDOZXII9CHdy+Qb6FpxVsqvACA=;
        b=GKnzgT/rD/i2Xl6zJJxCyWBMaJSrMRUIsNel4PfyBpRv9L6Nrv3QxGqwzuYMbQrnwo
         flCUu9KYKX6Q1C1AxRtQN7JQmbyOoigiiwN4umnueMMX3RqjcHGDC2Nrs+Qbg+EOKOM9
         7lMQsxNo54txP17uc1LBl5BJSvfmkmfhUPRDmC3ihwH8qsbB3W3tEMjUUncQVp8Fsfpc
         rhy/h7VqEJU1WABlWIEzNZL3Gb2e0RxXmQmfWDwUdD6G2TXxVCIfZJSrtsoloNJz2y+y
         Xr1pxWAzdu+yAHwrIKmYII/H9UEgXX2S7KLpTc3bBMX0nE4u4ov0ROTHJY31N89fDpK8
         73Qg==
X-Gm-Message-State: AGRZ1gKeesnFwIUZbM2w6pAJyGlwy5GnPOPq26TpYvxCt7PQqOqVg+XH
        Q92WlxYu8RLkHK/qPIfuiLU=
X-Google-Smtp-Source: AJdET5fZB2RqThUpqOkqRHKZjRglUsOne0IKhY4COWz4kpIsxQAtG/IEbXtMaHt3V8uI13WBGneowA==
X-Received: by 2002:adf:aa05:: with SMTP id p5-v6mr11726305wrd.56.1541180682088;
        Fri, 02 Nov 2018 10:44:42 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (ekn166.neoplus.adsl.tpnet.pl. [83.21.181.166])
        by smtp.gmail.com with ESMTPSA id t134-v6sm6859762wmd.18.2018.11.02.10.44.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 10:44:41 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [RFC] Generation Number v2
References: <6367e30a-1b3a-4fe9-611b-d931f51effef@gmail.com>
        <xmqqy3ag13us.fsf@gitster-ct.c.googlers.com>
        <875zxil1if.fsf@evledraar.gmail.com>
        <6902dbff-d9f6-e897-2c20-d0cb47a50795@gmail.com>
Date:   Fri, 02 Nov 2018 18:44:39 +0100
In-Reply-To: <6902dbff-d9f6-e897-2c20-d0cb47a50795@gmail.com> (Derrick
        Stolee's message of "Wed, 31 Oct 2018 09:04:12 -0400")
Message-ID: <86a7mrxtko.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:
> On 10/31/2018 8:54 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Tue, Oct 30 2018, Junio C Hamano wrote:
>>> Derrick Stolee <stolee@gmail.com> writes:
>>>>
>>>> In contrast, maximum generation numbers and corrected commit
>>>> dates both performed quite well. They are frequently the top
>>>> two performing indexes, and rarely significantly different.
>>>>
>>>> The trade-off here now seems to be: which _property_ is more important,
>>>> locally-computable or backwards-compatible?
>>>
>>> Nice summary.
>>>
>>> As I already said, I personally do not think being compatible with
>>> currently deployed clients is important at all (primarily because I
>>> still consider the whole thing experimental), and there is a clear
>>> way forward once we correct the mistake of not having a version
>>> number in the file format that tells the updated clients to ignore
>>> the generation numbers.  For longer term viability, we should pick
>>> something that is immutable, reproducible, computable with minimum
>>> input---all of which would lead to being incrementally computable, I
>>> would think.
>>
>> I think it depends on what we mean by backwards compatibility. None of
>> our docs are saying this is experimental right now, just that it's
>> opt-in like so many other git-config(1) options.
>>
>> So if we mean breaking backwards compatibility in that we'll write a new
>> file or clobber the existing one with a version older clients can't use
>> as an optimization, fine.
>>
>> But it would be bad to produce a hard error on older clients, but
>> avoiding that seems as easy as just creating a "commit-graph2" file in
>> .git/objects/info/.
>
> Well, we have a 1-byte version number following the "CGPH" header in
> the commit-graph file, and clients will ignore the commit-graph file
> if that number is not "1". My hope for backwards-compatibility was
> to avoid incrementing this value and instead use the unused 8th byte.

How?  Some of the considered new generation numbers were backwards
compatibile in the sense that for graph traversal the old code for
(minimum) generation numbers could be used.  But that is for reading.
If the old client tried to update new generation number using old
generation number algorithm (assuming locality), it would write some
chimaera that may or may not work.

> However, it appears that we are destined to increment that version
> number, anyway. Here is my list for what needs to be in the next
> version of the commit-graph file format:

As a reminder, here is how the commit-graph format looks now [1]

  HEADER:
    4-byte signature:                  CGPH
    1-byte version number:             1
    1-byte Hash Version:               1 =3D SHA-1
    1-byte number (C) of "chunks":     3 or 4
    1-byte (reserved for later use)    <ignored>
  CHUNK LOOKUP:
    (C + 1) * 12 bytes listing the table of contents for the chunks
  CHUNK DATA:
    OIDF
    OIDL
    CDAT
    EDGE [optional, depends on graph structure]
  TRAILER:
    checksum

[1]: Documentation/technical/commit-graph-format.txt


> 1. A four-byte hash version.

Why do you need a four-byte hash version?  255 possible hash functions
is not enough?

> 2. File incrementality (split commit-graph).

This would probably require a segment lookup part, and one chunk of each
type per segment (or even one chunk lookup table per segment).  It may
or may not need generation number which can support segmenting (here
maximal generation numbers have the advantage); but you can assume that
if segment(A) > segment(B) then reach.ix(A) > reach.ix(B),
i.e. lexicographical-like sort.

> 3. Reachability Index versioning

I assume that you mean here versioning for the reachability index that
is stored in the CDAT section (if it is in a separate chunk, it should
be easy to version).

The easiest thing to do when encountering unknown or not supported
generation number (perhaps the commit-graph file was created in the past
by earlier version of Git, perahs it came from server with newer Git, or
perhaps the same repository is sometimes accessed using newer and
sometimes older Git version), is to set commit->generation_number to
GENERATION_NUMBER_ZERO, as you wrote in [2].

We could encode backward-compatibility (for using) somewhat, but I
wonder how much it would be of use.

[2]: https://public-inbox.org/git/61a829ce-0d29-81c9-880e-7aef1bec916e@gmai=
l.com/

> Most of these changes will happen in the file header. The chunks
> themselves don't need to change, but some chunks may be added that
> only make sense in v2 commit-graphs.

What I would like to see in v2 commit-graph format would be some kind
convention for naming / categorizing chunks, so that Git would be able
to handle unknown chunks gracefully.

In PNG format there are various types of chunks.  Quoting Wikipedia:

  Chunk types [in PNG format] are given a four-letter case sensitive
  ASCII type/name; compare FourCC. The case of the different letters in
  the name (bit 5 of the numeric value of the character) is a bit field
  that provides the decoder with some information on the nature of
  chunks it does not recognize.

  The case of the first letter indicates whether the chunk is critical
  or not. If the first letter is uppercase, the chunk is critical; if
  not, the chunk is ancillary. Critical chunks contain information that
  is necessary to read the file. If a decoder encounters a critical
  chunk it does not recognize, it must abort reading the file or supply
  the user with an appropriate warning.

Currently this is solved with the format version.  For given format
version some chunks are necessary (critical); if there would be another
type of chunk that must be understood, we can simply increase format
version.=20

  The case of the second letter indicates whether the chunk is "public"
  (either in the specification or the registry of special-purpose public
  chunks) or "private" (not standardised). Uppercase is public and
  lowercase is private. This ensures that public and private chunk names
  can never conflict with each other (although two private chunk names
  could conflict).

For Git this could be "official" and "experimental"... though I don't
see people sharing commit-graph files with experimental chunks that can
be used only by some local unpublished fork of Git.

  The third letter must be uppercase to conform to the PNG
  specification. It is reserved for future expansion. Decoders should
  treat a chunk with a lower case third letter the same as any other
  unrecognised chunk.

In short: reserved.  This could be the fate of all of those 4 flags that
we do not need.

  The case of the fourth letter indicates whether the chunk is safe to
  copy by editors that do not recognize it. If lowercase, the chunk may
  be safely copied regardless of the extent of modifications to the
  file. If uppercase, it may only be copied if the modifications have
  not touched any critical chunks.

If the data contained in the chunks is immutable, then it could be
copied when updating commit-graph file... but what to do with new
commits, with what to fill the data for a new commit for a copied
unknown chunk?  All zeros?  All ones?  Some value defined in the chunk
itself?

Best,
--=20
Jakub Nar=C4=99bski
