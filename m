From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: 6d4bb3833c3d2114d (fetch: verify we have everything we need
 before updating our ref) breaks fetch
Date: Sat, 01 Oct 2011 01:54:08 +0200
Message-ID: <1317426849.4331.29.camel@centaur.lab.cmartin.tk>
References: <1317225869.30267.18.camel@bee.lab.cmartin.tk>
	 <m3y5x8o527.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-ht/6D55sjg1Pb42ww3Iv"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 01 01:54:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9muE-0004yT-Ht
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 01:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755903Ab1I3XyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 19:54:10 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:36433 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755009Ab1I3XyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 19:54:09 -0400
Received: from [192.168.1.17] (brln-4dbc5ac8.pool.mediaWays.net [77.188.90.200])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 1F4C94617B;
	Sat,  1 Oct 2011 01:53:45 +0200 (CEST)
In-Reply-To: <m3y5x8o527.fsf@localhost.localdomain>
X-Mailer: Evolution 3.0.3- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182527>


--=-ht/6D55sjg1Pb42ww3Iv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2011-09-28 at 12:12 -0700, Jakub Narebski wrote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> > Hello,
> >=20
> > Whilst trying to do some work related to fetch, I came across a
> > regression in the 'next' branch. Bisecting gave me this commit as
> > breaking point (and I tried with the parent and there it worked). When
> > doing 'git fetch', rev-list will complain about usage, and fetch will
> > say that we didn't receive enough, even though earlier versions of git
> > have no problems. This fails both on github and on git.or.cz and for gi=
t
> > and http transports:
> >=20
> > $ ./git-fetch git://repo.or.cz/git
>=20
> Have you tried
>=20
>   $ ./git fetch git://repo.or.cz/git

But this would execute /usr/local/libexec/git-fetch, wouldn't it? That
is precisely what I don't want to execute, because I changed some code
in builtin/fetch.c that I want to test.

But yes, the problem was that the local git-fetch was trying to pass an
option to rev-list that my older installed binary didn't understand. In
this particular case I don't want to run the older git-fetch, but
otherwise, that would work.

I guess I'll have to either properly install git from 'next' or base my
changed on 'maint'

   cmn



--=-ht/6D55sjg1Pb42ww3Iv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOhlagAAoJEHKRP1jG7ZzThXUH/A4h5rKfDb46jmcBHgyu3riI
6mwmiA21Vd2Lbma4LH87/h7oxtLmjVzglunhZVlG/4RxU8L0ENw+z5/QDn3jKeXT
PbqM/Kc96Hbs3gwRZtq5VeX+c6cL1CEbUMrkjkzp78JTEXSMzL/FoPhgT5FnEsiI
CmBvaVgNcc44KfHxToEf9uu/oPmEIyh73dyNFECEJWNahFUqX2PQHEMF8+6KKecw
5fOiw7HxpKzsQ3j/CDJZKE6hn0/Yzw6phTt5JUt/XQZwyjYqjb7jN9ysxk2zns8Z
ws1aWqAHbAugQyvGW4VlxQC0cDexTMwMdsYQC6R2xu5r8TLAfZ9BXPi+Zmc//7Q=
=0AX0
-----END PGP SIGNATURE-----

--=-ht/6D55sjg1Pb42ww3Iv--
