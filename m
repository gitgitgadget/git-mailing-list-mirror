From: Martin Waitz <tali@admingilde.org>
Subject: Re: Notes on Using Git with Subprojects
Date: Thu, 28 Sep 2006 09:37:06 +0200
Message-ID: <20060928073706.GE8056@admingilde.org>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.64.0609261629160.9789@iabervon.org> <20060926213003.GA8177@spearce.org> <4519AACD.7020508@gmail.com> <20060927080652.GA8056@admingilde.org> <451AADC3.40201@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lkTb+7nhmha7W+c3"
Cc: Shawn Pearce <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 09:37:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSqSO-0000um-UA
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 09:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbWI1HhN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 03:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751750AbWI1HhN
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 03:37:13 -0400
Received: from agent.admingilde.org ([213.95.21.5]:8602 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1751575AbWI1HhM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 03:37:12 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GSqSA-0000Lc-EX; Thu, 28 Sep 2006 09:37:06 +0200
To: A Large Angry SCM <gitzilla@gmail.com>
Content-Disposition: inline
In-Reply-To: <451AADC3.40201@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27993>


--lkTb+7nhmha7W+c3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Sep 27, 2006 at 09:58:43AM -0700, A Large Angry SCM wrote:
> This means that modules are not separate, stand alone projects but,=20
> rather, just a sub part of your bigger project. Very useful and=20
> applicable in some situations but other situations want/need separate,=20
> stand alone subprojects.

you can do everything with the submodule which would be possible with
a normal GIT repository.  And you can always clone it into an directory
which is not controlled by a parent project.

I really think that this is an very important property of a submodule.

> >By storing the complete refs/heads directory for each submodule instead
> >of only one head, it is possible to track multiple branches of a
> >subproject.  I'm don't know yet how this works out in praktice but I
> >think that it can be nice to be able to atomically commit to several
> >branches of one submodule (perhaps one branch per customer, per
> >hardware platform, whatever).
>=20
> It's not immediately clear to me if tracking several long term=20
> (globally) visible branches in a checkout sub module is generally useful=
=20
> or only useful in special situations. I need to think about this...

One use-case which may be important here:

The submodule has two different branches which got forked and are not
intended to be merged again.  At some point in time the parent project
wants to switch from one branch of the submodule to another branch.
If a user still has modifications in the old branch and wants to
update the parent project then it is important to know if the local
modifications and those coming from the parent have to be merged or
should stay in different branches.
If the parent is switching branches there should only be some warning
if the user still has modifications in the old branch, giving him the
chance to port the modifications to the other branch.

--=20
Martin Waitz

--lkTb+7nhmha7W+c3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFG3uij/Eaxd/oD7IRAuGYAJ9+940sakU33AyMz7XU2QDFRR4JnQCfTsye
4Tc1GtGCdrcqHE4kliLgGGI=
=G7cV
-----END PGP SIGNATURE-----

--lkTb+7nhmha7W+c3--
