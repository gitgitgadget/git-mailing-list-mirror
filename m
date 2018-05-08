Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56ECF200B9
	for <e@80x24.org>; Tue,  8 May 2018 18:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933431AbeEHSWm (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 14:22:42 -0400
Received: from mail-ot0-f170.google.com ([74.125.82.170]:44342 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933042AbeEHSWk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 14:22:40 -0400
Received: by mail-ot0-f170.google.com with SMTP id g7-v6so37188327otj.11
        for <git@vger.kernel.org>; Tue, 08 May 2018 11:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=o2jr0gXy44Cso5ZtpVcZ8kytbkPqHikBrbb7K6MCSeA=;
        b=jsRI+edN7pU9Ur2uliOOvAHdaBuEhzditRZwlFJE4LVs+GNA2RKB7663DdL4wuV//f
         5sW7fXVwJn/ZYzeGIQ4aJFFaC10rNZ+ItgEx8dyCpbLEM8H17boRhEsyEDxPcMc2nRCN
         2TPRKzPKQ8Yg0xCZrBa6OY11nS9THcx84GG10vwny6F1E4wNRyNgLzyZPkW6HeRw1g9U
         L7cFDoi4/MFDVQPWWVEw2m7shpmCTA4zV/R0jVG8U7ufRl7dNIhwQZuTsgtKgR8ItaTf
         bdWkAvmoJRU2twvErNsEo3jDYwxVqNgYSwENvlQBo/eN4Lv0POMBmWWX2bOPlB1zQaOR
         unng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=o2jr0gXy44Cso5ZtpVcZ8kytbkPqHikBrbb7K6MCSeA=;
        b=PYUYedYdfZYJOpkTB12Nu5w7pgQ5MFe7EOXoARUhmU/Z9iJ2R2FcoO+oN+r6wBFANr
         3PNEG7sq2IToiW37FJoEhB0IIBzbLXL6QBiuRMUBJd0WKLaW7FzJxcpuB3YybP7SY4eF
         dJXyKwO8VhN+gbbjsPA0x2TNjxEpimC+m+yc+jwukIcY62yr23YNIwQUt5j1NkNQDRho
         hx5GGu6ixX+G4Z9u7Udn0f9PsSSDJeSuioBmAgvdkHpEmIt0MiBNuZJx97veOTJ5uNrX
         U8x0GQ7W0IDIsc4hTi1l9SAipWnBft4DsSXXYQStjuPiRhCI5vdxth8oKL3pLw1mL/HY
         FSWA==
X-Gm-Message-State: ALQs6tCjNX8KvecRjBAvg9zuxWMtn/834kuUAzUNHSx/jxojl3NVSpgo
        4/eWqAf85zWzIM3o4XKpfl4DQqUllUJ8obRAqqi1TQ==
X-Google-Smtp-Source: AB8JxZorN930u2bSO5jI3VsJ/g1U96z40sMG40N+XBtrS+wjnRGtQCzCEWTP7658LLqJCYhd14YwyRGqOOE5jdR0LqM=
X-Received: by 2002:a9d:e8f:: with SMTP id 15-v6mr21663929otj.14.1525803760162;
 Tue, 08 May 2018 11:22:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Tue, 8 May 2018 11:22:09 -0700 (PDT)
In-Reply-To: <CAGZ79kZiwX-QFnkTfRHby38GYBDwj-0Dyv3_PWPXtnWr+112CA@mail.gmail.com>
References: <CACsJy8AkfNfupdr1MqZSaxNCbPwBVzxXNMMqPvwif0NtuCxDaA@mail.gmail.com>
 <20180508155627.19245-1-pclouds@gmail.com> <CAGZ79kZiwX-QFnkTfRHby38GYBDwj-0Dyv3_PWPXtnWr+112CA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 8 May 2018 20:22:09 +0200
Message-ID: <CACsJy8A10qixJ7YtJKJejp1t49aBZFDn7CjSTiaq8GeVHuxiOQ@mail.gmail.com>
Subject: Re: [PATCH] pack-format.txt: more details on pack file format
To:     Stefan Beller <sbeller@google.com>
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

On Tue, May 8, 2018 at 7:23 PM, Stefan Beller <sbeller@google.com> wrote:
>>  While at there, I also add some text about this obscure delta format.
>>  We occasionally have questions about this on the mailing list if I
>>  remember correctly.
>
> Let me see if I can understand it, as I am not well versed in the
> delta format, so ideally I would understand it from the patch here?

Well yes. I don't expect my first version to be that easy to
understand. This is where you come in to help ;-)

>> +Valid object types are:
>> +
>> +- OBJ_COMMIT (1)
>> +- OBJ_TREE (2)
>> +- OBJ_BLOB (3)
>> +- OBJ_TAG (4)
>> +- OBJ_OFS_DELTA (6)
>> +- OBJ_REF_DELTA (7)
>> +
>> +Type 5 is reserved for future expansion.
>
> and type 0 as well, but that is not spelled out?

type 0 is invalid. I think in some encoding it's not even possible to
encode zero. Anyway yes it should be spelled out.

>
>> +Deltified representation
>
> Does this refer to OFS delta as well as REF deltas?

Yes. Both OFS and REF deltas have the same "body" which is what this
part is about. The differences between OFS and REF deltas are not
described (in fact I don't think we describe what OFS and REF deltas
are at all).

>> is a sequence of one byte command optionally
>> +followed by more data for the command. The following commands are
>> +recognized:
>
> So a Deltified representation of an object is a 6 or 7 in the 3 bit type
> and then the length. Then a command is shown how to construct
> the object based on other objects. Can there be more commands?
>
>> +- If bit 7 is set, the remaining bits in the command byte specifies
>> +  how to extract copy offset and size to copy. The following must be
>> +  evaluated in this exact order:
>
> So there are 2 modes, and the high bit indicates which mode is used.
> You start describing the more complicated mode first,
> maybe give names to both of them? "direct copy" (below) and
> "compressed copy with offset" ?

I started to update this more because even this text is hard to get
even to me. So let's get the background first.

We have a source object somewhere (the object name comes from ofs/ref
delta's header), basically we have the whole content. This delta
thingy tells us how to use that source object to create a new (target)
object.

The delta is actually a sequence of instructions (of variable length).
One is for copying from the source object. The other copies from the
delta itself (e.g. this is new data in the target which is not
available anywhere in the source object to copy from). The last bit of
the first byte determines what instruction type it is.


>> +  - If bit 0 is set, the following byte contains bits 0-7 of the copy
>> +    offset (this also resets all other bits in the copy offset to
>> +    zero).
>> +  - If bit 1 is set, the following byte contains bits 8-15 of the copy
>> +    offset.
>> +  - If bit 2 is set, the following byte contains bits 16-23 of the
>> +    copy offset.
>> +  - If bit 3 is set, the following byte contains bits 24-31 of the
>> +    copy offset.
>
> I assume these bits are exclusive, i.e. if bit 3 is set, bits 0-2 are not
> allowed to be set. What happens if they are set, do we care?
>
> If bit 3 is set, then the following byte contains 24-31 of the copy offset,
> where is the rest? Do I wait for another command byte with
> bits 2,1,0 to learn about the body offsets, or do they follow the
> following byte? Something like:
>
>   "If bit 3 is set, then the next 4 bytes are the copy offset,
>   in network byte order"

My first attempt at "translating to English" is like a constructing C
from assembly: it's horrible.

The instruction looks like this

        bit      0        1        2        3       4      5      6
  +----------+--------+--------+--------+--------+------+------+------+
  | 1xxxxxxx | offset | offset | offset | offset | size | size | size |
  +----------+--------+--------+--------+--------+------+------+------+

Here you can see it in its full form, each box represents a byte. The
first byte has bit 7 set as mentioned. We can see here that offsets
(where to copy from in the source object) takes 4 bytes and size (how
many bytes to copy) takes 3. Offset size size is in LSB order.

The "xxxxxxx" part lets us shrink this down. If the offset can fit in
16 bits, there's no reason to waste the last two bytes describing
zero. Each 'x' marks whether the corresponding byte is present. The
bit number is in the first row. So if you have offset 255 and size 1,
the instruction is three bytes 10010001b, 255, 1. The octets on "bit
column" 1, 2, 3, 5 and 6 are missing because the corresponding bit in
the first bit is not set.

>> +  - If bit 4 is set, the following byte contains bits 0-7 of the copy
>> +    size (this also resets all other bits in the copy size to zero_.
>> +  - If bit 5 is set, the following byte contains bits 8-15 of the copy
>> +    size.
>> +  - If bit 6 is set, the following byte contains bits 16-23 of the
>> +    copy size.
>
> bits 4-7 seem to be another group of mutually exclusive bits.
> The same question as above:
> If bit 6 is set, where are bits 0-15 of the copy size?

I think this is a corner case in this format. I think Nico meant to
specify consecutive bytes: if size is 2 bytes then you have to specify
_both_ of them even if the first byte could be zero and omitted.

The implementation detail is, if bit 6 is set but bit 4 is not, then
the size value is pretty much random. It's only when bit 4 is set that
we first clear out "size" and start adding bits to it.

>
>> +
>> +  Copy size zero means 0x10000 bytes.
>
> This is an interesting caveat. So we can only copy 1-0x10000 bytes,
> and cannot express to copy 0 bytes?

Yes. There's no point to copy nothing. And it saves space to not
specify "size" at all. I think this is meant to copy a very large part
from the source, so you just continue to copy a series of 0x10000
chunks.

>
>> The data from source object at
>> +  the given copy offset is copied back to the destination buffer.
>> +
>> +- If bit 7 is not set, it is the copy size in bytes. The following
>> +  bytes are copied to destination buffer
>> +- Command byte zero is reserved for future expansion.
>
> Thanks,
> Stefan



-- 
Duy
