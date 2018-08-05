Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 824371F597
	for <e@80x24.org>; Sun,  5 Aug 2018 18:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbeHEU6u (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 16:58:50 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34932 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbeHEU6u (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 16:58:50 -0400
Received: by mail-io0-f196.google.com with SMTP id w11-v6so9205987iob.2
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 11:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iZmYms38T6DVWxMdIqsGyBaKamDuYgw/KbpFG++n7Mw=;
        b=q8/vo0dMHKHC8YWr3r5flagA2U3RdIAtrMOC21CaBtb565AVI51SIMVBtgnSECDaCs
         WJuvf4OmDO5SmbnqGcCNT16K8TORt+w+idwWXEBrStAMkCJyXlF16kxon/rYk6Jt3wIN
         WwD3Eau2FiaLd6wS6RPOM/lHPHNIrMtRCLmqH6MRUF/KNMEsJFuWIntR6bO7W5kGdLHo
         YUsT5y56Cqn/K6ujH2P5psO/FXTXs6QROhrp56CB6/DpQ4uYhZwMJzfB2ZpNWC2dMgGQ
         /K7uOZ0/4phti3hSU1+WA0WAof5u9Y5pPCgj4/ob0mDmwhBMBYlogd8E7Z7Kx646gIZc
         ffsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iZmYms38T6DVWxMdIqsGyBaKamDuYgw/KbpFG++n7Mw=;
        b=V4HeWyZjC92RDl6IQXBWIOUh9h/dOVG7cYykiPOq6HChMAu0bU6xj0fzybrk22Q8f6
         kl1uK85QuNRzLPtXPwxM+0SggrPrqA5uzFyAN+4SwUsl5+wydtfQWjMEfIywBZWyI1Zv
         F0q9a/FI0kuldDUGbravqHIiq4hUAVEmUbDsLXE68j2bd2+YR5rnJByAiQzDjlKvhdbv
         8a1Rx33J8uBo9AqdWSfEV5c37yR2GR+CKMgmmTDi9s6Ar5yD7s18t3+reSkwjtzOq6wk
         bIfltXm13+JEOZEjQO2/dCIFcSMbfkv4vkfWGDhB7uWlg4Vz7egsyeDaTXph4M1X/nPL
         LrNQ==
X-Gm-Message-State: AOUpUlETEXhcwlyr1ijBw5jZtMeSdVl/mEkAr25Ui4ul/fHpSYUTKzGB
        dhUr2bEbtPtcClt5VlHKSs/yntRMcEWu95lkzw4=
X-Google-Smtp-Source: AA+uWPzSW5pcBf2xumv9tCf+p05V9jfGXQtu4UV8m4LJG8Jx0QwUiOM4qrvmOsjfa9mufy6bh0eYvvqA89kAFcORxkA=
X-Received: by 2002:a6b:3042:: with SMTP id w63-v6mr12502876iow.223.1533495199883;
 Sun, 05 Aug 2018 11:53:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:228d:0:0:0:0:0 with HTTP; Sun, 5 Aug 2018 11:53:19 -0700 (PDT)
In-Reply-To: <CACsJy8AzksB=rfaX_dfboMXHjqj6gj+erdF6eRFAKmWA1-3PUg@mail.gmail.com>
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
 <20180722054836.28935-3-chriscool@tuxfamily.org> <CACsJy8AzksB=rfaX_dfboMXHjqj6gj+erdF6eRFAKmWA1-3PUg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 5 Aug 2018 20:53:19 +0200
Message-ID: <CAP8UFD2frOjmZoOfWW-93xewA6LS5zTEisNr4QDz2FNQE2DY_A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] Add delta-islands.{c,h}
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 22, 2018 at 10:50 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Jul 22, 2018 at 7:51 AM Christian Couder
> <christian.couder@gmail.com> wrote:

>> diff --git a/pack-objects.h b/pack-objects.h
>> index edf74dabdd..8eecd67991 100644
>> --- a/pack-objects.h
>> +++ b/pack-objects.h
>> @@ -100,6 +100,10 @@ struct object_entry {
>>         unsigned type_:TYPE_BITS;
>>         unsigned no_try_delta:1;
>>         unsigned in_pack_type:TYPE_BITS; /* could be delta */
>> +
>> +       unsigned int tree_depth; /* should be repositioned for packing? */
>> +       unsigned char layer;
>> +
>
> This looks very much like an optional feature. To avoid increasing
> pack-objects memory usage for common case, please move this to struct
> packing_data.

As you can see the patch 6/6 (in the v2 of this patch series that I
just sent) moves `unsigned int tree_depth` from 'struct object_entry'
to 'struct packing_data'. I am not sure that I did it right and that
it is worth it though as it is a bit more complex.

About `unsigned char layer` I am even less sure that it's worth it for
the following reasons:

- 'struct object_entry' contains bit fields as its last members and
then the following comment:

    /*
     * pahole results on 64-bit linux (gcc and clang)
     *
     *   size: 80, bit_padding: 20 bits, holes: 8 bits
     *
     * and on 32-bit (gcc)
     *
     *   size: 76, bit_padding: 20 bits, holes: 8 bits
     */

I am not sure if this comment is still up to date, but if it true
maybe there is enough space in the padding to add 'layer' as a 8 bit
bit field somewhere without increasing the size of 'struct
object_entry'.

- 'layer' is used in add_to_write_order() which is called from many
places in add_descendants_to_write_order() and compute_write_order()
for example like this:

            for (s = DELTA_SIBLING(e); s; s = DELTA_SIBLING(s)) {
                add_to_write_order(wo, endp, s);
            }

So it seems to me that moving 'layer' to 'struct packing_data' would
require changing the DELTA_SIBLING macros or adding a hack to easily
find the index in an array corresponding to a 'struct object_entry'.

- I don't see why it is different from other fields in 'struct
object_entry' that are also used in compute_write_order(), for
example:

    uint32_t delta_idx;    /* delta base object */
    uint32_t delta_child_idx; /* deltified objects who bases me */
    uint32_t delta_sibling_idx; /* other deltified objects who ... */

Would we also want to move these fields to 'struct packing_data'? Why
or why not? If we want to move them, then it might be a good idea to
do all the moving at the same time to make sure we get something
coherent.

Thanks,
Christian.
