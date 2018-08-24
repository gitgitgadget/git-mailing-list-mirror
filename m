Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 995BB1F428
	for <e@80x24.org>; Fri, 24 Aug 2018 22:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeHYCcO (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 22:32:14 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:45963 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbeHYCcO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 22:32:14 -0400
Received: by mail-qt0-f177.google.com with SMTP id g44-v6so11226325qtb.12
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 15:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4LpIB0O0quaJ5V54xBB6/cRhrGQuY6CItiC8Rp6B9sU=;
        b=LiO7VwuT9bmlpBYn++IMIAou16yiLrVSDfc4n8ENyT5YaL38m864/u50atA5k6JtjK
         IW6cUdseBA3pxVWcJmJkKPG2qGK1elMwVXyTWuakam6D3pyMMd29fC0IsAyEhegJeFfO
         fqgPrQdBE0wA1CbOEbC7u54l/Hbh1BfXgy8lKQctwqHwxcphaQM+krWuSl6LzgoPqGOK
         mINji7B7MLcsdgaMI0xH4kZYBJO2R3zbyIJ3RbXtm8oZEZBwy4C11RBsEM1aUrJRYJcf
         /+jPZ/7/188S16nca7daJXEGJddRgx9Qfd/zt6jw26EkTppjEs16FpA90MA5QL6Je3lo
         ZB0A==
X-Gm-Message-State: APzg51AFm4KDapJholWsHjAvhzhHh/wdm5ZUW7ZxVEK77FR2hQW0kssN
        b94DKRRvfwHdmOm0Q8DBK1McWvIbFxDE4t5+eRQ=
X-Google-Smtp-Source: ANB0Vda+Dum+APZfmw/AvfhUvB98j+w+9BT+LNwLcLmbu43B/5YhQP9Z2TEMXrv3o2DOIswb5tVzN4fam0n1zPx7ppk=
X-Received: by 2002:a0c:e292:: with SMTP id r18-v6mr4043265qvl.62.1535151335434;
 Fri, 24 Aug 2018 15:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180821192321.GA720@sigill.intra.peff.net> <20180821193556.GA859@sigill.intra.peff.net>
 <CAPig+cT+LBSJHoR1kUi+S2h96y_qmVEpK0xAy6sRUGQj6GQEyg@mail.gmail.com>
 <20180821204341.GA24431@sigill.intra.peff.net> <CAPig+cTghgbBo5VfZN+VP2VM00nPkhUqm0dOUqO37arxraxBKw@mail.gmail.com>
 <CACsJy8BxxyRxqCj5ZoOmPaiwmFRKHU72yTxyC_eHXS+cEa94zw@mail.gmail.com>
In-Reply-To: <CACsJy8BxxyRxqCj5ZoOmPaiwmFRKHU72yTxyC_eHXS+cEa94zw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 24 Aug 2018 18:55:24 -0400
Message-ID: <CAPig+cQNkMEUj=6e=6czbkWeozJQ-Go09C6bZwVJUTpM3JJiiw@mail.gmail.com>
Subject: Re: worktree duplicates, was: [PATCH] SubmittingPatches: mention doc-diff
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 24, 2018 at 10:47 AM Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Aug 23, 2018 at 8:21 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > Peff wrote:
> > > Yes, but then what's the next step for my script? I can't "remove" since
> > > the worktree isn't there. I can't blow away any directory that I know
> > > about, since there isn't one.
> >
> > I was thinking that "worktree add" could start respecting the --force
> > option as an escape hatch.
> >
> > > What about refusing by default, but forcing an overwrite with "-f"?
> >
> > My thought, also.
>
> Sounds good. Eric are you going to implement this? Just checking so
> that I can (hopefully) cross this off my backlog ;-)

It wasn't something I was planning on working on (at least not
immediately) since it's still a bit fuzzy for me whether this is
enough to help Peff's use-case (and because I have several other
things in my queue, already).

However, before even considering implementing it, there's at least one
question (and possibly others) needing answering. For instance, how
should "add --force" interact with a locked (not-present) worktree?
Should it blast it despite the lock? Or would that need --force
specified twice ("git worktree add -f -f foo")?

As for the actual implementation, I haven't yet looked at how much
surgery will be needed to make 'add' respect --force.
