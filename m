Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 775311F453
	for <e@80x24.org>; Wed, 24 Apr 2019 22:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfDXWqe (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 18:46:34 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35676 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726673AbfDXWqe (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Apr 2019 18:46:34 -0400
Received: from genre.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 41B7460FF7;
        Wed, 24 Apr 2019 22:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1556145991;
        bh=fSbGz2tgSzGORbS4P/Yyc1bZtHSipWz63PFsJG2t2Xw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=F3Z3ANb7NbCkWObM7Drl68KlDuLEtZ9B5Q2VJgAnUltm6gyf389UC4X/2b66oGdvg
         T6vnWpN/4UUiHbJ6tCKtNdTrqJERllNpiqIWg3+EQ36NJlSJOe1Z1ftQDQzZqIFZed
         lKmtyvwk9UnuTu3PiwKpXY8UTnjsMX84FvAs/7RNAM3OgIjbglgK6PvW2QJInATjZl
         F0D5GAvLBGwNE5Qa8mkhAiMCE/pLME4k7S0wEPw+ufgzp7OtQ/JZFVKO9sxMhAWndY
         Hdm8/FiWwmHna0KkkJXmE2RjGLPnV1YZPkPnZ+J1aih2+PTk/60PQwTE+C6B4cJvUO
         dS/Sg+Pd+aM9YqeCh3uvtuzXtrBmmsuEROeQI3Tkn8kToiWLh4sk3zV38zDs3ML15X
         H2F8AseOEtgeGkBI2zayDmHBOT6UZE+w8oWjwzSSvGGKjSjdFyrbt1LFrEhZDVyexr
         hR1pqNQ+XGmRl4+UR6aKTj9boKqiHDUs74gp/TGk+kfUlDvDpf6
Date:   Wed, 24 Apr 2019 22:46:27 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/5] sequencer: add support for multiple hooks
Message-ID: <20190424224626.GJ6316@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
 <20190424004948.728326-4-sandals@crustytoothpaste.net>
 <ed0312f5-d174-76e0-fea7-5de93f5840b8@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FCF9ydJxlAJsfRTu"
Content-Disposition: inline
In-Reply-To: <ed0312f5-d174-76e0-fea7-5de93f5840b8@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FCF9ydJxlAJsfRTu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2019 at 10:51:56AM +0100, Phillip Wood wrote:
> On 24/04/2019 01:49, brian m. carlson wrote:
> > Add support for multiple post-rewrite hooks, both for "git commit
> > --amend" and "git rebase".
> >=20
> > Additionally add support for multiple prepare-commit-msg hooks.
> >=20
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >  builtin/am.c                       | 28 ++++++---
>=20
> Having read the patch subject I was surprised to see this touching
> bulitin/am.c

I can rewrite the subject. Unfortunately, the same hook for rebase goes
through two wildly different modules, so in order to completely convert
the post-rewrite hook, I have to update both at the same time.

> > +static void run_interactive_rewrite_hook(void)
> > +{
> > +	struct string_list *hooks;
> > +	struct string_list_item *p;
> > +	struct child_process child;
> > +
> > +	hooks =3D find_hooks("post-rewrite");
> > +	if (!hooks)
> > +		return;
> > +
> > +	for_each_string_list_item(p, hooks) {
> > +		child_process_init(&child);
> > +
> > +		child.in =3D open(rebase_path_rewritten_list(),
> > +			O_RDONLY);
> > +		child.stdout_to_stderr =3D 1;
> > +		child.trace2_hook_name =3D "post-rewrite";
> > +		argv_array_push(&child.args, p->string);
> > +		argv_array_push(&child.args, "rebase");
> > +		if (run_command(&child))
> > +			break;
> > +	}
> > +	free_hooks(hooks);
> >  }
>=20
> If you're adding a function to do this it would be nice to use it from
> am.c as well rather than duplicating essentially the same code. Is there
> any way to use a helper to run all the hooks, rather than introducing a
> similar loop everywhere where we call a hook?

It's becoming clear to me that a helper is probably going to be cleaner,
so I'll add one in for v2.

> >  void commit_post_rewrite(struct repository *r,
> > @@ -1326,6 +1362,7 @@ static int try_to_commit(struct repository *r,
> >  	char *amend_author =3D NULL;
> >  	const char *hook_commit =3D NULL;
> >  	enum commit_msg_cleanup_mode cleanup;
> > +	struct string_list *hooks;
> >  	int res =3D 0;
> > =20
> >  	if (parse_head(r, &current_head))
> > @@ -1369,7 +1406,10 @@ static int try_to_commit(struct repository *r,
> >  		goto out;
> >  	}
> > =20
> > -	if (find_hook("prepare-commit-msg")) {
> > +	hooks =3D find_hooks("prepare-commit-msg");
> > +	if (hooks) {
> > +		free_hooks(hooks);
>=20
> I think you forgot to update run_prepare_commit_msg_hook(), it should
> probably be passed this list now. It might be outside the scope of this
> series but unifying this with builtin/commit.c

run_prepare_commit_msg_hook calls run_hook_le, which looks up that value
itself. It's unfortunate that we have to do it twice, but we need to
know whether we need to re-read the commit msg or not. I can explain
this further in the commit message.

> > diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commi=
t-msg-hook.sh
> > index ba8bd1b514..5b83f037b5 100755
> > --- a/t/t7505-prepare-commit-msg-hook.sh
> > +++ b/t/t7505-prepare-commit-msg-hook.sh
> > @@ -3,6 +3,7 @@
> >  test_description=3D'prepare-commit-msg hook'
> > =20
> >  . ./test-lib.sh
> > +. "$TEST_DIRECTORY/lib-hooks.sh"
> > =20
> >  test_expect_success 'set up commits for rebasing' '
> >  	test_commit root &&
> > @@ -317,4 +318,12 @@ test_expect_success C_LOCALE_OUTPUT 'with failing =
hook (cherry-pick)' '
> >  	test $(grep -c prepare-commit-msg actual) =3D 1
> >  '
> > =20
> > +commit_command () {
> > +	echo "$1" >>file &&
> > +	git add file &&
> > +	git commit -m "$1"
> > +}
> > +
> > +test_multiple_hooks prepare-commit-msg commit_command
>=20
> It's not clear to me that this is testing the sequencer

You're right. I need to adopt a different approach here.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--FCF9ydJxlAJsfRTu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzA50IACgkQv1NdgR9S
9ouMUA//dqacu5FzjnEsbwCwf4XD8KN2WUuM89GB5aD2qGdNCjU6YQ9zxeVBoFVg
MzzrL67Icjh7VqEwiztRCT0+XuoxyMXbJLmdsK6YOcqdzrWwxIr9D1mF7E/aenIM
bZ7asuPRKWM7JZULoDqLzwvAEta920TTjlwbZaU/aqtRuyX5r8UeYbuRmM0Sfz2h
VoyNlmgOkzN0Ju/aytRes7ASiNDauTYJIQIMW7iTzijBwq++5hACtLAHCp/xjRk/
9Z5Us2OkvXkerVYtgefUFUEwUNhBbNY49I4uc+OfiOuOlcOM84nR9N4Rn34VNo51
s0lfLEbnIkIlW1WFx4aFxEqWDeRbmTQTJB+wwtTc1QuV1+Nc31zuw9Cbkn8ckntv
85Ut4C5hg6voJefnAC6RLTpQdP9o0J9SWfeGp7NmNDZKSAriUX2DfQDwi2mU9shU
Dr+aqjxcxj1hOcD5h5FfZhnCQtVMn6OtQoXolzuNKlpgJw+NplL8IJgNLJeBgIJw
KlusNa4+U8U/bEFhtZiZKdxHa24jUfpcA9XvVYLvXySDbpnwDxxvYgkoC6d7rCIQ
z4P9iYUrb5MayEKwYzkRbrvO+csbs7X6JXjna6JbH/NoCK5Jhg0z8Csf//xdCeVb
lxsTIvcQGN4Fov6AP2bO6pnx7Fw3m1rBVivcShS2OAMxyQTWHhY=
=ejVY
-----END PGP SIGNATURE-----

--FCF9ydJxlAJsfRTu--
