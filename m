Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43F9F1F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 15:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbeKVC2l (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 21:28:41 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172]:45897 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731131AbeKVC2l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 21:28:41 -0500
Received: by mail-lj1-f172.google.com with SMTP id s5-v6so5256208ljd.12
        for <git@vger.kernel.org>; Wed, 21 Nov 2018 07:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=46AXHA3jnxXSdnqvvy70RYfxkKNiqbfkSAAuVablzQ0=;
        b=GOoFxricJSX3aV+V4IHEENUA/TorJjU8x8KHmwazjLaEfcrh2hEIYeXrSLJ1FOFgaM
         0rtwxMZMSe5a7TifMa/W5KS5FuYRBTBwRXFKHWGmiFKxypBqsB3wHd58ZHYsV+Onh1sD
         m0zJj8psQekIm9ZXhIRJs0sVhu2m8a5k8ntoMZynOlhiiWmrmLwk0nPYsRKkQ4/gKWXS
         FrXJj4rRKuwU0H3BzREwGvb91FRwu56fL0iS7+NLUqwGzHojhYJNn/JxNYkj7y1pkk5/
         U4Y7t7DxXcNIxUN0m1n+rvdk/PsQMUByXnRdqIVeNL9J+CWlA159s3G/yBVOI9pL2fDF
         udAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=46AXHA3jnxXSdnqvvy70RYfxkKNiqbfkSAAuVablzQ0=;
        b=JguPhfNNAQNb3+98c0XjmNAcC0iD1TRcSwTli5yrVvult2Fm+N4PFZT3JOPoYhKpnT
         1FH1M3su1VQiutEEicvAXgVLcMrIpi6aKe8/jsNEXD6LUixrfpustLwuZoyNsi/9P1p8
         3PtDkjh4VTQQc6opIgVfWFVVVaRKAWdG/1f9h0qFMuGTiTx4tE8kYGo3QtmHLlMZ30Kc
         wB4txriRFYMCKqALUab4RMRozkCo43Mm7NI2ixBHpurv18Wu3b0U8CCGywRCzFU5ZIaJ
         y1rYs1iQ9f3i16wWroIkHMXdryRVBvnLPhnJOXbx3YGiHgamxubvHPv8ErXQm9GVCjPq
         biFA==
X-Gm-Message-State: AA+aEWaVmhsnaDWRJPgK1ekS7tD9vDLPiXWPRh0vTx7p4VNUnoNhnChj
        LN5B0W4suUN4wp9ExI7HYD4aYvOAjmvjbNB/5lY=
X-Google-Smtp-Source: AFSGD/WHjjGwPKlmTiqJ6qQHWOOqskPVSNXd5jxBDfHjeXoRqRCcXDQVox6CHq1LK11dvX8vV3ngik9P7CNueBJFoQM=
X-Received: by 2002:a2e:1f01:: with SMTP id f1-v6mr4303461ljf.129.1542815620887;
 Wed, 21 Nov 2018 07:53:40 -0800 (PST)
MIME-Version: 1.0
References: <CA+onWPcgHMCffjfNO3wxMwVD2bOJzWmwtYtrj9QakDUEA=OXqQ@mail.gmail.com>
 <CA+onWPe9hmr36xvc9F58KwW5fyby-wn6F2hiJy9ce__sA1mSjw@mail.gmail.com>
 <20181121144453.gnqcn5ugvd2yo5jl@tigra> <CA+onWPf71VU9r9S6MxqEAxxCF+9gqMLoPdmOb83NK+MJDUAM8w@mail.gmail.com>
 <CA+onWPeiOz5_nvgDpcxVpBaMQUHg14yKTbfFnRuQV1vWnpCVFA@mail.gmail.com>
In-Reply-To: <CA+onWPeiOz5_nvgDpcxVpBaMQUHg14yKTbfFnRuQV1vWnpCVFA@mail.gmail.com>
From:   Jamie Jackson <jamiejaxon@gmail.com>
Date:   Wed, 21 Nov 2018 10:53:29 -0500
Message-ID: <CA+onWPey2Mv81CVs2+4MYGv7JZSE0NJ-W17=Xr+HMTnc7aMzzA@mail.gmail.com>
Subject: Re: Fwd: "show-ignore" problem after svn-git clone
To:     kostix@bswap.ru
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think I've got it now; maybe I just needed to sleep on it. It's
happier if I use the whole URL for trunk in the -T parameter.

I'll see how the rest of it plays out, but the `git svn show-ignore
--id=origin/trunk` command is working now.
On Wed, Nov 21, 2018 at 10:45 AM Jamie Jackson <jamiejaxon@gmail.com> wrote:
>
> By the way, my goal is to pull in trunk (only) at first, and possibly
> pull in certain branches (later) on an as-needed basis. I'll need to
> sync the Git repo with SVN for a while, until we permanently switch to
> Git (and put SVN in read-only).
> On Wed, Nov 21, 2018 at 10:38 AM Jamie Jackson <jamiejaxon@gmail.com> wrote:
> >
> > ICF2008571:eclipse-workspace jjackson$ git svn clone \
> > >   -r 95115:HEAD https://mydomain.com/svn/HUD/onecpd \
> > >   -T trunk \
> > >   --no-metadata \
> > >   -A ~/eclipse-workspace/scraps/git_migration/users.txt \
> > >   hudx-git-migration
> > ICF2008571:eclipse-workspace jjackson$ cd hudx-git-migration/
> >
> > ICF2008571:hudx-git-migration jjackson$ git svn show-ignore
> > fatal: bad revision 'HEAD'
> > rev-list --first-parent --pretty=medium HEAD --: command returned error: 128
> >
> > ICF2008571:hudx-git-migration jjackson$ git svn show-ignore --id=origin/trunk
> > fatal: bad revision 'HEAD'
> > rev-list --first-parent --pretty=medium HEAD --: command returned error: 128
> >
> > ICF2008571:hudx-git-migration jjackson$ cat .git/config
> > [core]
> > repositoryformatversion = 0
> > filemode = true
> > bare = false
> > logallrefupdates = true
> > ignorecase = true
> > precomposeunicode = true
> > [svn-remote "svn"]
> > noMetadata = 1
> > url = https://mydomain.com/svn/HUD
> > fetch = onecpd/trunk:refs/remotes/origin/trunk
> > [svn]
> > authorsfile = /Users/jjackson/eclipse-workspace/scraps/git_migration/users.txt
> >
> > On Wed, Nov 21, 2018 at 9:44 AM Konstantin Khomoutov <kostix@bswap.ru> wrote:
> > >
> > > On Wed, Nov 21, 2018 at 08:37:03AM -0500, Jamie Jackson wrote:
> > >
> > > > I'm brand new to svn-git and I'm having a problem right out of the
> > > > gate. I suspect I need a different ID, but I have no clue how to get
> > > > it.
> > > >
> > > > Here's the failed attempt:
> > > > https://gist.github.com/jamiejackson/57e90302802f4990b36dfe28c3c71d13
> > >
> > > Please post the content supposedly available at that link in your mail
> > > message, inline.  Otherwise it's impossibly to sensibly comment on it.
> > >
