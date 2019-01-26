Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECC191F453
	for <e@80x24.org>; Sat, 26 Jan 2019 14:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfAZOIe (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 09:08:34 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36149 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfAZOId (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 09:08:33 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so10668416ljk.3
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 06:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Cr+jmG1QqRw/Vo+swGaR0GYfMfMJPfybH7E01taDHJo=;
        b=MC451/79dzT802FdlsgDo0P9olqeZ3TUKxg8JsYCD23W4eBJzkXRwQ9z2sFH0+cP9A
         /3CFIVsn7qkHpPi9MIaB6PXgDm/J64eCXBochoEh8AQkrq0NzXPlhiP0KoNsG8N9soXk
         d7v4DEYktu1yl87K6yEdB5DdvUSWM3jiZQS75YPPoaGTGftZyQQRCh8ppTg7JeaV9FbW
         PZBMb9MDp6ZUquoJ51EAngPpDzz+sM3lhmJ9NB1/dLSYhjHcb3dDkXKCngqdz8ZMLTnq
         I8yIfnstaLD9tpf5AlU8nOoeE7QB92ROfJxSJ1qZlAEbpuIkEWJYWg8K/JleJckRUtUw
         rKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Cr+jmG1QqRw/Vo+swGaR0GYfMfMJPfybH7E01taDHJo=;
        b=DhEkUrPKUeOHmjgdwYM17FDnpnZDCmm13Z1sRmQCvlHfbZkSWpimLHqQDCV6aHAsIW
         lKVlL842BFR+OqxtcZlybsrVn8Aj+8bU3txP9enaPLwt1iE4Vu+Kr6OPrx+XgRlpdhyX
         s/A74AlY9DpCLx5C8LUwmqGnQyotPL6rqiquP/phjkAMV+mJiNtfMaOOvxYjWKq8AAd4
         lEDRmgQrc2+nUmAtENb8ywVmGRcSVppLwOzPJDy+2wBAX1d5fYrTLYMXBdXN4moxIvB3
         3+VVYwi+rK0oVLaOag+hUO7v3xfej9wr51N6BvCSIpFuWc/6233AK5JwjSewQyQlVp8e
         eX0w==
X-Gm-Message-State: AJcUukcrk9Wl/5gq+9GZCNbsXdiU2zIyG19jN8s1WirdDQzyjr6uyMny
        FZYkqcY1C7JPtDIYDbKIHbHN3LNdHwPZi118y/0=
X-Google-Smtp-Source: ALg8bN7lbqW/yWalXuMVPg0e/3eVHFF7krylYopnjwceXAF1DJizpNkr7bp1hftyfcamkmEmFUERJfDqh51hWTMqGKQ=
X-Received: by 2002:a2e:1b47:: with SMTP id b68-v6mr12019809ljb.104.1548511711259;
 Sat, 26 Jan 2019 06:08:31 -0800 (PST)
MIME-Version: 1.0
References: <CA+xP2Sax+thitfKv4hTtKTYPhfVXJxD_qoJxgkCyZFTzskP-Tw@mail.gmail.com>
 <CACsJy8Df6XM55ExRfCjpUQsv2Vm0cOwrSAyNf6net__uztMOGQ@mail.gmail.com>
In-Reply-To: <CACsJy8Df6XM55ExRfCjpUQsv2Vm0cOwrSAyNf6net__uztMOGQ@mail.gmail.com>
From:   Sebastian Staudt <koraktor@gmail.com>
Date:   Sat, 26 Jan 2019 15:07:54 +0100
Message-ID: <CA+xP2SaJYD+OKC18y0zz2V6A9J8rAB0-cxMnrDmWt==8v2_uBA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Setup working tree in describe
To:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Sa., 26. Jan. 2019 um 12:01 Uhr schrieb Duy Nguyen <pclouds@gmail.com>:
>
> On Sat, Jan 26, 2019 at 5:44 PM Sebastian Staudt <koraktor@gmail.com> wro=
te:
> >
> > This ensures the given working tree is used for --dirty and --broken.
> >
> > Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
> > ---
> >  builtin/describe.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/builtin/describe.c b/builtin/describe.c
> > index cc118448ee..ba1a0b199b 100644
> > --- a/builtin/describe.c
> > +++ b/builtin/describe.c
> > @@ -601,6 +601,8 @@ int cmd_describe(int argc, const char **argv,
> > const char *prefix)
> >      if (!hashmap_get_size(&names) && !always)
> >          die(_("No names found, cannot describe anything."));
> >
> > +    setup_work_tree();
>
> This forces worktree's presence in all cases and will die() if
> worktree is not available. You need to check if broken or dirty is set
> and only call this function in that case.
>
> Though in my opinion it's better to call before we need it in the "if
> (broke)" and "else if (dirty)" code blocks. That way you don't even
> need to check if it's "dirty" or "broken". Does "broken" really need
> this though? If it runs "git diff-index" separately, that command
> should handle this setup_work_tree() already, or we may need to fix it
> there, not here.
>

Thanks for your feedback.
Are you sure that it will fail without a working tree?
Is it even possible to have *no* working tree?

I already tested this with some real life examples, e.g.

    git --git-dir /some/path/.git describe

From inside and outside of other repositories.
I didn=E2=80=98t hit any errors so far.

> > +
> >      if (argc =3D=3D 0) {
> >          if (broken) {
> >              struct child_process cp =3D CHILD_PROCESS_INIT;
> > --
> > 2.20.1
>
>
>
> --
> Duy

Best regards,
    Sebastian

Am Sa., 26. Jan. 2019 um 12:01 Uhr schrieb Duy Nguyen <pclouds@gmail.com>:
>
> On Sat, Jan 26, 2019 at 5:44 PM Sebastian Staudt <koraktor@gmail.com> wro=
te:
> >
> > This ensures the given working tree is used for --dirty and --broken.
> >
> > Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
> > ---
> >  builtin/describe.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/builtin/describe.c b/builtin/describe.c
> > index cc118448ee..ba1a0b199b 100644
> > --- a/builtin/describe.c
> > +++ b/builtin/describe.c
> > @@ -601,6 +601,8 @@ int cmd_describe(int argc, const char **argv,
> > const char *prefix)
> >      if (!hashmap_get_size(&names) && !always)
> >          die(_("No names found, cannot describe anything."));
> >
> > +    setup_work_tree();
>
> This forces worktree's presence in all cases and will die() if
> worktree is not available. You need to check if broken or dirty is set
> and only call this function in that case.
>
> Though in my opinion it's better to call before we need it in the "if
> (broke)" and "else if (dirty)" code blocks. That way you don't even
> need to check if it's "dirty" or "broken". Does "broken" really need
> this though? If it runs "git diff-index" separately, that command
> should handle this setup_work_tree() already, or we may need to fix it
> there, not here.
>
> > +
> >      if (argc =3D=3D 0) {
> >          if (broken) {
> >              struct child_process cp =3D CHILD_PROCESS_INIT;
> > --
> > 2.20.1
>
>
>
> --
> Duy
