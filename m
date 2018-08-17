Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF2211F954
	for <e@80x24.org>; Fri, 17 Aug 2018 14:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeHQRhd (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 13:37:33 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:38771 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbeHQRhd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 13:37:33 -0400
Received: by mail-io0-f196.google.com with SMTP id y3-v6so2678675ioc.5
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 07:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z55aR9xD6aWGMy6XtFXSJQdVBLQEPoj38EQ3Twq3e8s=;
        b=YjX0sGxOmVGYHqtwC4AQMA2VDSaNFHJNiAqOH/IdSxYan/X+OzrMltCP1IxjDX3APO
         kSpHLkyHvJlJPPrFgu+66JbRHxto+3BmKvDlZ0ibNiCK6tWXnaaGoTvSYWfLgixENRJB
         dpUgMI5dVDSftxBVNL0t95XaZMEiYoZfOGoZHStXrPRfrSoVRshn5vOovdbwJV7NnCGB
         tLgpprp9fpcRr2Gnq6zZKbNMmiyTokLwqe78/4PsqnOjAVrsW4rLDYVQ9QA0bvmWUqpm
         FzKesnsqnKJgqc2IwUtcRaGsTahyw4bR2Ej0w1oJ8iKmtqljPuyhodd4jFnBNabnxVpA
         f5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z55aR9xD6aWGMy6XtFXSJQdVBLQEPoj38EQ3Twq3e8s=;
        b=o3/86yreq2Xvxg0ggLiVBqxi3u4M4OYf2gJdZ+oNdU72jxQxx1rrCAj/kEe4/jFSO1
         iVnC/h8CtczNoYknfCe7hXuDCSRY9udN53jB1CsFzMfhGiBBdTCi3J95hsy8ww33aVIY
         9P4QjKv2I5SY/huB6rOW9Ft+VBBvuYVrofSWa4S/ICudNUV80C7fkp+nMIkXFY2f8p+o
         EyNzq1K6DbfPPZfO3zG7odhjg6gW+lAW2EYnD8oFN/3VcU2dYekMFTE5fK3cE9+G++Mu
         998YXjEJjEkyf0indU18yS2tCcjYurs5oTmU9jUSAye55WrHzVpHrTsTBlYwiTaerp05
         9H1g==
X-Gm-Message-State: AOUpUlHLAI9XB1bcsefaIie6pt9wWO8XT1VCkKm5TKLKZOWfxT/YDdgS
        Ioaffe74kgoVvsou+sxRXIDpW1F3y7XVfNG+gU2dsA==
X-Google-Smtp-Source: AA+uWPx1Nyi1IDnxbasHZjg7lUTU8iWfBBCelO7AeI6igJ7I8TX6pAi83MwgYQNvOHmUO/6f7ZKS4g5BG+3dO0T/mwI=
X-Received: by 2002:a5e:d819:: with SMTP id l25-v6mr5227868iok.236.1534516437576;
 Fri, 17 Aug 2018 07:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180816183117.13716-1-pclouds@gmail.com> <20180817064734.GB131749@aiede.svl.corp.google.com>
In-Reply-To: <20180817064734.GB131749@aiede.svl.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 17 Aug 2018 16:33:30 +0200
Message-ID: <CACsJy8Di4GQLqkBmcnrfmU9aS=wizxU36Ly0BRgDEDmFG=+2Fg@mail.gmail.com>
Subject: Re: [PATCH/RFC] commit: add short option for --amend
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 17, 2018 at 8:47 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -1489,7 +1489,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
> >                           STATUS_FORMAT_LONG),
> >               OPT_BOOL('z', "null", &s.null_termination,
> >                        N_("terminate entries with NUL")),
> > -             OPT_BOOL(0, "amend", &amend, N_("amend previous commit"))=
,
> > +             OPT_BOOL('j', "amend", &amend, N_("amend previous commit"=
)),
> [...]
> > Thoughts?
>
> I'm not a fan.  I would have trouble remembering what the short option
> name means, and it matches the common --jobs option for parallelism
> that many commands use.  "git commit --am" works today already and
> doesn't run into those problems.

The alternative is -A or -M which may be easier associated with
--amend. That "--am" also would break the moment somebody adds
--amsomething.

> I'm sympathetic to the goal of saving typing, but I'm more sympathetic
> to the goal of making user support easier, which is what makes me end
> up there.
>
> That said, I've been looking recently at Mercurial's "hg evolve"
> extension[1] and I wouldn't be against a well thought out new command
> (e.g. "git amend") that does the equivalent of "git commit --amend"
> with some related features.  So I think there are some paths forward
> that involve abbreviating.

I'm not opposed to a new command like this, but I don't think it
should stop us from adding short options.
--=20
Duy
