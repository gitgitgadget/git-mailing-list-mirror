From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Fixes to parsecvs
Date: Thu, 6 Apr 2006 14:08:12 +0200
Message-ID: <20060406120812.GO13324@lug-owl.de>
References: <1144305392.2303.240.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ck22u5fw4m2k6hx2"
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 06 14:08:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRTHx-0002sn-QI
	for gcvg-git@gmane.org; Thu, 06 Apr 2006 14:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWDFMIR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Apr 2006 08:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWDFMIR
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Apr 2006 08:08:17 -0400
Received: from lug-owl.de ([195.71.106.12]:32471 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1750793AbWDFMIQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Apr 2006 08:08:16 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id 005CCF0056; Thu,  6 Apr 2006 14:08:12 +0200 (CEST)
To: Keith Packard <keithp@keithp.com>
Content-Disposition: inline
In-Reply-To: <1144305392.2303.240.camel@neko.keithp.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18468>


--Ck22u5fw4m2k6hx2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-04-05 23:36:32 -0700, Keith Packard <keithp@keithp.com> wrote:
> note, parsecvs remains available from:
>=20
> 	git://git.freedesktop.org/~keithp/parsecvs

It now compiles out-of-the-box for me, nice work.

However, it would be nice if you'd add a short description about how
to use it. Something like this:
---------------------------------------------------------------------
There's still a lot of work to do on parsecvs, but if you want to give
it a run, first create a copy of the whole CVS tree and go to the base
directory of this copy. (You find a lot of *,v files in this directory
and all its subdirectories.)
Now feed all ,v filenames into parsecvs. Keep in mind that a
`edit-change-log' executable needs to be in your $PATH (a one-line
script only exit'ing with 0 will do the job.):

	find . -type f -name '*,v' -print | parsecvs

This will create the .git/ directory and put all the objects, commits
and tree information into this new git repository.
---------------------------------------------------------------------

I just ran it against a locally rsync'ed copy of the Binutils ,v
files. Looging at the progress bar, it is bascally ready:


Load:               winsup/configure.in,v ....................* 27704 of 27=
704


But it seems it now starts to really consume memory:

jbglaw@bixie:~/bin$ ps axflwww|egrep '(VSZ|parsecvs)'|grep -v grep
F   UID   PID  PPID PRI  NI    VSZ   RSS WCHAN  STAT TTY        TIME COMMAND
0  1000 15564 22879  18   0 2805084 549996 finish T  pts/10    30:51 |     =
  \_ parsecvs

How well does this work with even larger repositories?

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--Ck22u5fw4m2k6hx2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFENQSsHb1edYOZ4bsRAjzHAJ9/1WkfF8oVOuq5YUQokSbnJbJyswCdHC6x
+xf1X0bY8pP56FSUtkP/P+E=
=gAR/
-----END PGP SIGNATURE-----

--Ck22u5fw4m2k6hx2--
