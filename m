Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21846C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 18:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238719AbhLHSRM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 13:17:12 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:2944 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238708AbhLHSRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 13:17:09 -0500
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:9225:6fd8:b89b:1501])
        (Authenticated sender: jn.avila@free.fr)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 33D6D19F4C8;
        Wed,  8 Dec 2021 19:13:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1638987216;
        bh=exQZY07DPl2spjiro+YrDZ3G71aprO6qH89nCqzNxR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rGM7LId6lHcIi7F18LzRhwFG5/Zmak9VR9Qj6UGTuCK9TCdDceQBFyEagWZtZroIY
         tIp0dbRrrGTuRgClA0FgSJyPPtTxOU+s2gDxq8ZtSDKt6/0tcsKtWVoQqax4qHlpmK
         c9owH0e0kY87fTta9tR0Ap/nMAGSsL36InLiHgdQnqUxW9MjZZGas4w5IwgcwyVKDN
         ECVHS4HW6CseA/yLPoUGFqz5Aidy4Yjde7hO7LIyYxRz2cDzloA/5DlcS+vtPpG9W1
         4/GdWf8+1y5FcyQ+cypgbwBSnqD57ZQm43N7BIdcIK9ernC5dhYyJrK1W6dDEA6p4V
         +xQ0AKv3UH/DA==
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/10] i18n: refactor "foo and bar are mutually exclusive"
Date:   Wed, 08 Dec 2021 19:13:30 +0100
Message-ID: <2447705.sFPtriHfYS@cayenne>
In-Reply-To: <211207.86bl1snv8a.gmgdl@evledraar.gmail.com>
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com> <476eb77aff6fbea926eaec55c9b4febb74282ab4.1638514910.git.gitgitgadget@gmail.com> <211207.86bl1snv8a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, 7 December 2021 19:07:41 CET =C6var Arnfj=F6r=F0 Bjarmason wrot=
e:
>=20
> On Fri, Dec 03 2021, Jean-No=EBl Avila via GitGitGadget wrote:
>=20
> > From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
> >
> > Use static strings for constant parts of the sentences.
> >
> > Signed-off-by: Jean-No=EBl Avila <jn.avila@free.fr>
> > ---
> >  builtin/checkout.c          | 2 +-
> >  builtin/diff-tree.c         | 2 +-
> >  builtin/fetch.c             | 2 +-
> >  builtin/init-db.c           | 2 +-
> >  builtin/log.c               | 4 ++--
> >  builtin/submodule--helper.c | 4 ++--
> >  builtin/worktree.c          | 2 +-
> >  range-diff.c                | 2 +-
> >  8 files changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/builtin/checkout.c b/builtin/checkout.c
> > index cbf73b8c9f6..4bd8a57f190 100644
> > --- a/builtin/checkout.c
> > +++ b/builtin/checkout.c
> > @@ -1621,7 +1621,7 @@ static int checkout_main(int argc, const char **a=
rgv, const char *prefix,
> >  				cb_option, toupper(cb_option));
> > =20
> >  	if (opts->overlay_mode =3D=3D 1 && opts->patch_mode)
> > -		die(_("-p and --overlay are mutually exclusive"));
> > +		die(_("%s and %s are mutually exclusive"), "-p", "--overlay");
>=20
> It's good to do all of these, but I think we should really quote the
> '%s' while at it. It also helps translators, who without that won't know
> (without jumping to the source) if %s and %s are "walking" and "chewing
> gum" or something like a CLI option that's quoted :)
>=20

With other comments included,  the proposition for this factorization would=
 be:

"the options '%s' and '%s' cannot be used together"



