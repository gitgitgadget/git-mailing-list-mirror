From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] Simplify calling of CR/LF conversion routines
Date: Sun, 22 Apr 2007 15:45:06 +0200
Message-ID: <20070422134505.GF27208@admingilde.org>
References: <20070418222827.GB2477@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X3gaHHMYHkYqP6yf"
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 22 15:45:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfcNk-0004X8-RC
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 15:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030876AbXDVNpK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 09:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030878AbXDVNpK
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 09:45:10 -0400
Received: from mail.admingilde.org ([213.95.32.147]:57570 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030876AbXDVNpI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 09:45:08 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HfcNG-0001rt-5d; Sun, 22 Apr 2007 15:45:06 +0200
Content-Disposition: inline
In-Reply-To: <20070418222827.GB2477@steel.home>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45239>


--X3gaHHMYHkYqP6yf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

For me (on glibc-2.5) the testsuite fails in t0020-crlf.sh, test 14:

*** glibc detected *** git: free(): invalid next size (fast): 0x081097b8 ***
=3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D
/lib/i686/cmov/libc.so.6[0x401ed843]
/lib/i686/cmov/libc.so.6(__libc_free+0x90)[0x401f0d00]
git[0x8096f66]
git[0x808ca97]
git[0x808cf52]
git[0x80715b2]
git[0x804a957]
git[0x804adac]
/lib/i686/cmov/libc.so.6(__libc_start_main+0xd8)[0x4019b878]
git[0x804a6d1]
=3D=3D=3D=3D=3D=3D=3D Memory map: =3D=3D=3D=3D=3D=3D=3D=3D
08048000-080ca000 r-xp 00000000 fe:03 856305     /home/martin/src/git/git
080ca000-080cc000 rw-p 00082000 fe:03 856305     /home/martin/src/git/git
080cc000-0812a000 rw-p 080cc000 00:00 0          [heap]
40000000-4001c000 r-xp 00000000 fe:05 1505       /lib/ld-2.5.so
4001c000-4001e000 rw-p 0001b000 fe:05 1505       /lib/ld-2.5.so
4001e000-4001f000 r-xp 4001e000 00:00 0          [vdso]
4001f000-40021000 rw-p 4001f000 00:00 0
40021000-40022000 rw-p 00000000 fe:03 902199     /home/martin/src/git/t/tra=
sh/.git/index
40022000-4002c000 r-xp 00000000 fe:05 2937       /lib/libgcc_s.so.1
4002c000-4002d000 rw-p 00009000 fe:05 2937       /lib/libgcc_s.so.1
40035000-40048000 r-xp 00000000 fe:09 98501      /usr/lib/libz.so.1.2.3
40048000-40049000 rw-p 00012000 fe:09 98501      /usr/lib/libz.so.1.2.3
40049000-4016d000 r-xp 00000000 fe:09 114802     /usr/lib/i686/cmov/libcryp=
to.so.0.9.8
4016d000-40181000 rw-p 00123000 fe:09 114802     /usr/lib/i686/cmov/libcryp=
to.so.0.9.8
40181000-40186000 rw-p 40181000 00:00 0
40186000-402c1000 r-xp 00000000 fe:05 1983       /lib/i686/cmov/libc-2.5.so
402c1000-402c2000 r--p 0013b000 fe:05 1983       /lib/i686/cmov/libc-2.5.so
402c2000-402c4000 rw-p 0013c000 fe:05 1983       /lib/i686/cmov/libc-2.5.so
402c4000-402c7000 rw-p 402c4000 00:00 0
402c7000-402c9000 r-xp 00000000 fe:05 2194       /lib/i686/cmov/libdl-2.5.so
402c9000-402cb000 rw-p 00001000 fe:05 2194       /lib/i686/cmov/libdl-2.5.so
402cb000-402cc000 rw-p 402cb000 00:00 0
40300000-40321000 rw-p 40300000 00:00 0
40321000-40400000 ---p 40321000 00:00 0
bff3f000-bff54000 rw-p bff3f000 00:00 0          [stack]
* FAIL 14: .gitattributes says two and three are text


bisecting points to ac78e548, but I can't see any obvious problem with
this commit.
Do you have any idea?

--=20
Martin Waitz

--X3gaHHMYHkYqP6yf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGK2bhj/Eaxd/oD7IRAu7PAJ9RiWyTLp1seED69vxfQVNTOmo5kACbBGGA
2nnNqGvtK9/MvbYWcitxymY=
=hy/D
-----END PGP SIGNATURE-----

--X3gaHHMYHkYqP6yf--
