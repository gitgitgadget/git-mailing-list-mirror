Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D95151F42D
	for <e@80x24.org>; Mon, 28 May 2018 13:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165279AbeE1NSx (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 09:18:53 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:45518 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165276AbeE1NQw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 09:16:52 -0400
Received: by mail-vk0-f65.google.com with SMTP id n134-v6so7016692vke.12
        for <git@vger.kernel.org>; Mon, 28 May 2018 06:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GFpkuO45pQeZoXW413+sIYVgYmtV1OX+MwuF4I8MwTs=;
        b=Z/B+K9d1nvGL/Zhjiae0zcO7dwDn8NGJjUGHo9dDc5c7yWxCvSDXj49e2E9K4Q7BC0
         j858CwWzd9M5Tq2Yi1haO3+COucjZU+1r+eTaqzF2w4Ngbxd+SW/Nf+OBt8vQaO3dMAT
         d4cz1vRIAX7PFvr8NcJR7wnkW5UF5LtMXjU/xzQuAgC9v87vWk0gofw3Ld9mQ8wVXbJY
         jlPhG76ryaHJ6FYGKT4KeoBg13gnfUVvFc+lL0oiNiepmJbYO5R8LZNjQATUytnT1p6v
         o7sQemwvYtPYdzp0pF9+sO57eRm1MWC8t5mY84nFkqBkYxKgWf8iqccMcR1QWyH+AgPJ
         WAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GFpkuO45pQeZoXW413+sIYVgYmtV1OX+MwuF4I8MwTs=;
        b=dco3Rp+RYYmMq6OIjs43h4mzR45zxj/tO3dpVd8B42P3gTtck2shRfxea1ILSbS22b
         6ougotr8uD44lMsqvUzYuoryYjOCSNDfhBkjJC1SEVRWtXyXUZDw82Zq97HsnUCQJiAl
         3Nk2JSLKfoe0lzaTWcyuag2X+4ETkkjF6al6AjmoGXTDUMMDjAAOz6MEzKC86OOAYNIW
         NRpMBZ/TIpoctWQGUHt8EPpUqr4PPuzAyfjdBRR5qmpXv/ppsgsZk/BZ1GU9IFVLmCNv
         7CjW5WMBodtmWgNYCafpYKsNI5RhOB1BKPwdZ3pL07+QTsTmilznrfbWdn0k9qyChXLT
         BlJw==
X-Gm-Message-State: ALKqPwdnzWEhXhz6HUBrpLfpiuaX9gOpwnJ8ay/nzFYqXZ7fLINEW4TQ
        QKrhMVScr0nAkgmqG6Iifiw6i8bFvBFzeIMfPyY=
X-Google-Smtp-Source: ADUXVKIqQAIF83IF1f0su5aAV0fel5UtL/j+rGHrYe9GFOypfUybLU/3M49zpVgNyEEajkEaSDiAdYbb6DAfDrk/xV4=
X-Received: by 2002:a1f:5003:: with SMTP id e3-v6mr8026792vkb.47.1527513411603;
 Mon, 28 May 2018 06:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAGHpTBLGmApTGsjeP2d93CWH=OWBXmbPdRrGxaobFRcSjUiuYw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1805281455210.82@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1805281455210.82@tvgsbejvaqbjf.bet>
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Mon, 28 May 2018 16:16:39 +0300
Message-ID: <CAGHpTBK-=Q51m37GYJOD4D8wLAOcg=nXD4H8GMfPnDJh8Ld4Yw@mail.gmail.com>
Subject: Re: [PATCH] git-rebase--interactive: fix copy-paste mistake
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 28, 2018 at 3:56 PM Johannes Schindelin <
Johannes.Schindelin@gmx.de> wrote:

> Hi Orgad,

> On Sun, 27 May 2018, Orgad Shaneh wrote:

> > exec argument is a command, not a commit.
> >
> > Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> > ---
> >   git-rebase--interactive.sh | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > index cbf44f8648..85a72b933e 100644
> > --- a/git-rebase--interactive.sh
> > +++ b/git-rebase--interactive.sh
> > @@ -160,7 +160,7 @@ r, reword <commit> = use commit, but edit the commit
> > message
> >   e, edit <commit> = use commit, but stop for amending
> >   s, squash <commit> = use commit, but meld into previous commit
> >   f, fixup <commit> = like \"squash\", but discard this commit's log
message
> > -x, exec <commit> = run command (the rest of the line) using shell
> > +x, exec <command> = run command (the rest of the line) using shell

> Apart from the white-space (which I *think* might make `git apply` barf on
> this diff), this looks obviously correct to me.

I'm behind a firewall, so I just pasted the patch in gmail, hoping it will
pass correctly :)

> To make it easier for Junio, maybe you can provide a link to a branch in a
> public repository, ready to be fetched?

Pushed to https://github.com/orgads/git -> exec-description branch.

> Thank you for cleaning up my mess,

No prob :)

- Orgad
