From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: Re: Bug: Problem with CRLF line ending in git-diff with coloring
Date: Fri, 14 Feb 2014 17:47:09 +0100
Organization: -no organization-
Message-ID: <20140214164709.GI7560@pille.home>
References: <20140209110155.GB16189@scotty.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 14 17:51:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WELz7-0004kP-S0
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 17:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752935AbaBNQtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 11:49:22 -0500
Received: from moutng.kundenserver.de ([212.227.17.8]:64397 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752907AbaBNQtT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 11:49:19 -0500
Received: from pille.home (port-92-205-19-133.dynamic.qsc.de [92.205.19.133])
	by mrelayeu.kundenserver.de (node=mreue001) with ESMTP (Nemesis)
	id 0LwRR9-1V6ttb2woB-018GN7; Fri, 14 Feb 2014 17:49:17 +0100
Received: from pille.home (localhost [127.0.0.1])
	by pille.home (8.14.4/8.14.4/Debian-4) with ESMTP id s1EGmZ7n029634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2014 17:48:36 +0100
Received: (from hs@localhost)
	by pille.home (8.14.4/8.14.4/Submit) id s1EGlAkl029629;
	Fri, 14 Feb 2014 17:47:10 +0100
X-Authentication-Warning: pille.home: hs set sender to stefan.hahn@s-hahn.de using -f
Content-Disposition: inline
In-Reply-To: <20140209110155.GB16189@scotty.home>
X-Mailer: Mutt http://www.mutt.org/
X-Editor: GNU Emacs http://www.gnu.org/
X-Accept-Language: de en
X-Location: Europe, Germany, Wolfenbuettel
X-GPG-Public-Key: gpg --keyserver keys.gnupg.net --recv-keys E4FCD563
X-GPG-Fingerprint: 0xE4FCD563 / EF09 97BB 3731 7DC7 25BA 5C39 185C F986 E4FC
 D563
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:VNZQiCzf439J1X+4j1e4Nxok7OxDd1sPcEDgCUeE5+5
 blgCvDc0M4DrQihm+y6ZnfNU6g7S0/ubhMuEGmyl4N4HaZOArk
 0TrSducYItbs/86x0ysTkGsC6Zh7r5UvyvUyFnKLBHvC8rvbeR
 f0iXTRYnbwd1vVb5MHhfVtz8gcisIHrybuuHaMA9jBxh4kbJnI
 KQbgHT1CEJx4AugHDr1lm5W0xnd7cprNFfOBvbeVdVrsGG/Enf
 sFk6rcZ12/J8/O/hyDBpHB6Jeln2cH74Xfr0kITZG5ZPDh8cPd
 NA3NZuud6+BQTQR2qXMsTPlp86GJQgk7DcHykYCpIjJcZ8CpiO
 /wZESsydPveCJ7p+EAR4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242111>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Mail von Stefan-W. Hahn, Sun, 09 Feb 2014 at 12:01:55 +0100:

Good afternoon,

I updated the test a little bit. Test 3 and 7 are going wrong.
Both tests have a CRLF line ending in the changed line.

I you redirect the output of the test to a file you see the main
problem:

,----
| -=1B[32m+=1B[m=1B[32mZeile 22=1B[m=1B[32m=0D=1B[m
| +=1B[32m+=1B[m=1B[32mZeile 22=1B[m=1B[41m=0D=1B[m
`----

> It's the right solution. IOW, you should place something like this in
> your .gitattributes:
>  *.html whitespace=3Dcr-at-eol

Sorry, but this is not possible, because I have files of both sorts (mainly
C/C++) files in my repository and cannot change the files as I wish.

With kind regards,
Stefan

--=20
Stefan-W. Hahn                          It is easy to make things.
                                        It is hard to make things simple.

--YZ5djTAD1cGYuMQK
Content-Type: application/x-sh
Content-Disposition: attachment; filename="t4060-diff-eol.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A#=0A# Copyright (c) 2014 Stefan-W. Hahn=0A#=0A=0Atest_descripti=
on=3D'Test coloring of diff with CRLF line ending.=0A=0A'=0A. ./test-lib.sh=
=0A=0Aget_color ()=0A{=0A	git config --get-color "$1"=0A}=0A=0Atest_expect_=
success setup '=0A        git config color.diff.plain black &&=0A        gi=
t config color.diff.meta blue &&=0A        git config color.diff.frag yello=
w &&=0A        git config color.diff.func normal &&=0A        git config co=
lor.diff.old red &&=0A        git config color.diff.new green &&=0A        =
git config color.diff.commit normal &&=0A	c_reset=3D$(git config --get-colo=
r no.such.color reset) &&=0A	c_plain=3D$(get_color color.diff.plain) &&=0A	=
c_meta=3D$(get_color color.diff.meta) &&=0A	c_frag=3D$(get_color color.diff=
=2Efrag) &&=0A	c_func=3D$(get_color color.diff.func) &&=0A	c_old=3D$(get_co=
lor color.diff.old) &&=0A	c_new=3D$(get_color color.diff.new) &&=0A	c_commi=
t=3D$(get_color color.diff.commit) &&=0A	c_whitespace=3D$(get_color color.d=
iff.whitespace)=0A'=0A=0A# Test cases=0A# - DOS line ending=0A#   - change =
one line=0A#   - change one line ending to UNIX=0A# - UNIX line ending=0A# =
  - change one line (trivial not tested here)=0A#   - change one line endin=
g to DOS=0A=0Atr 'Q' '\015' << EOF > x=0AZeile 1Q=0AZeile 2Q=0AZeile 3Q=0AE=
OF=0A=0Agit update-index --add x=0A=0Atr 'Q' '\015' << EOF > x=0AZeile 1Q=
=0AZeile 22Q=0AZeile 3Q=0AEOF=0A=0Atr 'Q' '\015' << EOF > expect=0Adiff --g=
it a/x b/x=0Aindex 3411cc1..68a4b2c 100644=0A--- a/x=0A+++ b/x=0A@@ -1,3 +1=
,3 @@=0A Zeile 1Q=0A-Zeile 2Q=0A+Zeile 22Q=0A Zeile 3Q=0AEOF=0A=0Atr 'Q' '\=
015' << EOF > expect_color=0A${c_meta}diff --git a/x b/x${c_reset}=0A${c_me=
ta}index 3411cc1..68a4b2c 100644${c_reset}=0A${c_meta}--- a/x${c_reset}=0A$=
{c_meta}+++ b/x${c_reset}=0A${c_frag}@@ -1,3 +1,3 @@${c_reset}=0A${c_plain}=
 Zeile 1${c_reset}Q=0A${c_old}-Zeile 2${c_reset}Q=0A${c_new}+${c_reset}${c_=
new}Zeile 22${c_reset}${c_new}Q${c_reset}=0A${c_plain} Zeile 3${c_reset}Q=
=0AEOF=0A=0Agit -c color.diff=3Dfalse diff > out=0Atest_expect_success "dif=
f files: change line in DOS file without color" '=0A        test_cmp expect=
 out'=0A=0Agit -c color.diff=3Dalways diff > out=0Atest_expect_success "dif=
f files: change line in DOS file with color" '=0A        test_cmp expect_co=
lor out'=0A=0A=0Atr 'Q' '\015' << EOF > x=0AZeile 1Q=0AZeile 2Q=0AZeile 3Q=
=0AEOF=0A=0Agit update-index --add x=0A=0Atr 'Q' '\015' << EOF > x=0AZeile =
1Q=0AZeile 2=0AZeile 3Q=0AEOF=0A=0Atr 'Q' '\015' << EOF > expect=0Adiff --g=
it a/x b/x=0Aindex 3411cc1..c040c67 100644=0A--- a/x=0A+++ b/x=0A@@ -1,3 +1=
,3 @@=0A Zeile 1Q=0A-Zeile 2Q=0A+Zeile 2=0A Zeile 3Q=0AEOF=0A=0Atr 'Q' '\01=
5' << EOF > expect_color=0A${c_meta}diff --git a/x b/x${c_reset}=0A${c_meta=
}index 3411cc1..c040c67 100644${c_reset}=0A${c_meta}--- a/x${c_reset}=0A${c=
_meta}+++ b/x${c_reset}=0A${c_frag}@@ -1,3 +1,3 @@${c_reset}=0A${c_plain} Z=
eile 1${c_reset}Q=0A${c_old}-Zeile 2${c_reset}Q=0A${c_new}+${c_reset}${c_ne=
w}Zeile 2${c_reset}=0A${c_plain} Zeile 3${c_reset}Q=0AEOF=0A=0Agit -c color=
=2Ediff=3Dfalse diff > out=0Atest_expect_success "diff files: change line e=
nding in DOS file to LF ending without color" '=0A        test_cmp expect o=
ut'=0A=0Agit -c color.diff=3Dalways diff > out=0Atest_expect_success "diff =
files: change line ending in DOS file to LF ending with color" '=0A        =
test_cmp expect_color out'=0A=0Atr 'Q' '\015' << EOF > x=0AZeile 1=0AZeile =
2=0AZeile 3=0AEOF=0A=0Agit update-index --add x=0A=0Atr 'Q' '\015' << EOF >=
 x=0AZeile 1=0AZeile 2Q=0AZeile 3=0AEOF=0A=0Atr 'Q' '\015' << EOF > expect=
=0Adiff --git a/x b/x=0Aindex a385875..63416d7 100644=0A--- a/x=0A+++ b/x=
=0A@@ -1,3 +1,3 @@=0A Zeile 1=0A-Zeile 2=0A+Zeile 2Q=0A Zeile 3=0AEOF=0A=0A=
tr 'Q' '\015' << EOF > expect_color=0A${c_meta}diff --git a/x b/x${c_reset}=
=0A${c_meta}index a385875..63416d7 100644${c_reset}=0A${c_meta}--- a/x${c_r=
eset}=0A${c_meta}+++ b/x${c_reset}=0A${c_frag}@@ -1,3 +1,3 @@${c_reset}=0A$=
{c_plain} Zeile 1${c_reset}=0A${c_old}-Zeile 2${c_reset}=0A${c_new}+${c_res=
et}${c_new}Zeile 2${c_reset}${c_new}Q${c_reset}=0A${c_plain} Zeile 3${c_res=
et}=0AEOF=0A=0Agit -c color.diff=3Dfalse diff > out=0Atest_expect_success "=
diff files: change line ending in UNIX file to CRLF ending without color" '=
=0A        test_cmp expect out'=0A=0Agit -c color.diff=3Dalways diff > out=
=0Atest_expect_success "diff files: change line ending in UNIX file to CRLF=
 ending with color" '=0A        test_cmp expect_color out'=0A=0Atest_done=0A
--YZ5djTAD1cGYuMQK--
