Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049C2C433EF
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 15:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhL2PuG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 10:50:06 -0500
Received: from smtp6-g21.free.fr ([212.27.42.6]:30752 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhL2PuE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 10:50:04 -0500
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:c5e0:3de3:cfd4:f8ca])
        (Authenticated sender: jn.avila@free.fr)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id 2C690780383;
        Wed, 29 Dec 2021 16:49:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1640793003;
        bh=7IdTNNXes7S1MpHNDroG03+CXfReXxcMYu3ebEOarik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S1AOg47cIQiMQwKGZSmRtCmc25TRLxqEUdEcnjFISX2ZwQJ9RutJMKM459/CGFG4W
         xrzLt9SYITU00VazF/Wf75+VlXXVEM5QRNJiwDmv57jJXMywYs4HVvuDVS/cktS5mf
         qAlWkz3cH7N1JJp288/DezUbU5DQnQUUtquAgSSKw9EqUmXfyUes5fcCN1Pj9men0V
         nlEOE+5DyGJSpL+sSfXzRcBBWlkPSj+fcjAtfwy/lWL9Qvf1IRfjDc3VjktFdibPSw
         AbuM2mllYFk+xZjaxex71O8dwfTqGGBHGcfeMUS/4+6l/ahuVQhJrTdW2FNjEwPn/Y
         q8Nc+bDM3w3ew==
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Cc:     Jeff King <peff@peff.net>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 11/11] i18n: turn even more messages into "cannot be used together" ones
Date:   Wed, 29 Dec 2021 16:49:53 +0100
Message-ID: <3237737.qFR3CMiZ0V@cayenne>
In-Reply-To: <3fdc2585-06e6-231c-621a-b719ec5d8f46@kdbg.org>
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com> <89066f01f32eb4ef8d6ea97aadda21cb36cbb6f2.1640647438.git.gitgitgadget@gmail.com> <3fdc2585-06e6-231c-621a-b719ec5d8f46@kdbg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, 28 December 2021 08:33:15 CET Johannes Sixt wrote:
> Am 28.12.21 um 00:23 schrieb Jean-No=EBl Avila via GitGitGadget:
> > From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
> > diff --git a/builtin/am.c b/builtin/am.c
> > index 8677ea2348a..be0e32f69cf 100644
> > --- a/builtin/am.c
> > +++ b/builtin/am.c
> > @@ -2230,8 +2230,8 @@ static int parse_opt_show_current_patch(const str=
uct option *opt, const char *ar
> >  	}
> > =20
> >  	if (resume->mode =3D=3D RESUME_SHOW_PATCH && new_value !=3D resume->s=
ub_mode)
> > -		return error(_("--show-current-patch=3D%s is incompatible with "
> > -			       "--show-current-patch=3D%s"),
> > +		return error(_("options '--show-current-patch=3D%s' and '--show-curr=
ent-patch=3D%s' "
> > +					   "cannot used together"),
>=20
> Missing "be".

Thanks.

>=20
> >  			     arg, valid_modes[resume->sub_mode]);
> > =20
> >  	resume->mode =3D RESUME_SHOW_PATCH;
> > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > index 86fc03242b8..400ceaba5e8 100644
> > --- a/builtin/cat-file.c
> > +++ b/builtin/cat-file.c
> > @@ -729,7 +729,7 @@ int cmd_cat_file(int argc, const char **argv, const=
 char *prefix)
> >  	}
> > =20
> >  	if (force_path && batch.enabled) {
> > -		error("--path=3D<path> incompatible with --batch");
> > +		error("'--path=3D<path>' and '--batch' cannot be used together");
>=20
> Missing "options" perhaps.
>

Thanks.
=20
> >  		usage_with_options(cat_file_usage, options);
> >  	}
> > =20
> > diff --git a/builtin/describe.c b/builtin/describe.c
> > index fd5ba1fc604..130b87b3a34 100644
> > --- a/builtin/describe.c
> > +++ b/builtin/describe.c
> > @@ -670,9 +670,9 @@ int cmd_describe(int argc, const char **argv, const=
 char *prefix)
> >  		}
> >  		describe("HEAD", 1);
> >  	} else if (dirty) {
> > -		die(_("--dirty is incompatible with commit-ishes"));
> > +		die(_("'%s' and commit-ishes cannot be used together"), "--dirty");
> >  	} else if (broken) {
> > -		die(_("--broken is incompatible with commit-ishes"));
> > +		die(_("'%s' and  commit-ishes cannot be used together"), "--broken");
>=20
> I noticed immediately that the two texts are not the same because they
> are not aligned, but it took me a few seconds to notice the extra blank
> in the second one.

Thanks.

>=20
> >  	} else {
> >  		while (argc-- > 0)
> >  			describe(*argv++, argc =3D=3D 0);
> > diff --git a/builtin/init-db.c b/builtin/init-db.c
> > index 546f9c595e7..b85dffbdf5c 100644
> > --- a/builtin/init-db.c
> > +++ b/builtin/init-db.c
> > @@ -681,7 +681,7 @@ int cmd_init_db(int argc, const char **argv, const =
char *prefix)
> >  	}
> >  	else {
> >  		if (real_git_dir)
> > -			die(_("--separate-git-dir incompatible with bare repository"));
> > +			die(_("'--separate-git-dir' and bare repository cannot be used toge=
ther"));
>=20
> IMO, in this case, the original text is awkward, and the transformation
> is worse because it really sounds like a mechanical replacement. I
> suggest not to do this transformation.

Agreed.

> > =20
> >  test_fixup_reword_opt () {
> >  	test_expect_success "--fixup=3Dreword: incompatible with $1" "
> > -		echo 'fatal: reword option of --fixup is mutually exclusive with'\
> > -			'--patch/--interactive/--all/--include/--only' >expect &&
> > +		echo 'fatal: reword option of --fixup and'\
> > +			'--patch/--interactive/--all/--include/--only'\
> > +			'cannot be used together' >expect &&
>=20
> On first sight, it looked significant that there are no blanks between
> "and", the single-quote, and the backslash. On second thought, the
> backslash is just a line continuation, and the blank that is needed in
> the text is inserted by "echo" because it emits its three arguments, the
> single-quoted strings', in blank-separated form. This means that there
> must not be a blank after "and" and after "--only" and before the
> single-quotes. There could be a blank before the backslash.
>=20
> Good.

That's exactly that. I struggled for quite some time when trying to split t=
he=20
string and the test was failing. Very counter-intuitive, even after you und=
erstand why.

Thanks for your review and spotting the mistakes. Will reroll.

As a side note, while editing all these tests in series, i could not help b=
ut notice that there=20
are different styles of writing them.



