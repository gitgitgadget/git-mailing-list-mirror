Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3BC31F404
	for <e@80x24.org>; Mon, 29 Jan 2018 02:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751411AbeA2C6Q (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 21:58:16 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53732 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbeA2C6P (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jan 2018 21:58:15 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F51CD9366;
        Sun, 28 Jan 2018 21:58:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=ktROhjZKm9dYWrPwg6W3vUhYKlc=; b=vSPdyaQ
        0bwoeWD/3DrRR7FMdYtnUEi0khimg+CB3j+vgkfYGHwSMZs5HptN1fm2Ss/Coi0K
        Mp46moblqEeSrDmCKGI9mur+PZDXN5ctFaBc4i8d94DrMNEKM1joFT2ItKTi1dBj
        zAck+MPa3wuhDzwM/s/NeqqyPRCNIwBBXCZo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=REI0piKeqE9dAM2SbKj7n7Y29UtWfi1g4
        UwJYwQfmKrZktszfglKzLdjZ7/ad1sO6/VFaDbuW6t4U48KLNnki025s00XLxXkT
        HcH3Zf7hDVhOMTkdo6eIE1hoWLvXr1pY0RAUGwyR9zOmea2c4jGGWY+gOeoNqJ91
        YSWGXHDNSk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 86730D9365;
        Sun, 28 Jan 2018 21:58:14 -0500 (EST)
Received: from zaya.teonanacatl.net (unknown [173.67.181.41])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 10299D9363;
        Sun, 28 Jan 2018 21:58:14 -0500 (EST)
Date:   Sun, 28 Jan 2018 21:58:12 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: t9128 failing randomly with svn 1.9?
Message-ID: <20180129025812.GD1427@zaya.teonanacatl.net>
References: <20180129015134.GN431130@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="csti59zOqP8qx56L"
Content-Disposition: inline
In-Reply-To: <20180129015134.GN431130@genre.crustytoothpaste.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Pobox-Relay-ID: 3F79239A-04A0-11E8-AC2D-692D1A68708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--csti59zOqP8qx56L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

brian m. carlson wrote:
> While running tests for my object_id part 11 series, I noticed a random
> segfault in git svn while running t9128.  I've reproduced this on a
> different machine as well, using both Subversion 1.9.5 and 1.9.7 (Debian
> stable and unstable).  It is reproducible on master.
>=20
> When the test fails, it fails on the "git svn tag tag3" step, and I get
> the following:
>=20
> Copying file:///home/bmc/checkouts/git/t/trash%20directory.t9128-git-svn-=
cmd-branch/svnrepo/trunk at r2 to file:///home/bmc/checkouts/git/t/trash%20=
directory.t9128-git-svn-cmd-branch/svnrepo/tags/tag3...
> Found possible branch point: file:///home/bmc/checkouts/git/t/trash%20dir=
ectory.t9128-git-svn-cmd-branch/svnrepo/trunk =3D> file:///home/bmc/checkou=
ts/git/t/trash%20directory.t9128-git-svn-cmd-branch/svnrepo/tags/tag3, 2
> Found branch parent: (refs/remotes/origin/tags/tag3) 0604824a81a121ad05aa=
f8caea65d8ca8f86c018
> Following parent with do_switch
> Successfully followed parent
> r7 =3D f8467f2cee3bcead03e84cb51cf44f467a87457d (refs/remotes/origin/tags=
/tag3)
> error: git-svn died of signal 11
>=20
> Doing the following three times, I had two crashes.
>=20
> (set -e; for i in $(seq 1 20); do (cd t && ./t9128-git-svn-cmd-branch.sh =
--verbose); done)
>=20
> I'm not really familiar with git svn or its internals, and I didn't see
> anything recently on the list about this.  Is this issue known?

I see the same test fail randomly on Fedora (and I think on
CentOS/RHEL, but I run the full tests more often on Fedora).

For me, it's tests 3 and 4 which fail with the same error.
I thought it was a failure in subversion or the perl
bindings rather than git, so I simply disabled them in the
Fedora builds.  The Debian packages skip 9128 as well (and
9167, which fails similarly).

I've seen the failures in t9141 from 'git svn branch' as
well.  I made a note to re-enable those tests after Jeff's
work to make it easier to run with shell tracing enabled by
default, but have not done so yet.

The 'git svn' tests are not run in Travis because the perl
subversion bindings are not installed.  I haven't made time
to try installing them and running the tests in Travis to
see if the failures occur there, but I suspect they would.

--=20
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Going to trial with a lawyer who considers your whole life-style a
Crime in Progress is not a happy prospect.
    -- Hunter S. Thompson


--csti59zOqP8qx56L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQFEBAEBCAAuBQJabo3EJxhodHRwczovL3d3dy5wb2JveC5jb20vfnRtei9wZ3Av
dG16LmFzYwAKCRBDJZOLvq8M41QcCACV7nQ303EHZEwPn61U8EKuajwhcyNYg2Gg
a7zBLAJ5mD6XPeLzYEQIbh5xY7nTiZQsVBeUONoMUTCQhi7+e7pIrn1uoo3yOZHU
fWZth4lu8li/NINuOvo56D1bXt/Rx43RlQRkwxF8sq7AFMkle0SFXsf3TYZXOqz3
z86rIVcjkjh43LfKLPKVmBUXoDpHX3YSqQS3ShPiOJfArVipcRNmLiDL53s5YCY8
0L/p9+h3iNxqX84+2OVgb5VnJ31AI+abAQquYYi7WdSmO9f0YiaGbsdyl1b/drmH
j7nB/7LEeOh0lEZvE//Ge0C+SsVQwWUJeByBQcUQREE3POTMSgp5
=8GAa
-----END PGP SIGNATURE-----

--csti59zOqP8qx56L--
