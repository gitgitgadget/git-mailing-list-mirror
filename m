Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31DF81F89D
	for <e@80x24.org>; Thu, 27 Jul 2017 10:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751028AbdG0KEu (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 06:04:50 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:38893 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750965AbdG0KEt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2017 06:04:49 -0400
Received: by mail-pg0-f53.google.com with SMTP id k190so30588647pgk.5
        for <git@vger.kernel.org>; Thu, 27 Jul 2017 03:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Qb7S2Zi/5XpBBcushQphQN/YAPcZlp4zryOvQc4h3Uc=;
        b=QVaWnoMnwktjkIwhmHPJ6RUQjqsDyagRouQxHIFDFCQrKrl85VMk9vmg9QY0CC21hz
         BM7yiPRB4PQhGHZwJSLtCyU9yzOkVQ8dj5LjzWV/5ptKUgkbMx7ZzZFmtAhSZoQf8UK3
         DkJNa+VhS6TGqdgV+C2E7UfP3H4RwkkklqYqATBTB2a2yZ4R2IlE+GDc+KxW99FFZkH1
         /SMf27T/0l+KDFGEh/G520JXL6cB4fq20BKsJR11MLkjkMycnhM6tISJ/3ohyQY737Ey
         xsxqV7zGZ7oGJHJLWwdbiP6Y05bqMGty+AgPGGqw9nXFuGJIACnOGhSdxTPF8n3kNwFS
         dYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Qb7S2Zi/5XpBBcushQphQN/YAPcZlp4zryOvQc4h3Uc=;
        b=hssisFvlmIRwhZ/eAH+Y9RuPSItPTJcyBhB4SSct1HORdmL0OFf48Na9swNTX/JRE5
         i9WVH1S7E+GrCpzFbvXRrbGWrC0XTW/3TD8xDbK5cVFwnavm3cLKONI0xvB5aFI6O/MM
         VKgAmcHqvS8fdywSXcsLM9f56zrOmniXkPBFFmeW6uGcUclXn5x1nsf2HEuf7KDpjbJ8
         /CpF84FhHmR7UoHuYw4usD+GoXxrym2tJFKY7Es3ry7sg3LMpjJiJaV97N2KNdppF3/w
         a0R31JfBIStuigu2bu3oaSXGrx+Ppo8qZkr/8MDAfWcnJdRCIitI4SYJC0qdhQpRVVPe
         bvkA==
X-Gm-Message-State: AIVw112smK6N9lFN9C+K4I3HAQTpaTpB5OTT0jO8R7/8c6wX28fkpMTv
        75AHFkoFSkwnhy6qLZi+UEW/fLB4/Zzh
X-Received: by 10.99.44.138 with SMTP id s132mr3535183pgs.318.1501149888827;
 Thu, 27 Jul 2017 03:04:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.44 with HTTP; Thu, 27 Jul 2017 03:04:48 -0700 (PDT)
In-Reply-To: <CAJo=hJuCXFem8saH9kgBu1ROV3uuhRxHcHXz_Bp7xB+taW5S=Q@mail.gmail.com>
References: <CAJo=hJvxWg2J-yRiCK3szux=eYM2ThjT0KWo-SFFOOc1RkxXzg@mail.gmail.com>
 <CAGZ79kZ48zTsHxrW-fvHRFQih=vBuywExSxA8a_=wzjdJPbtrg@mail.gmail.com> <CAJo=hJuCXFem8saH9kgBu1ROV3uuhRxHcHXz_Bp7xB+taW5S=Q@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 27 Jul 2017 03:04:48 -0700
Message-ID: <CAGZ79kaLN-_13Y4UifZXy6A1A2Peud90z=oEOw9_1DaXHRWKbQ@mail.gmail.com>
Subject: Re: reftable [v3]: new ref storage format
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 24, 2017 at 4:00 PM, Shawn Pearce <spearce@spearce.org> wrote:
> On Mon, Jul 24, 2017 at 3:22 PM, Stefan Beller <sbeller@google.com> wrote:

>>> #### index record
>>>
>>> An index record describes the last entry in another block.
>>> Index records are written as:
>>>
>>>     varint( prefix_length )
>>>     varint( (suffix_length << 3) | 0 )
>>>     suffix
>>>     varint( block_offset )
>>>
>>> Index records use prefix compression exactly like `ref_record`.
>>>
>>> Index records store `block_offset` after the suffix, specifying the
>>> offset in bytes (from the start of the file) of the block that ends
>>> with this reference.
>>
>> Instead of hardcoding the "0" in the last 3 bits, maybe pick one
>> of the reserved bit patterns to be there? I would imagine this
>> makes debugging easier:
>>
>>     0x5? Hah that must be an index block I have been
>>     looking at the wrong block!
>
> This is an excellent suggestion. I'll include it in the next iteration.

I was thinking about this a bit more and wondering if this would
allow mixing all sorts of entries in the same block. Think about one
of the most common cases client side:

    git commit -m "just a lonely ref update, no fancy stuff"

For that we need (a) a single ref update and (b) now that the
format evolved a single reflog entry, maybe (c) an obj entry, too.

I just realize that in this case we'd crank down the block size
such that there is very little padding required, but I still wonder
if it would be possible to omit the second (and third) block,
but rather go for a "m"ixed block containing just these 3 entries.

Additionally by setting the block_size to a special value "0",
we could indicate the omission of a footer, such that a single
ref update reftable is super small.
