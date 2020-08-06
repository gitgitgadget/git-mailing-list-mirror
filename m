Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AE7C433E0
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 23:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B368D221E2
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 23:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="EThyAB2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgHFXJV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:09:21 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41396 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725812AbgHFXJT (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Aug 2020 19:09:19 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AB0CF60129;
        Thu,  6 Aug 2020 23:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596755327;
        bh=tISJCLtWH7OKCla0j5wOEBHDweNIltGAaKh1gLRfRzI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=EThyAB2vyq5TVhKAwZaAuCmXq4DCKKZWBJxWkkCD8WAjKQouPCXuoIV05ufJjkRVz
         4EJiRSGdpnhYlW/xsWTMU9tCvQQVHjvmD3dgswSBmAQJeshQkr9t4VruNqZn0SIudy
         KlAzdawtSezdxQUIqySjb4ITQBJB0CfQF+lay4MoDcTtMhBsVMX1iaILkvObVezAzK
         VfixCdjqQ4+ky1WdhYxMxgCrFmBV4DiU+P7J/KOny9mvH1tS6xmUP34V852lCj6R9d
         NKT6subI6PcfqtTpSPVFyyNJNwRUSNDL94ZFF4wvqJjM+FC/0aen18do2715WKk9LR
         wVA7gZSJ3TV9efiFNeR5YAcEkr24iQqR4ZElsBVyNNy+DbMdF6Lx8R0u5lgx/7T9kQ
         wducneiRh/udu7CKT+s1AivkeBnPmWi7Brs0lvSxLjTF6pA7jb5a9TVxiEmOGMgZGs
         iZmh1bku9xykcZ0aKFqbZ4KMMVHwhskR4h7FhC9SNWapCiqyvgl
Date:   Thu, 6 Aug 2020 23:08:37 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation: mark `--object-format=sha256` as
 experimental
Message-ID: <20200806230837.GA8085@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org
References: <20200806202358.2265705-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <20200806202358.2265705-1-martin.agren@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-06 at 20:23:58, Martin =C3=85gren wrote:
> After eff45daab8 ("repository: enable SHA-256 support by default",
> 2020-07-29), vanilla builds of Git enable the user to run, e.g.,
>=20
>   git init --object-format=3Dsha256
>=20
> and hack away. This can be a good way to gain experience with the
> SHA-256 world, e.g., to find bugs that
>=20
>   GIT_TEST_DEFAULT_HASH=3Dsha256 make test
>=20
> doesn't spot.
>=20
> But it really is a separate world: Such SHA-256 repos will live entirely
> separate from the (by now fairly large) set of SHA-1 repos. Interacting
> across the border is possible in principle, e.g., through "diff + apply"
> (or "format-patch + am"), but even that has its limitations: Applying a
> SHA-256 diff in a SHA-1 repo works in the simple case, but if you need
> to resort to `-3`, you're out of luck.
>=20
> Similarly, "push + pull" should work, but you really will be operating
> mostly offset from the rest of the world. That might be ok by the time
> you initialize your repository, and it might be ok for several months
> after that, but there might come a day when you're starting to regret
> your use of `git init --object-format=3Dsha256` and have dug yourself into
> a fairly deep hole.

I do agree that they don't interoperate right now, and that we'd like it
to in the future.  But there are definitely people who can use SHA-256
support for new projects without problems.  I'm aware of certain
government agencies who very much do not want to use SHA-1 at all (and
at some point will be legally prohibited from doing so), and they will
be completely fine with the status quo.  Some of those same
organizations are unhappy about prohibited algorithms even being linked
into the binaries they use.  These folks can use a suitably new version
of Git everywhere and not care about the lack of backwards
compatibility.

I am, of course, in favor of abandoning SHA-1 as fast as practically
possible, but I understand that backwards compatibility is obviously a
concern.

> Workflows aside, let's consider a more technical aspect. Pack index
> files (pack-*.idx) exist in two flavours: v1 and v2. The hash transition
> document foresees a v3, which we do not yet support (and for all we
> know, the final v3 might end up different from the one sketched in the
> hash transition document).
>=20
> When the test suite is run with SHA-1 as the default hash algo, it
> creates and consumes v2 pack files. But with SHA-256, we use an
> undocumented, hybrid format where the header looks like v2, but where
> the payload is not only "not correct SHA1", but where even the data
> sizes are different. The trailing checksum is different, meaning no-one
> (except us!) should/would try to interpret this file as a proper v2 pack
> index.
>
> We could certainly (re)define v2 to match our SHA-256 behavior, but we
> do foresee v3 for a reason. And that would still just fix this specific
> issue. And even when everything around SHA-256 is well-defined and we
> have SHA-1--SHA-256 interoperability, there's a risk, at least
> initially, that somewhere we'd be permeating buggy data that we'd then
> feel responsible for and need to be able to handle for a long time to
> come.

These are valid index v1 and v2 files, just with a different hash
algorithm.  v3 is there for the point where we do interoperate and need
to store hash values of multiple algorithms at once.  There's little to
no benefit to v3 if you don't need multiple algorithm support, other
than the fact that they declare the algorithms in them.

This is no different than saying that our commit or tree objects are in
a different form; they are syntactically identical, just with a
different hash algorithm.  That's how everything is in the .git
directory.

> diff --git a/Documentation/object-format-disclaimer.txt b/Documentation/o=
bject-format-disclaimer.txt
> new file mode 100644
> index 0000000000..4cb106f0d1
> --- /dev/null
> +++ b/Documentation/object-format-disclaimer.txt
> @@ -0,0 +1,6 @@
> +THIS OPTION IS EXPERIMENTAL! SHA-256 support is experimental and still
> +in an early stage.  A SHA-256 repository will in general not be able to
> +share work with "regular" SHA-1 repositories.  It should be assumed
> +that, e.g., Git internal file formats in relation to SHA-256
> +repositories may change in backwards-incompatible ways.  Only use
> +`--object-format=3Dsha256` for testing purposes.

I'm fine with marking the functionality experimental for a few releases,
since it is possible we have bugs people haven't found, and adding a
note about interoperability after that point, since I think that's a
fair and valuable issue.  I think if we go a few releases without any
major issues, we can change this to the following:

  Note that a SHA-256 repository cannot yet share work with "regular"
  SHA-1 repositories.  Many tools do not yet understand SHA-256
  repositories, so users may wish to take this into account when
  creating new repositories.
--=20
brian m. carlson: Houston, Texas, US

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXyyNdQAKCRB8DEliiIei
gRYDAP9MQDGyfKIzNEMSFO2IS4WbK5WaioswZ2mnOGk8aT0dyQD8CsFVsjTJEsKE
jTecW+SpxqE9RaxvFP9AJg6NxujgyAA=
=yZen
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
