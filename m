From: Martin Waitz <tali@admingilde.org>
Subject: non-monotonic index when using http://?
Date: Mon, 21 Aug 2006 10:46:06 +0200
Message-ID: <20060821084606.GI30022@admingilde.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="it/zdz3K1bH9Y8/E"
X-From: git-owner@vger.kernel.org Mon Aug 21 10:46:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GF5Qb-0007zW-3O
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 10:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbWHUIqJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 04:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbWHUIqJ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 04:46:09 -0400
Received: from agent.admingilde.org ([213.95.21.5]:45224 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S965062AbWHUIqI
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 04:46:08 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GF5Q6-0006yw-My
	for git@vger.kernel.org; Mon, 21 Aug 2006 10:46:06 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25788>


--it/zdz3K1bH9Y8/E
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

At work I'm getting the following error message, any ideas?

> git --version
git version 1.4.2.rc4.g242a
> git pull upstream
Fetching refs/heads/master from http://git.kernel.org/pub/scm/git/git.git u=
sing http
error: non-monotonic index
walk 43134fcb350fb70d26634be163db1f71c14db19f
walk 55c3eb434ab6d489c632263239be15a1054df7f2
Getting alternates list for http://git.kernel.org/pub/scm/git/git.git/
Getting pack list for http://git.kernel.org/pub/scm/git/git.git/
error: non-monotonic index
/home/tcmc_mwz/i686/bin/git-fetch: line 402:  2077 Segmentation fault
git-http-fetch -v -a "$head" "$remote/"
zsh: exit 1     git pull upstream
> gdb git-http-fetch
GNU gdb Red Hat Linux (6.3.0.0-1.132.EL3rh)
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain condition=
s.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-redhat-linux-gnu"...Using host libthread_d=
b library "/lib/tls/libthread_db.so.1".
=20
(gdb) run -v -a 43134fcb350fb70d26634be163db1f71c14db19f http://git.kernel.=
org/pub/scm/git/git.git/
Starting program: /autohome/tcmc_mwz/src/git/git-http-fetch -v -a 43134fcb3=
50fb70d26634be163db1f71c14db19f http://git.kernel.org/pub/scm/git/git.git/
error: non-monotonic index
walk 43134fcb350fb70d26634be163db1f71c14db19f
walk 55c3eb434ab6d489c632263239be15a1054df7f2
Getting alternates list for http://git.kernel.org/pub/scm/git/git.git/
Getting pack list for http://git.kernel.org/pub/scm/git/git.git/
error: non-monotonic index
=20
Program received signal SIGSEGV, Segmentation fault.
0x0804c1e2 in setup_index (repo=3D0x991a058,
    sha1=3D0xbfffa420 "y:\236\223(mleiA\227}.[I=EF=BF=BF\205f=EF=BF=BF=EF=
=BF=BF") at http-fetch.c:501
501             new_pack->next =3D repo->packs;
(gdb) bt
#0  0x0804c1e2 in setup_index (repo=3D0x991a058,
    sha1=3D0xbfffa420 "y:\236\223(mleiA\227}.[I=EF=BF=BF\205f=EF=BF=BF=EF=
=BF=BF") at http-fetch.c:501
#1  0x0804d17c in fetch_indices (repo=3D0x991a058) at http-fetch.c:946
#2  0x0804d217 in fetch_pack (repo=3D0x991a058,
    sha1=3D0x994eb9c "U=EF=BF=BF\230D=EF=BF=BF\036 &p\aih=EF=BF=BF\r=EF=BF=
=BF\017=EF=BF=BFhs.=EF=BF=BF") at http-fetch.c:978
#3  0x0804d7f6 in fetch (sha1=3D0x994eb9c "U=EF=BF=BF\230D=EF=BF=BF\036 &p\=
aih=EF=BF=BF\r=EF=BF=BF\017=EF=BF=BFhs.=EF=BF=BF")
    at http-fetch.c:1130
#4  0x0804a414 in loop () at fetch.c:179
#5  0x0804a77b in pull (targets=3D1, target=3D0xbfffb600, write_ref=3D0x0,
    write_ref_log_details=3D0xbfffd3b9 "http://git.kernel.org/pub/scm/git/g=
it.git/") at fetch.c:288
#6  0x0804dbd7 in main (argc=3D5, argv=3D0xbfffb5f4) at http-fetch.c:1282

--=20
Martin Waitz

--it/zdz3K1bH9Y8/E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFE6XLOj/Eaxd/oD7IRAgScAJwNUqrgIFgbO0s/Ap/n7FgKhNPYBgCeOQ0l
uDeBOxSEbC1vbTqQpGFgEys=
=A80W
-----END PGP SIGNATURE-----

--it/zdz3K1bH9Y8/E--
