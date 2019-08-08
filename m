Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF1C51F732
	for <e@80x24.org>; Thu,  8 Aug 2019 22:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390491AbfHHWRz (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 18:17:55 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:41168 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390340AbfHHWRz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 18:17:55 -0400
Received: by mail-ot1-f49.google.com with SMTP id o101so125057681ota.8
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 15:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=influxdata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=7zmkAQo3zTdZ0dBCXkwIDiqrQ/OVpVh0TEb/uYwyw1g=;
        b=owglcZH44VCAz0KlPKtuR1FBc5b2qSFLFDRsK82wm9qbhIIK5P7MlKmnNRbJdlsGuC
         gG8/nrEA7GCNffZ92VOKQ8dZbXLIbIHeUULu7V6ZinFUCOTwScSmL1LP8fpGxeTzvNo1
         kTj/JZGK54s7r74aXZH4DEMy0Jy1+/zGGfv/yhniyS9dQEMLtP6CGcz2EvOXOhhRFrgO
         QcEh4FH4RWBNxYUANqT/m33INbhaYHthGIvFrhJDGhOauudQv7S8cvb2VbTtaxWlJIHi
         u3lA1Fe+i71Dt3tP3GebfIy4sUSkKD07+HkQbXl5fZaC0eWu1qd6rVdeJrxHV7xiEIDP
         b+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7zmkAQo3zTdZ0dBCXkwIDiqrQ/OVpVh0TEb/uYwyw1g=;
        b=qsadXnFCBZD+1wdO2/H3rQasjCcMDl//pSbHPTQ3vzPeoBARTy/I7MJjTzTx+m2Ari
         TQFnQQeKQG0XZaEmLkznZPXLgNhVLK84LUduJYq5wvKl6082RToCmrG/Qmg5zbm3TfTc
         mLXdep1SgzIW6U8wxbXvbpIzsYGgVG2RYRKsHqK+n0PX/iS+ip+UlNJibgpDPkRhtubd
         e/H3V34gQsreq16dIEV08TJHmGLI4vDcO+n9X8AwM96Z+/3AUE/Ne5IO29vZvJZwokxx
         6iSJQfIK2C/Tuxk1P0mmsg5uGxn1qXkR81SXjOk0VhI8yVPRiXXHKJxvXrHgfkZmNaSZ
         vwqA==
X-Gm-Message-State: APjAAAX9SQOXbmnZ6OcDUSuOmUiN/mki9XkcJWdgPjRy9F2wIQIOKZ1P
        42esW9tAzn66qtGsRqBmx/qJ7UFSgDtlj2YFwEYy/LnU2DU=
X-Google-Smtp-Source: APXvYqzufrqxZ1Sv17/ke+bVg7Fa80s47kxZ4qb8sArzk+K0RM/0UzVRHGgmVwgo7O35aiECt9inRjDzrdRodZ84PjY=
X-Received: by 2002:a6b:bc42:: with SMTP id m63mr17036804iof.189.1565302674357;
 Thu, 08 Aug 2019 15:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <CALxJwdP70PpcJKFC3FRm5t58yjxz438WwYisuFwQsJ2oaXV_9A@mail.gmail.com>
In-Reply-To: <CALxJwdP70PpcJKFC3FRm5t58yjxz438WwYisuFwQsJ2oaXV_9A@mail.gmail.com>
From:   Mark Rushakoff <mark@influxdata.com>
Date:   Thu, 8 Aug 2019 15:17:43 -0700
Message-ID: <CALxJwdM0ifKoQDMXJuuWyeXdR9-oxVpOyODBO0TXcz=d+0vq2Q@mail.gmail.com>
Subject: Re: Possible to unshallow or deepen based on local objects?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 26, 2019 at 11:43 AM Mark Rushakoff <mark@influxdata.com> wrote:
>
> I am building some CI tooling, and I am working with a large-ish repository, so
> I am trying to start with a shallow clone of the repository and deepen it on
> demand. I am finding it very difficult to correctly switch between fetch
> --depth and fetch --deepen.
>
> I am looking for a way to "recover" from a fetch --depth call that made my
> history shallower than before. Ultimately, I may take a different approach to
> just work around this altogether, but I thought I'd ask here first.
>
> In particular, if there is history like this:
>
> A --- B --- C --- D --- E --- F
>        \                 \
>          ---------------- G
> And my shallow history includes D..F, then I believe I am limited in my options
> for fetching G:
>
> - If I do a plain fetch of G, or if I use --deepen, then I pull in A and all of
>   its history, which I don't strictly need or want yet.
> - If I know G's parent is B, and I fetch --depth=1, then (I think) I will see
>   B, E, F, and G, effectively losing sight of D
>
> As a more contrived example, suppose I have a shallow clone of a repository:
>
> bash-3.2$ git clone --depth=4 -q git@github.com:git/git.git
> bash-3.2$ cd git
> bash-3.2$ git log --format='%h %d'
> 3034dab  (HEAD -> master, origin/master, origin/HEAD)
> 98e06de
> 352253a
> 4098130  (grafted)
> 7b974e3
> df63c2e
> 75ce486  (grafted)
> 70b39fb  (grafted)
> afc3bf6  (grafted)
> bash-3.2$ cat .git/shallow
> 409813088ad55ae4a60f55412f6b5ba6a89d89e7
> 70b39fbede78313656e8a6bd9b38b238ab10db2f
> 75ce48674889df6a2bb493fb5d6bef0ef60ca7ae
> afc3bf6eb13d9fc489b569164819cff44db8ac17
>
> And then suppose I fetch with depth smaller than before:
>
> bash-3.2$ git fetch --depth=1 -q
> bash-3.2$ git log --format='%h %d'
> 3034dab  (grafted, HEAD -> master, origin/master, origin/HEAD)
> bash-3.2$ cat .git/shallow
> 3034dab9ed6b11970a53099a7b3ca981f1461365
> 409813088ad55ae4a60f55412f6b5ba6a89d89e7
> 70b39fbede78313656e8a6bd9b38b238ab10db2f
> 75ce48674889df6a2bb493fb5d6bef0ef60ca7ae
> afc3bf6eb13d9fc489b569164819cff44db8ac17
>
> I can still see the commits I had before the --depth=1 fetch:
>
> bash-3.2$ git log -1 --format=oneline 75ce486
> 75ce48674889df6a2bb493fb5d6bef0ef60ca7ae (grafted) Merge branch
> 'di/readme-markup-fix'
>
> Short of looking through .git/shallow and removing each entry whose parents I
> can resolve, is there a built-in command to "unshallow based on local objects"?
> I have tried many web search terms, I have looked through the docs for many
> low-level git commands, I have tried variations of "git fetch .", and I am
> stumped.

I've run into another flavor of this problem now.

I have a shallow clone of a repository. Then sometime later, I obtain a bundle
containing full history.

I thought I could use git fetch --unshallow /path/to/repo.bundle
mybranch:mybranch, but I've found that git does not support shallow fetches
from a bundle and that unshallow is actually an alias for --depth=2147483647 in
4dcb167fc3 (fetch: add --unshallow for turning shallow repo into complete one,
2013-01-11).

If I do a plain fetch from the bundle, I can manually modify .git/shallow to
"unshallow" my repository like the previous email in this thread. But what I
think I still want here is a way to tell git "here are all the objects I have;
update the shallow boundaries accordingly."
