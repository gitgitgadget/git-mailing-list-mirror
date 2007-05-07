From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] submodule merge support
Date: Mon, 7 May 2007 11:03:46 +0200
Message-ID: <20070507090346.GI30511@admingilde.org>
References: <20070506190224.GG30511@admingilde.org> <20070506220745.GA2439@steel.home> <alpine.LFD.0.98.0705061517380.12945@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xs+9IvWevLaxKUtW"
Cc: Alex Riesen <raa.lkml@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon May 07 11:03:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkz8O-0001wZ-Ku
	for gcvg-git@gmane.org; Mon, 07 May 2007 11:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077AbXEGJDt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 05:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754125AbXEGJDt
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 05:03:49 -0400
Received: from mail.admingilde.org ([213.95.32.147]:40273 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754077AbXEGJDt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 05:03:49 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Hkz8E-0000Qb-Oc; Mon, 07 May 2007 11:03:46 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0705061517380.12945@woody.linux-foundation.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46435>


--xs+9IvWevLaxKUtW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sun, May 06, 2007 at 03:18:53PM -0700, Linus Torvalds wrote:
> On Mon, 7 May 2007, Alex Riesen wrote:
> > merge-recursive is a mess already, you just made even more so.
> > Besides, you completely forgot all other merge strategies.
> >=20
> > How about making all existing strategies just ignore submodules, and
> > move recursive merge in the merge driver (git-merge.sh)?
>=20
> Yes, I think that's the right thing to do.
>=20
> I think it's the right thing for another reason: in a true "recursive"=20
> merge, the submodules shouldn't be recursively merged anyway. *THEIR*=20
> merge will have its own history, and doing it based on some random histor=
y=20
> of the superproject is actually wrong anyway!

Of course the submodule has to get its own history, it's not possible
to do otherwise.  But you have to trigger the submodule merge when you
find a submodule-level conflict in the supermodule merge, just as
you trigger file-level three-way merges, too.
This is really all which my patch does -- it starts a new instance of
the merge driver which only merges the submodule commit from the other
supermodule tree.
So it's not recursive in the merge-recursive way, but in a
call-git-merge-again way.

The comment about merge-recursive not being the best place is correct of
course.

--=20
Martin Waitz

--xs+9IvWevLaxKUtW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGPutyj/Eaxd/oD7IRAjUSAJ4qIUWcQkgMd897CdSCFkHeSa1phwCfa5au
AoadmLvBp9tWnVhS52bYL7k=
=rw4S
-----END PGP SIGNATURE-----

--xs+9IvWevLaxKUtW--
