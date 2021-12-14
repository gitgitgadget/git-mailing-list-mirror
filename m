Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBA0C433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 07:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhLNHs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 02:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbhLNHs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 02:48:28 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C0AC061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 23:48:27 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id g14so59179088edb.8
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 23:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MaGmZ2Yboj4Pq3UohuiRMyZPt9Z53fIJCGiBfnyjilc=;
        b=EY69EY6IsDlOQ0fZjgna/6XbAmiJCe2hX0B3vheg1rwtHUskHTBsn/ETj17U0Dmwu3
         g5nuaFaZ7IZH3JQAfkk/cJ/mOf77f3qF17i67Lo0IR5LnvO/m81bA0LsDd7Ff5BSJkjL
         c40M8a3ix/nTjONNKfSi3yoGIl3w6S7Ppnd1+kcpsYdc9BGKsnr7Y9KXD9NgP4z7nnqI
         V62x+PKavjXSx3C9zGLEmsTij9Y9xAasaT49St6RX9iapJd9EEpJB9JzHFEGNKUk/09K
         pGULmTY1AaDLrY3d/3MYo9LzI1NRx+gF0YI2Ay7Kkuua5/y/90EjgcsIsniRsQB1tb57
         /g1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MaGmZ2Yboj4Pq3UohuiRMyZPt9Z53fIJCGiBfnyjilc=;
        b=cF1Yzuvyudk46qfEeTrGRR6mEy8D+7ajptX4Xqy9HO0Te8nsXVQ9HaFtIal9eJa9mI
         GtpKqx4wf1XJj6nOX/S++jKFYieTMXohgxSrjgwTNfdmUxc8xT/N+8ZslFJ7dPvhmEql
         ZU9te3p/T+1Ru+zEUM12EE3kKfQaqHUZgmst5yQjgYs6+bFAbA13MBeFdcZpMNAp9xa9
         ryqglsn7uZh+ymXSYgeUrCrWZl8owR9VcUvRqfQO7IEfFMzHjZaptyNVLsLgNymXzWzR
         Nm5+1UAvumC3YHOtQSRiYFIql7vJLdK4fuVz/K57UHhhC4vWFDxHZp/nxGYzZARMREVP
         5KyQ==
X-Gm-Message-State: AOAM533ALJbeMfhboqRK/1EYPJd4c0hw98eRglB8AAGfZ/jntIIHMlNo
        xxYWRH6f2bB1YRApaAF7zcgaUXfcVb5QnOTkYPzjlGun
X-Google-Smtp-Source: ABdhPJz8oU+AlVW+SAdVJ1pUwyinJ3IkV1ofn7kBMMLcR7TCKSBmje8cUQRMkyR4ehgpr/5lP3doci33Zav3jnFcad0=
X-Received: by 2002:a17:907:2d11:: with SMTP id gs17mr4268563ejc.100.1639468104990;
 Mon, 13 Dec 2021 23:48:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
 <pull.1151.v4.git.git.1639454952.gitgitgadget@gmail.com> <f669829a98b590d8a53be75b88d97b1d004eb855.1639454952.git.gitgitgadget@gmail.com>
 <84ffc06d-09a7-0180-5460-6e1460b8aaac@gmail.com>
In-Reply-To: <84ffc06d-09a7-0180-5460-6e1460b8aaac@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Dec 2021 23:48:13 -0800
Message-ID: <CABPp-BFDF2YsUQw7RE=WgupN9i6Q8pRH2M6r1YgP9c6JChTRPA@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] Documentation: clarify/correct a few sparsity
 related statements
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 13, 2021 at 11:38 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 14/12/21 11.09, Elijah Newren via GitGitGadget wrote:
> >   --sparse::
> > -     Initialize the sparse-checkout file so the working
> > -     directory starts with only the files in the root
> > -     of the repository. The sparse-checkout file can be
> > -     modified to grow the working directory as needed.
> > +     Employ a sparse-checkout, with only files in the toplevel
> > +     directory initially being present.  The
> > +     linkgit:git-sparse-checkout[1] command can be used to grow the
> > +     working directory as needed.
> >
>
> s/toplevel/top-level/

No, the only occurrence of either term in Documentation/glossary.txt
(though used incidentally) is 'toplevel' rather than 'top-level', git
rev-parse has a --show-toplevel flag with no hyphen between top and
level, and the occurrences of 'toplevel' in the codebase from a quick
grep outnumber top-level 2 to 1.  I'll keep 'toplevel'.

> >   It uses the skip-worktree bit (see linkgit:git-update-index[1]) to tell
> >   Git whether a file in the working directory is worth looking at. If
> >   the skip-worktree bit is set, then the file is ignored in the working
> > -directory. Git will not populate the contents of those files, which
> > +directory. Git will avoid populating the contents of those files, which
> >   makes a sparse checkout helpful when working in a repository with many
> >   files, but only a few are important to the current user.
> >
>
> Looks OK.
