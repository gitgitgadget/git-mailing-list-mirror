Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E398CC43334
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 00:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiFXA3h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 20:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiFXA3g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 20:29:36 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0754249B48
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 17:29:34 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kyleam.com; s=key1;
        t=1656030572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1nkRUTW7hapcq8fAF8si1Rh9y1y6RY4LZZJI+lTywFg=;
        b=pzwlULoNqYkRCp/7eS/NmUxpHiBlPAcchfxDXY1z/6usHObDG5V0F7shPhTqB/5L7EITIU
        zkSGpldBYRykFbGG9hh+2S0lbobdCfmh001J8zbmx/FbuwnqatENKfRrMnbAPDrXohBd19
        udTa1+D7ceEAyZC2/mumIQkTNKFvtgkzeir5tgBUGBVB+2Bea3mChSvnxtRR+nb6zEgRji
        9soAX7AqMygNYlUZ6K+wz3pfZpXsutKcY+E5JGa908TFTL4poE8Xacqto6f2DfKZC/6B2R
        COTq76c+7PEm6bCnfe4Dpi7/dwxGx7Uvrg3Y9+xohzzx4SI7X724AVJCccqdeQ==
From:   Kyle Meyer <kyle@kyleam.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stephen Smith <ischis2@cox.net>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.org>
Subject: Re: SHA-256 transition
In-Reply-To: <220624.86fsjvj690.gmgdl@evledraar.gmail.com>
References: <12011256.O9o76ZdvQC@thunderbird>
 <220621.86sfnyuvt0.gmgdl@evledraar.gmail.com>
 <YrI9dvfoc5NYgVDq@tapette.crustytoothpaste.net>
 <220624.86fsjvj690.gmgdl@evledraar.gmail.com>
Date:   Thu, 23 Jun 2022 20:29:27 -0400
Message-ID: <8735fukioo.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: kyleam.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason writes:

> E.g. I use magit with Emacs, and last I checked it would puke on
> SHA-256. But checking again it seems someone patched it in January of
> this year to e.g. change "{40}" in regexes to "{40,}", so in theory it
> should work now (but I didn't try actually using it in that mode).

Yeah, I gave it some testing as I made those adjustments [*], but "in
theory it should work" is about my level of confidence too.  If you're
experimenting with SHA-256 repos and find spots where Magit chokes,
opening issues on Magit's side would be very appreciated.

[*] https://github.com/magit/magit/pull/4585
