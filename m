From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: Re: ssh removed?
Date: Wed, 7 Dec 2005 15:29:39 +0100
Message-ID: <20051207142938.GD26574@schottelius.org>
References: <20051206211918.GP21705@schottelius.org> <20051206232945.GJ22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sXc4Kmr5FA7axrvy"
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 07 15:34:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ek0Ip-0004j8-1H
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 15:29:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbVLGO3r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 09:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbVLGO3r
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 09:29:47 -0500
Received: from wg.technophil.ch ([213.189.149.230]:14295 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1751091AbVLGO3q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2005 09:29:46 -0500
Received: (qmail 29495 invoked by uid 1000); 7 Dec 2005 14:29:39 -0000
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20051206232945.GJ22159@pasky.or.cz>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13324>


--sXc4Kmr5FA7axrvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Petr Baudis [Wed, Dec 07, 2005 at 12:29:45AM +0100]:
> Dear diary, on Tue, Dec 06, 2005 at 10:19:18PM CET, I got a letter
> where Nico -telmich- Schottelius <nico-linux-git@schottelius.org> said th=
at...
> > Did somebody remove git+ssh in git? If I search for ssh in cg-log
> > in the git source I do not see any hint. But I see that when trying to
> > use it:
> ..snip..
> > [22:16] hydrogenium:ccollect.sh% cg-version
> > cogito-0.17pre.GIT (c10cc1d2a99b01ed3bf45d5f2ad6157940a22365)
> > [22:17] hydrogenium:ccollect.sh% git --version
> > git version 0.99.8.GIT
>=20
> Quite on the contrary, your GIT is too old - at least 0.99.9 is required
> as noted in the INSTALL file.

And I found the problem's source now:

[15:23] hydrogenium:git# cg-update                                         =
        =20
Recovering from a previously interrupted fetch...                          =
        =20
Fetching head...                                                           =
        =20
Fetching objects...                                                        =
        =20
error: The requested URL returned error: 404                               =
        =20
Getting pack list                                                          =
        =20
Getting alternates list                                                    =
        =20
error: Unable to find a0adb3dcb345a380e1b6f2208feff4f61499e0d3 under http:/=
/www.kern
el.org/pub/scm/git/git.git/                                                =
        =20

--> git was not updated from update-git+cogito.sh!

Now I try to update it, after I removed the git source direcotry:

[15:24] hydrogenium:build# rm -rf ~nico/build/git
[15:24] hydrogenium:build# ~nico/update-git+cogito.sh
Working on git (in /home/user/nico/build/git) ...
Cloning git
defaulting to local storage area
Fetching head...
Fetching objects...
progress: 3 objects, 6382 bytes
error: The requested URL returned error: 404
Getting pack list
Getting index for pack 46ff81b11ed16ed38caa4aada913cb08c00185b2
Getting pack 46ff81b11ed16ed38caa4aada913cb08c00185b2
which contains 8a6bd02d4ff1628af4c47d8c0c35d835607832d1
error: The requested URL returned error: 404
Getting alternates list
error: Unable to find 6ff87c4664981e4397625791c8ea3bbb5f2279a3 under http:/=
/www.kernel.org/pub/scm/git/git.git/

I am trying to get git with git-0.99.8, is that impossible currently?

I am wondering why it gets a 404, the url I use for git is

http://www.kernel.org/pub/scm/git/git.git

for cogito is

http://www.kernel.org/pub/scm/cogito/cogito.git

Nico

--=20
Latest project: cinit-0.2.1 (http://linux.schottelius.org/cinit/)
Open Source nutures open minds and free, creative developers.

--sXc4Kmr5FA7axrvy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ5bx0rOTBMvCUbrlAQJ7xQ/9G5wAtg+J7J6LhBgsLrd9FaljCPQDjtq1
1dd4wMjl9AR5dR4NbK53Qqlh7B85EdnBdKkGG28RJxc4e2JMbttc/dsE1DzC7Elo
qIlTk8w31cr9z8KUyeFZQqmanMOVleWTcbb7qi0zUNKoYDZVYDLGPXPvMvFPau0K
/i0RxyD17XkxOUroVjG9bCZxq/6xbKLIAD8xHpVYzYxUmOxQ+ls5hSd5Fp2tsn5V
RoFgNuTvp1dE+TNi+sJu7vthd7+7n+FtMfaqgXnGT68sxY+LfDFvnvtzX2Co6t4x
If2uOmZ10Ox2T6Ipd4huVT2RL6uA4Uw7I4aUN/Kv+gIKFC27tC1HvCsHT81XQ9MY
ix1gExFZuphMTTc+SzxyIjcFw4P9RdLNmwLv8d6SZ0ef0unLINV01LyFfoRQ648C
+EijDJbEsZY6YfseeikagKitr3RjryXVmF7Ax0WzbFlhrCirtHVr7jwRLvLKOvZ4
zVsZnm4Re8pM7PT+KoXHAnQ2jH+KH+AnBsh+4F4Ne1YFNDVuQLLdOSfEnbBEDQNA
CLU+6y6cQI9got33PtI6dPE3seeG9KcVoYwyJTKE7bN8ejOKI/yh/fLEU6hlTgXz
wKFepGRrk+yeJyvC2NMMWPC2kVRtxCWHLSjElPBMIoPPqUIWA8G2MT0aaGs+KtyR
Jy2GEVHLF1I=
=Fx/U
-----END PGP SIGNATURE-----

--sXc4Kmr5FA7axrvy--
