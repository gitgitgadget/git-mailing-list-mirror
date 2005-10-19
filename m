From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: Problem getting older version
Date: Wed, 19 Oct 2005 10:00:46 +0200
Message-ID: <20051019080046.GI22986@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q59ABw34pTSIagmi"
X-From: git-owner@vger.kernel.org Wed Oct 19 10:02:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES8sr-0006my-LY
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 10:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbVJSIBK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 04:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbVJSIBK
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 04:01:10 -0400
Received: from wg.technophil.ch ([213.189.149.230]:60321 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S932344AbVJSIBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 04:01:09 -0400
Received: (qmail 23664 invoked by uid 1000); 19 Oct 2005 08:00:46 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10269>


--Q59ABw34pTSIagmi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

The following situation:

- The last commit was a merge, mhich broke some files
- We want three files from the commit before

Now I was told to do the following:

1. get the sha1hash from the commit before (cg-log did that)
2. get the sha1hash from the file in that tree:
[9:27] srsyg01:walderlift% git-ls-tree 35ff687efc1b19b4db918e5af859894a9dc9=
16e4 Code/lw1/Client/MainForm.xfm=20
100644 blob 605958b1435f6bdbd5cc502ae3a4c1a281d01f0a    Code/lw1/Client/Mai=
nForm.xfm

3. cat the file with git-cat-file
[9:36] srsyg01:walderlift% git-cat-file blob 605958b1435f6bdbd5cc502ae3a4c1=
a281d01f0a | less

4. Now overwrite it
[9:38] srsyg01:walderlift% git-cat-file blob 605958b1435f6bdbd5cc502ae3a4c1=
a281d01f0a > Code/lw1/Client/MainForm.xfm=20

5. Goto 2 and repeat two times

Is this really the standard way to recover a file? As a developer / end use=
r I would expect that:

cg-recover <filename> <commit id> and -f for overwriting the file if it exi=
sts

Did I overlook something or is it currently really this complicated? And it=
 is
very error prone, if I have to overwrite the files using '>'-redirection (p=
erhaps I mistype the
filename).

Nico

--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--Q59ABw34pTSIagmi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ1X9LbOTBMvCUbrlAQLH+A//Zhjl5zzZ/LaQHfx7HBEoJiiiZ9jZl7Yr
bSURA5qBCQi8JFHb0j6ecFNXfVHD2Y0jv+6ey8Dt923bRqdfJLkeMPk5MkSLbNj4
5abbDeiMGuf95K9P88RnngqDXSK6w6wyvu7Z1GZe3vy3nqjsdKdLyzXGYy+2+xmA
9/q23HUx9djlv3r8ZPZgsburwhcc35LIWcmZgwdtjNZnBWpe7Os+eMhhVxlETSyM
xDGUg0xFCo4VWkuZuYFly1T6zVcROXNAbJ6rGyj0mxKrxn5z3AaJoXDjzZYzvOOF
eLMad/wlIzD1Tx/4ZkyvfJbSEMPZctobK2WsvQfFafLffYO9k+zLN6NjNDuygxBL
dHdu7e8x9BxXW1L7nYbNxYQlZv1F5TrSx54N1LrOeLukx9qnUL1UHUQfti69zLfh
Yq47apq0scolXXcxKxDkC7n+A4MJ2S1AU1u3xTrXcrMZvKsPRiuaF2rxKC6PwAmc
APlHyITZ+YT6mGirFgeiHuXohb+GWdsCeJmtkWIMJjJg+Bctjmyq5xTZGGETP7EL
XkQ5+KFkTdenJzmPoC+pGhrP39qTiaYXbuPZnBiKY0EVCWEECkOn83QwXkPr0M7D
5fTtDTZyRuLj8qZ489jthQ7rM7NxINoS8+srM5qYFRdk18MYVB4AjFZwXGLDzJVI
1F+LONl65IM=
=0yks
-----END PGP SIGNATURE-----

--Q59ABw34pTSIagmi--
