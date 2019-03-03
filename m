Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D7F820248
	for <e@80x24.org>; Sun,  3 Mar 2019 18:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfCCSda (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 13:33:30 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41270 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfCCSda (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 13:33:30 -0500
Received: by mail-ed1-f66.google.com with SMTP id x7so2426365eds.8
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 10:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K8Z0W6ALlbLBzDonkS/btL//Kt7RrJ9GseNs9heI8A8=;
        b=GQeDfzcdOAIB0m6sTwsXhCyOJcrNuEquP3/1gBx66U+mZCMEB8GxB9t6lEk0H7OAn7
         X21ii+YFEjNACEUhE8BSVE3y/xyZcLZfdXODbdgRb93O/Q+cpWHyrRLYOd+r1gThEViW
         1KHvX0PJvJ02O8D0N9Y32MVF56f9qKVpH18+g30jv1DdrCOCm4jwYpsdQlYn0QFeQuub
         vRHhoYbRgqzIf8rFoDYgHdy98ohdfLr7GZx1cTrW9Psu47a2GeLJS7MkgSGcSx9fIJr1
         cHHrHJ76lyy9Xn67Pa4LttZ2UOCebt9BiQRjD8lAFI4cSULrTr3oTNqpDm/m/+TO27A1
         KJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K8Z0W6ALlbLBzDonkS/btL//Kt7RrJ9GseNs9heI8A8=;
        b=AS/dc+58IqVCD6jh/JG66XYO3W+gK6+xIhvO7oRpJDZE8d0nkusYHVVxbmP6z3plz/
         RidN4tMEHS0NvcN1ETOgPuEFknDxrvxAWryG3oSGPOVxODSGVpxGb7Q/3Jdl/zzYD/Om
         nY9exEly2/YQL+vayA/Y0bzvksQW9LQgyfx8bJ3i75/NXBovnWij1JQgt/37SPLa4h0G
         dJsj9o9xB0o8dZz5/Tv5+dMooPup97LQz/B1HI9I9auX7poIs7vtO3KwfDH3kRV3L0kY
         +wW4QbPrCmAXuFOHEh2kHkfdNwOgbqvvFp8K+mk0Wus7koCMfoAN4Wd/ISjRwE6D6vpr
         8i2Q==
X-Gm-Message-State: APjAAAU9hbecgsd/gsCbXVGB4BimeaVo+GiKdy+snrFRB+c189F7AZVF
        LdKhjX9iIWxAmO/mBxE9Di1DQsQYfRxn9Db8z9w=
X-Google-Smtp-Source: APXvYqxQRnJm0Bf3QCDM7dug28UTTl0c9I3ivY4VbigoMEcjzlK9ErBRaG15w7zViILdqng0ZvyhHWa3h6Pki/aKARM=
X-Received: by 2002:a50:ae8a:: with SMTP id e10mr12694663edd.24.1551638008417;
 Sun, 03 Mar 2019 10:33:28 -0800 (PST)
MIME-Version: 1.0
References: <CAEpy5fTnyPjH0sVyjnGHi1qxo+_dpaerxwaD7MmNPbmLx6qyJA@mail.gmail.com>
 <xmqq1s40u8gt.fsf@gitster-ct.c.googlers.com> <20190222061949.GA9875@sigill.intra.peff.net>
In-Reply-To: <20190222061949.GA9875@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 3 Mar 2019 19:33:17 +0100
Message-ID: <CAP8UFD1puPt2c+EJRaBZmd_Fi5uJn0e4fthw8cpKoj7k+5Oy4g@mail.gmail.com>
Subject: Re: [PATCH 0/3] prettier bisect output
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bartosz Baranowski <bbaranow@redhat.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 7:19 AM Jeff King <peff@peff.net> wrote:
>
> On Thu, Feb 21, 2019 at 01:39:46PM -0800, Junio C Hamano wrote:

> > At the end of the bisection session, bisect.c::show_diff_tree() is
> > called on that "culprit" commit.  Is it possible that 3a9388ee is a
> > simple and trivial merge that does not have anything worth reporting
> > for "git diff-tree"?
>
> I've run across this many times, too. Since it's been bugging me for a
> decade, I thought I'd finally try to address it. Here are some patches.
>
> There was some discussion about a year ago about just using "git show"
> for this output:
>
>   https://public-inbox.org/git/CAP8UFD3QhTUj+j3vBGrm0sTQ2dSOLS-m2_PwFj6DZS4VZHKRTQ@mail.gmail.com/
>
> Christian seemed generally OK with tweaking the output, but preferred
> not to move all the way to running an external "git show".

Yeah, I am still OK with tweaking the output, though I'd rather not go
back to using an external process.

> I'm not sure
> I completely agree, but it was easy enough to get the results I wanted
> just by fiddling the current code a bit. ;)
>
>   [1/3]: bisect: use string arguments to feed internal diff-tree
>   [2/3]: bisect: fix internal diff-tree config loading
>   [3/3]: bisect: make diff-tree output prettier

I am OK with the above patches.

Thanks,
Christian.


>  bisect.c                    | 19 +++++--------------
>  t/t6030-bisect-porcelain.sh |  6 +++---
>  2 files changed, 8 insertions(+), 17 deletions(-)
>
> -Peff
