From: Till =?ISO-8859-1?Q?Sch=E4fer?= <till2.schaefer@tu-dortmund.de>
Subject: Re: git clone svn: authors from authors file are ignored, authors-prog works, but crashes on branch points
Date: Thu, 10 Sep 2015 19:29:37 +0200
Organization: TU Dortmund
Message-ID: <5258505.eFJUESI73n@granit>
References: <5613050.3arVUQYvEz@granit> <55F17847.9020401@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Sep 10 19:30:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za5fU-00037f-6q
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 19:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbbIJR3t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Sep 2015 13:29:49 -0400
Received: from mx1.HRZ.tu-dortmund.de ([129.217.128.51]:36923 "EHLO
	unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbbIJR3r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Sep 2015 13:29:47 -0400
Received: from granit.localnet (granit.cs.uni-dortmund.de [129.217.38.151])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.15.2/8.15.2) with ESMTPSA id t8AHTbdS027365
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 10 Sep 2015 19:29:42 +0200 (CEST)
User-Agent: KMail/4.14.10 (Linux/4.0.5-gentoo; KDE/4.14.11; x86_64; ; )
In-Reply-To: <55F17847.9020401@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277611>

Hi,=20
I can confirm, that the patch (see mail: "[PATCH] git-svn: parse author=
s file more leniently") fixes the "Author: **** not defined in **** fil=
e" problem in my case.=20

Downgrading to subversion 1.8.13 (from 1.8.14) also fixes the branching=
 crash in revision 17. With subversion 1.8.14 i still get: =20

=46ound possible branch point: svn://svn.code.sf.net/p/scaffoldhunter/c=
ode/trunk =3D> svn://svn.code.sf.net/p/scaffoldhunter/code/branches/sub=
search, 17
Use of uninitialized value $u in substitution (s///) at /usr/lib64/perl=
5/vendor_perl/5.20.2/Git/SVN.pm line 101.
Use of uninitialized value $u in concatenation (.) or string at /usr/li=
b64/perl5/vendor_perl/5.20.2/Git/SVN.pm line 101.
refs/remotes/origin/trunk: 'svn://svn.code.sf.net/p/scaffoldhunter/code=
' not found in ''


Am Donnerstag, 10. September 2015, 14:32:07 schrieb Michael J Gruber:
> Till Sch=C3=A4fer venit, vidit, dixit 26.08.2015 21:57:
> > Hi,
> > i am observing some weired "git svn clone" behavior during my try t=
o migrate the Scaffold Hunter [1] SVN repository [2] to Git:=20
> >=20
> > if i just use the command=20
> >=20
> > $ git svn clone svn://svn.code.sf.net/p/scaffoldhunter/code --no-me=
tadata -s code
>=20
> Is there a specific reason for "--no-metadata"? The man page advises
> against it. Basically, it keeps you from converting the history in
> chunks. (You can always filter-branch everything after a complete, "o=
ne
> shot" conversion which may be done in stages.)

i was basically following the tutorial at git-scm [1] (which is also so=
mewhat outdated in the later svn branch conversion). Anyway, i did not =
read the manual :-/ (man-page)


Regards,=20
Till

[1] https://git-scm.com/book/en/v2/Git-and-Other-Systems-Migrating-to-G=
it










>=20
> > everything went smoothly. Now i wanted to replace the authors SVN-l=
ogins by useful names and created a mapping file with the following con=
tent:=20
> >=20
> > anjenson =3D Andrew Zhilka <>
> > bernhard.dick =3D Bernhard Dick <>
> > dominic.sacre =3D Dominic Sacr=C3=A9 <>
> > doxmoxbox =3D doxmoxbox <>
> > falkn =3D Falk Nette <>
> > henning.garus =3D Henning Garus <>
> > kakl =3D Karsten Klein <>
> > klein =3D Karsten Klein <>
> > lappie00 =3D Jeroen Lappenschaar <>
> > michael.hesse =3D Michael Hesse <>
> > nlskrg =3D Nils Kriege <nlskrg@gmail.com>
> > philipp.kopp =3D Philipp Kopp <>
> > philipp.lewe =3D Philipp Lewe <>
> > schrins =3D Sven Schrinner <>
> > shamshadnpti =3D Shamshad Alam <>
> > srenner7 =3D Steffen Renner <>
> > sturm89 =3D Werner Sturm <>
> > thomas.schmitz =3D Thomas Schmitz <>
> > thorsten.fluegel =3D Thorsten Fl=C3=BCgel <>
> > till.schaefer =3D Till Sch=C3=A4fer <till2.schaefer@tu-dortmund.de>
> > tillschaefer =3D Till Sch=C3=A4fer <till2.schaefer@tu-dortmund.de>
> >=20
> >=20
> > I executed:
> >=20
> > $ git svn clone svn://svn.code.sf.net/p/scaffoldhunter/code --autho=
rs-file=3D/home/till/temp/code-authors-transform.txt --no-metadata -s c=
ode
> >=20
> > and got the error message "Author: klein not defined in /home/till/=
temp/code-authors-transform.txt file".=20
> > I tried a workaround by using a python script to return the entries=
 i have already defined in the authors file:=20
> >=20
> > $ git svn clone svn://svn.code.sf.net/p/scaffoldhunter/code --autho=
rs-file=3D/home/till/temp/code-authors-transform.txt --authors-prog=3D/=
home/till/temp/authors.py --no-metadata -s code
> >=20
> > The import process now went over the "klein" commit. The weired thi=
ng is, that a few SVN usernames seem to be recognized in the authors fi=
le and a few are passed to my script (I logged the output). However, at=
 the first revision, where a tag was added in the SVN repo the cloning =
process crashed with the error message:=20
>=20
> That first part is weird already. The reason is that author-file
> processing and author-prog output processing use different perl regex=
ps.
> I will follow up with a patch.
>=20
> > Found possible branch point: svn://svn.code.sf.net/p/scaffoldhunter=
/code/trunk =3D> svn://svn.code.sf.net/p/scaffoldhunter/code/branches/s=
ubsearch, 17
> > Use of uninitialized value $u in substitution (s///) at /usr/lib64/=
perl5/vendor_perl/5.20.2/Git/SVN.pm line 101.
> > Use of uninitialized value $u in concatenation (.) or string at /us=
r/lib64/perl5/vendor_perl/5.20.2/Git/SVN.pm line 101.
> > refs/remotes/origin/trunk: 'svn://svn.code.sf.net/p/scaffoldhunter/=
code' not found in ''
> >=20
> > One problem I am seeing in the SVN repo is, that between the revisi=
ons 97 and 102 the trunk folder was absent. the old one was moved to so=
me subfolder and a new one was created. Therefore, I started the clonin=
g beginning with rev 102 using the command line option "-r102:HEAD". Ho=
wever, the same error occurred for some later tag (the first tag after =
rev 102).=20
> >=20
> > Found possible branch point: svn://svn.code.sf.net/p/scaffoldhunter=
/code/trunk =3D> svn://svn.code.sf.net/p/scaffoldhunter/code/tags/relea=
se-2.0, 1565
> > Use of uninitialized value $u in substitution (s///) at /usr/lib64/=
perl5/vendor_perl/5.20.2/Git/SVN.pm line 101.
> > Use of uninitialized value $u in concatenation (.) or string at /us=
r/lib64/perl5/vendor_perl/5.20.2/Git/SVN.pm line 101.
> > refs/remotes/origin/trunk: 'svn://svn.code.sf.net/p/scaffoldhunter/=
code' not found in ''
> >=20
> > I would be very glad if someone has a hint about what is going wron=
g here. Is this a bug in git or is something wrong with the SVN repo?
>=20
> The layout change (no root) certainly doesn't help. We shouldn't cras=
h,
> though.
>=20
> > used software versions:=20
> > - git 2.5.0=20
> > - subversion 1.8.14
>=20
> The conversion goes through for me with (your other options and) your
> authors file and specifying a stupid authors prog:
>=20
> --->8---
> #!/bin/sh
> grep "$1" /tmp/t/authors | head -n 1 | cut -d'=3D' -f2 | cut -c'2-'
> --->8---
>=20
> and:
>=20
> git version 2.6.0.rc0.178.g4177fa5
> svn, Version 1.8.13 (r1667537)
>=20
> with our without --authors-file...
>=20
> (It went also through with a patched git-svn and just the authors fil=
e.)
>=20
> I don't think git-svn has changed since git 2.5.0. Maybe you can
> downgrade svn for the one-shot conversion? I don't see anything
> suspicious in their changelog but don't remember it as being overly
> complete.
>=20
> git svn served us well in making itself mostly obsolete. The downside=
 is
> that not many are using it any more. Keeping up with subversion chang=
es
> (to keep git svn working) has become more and more difficult.
>=20
> Michael





--=20
Dipl.-Inf. Till Sch=C3=A4fer
TU Dortmund University
Chair 11 - Algorithm Engineering
Otto-Hahn-Str. 14 / Room 237
44227 Dortmund, Germany

e-mail: till.schaefer@cs.tu-dortmund.de
phone: +49(231)755-7706
fax: +49(231)755-7740
web: http://ls11-www.cs.uni-dortmund.de/staff/schaefer
pgp: https://keyserver2.pgp.com/vkd/SubmitSearch.event?&&SearchCriteria=
=3D0xD84DED79
