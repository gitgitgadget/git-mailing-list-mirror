Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5A151F453
	for <e@80x24.org>; Mon, 22 Oct 2018 14:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeJVWvx (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 18:51:53 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:36605 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbeJVWvx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 18:51:53 -0400
Received: by mail-it1-f195.google.com with SMTP id c85-v6so12744100itd.1
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 07:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cy0uCKx6T9LGdGZBWFqyy8GBiQ+C5KWbGGSSpjp0Hec=;
        b=sa/+pul/NjkZOheYMiTAv5qbmlREZN/0IKTzAnG2MA7VzCxpjlyVRNoDh+NIAuN+YW
         IVhqXdMAldHRxLGMzONCoecviYvKIyfUZnt1ILjaM70VqDRQqnDxXNlSEXMHKRddp2nU
         Wn31GTA7hIzdh4mXPYMjbrZdn8FWLqBFLbOztG4VLQ14ARD9+0VKa4dV/0d2e3rSpWOu
         ftpGZv0YIE9HPZWDb+3Od2T/qSM6FQ6Bq7FvnhC+jzi04YnKrgs1uGND7e8fsF5d9LLg
         Aaml0TnGDSj4jw2j5D8y3gItdY3lNByQa3X+wCkaIH3VUUUTUKWchOsh+luFilDZ5SAH
         Sq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cy0uCKx6T9LGdGZBWFqyy8GBiQ+C5KWbGGSSpjp0Hec=;
        b=GjyJNmO34cyik42pSXgpWRuMrGd+Uip0Mq0s2IsywZt/I0GvHdOzOH+a1YlYLSLw8u
         Uq9YoiB1E3RAaXeLvPFcj+n/vyiA3+rF84YPidWXUy+mn5h3O3TYln3YgMK4TICrISTU
         OyilAAS/A4yohBPnYXZqaLJtGRTPgfUlLA2J+glhzaPn4oXlCYl3sy3raL1s3BFWSRvc
         Is6taTft3dl02JClBF1dtEIToq+YSNPC3spfT9Y8KvZ+Urv+Bxp3x16Uupwz22jfb4jG
         aDViQFtZHHf16GM8Wfb+YlyW4awExbQAQzBn+YXJs3RRkp4MvGcELIBnLdwRo2lgMfLa
         pRpQ==
X-Gm-Message-State: ABuFfoiLPH0mQydnSJwQdtldxknjMqRCugy8YtdKueI9rpAgDI7O8SN3
        9V3ByoPIb46KDjRTLWhOSCNfqpU4IKtmcR+4IQo=
X-Google-Smtp-Source: ACcGV62xgenkedz/QDshnt+fQwgIZ1tgi3ugf4Yj/Axc1hq0+fk/gJax1+YpeohkmQWFQZnfOhV/VZtgqWjDhEmCRyo=
X-Received: by 2002:a24:cd02:: with SMTP id l2-v6mr10112092itg.70.1540218784342;
 Mon, 22 Oct 2018 07:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20181002160658.15891-1-pclouds@gmail.com> <20181021140228.24941-1-pclouds@gmail.com>
 <20181021140228.24941-3-pclouds@gmail.com> <xmqqefciwphv.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqefciwphv.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 22 Oct 2018 16:32:37 +0200
Message-ID: <CACsJy8BYJKKdnbNYBR-XNeSE9jpWqby+epMKWo9-wGRjVE8Lfg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] worktree: add per-worktree config files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 22, 2018 at 6:54 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index 552827935a..244560a35e 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -2,8 +2,9 @@ CONFIGURATION FILE
> >  ------------------
> >
> >  The Git configuration file contains a number of variables that affect
> > -the Git commands' behavior. The `.git/config` file in each repository
> > -is used to store the configuration for that repository, and
> > +the Git commands' behavior. The files `.git/config` and optionally
> > +`config.worktree` (see `extensions.worktreeConfig` below) in each
> > +repository are used to store the configuration for that repository, an=
d
> >  `$HOME/.gitconfig` is used to store a per-user configuration as
> >  fallback values for the `.git/config` file. The file `/etc/gitconfig`
> >  can be used to store a system-wide default configuration.
> > @@ -371,6 +372,13 @@ advice.*::
> >               editor input from the user.
> >  --
> >
> > +extensions.worktreeConfig::
> > +     If set, by default "git config" reads from both "config" and
> > +     "config.worktree" file from GIT_DIR in that order. In
> > +     multiple working directory mode, "config" file is shared while
> > +     "config.worktree" is per-working directory (i.e., it's in
> > +     GIT_COMMON_DIR/worktrees/<id>/config.worktree)
> > +
>
> This obviously conflicts with your 59-patch series, but more
> importantly
>
>  - I notice that this is the only description of extensions.* key in
>    the configuration files.  Don't we have any other extension
>    defined, and if so shouldn't we be describing them already (not
>    as a part of this series, obviously)?

Right. We have two extensions already but it's described in
technical/repository-format.txt. I'll move this extension there
because it's written "This document will serve as the master list for
extensions." in that document.

>  - If we are going to describe other extensions.* keys, do we want
>    extensions-config.txt file to split this (and others) out and
>    later rename it to config/extensions.txt?  Or do we want to
>    collect related things together by logically not by name and have
>    this extension described in config/worktree.txt instead, perhaps
>    separate from other extensions.* keys?

I think we would go with config/extensions.txt because if grouping
logically, I'm not sure where extensions.preciousObjects and
extensions.partialClone would go.
--=20
Duy
