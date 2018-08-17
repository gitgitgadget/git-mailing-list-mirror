Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 151AD1F954
	for <e@80x24.org>; Fri, 17 Aug 2018 15:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbeHQSfd (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 14:35:33 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:44427 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbeHQSfc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 14:35:32 -0400
Received: by mail-io0-f195.google.com with SMTP id q19-v6so7207587ioh.11
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 08:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RRnnqBHR5HG98jmENWizZxIegviD+6z1XJCtntIZfHc=;
        b=my+nui1xLKBOaMOdUrP+iJbhqSVbr++qj9U0uo+RMwKQC1qQ3P5PGZIZJUrvD6OFF8
         57rtTdQiz1L7h5Ce+Heuvk4Wl8onhsRE+phc0HSruF2P7tfvbrHVR0CiDPEjJjmI9TjU
         7fhTenLhKKgeCB5/istm2T1uxvCB3WfNkGUxm1FV5nmOpAll4PgTvEVnMaVcDVgad4pB
         OuVmotecXx24Xzocl2WlqEIKQfYz2TWM9JzeAL8NIqHRBIWncD+0WLR0O5dMjHs0mxLw
         d+D0JdQQA0feHsXvQ14r67WVJRBcWcm/rFEId/9E0U7HeQf4hX1FiH1F5+h2qvwx/hZS
         7Wyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RRnnqBHR5HG98jmENWizZxIegviD+6z1XJCtntIZfHc=;
        b=BtwPhNGXB9TlIQa4ebk9G6T8cIn2gy3wueCK9e+Kn8NV8wtU2k0ZtG2S6Vcd/obuK6
         GMadIxDOTJDIUWwL/Fm0i4Vn6xjwx7D4N457cDj7hQgNXZDJfi523KqzA5dr4CWiZ4AX
         rBkJOGA/qIYdTXcTIgquaqXArm1FyUSQDuW2Ta7Y1swAQnyoqNJksFW1abK80NQu9vJn
         DHelSitVw+WmFTPHzLwwz4V0B/IO+JSWQvHRuV+wnFd/nuflOiV6dkhV/qYD0rGSXyth
         4wnXHCSPWPqAH+JDJf4vfy/f9e0ad1XUryh+JT6cV261G/R5M4zpwO8FBj9+8UV+QVsS
         6JZQ==
X-Gm-Message-State: AOUpUlEuN2t1VIZ2Aqhlo4V2RPQcpWC83ah23ZNhcWhTsXzE+Z2NuJEL
        aGZvJheE6khc1O8K5fV8LM4ZVCZPqj+wE/UBYSA=
X-Google-Smtp-Source: AA+uWPyFLUnAOlXd1VeIOyUuoKCXPWFpyjPRYJUwvVQFJ1hKj+YapU4HvbWrmNsBccs2AhzejWX7UgXqLoidqXOtO4U=
X-Received: by 2002:a6b:a2cf:: with SMTP id l198-v6mr27421730ioe.282.1534519904122;
 Fri, 17 Aug 2018 08:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180816183117.13716-1-pclouds@gmail.com> <20180817064734.GB131749@aiede.svl.corp.google.com>
 <CACsJy8Di4GQLqkBmcnrfmU9aS=wizxU36Ly0BRgDEDmFG=+2Fg@mail.gmail.com> <20180817152655.GA4816@sigill.intra.peff.net>
In-Reply-To: <20180817152655.GA4816@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 17 Aug 2018 17:31:17 +0200
Message-ID: <CACsJy8ArEu=AV-eHtTxDOee=SKNL94oxgkrq0eJg5fcggaboNw@mail.gmail.com>
Subject: Re: [PATCH/RFC] commit: add short option for --amend
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 17, 2018 at 5:26 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Aug 17, 2018 at 04:33:30PM +0200, Duy Nguyen wrote:
>
> > On Fri, Aug 17, 2018 at 8:47 AM Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> > >
> > > Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> > >
> > > > --- a/builtin/commit.c
> > > > +++ b/builtin/commit.c
> > > > @@ -1489,7 +1489,7 @@ int cmd_commit(int argc, const char **argv, c=
onst char *prefix)
> > > >                           STATUS_FORMAT_LONG),
> > > >               OPT_BOOL('z', "null", &s.null_termination,
> > > >                        N_("terminate entries with NUL")),
> > > > -             OPT_BOOL(0, "amend", &amend, N_("amend previous commi=
t")),
> > > > +             OPT_BOOL('j', "amend", &amend, N_("amend previous com=
mit")),
> > > [...]
> > > > Thoughts?
> > >
> > > I'm not a fan.  I would have trouble remembering what the short optio=
n
> > > name means, and it matches the common --jobs option for parallelism
> > > that many commands use.  "git commit --am" works today already and
> > > doesn't run into those problems.
> >
> > The alternative is -A or -M which may be easier associated with
> > --amend. That "--am" also would break the moment somebody adds
> > --amsomething.
>
> I think "-A" has been considered as possibility for matching "commit -a"
> / "add -A" in the past, but I had trouble finding past discussion
> (searching for "A" in the mailing list is not very productive). It was
> mentioned in 3ba1f11426 (git-add --all: add all files, 2008-07-19), but
> that was quite a while ago.
>
> Not necessarily a blocker, but something to consider.
>
> Like Jonathan, I do find "-j" a little non-intuitive, but I agree that
> most of the intuitive ones are taken. :)

Oh well. Maybe next time we'll be more careful with adding short
options. Consider this patch dropped.
--=20
Duy
