Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 271CF1F461
	for <e@80x24.org>; Sat, 22 Jun 2019 04:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbfFVEgl (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jun 2019 00:36:41 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46101 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbfFVEgk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jun 2019 00:36:40 -0400
Received: by mail-ua1-f68.google.com with SMTP id o19so3700140uap.13
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 21:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tDnUZ7x7ik1envSyAV11OG1dihyKUiTM0BnlOAR/NIQ=;
        b=D+YyIhQ495DQJzDig8ak8wvO5vy3byxWFu60FhVhRpVU2z9/I9V469fTPj4Jtrby/i
         2k75msc3EGnMqsFxxUp7EqYkBEdW6LBG6F73NKR818g8E7pE7sK4pRPcxsJ/I9l7DVWy
         14CVCITCaTPLKfINTevuoDfICUT6sVA/Bgi7F8G3br2tXewf/FOLGMlSK53AnoTwX4U+
         Z7XAHDqIBisBv+0HhhAGXz59fJ5JFznpEYkMRxywoKFYZugk+MMQCUgf9QIlHX7Jc351
         WaSi8yfDS8l9j0f5PBYVcnjZI947xSx4rlUUcvNbn0IOhYTZ2OPZ8moD9UxTWPPfAkY5
         +kAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tDnUZ7x7ik1envSyAV11OG1dihyKUiTM0BnlOAR/NIQ=;
        b=GGlB+2uBCsXe1aJw+dLkRXiWg6gH5aEhsSGiUpwVirVyFzXbReqQNcA+/D18x7Fthq
         YwzFySeAhqmFAA9QqJQ1W0OQhrsuri5Q14UdwH8Gmc5eucjwxCm7Sda1r5bjHlOfrLfH
         S3hayoMEyCSJJR1gIoz3Y7GE2UjReBK3mIiP2ap2JPSGTLi129ewPfExwBE/QWRNxVOL
         nWzSYESahX9MICGw5RP+0jhmX+K5ztCNezdbzIDVHqyjlZ+vGoOoIeMJOYGEBsQLopn/
         WBPwpDIx/EwQNKr9GG8xsvzdxJgpbPSu/y+cvnNAjEotayqMjZ6EObF7q/f6+Dref22P
         vtUA==
X-Gm-Message-State: APjAAAXNce5RDyPYnfBp6R2Yvje+hX1KbPS7+FuWeJ5SfifORZRFR67Z
        JO5EdMyUG7d6sI4OouSF2g6AjLtrpXVTj6DJ8YM=
X-Google-Smtp-Source: APXvYqxAvwIXpxysEIdqw5Mm2Mkr7Lhvx9/rOnZ5IaZ8t3B1DJxOckuspWPjNHGZXlpXixn5dsNT4dQayjn5ChKU5Z0=
X-Received: by 2002:ab0:6788:: with SMTP id v8mr6443867uar.48.1561178199702;
 Fri, 21 Jun 2019 21:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
 <20190621223107.8022-14-felipe.contreras@gmail.com> <CACsJy8AATA-7Z+HsA80NQ2j4Z9JeuSYXiBZLi=7FopzfLY1R+w@mail.gmail.com>
In-Reply-To: <CACsJy8AATA-7Z+HsA80NQ2j4Z9JeuSYXiBZLi=7FopzfLY1R+w@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 21 Jun 2019 23:36:28 -0500
Message-ID: <CAMP44s0+OoqhXHX1BD7Gw-0GqgyKYPw4GzhNr9n2pOfxjWcMYg@mail.gmail.com>
Subject: Re: [PATCH 13/14] completion: add default options
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 21, 2019 at 10:02 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Sat, Jun 22, 2019 at 5:31 AM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > Versions of Git older than v2.17 don't know about
> > --git-completion-helper, so provide some defaults for them.
> >
> > Also, some commands fail if there's no Git repository available.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  contrib/completion/git-completion.bash | 97 +++++++++++++++++++++++++-
> >  t/t9902-completion.sh                  |  4 +-
> >  2 files changed, 98 insertions(+), 3 deletions(-)
> >
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > index d3ee6c7dc2..922ba5f925 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -377,6 +377,100 @@ else
> >         unset $(compgen -v __gitcomp_builtin_)
> >  fi
> >
> > +__gitcomp_builtin_add_default=" --dry-run --verbose --interactive --patch --edit --force --update --renormalize --intent-to-add --all --ignore-
> removal --refresh --ignore-errors --ignore-missing --chmod=
> --no-dry-run -- --no-verbose --no-interactive --no-patch --no-edit
> --no-force --no-update --no-renormalize --no-intent-to-add --no-all
> --no-ignore-removal --no-refresh --no-ignore-errors
> --no-ignore-missing --no-chmod"
>
> And who's going to keep these uptodate?

The same people that kept them up-to-date before git-completion-helper.

> If you do this, might as well delete --git-completion-helper

They serve two different purposes. Say you install the completion of
Git v2.22, but a while later you have Git v2.25; you will get the
updated commands thanks to git-completion-helper, and all the
__gitcomp_builtin_*_default will be ignored.

Granted; that's not the typical situation, as many people get the Git
completion through their distribution in tandem with their Git
version. But remember that these completion scripts are part of
contrib; they are not part of official Git (`make install` doesn't
install them).

When a) most people have a version of git that has
git-completion-helper, and b) most of the issues running commands
outside of a Git repo are resolved, they could be removed. But right
now they do serve a purpose.

> A more acceptable option might be regenerate git-completion.bash and
> run --git-completion-helper to generate these, or make
> git-completion.bash source a generated file. But that might need some
> more build infrastructure, and people who just one to copy the file
> might not like it.

Indeed, I wrote a script to generate these, but I manually copied
them. I could write a script that automatically generates this file if
it's agreed that this is indeed the way we want to go.

But even if these were not up-to-date--as historically has been the
case for most options--and a) you are running a version of Git that
doesn't have git-completion-helper, or b) you run a command that
requires a Git repo; it's better to get outdated options than to get
*nothing*, which is what we get now.

Cheers.

-- 
Felipe Contreras
