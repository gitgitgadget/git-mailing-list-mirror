Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30F4C433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 03:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351300AbiASD2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 22:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240019AbiASD2l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 22:28:41 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DF9C061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 19:28:41 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B2EC85B227;
        Wed, 19 Jan 2022 03:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1642562920;
        bh=ObapFdFKlvsRcx+3tHPYl8KZY87Dqmm5foC3qNoNIIM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=shyF74kEi5YGeK6tolldvmG9FbStkFQMfHxshG7IJmijgslTeWmn3TR6JmMPluTXe
         p2dyVf7WycS02tyzpp6iYC2nRpGoanfw0MHN9npuh2D4M/ZDUm6D7z7u/6/pCi1UJK
         rchesFJwaJV7TjeaqXVODQl2nz5LlHrDDROiF6zMr2415Du3JaZd01/kIretMuXyr0
         11upzWZVZQuK7OZt4aQY935++osUuLBBJgWa1uxyiWJXVb2XTgMdcyskff91yVRaj/
         5wVRDogqjtwFD+6CYLtvxzzBpiiTWJi/wlPIbfeUPAzumBAKRh2gh4a/p5wiN06762
         vgYfDoArZpm4Qsgd1uP4i3z8G82CFeIIS58GBm+VBHMnpX6aNptziSOBUcbNGS8gTp
         QpsvjyHJt+vcWj6J2WIB6FEe58eozfX4FaP+byBG4TR2Of+wHe5R6hLloIj64P4wCx
         k8FfhmJWT/xForYED+/cEdKRaPOksaEMG6Xw5PsqKgXiP0Q5ANd
Date:   Wed, 19 Jan 2022 03:28:39 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        rsbecker@nexbridge.com, Taylor Blau <me@ttaylorr.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] wrapper: use a CSPRNG to generate random file
 names
Message-ID: <YeeFZ0Gf9+0fH32a@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        rsbecker@nexbridge.com, Taylor Blau <me@ttaylorr.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20220104015555.3387101-1-sandals@crustytoothpaste.net>
 <20220117215617.843190-1-sandals@crustytoothpaste.net>
 <20220117215617.843190-3-sandals@crustytoothpaste.net>
 <220118.86zgntpegy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DgQO9jVtXzZzQUJV"
Content-Disposition: inline
In-Reply-To: <220118.86zgntpegy.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DgQO9jVtXzZzQUJV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-01-18 at 09:24:58, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> I had a comment on v1[1] of this series which still applies here,
> i.e. the "if we're writing into TMPDIR[...]" here elides the fact that
> much of the time we're writing a tempfile into .git, so the security
> issue ostensibly being solved here won't be a practical issue at all.
>=20
> Then for out-of-repo tempfiles some OS's have a per-user $TEMPDIR you
> can use (e.g. systemd's /run/user/`id -u`). Finally...

Some OSes do have that, but it is not universal and we can't rely on
environment variables being set.  They are stripped out by some
programs, including Homebrew, even on OSes where they're provided.

/run/user is also not a suitable temporary directory on Linux.
Temporary files can be large, and /run is almost always a tmpfs, which
means it sits entirely in memory.  Setting anything in /run as TMPDIR
is a mistake.

> ...we already have in-tree users of mkstemp(), which on glibc ostensibly
> tries to solve the same security issues you note here, and the
> reftable/* user has been added since earlier iterations of this series:
> o   =20
>     $ git grep -E '\bmkstemp\(' -- '*.[ch]'
>     compat/mingw.c:int mkstemp(char *template)
>     compat/mingw.h:int mkstemp(char *template);
>     entry.c:                return mkstemp(path);
>     reftable/stack.c:       tab_fd =3D mkstemp(temp_tab_file_name.buf);
>     reftable/stack.c:       tab_fd =3D mkstemp(temp_tab->buf);
>     reftable/stack_test.c:  int fd =3D mkstemp(fn);
>     wrapper.c:      fd =3D mkstemp(filename_template);
>=20
> This series really feels like it's adding too much complexity and
> potential auditing headaches (distributors worrying about us shipping a
> CSPRNG, having to audit it) to a low-level codepath that most of the
> time won't need this at all.

Every Rust program or Go program includes code to call a CSPRNG because
it's required to avoid hash collision DoS attacks.  I do plan to look
into that in the future, because my guess right now is that we are in
fact vulnerable to DoS attacks if someone creates crafted object IDs.[0]
When I do that, I'll need this code.

I also don't think adding code for a CSPRNG is an auditing problem.  We
use the system CSPRNG, which is the thing that literally everybody
should be doing if they need good quality random numbers.  If we were
shipping a custom CSPRNG, then that would be an auditing problem, but I
am explicitly not doing that because it's not necessary here and I'm
willing to insist that the system provide one somewhere so we don't have
to.

> So instead of:
>=20
>  A. Add CSPRNG with demo test helper
>  B. Use it in git_mkstemps_mode()
>=20
> I'd think we'd be much better off with:
>=20
>  A. Split out callers of tempfile.c and mk.*temp in wrapper.c that create=
 tempfiles in .git
>  B. <the rest>
>=20
> I honestly haven't looked too much at what <the rest> is, other than
> what I wrote in [1], which seems to suggest that most of our codepaths
> won't need this.
>=20
> I'd also think that given the reference to CSPRNG in e.g. some glibc
> versions that instead of the ifdefs in csprng_bytes() we should instead
> directly use a secure mkstemp() (or similar) for the not-.git cases that
> remain after the "mktemp in a dir we chown" v.s. "mktemp in shared /tmp"
> are split up.
>=20
> Maybe these are all things you looked at and considered, but from my
> recollection (I didn't go back and re-read the whole discussion) you
> didn't chime in on this point, so *bump* :)

I did explain it in the cover letter for v2, along with the explanation
in the paragraph above.  The situation is that mkstemp doesn't handle
all our use cases, and Randall said in the followups to v1 that mkstemp
is not available on NonStop.  I therefore must conclude that we'll need
to implement this somewhere, even if only as a fallback.

If we think mkstemp is going to work here and we don't need this, then
I'll drop this series.  However, I am annoyed that I'm getting
conflicting information about what code is portable on different
platforms, which is made especially difficult by trying to support Unix
systems that don't support a 21-year-old standard and which lack
suitable public documentation.  If I write and polish a series based on
a set of information I've been given and then it turns out that we
decide to do something completely different based on conflicting
information, that's not a motivator to continue sending patches.  This
will not be the first time I've dropped a series after several rounds of
review because we totally decided to change course and do something
different, and I don't want to repeat this again.

[0] This type of attack is extremely trivial because the number of
collisions necessary for this attack is usually on the order of 2^16,
which means the work can be done in a couple seconds on a typical
system.  I have a proof of concept of this for PHP online.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--DgQO9jVtXzZzQUJV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYeeFZQAKCRB8DEliiIei
gXdvAP4mts+sXKVnDPJK4rSd+jyk2FkGtV6qClcCw3118ziBPQD/Vy1J8tK2rKvQ
qdRL2SDmh+2SJ/kgKeFBRl9Z2BZ3pg8=
=mP52
-----END PGP SIGNATURE-----

--DgQO9jVtXzZzQUJV--
