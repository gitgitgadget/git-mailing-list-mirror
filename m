From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH] checkout: add a test for creating a new branch with regexp as a starting point
Date: Fri, 30 Jul 2010 12:44:28 +0400
Message-ID: <20100730084428.GA9577@wo.int.altlinux.org>
References: <20100729220111.GA28176@wo.int.altlinux.org> <AANLkTi=Qf1OUmjkpL-6e8gT8MU9G=m37sxrdAoyj5=R0@mail.gmail.com> <201007300136.13501.trast@student.ethz.ch> <20100729220111.GA28176@wo.int.altlinux.org> <AANLkTi=Qf1OUmjkpL-6e8gT8MU9G=m37sxrdAoyj5=R0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 30 10:44:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OelCl-0007Dv-8x
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 10:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755736Ab0G3Iob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 04:44:31 -0400
Received: from vint.altlinux.org ([194.107.17.35]:50851 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755380Ab0G3Ioa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 04:44:30 -0400
Received: from wo.int.altlinux.org (wo.int.altlinux.org [192.168.1.4])
	by vint.altlinux.org (Postfix) with ESMTP id CDCCD3F80005
	for <git@vger.kernel.org>; Fri, 30 Jul 2010 08:44:28 +0000 (UTC)
Received: by wo.int.altlinux.org (Postfix, from userid 508)
	id A860C3F48760; Fri, 30 Jul 2010 12:44:28 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <201007300136.13501.trast@student.ethz.ch> <AANLkTi=Qf1OUmjkpL-6e8gT8MU9G=m37sxrdAoyj5=R0@mail.gmail.com>
X-fingerprint: FE4C 93AB E19A 2E4C CB5D  3E4E 7CAB E6AC 9E35 361E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152232>


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 29, 2010 at 11:07:20PM +0000, =C6var Arnfj=F6r=F0 Bjarmason wro=
te:
> On Thu, Jul 29, 2010 at 22:01, Dmitry V. Levin wrote:
[...]
> > +test_expect_success setup '
> > + =A0 =A0 =A0 echo a > a &&
> > + =A0 =A0 =A0 git add a &&
> > + =A0 =A0 =A0 test_tick &&
> > + =A0 =A0 =A0 git commit -m first &&
> > + =A0 =A0 =A0 echo b > b &&
> > + =A0 =A0 =A0 git add b &&
> > + =A0 =A0 =A0 test_tick &&
> > + =A0 =A0 =A0 git commit -m second
> > +'
>=20
> This should use test_commit (see t/README), but...

The peculiarity of this bug makes it impossible, because test_commit()
also creates a tag which spoils test conditions.

> > +test_expect_success checkout '
> > + =A0 =A0 =A0 git checkout -b new_branch :/first
> > +'
> > +
> > +test_done
>=20
> ...it looks like this can just be added to the end of
> t2018-checkout-branch.sh instead of creating a new test. Creating a
> new file just for a single test for such a simple feature is a bit of
> an overkill.

Well, I see no t2018-checkout-branch.sh yet.  What file do you suggest
appending?

On Fri, Jul 30, 2010 at 01:36:13AM +0200, Thomas Rast wrote:
> It should also use test_expect_failure unless you expect to have a fix
> soon, otherwise it would stop the test suite from running through.

Of course I'd like to have this bug fixed, but OK, let it be
test_expect_failure() for now.


--=20
ldv

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkxSkOwACgkQfKvmrJ41Nh53jQCfWvXu5pWwrADZN7NHIADxwAch
lHcAn24RvZMIhKv1LoEaysQzVYhXetAv
=kbC2
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
