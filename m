From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <carlos@cmartin.tk>
Subject: Re: logging disjoint sets of commits in a single command
Date: Wed, 01 Feb 2012 01:39:29 +0100
Message-ID: <1328056769.31804.217.camel@centaur.lab.cmartin.tk>
References: <CB4DC442.72F%bryano@fb.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-jlUKsRfhSvbRClPUmCUX"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Bryan O'Sullivan <bryano@fb.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 01:39:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsOEP-0006K0-Al
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 01:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869Ab2BAAjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 19:39:17 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:35326 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752050Ab2BAAjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 19:39:16 -0500
Received: from [192.168.1.17] (brln-4dbc7d36.pool.mediaWays.net [77.188.125.54])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 65C8A46172;
	Wed,  1 Feb 2012 01:39:10 +0100 (CET)
In-Reply-To: <CB4DC442.72F%bryano@fb.com>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189487>


--=-jlUKsRfhSvbRClPUmCUX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-02-01 at 00:27 +0000, Bryan O'Sullivan wrote:
> On 2012-01-31 16:15 , "Bryan O'Sullivan" <bryano@fb.com> wrote:
>=20
> >I'm trying to use "git log" to display only a handful of commits, where
> >the commits are not necessarily linearly related to each other.
>=20
> And I beautifully fat-fingered the "send" key. Oops.
>=20
> What I was *going* to say was that it looks like revision.c:limit_list is
> (whether intentionally or not) getting in the way of this.
>=20
> Here's a sample command line against a kernel tree:
>=20
> git log 373af0c^..373af0c 590dfe2^..590dfe2
>=20
> I want git to log those two specific commits, but in fact it looks like
> limit_list is marking 590dfe2 as UNINTERESTING while processing 373af0c,
> and so it gets pruned.
>=20
> Is there some way around this, or would a patch to fix it be acceptable?

=46rom my reading of the manpage (and the way most git commands work) log
accepts one range of commits. They all get bunched up together.

You might find cat-file's --batch mode interesting.

    git rev-list 373af0c^..373af0c | git cat-file --batch
    git rev-list 590dfe2^..590dfe2 | git cat-file --batch

looks a lot like what you're looking for.

   cmn


--=-jlUKsRfhSvbRClPUmCUX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJPKInBAAoJEHKRP1jG7ZzTJ/cH/iRpwMEXFRvmmCqcruKk6+Hf
GWowQt7yFqhcIpQObiZ8PJWV4ZZQiezppkZcdEUgNqUulXg3li0gmRHKLWFpVdXD
ktMBYUbTiIjUYSN2866P2r9HVge1HefiReEy8DqFddRp8lsFyXkHrgLz/44AWbyi
C8K5wfzTcHs0mEkWTgtRN5S5vNJIvBPPhHiVSc4bhccd1RmYR5jdzyuWGwX1NEMX
UEe8C4RJxyB/1vq8fZQyy4vlN9v09hG15wWBWbY7h8xUsAbIsLMbhVbFtxEsreEr
3tCwz5PQO7GVyY19Eob+Y4Bx887/BWJpsIlYBJPI79rS2zHnUOpbiHcl367MNSM=
=zOpB
-----END PGP SIGNATURE-----

--=-jlUKsRfhSvbRClPUmCUX--
