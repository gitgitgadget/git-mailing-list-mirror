Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4486C1F463
	for <e@80x24.org>; Sun, 15 Sep 2019 21:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfIOVvP (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Sep 2019 17:51:15 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33031 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfIOVvP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Sep 2019 17:51:15 -0400
Received: by mail-qt1-f195.google.com with SMTP id r5so40912391qtd.0
        for <git@vger.kernel.org>; Sun, 15 Sep 2019 14:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3qOCK0F/FevAYkbmIuh86FHYFI5bMC+c0F/HWQCu3tY=;
        b=Ag2IU2GILm9k4/8nrLn2xaO+APz7/0wIzwQndf+YkV/USU2355Y8B4ejS4Rj+pZZMG
         r48gV4m8Bkg1/KqRHfGg3C8tOwDI+FAHxDib6Y3k07ebQbbcyETQiEG5R6eE+v8wCVwz
         6NGIoW8xTksbcv2h6wcE8GyCguCC5rcs/HSR4UFkF6YWOpWCCC1xriS0cQaH8SXdjVj2
         orMFtN9UAhH5cqZCOKgZHfiyGKd2DnX/hIJKLHhTQfpPLdSDrNdx2ZHplOHZvD6yG0xL
         9JLUYTAfYBcFJs51SFhS9G3UX4J3GGl1VSOHbUwGrvsxwQhmgdKZcA59Tj+y42HZX0sG
         oKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3qOCK0F/FevAYkbmIuh86FHYFI5bMC+c0F/HWQCu3tY=;
        b=U361ozraOlOSrAOf66ai98hchrGuJ/hZ1im8CmB/V7XRBPxgPHRi21D2WZ6VjYdcWz
         a2N71xKu3e7gS+DireDlLNNS0EyA/I7zn75VLjBlq/XK4IOAwkBauM/tAk7cFHCY/EHu
         zm40VyCbaj7NWyZwK1uEmuV4syT7t5RCvG9MgdxyhzqRBmFTsLpa28r7/vS8G+g/pl9Q
         4Iti+9E52QCdZYnxnjZ9FMhEf4KliKAU8M6PrTJ3jXT0J+s/VewMT9OsKsQU76V/gYFR
         TJXV0KqEFhtq6jcYDl+x+7PkMupXxfSFNzxETIlH3BxbzDMhuXBZd8ARCFtMxDW/8GQb
         VaQA==
X-Gm-Message-State: APjAAAXuXefmAs4r2rphNULe1bmcDGLLT9G8N3yrJySo9h4pfGCHfqkR
        /gYbyrHTfgpyNMcQQfqUyJe4ylQuDjUtOx0sgwbHqMpY
X-Google-Smtp-Source: APXvYqxA2jzf3ZzhQnSHVw2cY0+SOKAINGdHgjC/nWjWkvAfzB+Mref190kNGwE/ixVYD9/X0MOLYhJH0YCSGGNjRj8=
X-Received: by 2002:ac8:1c2d:: with SMTP id a42mr13951304qtk.91.1568584273297;
 Sun, 15 Sep 2019 14:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190707055132.103736-1-masayasuzuki@google.com>
 <20190709125620.GA18175@sigill.intra.peff.net> <CAJB1erXRg4S-vzRZwA-Q5cXAPayRE0dAjFjjkNQ9CoKiXF=7EQ@mail.gmail.com>
 <20190722210037.GA31664@sigill.intra.peff.net> <xmqqsgpnj3hv.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsgpnj3hv.fsf@gitster-ct.c.googlers.com>
From:   Masaya Suzuki <masayasuzuki@google.com>
Date:   Sun, 15 Sep 2019 14:50:59 -0700
Message-ID: <CAJB1erXHWKu35_7EJ7tK7X4jkzcWA6KR8LqNdR8Mf=hY+rWK+w@mail.gmail.com>
Subject: Re: [PATCH] credential: add nocache option to the credentials API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 26, 2019 at 9:28 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > I was thinking that Git itself could treat "ttl=0" specially, the same
> > as your nocache, and avoid passing it along to any helpers during the
> > approve stage. That would make it exactly equivalent to your patch
> > (modulo the name change).
> > ...
> > And as you noted above, if we don't suppress the helper calls inside
> > Git, then every matching storage helper needs to learn about "nocache"
> > (or "ttl") before it will do any good.
>
> I was waiting for this discussion to settle and then the discussion
> seems to have petered out.  Any interest to following the "ttl with
> special casing value 0 as 'nocache'" idea thru from either two of
> you, or should I take the patch as is in the meantime?

Sorry for the late reply. I think about this again. I imagine that, if
I would like to have credentials with an expiration and I want to have
them managed by other helpers, it's probably better to use an absolute
timestamp instead of duration. The second call to the helpers is done
after the remote call. For the helpers that store TTL-ed credentials,
they cannot tell the start time of the TTL in the second call. This
makes it hard to cache the short-lived credentials safely because some
time has spent during the remote call and the actual TTL is shorter
than ttl=N option. From this, instead of adding ttl=DURATION, it might
be better to have expires_at=TIMESTAMP.

Maybe my observation is not an issue. I don't know. For now, adding
nocache seems a safer action for me, so I vote for taking nocache
patch as-is in the meantime. If there's somebody who wants to receive
TTL or expiration timestamp, they can decide what's actually needed
later.
