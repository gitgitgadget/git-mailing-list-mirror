Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE78C20A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 18:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbeLHSRz (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 13:17:55 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:33354 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbeLHSRz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 13:17:55 -0500
Received: by mail-io1-f68.google.com with SMTP id t24so5867705ioi.0
        for <git@vger.kernel.org>; Sat, 08 Dec 2018 10:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EZYDBFFDMs1j/kDFWbCHNdKY4EoP592hdW5zMDsIi4E=;
        b=jx7B8jNv4stxGGTwdOFqNolVnJWrihR4dg/fPXTC3Km//CFRx1gzt1S3Tni1FrJ1SQ
         K7WL7xstW7hhiv5RgWVahkD0/R20QUxKBMr6gC3GGbnY6dzK910B5MjVqZkHQaYkq7f9
         zCvdDjRq5DxBTdzPnAgWczhJY06wCpLzlYq/eYK+wjdMsPsVuFKm9XT1lV/2BDd7YP5y
         cIs6PBhlSX2zUOFejrVri/K5tGu185h9KAA3gz/zVKgHyICHgYCRhkIM4ZH64g/AKdxu
         uIRetwc7jld4Xhps6oQf3SK1tJJOV4UNyDlKTyDz5qHim/AYXfCJprfeoTrCSCKgxwiK
         VnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EZYDBFFDMs1j/kDFWbCHNdKY4EoP592hdW5zMDsIi4E=;
        b=kBrPP65lR/51MRmAHbWR6LXSDB8wnaX+EXEdwQJ0TichNNJyK7J5P6/HCGTVxj9tNt
         4w2zM80I7kEw/pxsv/WlMIzzWgeBqKtxkPpDu5f0I/o/BoiouadUd1SUpZxOZvRF6Ams
         KBN/mI0kfuF4dvppz5mZLGPe0tZJYGajAHc0Nyfans1jXTg295LerTE05wb1R9zKsVTg
         ND0476yxVV/eHcXeDG72gd4pP7tlS4opvETKyg0i1wsq6WHPxUmqTpmv4nHKZUWkg8cU
         SiU4cnNRNltfI+6tGLHUGU8I/zic5xQazyzbw+5aiLyrcbeeCIqEZLdxxeN7utzkxPSA
         mCTA==
X-Gm-Message-State: AA+aEWY7gOjdToHxpRG5fGGUK/eqzXYrnBFzQZwwy0IlmlZBnyWT5cM7
        DXY2M7WFqI8X7vQUgyUUCJcWBrSxZWvh+bSWR8DyvmT8
X-Google-Smtp-Source: AFSGD/Xc2GPI8T3z/Qwc2xf9xkl2JepcgOa+x3AHlhdEbeOc2d9JHMVnTEZnfy12qgrh9SUsjPW0ChY7M0wsZ+t/bBY=
X-Received: by 2002:a6b:6f15:: with SMTP id k21mr4557088ioc.236.1544293074251;
 Sat, 08 Dec 2018 10:17:54 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LFD.2.21.1812081103500.29142@localhost.localdomain>
 <CACsJy8APyyAWM+L=HU1XM4V+qdTWqjto6x=Q06By8DbgtYfpCA@mail.gmail.com>
 <alpine.LFD.2.21.1812081232240.32380@localhost.localdomain>
 <CACsJy8AC-anZ=EA3zxWeX8UUNcZiKsQMu8x0eCHAOCUjFWoFuQ@mail.gmail.com> <alpine.LFD.2.21.1812081236220.32716@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.1812081236220.32716@localhost.localdomain>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 8 Dec 2018 19:17:28 +0100
Message-ID: <CACsJy8A_vaVUt389O5ABa+vsrVDgo1L3WZzVx+P0qfiaY9=p1w@mail.gmail.com>
Subject: Re: why doesn't "git reset" mention optional pathspec?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 8, 2018 at 6:37 PM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
> On Sat, 8 Dec 2018, Duy Nguyen wrote:
>
> > On Sat, Dec 8, 2018 at 6:32 PM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> > >
> > > On Sat, 8 Dec 2018, Duy Nguyen wrote:
> > >
> > > > On Sat, Dec 8, 2018 at 5:08 PM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> > > > >
> > > > >
> > > > >   from "man git-reset":
> > > > >
> > > > > SYNOPSIS
> > > > >   git reset [-q] [<tree-ish>] [--] <paths>...
> > > > >   git reset (--patch | -p) [<tree-ish>] [--] [<paths>...]
> > > > >   git reset [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
> > > > >
> > > > > oddly, the third form says nothing about possible "<paths>", even
> > > > > though i'm pretty sure they're valid in that third case (at least
> > > > > for "--mixed"). thoughts? is that just an oversight in the man
> > > > > page?
> > > >
> > > > --mixed prints a deprecation warning. I don't think it's worth
> > > > making the synopsis more complicated for that. All other modes
> > > > reject pathspec.
> > >
> > >   i just tested this, and i don't see a deprecation warning.
> >
> > Hmm.. maybe I misread the code. I just tried it
> >
> > $ ./git reset --mixed HEAD foo
> > warning: --mixed with paths is deprecated; use 'git reset -- <paths>' instead.
>
>   weird ... i just tried this two ways, explicitly specifying
> "--mixed" and also without (which is the default mode, right?), and i
> got the deprecated message with the first but not the second. that
> seems ... odd.

Without --mixed, you're using the first form

    git reset [-q] [<tree-ish>] [--] <paths>...

which accepts pathspec. If it's not clear, of course patches are welcome.
-- 
Duy
