Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7F4A2018B
	for <e@80x24.org>; Mon, 27 Jun 2016 16:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbcF0Qde (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 12:33:34 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:34528 "EHLO
	mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbcF0Qdd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 12:33:33 -0400
Received: by mail-it0-f46.google.com with SMTP id g127so16859973ith.1
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 09:33:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OukUpNz9+X6WdwuKozhwvTZBrGnawvMnFKTuhSD1puU=;
        b=kne8F1uaGN0C/P3QxqyeYsZEBbH4jsgmeK6Y0hRxtwCTzno2xmnaLA8ZJwt4VN8ddq
         cWKAqzlLxwkgeHOa3pmb0X28gCykBOLW4qypB/Y8rGMaNXx93/Qk/voWedEzBHgORSy2
         FKwUwhqmTWfOOCVVPI5ce6mNjWJwXY8J28/NsHdq/mQN0QG8Mm2UM/1KMbvv1XU0RGPz
         rszpBR9120QDin2d4cW+eOh6YeZFdXNEFmFLNmj3dpRhgS4VWQc+D6Rgz+6yXpH9Mlu2
         kkWf//zH7IKtJi7z3rJFmsKK0KS4wZUXFkg2vHOFaLTuksUXGolGl3wbnSCad642s+D8
         NesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OukUpNz9+X6WdwuKozhwvTZBrGnawvMnFKTuhSD1puU=;
        b=JsFGK9SFJynvCRG3JSLRYPyE+3k30FfxzX3KkR1yKs/JYok8Zi2zzJWvmI7sE83AyU
         s6zFgzX72JScVVOHJuLuL+MvIVSqFIGtuqK1rYYUTRGtv+ewur6ySIDYDoWoOHlCGYKL
         /6CACPmWU2zNNkzStLxnn6rbR6uJIMypNZ5lbH0JQFjkvE3wmddgFWS7Y27Uqqe323S3
         jCn7PERNSln35i067Uj+lG62py0LDUT0+gtoi8IriPZwOq2Cnc1/YeTc2v6k4kxtN2Pp
         o6rCFAGUNtf12oqCWovq2OI0Dy8YiDd6Qa6KxxgGwANZM3PTKRoXm4BZ0KV1EoWC46fB
         3Gxg==
X-Gm-Message-State: ALyK8tK3A662R1SPXgDCPyNtiKliE52GDAS2bNAE1RpSX8usA2aFz/l2Kg455PPPCEMYCAtdIP/hS0qZ2v+FTQ==
X-Received: by 10.36.130.130 with SMTP id t124mr10000770itd.42.1467045194505;
 Mon, 27 Jun 2016 09:33:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Mon, 27 Jun 2016 09:32:39 -0700 (PDT)
In-Reply-To: <20160627162052.GA4532@sigill.intra.peff.net>
References: <20160626070617.30211-1-pclouds@gmail.com> <20160626182715.GA12546@sigill.intra.peff.net>
 <CACsJy8DAMe3YH-f_Qm8FEmanXepnwF2z1L6DDGoJf1eysmW2xQ@mail.gmail.com> <20160627162052.GA4532@sigill.intra.peff.net>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Mon, 27 Jun 2016 18:32:39 +0200
Message-ID: <CACsJy8D6TxkMWJTUCeDd8tuMyTRXcvWdMw4VL3nO7jbLEgjE-A@mail.gmail.com>
Subject: Re: [PATCH] config: add conditional include
To:	Jeff King <peff@peff.net>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 27, 2016 at 6:20 PM, Jeff King <peff@peff.net> wrote:
> You do allow distinguishing the suffix thing with "/" at the end in the
> rule above, though. So between the two rules:
>
>   - slash at the end is a shorthand for "/**"
>
>   - no-slash at the beginning (i.e., a non-absolute path) is a shorthand
>     for "**/" at the beginning

Neither slash or "./" at the beginning...

> you should be able to specify anything.

...then yeah it looks pretty good. With the exception of  "./" we can
still have paths relative to where the the config file is. For
$HOME/.gitconfig that  eliminates the need for expanding "~"
($HOME/.config/git/config may still need it, unless we allow "../"
too, but that complicates matching).

> I do agree that there's value in trying to make the rules consistent
> with other parts of git, though. I don't know the corner cases of
> gitignore and gitattributes well enough to compare off the top of my
> head, though (though I suspect you do. :) ).

Naah the complication of .gitignore and .gitattributes have long
exceeded my brain's capacity.
-- 
Duy
