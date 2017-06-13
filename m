Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72E3C20282
	for <e@80x24.org>; Tue, 13 Jun 2017 10:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbdFMKQZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 06:16:25 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:35289 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752198AbdFMKQX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 06:16:23 -0400
Received: by mail-it0-f53.google.com with SMTP id m62so38032873itc.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 03:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+sOE7MCfpYfw8QbjRUnAjoOnTvytpeJzogplUmTmI48=;
        b=Mf56nZfUCqKA0HxI7xHOxilTIngtjs3qjl1c+kqGQlNNLWZn3KdHk6OlZZJEvripFn
         N9fbaBLGkD/WJnJC4EfZBYaHdkxa+6uotMEKN+KTqKSYwXPO8VTNKNamYV1Srk+u8zJx
         fqN7pYtxMhD2pqkuXoMxylMyKxUT/kX9dcxPbwJ5W+3p21rXO/f470gs2er32/Kmp9fN
         9cirz+F4cPQmFDnFn9KhVWQ+89OHqCEedTlJMMl3j6JC72/kbpCzUSdR80U2qENdcc3U
         /SqrOOCvpCJBDXKNkZVtCTFdvus1/oXUEfsRUtrOKY32Szz43pulS75vmyGkFKfeZ7lG
         FMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+sOE7MCfpYfw8QbjRUnAjoOnTvytpeJzogplUmTmI48=;
        b=H0ZWZjsIkIx4HtwEIdlX/DhjYMY74CnmOTWl9dhQux+XnagP80e7qxZx1BkNqvqxLd
         BF0elXo3IiTcE7t3dLLgBt6supdwKUsHUOmXdsyK9xAXxQ5CAjJ5is5gDPVjmk4Zv+kD
         EiPgVg4BUbw6wMo1Hb1QnwmAOgQWApQzfoXxVX253ad44THK4SkELxcv04ixyqzNV8Vd
         O5jcDWQxTadG2+WQtFa1wlN+UZXkMO9PRwwAMFMrh6Wfu7tj1x4kPpdHZVsd0OTzmo4o
         8a0eBIoUJBLi7ctyTz1f5hcynhu3zFgOAwekEcqfepObWg/+knJuIwvV1hZofBRy+fpb
         giPA==
X-Gm-Message-State: AKS2vOxvkCeq6a/XjstXbVgi63ueT5CYH9vlb30ksLlHm4QXh6mbay2v
        bw/Wjson+hR0+B3gpzXl1XgYNPwN8w==
X-Received: by 10.36.74.148 with SMTP id k142mr13195328itb.94.1497348982435;
 Tue, 13 Jun 2017 03:16:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Tue, 13 Jun 2017 03:16:01 -0700 (PDT)
In-Reply-To: <c7532160-53eb-a0c5-94e6-483aadf0cfc5@web.de>
References: <20170602223003.6etkdnnogb2jmoh3@sigill.intra.peff.net>
 <22833.60191.771422.3111@a1i15.kph.uni-mainz.de> <20170602225148.drkl7obwhzypgjtr@sigill.intra.peff.net>
 <a8b789e6-d0cd-6d96-1bfb-ccc5bc174013@web.de> <20170607081729.6pz5yo2hmp4fwuas@sigill.intra.peff.net>
 <662a84da-8a66-3a37-d9d2-4ff8b5f996c3@web.de> <xmqq37b5qly8.fsf@gitster.mtv.corp.google.com>
 <CACBZZX5ofJC70S09rfL_EMK2KWAoPCMun1eisi+CXeX=FSwy6Q@mail.gmail.com>
 <22846.51138.555606.729612@a1i15.kph.uni-mainz.de> <CACBZZX6AH2nEGPHMq6XOLDxr4SH9v-zT_YGovLXN_ZQ+fB345g@mail.gmail.com>
 <20170612182045.z4d37ph5uqqhwmas@sigill.intra.peff.net> <CACBZZX5OQc45fUyDVayE89rkT=+8m5S4efSXCAbCy7Upme5zLA@mail.gmail.com>
 <c7532160-53eb-a0c5-94e6-483aadf0cfc5@web.de>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 13 Jun 2017 12:16:01 +0200
Message-ID: <CACBZZX4w1OKYZ2uiBSB7S1hO7tUzqvfWskmCJmMmtBebNRDPCQ@mail.gmail.com>
Subject: Re: [PATCH] strbuf: let strbuf_addftime handle %z and %Z itself
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Ulrich Mueller <ulm@gentoo.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 12:31 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Am 12.06.2017 um 21:02 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> I only ever use the time offset info to quickly make a mental note of
>> "oh +0200, this guy's in Europe", or "oh -0400 America East". Having
>> any info at all for %Z would allow me to easily replace that already
>> buggy mapping that exists in my head right now with something that's
>> at least a bit more accurate, e.g. I remember that +0900 is Japan, but
>> I can't now offhand recall what timezones India is at.
>>
>> Now, obviously we can't know whether to translate e.g. -0400 to New
>> York or Santiago, but for the purposes of human readable output I
>> thought it would be more useful to guess than show nothing at all. So
>> for that purpose the most useful output of %Z *for me* would be just
>> showing a string with the 3 most notable cities/areas, weighted for
>> showing locations on different continents, e.g.:
>>
>>    +0000 =3D Iceland, West Africa, Ittoqqortoormiit
>>    +0100 =3D London, Lisbon, Kinshasa
>>    ...
>>    +0900 =3D Tokyo, Seul, Manokwari
>>    ....
>>    -0900 =3D San Francisco, Vancouver, Tijuana
>>    ....
>>    -0600 =3D Denver, Managua, Calgary
>>
>> Then I could run:
>>
>>      git log --date=3Dformat-local:"%Y[...](%Z)"
>>
>> And get output like:
>>
>>      commit 826c06412e (HEAD -> master, origin/master, origin/HEAD)
>>      Author: Junio C Hamano <gitster@pobox.com>
>>      Date:   Fri Jun 2 15:07:36 2017 +0900 (San Francisco, Vancouver,
>> Tijuana etc.)
>>
>>      Fifth batch for 2.14
>>      [...]
>>      commit 30d005c020
>>      Author: Jeff King <peff@peff.net>
>>      Date:   Fri May 19 08:59:34 2017 -0400 (New York, Havana, Santiago
>> etc.)
>>
>>          diff: use blob path for blob/file diffs
>>
>> Which gives me a pretty good idea of where the people who are making
>> my colleges / collaborators who are making commits all over the world
>> are located, for the purposes of reinforcing the abstract numeric
>> mapping with a best-guess at what the location might be, or at least
>> something that's close to the actual location.
>
> Half the time this would be off by a zone in areas that use daylight
> saving time, or you'd need to determine when DST starts and ends, but
> since that depends on the exact time zone it will be tricky.

Yes, not to beat this point to death, but to clarify since we still
seem to be talking about different things:

I'm not saying it isn't fuzzy and inaccurate, I'm saying there's a
use-case for human readable output where saying e.g. "somewhere New
York-ish" is more useful than nothing, even given summer time I'm
still going to know approximately what timezone it is, more so than
the offset number.

And that is, I would argue, the best thing to do when the user is via
%Z asking for a human-readable timezone-ish given a commit object,
which only has the offset.

> You could use military time zones, which are nice and easy to convert:
> Alpha (UTC+1) to Mike (UTC+12) (Juliet is skipped), November (UTC-1) to
> Yankee (UTC-12), and Zulu time zone (UTC+0).  Downside: Most civilians
> don't use them. :)  Also there are no names for zones that have an
> offset of a fraction of an hour.

Yes I think if we're going down the road of providing some
human-readable version of the offset this is near-useless since almost
nobody using Git is going to know these by heart.

>> I'd definitely use a feature like that, and could hack it up on top of
>> the current patches if there wasn't vehement opposition to it. Maybe
>> the above examples change someone's mind, I can't think of a case
>> where someone's relying on %Z now for date-local, or at least cases
>> where something like the above wouldn't be more useful in practice
>> than just an empty string, but if nobody agrees so be it :)
>
> Personally I don't have a use for time information; dates alone would
> suffice for me -- so I certainly won't hold you back.  But I don't see
> how it could be done.

It could be done by accepting that you're not going to get a perfect
solution but one that's good enough to aid the humans currently
reading the currently only numeric output.

My use-case for this is having colleges all over the world who create
commits using different time offsets. It's simply easier to at a
glance realize what office someone is in if "git log" is printing city
names in/near those timezones, even if none of those cities are where
those people are located.
