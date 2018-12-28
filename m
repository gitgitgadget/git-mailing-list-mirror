Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CB3D1F45B
	for <e@80x24.org>; Fri, 28 Dec 2018 16:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731549AbeL1QEH (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 11:04:07 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54316 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbeL1QEH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 11:04:07 -0500
Received: by mail-it1-f196.google.com with SMTP id i145so28835933ita.4
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 08:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O5YxmmkBGAk1eHpOyB7jJbLTA0s51YDM5oQqNroOM7A=;
        b=qn6T9Ny4FVUOMU3YawBC2SqoLGe9OF1lO8FKqsnXdB1IL22/BzO89n+34TswvVrBLk
         vX1Idj3p4Z4arQjfvnIP+r9pv+0ZY0yu82ywh9spkJ9Lv2/G9M4XLkHPFSPRcOuuOdtF
         G92k5LNYFeO/P52BEmWl9Edx7zcPNK8mkLk1CpdjgHd+ydKDjHprFi8UxCeh4wdXSPIy
         5CoDIv5Oz1YZ4tukGqBsacULyHGvlInOKrq+nAuiI1QF7L4fMZC0fJ0dFjRO5MGDjuyh
         OQ0YrHVRPMgyVKVtAuD7g6AgvHqq9oGLCzGgcmXNv/sO/nEhDfOY4vW7f8ihPdg47kft
         +EGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O5YxmmkBGAk1eHpOyB7jJbLTA0s51YDM5oQqNroOM7A=;
        b=WM7wAfyOrNGiWrda4xyXIEh5c1/nuDamvWPxp6V99GTZg7giwE3Im8kMl7qv9Uaahb
         4cDYXnVKI3GOBI3WzzR1ivGHO6N0y1QjMs25OR0x+ocV13a1wFaPBotWgayRXZl/VI08
         nWAen/xRbJOxz2cG4JWUSPKMCCyrzsAIs9+xjOeVRuwozn7wXuhuzJu7tcoa1ljbo3CB
         T0zTjyfyjN/WQ5qt7jtDVPDOKIHwsyiIYyPAooi+KqZJOstJIU6LcD/cJppSqkxWLABQ
         ps3trOe+OI7L8QLBKdOshKcxQCoUbdq/PLKkiR4W6Dy60tt1Lf9/e7bi1P4b7JqC5hZe
         T/Ig==
X-Gm-Message-State: AA+aEWaKo9Cw8/akwC+gis6gRHOfEm5Coq0JvjEEJWq9qjvcUz2pZe98
        gWnDo774qZeE3okVVqssz+eNcnRNuP2SFvn/Z4I=
X-Google-Smtp-Source: AFSGD/WKf0Ci8NKScZpzN/XDMFfj/06Hsg3mVmp+rbz2pIbuaSBQV2/D6kxpbFTlJg3V9k2pL6PsiftYQPsa091tFu4=
X-Received: by 2002:a24:e1ce:: with SMTP id n197mr17936816ith.123.1546013046502;
 Fri, 28 Dec 2018 08:04:06 -0800 (PST)
MIME-Version: 1.0
References: <ad875f1e-54e1-e19f-cd65-95ab503c6de2@zytor.com>
 <20181227235526.GF146609@google.com> <95ca8579-4e12-1e46-8824-b1d19c6d9289@zytor.com>
In-Reply-To: <95ca8579-4e12-1e46-8824-b1d19c6d9289@zytor.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 28 Dec 2018 17:03:40 +0100
Message-ID: <CACsJy8A0bP4e14m+zpr02MHCDEBdfpXHn-Vjw5cV4WtQVoKrNg@mail.gmail.com>
Subject: Re: RFE: version-controlled merge rules
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 28, 2018 at 4:46 PM H. Peter Anvin <hpa@zytor.com> wrote:
>
> On 12/27/18 3:55 PM, Jonathan Nieder wrote:
> > Hi,
> >
> > H. Peter Anvin wrote:
> >
> >> [merge "version"]
> >>         name = Version file merge driver
> >>         driver = sort -V -r %O %A %B | head -1 > %A.tmp.1 && mv -f %A.tmp.1 %A
> > [...]
> >> However, I can't even put this in .gitattributes, because doing so would break
> >> any user who *doesn't* have the previous rule defined locally. Even worse, if
> >> this rule needs to change, propagating it to all new users has to be done
> >> manually... never mind if it needs to vary by branch!
> >>
> >> The simplest way to address this would presumably be to let the
> >> repository/working directory contain a .gitconfig file that can contain rules
> >> like that.  (Allowing it to be in the repository proper is probably a
> >> requirement for merges to be handled correctly on bare repositories; I'm not
> >> sure how .gitattributes is handled for that.)
> >
> > The main issue I see is that this would make it a little *too* easy to
> > run arbitrary code on the user's machine.  Build systems often already
> > lead to that, but users are more familiar with the risks for build
> > than for version control.
> >
> > See [1] for some related discussion.
> >
> > That said, using the include.path feature (see git-config(1)), it's
> > possible to do something similar:
> >
> >       [include]
> >               path = ../.gitconfig
> >
> > Thanks and hope that helps,
> > Jonathan
> >
>
> That would be great, except that it doesn't work if the worktree isn't in
> "..".  This is one of many cases where it would be great to have environment
> variable interpolation.

It's been discussed, see [1] and others in the same thread. The
feeling I got was it seemed good idea, but we're just not sure about
the exact syntax and some corner cases, and most importantly nobody
has stepped up to implement it.

[1] https://public-inbox.org/git/20181109101918.GC7410@sigill.intra.peff.net/
-- 
Duy
