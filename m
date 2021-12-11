Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75235C433EF
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 09:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhLKJ6f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 04:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbhLKJ6f (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 04:58:35 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097A0C061714
        for <git@vger.kernel.org>; Sat, 11 Dec 2021 01:58:34 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id m6so10439646lfu.1
        for <git@vger.kernel.org>; Sat, 11 Dec 2021 01:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N747oZX37sPy9c//yjOC4AtSs8mtF528PYGgaMMO3zs=;
        b=d4K2HSMtdnJZZbnDlFF16xj2kvEu4gmLvoC7BAmwVYnwGHxmxMIU1qwTfbLTwT6juD
         R2TuRBpkGWamuRtesC55n1lJrruh1hLOLEpcNeWQphzqk5Nive3CpMn2HfScvpYBnff1
         4fLhR1I9GP475mfjomfYYcsce0+Lvmj0VEoDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N747oZX37sPy9c//yjOC4AtSs8mtF528PYGgaMMO3zs=;
        b=pA7PLaL+ShsvnnPqHZtxU5BuiL1pZRnBb86xuPJJnxTkrZ45UVCiRBHzOYI+axqL5v
         +4jiIZ1S2VwNeWhwILHURZ7MtjBpWc39SUyZPV5gCldtOpNngU/Y404An/W2ew7+llyz
         TYb9PsnEjc82WgcNjBeBAqeCzSONlQN9NHOkmgwxMujg16FOFYns1J6zJeKdNGduVLyq
         rivNhI5FwWhLb9e2UiVt9BQtt4c9Dezv4V7ugKK9KrWTamMs9p1rAIN/oRrXtdk/Qrtg
         sUJ0SDWaqhgKkyRRO1okf6sKPqqne9HYbRDnNDnP85jp1EKh3yAk1vWa/xxq6/BoCwph
         okZw==
X-Gm-Message-State: AOAM533csgmN85YJZz8AKIHUuenIR4amB5W5Oyr0kKpAjyqFBxP2l+Hf
        zflU62Ft0Lb99XX8uT6/IufGgP34Wb/lKUbtUNJnXp/3ZDQ=
X-Google-Smtp-Source: ABdhPJwBzMY6wk7X4XRJwDVuoArJ5zT0jLPWR1KVGYh5BswOe91x2NYuUaO34QLVMqH7VDYUWEW5HyHcUgjJ6AfCtNY=
X-Received: by 2002:ac2:4c48:: with SMTP id o8mr16861231lfk.690.1639216713193;
 Sat, 11 Dec 2021 01:58:33 -0800 (PST)
MIME-Version: 1.0
References: <20211209201029.136886-1-jholdsworth@nvidia.com>
 <CAE5ih7872E8X-qRfBrBOHmKcUCX46GkXwq2WD3UUX8TuYczZDw@mail.gmail.com> <BN8PR12MB33613E4CCDF13E6D0DE155BEC8719@BN8PR12MB3361.namprd12.prod.outlook.com>
In-Reply-To: <BN8PR12MB33613E4CCDF13E6D0DE155BEC8719@BN8PR12MB3361.namprd12.prod.outlook.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Sat, 11 Dec 2021 09:58:22 +0000
Message-ID: <CAE5ih7-ZoKThXefBN=znytQi=z4_notihQdSksYdMTzKDTAb=w@mail.gmail.com>
Subject: Re: [PATCH 0/6] Transition git-p4.py to support Python 3 only
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 10 Dec 2021 at 10:54, Joel Holdsworth <jholdsworth@nvidia.com> wrote:
>
> > I might as well take this opportunity to say that I've stopped needing to
> > worry about git-p4!
> >
> > Hurrah!
>
> Lucky you. It looks like I'm going to be working with Perforce a lot in the coming years, but if I can get the bridge to git working really nicely, then I am hoping to have a happy workflow even so.

I cannot begin to tell you how liberating it is to just have a pure
git workflow!

But yes, git-p4 at least stops some of the pain.

>
> > I'm finding that the unit tests no longer pass with this change. I'm not exactly
> > sure why.
>
> What unit tests are these? I am happy to test with them.

    cd t
    make T=t98* -j$(nproc)
