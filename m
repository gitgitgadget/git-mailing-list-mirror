From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH 2/2] Handle invalid argc gently
Date: Thu, 14 Sep 2006 22:25:39 +0400
Message-ID: <20060914182539.GA12109@basalt.office.altlinux.org>
References: <20060914010409.GB20593@nomad.office.altlinux.org> <7vu03b5k0t.fsf@assigned-by-dhcp.cox.net> <20060914013146.GD7044@basalt.office.altlinux.org> <7vpsdz5542.fsf@assigned-by-dhcp.cox.net> <20060914131626.GE6709@basalt.office.altlinux.org> <7virjq4cfj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 14 20:26:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNvuR-00036o-GE
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 20:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWINSZl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 14:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWINSZl
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 14:25:41 -0400
Received: from mh.altlinux.org ([217.16.24.5]:58579 "EHLO mh.altlinux.org")
	by vger.kernel.org with ESMTP id S1750919AbWINSZk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Sep 2006 14:25:40 -0400
Received: from basalt.office.altlinux.org (localhost.localdomain [127.0.0.1])
	by mh.altlinux.org (Postfix) with ESMTP
	id BBA09382CC44; Thu, 14 Sep 2006 22:25:39 +0400 (MSD)
Received: by basalt.office.altlinux.org (Postfix, from userid 501)
	id AA0E2B0D93; Thu, 14 Sep 2006 22:25:39 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7virjq4cfj.fsf@assigned-by-dhcp.cox.net>
X-fingerprint: FE4C 93AB E19A 2E4C CB5D  3E4E 7CAB E6AC 9E35 361E
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27023>


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2006 at 09:53:36AM -0700, Junio C Hamano wrote:
[...]
> >> What is the valid reason to do execlp("git", NULL, NULL)?
> >
> > Personally I do not plan to execute git this way on regular basis, inde=
ed. :)
> >
> > But argc =3D=3D 0 is allowed, so why should git crash?
>=20
> Oh, no I was not arguing for making git crash.  I was just
> trying to learn if there is a valid reason to choose to, or
> common misconfiguration that causes it to, run with ac =3D=3D 0,
> since I did not think of any.

Well, the execlp example is somewhat dragged in.
More common case is execvp:

char *argv[] =3D { NULL };
execvp("git", argv);

The argv array may be empty for various reasons, e.g. pointer arithmetic
mistakes.


--=20
ldv

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFCZ6jfKvmrJ41Nh4RAneBAJ9/PL4ev5lZJIcAu8+BOqzeSwoVzACdGGR6
mIWlYo9nyZyFaikNbcRIkGk=
=DVR+
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
