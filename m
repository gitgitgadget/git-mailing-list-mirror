From: Peter Cordes <peter@cordes.ca>
Subject: git gui bug: filenames starting with ~
Date: Sat, 28 Mar 2015 21:25:35 -0300
Message-ID: <20150329002535.GA3933@cordes.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary=2fjX3cMESU3XgGmZ
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 29 01:55:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yc1Vz-0006DI-1g
	for gcvg-git-2@plane.gmane.org; Sun, 29 Mar 2015 01:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbbC2Azj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2015 20:55:39 -0400
Received: from mta02.eastlink.ca ([24.224.136.13]:42364 "EHLO
	mta02.eastlink.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbbC2Azi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2015 20:55:38 -0400
X-Greylist: delayed 1800 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Mar 2015 20:55:38 EDT
Received: from cmgw04.eastlink.ca ([71.7.199.170])
 by mta02.eastlink.ca (Oracle Communications Messaging Exchange Server
 7u4-21.01 64bit (built Feb 16 2011))
 with ESMTP id <0NLY00BAM3OCPU70@mta02.eastlink.ca> for git@vger.kernel.org;
 Sat, 28 Mar 2015 21:25:35 -0300 (ADT)
Received: from llama.cordes.ca ([24.222.15.154])	by cmgw04.eastlink.ca with	id
 9CRc1q0013KSLsg01CRcLf; Sat, 28 Mar 2015 21:25:36 -0300
X-Authority-Analysis: v=2.1 cv=X+5rdgje c=1 sm=1 tr=0
 a=VqZp1DG769JwQ3ubIT2vIg==:117 a=VqZp1DG769JwQ3ubIT2vIg==:17 a=A3G9z55_2fAA:10
 a=d-Ega9QjyLEA:10 a=emO1SXQWCLwA:10 a=T591hJNQgOonvGdZexwA:9 a=CjuIK1q_8ugA:10
 a=uVyZoGBFGNNoMgFfFNEA:9 a=vzJ8XXBVs6QA:10
Received: from peter by llama.cordes.ca with local (Exim 3.36 #1 (Debian))
	id 1Yc12l-0001Ha-00	for <git@vger.kernel.org>; Sat, 28 Mar 2015 21:25:35 -0300
Content-disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266426>


--2fjX3cMESU3XgGmZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  I didn't check if git claims to support arbitrary filenames.  If a
leading ~ isn't allowed, then this isn't a bug.

I'm using git-gui version 0.19.GITGUI, from git version 2.3.4, from
the Ubuntu PPA.
git  2:2.3.4-1avh1~utopic1


steps to reproduce:

mkdir -p git-shellmeta && cd git-shellmeta
git init
touch '~bin' '~xyz'
git gui &

In the gui, ~bin appears in the list of files with unstaged changes.
However, instead of appearing as a file, the diff pane shows
Git Repository (subproject)

Selecting ~xyz pops up a dialog saying:=20

Error loading file:=20
user "xyz" doesn't exist

So I guess username expansion is happening somewhere it shouldn't.

The home directory of the "bin" user on my system is /bin, which is
not a (subdir of a) git repo.  The message that ~bin is a subproject
is another symptom of this bug.


PS.
no, I didn't name that ~bin file.  Someone else left it lying around
in a directory.

--=20
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC

--2fjX3cMESU3XgGmZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iLwEAQEIAAYFAlUXRn4ACgkQBaSaEuRa5FPlBQT+Pco6skl1UQKlBR8XMrG35oVy
RCJdZTL+1SKZG22qHzmrJ1lF2LOz6Q7GbNXmci6g4GRrFMQ4v+u2ySjOuQxGdoVq
/Wfx6jvIgedMozB0tWxaS4v/QrNOth72OScAs9biLv12nvUn39SOHiepRwwno9Gz
T0Z6LqiD4QoRTNbGNGNM/uJCFPlPSqqVJ3uYvxPAYm0EXTlZmziUI7c6/qUG6w==
=aVKM
-----END PGP SIGNATURE-----

--2fjX3cMESU3XgGmZ--
