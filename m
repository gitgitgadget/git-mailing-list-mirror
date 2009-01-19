From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: how to omit rename file when commit
Date: Mon, 19 Jan 2009 11:41:02 -0600
Message-ID: <200901191141.07440.bss@iguanasuicide.net>
References: <1976ea660901190113l5407f108lff8f37d9a8331f58@mail.gmail.com> <7v63kbr6zc.fsf@gitster.siamese.dyndns.org> <1976ea660901190135k71087673p85e995878e539a8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4897546.9ydPgUGPMc";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Frank Li" <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 18:41:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOy8B-0006rn-Il
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 18:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbZASRkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 12:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbZASRkW
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 12:40:22 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:52794 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbZASRkU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 12:40:20 -0500
Received: from [206.104.167.41]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LOy6k-00085f-Km; Mon, 19 Jan 2009 17:40:18 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <1976ea660901190135k71087673p85e995878e539a8f@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106371>

--nextPart4897546.9ydPgUGPMc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 2009 January 19 03:35:41 you wrote:
>For example:
>there are 2 file. a.c and e.c
>I modify e.c.
>and git mv a.c b.c
>
>git update-index e.c
>
>I just want to commit e.c and don't commit rename(a.c -> b.c)

Here, it looks like all you need to do is follow the instructions given by =
git=20
status--use "git reset HEAD" on each file you want unstaged:
$ rm -rf test && mkdir test
$ cd test
/home/bss/test
$ git init
Initialized empty Git repository in /home/bss/test/.git/
$ echo b > a.c; echo d > e.c
$ git add a.c b.c e.c
$ git commit -m 'Setup'
Created initial commit fc9d26e: Setup
 2 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 a.c
 create mode 100644 e.c
$ git mv a.c b.c
$ echo e > e.c
$ git add e.c
$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       renamed:    a.c -> b.c
#       modified:   e.c
#
$ git reset HEAD -- a.c b.c
a.c: locally modified
$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   e.c
#
# Changed but not updated:
#   (use "git add/rm <file>..." to update what will be committed)
#
#       deleted:    a.c
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       b.c
$ git commit -m 'e.c: Fix typo'
Created commit c23b226: e.c: Fix typo
 1 files changed, 1 insertions(+), 1 deletions(-)
$ git status
# On branch master
# Changed but not updated:
#   (use "git add/rm <file>..." to update what will be committed)
#
#       deleted:    a.c
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       b.c
no changes added to commit (use "git add" and/or "git commit -a")

HTH.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart4897546.9ydPgUGPMc
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkl0uzMACgkQdNbfk+86fC0XpgCggK8iHT3x3UawHm3yCfIEvef8
SgYAn0/pok6TSnWvJDjo6zbJhTEypm+i
=VJqD
-----END PGP SIGNATURE-----

--nextPart4897546.9ydPgUGPMc--
