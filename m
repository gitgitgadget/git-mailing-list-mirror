Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCFC61F462
	for <e@80x24.org>; Sat,  1 Jun 2019 19:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfFAT3s (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jun 2019 15:29:48 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40309 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfFAT3s (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jun 2019 15:29:48 -0400
Received: by mail-ot1-f68.google.com with SMTP id u11so12519755otq.7
        for <git@vger.kernel.org>; Sat, 01 Jun 2019 12:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uMWw5o61f7Dlr06Qkl8/vT7A8T5L94PV6jbrws4YT/I=;
        b=opoOSFYJPCwk4QAhuvhuVGLohf3A01xoW9mlhavPrwtC83bB0wC/sakOwdaNusld+Z
         MJGemVmtIEd5Kr2aLypqrmmszmBFRb3D+JdjbShC50IUcT7o0dQq/8SEXSra/zW39Cvi
         4XitUtQ3ylTC3NhJHbDwUi869/DIPykF7fH3WvOYLy9VCxC8mRLX6rkptDHWLzRdeHFm
         Mxu6OF+4X32sHkgJZTPMHurfazuiWxZUfgWXiqAIBKhs678Jp2o/4GuzymhaMg4W2g0c
         8YCc7GxwORAyFtO1HicH+Bb/tnPcnULN1uZ7ZhwMlxN7zYiKfOIXM0sR2fx9fl2o20An
         /MKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uMWw5o61f7Dlr06Qkl8/vT7A8T5L94PV6jbrws4YT/I=;
        b=iKCaDXc1cgbLEAFVzIE0++YCgyeFKSii1ZE7enVKWNm6f0DvnLzNCAZJx8YzCmtxtv
         RX7Fcb9imXjVUGbBvyjqdbN5Lm8zi8aB88OjbTRgDGKRBoNmhUgYSJtAXkv9ql/fo9Lx
         NO0xd0xuvk/Rk+2Xm3wQvA1Rz+DtQjY3YyEKsKPEXudglytY4RzbR/owpFNIWxFmlJMX
         H73JqqKIZZtKr/ItSknSvUjVaA6As2pgZ39eJAuSh2Xpxa80svB3VVIv9kVwQyIf+1HD
         qtfTWiS4c0CLSqzKfQWrB48h5ReTztKUoGZLcIe/rCjwY2a5wSqVUmZ2nvq2E61X6vgo
         BjUg==
X-Gm-Message-State: APjAAAUbIrg+9vdU5kT5KZtDSJqv3FhgzALCSAxFyW60isCBs5dS+qgL
        NOqzX4sSEq4b5f3tD5UCLRap38cW2XlvuHOWUFCftbHy
X-Google-Smtp-Source: APXvYqz6m5hpn7Tf2reqLXdEOkjqrbb27ktg5tmEwKqTX7XX6aV99pkmntZdaXDreL3KPLlnUbp5tcEmGRp2/l/AN9k=
X-Received: by 2002:a9d:60b:: with SMTP id 11mr6748820otn.9.1559417388122;
 Sat, 01 Jun 2019 12:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHAc2je-Yz4oej-sqvp+G+2Wv+eBABeJWUMm4scRwF2z_diUXw@mail.gmail.com>
 <20190513104944.20367-1-pclouds@gmail.com> <CAPig+cRNDmHD7JrvJL8yvo0r_3HSNdVuF79uYt7fG4iaBpCeCQ@mail.gmail.com>
 <CACsJy8BBtSo8ikwG4sMRYbM5=L4Ck-Cgioea6XGKt7-nVq_Ogg@mail.gmail.com>
In-Reply-To: <CACsJy8BBtSo8ikwG4sMRYbM5=L4Ck-Cgioea6XGKt7-nVq_Ogg@mail.gmail.com>
From:   Shaheed Haque <shaheedhaque@gmail.com>
Date:   Sat, 1 Jun 2019 20:29:36 +0100
Message-ID: <CAHAc2jdXDcOT61xSDcmSMrOxDDhEn+WeuP2OqKQ4=2wR58OCww@mail.gmail.com>
Subject: Re: [PATCH] worktree add: be tolerant of corrupt worktrees
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 18 May 2019 at 12:50, Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Fri, May 17, 2019 at 2:46 PM Eric Sunshine <sunshine@sunshineco.com> w=
rote:
> >
> > On Mon, May 13, 2019 at 6:50 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> > > find_worktree() can die() unexpectedly because it uses real_path()
> > > instead of the gentler version. When it's used in 'git worktree add' =
[1]
> > > and there's a bad worktree, this die() could prevent people from addi=
ng
> > > new worktrees.
> >
> > This is good to know because, to fix [1], I think we'll want to add a
> > new function[2] akin to find_worktree(), but without magic suffix
> > matching (that is, just literal absolute path comparison).
>
> Yeah. find_worktree() was made to handle command line options from
> worktree's move/remove, it's probably a bit too magical for this case.
>
> I still want to store relative path in "gitdir" files at some point,
> which would complicate the last "absolute path comparison" part a bit.
> But it should be manageable.
>
> > [1]: https://public-inbox.org/git/0308570E-AAA3-43B8-A592-F4DA9760DBED@=
synopsys.com/
> > [2]: https://public-inbox.org/git/CAPig+cQh8hxeoVjLHDKhAcZVQPpPT5v0AUY8=
gsL9=3DqfJ7z-L2A@mail.gmail.com/
> >
> > > The "bad" condition to trigger this is when a parent of the worktree'=
s
> > > location is deleted. Then real_path() will complain.
> > >
> > > Use the other version so that bad worktrees won't affect 'worktree
> > > add'. The bad ones will eventually be pruned, we just have to tolerat=
e
> > > them for a bit.
> >
> > The patch itself makes sense, though, as Shaheed noted in his
> > response, pruning seems to get short-circuited somehow under this
> > situation; perhaps that needs its own fix, but certainly shouldn't
> > hold up this fix.
>
> I might have missed that detail. Thanks for pointing out. Will get anothe=
r look.

On the off-chance this is not obvious to you experts, 'worktree
remove' also hits this issue, as you can see from this little example
I just caught:

$ git worktree remove --force /tmp/tmp56t59s2k/git_worktree.pa44kgs0
fatal: Invalid path '/tmp/tmpy4f98pwj': No such file or directory
$ mkdir /tmp/tmpy4f98pwj
$ git worktree remove --force /tmp/tmp56t59s2k/git_worktree.pa44kgs0
fatal: Invalid path '/tmp/tmp_q3p2mon': No such file or directory
$ mkdir /tmp/tmp_q3p2mon
...
several more suppressed
...
$ git worktree remove --force /tmp/tmp56t59s2k/git_worktree.pa44kgs0
fatal: '/tmp/tmp56t59s2k/git_worktree.pa44kgs0' is not a working tree

Thanks, Shaheed

>
> --
> Duy
