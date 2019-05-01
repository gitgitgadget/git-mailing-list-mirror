Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE29E1F453
	for <e@80x24.org>; Wed,  1 May 2019 07:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfEAHPd (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 03:15:33 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:44458 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfEAHPc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 03:15:32 -0400
Received: by mail-lj1-f182.google.com with SMTP id c6so8385371lji.11
        for <git@vger.kernel.org>; Wed, 01 May 2019 00:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6OLQJ5k2Wvsw3vIAagSOO+ysKjqTOCkE5f0f91RH6nQ=;
        b=ilDXcPbzqFpPywTbHhtR3TuXkr3y6YCpA+Kl3W25BNkv/DrlUwI9rzLC8YVPPZlewV
         NFTk2lB3WW8nsTsGqjyLD09u6bicDvVDH3f08CjMZ9yrGpfoVtf4GPzjEGCC0Rq/Px+l
         1k/j9dBbFo9+6dDMb8ySPaEdv3o9g0Ct+tHAX8A6NmBWknuBflfUUa560jOi8tbNXKFt
         E3WO6kb2sg2TGU2aVS0wGNS8E4FDaL5Zt1vzqWIsY6iLa16rM0hfQqMoF5n4ZASPAs1v
         MnejBZw05NIIMZBqqkI1FsH059NBL0f8zoaMDcqHDUsgpZT4y1Xr6tAgBiIgEw0kGNte
         Ugag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6OLQJ5k2Wvsw3vIAagSOO+ysKjqTOCkE5f0f91RH6nQ=;
        b=ODL81X/ke2Cb1HFyzwD3eMv/hnpCAcPPVT80BDckhLi+5C382SlzjXi+gk4c4RINrT
         Hj+XIeSto/ZJ5jwl5xk7g1dmWwD27BTbP9yaRXvUoxfC7g3kecWQ6XmLcaNnB5W256z0
         svdnrnSuHNfxBDV38uq5QPDgpb3RioS9/dgMzXLai3ezA5p/SRJ29Du432oleVH1PKOQ
         cUAHodXbQuLvhUrGrpFNenh6NnGw0Skl024n5LZclKp9bQh+C5Ug92mbRtRE+qb8KU3z
         Cse9w1L2DfF6+PZv3l7qIQ3B9R5e/59cRbIl7s6J3Q2S1tJo0pUHLtAWNH5MKiTI3ZgI
         MUvQ==
X-Gm-Message-State: APjAAAWchdirTEWIyfwk2y2x85dLLtW3Eug4xYkzRvB+e93S9MIC8DZ9
        yL801fpbcooPxYFAlSYhsTTYnfOAgL6G/nhZ2is=
X-Google-Smtp-Source: APXvYqy3zuk7/mwe66lANwxSkceeXmfdagBn+mMnxXSx4Zsdj5welCeiuIs9GJVP6g4NhxO9LdSFSuSY0ZgOjTY+rH0=
X-Received: by 2002:a2e:9d99:: with SMTP id c25mr5779607ljj.29.1556694930797;
 Wed, 01 May 2019 00:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAF8BazDu_GqoCPBQ-gEJ+q8n1aWSjf_TOV7bDE5VCQkDgBjyfQ@mail.gmail.com>
 <CAF8BazA-VYFns7o9F7gXfFZCspbM0yQKi+LQ+BnkpGH+EjPC9A@mail.gmail.com>
 <CACsJy8DSW2f3v1KpU-QrAz-EeLwG4mVm9ToDdA2=kXSmtsEAYw@mail.gmail.com>
 <CAF8BazBShg9F2uCuVQ_PM6196kOUNWOA1T9APkCXCoey7as2mQ@mail.gmail.com> <20190430174110.GA16729@sigill.intra.peff.net>
In-Reply-To: <20190430174110.GA16729@sigill.intra.peff.net>
From:   Aleksey Midenkov <midenok@gmail.com>
Date:   Wed, 1 May 2019 10:15:19 +0300
Message-ID: <CAF8BazBBP53uhh+oOroFuVCEL-FaqJheSYX5Q5_NQxGRt=g_xA@mail.gmail.com>
Subject: Re: Bug: fatal: Unable to create '.../.git/index.lock': File exists.
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 30, 2019 at 8:41 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Apr 30, 2019 at 02:19:11PM +0300, Aleksey Midenkov wrote:
>
> > > I gave it about 2000 commits (from v2.20.1 to master on git.git) to
> > > rebase. No luck.
> >
> > Please, try on this repo: git@github.com:tempesta-tech/mariadb
> >
> > ```
> > git checkout 62a082f573
> > git rebase -p -x /tmp/check.sh ca7fbcea6c4
> > ```
>
> It doesn't reproduce for me.
>
> Usually when we see racy contention on index.lock, the culprit turns out
> to be another unrelated git process refreshing the index. Do you have
> anything else running which might be using "git status" (e.g., magit in
> emacs, vim git integration, etc)?
>

kdevelop which is git-aware. But if git fails on concurrent operation
this is still not good. I would expect it to wait until lock releases
for some time.

I confirm, without kdevelop running it doesn't reproduce.

> -Peff



-- 
All the best,

Aleksey Midenkov
@midenok
