From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: strange cg-add problem
Date: Tue, 22 Nov 2005 13:30:58 +0100
Message-ID: <20051122123058.GB19989@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
X-From: git-owner@vger.kernel.org Tue Nov 22 13:36:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeXMC-0004qp-1O
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 13:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbVKVMdY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 07:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbVKVMdY
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 07:33:24 -0500
Received: from wg.technophil.ch ([213.189.149.230]:22159 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S964902AbVKVMdY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 07:33:24 -0500
Received: (qmail 20472 invoked by uid 1000); 22 Nov 2005 12:30:58 -0000
To: Git ML <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12544>


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I try to backup a MySQLDump and put it into git so we have easy access
to diffs and can have a real history.

The problem I have is that it works perfectly, when running manually,
but when running in the script git refuses to use the file:

----------------------------------------------------------------------
srwali01:/home/server/backup/db# ~/db-dump.sh=20
/home/server/backup/db//2005-11-22/13:26 does not exist or is not a regular=
 file
cg-add: warning: not all files could be added
cg-commit: Nothing to commit
----------------------------------------------------------------------
(The script can be found at [0].)

When I do that on the command line, this happens:

----------------------------------------------------------------------
srwali01:/home/server/backup/db# cg-add /home/server/backup/db//2005-11-22/=
13:26
Adding file /home/server/backup/db//2005-11-22/13:26
Ignoring path /home/server/backup/db//2005-11-22/13:26
srwali01:/home/server/backup/db# cg-commit -m "Backup vom 2005-11-22 um 13:=
26"
cg-commit: Nothing to commit
----------------------------------------------------------------------

When I add it with a relative path it works:
----------------------------------------------------------------------
Adding file 2005-11-22/13:26
srwali01:/home/server/backup/db# cg-commit -m "Backup vom 2005-11-22 um 13:=
26"
A 2005-11-22/13:26
Committed as 3086174c1c84ce598137062867c07a4b7c619c39.
----------------------------------------------------------------------

When I change it in the script to be relativeo
[( cd "$DDIR"; cg-add "$SUBDIR/$FILENAME"; cg-commit -m "Backup vom $SUBDIR=
 um $FILENAME") ]
than the same happens:

----------------------------------------------------------------------
srwali01:~# ./db-dump.sh=20
2005-11-22/13:31 does not exist or is not a regular file
cg-add: warning: not all files could be added
cg-commit: Nothing to commit
----------------------------------------------------------------------

Any hint why it behaves differently in script and command line?

Btw, does someone know, why mysqldump does just one insert and a very very =
long line
and not many inserts with only one value? The bevahiour of it seems to have=
 changed,
as mysqldump did that in earlier releases [sorry bit offtopic].

Greetings,

Nico


[0]: http://linux.schottelius.org/scripts/#db-dump+git.sh

--=20
Latest project: cinit-0.2.1 (http://linux.schottelius.org/cinit/)
Open Source nutures open minds and free, creative developers.

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ4MPgrOTBMvCUbrlAQJ24w//ewvmbmiLdyeYkmeQseTAOpWMd3slxW12
K27628zOg6omvVib2LJFhAa/FxYPkljqlnF5LmxLfN3JixHmaPL3LpQZV4WZtGK4
uAEG4jbTueLdDKiwo2LYUeT7pCWTF0wtABkgNttCdEbmadyaNFTAtmrq9idoZnKH
STpB1uAMO2n58M5zvjHrcSVPBnabtocp7pVIzsBMZGXACZ1stevxRDqEe3UuhTeA
UTuuxK+2jWAwQKuCFligKrxQgI1IeV61Upwg8L1TXz9uehYCQe/2D7QRZRVW+fhB
Tl1eoLBSFvfUGVy9D4bdNKXLRZPpJgIgHYZNMZ9YpyTzEfz8BL3MpsBHnyXsEBe5
yI9ibZIj+AGZEvzkhTjbXeSoZJKwUEYteh6X3XcRpmE+8wP0MZbAOAl+8DgHX4Rn
kfh/YNigaY85MjXrjE1sIVmMzwdDmurSS8sK9gCqbHiiRsfY1p/qmjRWJ6+EK9rn
nAYRiZN6xDC8rrG0HrcDOMw0csLGmKEmROctJ8J5L1/1Va1GEpfJehONzAQDObIc
WfzHY1pSlER+4ZDLwYH/d+qSswNyZ5AG1/XI1hAqixqFOchc+JGP3GNX0a5FE6Qs
YVK+vUPmSvyXAEa3WoQfEK7OoB3AesBc4k+54Uuq+ECrMpjrCJWSaodgpItOKAtU
yejzNywKMwk=
=18KX
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
