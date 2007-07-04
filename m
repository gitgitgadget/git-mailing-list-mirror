From: Jan Hudec <bulb@ucw.cz>
Subject: Re: git-rm isn't the inverse action of git-add
Date: Wed, 4 Jul 2007 22:08:06 +0200
Message-ID: <20070704200806.GA3991@efreet.light.src>
References: <46893F61.5060401@jaeger.mine.nu> <20070702194237.GN7730@nan92-1-81-57-214-146.fbx.proxad.net> <46895EA4.5040803@jaeger.mine.nu> <20070702204051.GP7730@nan92-1-81-57-214-146.fbx.proxad.net> <vpq7ipittl2.fsf@bauges.imag.fr> <Pine.LNX.4.64.0707022205210.4071@racer.site> <vpqoditkc23.fsf@bauges.imag.fr> <Pine.LNX.4.64.0707031308170.4071@racer.site> <vpqir91hagz.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Yann Dirson <ydirson@altern.org>,
	Christian Jaeger <christian@jaeger.mine.nu>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 04 22:08:28 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6B9G-0007Zd-PV
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 22:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755459AbXGDUIP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 16:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755372AbXGDUIP
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 16:08:15 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:45278 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439AbXGDUIO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 16:08:14 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id C95C2573DB;
	Wed,  4 Jul 2007 22:08:12 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id MQZqsKMFP-HA; Wed,  4 Jul 2007 22:08:11 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 15336573F6;
	Wed,  4 Jul 2007 22:08:11 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1I6B8w-0001hY-FK; Wed, 04 Jul 2007 22:08:06 +0200
Content-Disposition: inline
In-Reply-To: <vpqir91hagz.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51636>


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2007 at 15:40:12 +0200, Matthieu Moy wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > Hmm. How did you expect then, that git-rm does _not_ lead to data
> > loss?=20
>=20
> Because there are tons of possible behaviors for "$VCS rm", and I'd
> expect it to be safe even if VCS=3Dgit, since it is with all the other
> VCS I know.
>=20
> What's wrong with the behavior of "hg rm"?
> What's wrong with the behavior of "svn rm"?
> What's wrong with the behavior of "bzr rm"?
> (no, I won't do it with CVS ;-) )
>=20
> None of these commands have the problem that git-rm has.

Hm. They all behave roughly the same: They unversion the file and unlink it,
unless it is modified, in which case they unversion it and leave it alone.

Now git has the extra complexity that index contains also content of the
file. But the behaviour can be easily adapted like this (HEAD =3D version in
HEAD, index =3D version in index, tree =3D version in tree):
 - if (HEAD =3D=3D index && index =3D=3D version) unversion and unlink
 - else if (HEAD =3D=3D index || index =3D=3D version) unversion
 - else print message and do nothing

Would you consider that a sane behaviour?

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGi/4mRel1vVwhjGURAvz0AJ0Qwy/TIQ7uMnR2WQvgoowc0Zz+ZQCcDC36
iq1MrRFLIMCb5pfHTSAEddA=
=SMI9
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
