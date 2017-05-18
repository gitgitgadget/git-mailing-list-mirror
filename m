Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCFA1201A7
	for <e@80x24.org>; Thu, 18 May 2017 01:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754653AbdERBQi (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 21:16:38 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36261 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754080AbdERBQh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 21:16:37 -0400
Received: by mail-wm0-f67.google.com with SMTP id k15so6100150wmh.3
        for <git@vger.kernel.org>; Wed, 17 May 2017 18:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=IJ3+rSnrZ6r0+HpbmjOq5PkdCOqeuwR3i4aqK7RCg0w=;
        b=Skobm1KXsjMjWvkA8nblHooEC0Qfur7uGat2YGnRd+RciwyYtwOmOIo+vR/EU+AwNL
         1nYm5rkvGsnpkVLq044QIDtfbR+aflUhAJZwfFhCx1f3XxX4m0dCSwtODW47m4EAaSK3
         mhB8p7OFsuYIyUzqKyQphF29rCX1NZnzTrM0EqPvjwcYlueGi2XA75Ww3/3U0zAH/9xb
         WHPcRNKbxaJ3AtBHqbOcRee4F/AJEmD5uUq8xtj4DcvGlVkC0cPa0nSy66HqeG4CScFx
         T9t2qVNihNn24YJfRelqlszqsXNGjMXx5jkAr/r6mVEybhQdCYgE+YIwpjt3tBSktERH
         7Btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=IJ3+rSnrZ6r0+HpbmjOq5PkdCOqeuwR3i4aqK7RCg0w=;
        b=s0utWHobxwDzDC1yw1r3vMgebqNJXFixPwndrkv57jEIlmuSaHVmItSH8TGeVHhZ2W
         lP/7thBaho5HSHKB+PXYzJVy6GnqggRnQ6UXC0BaMaK7ZVeZ5O5arXxfYkQZTHrg+v/C
         9b6WZd7RsidD3ucenNO2It+0DPOUlWeGCrz3Ucze7TGnj3M2yf/+afOSS4Ui0Mh6HIuZ
         jLkwcVnznTRTYaShe6yHf2X7Jb5sc9beT9iwO+CIkfGHf0gVRInHyzx6mpDuPndq+aVC
         7yUiJeBj9WmKfO88jf8H0bbt3/jZ4PfG0E4IcObgRo/2+JJGXVPBxVdB+qHkDoprFKyk
         GXGw==
X-Gm-Message-State: AODbwcCvmuvseaG4I2CL6BtcZju8XVlThhzANigwQ9KIPwjqwOcqnqH0
        sbFF7kQFEl6j2Rd9xjnYOJY5z+KqYw==
X-Received: by 10.25.156.75 with SMTP id f72mr309483lfe.77.1495070196276; Wed,
 17 May 2017 18:16:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.46.71.69 with HTTP; Wed, 17 May 2017 18:16:15 -0700 (PDT)
In-Reply-To: <20170518000735.GD185461@google.com>
References: <20170517002825.GR27400@aiede.svl.corp.google.com>
 <20170517005041.46310-1-manishearth@gmail.com> <CAM2h-yfRc69W8f=inRRjtyBh4EZWJk6W2gCTM=S=ifJn3g8auA@mail.gmail.com>
 <CACpkpx=usSnEBPPPppdeaM+HUNc06ZuN3mrfN4Nemspn96K9dQ@mail.gmail.com> <20170518000735.GD185461@google.com>
From:   Manish Goregaokar <manishearth@gmail.com>
Date:   Wed, 17 May 2017 18:16:15 -0700
X-Google-Sender-Auth: XuoSGmnk--FFbi7jZHtYdq2ICHw
Message-ID: <CACpkpxkGWhcALQZ2+2nOCRKgzAa7U7EjZg--S71zocdGY8NYag@mail.gmail.com>
Subject: Re: [PATCH 1/2] refs: Add for_each_worktree_ref for iterating over
 all worktree HEADs
To:     Brandon Williams <bmwill@google.com>
Cc:     Manish Goregaokar <manishearth@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Just as an fyi, its usually fine to send out a path RFC

Ah, this is helpful! Yes, I was still trying to get the tests to run,
so consider this WIP.

I have since gotten them to run and found one failure which I fixed
(didn't null-check `commit`).

Waiting for them to finish again, will send new patches when done.
Sorry about that.


> but I'm just hoping to provide you with some of the expectations we have.

Thank you!

I thought I'd submit the patch early so that I could get the basic
design through review; I wasn't sure if I was using the right APIs for
this task.

I should probably write a test for this too. Looks straightforward enough.

> Welcome! Take a load off and stay a while :)

:)
-Manish Goregaokar


On Wed, May 17, 2017 at 5:07 PM, Brandon Williams <bmwill@google.com> wrote:
> On 05/17, Manish Goregaokar wrote:
>> Oh, btw, refs.c needs an #include "worktree.h" to work; I didn't get a
>> chance to test this after rebasing onto the maint branch.
>>
>> (There's also another fix it needs to have no warnings, but that's not
>> going to affect building). I have this fixed locally, but I'll wait
>> for the rest of the review before pushing them up.
>> -Manish Goregaokar
>
> Just as an fyi, its usually fine to send out a path RFC (request for
> comments) or WIP (Work in Progress) which compiles with warnings (or
> maybe not at all) and which doesn't pass all tests.  If you do that just
> make sure to indicate as such.
>
> Though if you are sending out a patch which you want to be seriously
> reviewed and ultimately merged then the best practice is to ensure that
> it compiles without warnings and that all tests pass.  I'm definitely
> guilty of this occasionally (no one's perfect!) but I'm just hoping to
> provide you with some of the expectations we have.
>
> I'm assuming you're newer to the community, so Welcome! Take a load off
> and stay a while :)
>
> --
> Brandon Williams
