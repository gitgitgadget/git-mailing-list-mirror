Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEDA620A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 17:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbeLHRfD (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 12:35:03 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40586 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeLHRfD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 12:35:03 -0500
Received: by mail-io1-f67.google.com with SMTP id n9so5764196ioh.7
        for <git@vger.kernel.org>; Sat, 08 Dec 2018 09:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PEp726HTMHuBSnqarCXo/yCl+8HqxobLwu59CI3qEoA=;
        b=TkYmPLrxHkBMf5aH8Dn9CBvDS93oU0JMNLFqWEodeEK0HCeNtHdCcDiOvFg+zhw35v
         y7dFthtMegYPScODYd2oHHNDYnYVjh5nCEn5dIcmSG4K0tJDvfLapSelEi2m1V9iG+xm
         uds8hVxaJoIp41PvXI76xhJx0AbronrOB5Yx9nHlVoJ4Xg2F1iuWqACw0NcnfBLud/b1
         feY6Jjk+BX357TryQ9heqQ5SUo904f52dENCCpBzMNJlc3nFonAopPVMFavjQkWaCHPU
         l9+GoABM9qeQKNkr6uHCTicpbYcGd5KxDuuxdbw2BYqFllJTkMxDujzcV1yK6mvRpEMu
         Hv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PEp726HTMHuBSnqarCXo/yCl+8HqxobLwu59CI3qEoA=;
        b=JMTzgMvoXXUSafRvRWBmmKYUjboXb1IEETmSPCDwWQ6hp614njANRewpjPjiMHFVjl
         5pVwypWOxLHn9qoCsrC63/yNGgHyZjgGED/PwYo0spN7PtbHj1SNBDItqy9xNXhrUBY+
         hjeN2aXGh5AU+vxvwjI/yxx0CgsP9tEsYhSxrzCRi3snOO7WAMWAdFkMFp91d1+LQ7DT
         Nj1jjan55cz5PzRllcBTgYVWK3dxX7xQNQOdh1JJVkAtJXf5GVN/2ohIF4u8bugNuB4B
         A1qesCXOGRWQfA1weDy0bBxFe9cpXOpTquK9bRR9MHs7g5BI27SE9/xNF5oOEOi36c8e
         0VyQ==
X-Gm-Message-State: AA+aEWbv/jQCYkZzBFymBasUruInop5p7iVhSf3cXJGsSOg94VZ54xUy
        aBpGh8Gx8QFKYRwuagpHluA0UHWTHJkAU4r/WdQJoctX
X-Google-Smtp-Source: AFSGD/W9b8fVjIU/Fk4pnjdNqXVfMHfQfPFNMdKWqnhCeEBfnPSwk0RDXwNWVyqK7Rghd3CbLuyGq27Y3oHzH5mToEg=
X-Received: by 2002:a5d:944d:: with SMTP id x13mr4532588ior.282.1544290502885;
 Sat, 08 Dec 2018 09:35:02 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LFD.2.21.1812081103500.29142@localhost.localdomain>
 <CACsJy8APyyAWM+L=HU1XM4V+qdTWqjto6x=Q06By8DbgtYfpCA@mail.gmail.com> <alpine.LFD.2.21.1812081232240.32380@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.1812081232240.32380@localhost.localdomain>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 8 Dec 2018 18:34:36 +0100
Message-ID: <CACsJy8AC-anZ=EA3zxWeX8UUNcZiKsQMu8x0eCHAOCUjFWoFuQ@mail.gmail.com>
Subject: Re: why doesn't "git reset" mention optional pathspec?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 8, 2018 at 6:32 PM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
> On Sat, 8 Dec 2018, Duy Nguyen wrote:
>
> > On Sat, Dec 8, 2018 at 5:08 PM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> > >
> > >
> > >   from "man git-reset":
> > >
> > > SYNOPSIS
> > >   git reset [-q] [<tree-ish>] [--] <paths>...
> > >   git reset (--patch | -p) [<tree-ish>] [--] [<paths>...]
> > >   git reset [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
> > >
> > > oddly, the third form says nothing about possible "<paths>", even
> > > though i'm pretty sure they're valid in that third case (at least
> > > for "--mixed"). thoughts? is that just an oversight in the man
> > > page?
> >
> > --mixed prints a deprecation warning. I don't think it's worth
> > making the synopsis more complicated for that. All other modes
> > reject pathspec.
>
>   i just tested this, and i don't see a deprecation warning.

Hmm.. maybe I misread the code. I just tried it

$ ./git reset --mixed HEAD foo
warning: --mixed with paths is deprecated; use 'git reset -- <paths>' instead.
-- 
Duy
