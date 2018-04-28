Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 817C21F428
	for <e@80x24.org>; Sat, 28 Apr 2018 05:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeD1FmQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 01:42:16 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36920 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbeD1FmO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 01:42:14 -0400
Received: by mail-oi0-f53.google.com with SMTP id f63-v6so3443678oic.4
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 22:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=hYz9YHmuNfxsJX/fN7zAnymNtRo8xefrhs1cxPuNhwY=;
        b=BmBh0tDOavztMmRdBY/2ZfxNKtNKYghUrhkdRmbP7y2q7M3CyAqkHlBi/G5NT6DM+5
         jLi23r9b7AaF0ECYL3UArwfNSTcLXG5jsJuhyyNtg0f1RVaxnM5Mpo1VHRbc+Q/NBiI4
         YIn7JMvF5asCoHHSDrPWvpJNBNuLCpPM255gmeoLT4JrtZ1TjtNi9vOrU+dh9BuH4j2L
         Vo1xpOx/mCe2LCuA+9FDMi0vsC3QO9LAWhnTjzcXqWuoaGG6kCHYa0k2HLc53xytrIbC
         5FRNZmFkhPZTMhLncmqfGZDPoYpvBpz6BBa4uaNkdkvFHeB5yJ01g3tBP6jwOhwuqvGZ
         cNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=hYz9YHmuNfxsJX/fN7zAnymNtRo8xefrhs1cxPuNhwY=;
        b=XITwvBF3PmekvO4uLritMxyX6Zde+wnnDXAXDqUI//+UBOmA5lyXORAzA63JJL33eN
         w26XklslMpnXiV6azSgzcEYPVJb1R/lyRHNJI9rvnjHkd+UPWWmFAscAMImsuQiikJdV
         1jbhzG1ZbawY+NucJGExM1+hJ9JEYSgJEkf7buxWafKZZLClMApzZ5WDVNBwgjlwBZO0
         szhH2WK2c8V7bTY8j+Ul+9KbNzTvUYxY0kA6NhBaFFhygL8cDFJHN1y3B7Lbgkfg6axt
         6Z3O2e3pQo5Zktbd4aM7LzsRmpyKAePPpFfIUSC9BEy+JfhcissHkWKJTbyR/XFJ9Xyd
         YPag==
X-Gm-Message-State: ALQs6tDDszKk53x5snN0TeZvPbzlvr8PxqiV8auKpa7N5AN5g9Ue5/6F
        hCvufa4ziAVbEpjjStvmoBRPigNERDGl1aEyfJg=
X-Google-Smtp-Source: AB8JxZqO6UL7IZj3ScdOETrwilX9te/erVsmUPPN5Spx7d4A313QxiKH40F1HzVI+rXloPx12QM9doUrzTkK4T6F0sY=
X-Received: by 2002:aca:2813:: with SMTP id 19-v6mr3027270oix.281.1524894134312;
 Fri, 27 Apr 2018 22:42:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Fri, 27 Apr 2018 22:41:43 -0700 (PDT)
In-Reply-To: <20180427210823.GB722934@genre.crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
 <20180423233951.276447-19-sandals@crustytoothpaste.net> <CAN0heSouHbAj8TbiROe=XRsBJ788Vi6P4a_Wvv=7OrdsXqQXHw@mail.gmail.com>
 <20180424235150.GD245996@genre.crustytoothpaste.net> <CAN0heSqpj9JfTrnMFRbquraxve9iTwoowgWRUhcD-gXHMg3V=g@mail.gmail.com>
 <CACsJy8DUsFLDb786FmsR+eTriXaWGXEE+ZG8kCjq7JoipN1Phg@mail.gmail.com> <20180427210823.GB722934@genre.crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 28 Apr 2018 07:41:43 +0200
Message-ID: <CACsJy8BCSMNRvcPS5HaWjaURpS7abfANVUmrJVrxZ=b0qqGjag@mail.gmail.com>
Subject: Re: [PATCH 18/41] index-pack: abstract away hash function constant
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 27, 2018 at 11:08 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Thu, Apr 26, 2018 at 05:46:28PM +0200, Duy Nguyen wrote:
>> On Wed, Apr 25, 2018 at 8:49 PM, Martin =C3=85gren <martin.agren@gmail.c=
om> wrote:
>> > Once that is accomplished, I sort of suspect that this code will want =
to
>> > be updated to not always blindly use the_hash_algo, but to always work
>> > with SHA-1 sizes. Or rather, this would turn into more generic code to
>> > handle both "v2 with SHA-1" and "v3 with some hash function(s)". This
>> > commit might be a good first step in that direction.
>>
>> I also have an uneasy feeling when things this close to on-disk file
>> format get hash-agnostic treatment. I think we would need to start
>> adding new file formats soon, from bottom up with simple things like
>> loose object files (cat-file and hash-object should be enough to test
>> blobs...), then moving up to pack files and more. This is when we can
>> really decide where to use the new hash and whether we should keep
>> some hashes as sha-1.
>
> I agree that this is work which needs to be done soon.  There are
> basically a couple of pieces we need to handle NewHash:
>
> * Remove the dependencies on SHA-1 as much as possible.
> * Get the tests to pass with a different hash (almost done for 160-bit
>   hash; in progress for 256-bit hashes).

This step sounds good on paper but realistically could be a nightmare for y=
ou.

I tried to implement a simple cat-file/hash-object combination with my
imaginary newhash, which sounded straightforward to me since you have
done a lot of heavylifting. To my surprise I hit a lot more problems.
My point is, when I concentrate on just a few simple cases like this,
I have a smaller scope to work with and could quickly identify
problems. When you work on the scale of the test suite, it's really
hard to know where the problem is (and you don't even know what areas
are newhash-safe).

Anyway my cat-file/hash-object modification could be found here. I
probably will polish and send out a few good patches from it.

https://github.com/pclouds/git/commits/new-hash
--=20
Duy
