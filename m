Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 204801FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 23:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933976AbcLGXto (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 18:49:44 -0500
Received: from mail-yw0-f179.google.com ([209.85.161.179]:33164 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933939AbcLGXtn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 18:49:43 -0500
Received: by mail-yw0-f179.google.com with SMTP id r204so309114258ywb.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 15:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yEazihera4eaonVp65GFIXpMNBopIQ/PKTfAxakW5ZA=;
        b=NuN/6vHXO9dlkS4UtnTCidTJiLtgthYPDI8yQJKMeOk+KA+iLOJOfZjrwRQFJoro+K
         El9VXt6DPIpysYCMg8i4BFJ8e2kG0IIyMNE3eYKVhq9DB2MbzCduhdWpzvLMICJ331Ur
         kOUylOURDNEknwm6wtl9MR6PckhtKfM3N3rL+AKyXLNgROCs+27rQqCeOrKmlAku6qOR
         z/qi79TbAqSMMfNT5pdS4i3Y2odteOLbpwkSQtHe9Tej/y6FIoJmEIqVP/I9fhDKfciT
         +SXkYAAUu5kPZiGuGRI96bGftqnvHErzrKsY/NfCWxs76v0tAW+5o86WquLgqtW0S0BF
         eEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yEazihera4eaonVp65GFIXpMNBopIQ/PKTfAxakW5ZA=;
        b=UYRwnyrYll/NDyfYSceVdpwqQP9f4a65rvttwQ1j23tdhJnzejq06WAC7CS2Rj7uJa
         oRxqUfitG4V9bin1TKu2IbnmpTZgz2maExU70lhGqYNR9++TNRJtIETqDbvon2K18IA0
         qCYNPCrVKNM2b3rHIhL0ZGCs85//wVfuQ8/23ItwJJQjby46b5hfvLIfuNWHK260OFyK
         QhkatI3xNgg7ONjzWPctxriaXRGrR3ri9kJH5AXer8KLgvw2KAb9k20A8X1wOGoOkc0B
         /u212DabQZEJmSPGPrhgxW+ZL4orzp3KGFvEGotIPUkMJp8xjelF2XhyKWbAZK3L45ST
         /mjw==
X-Gm-Message-State: AKaTC02JOsI2du8NphTGEMlgJIG/pxPf3lvXouKt5QpYS/7UCznxJxFqjtKtmrkweDlfUymZHOGWXPedIvrt6g==
X-Received: by 10.129.74.65 with SMTP id x62mr66670429ywa.59.1481154582469;
 Wed, 07 Dec 2016 15:49:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.118.87 with HTTP; Wed, 7 Dec 2016 15:49:22 -0800 (PST)
In-Reply-To: <xmqqa8c7wfxu.fsf@gitster.mtv.corp.google.com>
References: <20161207023259.29355-1-jacob.e.keller@intel.com>
 <20161207023259.29355-2-jacob.e.keller@intel.com> <xmqqa8c7wfxu.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 7 Dec 2016 15:49:22 -0800
Message-ID: <CA+P7+xrPivwMzGhzKxu30jns+YvSQGXBKUc4JDmfbenTy27tZg@mail.gmail.com>
Subject: Re: [PATCH 2/2] describe: add support for multiple match patterns
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2016 at 2:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> ... Suppose that you version all
>> your official releases such as "v1.2", "v1.3", "v1.4", "v2.1" and so on.
>> Now, you also have other tags which represent -rc releases and other
>> such tags. If you want to find the first major release that contains
>> a given commit you might try
>>
>> git describe --contains --match="v?.?" <commit>
>>
>> This will work as long as you have only single digits. But if you start
>> adding multiple digits, the pattern becomes not enough to match all the
>> tags you wanted while excluding the ones you didn't.
>
> Isn't what you really want for the use case a negative pattern,
> i.e. "I want ones that match v* but not the ones that match *-rc*",
> though?

That's another way of implementing it. I just went with straight
forward patterns that I was already using in sequence.

Basically, this started as a script to try each pattern in sequence,
but this is slow, cumbersome and easy to mess up.

You're suggesting just add a single second pattern that we will do
matches and discard any tag that matches that first?

I think I can implement that pretty easily, and it should have simpler
semantics. We can discard first, and then match what remains easily.

Thanks,
Jake
