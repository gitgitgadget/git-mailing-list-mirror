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
	by dcvr.yhbt.net (Postfix) with ESMTP id C81A91F461
	for <e@80x24.org>; Sat, 18 May 2019 11:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbfERLuF (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 May 2019 07:50:05 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43932 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729814AbfERLuF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 May 2019 07:50:05 -0400
Received: by mail-io1-f68.google.com with SMTP id v7so7504277iob.10
        for <git@vger.kernel.org>; Sat, 18 May 2019 04:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WNKQaNaQhiwaKd1iY6zsto+48CA+oXpbxl14zstURz8=;
        b=fkfwU/sHiFSG0SJRyd20bmq6/HISmZtJIXvr2LqFb1FH4H/Jo7Bme4m3H1/9yAWBxb
         bOc0htbwRw+nSaxcunTWXTbDaUfInMVdU3QL+Qbq7oXmiCSdCuxOdRoGiQvxrPstYEgX
         vyCtzHPUenzePK7EIo67C7ghrY08eFkSrvRvse+HJzWaQyfHYEoidw4lIZYpHPdWSMOe
         OINTpgqFYxhSfCEQE5/i1fZRYMZU5iq2iV7uPlttFnhw5ON3NzbXQD1rH3Lr7JQ40ATp
         e1rFTS0G/o/u+jlTC9fzbqQCuPAKiru9QfQ4TDwNIDh/EzpU3a3e2zDy4jcxX8DvcNED
         kWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WNKQaNaQhiwaKd1iY6zsto+48CA+oXpbxl14zstURz8=;
        b=My+hFbzLFoeXRQfHu1T2uXs82baRlNSIjtA9xgtbxg2TWzHzDrP2M36+onkU4r+iUd
         dlruQoI9O0d5gHQ8s/wLDu31L1XQMNI3YO1p+7yNnckqr+fs5M5q2b0Nx0mLHc+Q/+I5
         dqIybQ5/P2sJkzqb0sZyYaw+m+M4K+6tzjvm6yWDrxbZYahfcwKYXO5OA4KwkhUcQeMv
         w2p8tn1N3v6AWp0tih+UdxIamSlHvwvOv5m1IZGy47X6PCGKqdWBGowEotcbfhrshB8F
         05WXNVILNeU18Zc3g4rixNpY6EiTC1YwrSKpeRQ5TWX5Tw0DyhK4JjhXDIgFr+yr2LLO
         ealw==
X-Gm-Message-State: APjAAAWjADyMgnX8JcZkz4CWagPOr0hYsGOcob7P0IvS2IUB/VD3uryM
        yCXYyfu9N3CUcUxbedkVxuvadaYBzvcFVql/goU=
X-Google-Smtp-Source: APXvYqzJSCjDOd29Nw4rMGXWv3kGxUAZVIAjI8223lrrsVc4z3M95qk1xJLnJ0sTPXScNATkCVBwNPg1DE4zzb1diYQ=
X-Received: by 2002:a6b:b907:: with SMTP id j7mr14370606iof.17.1558180204530;
 Sat, 18 May 2019 04:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAHAc2je-Yz4oej-sqvp+G+2Wv+eBABeJWUMm4scRwF2z_diUXw@mail.gmail.com>
 <20190513104944.20367-1-pclouds@gmail.com> <CAPig+cRNDmHD7JrvJL8yvo0r_3HSNdVuF79uYt7fG4iaBpCeCQ@mail.gmail.com>
In-Reply-To: <CAPig+cRNDmHD7JrvJL8yvo0r_3HSNdVuF79uYt7fG4iaBpCeCQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 18 May 2019 18:49:38 +0700
Message-ID: <CACsJy8BBtSo8ikwG4sMRYbM5=L4Ck-Cgioea6XGKt7-nVq_Ogg@mail.gmail.com>
Subject: Re: [PATCH] worktree add: be tolerant of corrupt worktrees
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Shaheed Haque <shaheedhaque@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 17, 2019 at 2:46 PM Eric Sunshine <sunshine@sunshineco.com> wro=
te:
>
> On Mon, May 13, 2019 at 6:50 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 <pclouds@gmail.com> wrote:
> > find_worktree() can die() unexpectedly because it uses real_path()
> > instead of the gentler version. When it's used in 'git worktree add' [1=
]
> > and there's a bad worktree, this die() could prevent people from adding
> > new worktrees.
>
> This is good to know because, to fix [1], I think we'll want to add a
> new function[2] akin to find_worktree(), but without magic suffix
> matching (that is, just literal absolute path comparison).

Yeah. find_worktree() was made to handle command line options from
worktree's move/remove, it's probably a bit too magical for this case.

I still want to store relative path in "gitdir" files at some point,
which would complicate the last "absolute path comparison" part a bit.
But it should be manageable.

> [1]: https://public-inbox.org/git/0308570E-AAA3-43B8-A592-F4DA9760DBED@sy=
nopsys.com/
> [2]: https://public-inbox.org/git/CAPig+cQh8hxeoVjLHDKhAcZVQPpPT5v0AUY8gs=
L9=3DqfJ7z-L2A@mail.gmail.com/
>
> > The "bad" condition to trigger this is when a parent of the worktree's
> > location is deleted. Then real_path() will complain.
> >
> > Use the other version so that bad worktrees won't affect 'worktree
> > add'. The bad ones will eventually be pruned, we just have to tolerate
> > them for a bit.
>
> The patch itself makes sense, though, as Shaheed noted in his
> response, pruning seems to get short-circuited somehow under this
> situation; perhaps that needs its own fix, but certainly shouldn't
> hold up this fix.

I might have missed that detail. Thanks for pointing out. Will get another =
look.
--=20
Duy
