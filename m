From: Krzysiek Pawlik <krzysiek.pawlik@people.pl>
Subject: Recoding of {git,cg}-log output
Date: Mon, 27 Feb 2006 01:10:44 +0100
Message-ID: <44024384.4060406@people.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigED376D7AFE4640D6D2F05B38"
X-From: git-owner@vger.kernel.org Mon Feb 27 01:10:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDVyS-00013i-JE
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 01:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWB0AKq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 19:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWB0AKp
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 19:10:45 -0500
Received: from people.pl ([212.85.96.54]:25822 "HELO v00054.home.net.pl")
	by vger.kernel.org with SMTP id S1750701AbWB0AKp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2006 19:10:45 -0500
Received: from localhost (HELO ?192.168.1.1?) (krzysiek.pawlik.people@home@127.0.0.1)
  by matrix01.home.net.pl with SMTP; Mon, 27 Feb 2006 00:10:39 -0000
User-Agent: Mail/News 1.5 (X11/20060206)
To: Git Mailing List <git@vger.kernel.org>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=BC555551
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16810>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigED376D7AFE4640D6D2F05B38
Content-Type: multipart/mixed;
 boundary="------------090402010900060507030605"

This is a multi-part message in MIME format.
--------------090402010900060507030605
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


First: a little "why": having /usr/bin/vim as PAGER allows to enter
UTF-8 commit messages quite easily, the problem is when git-log (or
cg-log) is run in terminal that's not UTF-8. In my case: terminal is
ISO-8859-2 and:

nelchael@nelchael ~$ cat ~/.vimrc | grep gitci
au BufRead /tmp/gitci* setlocal textwidth=3D75 fileencoding=3Dutf-8
encoding=3Dutf-8 fileencodings=3Dutf-8,default

So... having {git,cg}-log recode the log entires when displaying is
quite useful. Two patches attached:

 a. git-log-recode.patch - uses iconv to recode the log output to
GIT_LOG_RECODE encoding
 b. cg-log-recode.patch - the same, but for cogito

With this patches it's possible to write UTF-8 commit messages and see
them ok in non-UTF-8 terminal in log by having GIT_LOG_RECODE=3Diso-8859-=
2.

Comments?

--=20
Krzysiek Pawlik (Nelchael)
RLU #322999 GPG Key ID: 0xBC555551

--------------090402010900060507030605
Content-Type: text/plain;
 name="cg-log-recode.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="cg-log-recode.patch"

LS0tIC91c3IvYmluL2NnLWxvZwkyMDA2LTAxLTE5IDE3OjIyOjIyLjAwMDAwMDAwMCArMDEw
MAorKysgYmluL2NnLWxvZwkyMDA2LTAyLTI3IDAwOjU5OjA3LjAwMDAwMDAwMCArMDEwMApA
QCAtMzQ4LDEzICszNDgsMjEgQEAKIAogaWYgWyAiJHNob3J0bG9nIiBdOyB0aGVuCiAJIyBT
cGVjaWFsIGNhcmUgaGVyZS4KLQkkcmV2bHMgJHNlcCAiJHtBUkdTW0BdfSIgfCBnaXQtc2hv
cnRsb2cgfCBwYWdlcgorCWlmIFsgLW4gIiR7R0lUX0xPR19SRUNPREV9IiBdOyB0aGVuCisJ
CSRyZXZscyAkc2VwICIke0FSR1NbQF19IiB8IGdpdC1zaG9ydGxvZyB8IGljb252IC0tZnJv
bS1jb2RlPVVURi04IC0tdG8tY29kZT0iJHtHSVRfTE9HX1JFQ09ERX0iIHwgcGFnZXIKKwll
bHNlCisJCSRyZXZscyAkc2VwICIke0FSR1NbQF19IiB8IGdpdC1zaG9ydGxvZyB8IHBhZ2Vy
CisJZmkKIAlleGl0CiBmaQogCiAKICMgTEVTUz0iUyIgd2lsbCBwcmV2ZW50IGxlc3MgdG8g
d3JhcCB0b28gbG9uZyB0aXRsZXMgdG8gbXVsdGlwbGUgbGluZXM7CiAjIHlvdSBjYW4gc2Ny
b2xsIGhvcml6b250YWxseS4KLSRyZXZscyAkc2VwICIke0FSR1NbQF19IiB8IHByaW50X2Nv
bW1pdF9sb2cgfCBfbG9jYWxfQ0dfTEVTUz0iUyIgcGFnZXIKK2lmIFsgLW4gIiR7R0lUX0xP
R19SRUNPREV9IiBdOyB0aGVuCisJJHJldmxzICRzZXAgIiR7QVJHU1tAXX0iIHwgcHJpbnRf
Y29tbWl0X2xvZyB8IGljb252IC0tZnJvbS1jb2RlPVVURi04IC0tdG8tY29kZT0iJHtHSVRf
TE9HX1JFQ09ERX0iIHwgX2xvY2FsX0NHX0xFU1M9IlMiIHBhZ2VyCitlbHNlCisJJHJldmxz
ICRzZXAgIiR7QVJHU1tAXX0iIHwgcHJpbnRfY29tbWl0X2xvZyB8IF9sb2NhbF9DR19MRVNT
PSJTIiBwYWdlcgorZmkKIAogZXhpdCAwCg==
--------------090402010900060507030605
Content-Type: text/plain;
 name="git-log-recode.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="git-log-recode.patch"

LS0tIC91c3IvYmluL2dpdC1sb2cJMjAwNi0wMi0yMyAxODozMTozMi4wMDAwMDAwMDAgKzAx
MDAKKysrIGJpbi9naXQtbG9nCTIwMDYtMDItMjcgMDA6NDc6MzQuMDAwMDAwMDAwICswMTAw
CkBAIC0xMSw1ICsxMSwxMSBAQAogWyAiJHJldnMiIF0gfHwgewogCWRpZSAiTm8gSEVBRCBy
ZWYiCiB9Ci1naXQtcmV2LWxpc3QgLS1wcmV0dHkgJChnaXQtcmV2LXBhcnNlIC0tZGVmYXVs
dCBIRUFEICIkQCIpIHwKLUxFU1M9LVMgJHtQQUdFUjotbGVzc30KK2lmIFsgLW4gIiR7R0lU
X0xPR19SRUNPREV9IiBdOyB0aGVuCisJZ2l0LXJldi1saXN0IC0tcHJldHR5ICQoZ2l0LXJl
di1wYXJzZSAtLWRlZmF1bHQgSEVBRCAiJEAiKSB8IFwKKwkJaWNvbnYgLS1mcm9tLWNvZGU9
VVRGLTggLS10by1jb2RlPSIke0dJVF9MT0dfUkVDT0RFfSIgfCBcCisJCUxFU1M9LVMgJHtQ
QUdFUjotbGVzc30KK2Vsc2UKKwlnaXQtcmV2LWxpc3QgLS1wcmV0dHkgJChnaXQtcmV2LXBh
cnNlIC0tZGVmYXVsdCBIRUFEICIkQCIpIHwgXAorCUxFU1M9LVMgJHtQQUdFUjotbGVzc30K
K2ZpCg==
--------------090402010900060507030605--

--------------enigED376D7AFE4640D6D2F05B38
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQFEAkOEgo/w9rxVVVERAueDAKCzwhK9Cv9rBbGk4FGqwtwWbORbPwCgpYlY
6+qHpb6eX90frh4JbiC4uYk=
=FYrG
-----END PGP SIGNATURE-----

--------------enigED376D7AFE4640D6D2F05B38--
