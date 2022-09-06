Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AC4C38145
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 19:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiIFTi1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 15:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiIFTiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 15:38:25 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054929A9FD
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 12:38:22 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e20so16942704wri.13
        for <git@vger.kernel.org>; Tue, 06 Sep 2022 12:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=EXFwczpmxzfGQ+q5nQuGjac7lec40qxle3YBqoW2ABI=;
        b=ks4wNxORyhi8R1/w+spR/MeG4tBk5vdQ0eHp/lGXruwfopeWZWHaBsPJXNfeoJ8OnS
         +3K7RuxBXXkQzxJL5UTfe15X1CSAf+xDFYnnblyrlpID9tOHBDN1c19TjJUyXJ9A6DDT
         h7amjpi3xVBNCDybiQBtghe3/AUj1l367EpY4ZUsf+QwnExj4XAC6vnImUFH0ewDeWv1
         lW2PXCGhpddWtsskmIO04gAi9hOBCOKM7/t8lLH/e8Yp7dMT4WIOjAfhL5n8WyHLSSZ4
         irP6IGOp7j1Eysy/H1v6bRsU2DGf8qo0cDO6i90jrFcnO7BsOtrFmsXkVRpjOItW3QmM
         hJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=EXFwczpmxzfGQ+q5nQuGjac7lec40qxle3YBqoW2ABI=;
        b=7WeQP+lxXAkkgEql1eb4J6UPmgRHrpi90gvtwScAno1VWLC/jNl/MbJ/rpaeFVl9CV
         0qg33jaKdwL+Li56Y0u3CW2L1HgNAGih6AdOSge6TbYXtwf11GbAQ1UFOvvIaxApwPdC
         lL+VIAFG4rdJ5fCXZiz89kIjDdsoP/vnTuLoxWPGN9jyClG60dhDpsoFAl4AdwxBnHIH
         H35XUBB1jTmeZJMs8787XiGN+gjl6gI3eQifeltBjYwqMXn3x4tTKVsiG+OP44JxmppR
         Ry5rf1ZM8ebMmdL6ToRqP/JnTNPFkMQVYk6SiMqLhw/BItN4LzQe79B/Oz0oDeDTkT1q
         NKIg==
X-Gm-Message-State: ACgBeo1g5QzAKWtbDCPjvOLm+3CzX2zMPDIWHHmGDWTBEPfAX7PY6Hb4
        5bKcAZif++w6CuPctSHwlebmIx8JLDdHBe0v++M=
X-Google-Smtp-Source: AA6agR5cpMoVt7NZIjBaMByyzE/4GLg9zd1wSrJXj53i3UpxbRIx5UEV6npm95gnVWONCWa6pz1cNj1iEIJ1aB9J8yQ=
X-Received: by 2002:a5d:6c6b:0:b0:225:dde:ab40 with SMTP id
 r11-20020a5d6c6b000000b002250ddeab40mr21836wrz.690.1662493101405; Tue, 06 Sep
 2022 12:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <CA+4x=b_07g6STT0nvma_gRhv=zdj+7TQx5SxKLUtuqONLwv=TQ@mail.gmail.com>
 <YxKo2l5nBoOa9Jfa@coredump.intra.peff.net>
In-Reply-To: <YxKo2l5nBoOa9Jfa@coredump.intra.peff.net>
From:   Lana Deere <lana.deere@gmail.com>
Date:   Tue, 6 Sep 2022 15:37:45 -0400
Message-ID: <CA+4x=b-GYMnZygHXOfNb3CdSRoxUeT80n=gSCLyfCA9WsB0wEw@mail.gmail.com>
Subject: Re: 2.37.2 can't "git pull" but 2.18.0 can
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the final output from git bisect:

$ git bisect good
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[d8d3d632f4165955da49032d50279c20cfbde2e5] hooks--update.sample: use
hash-agnostic zero OID

Does that offer any hint about what is going on?

Incidentally, some but not all of the pulls produced additional
output.  Maybe it's a clue?

$ ~/tmp/git/install/bin/git pull
warning: Pulling without specifying how to reconcile divergent branches is
discouraged. You can squelch this message by running one of the following
commands sometime before your next pull:

  git config pull.rebase false  # merge (the default strategy)
  git config pull.rebase true   # rebase
  git config pull.ff only       # fast-forward only

You can replace "git config" with "git config --global" to set a default
preference for all repositories. You can also pass --rebase, --no-rebase,
or --ff-only on the command line to override the configured default per
invocation.

From http://githost:7990/scm/dp/d2s_sw
 * branch                  feature/switch-to-qt5 -> FETCH_HEAD
Already up to date.


.. Lana (lana.deere@gmail.com)

On Fri, Sep 2, 2022 at 9:07 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Sep 02, 2022 at 03:27:55PM -0400, Lana Deere wrote:
>
> > I'm testing an upgrade to git 2.37.2 from the current version we're
> > using of 2.18.0.  When I try to pull in my development tree, 2.37.2
> > gives me an error but 2.18.0 things all is fine:
> >
> > $ /tools/linux-x86_64/git/2.37.2/bin/git pull
> > Your configuration specifies to merge with the ref
> > 'refs/heads/feature/switch-to-qt5'
> > from the remote, but no such ref was fetched.
> >
> > $ /tools/linux-x86_64/git/2.18.0/bin/git pull
> > From http://githost:7990/scm/dp/sw
> >  * branch                  feature/switch-to-qt5 -> FETCH_HEAD
> > Already up to date.
> >
> > Anyone have any ideas about this?  All I could find on google was a
> > suggestion that the "no such ref" message indicates the remote branch
> > was deleted, but that's not the case here.
>
> It's curious that the older version shows us fetching into FETCH_HEAD,
> but the new one doesn't. I wonder if you have some unusual refspecs. Or
> perhaps a branch.*.remote config option which fetches from a different
> remote. The "git config" output brian asked for may be instructive
> there.
>
> If it's possible for you to build Git from source, it may also be
> interesting to bisect to find the commit that caused the change.
>
> -Peff
