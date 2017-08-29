Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D1C01F4DD
	for <e@80x24.org>; Tue, 29 Aug 2017 19:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbdH2TWL (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 15:22:11 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34610 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbdH2TWK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2017 15:22:10 -0400
Received: by mail-pf0-f181.google.com with SMTP id l87so3042765pfj.1
        for <git@vger.kernel.org>; Tue, 29 Aug 2017 12:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qkDPrjY+Prcgi3DfxdZi8QYTXJemyz2tCP3SnFqavGY=;
        b=TyVV/++0KTuzNf5vf2iZYGmzjW8/QtvzkB21JebYcsXPqzgf4fNQGRiuXCcG0NPPye
         61pEcaFjW3JmJVIbpIcP9gOy0J1dO6uEu9KFvscUJ6PuW3A0ObGqFao2fXSBbN2loCsb
         3kcQGlGj39/186ezJWpbcAgEW1ladm+fPh2gsLXkNO2imvdkwkm1SRLqdHz/YO/sXSVI
         FyJRyWazggqQAJqR8tEfXEHbDwZ7v5qNwTT8SWAwfhuuzMYWVVhnTJHBm800daAVcPSO
         WKBZZL9ymYDcDmkg5sA18PMGVgwuaG537eLWCQetoUZHqK3ZX9BLcacwWyBYKPlse0+R
         28PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qkDPrjY+Prcgi3DfxdZi8QYTXJemyz2tCP3SnFqavGY=;
        b=AIwDpmYtaDjupiAOL1a/H0Blk/BZ0pbc2gJ6YLXc+3AWbrRMzdVha6a5sSzcAtTL8v
         4cMs9SR5Nfx6DlQbi8/gmkcLCF5Ma0nC8DuphnRidBNE7gMoB+BuzDy9ORjNeKW64mxc
         ocmZQnYQCVYbtb5GNU5C98MQ5BAnLGAjDVi711a2h9kDZsIdKBS9bcz7RMyfhfDt16ow
         JZ3iagS4Tc6mVk10Qxzb9CnjFn5ushuA1EdiQ7Pb9lukLUADVkecWtcSDlNXRb5xPIhi
         OsjC0/p4yvpDtmF+uvbFVyOXNd2Ao7tyKTbp/+9Ze1m8EYA+GHt+OxP10BygGBA9u1Kg
         MwRw==
X-Gm-Message-State: AHYfb5gDW47EEvee5D78nNKbgiiBGa+WNnfRyVtBzFdm9+LYFWnUEhUD
        JeWoe2aBY2Oym1gIim3RhD41sYh9Zw==
X-Received: by 10.98.141.79 with SMTP id z76mr1358472pfd.321.1504034529626;
 Tue, 29 Aug 2017 12:22:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.37 with HTTP; Tue, 29 Aug 2017 12:22:08 -0700 (PDT)
In-Reply-To: <20170829185341.s3xlsx4uym7lcluc@sigill.intra.peff.net>
References: <20170827073732.546-1-martin.agren@gmail.com> <9E4606AF-8814-42DE-8D3A-3A15C1B1723C@gmail.com>
 <CAN0heSraJFbbog7FKpAtmob9W6_5-AS1StZFVW6xUwMDWfMYgg@mail.gmail.com>
 <179AC8FB-5991-4200-9AAC-2F8D0914D5F9@gmail.com> <20170827232338.hm5t7t7c2xaa3zyl@sigill.intra.peff.net>
 <CAN0heSoUqcOqVspZkbPahWQdtVpSdtSZoCFWu0ZQJfN3F0mD2g@mail.gmail.com>
 <B1E291F2-86FF-4982-A092-92FAED65385C@gmail.com> <20170829185341.s3xlsx4uym7lcluc@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 29 Aug 2017 21:22:08 +0200
Message-ID: <CAN0heSomjqiSStq3eqGgCe21b0Pr0gbAQLL-2EEB6Zfnjj+Mjg@mail.gmail.com>
Subject: Re: [PATCH] pkt-line: re-'static'-ify buffer in packet_write_fmt_1()
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29 August 2017 at 20:53, Jeff King <peff@peff.net> wrote:
> On Tue, Aug 29, 2017 at 06:51:52PM +0100, Lars Schneider wrote:
>> What if we run a few selected tests with valgrind and count all files that
>> valgrind mentions (a single leak has multiple file mentions because of
>> the stack trace and other leak indicators). We record these counts and let
>> TravisCI scream if one of the numbers increases.
>>
>> I wonder how stable/fragile such a metric would be as a simple refactoring
>> could easily change these numbers. Below I ran valgrind on t5510 before and
>> after Martin's patch. The diff below clearly shows the pkt-line leak.
>>
>> Would it make sense to pursue something like this in TravisCI to avoid
>> "pkt-line" kind of leaks in the future?
>
> I don't think that would work, because simply adding new tests would
> bump the leak count, without the code actually growing worse.
>
> But think about your strategy for a moment: what you're really trying to
> do is say "these existing leaks are OK because they are too many for us
> to count, but we want to make sure we don't add _new_ ones". We already
> have two techniques for distinguishing old ones from new ones:
>
>   1. Mark existing ones with valgrind suppressions so they do not warn
>      at all.
>
>   2. Fix them, so that the "existing" count drops to zero.
>
> Option (2), of course, has the added side effect that it's actually
> fixing potential problems. :)

One idea would be to report that "t1234 used to complete without leaks,
but now there is a leak". Of course, the leak could be triggered by some
"irrelevant" setup step that was just added and not by the functionality
that is actually tested. But maybe then the reaction might be "oh, let's
fix this one leak so that this test is leak-free again". If that then
also reduces the leakiness of some other tests, good. That might help
against the "there are too many leaks, where should I start?"-effect.

Or similarly "This stack-trace was reported. I haven't seen it before."
It could be a refactoring, it could be an old leak that hasn't been
triggered in that way before, or it could be a new leak.

But to be honest, I think that only works -- in a psychological sense --
once the number of leaks is small enough, however much that is.

One take-away for me from this thread is that memory-leak-plugging seems
to be appreciated, i.e., it's not just an academic problem. I think I'll
look into it some more, i.e., slowly pursue option 2. :-) That might help
give some insights on how to identify interesting leaks.

Martin
