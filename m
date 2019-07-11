Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 067FF1F461
	for <e@80x24.org>; Thu, 11 Jul 2019 18:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbfGKS0G (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 14:26:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36002 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbfGKS0G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 14:26:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so3149220pfl.3
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 11:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zi+haN3S+P7a3L1TCW1VXdXlFeb6d/3GfhPiEaoABQU=;
        b=0ZWPcqnqrqXjYKH0+eRBMMB9ZPmKboRxF3CsrKTO7I4QXzrIaqUQa5XoHKS2VBgaPF
         O/UE+kQmr42m+o/TMZeIrndJKdxdzeo0JUXsbUQ/DPYnSKYiSysln+CwAp+ZPYYpk21X
         my/FeEt6+IWqUFb6P+PnjIqOFmZoOY2gUKjsJxx9zCb94cV8usR9wzMaaYiJdLFmmI2c
         hNwSSoebw9kP7pB4IctgldEsRSX9k5M9d2ezUGoqaewYWqbHZf8m9+QHwBNgaPwN9djN
         wBO/LGkS2DkEozfLXE9cc0Qjhj5gz0A5pbcOA6ecFHOd9DXxh6bPGwMtardD8MEeVTX8
         iJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zi+haN3S+P7a3L1TCW1VXdXlFeb6d/3GfhPiEaoABQU=;
        b=OQWW3eJfkt20IHQn0hK5GrHjQWLfQ2cx1mpNCRhwPLO06j7Ukt/ljYjSZNkYX4nVIZ
         +ecvihdyBIAE16nivZ7uE/A+YEeZtmfZUV/A7Kfrr4HD0r+liCtIDGCaZiRGgn+6B3en
         m1pFzm5saj5BVK6GSzx+dQf6DO9M+AO1oxFr/EO5K4sJGbIH7Rjrh+O2ri1vVP9KeLqg
         3sFXyz+JA+H2D4loC5XdmLp+R67sSIS54EqCOwTFRJjY8qVaHUc1NxGvD4toUd5AxCcy
         ayhI4MsPyJhdpj0RZewYexK1oqh6CwXSViEfaSSrYHUSd6SZbBzKJOcu13khLUWqVN1d
         QhXw==
X-Gm-Message-State: APjAAAVY6M4fZ3rKz2iGzrPB2aXr6V9wwPqBlNaHWrj4xTy75BPD4W5Z
        lJaZ5+cGFEGfNA9b+Q7Ak/g2zSWrQC7q9vZ7K+I=
X-Google-Smtp-Source: APXvYqwOgbnhkahY4cudYmeHDcpMNUsS13V3Q33//KalFadl9byYmBuCGFNkmaP7xxJnIw8iqE4zprWBhOcIpKztIKc=
X-Received: by 2002:a17:90a:1b4c:: with SMTP id q70mr6214461pjq.69.1562869565749;
 Thu, 11 Jul 2019 11:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190711172626.16480-1-ariadne@dereferenced.org>
 <20190711172626.16480-3-ariadne@dereferenced.org> <91cdd139-1dac-e7b5-c51a-ea057c0c31ca@drbeat.li>
In-Reply-To: <91cdd139-1dac-e7b5-c51a-ea057c0c31ca@drbeat.li>
From:   Ariadne Conill <ariadne@dereferenced.org>
Date:   Thu, 11 Jul 2019 13:25:54 -0500
Message-ID: <CAAOiGNyYyFpdkHXa8fY3OcLsZsiZXb72YUQ294f61EosxdK8Kg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] log: add --no-use-mailmap option to complement
 --use-mailmap option
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Thu, Jul 11, 2019 at 1:24 PM Beat Bolli <dev+git@drbeat.li> wrote:
>
> On 11.07.19 19:26, Ariadne Conill wrote:
> > When mailmap is enabled by default or by configuration, it may be
> > useful to override the default behaviour.  Previously, it was
> > possible to enable the mailmap feature when it was disabled by
> > default or in the configuration, but it was not possible to disable
> > the mailmap feature when it was enabled by default or by the
> > configuration.
> >
> > The --no-use-mailmap option equalizes this by allowing the user to
> > explicitly enable or disable the mailmap feature according to their
> > requirements.
> >
> > Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
> > ---
> >  Documentation/git-log.txt | 5 +++++
> >  builtin/log.c             | 1 +
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> > index b02e922dc3..50bc8f7da2 100644
> > --- a/Documentation/git-log.txt
> > +++ b/Documentation/git-log.txt
> > @@ -54,6 +54,11 @@ OPTIONS
> >       addresses to canonical real names and email addresses. See
> >       linkgit:git-shortlog[1].
> >
> > +--no-use-mailmap::
> > +     Do not use the mailmap file to map author and commiter names
> > +     and email addresses to canonical real names and email addresses.
> > +     See linkgit:git-shortlog[1].
> > +
> >  --full-diff::
> >       Without this flag, `git log -p <path>...` shows commits that
> >       touch the specified paths, and diffs about the same specified
> > diff --git a/builtin/log.c b/builtin/log.c
> > index 3d2ce8fa3d..a9195bcb34 100644
> > --- a/builtin/log.c
> > +++ b/builtin/log.c
> > @@ -167,6 +167,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
> >               OPT__QUIET(&quiet, N_("suppress diff output")),
> >               OPT_BOOL(0, "source", &source, N_("show source")),
> >               OPT_BOOL(0, "use-mailmap", &mailmap, N_("Use mail map file")),
> > +             OPT_NEGBIT(0, "no-use-mailmap", &mailmap, N_("Do not use mail map file"), 1),
>
> This works already. OPT_BOOL automatically handles the negation. You
> just have to add "[no-]" to the documentation of --use-mailmap.

Aha.  I was expecting it to behave like typical getopt_long() parsing,
where you have to handle this yourself.  No problem.  I'll clean that
up!  Thanks for the tip.

Ariadne
