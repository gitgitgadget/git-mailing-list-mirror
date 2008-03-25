From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: git-merge adds test to a message -- bug?
Date: Tue, 25 Mar 2008 01:12:47 +0100
Message-ID: <20080325001247.GB26905@alea.gnuu.de>
References: <slrnfudp0q.19k.joerg@alea.gnuu.de> <7vabko3dm2.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803241208400.4353@racer.site> <7viqzcvznm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 11:16:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je6CW-0000Xo-VY
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 11:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880AbYCYKPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 06:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752865AbYCYKPT
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 06:15:19 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:2841 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752543AbYCYKPR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 06:15:17 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 74868488034; Tue, 25 Mar 2008 11:15:15 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Je5ym-0005id-2Q; Tue, 25 Mar 2008 11:02:08 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JdwmV-00075c-RC; Tue, 25 Mar 2008 01:12:47 +0100
Content-Disposition: inline
In-Reply-To: <7viqzcvznm.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78172>


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hallo Junio,

Junio C Hamano schrieb am Mon 24. Mar, 09:45 (-0700):
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > On Sun, 23 Mar 2008, Junio C Hamano wrote:
> >
> >> I unfortunately do not recall why _prepend_, and not _replace_, had to=
 be
> >> the right behaviour.
> >
> > http://article.gmane.org/gmane.comp.version-control.git/31896/match=3Dg=
it+merge+make+usable
> >
> > Hth,
>=20
> Ok, it helped.
>=20
> So it was "my suspicion that people who would want to pass -m would want
> it to behave this way".
>=20
> I do not care deeply either way myself, as I never have found use for -m
> to the merge command, but I think it could have been argued either way.

I would like to argue for the replace way. :) Take git rebase -p as an
example. If a merge is included in the rebase, it's redone with git merge
-m. Because git rebase works with detached heads you get merge messages
like this:

commit 580c95c6bb4bb74bdbf6776ca816560690c16c5d
Merge: 62b68ef... 9604163...
Author: A U Thor <author@example.com>
Date:   Thu Apr 7 15:26:13 2005 -0700

    Merge branch 'to-be-preserved' into to-be-rebased
   =20
    Merge commit '96041635cd9e0bd999384c1c30d7df40002a0742' into HEAD

This is an example from the test t3404. Simply run git log -g and search
for merges.

Maybe a new option -M for merge could help? -m with the old behaviour to
prepend and -M to replace.

Bye, J=F6rg.
--=20
IRC: Der [Prof. Andreas Pfitzmann, TU Dresden] hat gerade vorgeschlagen, sie
  sollen doch statt Trojanern die elektromagnetische Abstrahlung nutzen. Das
  sei nicht massenf=E4hig, ginge ohne Eingriff ins System, sei zielgerichte=
t,
  und, der Hammer, das funktioniere ja bei Wahlcomputern schon sehr gut.

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH6EN/we0mZwH1VIARAmSCAKCf2uG/LE3Iz09CKdDDTp58UpagbgCbBege
rgeSch2WgSNB/1KE+jUyPo4=
=Lz6O
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
