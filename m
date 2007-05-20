From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Third round of support for cloning submodules
Date: Sun, 20 May 2007 23:40:26 +0200
Message-ID: <20070520214026.GL5412@admingilde.org>
References: <11796842882917-git-send-email-skimo@liacs.nl> <7vhcq7l3ar.fsf@assigned-by-dhcp.cox.net> <20070520195930.GX942MdfPADPa@greensroom.kotnet.org> <20070520205444.GC25462@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E69HUUNAyIJqGpVn"
Cc: skimo@liacs.nl, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 23:40:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpt8j-00086A-Sf
	for gcvg-git@gmane.org; Sun, 20 May 2007 23:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756670AbXETVk2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 17:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756657AbXETVk2
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 17:40:28 -0400
Received: from mail.admingilde.org ([213.95.32.147]:51241 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756670AbXETVk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 17:40:27 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Hpt8c-000633-JW; Sun, 20 May 2007 23:40:26 +0200
Content-Disposition: inline
In-Reply-To: <20070520205444.GC25462@steel.home>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47927>


--E69HUUNAyIJqGpVn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sun, May 20, 2007 at 10:54:44PM +0200, Alex Riesen wrote:
> Me too. I actually believe it is the only way to do it. How can you
> checkout a subproject to something else (to what a branch may point)
> and to what the tree of superproject has? On the other side (in
> subproject) - why are you, the superproject, allowed to screw the
> references of the subproject?! It is independent, isn't it?!

right.  except when you have some managed-by-superproject branch
which is known to be special ;-)

After all the submodule checkout is independent from its parent
repository, too -- so you don't screw anything *g*.


> > >  - What would we do when the subproject working tree is not
> > >    clean?
> >=20
> > I was planning on adding a --dry-run to git-checkout.
> > The superproject would run this in each subproject before
> > doing the actual checkout of the superproject.
>=20
> Why not do exactly what we do now? Pass "-m" down to it, if it was
> given to the top-level git-checkout.

sounds good.
With submodules we have to consider one extra level of merging.
-m in the supermodule also means that an automatic merge of the
dirlink entry should be done.  Which would execute git-merge in the
submodule.  And merging in a dirty tree is a challenge of its own.

So if local changes conflict with the checkout we should just error out.

--=20
Martin Waitz

--E69HUUNAyIJqGpVn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGUMBKj/Eaxd/oD7IRApUxAJ9klXTS6S0mRQbvuxx6q0EbT41K7QCfT9ZL
m5fhAMj1JCViCHJjsGJ/3/M=
=eYIw
-----END PGP SIGNATURE-----

--E69HUUNAyIJqGpVn--
