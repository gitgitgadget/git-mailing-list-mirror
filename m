Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2D301F424
	for <e@80x24.org>; Wed,  9 May 2018 16:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965273AbeEIQU2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 12:20:28 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:37046 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965034AbeEIQU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 12:20:27 -0400
Received: by mail-oi0-f54.google.com with SMTP id w123-v6so23034833oia.4
        for <git@vger.kernel.org>; Wed, 09 May 2018 09:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rVKAhkrM6oXYAE9QdTh4KO360+M/xH+ti9xhIRc544E=;
        b=McIfEbwN+K0l9cui3r07gMg3L7ZaboxGNMHWApfnJ4uxn2WEJeKC2ACq8J/JIOU4mh
         vPmvVv/HQWg3+CBvVrQ0zy8n7Z/eN5G+U/rD1vgYolRiWwWMRIFFpru88sH9LpRRuMi8
         iknI1oIE4HK/76tyg0ioE0/1GSuzYJ9seIRZl0C/MmTEQmNJmCwIEBaPWsEwwz1iDh0z
         xWweGtaQc8MkvOXsSTC+c+oVrOqiqvBKLmnFvCKqKHyjgv2J4eB7zOkz6BQ35qQjCMSb
         qiRKhKYNsA08PV2BsIBN1CMm4R3YEkhdWPi26eczsYho4tSsSQyXxOwiYqDx0QRyelIb
         dQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rVKAhkrM6oXYAE9QdTh4KO360+M/xH+ti9xhIRc544E=;
        b=OZ1fk4PGFKMxtuMJSrZlpQSj3jeUlMJjZYvOeeYpjhjEBtBZvXcotPHKn3TmhIeBiS
         cXjK0vV5nN+Yl2blhbzfi8Xw+wPjc0CPxudcUw0AYNMdiI7Tc/qeDu+o9E3QIFEzjXOH
         V1QqE/+eAs+iUXZJ9cn7akyxjIbZigAz0HrBEF1W0oTZi1h9qQVVnLK6NgeHNLuqVx0X
         pbt0NzEp5VvTY+1K7RWy6nXa00gfBXzTeptNwIjrInCttrFCzvCoFRWQ7xISs2RuIdSZ
         iO+vDnfctbzFzShHtwj4w6nH7ffPpivIDxCBYdDR4B+QAfiKXlHaweaPlbO3RbRGpZ2i
         MUZQ==
X-Gm-Message-State: ALQs6tAquE8yj0eyPH4PxY1rM8f3PSk5r/2GBonGFl746bLmkRU/Rw7T
        U9SmBl8pxgEUJX5jseNbd5kPLUJZN1aNrkgERg8=
X-Google-Smtp-Source: AB8JxZqL1Sjv3ruJQOLTTBNvAT7cm9C0w3IQIMaL9XM+9O6qi6eYMy9g0zTsrEH6xi/KUQCa+FTx0EzwobHI2NFyh6k=
X-Received: by 2002:aca:ce42:: with SMTP id e63-v6mr30597682oig.34.1525882827189;
 Wed, 09 May 2018 09:20:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Wed, 9 May 2018 09:19:56 -0700 (PDT)
In-Reply-To: <20180508181839.GC7210@sigill.intra.peff.net>
References: <20180506141031.30204-5-martin.agren@gmail.com>
 <CACsJy8DyRhQ0DKy8UyK+r7Kmw=0hHD=W6aXXKutk4e-wtGTdNg@mail.gmail.com>
 <CACsJy8Btuc2J4aCTymkvLYyMV5zJrdMUdtV5NDnPqXOjsTVw4w@mail.gmail.com>
 <CAN0heSpA5H7Gwwx0TEY9=iFJrgKb0SPXqKOwHK=4NxPYoGjZ7A@mail.gmail.com>
 <CACsJy8DDyrUinwXx1b66DCHB+2DLt1KBmFt_83R1+HWjbzGH2A@mail.gmail.com> <20180508181839.GC7210@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 9 May 2018 18:19:56 +0200
Message-ID: <CACsJy8BDaHUs+DMOM7h6Lgbn8qB8yE4-O4iG=t85nG6sQ77zOw@mail.gmail.com>
Subject: Re: [PATCH 4/5] lock_file: make function-local locks non-static
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 8, 2018 at 8:18 PM, Jeff King <peff@peff.net> wrote:
> On Mon, May 07, 2018 at 05:24:05PM +0200, Duy Nguyen wrote:
>
>> >>>> -       static struct lock_file lock;
>> >>>> +       struct lock_file lock = LOCK_INIT;
>> >>>
>> >>> Is it really safe to do this? I vaguely remember something about
>> >>> (global) linked list and signal handling which could trigger any time
>> >>> and probably at atexit() time too (i.e. die()). You don't want to
>> >>> depend on stack-based variables in that case.
>> >>
>> >> So I dug in a bit more about this. The original implementation does
>> >> not allow stack-based lock files at all in 415e96c8b7 ([PATCH]
>> >> Implement git-checkout-cache -u to update stat information in the
>> >> cache. - 2005-05-15). The situation has changed since 422a21c6a0
>> >> (tempfile: remove deactivated list entries - 2017-09-05). At the end
>> >> of that second commit, Jeff mentioned "We can clean them up
>> >> individually" which I guess is what these patches do. Though I do not
>> >> know if we need to make sure to call "release" function or something/
>> >> Either way you need more explanation and assurance than just "we can
>> >> drop their staticness" in the commit mesage.
>> >
>> > Thank you Duy for your comments. How about I write the commit message
>> > like so:
>>
>> +Jeff. Since he made it possible to remove lock file from the global
>> linked list, he probably knows well what to check when switching from
>> a static lock file to a stack-local one.
>
> It should be totally safe. If you look at "struct lock_file", it is now
> simply a pointer to a tempfile allocated on the heap (in fact, I thought
> about getting rid of lock_file entirely, but the diff is noisy and it
> actually has some value as an abstraction over a pure tempfile).
>
> If you fail to call a release function, it will just hang around until
> program exit, which is more or less what the static version would do.
> The big difference is that if we re-enter the function while still
> holding the lock, then the static version would BUG() on trying to use
> the already-active lockfile. Whereas after this series, we'd try to
> create a new lockfile and say "woah, somebody else is holding the lock".

Ah.. I did miss that "everything on heap" thing. Sorry for the noise
Martin and thanks for clarification Jeff :)
-- 
Duy
