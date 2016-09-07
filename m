Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D25AB1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 22:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757848AbcIGWM4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 18:12:56 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:35426 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757519AbcIGWMj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 18:12:39 -0400
Received: by mail-yb0-f194.google.com with SMTP id y64so530164yby.2
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 15:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4RS8b+npXYUB0mF7GDnMTkOq/baauoi8uw6tqpY5ydc=;
        b=QlhIi0kVViZXTQXfVcCfcbil8kxpWTbPHlamwo2pLW7eK7Q9wlJhy11f2hMf9P/KYY
         UlW6tixnMma4szrM1RQbm/uhvDaBRJiJSZZgKMnmq2ZS89SB6RKop5JQxt2GepbnKXKi
         yFHU44toP09ej+Uka/LRbY9aS+wLa2NpyjZJQeme9VVJweGO3FwRuKSZ5P7HndbJnCLP
         yHqvR5WYwtypC6KSDug5CFgsBRhv6XvdC+zsMowRpFMXFp+9gnnRSybV+v2c9VsnyE0n
         bXC+36wo4rfKGHQzxiqNL0PxJRqpVyL27InipX1WmAp03KWTNUnhtspJLSWhUcoA5pLU
         hyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4RS8b+npXYUB0mF7GDnMTkOq/baauoi8uw6tqpY5ydc=;
        b=eDk/39baOGrUbGEFBF0c5JNzATTTg/oF3dGDhSA/1GKtcDr9rYocpolNBh0nu00TZj
         5w8ZlbvpnrQ2Lcya2Ok9ubwGn6d8k++R0EG8EJh1hPEf8JC+pU1JIF4egxlW9yzMSDyN
         Hj+WAlJa3AEc+905wVcNfhz4In/jSLz+dCCdywYNG/CFIKg0a5YgUwow59mpWi2OGP/p
         9SlDaLK78zxEQmi1SX1XqO5Ff+D5Qj6lkqpH9r9nKXfwmwSrH5CiuBvpoDZIEEx/yP9g
         05PHODDVV7dxrAkPbDYHEsNqGbzUiz+APt23zxYRZV+RPDEoijb6ZgytgswXmBP4N32E
         wQCw==
X-Gm-Message-State: AE9vXwMghkwfqWbxmQAumfdLU2gzAiicV7m06Ko0xWtkUO57LFgvDQUeEv5bINZJvRgWgAsAYJKVmeHWDr2zmw==
X-Received: by 10.37.212.199 with SMTP id m190mr16263820ybf.73.1473286358406;
 Wed, 07 Sep 2016 15:12:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Wed, 7 Sep 2016 15:12:17 -0700 (PDT)
In-Reply-To: <20160907220232.uotocvgdojfcl4o4@sigill.intra.peff.net>
References: <20160907220101.hwwutkiagfottbdd@sigill.intra.peff.net> <20160907220232.uotocvgdojfcl4o4@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 7 Sep 2016 15:12:17 -0700
Message-ID: <CA+P7+xriHk=UrBhLD1mWK7mWBth_2du7jgLPSAkoSAjKz0de-Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] patch-ids: turn off rename detection
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>,
        Xiaolong Ye <xiaolong.ye@intel.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 7, 2016 at 3:02 PM, Jeff King <peff@peff.net> wrote:
> The patch-id code may be running inside another porcelain
> like "git log" or "git format-patch", and therefore may have
> set diff_detect_rename_default, either via the diff-ui
> config, or by default since 5404c11 (diff: activate
> diff.renames by default, 2016-02-25). This is the case even
> if a command is run with `--no-renames`, as that is applied
> only to the diff-options used by the command itself.
>
> Rename detection doesn't help the patch-id results. It
> _may_ actually hurt, as minor differences in the files that
> would be overlooked by patch-id's canonicalization might
> result in different renames (though I'd doubt that it ever
> comes up in practice).
>
> But mostly it is just a waste of CPU to compute these
> renames.

Yes this seems reasonable.

>
> Note that this does have one user-visible impact: the
> prerequisite patches listed by "format-patch --base". There
> may be some confusion between different versions of git as
> older ones will enable renames, but newer ones will not.
> However, this was already a problem, as people with
> different settings for the "diff.renames" config would get
> different results. After this patch, everyone should get the
> same results, regardless of their config.

Makes sense.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> The patch is the same as v1, but the commit message is modified, as I
> realized that "--base" does expose this value publicly (but as I argue
> above, this is probably an improvement).

I agree this is an improvement.

Thanks,
Jake
