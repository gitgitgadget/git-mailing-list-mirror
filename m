Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37EFC2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 22:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86AFE206CB
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 22:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgKIWMu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 17:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbgKIWMu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 17:12:50 -0500
Received: from 0x63.nu (0x63.nu [IPv6:2a02:750:9::199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FF5C0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 14:12:49 -0800 (PST)
Received: from ip6-localhost ([::1] helo=moveme2)
        by 0x63.nu with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <anders@0x63.nu>)
        id 1kcFP3-0024zo-Mr; Mon, 09 Nov 2020 23:12:45 +0100
References: <20201025212652.3003036-1-anders@0x63.nu> <20201025212652.3003036-7-anders@0x63.nu> <CAP8UFD1nYgqT1k1Mc=Ea3AZkb-TdhPBzXo+N+4nWgYVxEBxzRA@mail.gmail.com>
User-agent: mu4e 0.9.18; emacs 26.0.91
From:   Anders Waldenborg <anders@0x63.nu>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 06/21] t4205: add test for trailer in log with nonstandard separator
In-reply-to: <CAP8UFD1nYgqT1k1Mc=Ea3AZkb-TdhPBzXo+N+4nWgYVxEBxzRA@mail.gmail.com>
Date:   Mon, 09 Nov 2020 23:12:14 +0100
Message-ID: <87y2jap4ch.fsf@0x63.nu>
MIME-Version: 1.0
Content-Type: text/plain
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Christian Couder writes:

> On Sun, Oct 25, 2020 at 10:27 PM Anders Waldenborg <anders@0x63.nu> wrote:
>>
>> ); SAEximRunCond expanded to false

Please disregard this line. It is an unfortunate and most embarrassing
artifact of messed up git send-email and stmp forwarding over ssh. Which
hopefully have been sorted so it doesn't happen next time. It obviously
shouldn't be part of the commit massage in any of the patches in the
series.

>> Signed-off-by: Anders Waldenborg <anders@0x63.nu>
>
> Why is this new test important?

The test that checks that 'git log --pretty=format:%(trailers)' shows
the output in the form "Closes: 1234" even if input was "Closes #1234"
is interesting both because it checks that this behavior is kept intact
in the patches later in the series which modifies handling of separator
and because it is a behavior that can be surprising and not well defined
in documentation and those tend to be the ones that are easiest to
accidentally break. Maybe the addition of the test should come later in
the series where the changes that potentially could break it happen.


It seems like you stopped reviewing my patch series at patch 06/21. That
is IMHO just before it starts to get interesting :)  Now I don't know if
rest of it was rubbish or uninteresting or just there was no time to
look at it.

I've updated according to the suggestions, but not sure if I should
repost the series with just such small adjustments.
