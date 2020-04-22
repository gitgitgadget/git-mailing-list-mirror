Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AD5C2BA19
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 02:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEDF7206D4
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 02:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0hWI24Bu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgDVCU4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 22:20:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37524 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726055AbgDVCU4 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 22:20:56 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E165D6088E;
        Wed, 22 Apr 2020 02:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1587522025;
        bh=3j5c9O22Xnz6MStkXkh1z7lIFN5WBKZyuQ5WLy3t9wU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=0hWI24Bu/t4X4JHj2duQ7SlD53b6oGEmO3TU4vUIyZ1q0iFoPgEMvJkxrvPsfs/6j
         mVyqYmIyh+2NR27K8Bwfzzi1aH6h7o4fjqqz8c8e1gGH6ApKJQEkloEItuiEpQON6U
         E/6o8vA7pKw1taomHZM8uc1zSG7NHZwejjgseg8h5i6oqK0PCG4H4w75a8EotvUoQl
         qoEsOUGGZ0BOZT/8Ddl7eJtT/ViGj4wTgW8R5DqGXddk5zPTbCB/pSX/Zfe5Ct86fW
         X3RNgoVBtO9qWfUQ1XlJ8QHTQsIeQ0wO5fkaWmtmEstnzO8p4FXtzY/GTRfmbn7vHF
         Gtx1/uGMXNF4gmsZlXXJgAk3F0d7hSSVoR/KyAAqHO8x3onsLpjs8fPT+3sk1SP3rf
         9NrBJsv2f9BsNz7OPCX0IxbtY9TEpo61zG5ZuZUginIC/8d4c6Pdy1Vm9EVZbe5iNl
         goo2k5ZNU1tQVjAaklfoqOIkXuxbPOB6yvmjF2RILYIwg+TBQab
Date:   Wed, 22 Apr 2020 02:20:20 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, Ilya Tretyakov <it@it3xl.ru>,
        "brian m. carlson" <bk2204@github.com>, git@vger.kernel.org
Subject: Re: Credential helpers are no longer invoked in case of having
 sub-folder parts in a repository URL. Since 2.26.1 version
Message-ID: <20200422022020.GF6465@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
        Ilya Tretyakov <it@it3xl.ru>,
        "brian m. carlson" <bk2204@github.com>, git@vger.kernel.org
References: <CAOrRacVviJP3w98-=QpFKYp630cN3gZQYnvAWZXeKqZRk2UDXg@mail.gmail.com>
 <20200421225837.GB3515235@coredump.intra.peff.net>
 <20200422010943.GD6465@camp.crustytoothpaste.net>
 <20200422012817.GD103469@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H4SyuGOnfnj3aJqJ"
Content-Disposition: inline
In-Reply-To: <20200422012817.GD103469@google.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.5.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--H4SyuGOnfnj3aJqJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-22 at 01:28:17, Jonathan Nieder wrote:
> brian m. carlson wrote:
> > On 2020-04-21 at 22:58:37, Jeff King wrote:
>=20
> >> This is unrelated to the recent helper fixes in v2.26.x. Here's a simp=
le
> >> reproduction:
> >>
> >>   url=3Dhttps://git.example.com/my-proj/my-repo.git
> >>   echo url=3D$url |
> >>   GIT_TERMINAL_PROMPT=3D0 \
> >>   ./git \
> >>     -c credential.helper=3D \
> >>     -c credential.$url.helper=3D'!echo username=3Dfoo; echo password=
=3Dbar;:' \
> >>     credential fill
> >>=20
> >> which should print a filled credential (with "foo/bar"), but will fail
> >> with recent versions. It bisects to brian's 46fd7b3900 (credential:
> >> allow wildcard patterns when matching config, 2020-02-20).
> >
> > Yeah, I can reproduce this.  It looks like what's happening is that
> > we're percent-encoding the slash in the paths as %2f, which of course
> > isn't going to match in the urlmatch code.  We probably need to tell the
> > percent encoding function not to encode slashes in this case.
> >
> > I'm testing a patch now and hope to have it on the list a little later
> > this evening.  Thanks for reporting and bisecting, and sorry for the
> > breakage.
>=20
> Thanks.  Here's another (though I haven't tried bisecting yet):
>=20
> 	echo url=3D'https://github.com/git/git' |
> 	GIT_TERMINAL_PROMPT=3D0 \
> 	git -c credential.helper=3D \
> 		-c credential.github.com.helper=3D'!echo username=3Dfoo; echo password=
=3Dbar;:' \
> 		credential fill

gitcredentials(7) says the following:

  Git considers each credential to have a context defined by a URL.
  This context is used to look up context-specific configuration, and is
  passed to any helpers, which may use it as an index into secure
  storage.

I'm not sure a hostname qualifies as a URL in this case.  So while my
patch did break this, I don't believe it's ever been documented to
actually work and was an artifact of our implementation (along with
"credential./git/git.helper" and "credential.https://.helper").  I've
also never seen this syntax used in the wild, but maybe I'm not looking
in the right places.

I don't think we can shoehorn it into urlmatch, since that would break
compatibility with the `http.*` config options, so I think we'd have to
revert the entire feature if we want to preserve it.  I think I'd prefer
to leave things as it is since it seems uncommon and there are easy
alternatives, but if folks prefer, I can send a patch to revert the
urlmatch feature.

I will likely not be online tomorrow (Wednesday), so if folks decide
they want a revert, I can send that out Thursday afternoon (GMT-05:00).
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--H4SyuGOnfnj3aJqJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXp+p4gAKCRB8DEliiIei
gQnsAQCVdMArHB4Wm93FXppSq3M3geuhFfYVvYZV7pIGlhFjwwD8CfUMeMfRRlF/
Wxf+f27YRI0/vfi4et8sFyQdW47rJA0=
=k7B2
-----END PGP SIGNATURE-----

--H4SyuGOnfnj3aJqJ--
