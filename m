From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Failing tests in t0027-autocrlf.sh under msysgit/git-win-sdk
Date: Thu, 02 Oct 2014 15:42:18 +0200
Message-ID: <542D563A.8070306@web.de>
References: <542D4769.60503@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git-win-sdk@googlegroups.com
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>,
	GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 02 15:42:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZgeH-0004jV-Vw
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 15:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076AbaJBNmW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Oct 2014 09:42:22 -0400
Received: from mout.web.de ([212.227.17.12]:61672 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607AbaJBNmW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2014 09:42:22 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MA5qv-1XOSMU1buD-00BN4p; Thu, 02 Oct 2014 15:42:19
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <542D4769.60503@virtuell-zuhause.de>
X-Provags-ID: V03:K0:LWl1NRbRT1emHc7XxnE9g0ZEyyG7YIobxlBifyM3VfW/B8Nse+o
 k8KF06YY8R+WUFynlthKuBC9NlqkTPSKi3NSLioAE8C4T0HnLRZkmJi4aCwQaYiT0uQxED5
 tDfy1hP9NyOsLA8HfEf4oq+OYq95qe4qUjMy2oGKc1gjoVvTgmpUQGQwJdwuNw8L7PtIGOT
 Mz/m4IdZwE3os5xMAXarA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257806>

On 2014-10-02 14.39, Thomas Braun wrote:
> Hi,
>=20
> I've enabled EXPENSIVE and ran the git test suite under msysgit/git-w=
in-sdk with
> git version 2.1.0.9753.g360f311.dirty.
>=20
> Now I have some failing tests in t0027-autocrlf.sh in the MINGW only =
section which puzzle me.
>=20
> The offending test sets are
>=20
> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> index 72dd3e8..90c4cd1 100755
> --- a/t/t0027-auto-crlf.sh
> +++ b/t/t0027-auto-crlf.sh
> @@ -245,18 +245,18 @@ if test_have_prereq MINGW
>  then
>  check_files_in_ws ""      false ""        LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
>  check_files_in_ws ""      true  ""        CRLF  CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -check_files_in_ws ""      false "auto"    LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> +# check_files_in_ws ""      false "auto"    LF    CRLF  CRLF_mix_LF =
 LF_mix_CR    CRLF_nul # first broken

>  check_files_in_ws ""      true  "auto"    CRLF  CRLF  CRLF         L=
=46_mix_CR    CRLF_nul
> -check_files_in_ws ""      false "text"    LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> +# check_files_in_ws ""      false "text"    LF    CRLF  CRLF_mix_LF =
 LF_mix_CR    CRLF_nul # broken
>  check_files_in_ws ""      true  "text"    CRLF  CRLF  CRLF         C=
RLF_mix_CR  CRLF_nul
>  check_files_in_ws ""      false "-text"   LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
>  check_files_in_ws ""      true  "-text"   LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> =20
>  check_files_in_ws native  false ""        LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
>  check_files_in_ws native  true  ""        CRLF  CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -check_files_in_ws native  false "auto"    LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> +# check_files_in_ws native  false "auto"    LF    CRLF  CRLF_mix_LF =
 LF_mix_CR    CRLF_nul # broken
>  check_files_in_ws native  true  "auto"    CRLF  CRLF  CRLF         L=
=46_mix_CR    CRLF_nul
> -check_files_in_ws native  false "text"    LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> +# check_files_in_ws native  false "text"    LF    CRLF  CRLF_mix_LF =
 LF_mix_CR    CRLF_nul # broken
>  check_files_in_ws native  true  "text"    CRLF  CRLF  CRLF         C=
RLF_mix_CR  CRLF_nul
>  check_files_in_ws native  false "-text"   LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
>  check_files_in_ws native  true  "-text"   LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
>=20
> I tried with NATIVE_CRLF =3D YesPlease but 117 failed too.
>=20
> First question, under what MINGW system do these tests pass?
> Second question any hints how to tackle this?

>=20
> The first failing test is
> not ok 117 - checkout core.eol=3D core.autocrlf=3Dfalse gitattributes=
=3Dauto file=3DLF
> #
> #                       compare_ws_file eol__crlf_false_attr_auto_ LF=
    crlf_false_attr__LF.txt
> #
>=20
>=20
> where I have in the trash directory
>=20
> $ diff -Nur *expect* *actual*
> --- LF.expect   2014-10-02 12:15:17 +0000
> +++ eol__crlf_false_attr_auto_.actual.crlf_false_attr__LF.txt   2014-=
10-02 12:15

=46irst things first:
We have a file with LF in the repo, and check it out.

Read it like this:
"eol__crlf_false_attr_auto_.actual"
                 ^ *.txt auto in .gitconfig  =20
      ^
      core.autocrlf is false=20
  ^
  core.eol is unset

The file is expected to have LF in the working tree, but has CRLF

> :17 +0000
> @@ -1,3 +1,3 @@
> -0000000   l   i   n   e   1  \n   l   i   n   e   2  \n   l   i   n =
  e
> -0000020   3
> -0000021
> +0000000   l   i   n   e   1  \r  \n   l   i   n   e   2  \r  \n   l =
  i
> +0000020   n   e   3
> +0000023
>=20
> Reading convert.h tells me that for undefined NATIVE_CRLF the native =
EOL is LF.
> Which looks like the test is correct.
>=20
> Thomas
>=20
Which version of t0027 do you have:
The latest version in git.git is this one,
and "should pass" (but I may have missed something)

commit f6975a6b119128de1c5a89e6cd64f75ed1de2177
Author: Torsten B=C3=B6gershausen <tboegi@web.de>
Date:   Sat Aug 16 22:16:58 2014 +0200

    t0027: Tests for core.eol=3Dnative, eol=3Dlf, eol=3Dcrlf
   =20
    Add test cases for core.eol "native" and "" (unset).
    (MINGW uses CRLF, all other systems LF as native line endings)
   =20
    Add test cases for the attributes "eol=3Dlf" and "eol=3Dcrlf"
   =20
    Other minor changes:
    - Use the more portable 'tr' instead of 'od -c' to convert '\n' int=
o 'Q'
      and '\0' into 'N'
    - Style fixes for shell functions according to the coding guide lin=
es
    - Replace "txtbin" with "attr"
   =20
    Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
