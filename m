Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65D4E1F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 15:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731561AbeKVCUa (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 21:20:30 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]:37938 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbeKVCU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 21:20:29 -0500
Received: by mail-lf1-f41.google.com with SMTP id p86so4329084lfg.5
        for <git@vger.kernel.org>; Wed, 21 Nov 2018 07:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7/j9CZA4kPXdlCusj2E+O2hMvFOhWc+NOOxeW0J2H/Q=;
        b=FsnagJxxUMfWWXamsWKO2V3BKkpcOJRLvhD4L3bADqkb5FPXYkHMYzyqKLxJM+u2Oq
         v4jSrxm2cMehIZJb2RtK9xvF3FxKlUv/72jb+x+F9Pei2R/1QjI3Ep2Kcx5uFNqz16uD
         XMgigKIxHWyOgtGyajVqRST53u69DNxl5bsL7UMm5CiSVeBNxLG4aq3KrMTiiWfYOWEt
         BzPBkIHV8wxit1y0PGif37u3VNQbDBjzxisMY1Mapo1qI4j9oWkc1+AoCP0jS4XUuJI9
         Y6pDMGRn968qeMr51/wwW/oVyNEG1kdIsGqtwdSzZoTF+Kj4AKvvlishftRvbGVygp3+
         0H6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/j9CZA4kPXdlCusj2E+O2hMvFOhWc+NOOxeW0J2H/Q=;
        b=bBRawVNr1wo/JKhEXKpFPF6ZkVe/YNJEuy3ulLDo9QFxSomWB2BQ26RV9QYvv6yvcb
         eJ/CpDxbuZu85woIrEU3zzEI3pLBViHoGGwkCsqEQANP8rVh6UYvCXdJtcvqTkX9tHbE
         8s6Ea4y71KqwK9KIgC/oe/O0QUfgkpezHrIqLO7gdFCvOz5s0k4kDe/5d9VgXpofcNCO
         BgE5TlBKBYumDy0Ho/3PlUyvqAJsnrxcf/cFR4JYb3ETo/EU/vPisTsLH7meuHosdbuq
         GOEjgmDc1qkGeNeGCS3g4C63DnkbGdq7l8S1sd5k56b57/emxFXBiX0/ZypdV3IC1sQb
         Px8A==
X-Gm-Message-State: AGRZ1gK9w+8DbNct6NKKUOLxEr9p6/M/CpjLJHDWk8d+TWUJy3g0wCAd
        MsIcDW7x4Pjl5ni5XZrQ7yuQ90Hxa3X/yN7cvB0=
X-Google-Smtp-Source: AJdET5dfrD8q0+J71MGSiacncAUzElbodmD3LVVwG4rxijmT9pQ9Fwq8LE/QakE7MF443KPKPs8T97qEvWrtmHIJgBQ=
X-Received: by 2002:a19:4402:: with SMTP id r2mr3960067lfa.111.1542815130229;
 Wed, 21 Nov 2018 07:45:30 -0800 (PST)
MIME-Version: 1.0
References: <CA+onWPcgHMCffjfNO3wxMwVD2bOJzWmwtYtrj9QakDUEA=OXqQ@mail.gmail.com>
 <CA+onWPe9hmr36xvc9F58KwW5fyby-wn6F2hiJy9ce__sA1mSjw@mail.gmail.com>
 <20181121144453.gnqcn5ugvd2yo5jl@tigra> <CA+onWPf71VU9r9S6MxqEAxxCF+9gqMLoPdmOb83NK+MJDUAM8w@mail.gmail.com>
In-Reply-To: <CA+onWPf71VU9r9S6MxqEAxxCF+9gqMLoPdmOb83NK+MJDUAM8w@mail.gmail.com>
From:   Jamie Jackson <jamiejaxon@gmail.com>
Date:   Wed, 21 Nov 2018 10:45:18 -0500
Message-ID: <CA+onWPeiOz5_nvgDpcxVpBaMQUHg14yKTbfFnRuQV1vWnpCVFA@mail.gmail.com>
Subject: Re: Fwd: "show-ignore" problem after svn-git clone
To:     kostix@bswap.ru
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By the way, my goal is to pull in trunk (only) at first, and possibly
pull in certain branches (later) on an as-needed basis. I'll need to
sync the Git repo with SVN for a while, until we permanently switch to
Git (and put SVN in read-only).
On Wed, Nov 21, 2018 at 10:38 AM Jamie Jackson <jamiejaxon@gmail.com> wrote:
>
> ICF2008571:eclipse-workspace jjackson$ git svn clone \
> >   -r 95115:HEAD https://mydomain.com/svn/HUD/onecpd \
> >   -T trunk \
> >   --no-metadata \
> >   -A ~/eclipse-workspace/scraps/git_migration/users.txt \
> >   hudx-git-migration
> ICF2008571:eclipse-workspace jjackson$ cd hudx-git-migration/
>
> ICF2008571:hudx-git-migration jjackson$ git svn show-ignore
> fatal: bad revision 'HEAD'
> rev-list --first-parent --pretty=medium HEAD --: command returned error: 128
>
> ICF2008571:hudx-git-migration jjackson$ git svn show-ignore --id=origin/trunk
> fatal: bad revision 'HEAD'
> rev-list --first-parent --pretty=medium HEAD --: command returned error: 128
>
> ICF2008571:hudx-git-migration jjackson$ cat .git/config
> [core]
> repositoryformatversion = 0
> filemode = true
> bare = false
> logallrefupdates = true
> ignorecase = true
> precomposeunicode = true
> [svn-remote "svn"]
> noMetadata = 1
> url = https://mydomain.com/svn/HUD
> fetch = onecpd/trunk:refs/remotes/origin/trunk
> [svn]
> authorsfile = /Users/jjackson/eclipse-workspace/scraps/git_migration/users.txt
>
> On Wed, Nov 21, 2018 at 9:44 AM Konstantin Khomoutov <kostix@bswap.ru> wrote:
> >
> > On Wed, Nov 21, 2018 at 08:37:03AM -0500, Jamie Jackson wrote:
> >
> > > I'm brand new to svn-git and I'm having a problem right out of the
> > > gate. I suspect I need a different ID, but I have no clue how to get
> > > it.
> > >
> > > Here's the failed attempt:
> > > https://gist.github.com/jamiejackson/57e90302802f4990b36dfe28c3c71d13
> >
> > Please post the content supposedly available at that link in your mail
> > message, inline.  Otherwise it's impossibly to sensibly comment on it.
> >
