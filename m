From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: What's cooking in git.git (Feb 2011, #05; Wed, 23)
Date: Sat, 26 Feb 2011 22:07:41 +0300
Organization: Marine Bridge & Navigation Systems
Message-ID: <20110226190741.GA24914@tugrik.mns.mnsspb.ru>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org> <AANLkTinUtqJJHNyS9CxrC=VnS87v=GH=pOw9yr4r=pii@mail.gmail.com> <AANLkTimWy+W+rcZHsac_n--y9iMeaoO66CPZVbN1VBp2@mail.gmail.com> <20110225090544.GA3783@tugrik.mns.mnsspb.ru> <alpine.DEB.1.00.1102251208380.1561@bonsai2> <20110225192455.GA7130@tugrik.mns.mnsspb.ru> <alpine.DEB.1.00.1102252251140.15247@pacific.mpi-cbg.de> <20110226110740.GA3096@tugrik.mns.mnsspb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 26 20:06:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtPTj-0006Rd-Iz
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 20:06:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576Ab1BZTGl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Feb 2011 14:06:41 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:44962 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752477Ab1BZTGj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 14:06:39 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1PtPTQ-0005Ru-LA; Sat, 26 Feb 2011 22:06:36 +0300
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1PtPUT-0006Xo-6m; Sat, 26 Feb 2011 22:07:41 +0300
Content-Disposition: inline
In-Reply-To: <20110226110740.GA3096@tugrik.mns.mnsspb.ru>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167990>

On Sat, Feb 26, 2011 at 02:07:40PM +0300, Kirill Smelkov wrote:
> Hi,
>=20
> On Fri, Feb 25, 2011 at 10:54:40PM +0100, Johannes Schindelin wrote:
> > > > And lastly, in [2] you claim that you cross-built msys-1.0.dll.=
 I=20
> > > > would like to have a script doing that in msysgit.git.
> > >=20
> > > This is in progress. Preliminary stuff (cross-built msys.dll no l=
onger needs
> > > mingwm10.dll), is here:
> > >=20
> > > http://repo.or.cz/w/msys/kirr.git/shortlog/refs/heads/x/kirr
> > > http://repo.or.cz/w/msysgit/kirr.git/shortlog/refs/heads/ks/cross=
msys
> >=20
> > Thanks, I will try to find some time to test this next week.
>=20
> Please don't - it does not build out of the box from msysgit yet. I j=
ust
> wanted to show it is not staying stale. When it is finished, I'll let
> you know.

Done. Please do

    git pull git://repo.or.cz/msysgit/kirr.git ks/crossmsys     # into =
msys


to receive the following updates:

Kirill Smelkov (3):
      msys: My patches to fix cross-compilation of msys.dll
      src/rt/release.sh: Move under-msys specific code into it's own fu=
nction
      src/rt/release.sh: Teach it to cross-compile msys.dll on linux


Thanks beforehand,
Kirill


[ Diffstat and cumulative patch also follow: ]


 .../0012-newlib-Fix-build-in-ctype_.c.patch        |   43 +++++
 ...p-cygwin-wsock_started-should-be-extern-C.patch |   33 ++++
 ...nsup-cygwin-reent_data-should-be-extern-C.patch |   33 ++++
 ...in-_sys_errlist-and-_sys_nerr-should-have.patch |   42 +++++
 ...in-Don-t-use-non-lvalue-assignment-in-cyg.patch |   36 ++++
 ...in-Don-t-use-non-lvalue-assgnment-in-dcrt.patch |   47 +++++
 ...cygwin-struct-LUID-has-no-member-QuadPart.patch |   39 +++++
 ...in-Fix-asm-constraint-for-_impure_ptr-err.patch |   38 ++++
 ...in-Add-volatile-qualifier-to-ilock-in-win.patch |   70 ++++++++
 ...in-call_signal_handler_now-alias-keeping-.patch |   48 +++++
 ...in-std_dll_init-and-wsock_init-should-not.patch |   60 +++++++
 ...-cygwin-Build-with-fno-threadsafe-statics.patch |   45 +++++
 ...24-winsup-cygwin-Avoid-libstdc-dependency.patch |  103 +++++++++++
 ...in-Strip-new-msys-1.0.dll-when-cross-comp.patch |   94 ++++++++++
 ...in-cygrun.exe-build-depends-on-libmsys-1..patch |   32 ++++
 ...in-cyrun.exe-should-be-built-with-nostdli.patch |   53 ++++++
 src/rt/release.sh                                  |  180 ++++++++++++=
+++++---
 17 files changed, 974 insertions(+), 22 deletions(-)
 create mode 100644 src/rt/patches/0012-newlib-Fix-build-in-ctype_.c.pa=
tch
 create mode 100644 src/rt/patches/0013-winsup-cygwin-wsock_started-sho=
uld-be-extern-C.patch
 create mode 100644 src/rt/patches/0014-winsup-cygwin-reent_data-should=
-be-extern-C.patch
 create mode 100644 src/rt/patches/0015-winsup-cygwin-_sys_errlist-and-=
_sys_nerr-should-have.patch
 create mode 100644 src/rt/patches/0016-winsup-cygwin-Don-t-use-non-lva=
lue-assignment-in-cyg.patch
 create mode 100644 src/rt/patches/0017-winsup-cygwin-Don-t-use-non-lva=
lue-assgnment-in-dcrt.patch
 create mode 100644 src/rt/patches/0018-winsup-cygwin-struct-LUID-has-n=
o-member-QuadPart.patch
 create mode 100644 src/rt/patches/0019-winsup-cygwin-Fix-asm-constrain=
t-for-_impure_ptr-err.patch
 create mode 100644 src/rt/patches/0020-winsup-cygwin-Add-volatile-qual=
ifier-to-ilock-in-win.patch
 create mode 100644 src/rt/patches/0021-winsup-cygwin-call_signal_handl=
er_now-alias-keeping-.patch
 create mode 100644 src/rt/patches/0022-winsup-cygwin-std_dll_init-and-=
wsock_init-should-not.patch
 create mode 100644 src/rt/patches/0023-winsup-cygwin-Build-with-fno-th=
readsafe-statics.patch
 create mode 100644 src/rt/patches/0024-winsup-cygwin-Avoid-libstdc-dep=
endency.patch
 create mode 100644 src/rt/patches/0025-winsup-cygwin-Strip-new-msys-1.=
0.dll-when-cross-comp.patch
 create mode 100644 src/rt/patches/0026-winsup-cygwin-cygrun.exe-build-=
depends-on-libmsys-1..patch
 create mode 100644 src/rt/patches/0027-winsup-cygwin-cyrun.exe-should-=
be-built-with-nostdli.patch



diff --git a/src/rt/patches/0012-newlib-Fix-build-in-ctype_.c.patch b/s=
rc/rt/patches/0012-newlib-Fix-build-in-ctype_.c.patch
new file mode 100644
index 0000000..77fb1e0
--- /dev/null
+++ b/src/rt/patches/0012-newlib-Fix-build-in-ctype_.c.patch
@@ -0,0 +1,43 @@
+From 39dade0de1e56cb226a77cc3d9ab67c529895db6 Mon Sep 17 00:00:00 2001
+From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
+Date: Sun, 13 Feb 2011 00:53:32 +0300
+Subject: [PATCH] newlib: Fix build in ctype_.c
+MIME-Version: 1.0
+Content-Type: text/plain; charset=3DUTF-8
+Content-Transfer-Encoding: 8bit
+
+    objs/../libc/ctype/ctype_.c:88: error: =E2=80=98_ctype_=E2=80=99 a=
liased to undefined symbol =E2=80=98_ctype_b+127=E2=80=99
+
+gcc4 refuses to take expression as alias target:
+
+    http://www.mail-archive.com/gcc%40gcc.gnu.org/msg01613.html
+
+So've cherry-hand-picked related patch by Cygwin's Corinna Vinschen
+<vinschen@redhat.com> from here:
+
+    http://cygwin.com/ml/newlib/2005/msg00189.html
+
+Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
+---
+ msys/rt/src/newlib/libc/ctype/ctype_.c |    5 ++++-
+ 1 files changed, 4 insertions(+), 1 deletions(-)
+
+diff --git a/msys/rt/src/newlib/libc/ctype/ctype_.c b/msys/rt/src/newl=
ib/libc/ctype/ctype_.c
+index 54f92d9..863ec60 100644
+--- a/msys/rt/src/newlib/libc/ctype/ctype_.c
++++ b/msys/rt/src/newlib/libc/ctype/ctype_.c
+@@ -85,7 +85,10 @@ static _CONST char _ctype_b[128 + 256] =3D {
+ };
+=20
+ #if defined(__CYGWIN__) || defined(__MSYS__)
+-extern _CONST char __declspec(dllexport) _ctype_[1 + 256] __attribute=
__ ((alias ("_ctype_b+127")));
++__asm__ (
++	".data \n\t"
++	".globl  __ctype_ \n\t"
++	".set    __ctype_,__ctype_b+127");
+ _CONST char __declspec(dllexport) *__ctype_ptr =3D _ctype_b + 128;
+ #else
+ extern _CONST char _ctype_[1 + 256] __attribute__ ((alias ("_ctype_b+=
127")));
+--=20
+1.7.4.1.48.g5673d
+
diff --git a/src/rt/patches/0013-winsup-cygwin-wsock_started-should-be-=
extern-C.patch b/src/rt/patches/0013-winsup-cygwin-wsock_started-should=
-be-extern-C.patch
new file mode 100644
index 0000000..a7b3870
--- /dev/null
+++ b/src/rt/patches/0013-winsup-cygwin-wsock_started-should-be-extern-=
C.patch
@@ -0,0 +1,33 @@
+From 061bbbde0f631181579c12c6fb7f7f68e7118fdc Mon Sep 17 00:00:00 2001
+From: Kirill Smelkov <kirr@mns.spb.ru>
+Date: Fri, 25 Feb 2011 18:16:30 +0300
+Subject: [PATCH] winsup/cygwin: wsock_started should be extern "C"
+MIME-Version: 1.0
+Content-Type: text/plain; charset=3DUTF-8
+Content-Transfer-Encoding: 8bit
+
+    i586-mingw32msvc-g++ -c -O2 -D__MSYS__ -MD -fbuiltin ... autoload.=
cc
+    .../winsup.h:240: error: previous declaration of =E2=80=98bool wso=
ck_started=E2=80=99 with =E2=80=98C++=E2=80=99 linkage
+    .../autoload.cc:254: error: conflicts with new declaration with =E2=
=80=98C=E2=80=99 linkage
+
+Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
+---
+ msys/rt/src/winsup/cygwin/winsup.h |    2 +-
+ 1 files changed, 1 insertions(+), 1 deletions(-)
+
+diff --git a/msys/rt/src/winsup/cygwin/winsup.h b/msys/rt/src/winsup/c=
ygwin/winsup.h
+index 162c586..ecc5f54 100644
+--- a/msys/rt/src/winsup/cygwin/winsup.h
++++ b/msys/rt/src/winsup/cygwin/winsup.h
+@@ -237,7 +237,7 @@ ssize_t check_iovec_for_write (const struct iovec =
*, int) __attribute__ ((regpar
+ #define set_winsock_errno() __set_winsock_errno (__FUNCTION__, __LINE=
__)
+ void __set_winsock_errno (const char *fn, int ln) __attribute__ ((reg=
parm(2)));
+=20
+-extern bool wsock_started;
++extern "C" bool wsock_started;
+=20
+ /* Printf type functions */
+ extern "C" void __api_fatal (const char *, ...) __attribute__ ((noret=
urn));
+--=20
+1.7.4.1.48.g5673d
+
diff --git a/src/rt/patches/0014-winsup-cygwin-reent_data-should-be-ext=
ern-C.patch b/src/rt/patches/0014-winsup-cygwin-reent_data-should-be-ex=
tern-C.patch
new file mode 100644
index 0000000..1213e59
--- /dev/null
+++ b/src/rt/patches/0014-winsup-cygwin-reent_data-should-be-extern-C.p=
atch
@@ -0,0 +1,33 @@
+From 6d8b0795ed154d975f89e9f5f8e27787af4bfcdd Mon Sep 17 00:00:00 2001
+From: Kirill Smelkov <kirr@mns.spb.ru>
+Date: Fri, 25 Feb 2011 18:19:30 +0300
+Subject: [PATCH] winsup/cygwin: reent_data should be extern "C"
+MIME-Version: 1.0
+Content-Type: text/plain; charset=3DUTF-8
+Content-Transfer-Encoding: 8bit
+
+    i586-mingw32msvc-g++ -c -O2 -D__MSYS__ -MD -fbuiltin ... dcrt0.cc
+    .../perthread.h:16: error: previous declaration of =E2=80=98_reent=
 reent_data=E2=80=99 with =E2=80=98C++=E2=80=99 linkage
+    .../dcrt0.cc:91: error: conflicts with new declaration with =E2=80=
=98C=E2=80=99 linkage
+
+Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
+---
+ msys/rt/src/winsup/cygwin/perthread.h |    2 +-
+ 1 files changed, 1 insertions(+), 1 deletions(-)
+
+diff --git a/msys/rt/src/winsup/cygwin/perthread.h b/msys/rt/src/winsu=
p/cygwin/perthread.h
+index 185cc04..738a301 100644
+--- a/msys/rt/src/winsup/cygwin/perthread.h
++++ b/msys/rt/src/winsup/cygwin/perthread.h
+@@ -13,7 +13,7 @@ details. */
+ #define PTMAGIC 0x77366377
+=20
+ struct _reent;
+-extern struct _reent reent_data;
++extern "C" struct _reent reent_data;
+=20
+ extern DWORD *__stackbase __asm__ ("%fs:4");
+=20
+--=20
+1.7.4.1.48.g5673d
+
diff --git a/src/rt/patches/0015-winsup-cygwin-_sys_errlist-and-_sys_ne=
rr-should-have.patch b/src/rt/patches/0015-winsup-cygwin-_sys_errlist-a=
nd-_sys_nerr-should-have.patch
new file mode 100644
index 0000000..cdf4009
--- /dev/null
+++ b/src/rt/patches/0015-winsup-cygwin-_sys_errlist-and-_sys_nerr-shou=
ld-have.patch
@@ -0,0 +1,42 @@
+From e608cceda43c4e7d6dd6829dd3ff1d0d6e0734e5 Mon Sep 17 00:00:00 2001
+From: Kirill Smelkov <kirr@mns.spb.ru>
+Date: Fri, 25 Feb 2011 18:22:41 +0300
+Subject: [PATCH] winsup/cygwin: _sys_errlist and _sys_nerr should have=
 external linkage
+MIME-Version: 1.0
+Content-Type: text/plain; charset=3DUTF-8
+Content-Transfer-Encoding: 8bit
+
+    i586-mingw32msvc-g++ -c -O2 -D__MSYS__ -MD -fbuiltin ... errno.cc
+    .../errno.cc:148: error: external linkage required for symbol =E2=80=
=98_sys_errlist=E2=80=99 because of =E2=80=98dllexport=E2=80=99 attribu=
te
+    .../errno.cc:290: error: external linkage required for symbol =E2=80=
=98_sys_nerr=E2=80=99 because of =E2=80=98dllexport=E2=80=99 attribute
+
+Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
+---
+ msys/rt/src/winsup/cygwin/errno.cc |    4 ++--
+ 1 files changed, 2 insertions(+), 2 deletions(-)
+
+diff --git a/msys/rt/src/winsup/cygwin/errno.cc b/msys/rt/src/winsup/c=
ygwin/errno.cc
+index 89e25ff..e4a4a81 100644
+--- a/msys/rt/src/winsup/cygwin/errno.cc
++++ b/msys/rt/src/winsup/cygwin/errno.cc
+@@ -145,7 +145,7 @@ seterrno (const char *file, int line)
+=20
+ extern char *_user_strerror _PARAMS ((int));
+=20
+-const NO_COPY char __declspec(dllexport) * const _sys_errlist[]=3D
++extern const NO_COPY char __declspec(dllexport) * const _sys_errlist[=
]=3D
+ {
+ /*      NOERROR 0       */ "No error",
+ /*	EPERM 1		*/ "Not super-user",
+@@ -287,7 +287,7 @@ const NO_COPY char __declspec(dllexport) * const _=
sys_errlist[]=3D
+ /* ECASECLASH 137 */ "Filename exists with different case"
+ };
+=20
+-int const NO_COPY __declspec(dllexport) _sys_nerr =3D
++extern int const NO_COPY __declspec(dllexport) _sys_nerr =3D
+   sizeof (_sys_errlist) / sizeof (_sys_errlist[0]);
+=20
+ /* FIXME: Why is strerror() a long switch and not just:
+--=20
+1.7.4.1.48.g5673d
+
diff --git a/src/rt/patches/0016-winsup-cygwin-Don-t-use-non-lvalue-ass=
ignment-in-cyg.patch b/src/rt/patches/0016-winsup-cygwin-Don-t-use-non-=
lvalue-assignment-in-cyg.patch
new file mode 100644
index 0000000..6ad498d
--- /dev/null
+++ b/src/rt/patches/0016-winsup-cygwin-Don-t-use-non-lvalue-assignment=
-in-cyg.patch
@@ -0,0 +1,36 @@
+From f9962a12ce9e1b47c5df8719b7b6079a91244131 Mon Sep 17 00:00:00 2001
+From: Kirill Smelkov <kirr@mns.spb.ru>
+Date: Fri, 25 Feb 2011 18:30:28 +0300
+Subject: [PATCH] winsup/cygwin: Don't use non-lvalue assignment in cyg=
heap.cc
+MIME-Version: 1.0
+Content-Type: text/plain; charset=3DUTF-8
+Content-Transfer-Encoding: 8bit
+
+There was one non-lvalue assgnment in cygheap.cc, and gcc does not
+support them for ages...
+
+    i586-mingw32msvc-g++ -c -O2 -D__MSYS__ -MD -fbuiltin ... cygheap.c=
c
+    .../cygheap.cc: In function =E2=80=98void* _csbrk(int)=E2=80=99:
+    .../cygheap.cc:169: error: lvalue required as left operand of assi=
gnment
+
+Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
+---
+ msys/rt/src/winsup/cygwin/cygheap.cc |    2 +-
+ 1 files changed, 1 insertions(+), 1 deletions(-)
+
+diff --git a/msys/rt/src/winsup/cygwin/cygheap.cc b/msys/rt/src/winsup=
/cygwin/cygheap.cc
+index ac4d8fa..bdb93cc 100644
+--- a/msys/rt/src/winsup/cygwin/cygheap.cc
++++ b/msys/rt/src/winsup/cygwin/cygheap.cc
+@@ -166,7 +166,7 @@ _csbrk (int sbs)
+     }
+=20
+   lastheap =3D cygheap_max;
+-  (char *) cygheap_max +=3D sbs;
++  cygheap_max =3D ((char *)cygheap_max) + sbs;
+   void *heapalign =3D (void *) pagetrunc (lastheap);
+=20
+   if (!needalloc)
+--=20
+1.7.4.1.48.g5673d
+
diff --git a/src/rt/patches/0017-winsup-cygwin-Don-t-use-non-lvalue-ass=
gnment-in-dcrt.patch b/src/rt/patches/0017-winsup-cygwin-Don-t-use-non-=
lvalue-assgnment-in-dcrt.patch
new file mode 100644
index 0000000..45990bf
--- /dev/null
+++ b/src/rt/patches/0017-winsup-cygwin-Don-t-use-non-lvalue-assgnment-=
in-dcrt.patch
@@ -0,0 +1,47 @@
+From 1448ec5e2ec6999122a60fd3f97c2ca89f660a4c Mon Sep 17 00:00:00 2001
+From: Kirill Smelkov <kirr@mns.spb.ru>
+Date: Fri, 25 Feb 2011 18:51:20 +0300
+Subject: [PATCH] winsup/cygwin: Don't use non-lvalue assgnment in dcrt=
0.cc
+MIME-Version: 1.0
+Content-Type: text/plain; charset=3DUTF-8
+Content-Transfer-Encoding: 8bit
+
+fork_info is defined as
+
+    # define fork_info ((struct child_info_fork *)(si.lpReserved2))
+
+so statement like
+
+    fork_info =3D NULL;
+
+is non-lvalue assgnment:
+
+    i586-mingw32msvc-g++ -c -O2 -D__MSYS__ -MD -fbuiltin ... dcrt0.cc
+    .../dcrt0.cc: In function =E2=80=98void _dll_crt0()=E2=80=99:
+    .../dcrt0.cc:958: error: lvalue required as left operand of assign=
ment
+
+Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
+---
+ msys/rt/src/winsup/cygwin/dcrt0.cc |    4 ++--
+ 1 files changed, 2 insertions(+), 2 deletions(-)
+
+diff --git a/msys/rt/src/winsup/cygwin/dcrt0.cc b/msys/rt/src/winsup/c=
ygwin/dcrt0.cc
+index d3a67c7..6da4c0a 100644
+--- a/msys/rt/src/winsup/cygwin/dcrt0.cc
++++ b/msys/rt/src/winsup/cygwin/dcrt0.cc
+@@ -955,10 +955,10 @@ _dll_crt0 ()
+ 	    }
+ 	  default:
+ #if defined (__MSYS__)
+-	    fork_info =3D NULL;
++	    si.lpReserved2 =3D NULL;  /* <-- means fork_info=3DNULL */
+ #else /* !__MSYS__ */
+ 	    if (_cygwin_testing)
+-	      fork_info =3D NULL;
++	      si.lpReserved2 =3D NULL;  /* <-- means fork_info=3DNULL */
+ 	    else if ((fork_info->type & PROC_MAGIC_MASK) =3D=3D PROC_MAGIC_G=
ENERIC)
+ 	      api_fatal ("conflicting versions of cygwin1.dll detected.  Use=
 only the most recent version.\n");
+ #endif /* !__MSYS__ */
+--=20
+1.7.4.1.48.g5673d
+
diff --git a/src/rt/patches/0018-winsup-cygwin-struct-LUID-has-no-membe=
r-QuadPart.patch b/src/rt/patches/0018-winsup-cygwin-struct-LUID-has-no=
-member-QuadPart.patch
new file mode 100644
index 0000000..d735178
--- /dev/null
+++ b/src/rt/patches/0018-winsup-cygwin-struct-LUID-has-no-member-QuadP=
art.patch
@@ -0,0 +1,39 @@
+From 7d49eefd97fe0276ff493580b749107713af54c0 Mon Sep 17 00:00:00 2001
+From: Kirill Smelkov <kirr@mns.spb.ru>
+Date: Fri, 25 Feb 2011 18:39:17 +0300
+Subject: [PATCH] winsup/cygwin: struct LUID has no member QuadPart
+MIME-Version: 1.0
+Content-Type: text/plain; charset=3DUTF-8
+Content-Transfer-Encoding: 8bit
+
+    i586-mingw32msvc-g++ -c -O2 -D__MSYS__ -MD -fbuiltin ... security.=
cc
+    ../security.cc: In function =E2=80=98BOOL get_group_sidlist(const =
char*, cygsidlist&, cygsid&, cygsid&, _TOKEN_GROUPS*, LUID, int&)=E2=80=
=99:
+    ../security.cc:507: error: =E2=80=98struct LUID=E2=80=99 has no me=
mber named =E2=80=98QuadPart=E2=80=99
+
+According to MSDN[1] there are only .LowPart and .HighPart in LUID, an=
d
+e.g. one wine patch[2] suggests how it should be redone.
+
+[1] http://msdn.microsoft.com/en-us/library/aa379261(v=3Dvs.85).aspx
+[2] http://www.winehq.org/pipermail/wine-patches/2001-November/001400.=
html
+
+Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
+---
+ msys/rt/src/winsup/cygwin/security.cc |    2 +-
+ 1 files changed, 1 insertions(+), 1 deletions(-)
+
+diff --git a/msys/rt/src/winsup/cygwin/security.cc b/msys/rt/src/winsu=
p/cygwin/security.cc
+index 7f0080e..5d48248 100644
+--- a/msys/rt/src/winsup/cygwin/security.cc
++++ b/msys/rt/src/winsup/cygwin/security.cc
+@@ -504,7 +504,7 @@ get_group_sidlist (const char *logonserver, cygsid=
list &grp_list,
+ 	  grp_list +=3D well_known_interactive_sid;
+ 	  grp_list +=3D well_known_authenticated_users_sid;
+ 	}
+-      if (auth_luid.QuadPart !=3D 999) /* !=3D SYSTEM_LUID */
++      if ( ! (auth_luid.HighPart =3D=3D 0 && auth_luid.LowPart =3D=3D=
 999) ) /* !=3D SYSTEM_LUID */
+ 	{
+ 	  char buf[64];
+ 	  __small_sprintf (buf, "S-1-5-5-%u-%u", auth_luid.HighPart,
+--=20
+1.7.4.1.48.g5673d
+
diff --git a/src/rt/patches/0019-winsup-cygwin-Fix-asm-constraint-for-_=
impure_ptr-err.patch b/src/rt/patches/0019-winsup-cygwin-Fix-asm-constr=
aint-for-_impure_ptr-err.patch
new file mode 100644
index 0000000..348252b
--- /dev/null
+++ b/src/rt/patches/0019-winsup-cygwin-Fix-asm-constraint-for-_impure_=
ptr-err.patch
@@ -0,0 +1,38 @@
+From 013548ec033024245161685e93a3467d6bd2dbc0 Mon Sep 17 00:00:00 2001
+From: Kirill Smelkov <kirr@mns.spb.ru>
+Date: Fri, 25 Feb 2011 19:50:48 +0300
+Subject: [PATCH] winsup/cygwin: Fix asm constraint for (&_impure_ptr->=
errno)
+
+    i586-mingw32msvc-g++ -c -O2 -D__MSYS__ -MD -fbuiltin ... exception=
s.cc
+    .../exceptions.cc:1234: error: memory input 1 is not directly addr=
essable
+
+It was about "m" (&_impure_ptr->_errno). Earlier gcc accepted this, bu=
t
+somehow world changed. Tell gcc the address can be also placed in a
+register to make it happy.
+
+Similiar issue resolved this way:
+
+http://coding.derkeiler.com/Archive/Assembler/alt.lang.asm/2008-11/msg=
00079.html
+http://coding.derkeiler.com/Archive/Assembler/alt.lang.asm/2008-11/msg=
00082.html
+
+Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
+---
+ msys/rt/src/winsup/cygwin/exceptions.cc |    2 +-
+ 1 files changed, 1 insertions(+), 1 deletions(-)
+
+diff --git a/msys/rt/src/winsup/cygwin/exceptions.cc b/msys/rt/src/win=
sup/cygwin/exceptions.cc
+index 94b3a0b..020c6d8 100644
+--- a/msys/rt/src/winsup/cygwin/exceptions.cc
++++ b/msys/rt/src/winsup/cygwin/exceptions.cc
+@@ -1226,7 +1226,7 @@ _sigdelayed0:								\n\
+ 	popl	%%eax							\n\
+ 	jmp	*%%eax							\n\
+ __no_sig_end:								\n\
+-" : "=3Dm" (sigsave.sig) : "m" (&_impure_ptr->_errno),
++" : "=3Dm" (sigsave.sig) : "rm" (&_impure_ptr->_errno),
+   "g" (sigsave.retaddr), "g" (sigsave.oldmask), "g" (sigsave.sig),
+     "g" (sigsave.func), "o" (pid_offset), "g" (sigsave.saved_errno), =
"g" (sigsave.newmask)
+ );
+--=20
+1.7.4.1.48.g5673d
+
diff --git a/src/rt/patches/0020-winsup-cygwin-Add-volatile-qualifier-t=
o-ilock-in-win.patch b/src/rt/patches/0020-winsup-cygwin-Add-volatile-q=
ualifier-to-ilock-in-win.patch
new file mode 100644
index 0000000..3b23139
--- /dev/null
+++ b/src/rt/patches/0020-winsup-cygwin-Add-volatile-qualifier-to-ilock=
-in-win.patch
@@ -0,0 +1,70 @@
+From 2fa5be857f3b026f245dd7a283de093809568f05 Mon Sep 17 00:00:00 2001
+From: Kirill Smelkov <kirr@mns.spb.ru>
+Date: Sat, 26 Feb 2011 14:38:42 +0300
+Subject: [PATCH] winsup/cygwin: Add volatile qualifier to ilock* in wi=
nbase.h
+MIME-Version: 1.0
+Content-Type: text/plain; charset=3DUTF-8
+Content-Transfer-Encoding: 8bit
+
+[ Cherry-picked from r1.14 in
+  http://cygwin.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/winbase.h?cvs=
root=3Dsrc ]
+
+This is needed in order to fix compilation with recent gcc/w32api:
+
+    i586-mingw32msvc-g++ -c -O2 -D__MSYS__ -MD -fbuiltin ... thread.cc
+    .../thread.cc: In constructor =E2=80=98pthread_cond::pthread_cond(=
pthread_condattr*)=E2=80=99:
+    .../thread.cc:438: error: invalid conversion from =E2=80=98volatil=
e LONG*=E2=80=99 to =E2=80=98long int*=E2=80=99
+    .../thread.cc:438: error:   initializing argument 1 of =E2=80=98lo=
ng int ilockexch(long int*, long int)=E2=80=99
+    .../thread.cc: In destructor =E2=80=98pthread_cond::~pthread_cond(=
)=E2=80=99:
+    .../thread.cc:448: error: invalid conversion from =E2=80=98volatil=
e LONG*=E2=80=99 to =E2=80=98long int*=E2=80=99
+    .../thread.cc:448: error:   initializing argument 1 of =E2=80=98lo=
ng int ilockexch(long int*, long int)=E2=80=99
+    [ and so on ... ]
+
+Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
+---
+ msys/rt/src/winsup/cygwin/winbase.h |    8 ++++----
+ 1 files changed, 4 insertions(+), 4 deletions(-)
+
+diff --git a/msys/rt/src/winsup/cygwin/winbase.h b/msys/rt/src/winsup/=
cygwin/winbase.h
+index 351d320..1257781 100644
+--- a/msys/rt/src/winsup/cygwin/winbase.h
++++ b/msys/rt/src/winsup/cygwin/winbase.h
+@@ -4,7 +4,7 @@
+ #define _WINBASE2_H
+=20
+ extern __inline__ long
+-ilockincr (long *m)
++ilockincr (volatile long *m)
+ {
+   register int __res;
+   __asm__ __volatile__ ("\n\
+@@ -16,7 +16,7 @@ ilockincr (long *m)
+ }
+=20
+ extern __inline__ long
+-ilockdecr (long *m)
++ilockdecr (volatile long *m)
+ {
+   register int __res;
+   __asm__ __volatile__ ("\n\
+@@ -28,7 +28,7 @@ ilockdecr (long *m)
+ }
+=20
+ extern __inline__ long
+-ilockexch (long *t, long v)
++ilockexch (volatile long *t, long v)
+ {
+   register int __res;
+   __asm__ __volatile__ ("\n\
+@@ -39,7 +39,7 @@ ilockexch (long *t, long v)
+ }
+=20
+ extern __inline__ long
+-ilockcmpexch (long *t, long v, long c)
++ilockcmpexch (volatile long *t, long v, long c)
+ {
+   register int __res;
+   __asm__ __volatile__ ("\n\
+--=20
+1.7.4.1.48.g5673d
+
diff --git a/src/rt/patches/0021-winsup-cygwin-call_signal_handler_now-=
alias-keeping-.patch b/src/rt/patches/0021-winsup-cygwin-call_signal_ha=
ndler_now-alias-keeping-.patch
new file mode 100644
index 0000000..096d757
--- /dev/null
+++ b/src/rt/patches/0021-winsup-cygwin-call_signal_handler_now-alias-k=
eeping-.patch
@@ -0,0 +1,48 @@
+From 85e943cb4e6aeac844ee465017efa5474c85e046 Mon Sep 17 00:00:00 2001
+From: Kirill Smelkov <kirr@mns.spb.ru>
+Date: Fri, 25 Feb 2011 20:37:09 +0300
+Subject: [PATCH] winsup/cygwin: call_signal_handler_now() alias-keepin=
g breaks compilation
+MIME-Version: 1.0
+Content-Type: text/plain; charset=3DUTF-8
+Content-Transfer-Encoding: 8bit
+
+    i586-mingw32msvc-g++ -c -O2 -D__MSYS__ -MD -fbuiltin ... exception=
s.cc
+    .../exceptions.cc:1148: error: =E2=80=98int call_signal_handler_no=
w_dummy()=E2=80=99 aliased to undefined symbol =E2=80=98call_signal_han=
dler_now=E2=80=99
+
+Unbreak it by making call_signal_handler_now() non-static and commenti=
ng
+the kludge. Hope it's ok.
+
+Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
+---
+ msys/rt/src/winsup/cygwin/exceptions.cc |    4 +++-
+ 1 files changed, 3 insertions(+), 1 deletions(-)
+
+diff --git a/msys/rt/src/winsup/cygwin/exceptions.cc b/msys/rt/src/win=
sup/cygwin/exceptions.cc
+index 020c6d8..a2853e9 100644
+--- a/msys/rt/src/winsup/cygwin/exceptions.cc
++++ b/msys/rt/src/winsup/cygwin/exceptions.cc
+@@ -1127,7 +1127,7 @@ events_terminate (void)
+ }
+=20
+ extern "C" {
+-static int __stdcall
++int __stdcall
+ call_signal_handler_now ()
+ {
+   if (!sigsave.sig)
+@@ -1142,10 +1142,12 @@ call_signal_handler_now ()
+   sigdelayed0 ();
+   return sa_flags & SA_RESTART;
+ }
++#if 0
+ /* This kludge seems to keep a copy of call_signal_handler_now around
+    even when compiling with -finline-functions. */
+ static int __stdcall call_signal_handler_now_dummy ()
+   __attribute__((alias ("call_signal_handler_now")));
++#endif
+ };
+=20
+ int
+--=20
+1.7.4.1.48.g5673d
+
diff --git a/src/rt/patches/0022-winsup-cygwin-std_dll_init-and-wsock_i=
nit-should-not.patch b/src/rt/patches/0022-winsup-cygwin-std_dll_init-a=
nd-wsock_init-should-not.patch
new file mode 100644
index 0000000..27441b4
--- /dev/null
+++ b/src/rt/patches/0022-winsup-cygwin-std_dll_init-and-wsock_init-sho=
uld-not.patch
@@ -0,0 +1,60 @@
+From 655638fd57f15e48c59620b763fbdc85bc7793a4 Mon Sep 17 00:00:00 2001
+From: Kirill Smelkov <kirr@mns.spb.ru>
+Date: Fri, 25 Feb 2011 20:16:45 +0300
+Subject: [PATCH] winsup/cygwin: std_dll_init() and wsock_init() should=
 not be static
+
+Because they are referenced from assembly-made LoadDllPrime from
+different from .text sections:
+
+    <linking new-msys-1.0.dll>
+    autoload.o:autoload.cc:(.ws2_32_info[_ws2_32_handle]+0x0): undefin=
ed reference to `std_dll_init'
+    autoload.o:autoload.cc:(.ws2_32_info[_ws2_32_handle]+0xc): undefin=
ed reference to `wsock_init'
+    autoload.o:autoload.cc:(.ws2_32_info[_ws2_32_handle]+0x17): undefi=
ned reference to `std_dll_init'
+    autoload.o:autoload.cc:(.ws2_32_info[_ws2_32_handle]+0x2e): undefi=
ned reference to `std_dll_init'
+    autoload.o:autoload.cc:(.ws2_32_info[_ws2_32_handle]+0x45): undefi=
ned reference to `std_dll_init'
+    autoload.o:autoload.cc:(.ws2_32_info[_ws2_32_handle]+0x5c): undefi=
ned reference to `std_dll_init'
+    autoload.o:autoload.cc:(.ws2_32_info[_ws2_32_handle]+0x73): undefi=
ned reference to `std_dll_init'
+    autoload.o:autoload.cc:(.ws2_32_info[_ws2_32_handle]+0x8a): more u=
ndefined references to `std_dll_init' follow
+    autoload.o:autoload.cc:(.wsock32_info[_wsock32_handle]+0xc): undef=
ined reference to `wsock_init'
+    autoload.o:autoload.cc:(.wsock32_info[_wsock32_handle]+0x18): unde=
fined reference to `std_dll_init'
+    autoload.o:autoload.cc:(.wsock32_info[_wsock32_handle]+0x30): unde=
fined reference to `std_dll_init'
+    autoload.o:autoload.cc:(.wsock32_info[_wsock32_handle]+0x48): unde=
fined reference to `std_dll_init'
+    autoload.o:autoload.cc:(.wsock32_info[_wsock32_handle]+0x60): unde=
fined reference to `std_dll_init'
+    autoload.o:autoload.cc:(.wsock32_info[_wsock32_handle]+0x78): unde=
fined reference to `std_dll_init'
+    autoload.o:autoload.cc:(.wsock32_info[_wsock32_handle]+0x90): more=
 undefined references to `std_dll_init' follow
+
+Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
+---
+ msys/rt/src/winsup/cygwin/autoload.cc |    8 ++++----
+ 1 files changed, 4 insertions(+), 4 deletions(-)
+
+diff --git a/msys/rt/src/winsup/cygwin/autoload.cc b/msys/rt/src/winsu=
p/cygwin/autoload.cc
+index 67d0bc0..6f5a8f5 100644
+--- a/msys/rt/src/winsup/cygwin/autoload.cc
++++ b/msys/rt/src/winsup/cygwin/autoload.cc
+@@ -201,8 +201,8 @@ union retchain
+ };
+=20
+ /* The standard DLL initialization routine. */
+-static long long std_dll_init () __asm__ ("std_dll_init") __attribute=
__ ((unused));
+-static long long
++long long std_dll_init () __asm__ ("std_dll_init") __attribute__ ((un=
used));
++long long
+ std_dll_init ()
+ {
+   HANDLE h;
+@@ -241,9 +241,9 @@ std_dll_init ()
+ }
+=20
+ /* Initialization function for winsock stuff. */
+-static long long wsock_init () __asm__ ("wsock_init") __attribute__ (=
(unused, regparm(1)));
++long long wsock_init () __asm__ ("wsock_init") __attribute__ ((unused=
, regparm(1)));
+ bool NO_COPY wsock_started =3D 0;
+-static long long
++long long
+ wsock_init ()
+ {
+   static LONG NO_COPY here =3D -1L;
+--=20
+1.7.4.1.48.g5673d
+
diff --git a/src/rt/patches/0023-winsup-cygwin-Build-with-fno-threadsaf=
e-statics.patch b/src/rt/patches/0023-winsup-cygwin-Build-with-fno-thre=
adsafe-statics.patch
new file mode 100644
index 0000000..023dd80
--- /dev/null
+++ b/src/rt/patches/0023-winsup-cygwin-Build-with-fno-threadsafe-stati=
cs.patch
@@ -0,0 +1,45 @@
+From bcf492ef90d866cced91f6fd8f57fd0b4cd05691 Mon Sep 17 00:00:00 2001
+From: Kirill Smelkov <kirr@mns.spb.ru>
+Date: Fri, 25 Feb 2011 21:57:51 +0300
+Subject: [PATCH] winsup/cygwin: Build with -fno-threadsafe-statics
+
+msys is low-level enough to do it's own synchronisation when neccessar=
y,
+and also gcc3 does not seem to be implementing threadsafe statics, so
+msys never used this mechanics.
+
+But when compiled with gcc4, threadsafe statics are default - this add=
s
+to code size, and also pulls __cxa_guard_acquire and __cxa_guard_relea=
se
+from libstdc++.
+
+Avoid it for compilers that understand threadsafe statics (gcc4). The
+goal is to avoid libstdc++ dependency completly in the end.
+
+See also:
+
+http://lists.apple.com/archives/darwin-drivers/2005/May/msg00067.html
+http://gcc.gnu.org/ml/libstdc++/2002-11/msg00279.html
+
+Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
+---
+ msys/rt/src/winsup/Makefile.common |    5 +++++
+ 1 files changed, 5 insertions(+), 0 deletions(-)
+
+diff --git a/msys/rt/src/winsup/Makefile.common b/msys/rt/src/winsup/M=
akefile.common
+index 78595d2..798c374 100644
+--- a/msys/rt/src/winsup/Makefile.common
++++ b/msys/rt/src/winsup/Makefile.common
+@@ -99,6 +99,11 @@ CPP_TARGET_INCLUDE:=3D/usr/include/c++/3.2.2/i686-p=
c-msys
+ COMPILE_CXX:=3D$(CXX) $c -nostdinc++ $(ALL_CXXFLAGS) -I$(GCC_INCLUDE)=
 \
+ 	     -I$(CPP_INCLUDE) -I$(CPP_TARGET_INCLUDE) \
+ 	     -fno-rtti -fno-exceptions
++
++# add -fno-threadsafe-statics if compiler supports it
++COMPILE_CXX+=3D$(shell $(CXX) -fno-threadsafe-statics -c -xc++ /dev/n=
ull >/dev/null 2>&1	\
++		&& echo -fno-threadsafe-statics)
++
+ COMPILE_CC:=3D$(CC) $c -nostdinc $(ALL_CFLAGS) -I$(GCC_INCLUDE)
+=20
+ vpath %.a	$(cygwin_build):$(w32api_lib):$(newlib_build)/libc:$(newlib=
_build)/libm
+--=20
+1.7.4.1.48.g5673d
+
diff --git a/src/rt/patches/0024-winsup-cygwin-Avoid-libstdc-dependency=
=2Epatch b/src/rt/patches/0024-winsup-cygwin-Avoid-libstdc-dependency.p=
atch
new file mode 100644
index 0000000..eb55fc0
--- /dev/null
+++ b/src/rt/patches/0024-winsup-cygwin-Avoid-libstdc-dependency.patch
@@ -0,0 +1,103 @@
+From dfd3d1291f744f0f9c5549a58f69c814cb980266 Mon Sep 17 00:00:00 2001
+From: Kirill Smelkov <kirr@mns.spb.ru>
+Date: Fri, 25 Feb 2011 22:04:06 +0300
+Subject: [PATCH] winsup/cygwin: Avoid libstdc++ dependency
+
+All we need from libstdc++ is operator new/delete, and also
+__cxa_pure_virtual().
+
+But if we are getting this stuff from libstdc++, the functions also
+pulls lots of dependencies, e.g. operator new calls std::terminate() i=
f
+it can't allocate memory, which links to exception-handling routines a=
nd
+other symbols from non-msys C runtime:
+
+    <linking msys.dll (with libstdc++)>
+    TODO
+
+Avoid it.
+
+Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
+---
+ msys/rt/src/winsup/cygwin/Makefile.in |    3 +-
+ msys/rt/src/winsup/cygwin/supcc.cc    |   48 ++++++++++++++++++++++++=
+++++++++
+ 2 files changed, 50 insertions(+), 1 deletions(-)
+ create mode 100644 msys/rt/src/winsup/cygwin/supcc.cc
+
+diff --git a/msys/rt/src/winsup/cygwin/Makefile.in b/msys/rt/src/winsu=
p/cygwin/Makefile.in
+index ef0ae9e..050fc8a 100644
+--- a/msys/rt/src/winsup/cygwin/Makefile.in
++++ b/msys/rt/src/winsup/cygwin/Makefile.in
+@@ -131,6 +131,7 @@ DLL_OFILES:=3Dassert.o autoload.o \
+ 	smallprint.o spawn.o strace.o strsep.o sync.o syscalls.o sysconf.o \
+ 	syslog.o termios.o thread.o times.o tty.o uinfo.o uname.o wait.o \
+ 	window.o \
++	supcc.o	\
+ 	$(EXTRA_DLL_OFILES) $(EXTRA_OFILES) $(MALLOC_OFILES) $(MT_SAFE_OBJEC=
TS)=20
+=20
+ GMON_OFILES:=3D gmon.o mcount.o profil.o
+@@ -201,7 +202,7 @@ new-$(DLL_NAME): $(LDSCRIPT) $(DLL_OFILES) $(DEF_F=
ILE) $(DLL_IMPORTS) $(LIBC) $(
+ 	$(CXX) $(CXXFLAGS) -nostdlib -Wl,-T$(firstword $^) -shared -o $@ \
+ 	-e $(DLL_ENTRY) $(DEF_FILE) $(DLL_OFILES) version.o winver.o \
+ 	$(DLL_IMPORTS) $(MALLOC_OBJ) $(LIBM) $(LIBC) \
+-	-lstdc++ -lgcc -lshell32 -luuid -lkernel32 -lnetapi32 -luser32
++	-lgcc -lshell32 -luuid -lkernel32 -lnetapi32 -luser32
+=20
+ dll_ofiles: $(DLL_OFILES)
+=20
+diff --git a/msys/rt/src/winsup/cygwin/supcc.cc b/msys/rt/src/winsup/c=
ygwin/supcc.cc
+new file mode 100644
+index 0000000..1d3d6b5
+--- /dev/null
++++ b/msys/rt/src/winsup/cygwin/supcc.cc
+@@ -0,0 +1,48 @@
++/* C++ supporting routines - minimal selected bits from libsupc++ for=
 msys.dll
++ * to work without linking to libstdc++
++ */
++#include "winsup.h"
++#include <stdlib.h>
++
++void *
++operator new (size_t size)
++{
++    void *p;
++
++    p =3D malloc(size);
++    /* TODO if !p - try __new_handler */
++
++    if (!p)
++        api_fatal("out of memory in `operator new()`");
++
++    return p;
++}
++
++void
++operator delete (void *p)
++{
++    if (p)
++        free(p);
++}
++
++
++void *
++operator new[] (size_t size)
++{
++    return operator new(size);
++}
++
++void
++operator delete[] (void *p)
++{
++    operator delete (p);
++}
++
++
++
++/* pure virtuals link to here */
++extern "C" void
++__cxa_pure_virtual()
++{
++    api_fatal("pure virtual method called");
++}
+--=20
+1.7.4.1.48.g5673d
+
diff --git a/src/rt/patches/0025-winsup-cygwin-Strip-new-msys-1.0.dll-w=
hen-cross-comp.patch b/src/rt/patches/0025-winsup-cygwin-Strip-new-msys=
-1.0.dll-when-cross-comp.patch
new file mode 100644
index 0000000..c840148
--- /dev/null
+++ b/src/rt/patches/0025-winsup-cygwin-Strip-new-msys-1.0.dll-when-cro=
ss-comp.patch
@@ -0,0 +1,94 @@
+From 907b5b7d60f82ca51792ee9f048b08f2f6510e84 Mon Sep 17 00:00:00 2001
+From: Kirill Smelkov <kirr@mns.spb.ru>
+Date: Sat, 26 Feb 2011 15:01:04 +0300
+Subject: [PATCH] winsup/cygwin: Strip new-msys-1.0.dll when cross-comp=
iling
+
+Somehow mingw32 cross compiler on Debian (lenny and squeeze) produces
+dll's with .debug_* sections with VirtualSize=3D0:
+
+    $ objdump -h new-msys-1.0.dll
+    new-msys-1.0.dll:     file format efi-app-ia32
+
+    Sections:
+    Idx Name          Size      VMA               LMA               Fi=
le off  Algn
+      0 .debug_abbrev 000137f0  00000000  00000000  000007e0  2**0
+                      CONTENTS, READONLY, DEBUGGING
+      1 .debug_info   0006f0b5  00000000  00000000  00013fe0  2**0
+                      CONTENTS, READONLY, DEBUGGING
+      2 .debug_line   0001c3fb  00000000  00000000  000831e0  2**0
+                      CONTENTS, READONLY, DEBUGGING
+      3 .debug_pubnames 0000303f  00000000  00000000  0009f5e0  2**0
+                      CONTENTS, READONLY, DEBUGGING
+      4 .debug_frame  000056d0  00000000  00000000  000a27e0  2**2
+                      CONTENTS, READONLY, DEBUGGING
+      5 .debug_loc    0001ba99  00000000  00000000  000a7fe0  2**0
+                      CONTENTS, READONLY, DEBUGGING
+      6 .debug_aranges 00002da0  00000000  00000000  000c3be0  2**3
+                      CONTENTS, READONLY, DEBUGGING
+      7 .debug_str    00000390  00000000  00000000  000c69e0  2**0
+                      CONTENTS, READONLY, DEBUGGING
+      8 .debug_ranges 000022a0  00000000  00000000  000c6de0  2**0
+                      CONTENTS, READONLY, DEBUGGING
+      9 .text         00081e30  71001000  71001000  000c9200  2**5
+                      CONTENTS, ALLOC, LOAD, READONLY, CODE, DATA
+     10 .data         00004958  71083000  71083000  0014b200  2**5
+                      CONTENTS, ALLOC, LOAD, DATA
+     11 .wsock32_info 00000378  71088000  71088000  0014fc00  2**2
+                      CONTENTS, ALLOC, LOAD, DATA, LINK_ONCE_DISCARD (=
COMDAT _wsock32_handle 15549)
+     12 .ws2_32_info  00000144  71089000  71089000  00150000  2**2
+                  CONTENTS, ALLOC, LOAD, DATA, LINK_ONCE_DISCARD (COMD=
AT _ws2_32_handle 14700)
+
+    ...
+
+And wine refuses to load PE's with such sections:
+
+    $ WINEDEBUG=3Dmodule wine hellomsys.exe
+    ...
+    trace:module:load_native_dll Trying native dll L"Z:\\home\\kirr\\s=
rc\\tools\\git\\msys\\msys\\rt\\src\\winsup\\cygwin\\objs\\msys-1.0.dll=
"
+    trace:module:map_image mapped PE file at 0x71000000-0x71102000
+    warn:module:map_image Section /4 too large (8f000000+14000/102000)
+    warn:module:load_dll Failed to load module L"msys-1.0.dll"; status=
=3Dc000007b
+    err:module:import_dll Loading library msys-1.0.dll (which is neede=
d by L"Z:\\...\\xmsys.exe") failed (error c000007b).
+    err:module:LdrInitializeThunk Main exe initialization for L"Z:\\..=
=2E\\xmsys.exe" failed, status c0000135
+
+Now, c000007b is ERROR_BAD_EXE_FORMAT (=3D STATUS_INVALID_IMAGE_FORMAT=
),
+and the error is triggered in ntdll:map_image():
+
+http://source.winehq.org/git/wine.git/?a=3Dblob;f=3Ddlls/ntdll/virtual=
=2Ec;h=3D0913b714bed3e2f766c7e4f056335224316d52c3;hb=3DHEAD#l1217
+
+because of
+
+    if (!sec->Misc.VirtualSize)
+        map_size =3D ROUND_SIZE( 0, sec->SizeOfRawData );
+    else
+        map_size =3D ROUND_SIZE( 0, sec->Misc.VirtualSize );
+
+I'm not PE expert, and can't tell who is right, so to workaround
+problems, let's just strip debuginfo...
+
+Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
+---
+ msys/rt/src/winsup/cygwin/Makefile.in |    7 +++++++
+ 1 files changed, 7 insertions(+), 0 deletions(-)
+
+diff --git a/msys/rt/src/winsup/cygwin/Makefile.in b/msys/rt/src/winsu=
p/cygwin/Makefile.in
+index 050fc8a..e8eafe6 100644
+--- a/msys/rt/src/winsup/cygwin/Makefile.in
++++ b/msys/rt/src/winsup/cygwin/Makefile.in
+@@ -204,6 +204,13 @@ new-$(DLL_NAME): $(LDSCRIPT) $(DLL_OFILES) $(DEF_=
=46ILE) $(DLL_IMPORTS) $(LIBC) $(
+ 	$(DLL_IMPORTS) $(MALLOC_OBJ) $(LIBM) $(LIBC) \
+ 	-lgcc -lshell32 -luuid -lkernel32 -lnetapi32 -luser32
+=20
++ifneq ($(findstring mingw32,$(CXX)),)
++	# wine loader does not like debug sections with VirtualSize 0 - so w=
hen
++	# cross-compiling, to workaround this problem, just strip them. XXX =
better use $$(STRIP)
++	$(patsubst %-g++,%-strip,$(CXX)) -g $@
++endif
++
++
+ dll_ofiles: $(DLL_OFILES)
+=20
+ $(LIBGMON_A): $(GMON_OFILES) $(GMON_START)
+--=20
+1.7.4.1.48.g5673d
+
diff --git a/src/rt/patches/0026-winsup-cygwin-cygrun.exe-build-depends=
-on-libmsys-1..patch b/src/rt/patches/0026-winsup-cygwin-cygrun.exe-bui=
ld-depends-on-libmsys-1..patch
new file mode 100644
index 0000000..6496696
--- /dev/null
+++ b/src/rt/patches/0026-winsup-cygwin-cygrun.exe-build-depends-on-lib=
msys-1..patch
@@ -0,0 +1,32 @@
+From 625a8d421d923b59d680b319ac2b6439eb46ecc6 Mon Sep 17 00:00:00 2001
+From: Kirill Smelkov <kirr@mns.spb.ru>
+Date: Sat, 26 Feb 2011 17:15:52 +0300
+Subject: [PATCH] winsup/cygwin: cygrun.exe build-depends on libmsys-1.=
0.dll.a
+
+Since we link to it we should tell make we need it, or else `make -j4`
+breaks:
+
+    i586-mingw32msvc-gcc -nodefaultlibs -o cygrun.exe cygrun.o -lgcc l=
ibmsys-1.0.dll.a -luser32 -lshell32 -lkernel32
+    i586-mingw32msvc-gcc: libmsys-1.0.dll.a: No such file or directory
+
+Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
+---
+ msys/rt/src/winsup/cygwin/Makefile.in |    2 +-
+ 1 files changed, 1 insertions(+), 1 deletions(-)
+
+diff --git a/msys/rt/src/winsup/cygwin/Makefile.in b/msys/rt/src/winsu=
p/cygwin/Makefile.in
+index e8eafe6..a1cbf71 100644
+--- a/msys/rt/src/winsup/cygwin/Makefile.in
++++ b/msys/rt/src/winsup/cygwin/Makefile.in
+@@ -225,7 +225,7 @@ winver_stamp: mkvers.sh include/cygwin/version.h w=
inver.rc $(DLL_OFILES)
+ 	touch $@ && \
+ 	$(COMPILE_CXX) -o version.o version.cc
+=20
+-cygrun.exe : cygrun.o
++cygrun.exe : cygrun.o $(LIB_NAME)
+ 	$(CC) -nodefaultlibs -o $@ $^ -lgcc $(LIB_NAME) -luser32 -lshell32 -=
lkernel32
+=20
+ #=0C
+--=20
+1.7.4.1.48.g5673d
+
diff --git a/src/rt/patches/0027-winsup-cygwin-cyrun.exe-should-be-buil=
t-with-nostdli.patch b/src/rt/patches/0027-winsup-cygwin-cyrun.exe-shou=
ld-be-built-with-nostdli.patch
new file mode 100644
index 0000000..215f788
--- /dev/null
+++ b/src/rt/patches/0027-winsup-cygwin-cyrun.exe-should-be-built-with-=
nostdli.patch
@@ -0,0 +1,53 @@
+From cf59176197193d2256f13580b5a8518b5e66a9c0 Mon Sep 17 00:00:00 2001
+From: Kirill Smelkov <kirr@mns.spb.ru>
+Date: Sat, 26 Feb 2011 17:19:54 +0300
+Subject: [PATCH] winsup/cygwin: cyrun.exe should be built with -nostdl=
ib (not -nodefaultlibs)
+
+Because -nodefaultlibs, still pulls in compiler's crt bits. E.g. when
+cross compiling:
+
+    i586-mingw32msvc-gcc -nodefaultlibs -o cygrun.exe cygrun.o libmsys=
-1.0.dll.a -lgcc libmsys-1.0.dll.a -luser32 -lshell32 -lkernel32
+    libmsys-1.0.dll.a(dncqs00563.o):(.text+0x0): multiple definition o=
f `_atexit'
+    /usr/lib/gcc/i586-mingw32msvc/4.4.2/../../../../i586-mingw32msvc/l=
ib/crt2.o:/home/ron/devel/debian/mingw32-runtime/mingw32-runtime-3.13/b=
uild_dir/src/mingw-runtime-3.13-20070825-1/crt1.c:280: first defined he=
re
+    /usr/lib/gcc/i586-mingw32msvc/4.4.2/../../../../i586-mingw32msvc/l=
ib/crt2.o:crt1.c:(.text+0x13): undefined reference to `__imp___onexit'
+    /usr/lib/gcc/i586-mingw32msvc/4.4.2/../../../../i586-mingw32msvc/l=
ib/crt2.o:crt1.c:(.text+0x35): undefined reference to `___cpu_features_=
init'
+    /usr/lib/gcc/i586-mingw32msvc/4.4.2/../../../../i586-mingw32msvc/l=
ib/crt2.o:crt1.c:(.text+0x3a): undefined reference to `__fpreset'
+    /usr/lib/gcc/i586-mingw32msvc/4.4.2/../../../../i586-mingw32msvc/l=
ib/crt2.o:crt1.c:(.text+0x51): undefined reference to `__CRT_glob'
+    /usr/lib/gcc/i586-mingw32msvc/4.4.2/../../../../i586-mingw32msvc/l=
ib/crt2.o:crt1.c:(.text+0x62): undefined reference to `___getmainargs'
+    /usr/lib/gcc/i586-mingw32msvc/4.4.2/../../../../i586-mingw32msvc/l=
ib/crt2.o:crt1.c:(.text+0x67): undefined reference to `__CRT_fmode'
+    /usr/lib/gcc/i586-mingw32msvc/4.4.2/../../../../i586-mingw32msvc/l=
ib/crt2.o:crt1.c:(.text+0x73): undefined reference to `___p__fmode'
+    /usr/lib/gcc/i586-mingw32msvc/4.4.2/../../../../i586-mingw32msvc/l=
ib/crt2.o:crt1.c:(.text+0x80): undefined reference to `__pei386_runtime=
_relocator'
+    /usr/lib/gcc/i586-mingw32msvc/4.4.2/../../../../i586-mingw32msvc/l=
ib/crt2.o:crt1.c:(.text+0x8d): undefined reference to `___p__environ'
+    /usr/lib/gcc/i586-mingw32msvc/4.4.2/../../../../i586-mingw32msvc/l=
ib/crt2.o:crt1.c:(.text+0xaa): undefined reference to `__cexit'
+    /usr/lib/gcc/i586-mingw32msvc/4.4.2/../../../../i586-mingw32msvc/l=
ib/crt2.o:crt1.c:(.text+0xb8): undefined reference to `__imp___iob'
+    /usr/lib/gcc/i586-mingw32msvc/4.4.2/../../../../i586-mingw32msvc/l=
ib/crt2.o:crt1.c:(.text+0xd8): undefined reference to `__CRT_fmode'
+    /usr/lib/gcc/i586-mingw32msvc/4.4.2/../../../../i586-mingw32msvc/l=
ib/crt2.o:crt1.c:(.text+0xf1): undefined reference to `__CRT_fmode'
+    /usr/lib/gcc/i586-mingw32msvc/4.4.2/../../../../i586-mingw32msvc/l=
ib/crt2.o:crt1.c:(.text+0x11a): undefined reference to `__imp____set_ap=
p_type'
+    /usr/lib/gcc/i586-mingw32msvc/4.4.2/../../../../i586-mingw32msvc/l=
ib/crt2.o:crt1.c:(.text+0x13a): undefined reference to `__imp____set_ap=
p_type'
+    /usr/lib/gcc/i586-mingw32msvc/4.4.2/../../../../i586-mingw32msvc/l=
ib/crt2.o:crt1.c:(.text+0x278): undefined reference to `__fpreset'
+    collect2: ld returned 1 exit status
+
+Since newlib/msys already have all what is needed, we can turn
+-nodefaultlibs into -nostdlib, which avoid standard crt2.o as well.
+
+Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
+---
+ msys/rt/src/winsup/cygwin/Makefile.in |    2 +-
+ 1 files changed, 1 insertions(+), 1 deletions(-)
+
+diff --git a/msys/rt/src/winsup/cygwin/Makefile.in b/msys/rt/src/winsu=
p/cygwin/Makefile.in
+index a1cbf71..393f2da 100644
+--- a/msys/rt/src/winsup/cygwin/Makefile.in
++++ b/msys/rt/src/winsup/cygwin/Makefile.in
+@@ -226,7 +226,7 @@ winver_stamp: mkvers.sh include/cygwin/version.h w=
inver.rc $(DLL_OFILES)
+ 	$(COMPILE_CXX) -o version.o version.cc
+=20
+ cygrun.exe : cygrun.o $(LIB_NAME)
+-	$(CC) -nodefaultlibs -o $@ $^ -lgcc $(LIB_NAME) -luser32 -lshell32 -=
lkernel32
++	$(CC) -nostdlib -o $@ $^ -lgcc $(LIB_NAME) -luser32 -lshell32 -lkern=
el32
+=20
+ #=0C
+=20
+--=20
+1.7.4.1.48.g5673d
+
diff --git a/src/rt/release.sh b/src/rt/release.sh
index a25f37a..c81f5e1 100644
--- a/src/rt/release.sh
+++ b/src/rt/release.sh
@@ -8,7 +8,26 @@ die () {
 cd "$(dirname "$0")"
=20
 debug=3D
-test "a$1" =3D "a--debug" && debug=3Dt
+cross=3D
+
+while test $# !=3D 0
+do
+	case "$1" in
+	"--debug")
+		debug=3Dt
+		;;
+
+	"--cross")
+		cross=3Dt
+		;;
+	*)
+		die "Unknown option $1"
+		;;
+	esac
+
+	shift
+done
+
 debug_clean=3D
 test "$debug" =3D "$(cat debug.txt 2>/dev/null)" || debug_clean=3Dt
 echo "$debug" > debug.txt
@@ -36,26 +55,143 @@ do
 	i=3D$(($i+1))
 done
=20
-test -f /bin/cc.exe || ln gcc.exe /bin/cc.exe ||
-die "Could not make sure that MSys cc is found instead of MinGW one"
=20
 cd msys/rt &&
-release=3DMSYS-g$(git show -s --pretty=3D%h HEAD) &&
-(export MSYSTEM=3DMSYS &&
- export PATH=3D/bin:$PATH &&
- (test -d bld || mkdir bld) &&
- cd bld &&
- DLL=3Di686-pc-msys/winsup/cygwin/new-msys-1.0.dll &&
- (test -f Makefile && test -z "$debug_clean" ||
-  ../src/configure --prefix=3D/usr) &&
- (test -z "$debug" || perl -i.bak -pe 's/-O2//g' $(find -name Makefile=
)) &&
- (test -z "$debug_clean" || make clean) &&
- (make || test -f $DLL) &&
- (test ! -z "$debug" || strip $DLL) &&
- rebase -b 0x68000000 $DLL &&
- mv $DLL /bin/) &&
-cd / &&
-hash=3D$(git hash-object -w bin/new-msys-1.0.dll) &&
-git update-index --cacheinfo 100755 $hash bin/msys-1.0.dll &&
-git commit -s -m "Updated msys-1.0.dll to $release" &&
-/share/msysGit/post-checkout-hook HEAD^ HEAD 1
+release=3DMSYS-g$(git show -s --pretty=3D%h HEAD) ||
+die "Could not detect MSYS release"
+
+
+# build msys.dll in native win32/msys environment
+release_native() {
+	test -f /bin/cc.exe || ln gcc.exe /bin/cc.exe ||
+	die "Could not make sure that MSys cc is found instead of MinGW one"
+
+	(export MSYSTEM=3DMSYS &&
+	 export PATH=3D/bin:$PATH &&
+	 (test -d bld || mkdir bld) &&
+	 cd bld &&
+	 DLL=3Di686-pc-msys/winsup/cygwin/new-msys-1.0.dll &&
+	 (test -f Makefile && test -z "$debug_clean" ||
+	  ../src/configure --prefix=3D/usr) &&
+	 (test -z "$debug" || perl -i.bak -pe 's/-O2//g' $(find -name Makefil=
e)) &&
+	 (test -z "$debug_clean" || make clean) &&
+	 (make || test -f $DLL) &&
+	 (test ! -z "$debug" || strip $DLL) &&
+	 rebase -b 0x68000000 $DLL &&
+	 mv $DLL /bin/) &&
+	cd / &&
+	hash=3D$(git hash-object -w bin/new-msys-1.0.dll) &&
+	git update-index --cacheinfo 100755 $hash bin/msys-1.0.dll &&
+	git commit -s -m "Updated msys-1.0.dll to $release" &&
+	/share/msysGit/post-checkout-hook HEAD^ HEAD 1
+}
+
+# cross-build msys.dll
+# XXX $debug not handled
+# XXX $debug_clean not handled
+release_cross() {
+	root=3D$(cd ../../../../ && pwd) &&
+	w32api=3D$root/mingw/include &&
+	(
+	 (test -d bld || mkdir bld) &&
+	 cd bld
+
+	 # this is the cross prefix for mingw gcc on Debian
+	 X=3Di586-mingw32msvc
+
+	 DLL=3D$X/winsup/cygwin/new-msys-1.0.dll
+
+	 export CC=3D$X-gcc
+	 export CXX=3D$X-g++
+	 export AR=3D$X-ar
+	 export AS=3D$X-as
+	 export RANLIB=3D$X-ranlib
+	 export LD=3D$X-ld
+	 export DLLTOOL=3D$X-dlltool
+	 export WINDRES=3D$X-windres
+	 export STRIP=3D$X-strip
+
+	 (
+	  test -d $X || mkdir $X || die
+	  cd $X
+
+	  # strip0d config.sub in srctree
+	  # Unfortunately I have to do this in scrtree, yes :( or else on lin=
ux configure says:
+	  #
+	  #     configure: error: can not run
+	  #     .../config.sub
+	  #
+	  # and manually inspecting config.sub gives:
+	  #
+	  #     $ ./config.sub
+	  #     bash: ./config.sub: /bin/sh^M: bad interpreter: No such file =
or directory
+	  #
+	  # this is better done in a patch, but git has problems applying
+	  # patches with trailing ^M, and also it would be fragile to apply
+	  # such patch from under msys. Another possibility would be to someh=
ow
+	  # fool configure to take config.sub from objtree, and yes, this can
+	  # be done for newlib, but not for winsup/cygwin - the latter looks
+	  # for aux files only in srctree.
+	  #
+	  # So be it - we'll dirty the tree a bit, but this is relatively
+	  # harmles, since noone of us usually touches config.sub, and also
+	  # even after stripping, it runs ok under msys.
+	  ac_config_sub=3D../../src/config.sub
+	  tmpfile=3D`mktemp -t strip0d.XXXXXX` &&
+	  tr -d '\015' <$ac_config_sub >$tmpfile &&
+	  mv $tmpfile $ac_config_sub &&
+	  chmod +x $ac_config_sub ||
+	  die "Could not tweak config.sub"
+
+	  # shadow for needed libiberty bits
+	  test -d libiberty ||
+	  (echo ">>> shadow libiberty ..." &&
+	   mkdir libiberty &&
+	   ln -s -t libiberty/ ../../../src/libiberty/{random,strsignal}.c &&
+	   ln -s -t libiberty/ ../../../src/include/{ansidecl,libiberty}.h
+	  ) ||
+	  die "Could not shadow libiberty"
+
+	  test -f newlib/Makefile ||
+	  (echo -e ">>> configure newlib ...\n" &&
+	   mkdir -p newlib &&
+	   cd newlib &&
+
+	   # NOTE i686-pc-cygwin here!
+	   CPPFLAGS=3D"-D__MSYS__"	\
+	   ../../../src/newlib/configure	\
+	       --host=3Di686-pc-cygwin
+	  ) ||
+	  die "Could not cross-configure newlib"
+
+	  test -f winsup/cygwin/Makefile ||
+	  (echo -e "\n\n>>> configure winsup/cygwin ...\n"
+	   mkdir -p winsup/cygwin &&
+	   cd winsup/cygwin &&
+
+	   # NOTE CFLAGS=3D"-gstabs+ ..." is incompatible with wine loader
+	   # -isystem mingw/include for w32api *.h files
+	   CFLAGS=3D"-O2 -D__MSYS__ -isystem $w32api"	\
+	   ../../../../src/winsup/cygwin/configure	\
+	       --host=3D$X	\
+	  ) ||
+	  die "Could not cross-configure winsup/cygwin"
+
+	  make -C newlib 		|| die "Could not build newlib"
+	  make -C winsup/cygwin 	|| die "Could not build msys.dll"
+	 ) &&
+
+	 # TODO rebase $DLL (?)
+
+	 mv $DLL $root/bin/msys-1.0.dll &&
+	 cd $root &&
+	 git commit -s -m "Updated msys-1.0.dll to cross-compiled $release" b=
in/msys-1.0.dll
+	)
+}
+
+
+if test -z "$cross" ; then
+	release_native
+else
+	release_cross
+fi
