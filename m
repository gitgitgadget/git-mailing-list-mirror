From: Martin Waitz <tali@admingilde.org>
Subject: Re: Notes on Using Git with Subprojects
Date: Wed, 27 Sep 2006 14:46:04 +0200
Message-ID: <20060927124604.GD8056@admingilde.org>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.64.0609261629160.9789@iabervon.org> <20060926213003.GA8177@spearce.org> <4519AACD.7020508@gmail.com> <20060927080652.GA8056@admingilde.org> <Pine.LNX.4.63.0609271152270.14200@wbgn013.biozentrum.uni-wuerzburg.de> <20060927113813.GC8056@admingilde.org> <Pine.LNX.4.63.0609271358100.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W5WqUoFLvi1M7tJE"
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 14:46:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSYnm-0007uf-CO
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 14:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbWI0MqL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 08:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbWI0MqL
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 08:46:11 -0400
Received: from agent.admingilde.org ([213.95.21.5]:43399 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1030202AbWI0MqK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 08:46:10 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GSYnc-0005LK-NW; Wed, 27 Sep 2006 14:46:04 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0609271358100.14200@wbgn013.biozentrum.uni-wuerzburg.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27903>


--W5WqUoFLvi1M7tJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Sep 27, 2006 at 02:01:11PM +0200, Johannes Schindelin wrote:
> On Wed, 27 Sep 2006, Martin Waitz wrote:
> > On Wed, Sep 27, 2006 at 11:55:22AM +0200, Johannes Schindelin wrote:
> > > > My current approach is like this:
> > > >=20
> > > >  * create a .gitmodules file which lists all the directories
> > > >    which contain a submodule.
> > > >  * the .git/refs/heads directory of the submodule gets stored in
> > > >    .gitmodule/<modulename> inside the parent project
> > >=20
> > > Taking this a step further, you could make subproject/.git/refs/heads=
 a=20
> > > symbolic link to .git/refs/heads/subproject, with the benefit that fs=
ck=20
> > > Just Works.
> >=20
> > in fact it is done this way (more or less).
>=20
> With the difference, that if you store the refs outside of=20
> <root>/.git/refs, you have to take extra care that prune does not delete=
=20
> the corresponding objects.

that's why there is .git/refs/module/modulname -> .gitmodule/modulename.

> > You can accumulate as many changes in different subprojects until you
> > get to a state that is worth committing in the parent project.
> > All these changes are then seen as one atomic change to the whole
> > project.
>=20
> AFAICT this is not the idea of subprojects-in-git. If you have to track=
=20
> the subprojects in the root project manually anyway, you don't need _any_=
=20
> additional tool (you _can_ track files in a subdirectory containing a .gi=
t=20
> subdirectory).

But then you loose the fine grained commits of your subprojects.
You only store the tree of the subproject when committing to the parent,
not the entire history.

I think having the "commit subproject changes to parent" step as a
manual action makes sense in the same way as you have to trigger a
commit to a repository by hand, too. You are not storing every little
change to your filesystem in the database.

--=20
Martin Waitz

--W5WqUoFLvi1M7tJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFGnKMj/Eaxd/oD7IRAuADAJsFaHwC9s9MfGfhXla2NCHLBaK7UgCdHsNA
XszfjA+Eh7JPPlsujHf4Pis=
=MT8N
-----END PGP SIGNATURE-----

--W5WqUoFLvi1M7tJE--
