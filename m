Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2EE22042F
	for <e@80x24.org>; Thu, 17 Nov 2016 00:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936618AbcKQAMX (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 19:12:23 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:38557 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935544AbcKQAMV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 19:12:21 -0500
Received: by mail-it0-f49.google.com with SMTP id j191so5034809ita.1
        for <git@vger.kernel.org>; Wed, 16 Nov 2016 16:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DcGqdYrXLf5RC9dlqrLojLeRo7qTC85DDhSlFib6yQw=;
        b=YTDmBe0yJZLI+Hw24HxyeqbuxJKlapG+5WW+s4PtX+/7Tz8W7LrJVnXsCA92DkN0or
         q8wcFDqXV4gXVJrfE2tR6vZgc/dTVXpRKl6EMnSgk7wAmJGT8PSGFY1fAfkkKoTcuv98
         JgKWFaw0NAnsKL/a9tiwP+Ww6hE49xqVk5KDSEO8yRc53S2TiSckuinnEoIcNiQEhF9w
         DJ3e+5gtTfXglFVMarByhwiaXRbcleevep7EvPMOrG+PMU5BCyZi5Lpj1vaoXhc78uA+
         x61+sW+46IM6nu+Meltl2Fh6d27RJM0ePaEKGQthotJT/9SXC89Ssz3M15Z/tgAUnrK+
         1EIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DcGqdYrXLf5RC9dlqrLojLeRo7qTC85DDhSlFib6yQw=;
        b=OHl5dCb08z5wQejiAi3X6LnYsc0CFBensqbhtncZid16LDh5PAfS+X1rPJN5/ncoxK
         Wn0FSeyybNDiOKD/G4EejyyXVnI47mCtDNc7/8H2SnUfMJU4zcpaeBFKf4/z6JZQRO0Q
         2IJQrS/caSpG9fjudFxRoBDWHgYPhpTlZWaYBLWn5+neoGw1JHllA+gOL3PoqAHmG3NB
         9uaE7esQ8i2CuuyY/uW42hcmZLjnPkRlNT7bC9W+Q31ma7AXrwOptqHTHivIrezBH38a
         s0qaWQw2+dpmSDdUedZi7wB4kdZvcBN9JXUERe/dfdZPNA+SoEm48rDiwg/i9pB0j+MB
         ucrQ==
X-Gm-Message-State: AKaTC00CdckvGIYliMDUJjq1lWRekg5gbVVeqIHXtvBCg/sZxvDjPkRZrWSTk3YCO1QlXsrcxeR4it+yXGMhTA==
X-Received: by 10.107.6.25 with SMTP id 25mr706957iog.78.1479341541014; Wed,
 16 Nov 2016 16:12:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.164.219 with HTTP; Wed, 16 Nov 2016 16:12:20 -0800 (PST)
In-Reply-To: <xmqq7f83ouqs.fsf@gitster.mtv.corp.google.com>
References: <CAM+g_Nsiu_qqapB+FvwJCBfwEYLTPdHg4DueQWHq4XDNXMCgpQ@mail.gmail.com>
 <xmqq7f83ouqs.fsf@gitster.mtv.corp.google.com>
From:   Norbert Kiesel <nkiesel@gmail.com>
Date:   Wed, 16 Nov 2016 16:12:20 -0800
Message-ID: <CAM+g_Ns-9Sj5r0V2XXZfGQz+0XiO1O-hT03japEGibkNgh8a4A@mail.gmail.com>
Subject: Re: Rebasing cascading topic trees
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes, `git rebase --onto topic1 topic1@{1} topic2` is the answer!

Thanks so much, learned something new today.

On Wed, Nov 16, 2016 at 3:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Norbert Kiesel <nkiesel@gmail.com> writes:
>
>> I currently have a situation with cascading topic branches that I need to rebase
>> regularly.  In the picture below, I want to rebase the tree starting with `E` to
>> be rebased onto master (my actually cascade is 4 branches deep).
>>
>> A--B--C--D (master)
>>    \
>>     E--F (topic1)
>>        \
>>         G--H (topic2)
>>
>> After running `git rebase --onto master master topic1`, I end up with
>>
>> A--B--C--D (master)
>>    |     \
>>    \      E'--F' (topic1)
>>     E--F
>>        \
>>         G--H (topic2)
>>
>> I then need to also run `git rebase --onto topic1 F topic2` to arrive at the
>> desired
>>
>> A--B--C--D (master)
>>    |     \
>>    \      E'--F' (topic1)
>>     E--F      \
>>        |       G'--H' (topic2)
>>        \
>>         G--H
>>
>> Problem here is that I don't have a nice symbolic name for `F` anymore after the
>> first rebase. Rebasing `topic2` first is not really possible, because I do not
>> have a new graft-point yet.  I currently write down `F` ahead of time (or use
>> `reflog` if I forgot) `F`, but I wonder if there is a better solution.
>
> Doesn't topic1@{1} point at "F" after the rebase of the topic1
> finishes?
>
