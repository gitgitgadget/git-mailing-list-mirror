Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E1681F404
	for <e@80x24.org>; Thu, 16 Aug 2018 06:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388305AbeHPI6L (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 04:58:11 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40187 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbeHPI6L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 04:58:11 -0400
Received: by mail-it0-f65.google.com with SMTP id h23-v6so5170845ita.5
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 23:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vrcEc5xjmmmAVDel7Snfz7PZRAzIIygYn6W+0O1utIA=;
        b=Qh1vgzDuiHCzY3rhtagI8JJIodF5OEx0tiZxxA9JirKP9gE+pmv+SrUaDix8agGEqV
         3kPEaX//Eb7ECXS5dDzhioAFOV7lkqqz/t88qxynbSdxrjHGh3egrHRHZQ4iYU5cJWHn
         BSJ2/tBQ4k1VJH0kBe6udId7Gd0QEvn+Swt0ydpB1wLfrJqBGOzOvRYeFrP7k42F7LRb
         C9sRi4cNd/tl27N5rFStm1HUmT0l/1fiGkp/bs1DmiJ1PcKAMKThECftHhiLqEFOU1VU
         s2NaT/Dy+cRJQpw7tqI6/0DMMrap8m1024AWxacDDScEV21Y2hpW9KAMA3pnzM33Jc4U
         fWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vrcEc5xjmmmAVDel7Snfz7PZRAzIIygYn6W+0O1utIA=;
        b=n9sNeQY2O7aoLqEsCrlB3hB73ALgr6YH55Vb/JLTsb3rIyK24t4MpASbaicRi8wTJx
         pLd0c7+Bl/TyARevS9HcSxGeCaYT0UyVuMjXT4hHP7By78lAoRES5eCe+ubJViYS6ST3
         k+BuhQWgIsTAfJ8akmJt+tuG4NOOfvZierS0vwzQmFJkgK+Cglq5SGy24jhNRTF9X8Jo
         pAPW6ltYP0l+UUj04O0doLa7+7+6KUgo1NTK5Dw2boaH/DMtHEWoZtH/1X4/EtVr2A7M
         WDQ9+PooFoYtKaVXrr49kC7m1TLfe7FSjJrW5d8UB4qaZDexuuCcpvewObcdaCUwvCyZ
         vJTw==
X-Gm-Message-State: AOUpUlFzgpMecdDpwCgFNjgozYy0RrkgZb3DXCYv4NDyc3IZYSOIk4ix
        RlEimSpB9JbCWFpTi8I/ZklLNrN2ndoY7Q4bj8g=
X-Google-Smtp-Source: AA+uWPy4RhPyH7ruOF23IlQrqPj3IWYT3NbwrjV20e18/X4JB6sXxkfu65DxLdA5rGPjYxVB0/rpiEPbIP1bhmhlWxM=
X-Received: by 2002:a24:54d:: with SMTP id 74-v6mr19589952itl.96.1534399326471;
 Wed, 15 Aug 2018 23:02:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:228d:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 23:02:05
 -0700 (PDT)
In-Reply-To: <20180813181149.GA10013@sigill.intra.peff.net>
References: <20180812051151.6425-1-chriscool@tuxfamily.org>
 <20180812051151.6425-2-chriscool@tuxfamily.org> <2113c74c-b230-6ea1-a980-d6d008bac759@ramsayjones.plus.com>
 <CAP8UFD1tX+rAxQc47o-50Kzo6hnX9mTWH2BPSq9HiO_OgBzYTw@mail.gmail.com>
 <7a780fe9-e8bf-804a-82e6-8df81cd5c41c@ramsayjones.plus.com> <20180813181149.GA10013@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 16 Aug 2018 08:02:05 +0200
Message-ID: <CAP8UFD1A8Z_Eh+N8204zSUG5Pnji+5=uwOiDr+LrbFGFJ-qPtg@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] Add delta-islands.{c,h}
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        SZEDER Gabor <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 8:11 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Aug 13, 2018 at 01:17:18PM +0100, Ramsay Jones wrote:
>
>> >>> +struct island_bitmap {
>> >>> +     uint32_t refcount;
>> >>> +     uint32_t bits[];
>> >>
>> >> Use FLEX_ARRAY here? We are slowly moving toward requiring
>> >> certain C99 features, but I can't remember a flex array
>> >> weather-balloon patch.
>> >
>> > This was already discussed by Junio and Peff there:
>> >
>> > https://public-inbox.org/git/20180727130229.GB18599@sigill.intra.peff.net/
>>
>> That is a fine discussion, without a firm conclusion, but I don't
>> think you can simply do nothing here:
>>
>>   $ cat -n junk.c
>>        1      #include <stdint.h>
>>        2
>>        3      struct island_bitmap {
>>        4              uint32_t refcount;
>>        5              uint32_t bits[];
>>        6      };
>>        7
>>   $ gcc --std=c89 --pedantic -c junk.c
>>   junk.c:5:11: warning: ISO C90 does not support flexible array members [-Wpedantic]
>>     uint32_t bits[];
>>              ^~~~
>>   $ gcc --std=c99 --pedantic -c junk.c
>
> Right, whether we use the FLEX_ALLOC macros or not, this needs to be
> declared with FLEX_ARRAY, not an empty "[]".

Ok, it will use FLEX_ARRAY in the reroll I will send soon.

Thanks Ramsay and Peff!
