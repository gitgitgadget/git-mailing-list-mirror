Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D213920248
	for <e@80x24.org>; Wed, 20 Mar 2019 14:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfCTOj3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 10:39:29 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41022 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfCTOj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 10:39:29 -0400
Received: by mail-vs1-f66.google.com with SMTP id z25so1611739vsk.8
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 07:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H8ppELgosYX9fdZw4Y7xZ/LJP7iZaOirhrS81SAny20=;
        b=fXfl9omP399cS2PElX9mQU1euw596q6nfsTGohBzpXCX2ja5ft5Pk80LA7IxwtFOYb
         S40Ahm0HzsectCGMGplrGkKWQQadeMkH5Xq6ApyVVr+wZLQHdzpnL+P1l2pD9VFfi7xd
         Ssg/yey/gmikH6GjOAoEyF8vE9XMnveTzOgg5YQU4PZm6+rLZ3tcpxyFGk14FRRUz6gs
         WELGFK2sDetFnm2mw+hnppqf56PS50f1Nr+4blxVfXH0ROOKrSxucu0wLNeP3G0Jt+Mg
         DaPRH60plXqchER1FGKEQnZ5HznIixELLQc/K6o7Zbb8A1inTM7yycbzIyWqYBIltraE
         F4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H8ppELgosYX9fdZw4Y7xZ/LJP7iZaOirhrS81SAny20=;
        b=tv+oDokpoJSAZyE4xKZrYiKdc6xXdnLZpkILHkg4iGjgn9Mc3UcocvL2rvt+VNCpXN
         fanqqA+0oEAwsDBWwng5u1aan9GSvLv+2x0lNVp+2NUC+YBNMfj5qcrQF4opAwuoJtbT
         7SgQ/eBbG6TOXWvF3Q0owkn3vGcuu40I+Mn5o2zKfACViqEkYc1t04L6VXEqb6AKeKqn
         uG2p8YajvOluccRqIf9+7aSjoP4skMYuu1newrsOBPiVd+O8qfiLNTTTbJ0R2zp6h3xV
         Zvt2+PUMViLth2VeFMit4UQr+7kGc8jBvDVTHjwpAUIYvtFrUwspkCPvffq/1irhJPeG
         Wy8A==
X-Gm-Message-State: APjAAAUzInjKf+qk0wZ5AOqeLbJUqEv60E7CbcteIAdK9R+9YUH9UFdL
        Ujub1SUNpRu/oCFbSXl0235YjXHcLbgI0227fIs=
X-Google-Smtp-Source: APXvYqxvJZEWT18cZKKpUK4BOFZ93EukN2OwDEdPpeCMACfOfg8nvmIZyJ13r4jfDoME3cUFzYZo3AkOj1WXYpgHuIo=
X-Received: by 2002:a67:b145:: with SMTP id z5mr4967641vsl.53.1553092767626;
 Wed, 20 Mar 2019 07:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <CALm+SVJR5BCHi_r7B279gKDukD4mYDQuv=K5guje73YDVmOxug@mail.gmail.com>
 <xmqq1s32w3vu.fsf@gitster-ct.c.googlers.com> <871s31vjo7.fsf@javad.com>
In-Reply-To: <871s31vjo7.fsf@javad.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 Mar 2019 08:39:16 -0600
Message-ID: <CABPp-BEe56GFM_2g7EyXmSrULFwRAvSPBomQ66jEQmCs=HhWpg@mail.gmail.com>
Subject: Re: [RFC PATCH] cherry-pick: set default `--mainline` parent to 1
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "C.J. Jameson" <cjcjameson@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 20, 2019 at 8:09 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> [...]
>
> > But I do have a very strong opinion against adding yet another
> > option that takes an optional argument.  If we want to allow
> > cherry-picking a merge commit just as easy as cherrry-picking a
> > single-parent commit, "git cherry-pick -m merge" (assuming 'merge'
> > is the tip of a branch that is a merge commit) that still requires
> > the user to say "-m" is not a good improvement.  We should just
> > accept "git cherry-pick merge" without any "-m" if we want to move
> > in this direction, I would think.
>
> Let's just make '-m 1' the default option indeed. No need for further
> complexities.
>
> Exactly according to what Junio has already said before. Here:
>
> https://public-inbox.org/git/xmqqsh5gt9sm.fsf@gitster-ct.c.googlers.com
>
> Junio wrote:
>
> > Now, it appears, at least to me, that the world pretty much accepted
> > that the first-parent worldview is often very convenient and worth
> > supporting by the tool, so the next logical step might be to set
> > opts->mainline to 1 by default (and allow an explicit "-m $n" from
> > the command line to override it).  But that should happen after this
> > patch lands---it is logically a separate step, I would think.
>
> ... and as that patch already landed...

This worries me that it'll lead to bad surprises.  Perhaps some folks
cherry-pick merges around intentionally, but I would want that to be a
rare occurrence at most.  There are lots of folks at $DAYJOB that
cherry-pick things, not all of them are expert git-users, and I am
certain several have erroneously attempted to cherry-pick merges
before.  I would much rather they continued to get an error message
and then asked other folks for help so that someone can explain to
them what they should instead be doing rather than silently changing
the current error into an unwanted operation.  Granted, the users will
at least get a confusing "Merge branch <foo>" commit message for
something that isn't a merge, but I don't think the users will notice
that either.  It just means we've got both confusing and ugly history
without the necessary individual commits or with too much having been
cherry-picked.  If -m 1 is too much to ask people to specify, could we
provide some other shorthand?  Or at least make a default-off config
option people would have to set if they want a cherry-pick of a merge
to succeed without specifying -m?

Elijah
