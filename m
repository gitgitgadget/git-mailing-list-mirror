Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3E6C56202
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 02:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F87720659
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 02:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgKPCWT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Nov 2020 21:22:19 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41710 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbgKPCWT (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Nov 2020 21:22:19 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E24E560427;
        Mon, 16 Nov 2020 02:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1605493308;
        bh=vrAHVty9UM3SaT8EyWw1vT9/7iQrN6qKhK0SOYgScbU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=TXddfx47RQlyqDUxrruQn8LXroyzW8ctc7BsoP9iUwnTIN/Ls8QewISL8XE9qYl/o
         Xl6RVLdFh8Gtv/ZV7m5vKDAxWlCObw5UQgYz/Hv6NeRblNt/Jw34MWqqZfXEWDwNnI
         3AtezfFU3gF7kW0YcQ2UOUvf3Z2WnnBdoqKupTRA3idySdOwl1ZgEDJ2bsvjYZT6AU
         CRHHL9OFNUS58LX4+pbkOZP5drVAdBJeS7eaoIC42AcYWoeoEvANAVq5jOj8eCCGNl
         by44Ec13Xx0UXFhIxMvvx4q67TtA7yhZFSXZPNqVKjtv0dneNA29qyfPQ5iFYQGJWp
         7zW+W3l+ge3NVTpNKAO+TjtvBYtqWq13osvOFpGweGmNoQOfsbOIR7Yew0Ceypvsm7
         stzCk0P7PwxevMXFpYPu2s47zwtQPL16DcQWPNoI0pFXsHS7bLWZdFvtgpy0oe5nun
         5qyYD+vBcYxkvwb+IL8Y+xryKdFTjqS/l4+9HTBFHR4oMIAlf1m
Date:   Mon, 16 Nov 2020 02:21:43 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 1/2] abspath: add a function to resolve paths with
 missing components
Message-ID: <20201116022143.GB389879@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
References: <20201009191511.267461-1-sandals@crustytoothpaste.net>
 <20201009191511.267461-2-sandals@crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2011091442190.18437@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2011091442190.18437@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-11-09 at 13:55:53, Johannes Schindelin wrote:
> Hi brian,
>=20
> On Fri, 9 Oct 2020, brian m. carlson wrote:
>=20
> > We'd like to canonicalize paths such that we can preserve any number of
> > trailing components that may be missing.  Let's add a function to do
> > that that calls strbuf_realpath to find the canonical path for the
> > portion we do have and then append the missing part.  We adjust
> > strip_last_component to return us the component it has stripped and use
> > that to help us accumulate the missing part.
> >
> > Note that it is intentional that we invoke strbuf_realpath here,
> > repeatedly if necessary, because on Windows that function is replaced
> > with a version that uses the proper system semantics for
> > canonicalization.  Trying to adjust strbuf_realpath to perform this kind
> > of canonicalization with an additional option would fail to work
> > properly on Windows.  The present approach is equivalent to
> > strbuf_realpath for cases where the path exists, and the only other
> > cases where we will use this function the additional overhead of
> > multiple invocations is not significant.
>=20
> Thank you for being so considerate. Yes, on Windows, we use (wherever
> possible) a shortcut that tells us the canonicalized path of existing
> entries.
>=20
> Technically, it is not `strbuf_realpath()` that we override, but we take a
> shortcut _in_ that function. That's semantics, though.
>=20
> More importantly, we recently fixed a bug in our code to allow for a quirk
> in the `strbuf_realpath()` function: `strbuf_realpath()` allows the last
> path component to not exist. If that is the case, now it's time to try
> without last component.
>=20
> In a sense, this is a 1-level version of your infinite-level
> `strbuf_realpath_missing()` function.
>=20
> An idea that immediately crosses my mind is whether that level could be
> something we want to pass directly into `strbuf_realpath()` as a parameter
> (it would be 1 to imitate the current behavior and -1 for the
> infinite-level case). What do you think? Does that make sense?
>=20
> In any case, I think this `_missing()` functionality should be implemented
> a bit more tightly with the `strbuf_realpath()` function because of the
> logic that already allows the last component to be missing:
>=20
>                 if (lstat(resolved->buf, &st)) {
>                         /* error out unless this was the last component */
>                         if (errno !=3D ENOENT || remaining.len) {
>                                 if (die_on_error)
>                                         die_errno("Invalid path '%s'",
>                                                   resolved->buf);
>                                 else
>                                         goto error_out;
>                         }
>=20
> See https://github.com/git/git/blob/v2.29.2/abspath.c#L130-L138 for the
> exact code and context.
>=20
> Seeing as we _already_ have some code to allow for _some_ missing
> component, it should be possible to extend the logic to allow for
> different levels (e.g. using `count_slashes()` if we want to allow more
> than just the last component to be missing).

Okay, if you'd prefer to do it that way, that's fine with me.  I'll
reroll with that change.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX7HiNwAKCRB8DEliiIei
gaQmAP4uJ03YF4iDf/ZdhQKw19rK1NC8N1vEvFKqjuhwjCX3XQEA7faAongMC0dA
ckmS0EXam3dwi/OdeV9aY6bJcIuy0Qs=
=byrt
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
