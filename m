Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DE521F404
	for <e@80x24.org>; Wed, 24 Jan 2018 18:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965068AbeAXSr1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 13:47:27 -0500
Received: from mail-yb0-f179.google.com ([209.85.213.179]:45098 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964989AbeAXSrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 13:47:25 -0500
Received: by mail-yb0-f179.google.com with SMTP id k127so1922193ybc.12
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 10:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dMt5s5DBiLqYovrHNogJz5rVInwJn6jTrr1jZYf5bz8=;
        b=N5usPwvWM0XINWeN2yo1UwD42XnBTi8naeXrn4+p6vLex0Uq/Dsrkci4eiI0bidviF
         pnYA7RymIKMoTkUMa3noe7YyDy6scUcBKA+pwEz/v/HKhkMSyVPDwUL0dCablEPzRO/y
         /uz3KKkdkStNZFwTXxB6hvgY0x6ZsL0DsV753Kpn5ig+hfnSg3tRtPrr5EecKOUM2xU+
         vPgfd8gQASQRnupkHeUFe1pSAEuYC7esjRikOONfMJEpsprKYfq6Z60ManOCVJhj1Dm2
         PQR0tfVgkpdhO8bwmi7YNKJzsB3HTjAC4BYK7Kgk9LOMEfgUmrYidK5GYMFKb5Xw9ivx
         KhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dMt5s5DBiLqYovrHNogJz5rVInwJn6jTrr1jZYf5bz8=;
        b=JuKaaLOuGs9KWt+uFAGLzE1lQc1Ij1DY0QXoGBiGCi6HIABur+EQiLFa3MK+RLNRli
         ESuYwOPD3+IZVfAOTNZecpL9HqF6V58oBYF14lnbgJnqIbqrFzodwXA8qx6/qZ55NP6m
         UL3vGsjHgWY+Fg9UPA+h4X3LFCDPhSCwFzobRumItvd4Raypb/Kj3Pp7f/soirICZhnV
         yWyb7RzeHwmBGsq5NE86HLcKLi6+L74/a7s6WO7sHKW1xrlTgHZ89bKcEXhjjY+eQL8i
         MEcO3xclH6Y9yD1oAhTj8J2x8UUcGvRXp+jAiNFUOjzwoG9Gv/KJM/+lrH20LfULcEzO
         Fpew==
X-Gm-Message-State: AKwxytefCEEIbsnfZZAKOc0HAvTzSy6EQPU2t92SCtovAtCtFZ9jc1iM
        Bu86QJgTDSZpEWdGhIACQEyulrSLrOOMzLAv9qg=
X-Google-Smtp-Source: AH8x225SghZrz/tdTXTQgqUJBxFYrLSogpzSWrr9BA+Ml4/FLDs/o5/NqtxrutB3/uxRecGfsZPuNW05JzBF0JCYYOc=
X-Received: by 10.37.128.3 with SMTP id m3mr6096506ybk.450.1516819645176; Wed,
 24 Jan 2018 10:47:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.87.17 with HTTP; Wed, 24 Jan 2018 10:46:44 -0800 (PST)
In-Reply-To: <CA+WKDT3ZsObXc2ENV3gUXbMZU=McBJdiEpvk7y2OM0t+PrqZtQ@mail.gmail.com>
References: <CAFAcib-2fxiVxtVWcbvafY3-Br7Y70HMiHFZoT0VfK6JU0Dp9A@mail.gmail.com>
 <CABPp-BGYs9jo16OZR8NsL-eO9LwEttBxBspvp1-_JjuD2oBYbA@mail.gmail.com>
 <CAFAcib9FGfTe8C7TaOY91kzhUvxXtpx5Y8JMFkqxhRhLJeytxg@mail.gmail.com> <CA+WKDT3ZsObXc2ENV3gUXbMZU=McBJdiEpvk7y2OM0t+PrqZtQ@mail.gmail.com>
From:   Josh Bleecher Snyder <josharian@gmail.com>
Date:   Wed, 24 Jan 2018 10:46:44 -0800
Message-ID: <CAFAcib_MysZPZOJ5xTWrh8nLk1Tn3Vi4LbscxgBO-+02S9Wvkw@mail.gmail.com>
Subject: Re: git merge-tree: bug report and some feature requests
To:     Edward Thomson <ethomson@edwardthomson.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Ed. I think I'll pursue the libgit2 route; sounds promising.


>> But the alternative appears to be punting entirely, as libgit2 does,
>> and merely providing something akin to three index entries.
>
> Indeed, when I added merge to libgit2, we put the higher-level conflict
> analysis into application code because there was not much interest in it
> at the time.  I've been meaning to add this to `git_status` in libgit2,
> but it's not been a high priority.

Is your conflict analysis application code public? I might be game to
do some of the legwork to get it into libgit2's git_status (although
I'm probably not the right person to do the API design). At a minimum,
it would be helpful as a reference, as I'm probably about to recreate
some subset of it myself.


-josh
