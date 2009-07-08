From: "Andre Mostert" <Andre.Mostert@intecbilling.com>
Subject: RE: git svn fetch fails with Temp file with moniker 'svn_delta'already in use
Date: Wed, 8 Jul 2009 14:18:33 +0200
Message-ID: <B4BD8C6031F4EC4DAD8EABAB3ABA6CFE025132AF@IBCPTEX01.intecbilling.com>
References: <B4BD8C6031F4EC4DAD8EABAB3ABA6CFE024DD5C1@IBCPTEX01.intecbilling.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, "Marcus Griep" <marcus@griep.us>
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jul 08 14:19:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOW7c-0000FM-TY
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 14:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551AbZGHMTF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2009 08:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753005AbZGHMTC
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 08:19:02 -0400
Received: from gateway.cpt.intecbilling.com ([196.30.79.194]:50642 "HELO
	gateway.cpt.intecbilling.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753946AbZGHMTA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Jul 2009 08:19:00 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <B4BD8C6031F4EC4DAD8EABAB3ABA6CFE024DD5C1@IBCPTEX01.intecbilling.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git svn fetch fails with Temp file with moniker 'svn_delta'already in use
Thread-Index: Acn/SZWYbuPxJGeORiWRJh6RsGRJ6AAVUQWgAAd9Y3A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122896>


It seems to be limited to http or https transports, as it worked OK wit=
h same repositories when accessed over svn.

I don't think it's anything in the repo, I get this with just about any=
 repository over http or https.=20

I've tried with a public repo, and I'm getting the below stacktrace now=
 - where previously I didn't get the glibc error.  The stacktrace seems=
 similar to the one from the link you've sent.

--Andr=E9



$ git svn clone --stdlayout https://celestia.svn.sourceforge.net/svnroo=
t/celestia=20
Initialized empty Git repository in /home/andre/tmp/celestia/.git/
r1 =3D 7c0af4a3c6ec64249a3e03aec7bd0e65acf4e247 (trunk)
	A	CVSROOT/cvswrappers
	A	CVSROOT/checkoutlist
	A	CVSROOT/editinfo
	A	CVSROOT/rcsinfo
	A	CVSROOT/commitinfo
	A	CVSROOT/config
	A	CVSROOT/taginfo
	A	CVSROOT/modules
	A	CVSROOT/notify
	A	CVSROOT/verifymsg
r2 =3D e942d8f29831d9f3449e142f54b94bb6d9e44732 (trunk)
	A	CVSROOT/loginfo
r3 =3D 8603ed14dc41c71996403d98377fdf0d5eade0f2 (trunk)
	A	celestia/src/trilist.h
	A	celestia/src/rng.h
	A	celestia/src/resmanager.h
	A	celestia/src/stellarclass.h
Temp file with moniker 'svn_delta' already in use at /usr/lib/perl5/sit=
e_perl/5.10.0/Git.pm line 1022.

*** glibc detected *** /usr/bin/perl: double free or corruption (!prev)=
: 0x0000000001b9f740 ***
=3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D
/lib/libc.so.6[0x7fd7f6fc2a58]
/lib/libc.so.6(cfree+0x76)[0x7fd7f6fc50a6]
/usr/local/apr/lib/libapr-1.so.0(apr_allocator_destroy+0x1d)[0x7fd7f450=
794d]
/usr/local/apr/lib/libapr-1.so.0(apr_pool_terminate+0x34)[0x7fd7f450849=
4]
/usr/lib/perl5/site_perl/5.10.0/x86_64-linux/auto/SVN/_Core/_Core.so(_w=
rap_apr_terminate+0x53)[0x7fd7f5eb19a3]
/usr/bin/perl(Perl_pp_entersub+0x56a)[0x46663a]
/usr/bin/perl(Perl_runops_standard+0x12)[0x4649e2]
/usr/bin/perl(Perl_call_sv+0x454)[0x4624e4]
/usr/bin/perl(Perl_call_list+0x277)[0x462897]
/usr/bin/perl(perl_destruct+0xe8f)[0x46422f]
/usr/bin/perl(main+0x8e)[0x41f66e]
/lib/libc.so.6(__libc_start_main+0xe6)[0x7fd7f6f67466]
/usr/bin/perl[0x41f519]
=3D=3D=3D=3D=3D=3D=3D Memory map: =3D=3D=3D=3D=3D=3D=3D=3D
00400000-00535000 r-xp 00000000 08:03 1785934                          =
  /usr/bin/perl
00734000-00735000 r--p 00134000 08:03 1785934                          =
  /usr/bin/perl
00735000-00739000 rw-p 00135000 08:03 1785934                          =
  /usr/bin/perl
00f3a000-01c8c000 rw-p 00f3a000 00:00 0                                =
  [heap]
7fd7ec000000-7fd7ec021000 rw-p 7fd7ec000000 00:00 0=20
7fd7ec021000-7fd7f0000000 ---p 7fd7ec021000 00:00 0=20
7fd7f1896000-7fd7f18ac000 r-xp 00000000 08:03 2435468                  =
  /lib/libgcc_s.so.1
7fd7f18ac000-7fd7f1aac000 ---p 00016000 08:03 2435468                  =
  /lib/libgcc_s.so.1
7fd7f1aac000-7fd7f1aad000 r--p 00016000 08:03 2435468                  =
  /lib/libgcc_s.so.1
7fd7f1aad000-7fd7f1aae000 rw-p 00017000 08:03 2435468                  =
  /lib/libgcc_s.so.1
7fd7f1aae000-7fd7f1ac0000 r-xp 00000000 08:03 1467634                  =
  /lib/libresolv-2.8.90.so
7fd7f1ac0000-7fd7f1cbf000 ---p 00012000 08:03 1467634                  =
  /lib/libresolv-2.8.90.so
7fd7f1cbf000-7fd7f1cc0000 r--p 00011000 08:03 1467634                  =
  /lib/libresolv-2.8.90.so
7fd7f1cc0000-7fd7f1cc1000 rw-p 00012000 08:03 1467634                  =
  /lib/libresolv-2.8.90.so
7fd7f1cc1000-7fd7f1cc3000 rw-p 7fd7f1cc1000 00:00 0=20
7fd7f1cc3000-7fd7f1cc7000 r-xp 00000000 08:03 1467627                  =
  /lib/libnss_dns-2.8.90.so
7fd7f1cc7000-7fd7f1ec7000 ---p 00004000 08:03 1467627                  =
  /lib/libnss_dns-2.8.90.so
7fd7f1ec7000-7fd7f1ec8000 r--p 00004000 08:03 1467627                  =
  /lib/libnss_dns-2.8.90.so
7fd7f1ec8000-7fd7f1ec9000 rw-p 00005000 08:03 1467627                  =
  /lib/libnss_dns-2.8.90.so
7fd7f1ec9000-7fd7f1ecb000 r-xp 00000000 08:03 696415                   =
  /lib/libnss_mdns4_minimal.so.2
7fd7f1ecb000-7fd7f20ca000 ---p 00002000 08:03 696415                   =
  /lib/libnss_mdns4_minimal.so.2
7fd7f20ca000-7fd7f20cb000 rw-p 00001000 08:03 696415                   =
  /lib/libnss_mdns4_minimal.so.2
7fd7f20cb000-7fd7f20d6000 r-xp 00000000 08:03 1467628                  =
  /lib/libnss_files-2.8.90.so
7fd7f20d6000-7fd7f22d5000 ---p 0000b000 08:03 1467628                  =
  /lib/libnss_files-2.8.90.so
7fd7f22d5000-7fd7f22d6000 r--p 0000a000 08:03 1467628                  =
  /lib/libnss_files-2.8.90.so
7fd7f22d6000-7fd7f22d7000 rw-p 0000b000 08:03 1467628                  =
  /lib/libnss_files-2.8.90.so
7fd7f22d7000-7fd7f22f9000 r-xp 00000000 08:03 2032454                  =
  /usr/lib/perl5/site_perl/5.10.0/x86_64-linux/auto/SVN/_Delta/_Delta.s=
o
7fd7f22f9000-7fd7f24f9000 ---p 00022000 08:03 2032454                  =
  /usr/lib/perl5/site_perl/5.10.0/x86_64-linux/auto/SVN/_Delta/_Delta.s=
o
7fd7f24f9000-7fd7f24fa000 r--p 00022000 08:03 2032454                  =
  /usr/lib/perl5/site_perl/5.10.0/x86_64-linux/auto/SVN/_Delta/_Delta.s=
o
7fd7f24fa000-7fd7f24fe000 rw-p 00023000 08:03 2032454                  =
  /usr/lib/perl5/site_perl/5.10.0/x86_64-linux/auto/SVN/_Delta/_Delta.s=
o
7fd7f24fe000-7fd7f257b000 r-xp 00000000 08:03 2015474                  =
  /usr/lib/perl5/site_perl/5.10.0/x86_64-linux/auto/SVN/_Client/_Client=
=2Eso
7fd7f257b000-7fd7f277b000 ---p 0007d000 08:03 2015474                  =
  /usr/lib/perl5/site_perl/5.10.0/x86_64-linux/auto/SVN/_Client/_Client=
=2Eso
7fd7f277b000-7fd7f277d000 r--p 0007d000 08:03 2015474                  =
  /usr/lib/perl5/site_perl/5.10.0/x86_64-linux/auto/SVN/_Client/_Client=
=2Eso
7fd7f277d000-7fd7f2783000 rw-p 0007f000 08:03 2015474                  =
  /usr/lib/perl5/site_perl/5.10.0/x86_64-linux/auto/SVN/_Client/_Client=
=2Eso
7fd7f2783000-7fd7f280c000 r-xp 00000000 08:03 1999050                  =
  /usr/lib/perl5/site_perl/5.10.0/x86_64-linux/auto/SVN/_Wc/_Wc.so
7fd7f280c000-7fd7f2a0c000 ---p 00089000 08:03 1999050                  =
  /usr/lib/perl5/site_perl/5.10.0/x86_64-linux/auto/SVN/_Wc/_Wc.so
7fd7f2a0c000-7fd7f2a0e000 r--p 00089000 08:03 1999050                  =
  /usr/lib/perl5/site_perl/5.10.0/x86_64-linux/auto/SVN/_Wc/_Wc.so
7fd7f2a0e000-7fd7f2a13000 rw-p 0008b000 08:03 1999050                  =
  /usr/lib/perl5/site_perl/5.10.0/x86_64-linux/auto/SVN/_Wc/_Wc.so
7fd7f2a13000-7fd7f2a14000 rw-p 7fd7f2a13000 00:00 0=20
7fd7f2a14000-7fd7f2a5f000 r-xp 00000000 08:03 2048584                  =
  /usr/lib/perl5/site_perl/5.10.0/x86_64-linux/auto/SVN/_Ra/_Ra.so
7fd7f2a5f000-7fd7f2c5e000 ---p 0004b000 08:03 2048584                  =
  /usr/lib/perl5/site_perl/5.10.0/x86_64-linux/auto/SVN/_Ra/_Ra.so
7fd7f2c5e000-7fd7f2c60000 r--p 0004a000 08:03 2048584                  =
  /usr/lib/perl5/site_perl/5.10.0/x86_64-linux/auto/SVN/_Ra/_Ra.so
7fd7f2c60000-7fd7f2c65000 rw-p 0004c000 08:03 2048584                  =
  /usr/lib/perl5/site_perl/5.10.0/x86_64-linux/auto/SVN/_Ra/_Ra.so
7fd7f2c65000-7fd7f2dc8000 r-xp 00000000 08:03 1786340                  =
  /usr/lib/libcrypto.so.0.9.8
7fd7f2dc8000-7fd7f2fc7000 ---p 00163000 08:03 1786340                  =
  /usr/lib/libcrypto.so.0.9.8
7fd7f2fc7000-7fd7f2fd4000 r--p 00162000 08:03 1786340                  =
  /usr/lib/libcrypto.so.0.9.8
7fd7f2fd4000-7fd7f2fea000 rw-p 0016f000 08:03 1786340                  =
  /usr/lib/libcrypto.so.0.9.8
7fd7f2fea000-7fd7f2fee000 rw-p 7fd7f2fea000 00:00 0=20
7fd7f2fee000-7fd7f3037000 r-xp 00000000 08:03 1352487                  =
  /usr/lib/libssl.so.0.9.8
7fd7f3037000-7fd7f3237000 ---p 00049000 08:03 1352487                  =
  /usr/lib/libssl.so.0.9.8
7fd7f3237000-7fd7f3238000 r--p 00049000 08:03 1352487                  =
  /usr/lib/libssl.so.0.9.8
7fd7f3238000-7fd7f323d000 rw-p 0004a000 08:03 1352487                  =
  /usr/lib/libssl.so.0.9.8
7fd7f323d000-7fd7f324c000 r-xp 00000000 08:03 1376910                  =
  /usr/local/serf/lib/libserf-0.so.0.0.0
7fd7f324c000-7fd7f344c000 ---p 0000f000 08:03 1376910                  =
  /usr/local/serf/lib/libserf-0.so.0.0.0
7fd7f344c000-7fd7f344d000 r--p 0000f000 08:03 1376910                  =
  /usr/local/serf/lib/libserf-0.so.0.0.0
7fd7f344d000-7fd7f344e000 rw-p 00010000 08:03 1376910                  =
  /usr/local/serf/lib/libserf-0.so.0.0.0
7fd7f344e000-7fd7f346f000 r-xp 00000000 08:03 1524606                  =
  /usr/local/lib/libsvn_ra_serf-1.so.0.0.0
7fd7f346f000-7fd7f366f000 ---p 00021000 08:03 1524606                  =
  /usr/local/lib/libsvn_ra_serf-1.so.0.0.0
7fd7f366f000-7fd7f3670000 r--p 00021000 08:03 1524606                  =
  /usr/local/lib/libsvn_ra_serf-1.so.0.0.0
7fd7f3670000-7fd7f3671000 rw-p 00022000 08:03 1524606                  =
  /usr/local/lib/libsvn_ra_serf-1.so.0.0.0
7fd7f3671000-7fd7f3685000 r-xp 00000000 08:03 1524591                  =
  /usr/local/lib/libsvn_ra_svn-1.so.0.0.0
7fd7f3685000-7fd7f3884000 ---p 00014000 08:03 1524591                  =
  /usr/local/lib/libsvn_ra_svn-1.so.0.0.0
7fd7f3884000-7fd7f3885000 r--p 00013000 08:03 1524591                  =
  /usr/local/lib/libsvn_ra_svn-1.so.0.0.0
7fd7f3885000-7fd7f3886000 rw-p 00014000 08:03 1524591                  =
  /usr/local/lib/libsvn_ra_svn-1.so.0.0.0
7fd7f3886000-7fd7f388d000 r-xp 00000000 08:03 1524601                  =
  /usr/local/lib/libsvn_ra_local-1.so.0.0.0
7fd7f388d000-7fd7f3a8d000 ---p 00007000 08:03 1524601                  =
  /usr/local/lib/libsvn_ra_local-1.so.0.0.0
7fd7f3a8d000-7fd7f3a8e000 r--p 00007000 08:03 1524601                  =
  /usr/local/lib/libsvn_ra_local-1.so.0.0.0
7fd7f3a8e000-7fd7f3a8f000 rw-p 00008000 08:03 1524601                  =
  /usr/local/lib/libsvn_ra_local-1.so.0.0.0
7fd7f3a8f000-7fd7f3a90000 r-xp 00000000 08:03 1524576                  =
  /usr/local/lib/libsvn_fs_util-1.so.0.0.0
7fd7f3a90000-7fd7f3c8f000 ---p 00001000 08:03 1524576                  =
  /usr/local/lib/libsvn_fs_util-1.so.0.0.0
7fd7f3c8f000-7fd7f3c90000 r--p 00000000 08:03 1524576                  =
  /usr/local/lib/libsvn_fs_util-1.so.0.0.0
7fd7f3c90000-7fd7f3c91000 rw-p 00001000 08:03 1524576                  =
  /usr/local/lib/libsvn_fs_util-1.so.0.0.0
7fd7f3c91000-7fd7f3cb2000 r-xp 00000000 08:03 1524581                  =
  /usr/local/lib/libsvn_fs_fs-1.so.0.0.0
7fd7f3cb2000-7fd7f3eb1000 ---p 00021000 08:03 1524581                  =
  /usr/local/lib/libsvn_fs_fs-1.so.0.0.0
7fd7f3eb1000-7fd7f3eb2000 r--p 00020000 08:03 1524581                  =
  /usr/local/lib/libsvn_fs_fs-1.so.0.0.0
fatal: unable to run 'git-svn'


> -----Original Message-----
> From: git-owner@vger.kernel.org=20
> [mailto:git-owner@vger.kernel.org] On Behalf Of Andre Mostert
> Sent: 08 July 2009 09:53 AM
> To: Eric Wong
> Cc: git@vger.kernel.org; Marcus Griep
> Subject: RE: git svn fetch fails with Temp file with moniker=20
> 'svn_delta'already in use
>=20
>=20
> =20
> Hi Eric
>=20
> I'm getting the same thing with a several internal repositories.=20
>=20
> It will happen almost immediately if I try to clone any one of them.=20
>=20
> I also have some existing clones created using earlier=20
> versions of git & svn. When fetching on an existing clone it=20
> usually works, until it fails. When it fails, it will keep on=20
> failing on attempting to fetch the same commit. I then tried=20
> to run "strace -f git svn fetch" to see if that will show=20
> anything helpful, but then it worked! So my guess is it could=20
> be some race condition?
>=20
> This is on Ubuntu 8.10 on x86_64 with libc-2.8.90.
>=20
> Git 1.6.3.3, perl 5.10.0 and svn 1.5.1 have all been built=20
> from official sources with mostly default options.
>=20
> I'll check if I can reproduce it with some public repos as well.
>=20


Thanks
--Andr=E9
