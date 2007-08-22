From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH] Fixed non portable use of expr, and incorrect use of
	test -eq for string comparison.
Date: Wed, 22 Aug 2007 23:00:01 +0200
Message-ID: <20070822210001.GA7585@piper.oerlikon.madduck.net>
References: <11877841633473-git-send-email-david@olrik.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Cc: git@vger.kernel.org
To: David Jack Olrik <david@olrik.dk>
X-From: git-owner@vger.kernel.org Wed Aug 22 23:00:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INxJN-0003IB-UU
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 23:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763237AbXHVVAS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 17:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763084AbXHVVAR
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 17:00:17 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:43884 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758834AbXHVVAP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 17:00:15 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id D5384895F4E;
	Wed, 22 Aug 2007 23:00:07 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 22280-10; Wed, 22 Aug 2007 23:00:07 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 37480895F44;
	Wed, 22 Aug 2007 23:00:03 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 5F1029F16A;
	Wed, 22 Aug 2007 23:00:02 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id E1B5B43F4; Wed, 22 Aug 2007 23:00:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <11877841633473-git-send-email-david@olrik.dk>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56419>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach David Jack Olrik <david@olrik.dk> [2007.08.22.1402 +0200]:
> -	if test "`expr index $httpd_only /`" -eq '1' || \
> +	if test "`echo $httpd_only | cut -c 1`" =3D '/' || \

how about

  if [ "$httpd_only" !=3D "${httpd_only#/}" ]; then

that should do the same and does so without external processes.

>  				which $httpd_only >/dev/null

This is also not really portable. I suggest the use of

  command -v $http_only

first, that's shell-internal as well, and second, it's
/more/ portable than which, but also not entirely.

http://www.debian.org/doc/developers-reference/ch-best-pkging-practices.en.=
html#s-bpp-debian-maint-scripts

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"of course the music is a great difficulty.
 you see, if one plays good music, people don't listen,
 and if one plays bad music people don't talk."
                                                        -- oscar wilde
=20
spamtraps: madduck.bogus@madduck.net

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGzKPRIgvIgzMMSnURAnO2AJ9Kjs8VsUoiKUB2P5WcjKSQQB/21wCg1wQ0
VhhGelhIdELkuRKjTnjhNC0=
=m0Kq
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
