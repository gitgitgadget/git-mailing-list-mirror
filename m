From: Martin Waitz <tali@admingilde.org>
Subject: Re: .gitlink for Summer of Code
Date: Tue, 27 Mar 2007 00:03:08 +0200
Message-ID: <20070326220302.GH22773@admingilde.org>
References: <1174825838.12540.5.camel@localhost> <1174930688.5662.20.camel@localhost> <20070326183523.GG22773@admingilde.org> <200703262133.44520.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NPukt5Otb9an/u20"
Cc: Eric Lesh <eclesh@ucla.edu>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	git@vger.kernel.org
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 27 00:03:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVxHZ-0002yw-9R
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 00:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933274AbXCZWDO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 18:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933332AbXCZWDO
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 18:03:14 -0400
Received: from mail.admingilde.org ([213.95.32.147]:54791 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933274AbXCZWDN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 18:03:13 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HVxHS-0002Uu-J7; Tue, 27 Mar 2007 00:03:10 +0200
Content-Disposition: inline
In-Reply-To: <200703262133.44520.Josef.Weidendorfer@gmx.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43191>


--NPukt5Otb9an/u20
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 26, 2007 at 09:33:44PM +0200, Josef Weidendorfer wrote:
> The idea was to make this a possible building block for submodules.
> A simple symlink does not work there when you want the checkout to
> work even after moving the whole checkout directory around (e.g. to move =
the
> submodule around inside of the superproject).

Well the submodule use case is a bit different than the lightweight
checkout.
When you store the submodule object database inside the supermodule then
you only need to store the position of the submodule relative to its
supermodule.  As you wrote this is neccessary in order to find the part
of the object database which belongs to this one submodule.
Finding the supermodule repository is obviously not difficult, only
finding the right part of it.
But for lightweight checkouts you need something which is closer to a
symlink.

> > So having an almost empty .git directory=20
> > and reusing parts from another .git directory makes a lot of sense to
> > me.
>=20
> This would work. However, you can not clone from an almost empty .git
> directory with current git.

You can't clone from a .gitlink with current git, eighter ;-).
But if you e.g. set git_dir according to your link then everything
should work quite easily.

> The original proposal was to have a standard .git directory for every
> light-weight checkout inside of the base .git directory, e.g.
> in <base>/.git/ext/<name>.git where <name> is some identifier for the
> lightweight checkout, either provided in the .gitlink file or
> automatically determined.

What would you store in these per-checkout directories?
The index and HEAD?  Anything more?
For submodules I currently use <parent>/.git/objects/module/<submodule>/
to store the objects belonging to the submodule.
Perhaps it makes sense to extend this to a full .git directory per
submodule, I'm not yet decided on that.
For submodules the object store has to be different, but for normal
lightweight checkout this should of course be shared.

--=20
Martin Waitz

--NPukt5Otb9an/u20
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGCEMVj/Eaxd/oD7IRAljgAJ0efUS7q16nDVmzI5WtH+Q9mUNW7gCePRyQ
KohkLoVlYDj0kXAS+rdfAj8=
=IaRS
-----END PGP SIGNATURE-----

--NPukt5Otb9an/u20--
