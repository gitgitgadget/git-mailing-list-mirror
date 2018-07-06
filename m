Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 850131F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 13:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933543AbeGFNSf (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 09:18:35 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:39180 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932995AbeGFNSe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 09:18:34 -0400
Received: by mail-oi0-f52.google.com with SMTP id d189-v6so23380855oib.6
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 06:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=edae/w+8oCcot11iqBMsPoV0s1Kzt6u0f0BVEB3hnNM=;
        b=uSP4t/QNcOrY4JjbZgn/iT+LLadFeuzO7TB4/0bzFMJkly34naI/y0wLRRR+tWBa9Y
         zGQFCHPARJTEMp/Jy3TlQelDfzauNKAU+IdASSe1YhQCq00X8ekfBLcT/Ud6BKZDRRG+
         jIPDMYx0xwt5s6iAqBPvN5ytmPG2EQ7BVJjjJOUTWhNO8cqUrOehHXIIw8tWA0PlfhE0
         gRm3aSkaetnZxl5vLD+DcEoEblisFAipBNb+pF6SyYn3mveRf7kTyvyHraAhUhIbeIFd
         d2tIOVpmkCguyToWcfYUJ8BKmBsvmEQFt0hW8mQNOc2deEIFpndr74IUQWKvzHqTQ2jV
         XFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=edae/w+8oCcot11iqBMsPoV0s1Kzt6u0f0BVEB3hnNM=;
        b=d+TiWbjIP5bnUaayAaSpcNMXEy0ixo1ujhtdqgJ5dOS3BQB5hbQsNfhtj3ZmDcvSV8
         ZDvSesgDUB2HEMyUpSx1cz8zCcUyymRh31UqabjMGmnkYRa0V2C9y2TpI7MdRz4dDBYO
         Ih6uqi2Yv4O0xtuMFbYz7ZmHyQycZPdBsH+32SAho/W40CSnUa2bhzsnmJ7u/HlwWnEE
         wOPcnjhYNMrI6uGLyxY6MSnuA4UpmCYWh1R3m0YXsvrQqC3BNGXZYvFs8uzTTG9LIwt0
         qCuDfl/41UX465ZKyv4o0kKxYQh/GyWsIzWXPAvTtlgGXmhLv8LSehYMGCXByXmzGPzQ
         hqXQ==
X-Gm-Message-State: APt69E1CJByQWwMSYVRa6UkaOhXjQhmFf3Rmt7sMi7mH3sOD1dORgN/V
        GbHMONXaXzGFmTssi9v+vsEmuKfS8aEcxjSnWuV6SCgXOvA=
X-Google-Smtp-Source: AAOMgpfZtAt7Vg9SLRt53hlyHDL1bRJihIKjrm6Ot6UAX0WoJhDYNltNjiK62vwssrUbPf+hqoH2RmWDMDeQlUkMGRM=
X-Received: by 2002:aca:ab0c:: with SMTP id u12-v6mr10413323oie.143.1530883113079;
 Fri, 06 Jul 2018 06:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <97803ec8dae0a73bae301a37377b7b4a78f77e99.camel@mad-scientist.net>
 <nycvar.QRO.7.76.6.1807041312150.75@tvgsbejvaqbjf.bet> <986185d30a0f09b4e2a9832d324a265cd3da7354.camel@mad-scientist.net>
 <nycvar.QRO.7.76.6.1807061059260.75@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1807061059260.75@tvgsbejvaqbjf.bet>
From:   Daniel Jacques <dnj@google.com>
Date:   Fri, 6 Jul 2018 09:18:21 -0400
Message-ID: <CAD1RUU-4a_jV_JjozjXOR4bi+_7rFW_AjmHbbrw6NHJ77=oGkw@mail.gmail.com>
Subject: Re: Git 2.18: RUNTIME_PREFIX... is it working?
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     paul@mad-scientist.net, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apologies for the delayed response - I've been out of town - and It
looks like Paul is already on the right track.

Johannes: I believe the GIT_EXEC_PATH snipped that you listed is not
incorrect. It's defined to "gitexecdir_SQ", and RUNTIME_PREFIX expects
(and enforces, as you snipped) that this is a relative path in
Makefile.

On non-RUNTIME_PREFIX builds, it should still be the absolute path, as
this is how Git self-locates, so using "gitexecdir_SQ" there makes
sense to me.

So:
RUNTIME_PREFIX=No, gitexecdir_SQ is absolute, GIT_EXEC_PATH is
absolute, used to find Git:
https://github.com/git/git/blob/ccdcbd54c4475c2238b310f7113ab3075b5abc9c/exec-cmd.c#L281
RUNTIME_PREFIX=YesPlease, gitexecdir_SQ is relative, GIT_EXEC_PATH is
relative and used to identify the search root of the Git installation:
https://github.com/git/git/blob/ccdcbd54c4475c2238b310f7113ab3075b5abc9c/exec-cmd.c#L40

The dual-use is confusing, and it took me a few to walk back through
how it is employed in each scenario. For clarity's sake, it may be
worth defining two variables and making one explicitly relative, but I
think it is functional as-is.

Paul: I used "config.mak" to configure RUNTIME_PREFIX when I used it
to the same effect:
https://chromium.googlesource.com/infra/infra/+/ca729b99c1f82665b634ef2ff69d93c97dfcda99/recipes/recipe_modules/third_party_packages/git.py#78

I forewent autoconf because I was concerned that the option was too
obscure and the configuration too nuanced to be worth adding via flag,
as RUNTIME_PREFIX requires some degree of path alignment and is fairly
special-case. If you prefer autoconf, though, it sounds like a good
thing to add, and I'm happy that you are finding the feature useful!

Cheers,
-Dan

On Fri, Jul 6, 2018 at 5:00 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Paul,
>
> On Thu, 5 Jul 2018, Paul Smith wrote:
>
> > On Wed, 2018-07-04 at 13:22 +0200, Johannes Schindelin wrote:
> > > > Basically what happens is that I run configure with
> > > > --prefix=/my/install/path --with-gitconfig=etc/gitconfig
> > > > --with-gitattributes=etc/gitattributes.
> > > >
> > > > Then I run make with RUNTIME_PREFIX=YesPlease.
> > >
> > > Ah. In Git for Windows, we do not use configure. I *think* this
> > > points to an incompatibility of the RUNTIME_PREFIX feature with our
> > > autoconf support, and this is a grand opportunity for you to step in
> > > and help.
> > >
> > > Essentially, what you will want to do is to implement a new configure
> > > option --with-runtime-prefix that then prevents the autoconf script
> > > from munging the relative paths in the way it does.
> >
> > FYI I was able to get this to work by overriding variables on the make
> > command line, like this:
> >
> >   make ... RUNTIME_PREFIX=YesPlease \
> >       gitexecdir=libexec/git-core \
> >       template_dir=share/git-core/templates \
> >       sysconfdir=etc
> >
> > I agree a new autoconf option would be much simpler to use.  I'll think
> > about it as I happen to have some some experience in these areas ;) ...
>
> I look forward to reviewing this...
>
> > but time is limited of course :).
>
> Yep. Same here ;-)
>
> Ciao,
> Johannes
