Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66882C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 00:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31C13611C7
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 00:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhJUAGX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 20:06:23 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37796 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229702AbhJUAGW (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 20 Oct 2021 20:06:22 -0400
Received: from camp.crustytoothpaste.net (unknown [72.12.180.34])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BC54C60734;
        Thu, 21 Oct 2021 00:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1634774617;
        bh=HTKhi0zusT5/h4xeqlBEs7yx5V8Q4pGP/bz+0XfxXWU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=wxGjQZhYjFI3c6ivp0aSBoB/LpnT3/xAML8xLsyISoPV0L8H2yfrFU/cZMlYnAKtI
         qs7BFDiB5C4sQhWtlke/qLlYjchCH4PhO+2XUmxLZj50BptGQuy+IiAh0VMLVkEiGb
         4YlrF6/L649aarl6W7mLwSLU86beKtOltIrP/WiFibi9cCp3dLnEee14Kv3u6GKMz6
         zfBHKTogyPHqMaxO6TDOHdoD+3zex9CM5Xb4Z4HuRpzBWn2cYLi2QSvBvDdQpF0tED
         zPPNaHECXLzndzdPMz9c/i0ODot7zJsbAC31Rq3T3d/c4Umxz/eakYSDsCw6Vee5Fy
         zQk/VHhGDjDmNXGfqomHc1Xi2c2NJOoK9VvHllGLkO4tt3NnmGHE4o3el67FfgfO4i
         iKQ0VmHbTkgOsg9SZNT8Nyvb3ifqN01JExQzmaPBTG1M+IF5pNjSfMfaIW3RWPklOK
         U1W8GO5BlsbH9e7TAk0ycZwocEYCbl5fE5Scs01tK6cY8xtsGtm
Date:   Thu, 21 Oct 2021 00:03:15 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 4/4] doc: add a FAQ entry about syncing working trees
Message-ID: <YXCuQ3KID6iq0vwa@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20211020010624.675562-1-sandals@crustytoothpaste.net>
 <20211020010624.675562-5-sandals@crustytoothpaste.net>
 <211021.86r1cfmfhh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MGFRd3eMEWJNdtId"
Content-Disposition: inline
In-Reply-To: <211021.86r1cfmfhh.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--MGFRd3eMEWJNdtId
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-10-20 at 23:35:43, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Wed, Oct 20 2021, brian m. carlson wrote:
>=20
> > +The recommended approach is to use `rsync -a --delete-after` (ideally =
with an
> > +encrypted connection such as with `ssh`) on the root of repository.  Y=
ou should
> > +ensure several things when you do this:
>=20
> What's the reason to recommend --delete-after in particular? I realize
> that e.g. in the .git directory not using *A* delete option *will* cause
> corruption, e.g. if you can leave behind stale loose refs with an
> up-to-date pack-refs file.
>=20
> But isn't that equally covered by --delete and --delete-before? I'm not
> very well worsed in rsync, but aren't the two equivalent as far as the
> end-state goes?

Yes.  The goal is that if something goes wrong, you have all the objects
you did before, even if you have some potentially invalid refs.  The
goal is to make it a little less risky if you interrupt it with a Ctrl-C
because you realize the destination contained data you wanted.  I always
prefer --delete-after for that reason, assuming the destination has
sufficient disk space.

It shouldn't make a difference in a successful end state, however.
>=20
> > +Be aware that even with these recommendations, syncing in this way is
> > +potentially risky since it bypasses Git's normal integrity checking for
> > +repositories, so having backups is advised.
>=20
> Perhaps we should recommend running a "git gc" or other integrity check
> after (or "git fsck"), although those don't cover some cases, e.g. the
> pack-refs v.s. loose refs problem in the case of a missing
> --delete-whatever.

I can recommend something like that.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--MGFRd3eMEWJNdtId
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYXCuQgAKCRB8DEliiIei
geGyAQCI2SNZLd7Qb2Dgvwkb1U5hn9StTInpCZM9Q0ARyp0crAD/YKX7cN9y5gc0
vd3KQ2zx6nxcYgL2f11ExO2rQIL0FgU=
=o2is
-----END PGP SIGNATURE-----

--MGFRd3eMEWJNdtId--
