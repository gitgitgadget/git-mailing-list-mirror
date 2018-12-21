Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABBF81F405
	for <e@80x24.org>; Fri, 21 Dec 2018 23:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733083AbeLUXmi (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 18:42:38 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57866 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727652AbeLUXmi (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 21 Dec 2018 18:42:38 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c537:b034:2963:7e8f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DA4146042C;
        Fri, 21 Dec 2018 23:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1545435756;
        bh=kU98n1klloK01plPPa9zP6z/K3OvAuyQRp1Hq6JRKkg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=JwMppD6j5oE2+SkwbV7+VfPBt1/TXu59GD0mdC0vX2rAWB6lsq/4ijP8WkFyYPhGu
         RvxjfEd5mNcB4AtlsALC3bUy+SGNWFWYEGTfWfJWvL7AOoQiCHEqyFK42H4zTR2AS9
         Sbexersxmaloc2wPCXG199VdaTWbwKkgnH7mDypgLk5xydGXg6TxrQvk3ZhTJHXSMa
         ziUUPECSPLpSs6/BaANh0Ln3d2L2H70DczvqIVQbxWHj4mayrzLyqmyLAOr7J4O7kn
         +TDl4Hc0R3tlELpyUsx+aZG5GQJWiWmZJI5SwNjzYT84oLq5+3IJAdgfgbsSnETEGv
         CVKgfdzjBFRqO7z/DdQ7BUYqRLyfb/yoXDzTQbxuRk6WzQbZ9f7mHRRC8q1LuGFy9F
         2SqHr3h1mrtVsJXOVzNtPzIS7ty2t1LVUgviR+DIAJ0QobMfd6BLdsMKmLkTGGIck5
         AouhgI+F+6Uy7KDBGWaey0gx45wr63keHqU8lKjxwnem/vID11l
Date:   Fri, 21 Dec 2018 23:42:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     John Passaro <john.a.passaro@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Can git choose perl at runtime?
Message-ID: <20181221234231.GB10611@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        John Passaro <john.a.passaro@gmail.com>, git@vger.kernel.org
References: <CAJdN7Kioa22xrDP2ssZXmBbu7KDkcr2MQCUDW=Tzm5ydzeChBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
In-Reply-To: <CAJdN7Kioa22xrDP2ssZXmBbu7KDkcr2MQCUDW=Tzm5ydzeChBQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 18, 2018 at 10:09:14PM -0500, John Passaro wrote:
> I recently submitted my first patch using OSX and found the experience
> frustrating, for reasons that have come up on the list before,
> concerning git-send-email and perl dependencies that you need to be
> root to update.
>=20
> Last seen here:
> https://public-inbox.org/git/878t55qga6.fsf@evledraar.gmail.com/
>=20
> The struggle is that Mac's package manager Homebrew has opted,
> apparently with some finality, to no longer support linking to a user
> perl at build time. PERL_PATH is hard-coded to link to the system
> perl, which means the user needs sudo to install the SSL libraries
> required for send-email. So for send-email to work, you need to either
> sudo cpan or build git yourself. The obvious solution here would be to
> do /usr/bin/env perl, but in the above message Aevar pointed out
> pitfalls with that.
>=20
> It seems that choosing perl at compile time necessarily comes with
> tradeoffs. So I wonder if there is a way we can support choosing a
> perl at runtime without breaking the existing mechanism of linking to
> perl at compile time.
>=20
> I'm picturing adding an executable "git-perl" to libexec that checks
> config core.perlPath and envvar GIT_PERL_PATH, in some order. Having
> chosen one of these or the build-time PERL_PATH as a last resort, it
> exec's the correct perl executable.
>=20
> Then relevant scripts (e.g. git-add--interactive, git-send-email)
> invoke git-perl instead of /usr/bin/perl, and the makefile no longer
> replaces that with PERL_PATH -- instead that will be used at runtime
> via git-perl when we can be sure the user does not explicitly prefer
> something different.

How do git send-email and git svn work in such a case? They depend on
the Git and Git::SVN modules being in place, so if you use a Perl other
than the one you built Git with, they won't be present (or they'll be
present, but potentially with the wrong version).
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlwdemcACgkQv1NdgR9S
9otfdg/8DEfznvMiI8hi3E/afNAeKNzysagVe61VzRUDqg4JqYNvMYuekS1Sskyz
YwFyvYSjoi5WXfFvozBSUUV9ELi4yfaXCbJTUP0fQU+helmkHQH0ufJ5qQ/m1qmC
67k94gol2H6sRas1bjTmblor7UDaN1HnVnMFkqLZBvGZDMUcOl35RvxZzEX4ckH5
YkAMgF3Oseq5zmRazk2q6z9Uma4KABBbdmWBCAaa8cAC+UXL7tsgcSeesw59tgFs
FzZ0tpWO/BfpP+D6nMLTlBesqtw5A4qKJ1W8sUR6qYL7nBLeQWmr14PNPOp967BF
gV0cZZX97lOiCYOKU4TVFF0vjVf/hgo+DAmnOnLDM1DUPH4AuntZFScX+Z9sYhdF
42Mjf7mPzUdNNU3U9QdOGgvkb0SNAiwhY6Ep3Pd32ssRsVcEgbKpM4AnBySmd0qe
2urP7DDna0PLdu0MYNpuBNjmxcZKPldt4w/iA6FVXuw2HOMJ0bdMdgoxzlK623+m
HrF0hO5ouqOAgES9z7VS8TfIoowWySMk56v3hmxWUkSOQbetJPlL/cpyBDq9lXRC
Auxz0xKiPq5yvsxIXkNEs00ShdS9WPHmsyS4RLqL+AxIIjIvJwCAEq2Apsm9bkYT
mX2nsMUNDK4La7bcgBjhQD9KGJMUlhbcsrCVRzB56TiFabibLSo=
=uUNS
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
