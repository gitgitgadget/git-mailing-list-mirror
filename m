Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B797E200B9
	for <e@80x24.org>; Tue,  8 May 2018 18:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755402AbeEHS6W (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 14:58:22 -0400
Received: from mail-yb0-f180.google.com ([209.85.213.180]:35772 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752098AbeEHS6V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 14:58:21 -0400
Received: by mail-yb0-f180.google.com with SMTP id j143-v6so2403149ybg.2
        for <git@vger.kernel.org>; Tue, 08 May 2018 11:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rQvLm4wVYWgWrOoM45iWBoomjiRe4nH8U3g3AbxX0sk=;
        b=tFlw7GV1tF+PnJ3UHmB40OPOkiYJBVBGZ+kX8kv7z38Oq7Q+7rBbg7pfNp6p2cZRmB
         4JgGdejGGgGlAqd+erXI20OTV+9OFPYk4TK3f9/HZrLEGZEXgyueqnRVr0tqo8E/6kBh
         1yCkeQTjvChfZMXKckgA0x/x20OZLamtGKcSr5po4EhfJ5heWp4Dcc3REb6jPB1ZDSIZ
         yRgfarIYSmY1NseWUJ0D0ay5PVDQ3AN9yRMbJdjYgtNYdeDB7UWQ2JzB17v//YF+B/45
         x3gEQZ/5Ipm1L9+DQXVPgkE/I7Bu0gUkmZjzgWE+isEuHpukWjomlF/elWJuga4NrAUP
         lfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rQvLm4wVYWgWrOoM45iWBoomjiRe4nH8U3g3AbxX0sk=;
        b=L5qSQG0I/7DI1FC2grRKJfXQMMMehNypFyfcbibGYVwxRr6ARwDCm5hGlbAByPHBrr
         YS9SOo/96+oLunY79KuzCqjDyIXIFLkN2POt58BouZjSxQ6kR+8TieMIlrDcdCrN7g3W
         Ge8kPoordY2uRwT05lwioKND1LakrMb4NQ1qdJT7kwJouEERc3nPuTBCYo1tW2dDqRFW
         wyDxUx6JuX/cxVXQLg1KJIszxAgpV4lbAnhVx4PP8VEQRDdIcbZXu6VUnVDZoHy6XFFr
         k6OQCaDKefZSSyyk/iI8NZHOQcfQnamydVzaS59uEMFQ5YC4hsBXfQxkE7LRp3Urc8MF
         IBlA==
X-Gm-Message-State: ALQs6tBhWMtq8bJx544i1V1vJdb0q1EiVvG6mpi0qdEs8pdcTQT746bi
        SdtvdP+AqDT635LyZhoqViG4v1IFsZe4/KewuIvTfifp
X-Google-Smtp-Source: AB8JxZq31KsM3od4ZFvEEyp/GzlA5lgMPufdP3YbX9wMd4cpXWUpOoJu577mVD8hDnHBQFrxk0HXldIiSycvPDM8t9I=
X-Received: by 2002:a25:3bc5:: with SMTP id i188-v6mr23436319yba.352.1525805900752;
 Tue, 08 May 2018 11:58:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Tue, 8 May 2018 11:58:20 -0700 (PDT)
In-Reply-To: <CACsJy8A10qixJ7YtJKJejp1t49aBZFDn7CjSTiaq8GeVHuxiOQ@mail.gmail.com>
References: <CACsJy8AkfNfupdr1MqZSaxNCbPwBVzxXNMMqPvwif0NtuCxDaA@mail.gmail.com>
 <20180508155627.19245-1-pclouds@gmail.com> <CAGZ79kZiwX-QFnkTfRHby38GYBDwj-0Dyv3_PWPXtnWr+112CA@mail.gmail.com>
 <CACsJy8A10qixJ7YtJKJejp1t49aBZFDn7CjSTiaq8GeVHuxiOQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 8 May 2018 11:58:20 -0700
Message-ID: <CAGZ79ka2rEptsZKS+U-3ZNf4+R8b98f0E+ECdpndhb=JXLNLdQ@mail.gmail.com>
Subject: Re: [PATCH] pack-format.txt: more details on pack file format
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> +Deltified representation
>>
>> Does this refer to OFS delta as well as REF deltas?
>
> Yes. Both OFS and REF deltas have the same "body" which is what this
> part is about. The differences between OFS and REF deltas are not
> described (in fact I don't think we describe what OFS and REF deltas
> are at all).

Maybe we should?

>
>>> is a sequence of one byte command optionally
>>> +followed by more data for the command. The following commands are
>>> +recognized:
>>
>> So a Deltified representation of an object is a 6 or 7 in the 3 bit type
>> and then the length. Then a command is shown how to construct
>> the object based on other objects. Can there be more commands?
>>
>>> +- If bit 7 is set, the remaining bits in the command byte specifies
>>> +  how to extract copy offset and size to copy. The following must be
>>> +  evaluated in this exact order:
>>
>> So there are 2 modes, and the high bit indicates which mode is used.
>> You start describing the more complicated mode first,
>> maybe give names to both of them? "direct copy" (below) and
>> "compressed copy with offset" ?
>
> I started to update this more because even this text is hard to get
> even to me. So let's get the background first.
>
> We have a source object somewhere (the object name comes from ofs/ref
> delta's header), basically we have the whole content. This delta
> thingy tells us how to use that source object to create a new (target)
> object.
>
> The delta is actually a sequence of instructions (of variable length).

The previous paragraph and this sentence are great for my understanding.
thanks! (Maybe keep it in a similar form around?)

> One is for copying from the source object.

ok that makes sense. I can think of it as a "HTTP range request", just
optimized for packfiles and the source is inside the same pack.
So it would say "Goto object <sha1> and copy bytes 13-168 here"

> The other copies from the
> delta itself

itself means the same object here, that we are describing here?
or does it mean other deltas?

> (e.g. this is new data in the target which is not
> available anywhere in the source object to copy from).




>
> The instruction looks like this
>
>         bit      0        1        2        3       4      5      6
>   +----------+--------+--------+--------+--------+------+------+------+
>   | 1xxxxxxx | offset | offset | offset | offset | size | size | size |
>   +----------+--------+--------+--------+--------+------+------+------+
>
> Here you can see it in its full form, each box represents a byte. The
> first byte has bit 7 set as mentioned. We can see here that offsets
> (where to copy from in the source object) takes 4 bytes and size (how
> many bytes to copy) takes 3. Offset size size is in LSB order.
>
> The "xxxxxxx" part lets us shrink this down.

.. by indicating how much prefix we can skip and assume it be all zero(?)

> If the offset can fit in
> 16 bits, there's no reason to waste the last two bytes describing
> zero. Each 'x' marks whether the corresponding byte is present.

So for a full instruction (as above), we'd have to

1 1111 111 <4 bytes offset> <3 bytes size>

for smaller instructions we have

1 1100 100 <2 bytes offset> <1 byte size>
and here the offset is in range 0..64k and
the size is 1-255 or 0x10000 ?


Modes to skip bytes in between are not allowed, e.g.
1 1101 101 < 3 bytes of offsets> <2 bytes of size>
and the missing bytes would be assumed to be 0?

> The
> bit number is in the first row. So if you have offset 255 and size 1,
> the instruction is three bytes 10010001b, 255,

Oh it is the other way round, the size will be just one byte,
indicating we can have a range of 1-255 or 0x10000 and an
offset of 0..255.

>
> I think this is a corner case in this format. I think Nico meant to
> specify consecutive bytes: if size is 2 bytes then you have to specify
> _both_ of them even if the first byte could be zero and omitted.

So it is not a mutually exclusive group, but a sequence (similar as in
git-bisect), where we start with 0 and end with exactly one edge
in between (sort of, we can also start with 1, then we have to have
all 1s)

> The implementation detail is, if bit 6 is set but bit 4 is not, then
> the size value is pretty much random. It's only when bit 4 is set that
> we first clear out "size" and start adding bits to it.

That sounds similar to what I spelled out above.

Thanks for taking on the documentation here.
The box with numbers really helped me!

Stefan
