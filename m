Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A4951F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 19:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfDWTG7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 15:06:59 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45343 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfDWTG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 15:06:59 -0400
Received: by mail-vs1-f65.google.com with SMTP id o10so8919656vsp.12
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 12:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YkCLPM3DYKLp/FbN9R7FWlcNTxDtbtHp/uiCIAsU+qE=;
        b=pIz319WgO22XvcO/HK0Fw8WCJtV2VYaC+r2bKJDiBGw7pIh4T4uTHyRN9aqvfcgUYw
         AFoWBMAoYGYcCPhsF2rd1ZZmhuvN5rJTyQw6WHKo2F7V9SlRJ/Sj8XURYvJQ3sDrM7E2
         IjvjJa49GMmBk7NL8wF5lZKAvpuYt1yZw5nzScUMisSZgy8rJ/hEnGoI/jOr8xWHQ3bx
         s8NIyGf9GKqxf6YCVrOY4EULbF/BaWSqy45WjlnQVmRE0bd1G0qHfAMYISy/Abk4LvAu
         32hVQSD6rB5nJvAFB0v4qpAN040N0v4PBj6156bx0YvvKVE6WGvvo4XzAdFPv7m0eVeg
         SX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YkCLPM3DYKLp/FbN9R7FWlcNTxDtbtHp/uiCIAsU+qE=;
        b=JRJeOLrNfOd1y+Et9FcZjny6C9O8p483Dw47gqWVKBttZrs3OX95BznNVvVdL0HHdT
         gUpUuma4WIMfmdBo9GUnqjeMZMrJU/YTxq7Q+CLIDs7TKYk9Q92JwP667bx7gED1AAnd
         cfj0ofPovGdDK83qgsUV2rtu9/DKCqmTw5oS9h3KzA0v1CRhfwmjuAPSVC5/3Yx2MAmZ
         0Iudhd/yHJ3J9dH1mAM5DvAw8qohJF+sDBIk5y1fUjPdQQRInsMWi92l01hj1IDHHtJ/
         /AwCWwhAiMiDYRru7mADJRP5e5odLXPJpc+O0l9ED5xyt21fgoxpt3mx6OA4wTLiRQWT
         pE/Q==
X-Gm-Message-State: APjAAAWN8rkdssecikaNN7+6+/6BDiEAHhA7QGxlW8nyunD1rKcyD/lP
        voVJOnGKo6gBqLgvZso5i5bjkojr2ucv9TW7iXY=
X-Google-Smtp-Source: APXvYqw8yfoJDgPgE6GmGaRXamiXmCapTU/39MEfLHES0CU0WMAJShrao5dyuziJwBzRc2/HzGCe53mImisSvftKAWM=
X-Received: by 2002:a67:f615:: with SMTP id k21mr14225008vso.136.1556046417920;
 Tue, 23 Apr 2019 12:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190423173056.28523-1-newren@gmail.com> <20190423182924.r6mkwrl2o7pcwjoa@tb-raspi4>
In-Reply-To: <20190423182924.r6mkwrl2o7pcwjoa@tb-raspi4>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 23 Apr 2019 12:06:45 -0700
Message-ID: <CABPp-BGbDN2DVwJKh3gdQ1wDZmGuevAYRhhfe_MCyunABDsEqg@mail.gmail.com>
Subject: Re: [PATCH] Honor core.precomposeUnicode in more places
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 23, 2019 at 11:29 AM Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>
> On Tue, Apr 23, 2019 at 10:30:56AM -0700, Elijah Newren wrote:
> > On Mac's HFS ("Hilarious FileSystem"?  "Halfwitted FileSystem"?) --
>
> How about "Hierarchical File System" ?

Sorry, I should have removed my draft commentary before submitting.
Yes, you are of course right.

...
> > Add code in a few places (pack-refs, show-ref, upload-pack) to check an=
d
> > honor the setting of core.precomposeUnicode to avoid these bugs.
>
> That's all correct, one minor question below.
...

> > @@ -16,6 +17,7 @@ int cmd_pack_refs(int argc, const char **argv, const =
char *prefix)
> >               OPT_BIT(0, "prune", &flags, N_("prune loose refs (default=
)"), PACK_REFS_PRUNE),
> >               OPT_END(),
> >       };
> > +     git_config(git_default_config, NULL);
> >       if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
> >               usage_with_options(pack_refs_usage, opts);
>
> I wonder if we could move the call to git_config() into parse_options(),
> (or another common place) but I haven't checked the details yet.
> Same below for show_ref().

Interesting idea.  However, moving it into parse_options() presumes
that either `git_default_config` will always be passed to
git_config(), or else the arguments needed by git_config() will be
explicitly passed to parse_options.  A quick grep through the source
code suggests that only about 1/3 of callsites pass git_default_config
to git_config(), and passing a config-related callback function to
parse_options seems a little weird to me.  Plus, the fact that 2/3 of
the callsites use a special config callback function suggests that
we'd still not catch all cases with such a change, much like I had to
update the upload_pack_config special callback below.

> And thankks for picking this up.
>
> >       return refs_pack_refs(get_main_ref_store(the_repository), flags);
> > diff --git a/builtin/show-ref.c b/builtin/show-ref.c
> > index 6a706c02a6..6456da70cc 100644
> > --- a/builtin/show-ref.c
> > +++ b/builtin/show-ref.c
> > @@ -1,5 +1,6 @@
> >  #include "builtin.h"
> >  #include "cache.h"
> > +#include "config.h"
> >  #include "refs.h"
> >  #include "object-store.h"
> >  #include "object.h"
> > @@ -182,6 +183,8 @@ static const struct option show_ref_options[] =3D {
> >
> >  int cmd_show_ref(int argc, const char **argv, const char *prefix)
> >  {
> > +     git_config(git_default_config, NULL);
> > +
> >       argc =3D parse_options(argc, argv, prefix, show_ref_options,
> >                            show_ref_usage, 0);
> >
> > diff --git a/upload-pack.c b/upload-pack.c
> > index d098ef5982..159f751ea4 100644
> > --- a/upload-pack.c
> > +++ b/upload-pack.c
> > @@ -1064,6 +1064,8 @@ static int upload_pack_config(const char *var, co=
nst char *value, void *unused)
> >               allow_ref_in_want =3D git_config_bool(var, value);
> >       } else if (!strcmp("uploadpack.allowsidebandall", var)) {
> >               allow_sideband_all =3D git_config_bool(var, value);
> > +     } else if (!strcmp("core.precomposeunicode", var)) {
> > +             precomposed_unicode =3D git_config_bool(var, value);
> >       }
> >
> >       if (current_config_scope() !=3D CONFIG_SCOPE_REPO) {
> > --
> > 2.21.0.420.g4906d192b3
> >
