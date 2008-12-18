From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: negated list in .gitignore no fun
Date: Thu, 18 Dec 2008 16:34:47 -0600
Message-ID: <200812181634.51351.bss@iguanasuicide.net>
References: <87hc51tajw.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2626607.b908YlhTYB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, joey@kitenet.net
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Fri Dec 19 00:18:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDS8L-0004Kw-D1
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 00:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897AbYLRXRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 18:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752601AbYLRXRA
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 18:17:00 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:43720 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbYLRXQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 18:16:59 -0500
X-Greylist: delayed 2538 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Dec 2008 18:16:59 EST
Received: from [206.104.162.243]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LDRS2-0005x5-Ra; Thu, 18 Dec 2008 22:34:38 +0000
User-Agent: KMail/1.9.9
In-Reply-To: <87hc51tajw.fsf@jidanni.org>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103506>

--nextPart2626607.b908YlhTYB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 2008 December 18 15:53:23 jidanni@jidanni.org wrote:
> # head -n 5 .gitignore
> *
> !X11/xorg.conf
> !anacrontab
> !apt/apt.conf.d/10jidanni
> !apt/sources.list
> # git-add .
> But git-status only shows anacrontab got added. None of the files in
> the subdirectories get added.

That's by design.  You've chosen to ignore those directories; they match "*=
"=20
themselves.  Thus, 'git add .' doesn't descend into them looking for files.

I wouldn't want to change this behavior because I'll often use a "build"=20
directory and put all generated files in it and just ignore that directory=
=20
with a single line in .gitignore.

I think the .gitignore you really want is:
*
!X11
!X11/xorg.conf
!anacrontab
!apt
!apt/apt.conf.d
!apt/apt.conf.d/10jidanni
!apt/sources.list
[...]

But, I haven't tested that.
=2D-=20
Boyd Stephen Smith Jr. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ,=3D ,-_-. =
=3D.=20
bss@iguanasuicide.net =A0 =A0 =A0 =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0((_/)o o(\_=
))
ICQ: 514984 YM/AIM: DaTwinkDaddy =A0 =A0 =A0 =A0 =A0 `-'(. .)`-'=20
http://iguanasuicide.net/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\_/ =
=A0 =A0=20

--nextPart2626607.b908YlhTYB
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklK0AsACgkQdNbfk+86fC1nSQCfWfD4x7pJ4iOyZfW5SXWfVvIc
Bs4Amwf4GBqM7LpNra55Fkd74LG+bJYH
=0dnM
-----END PGP SIGNATURE-----

--nextPart2626607.b908YlhTYB--
