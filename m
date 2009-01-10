From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: Git - Pushing to a production website
Date: Fri, 9 Jan 2009 23:04:47 -0600
Message-ID: <200901092304.51986.bss@iguanasuicide.net>
References: <20090109222344.3539138a@family.dyweni.com> <200901092238.06968.bss@iguanasuicide.net> <20090109224618.5d8c461c@family.dyweni.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1284038.LWuv7WTkbx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: 4jxDQ6FQee2H@dyweni.com
X-From: git-owner@vger.kernel.org Sat Jan 10 06:06:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLW35-00029T-2B
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 06:06:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbZAJFEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 00:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbZAJFEQ
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 00:04:16 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:51741 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbZAJFEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 00:04:16 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.124])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LLW18-0003Jh-US; Sat, 10 Jan 2009 05:04:15 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <20090109224618.5d8c461c@family.dyweni.com>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105076>

--nextPart1284038.LWuv7WTkbx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 2009 January 09 22:46:18 4jxDQ6FQee2H@dyweni.com wrote:
>> You could simply commit after running the perl script.  You could
>> even commit to a branch so that it's (a little) less likely those
>> changes get integrated into master.
>
>How about this, ran by the post-update hook:
>
>For the first update:
>
> - Do a git pull

I'm not enitirely sure you want post-update doing the pull.

> - Then create a new branch 'working' and checkout
> - Apply the patches to 'working' and commit
>
>This leaves 'working' =3D=3D 'master^'

Actually, it leaves HEAD =3D=3D working and master =3D=3D working^.

>For subsequent updates:
> - Compare the SHA1 hashes for 'working' and 'master^'.
>   - If they don't match, throw an error and exit
> - Assuming they match, checkout 'master' and delete 'working'
> - Do a git pull

(See above)

> - Then create a new branch 'working' and checkout
> - Apply the patches to 'working' and commit
>
>
>This would keep the working directory clean and allow future updates to
>occur, if no one commits anything to git 'working'.  If they did, the
>script would exit and prevent the update requiring the developer to
>review the commit logs and cherry-pick where necessary.

It wouldn't *completely* prevent changes to working as one could "git=20
commit --amend" and still have working^ =3D=3D master.  That said, if devel=
opers=20
get creative enough they can probably bypass most measures, at least those=
=20
based on a hook.

A privileged process for updates could stash the expected SHA for master an=
d=20
working somewhere developers can't write.  That should prevent even dedicat=
ed=20
developers from making unauthorized changes, modulo security/cryptographic=
=20
exploits.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart1284038.LWuv7WTkbx
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkloLHMACgkQdNbfk+86fC0gLgCbBzp8lPPWRaTVi8/qkZBHTOTe
zWkAnAwuQhjts5mzazFGqZIIT+5Lp7OP
=jzLL
-----END PGP SIGNATURE-----

--nextPart1284038.LWuv7WTkbx--
