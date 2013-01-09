From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: [PATCH] t1402: work around shell quoting issue on NetBSD
Date: Tue, 08 Jan 2013 21:07:54 -0500
Message-ID: <rmitxqrhzwl.fsf@fnord.ir.bbn.com>
References: <50EC8025.8000707@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git discussion list <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Jan 09 03:08:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsl5T-0006if-Tr
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 03:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756786Ab3AICH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 21:07:56 -0500
Received: from fnord.ir.bbn.com ([192.1.100.210]:54005 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753851Ab3AICHz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 21:07:55 -0500
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id 561F0A644; Tue,  8 Jan 2013 21:07:54 -0500 (EST)
OpenPGP: id=32611E25
X-Hashcash: 1:20:130109:git@vger.kernel.org::vSN4lzJS7w3HU6Me:0000000000000000000000000000000000000000000WKi
X-Hashcash: 1:20:130109:gitster@pobox.com::vSN4lzJS7w3HU6Me:000000000000000000000000000000000000000000003LAn
X-Hashcash: 1:20:130109:mhagger@alum.mit.edu::7g4p59/klqjB+afW:000000000000000000000000000000000000000007Wl2
X-Hashcash: 1:20:130109:jrnieder@gmail.com::7g4p59/klqjB+afW:00000000000000000000000000000000000000000007pni
X-Hashcash: 1:20:130109:rene.scharfe@lsrfire.ath.cx::7g4p59/klqjB+afW:0000000000000000000000000000000000DUhI
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213022>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> The test fails for me on NetBSD 6.0.1 and reports:
>
> 	ok 1 - ref name '' is invalid
> 	ok 2 - ref name '/' is invalid
> 	ok 3 - ref name '/' is invalid with options --allow-onelevel
> 	ok 4 - ref name '/' is invalid with options --normalize
> 	error: bug in the test script: not 2 or 3 parameters to test-expect-succ=
ess
>
> The alleged bug is in this line:
>
> 	invalid_ref NOT_MINGW '/' '--allow-onelevel --normalize'

The bug in NetBSD's sh has been fixed in -current:

  http://gnats.netbsd.org/47361

and the change will almost certainly make it to the -6 and -5 release
branches.

With the fixed sh:
  414c78c (with the workaround): t1402 passes
  69637e5 (without the workaround): t1402 passes

With the buggy sh,
  414c78c (with the workaround): t1402 passes
  69637e5 (without workaround): t1402 fails

so I can confirm that the workaround is successful on NetBSD 5.

Thanks for addressing this, and sorry I didn't mention it on this list.

Greg



--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iEYEARECAAYFAlDs0PoACgkQ+vesoDJhHiWg9QCghCymNfB1hyMO4/xGzdQcZ0cZ
7MQAn3hvRb6Mcxf7GlVsfCaYxQA8HIq9
=VO1A
-----END PGP SIGNATURE-----
--=-=-=--
