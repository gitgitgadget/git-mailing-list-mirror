From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git clone svn: authors from authors file are ignored,
 authors-prog works, but crashes on branch points
Date: Thu, 10 Sep 2015 14:32:07 +0200
Message-ID: <55F17847.9020401@drmicha.warpmail.net>
References: <5613050.3arVUQYvEz@granit>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?Q?Till_Sch=c3=a4fer?= <till2.schaefer@tu-dortmund.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 10 14:32:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za11Z-0008Ku-Ae
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 14:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971AbbIJMcN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Sep 2015 08:32:13 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45170 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753426AbbIJMcK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Sep 2015 08:32:10 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 4C0142126E
	for <git@vger.kernel.org>; Thu, 10 Sep 2015 08:32:09 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Thu, 10 Sep 2015 08:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=i29xd5ozq/eyA+KAMk2+qdj0MqI=; b=gA8cH3
	Evq2gCojzhPWOO7m5xCXJ7CBJKFrpnvzruupHPoTXw6K7BeS+V/uofMluPEf3Vzf
	87JN7Ead9JjWjuzoC1bfJXXTsm5hGqCYUxXVdzRJM9NL+93MOqmcVs++ga1nTjfE
	kIqyZb2R5Mou1yIvn4vYU9lok4PNHOQciRRXk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=i29xd5ozq/eyA+K
	AMk2+qdj0MqI=; b=RqDikvaQY56wMpCoZHdoYbwLUUa0FgltpYiKjBLbUusoFm5
	rkHC6tVPGyCiZuGuGdFUBM0kohxgEP4tWz23aPnKeiwK7AmQdu3xqoM0L7XXw5Zr
	lb7WMUhR9iKg98qi8fy6uUaG/IN58g3c0ysOuvLDz4ymLCqK5p4N01EVKll4=
X-Sasl-enc: VgcaUDDnaNxA7cGp4+jaw9rM4Q+nw0LhKJDzVOwKCufY 1441888329
Received: from localhost.localdomain (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id C9980C0028A;
	Thu, 10 Sep 2015 08:32:08 -0400 (EDT)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <5613050.3arVUQYvEz@granit>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277581>

Till Sch=C3=A4fer venit, vidit, dixit 26.08.2015 21:57:
> Hi,
> i am observing some weired "git svn clone" behavior during my try to =
migrate the Scaffold Hunter [1] SVN repository [2] to Git:=20
>=20
> if i just use the command=20
>=20
> $ git svn clone svn://svn.code.sf.net/p/scaffoldhunter/code --no-meta=
data -s code

Is there a specific reason for "--no-metadata"? The man page advises
against it. Basically, it keeps you from converting the history in
chunks. (You can always filter-branch everything after a complete, "one
shot" conversion which may be done in stages.)

> everything went smoothly. Now i wanted to replace the authors SVN-log=
ins by useful names and created a mapping file with the following conte=
nt:=20
>=20
> anjenson =3D Andrew Zhilka <>
> bernhard.dick =3D Bernhard Dick <>
> dominic.sacre =3D Dominic Sacr=C3=A9 <>
> doxmoxbox =3D doxmoxbox <>
> falkn =3D Falk Nette <>
> henning.garus =3D Henning Garus <>
> kakl =3D Karsten Klein <>
> klein =3D Karsten Klein <>
> lappie00 =3D Jeroen Lappenschaar <>
> michael.hesse =3D Michael Hesse <>
> nlskrg =3D Nils Kriege <nlskrg@gmail.com>
> philipp.kopp =3D Philipp Kopp <>
> philipp.lewe =3D Philipp Lewe <>
> schrins =3D Sven Schrinner <>
> shamshadnpti =3D Shamshad Alam <>
> srenner7 =3D Steffen Renner <>
> sturm89 =3D Werner Sturm <>
> thomas.schmitz =3D Thomas Schmitz <>
> thorsten.fluegel =3D Thorsten Fl=C3=BCgel <>
> till.schaefer =3D Till Sch=C3=A4fer <till2.schaefer@tu-dortmund.de>
> tillschaefer =3D Till Sch=C3=A4fer <till2.schaefer@tu-dortmund.de>
>=20
>=20
> I executed:
>=20
> $ git svn clone svn://svn.code.sf.net/p/scaffoldhunter/code --authors=
-file=3D/home/till/temp/code-authors-transform.txt --no-metadata -s cod=
e
>=20
> and got the error message "Author: klein not defined in /home/till/te=
mp/code-authors-transform.txt file".=20
> I tried a workaround by using a python script to return the entries i=
 have already defined in the authors file:=20
>=20
> $ git svn clone svn://svn.code.sf.net/p/scaffoldhunter/code --authors=
-file=3D/home/till/temp/code-authors-transform.txt --authors-prog=3D/ho=
me/till/temp/authors.py --no-metadata -s code
>=20
> The import process now went over the "klein" commit. The weired thing=
 is, that a few SVN usernames seem to be recognized in the authors file=
 and a few are passed to my script (I logged the output). However, at t=
he first revision, where a tag was added in the SVN repo the cloning pr=
ocess crashed with the error message:=20

That first part is weird already. The reason is that author-file
processing and author-prog output processing use different perl regexps=
=2E
I will follow up with a patch.

> Found possible branch point: svn://svn.code.sf.net/p/scaffoldhunter/c=
ode/trunk =3D> svn://svn.code.sf.net/p/scaffoldhunter/code/branches/sub=
search, 17
> Use of uninitialized value $u in substitution (s///) at /usr/lib64/pe=
rl5/vendor_perl/5.20.2/Git/SVN.pm line 101.
> Use of uninitialized value $u in concatenation (.) or string at /usr/=
lib64/perl5/vendor_perl/5.20.2/Git/SVN.pm line 101.
> refs/remotes/origin/trunk: 'svn://svn.code.sf.net/p/scaffoldhunter/co=
de' not found in ''
>=20
> One problem I am seeing in the SVN repo is, that between the revision=
s 97 and 102 the trunk folder was absent. the old one was moved to some=
 subfolder and a new one was created. Therefore, I started the cloning =
beginning with rev 102 using the command line option "-r102:HEAD". Howe=
ver, the same error occurred for some later tag (the first tag after re=
v 102).=20
>=20
> Found possible branch point: svn://svn.code.sf.net/p/scaffoldhunter/c=
ode/trunk =3D> svn://svn.code.sf.net/p/scaffoldhunter/code/tags/release=
-2.0, 1565
> Use of uninitialized value $u in substitution (s///) at /usr/lib64/pe=
rl5/vendor_perl/5.20.2/Git/SVN.pm line 101.
> Use of uninitialized value $u in concatenation (.) or string at /usr/=
lib64/perl5/vendor_perl/5.20.2/Git/SVN.pm line 101.
> refs/remotes/origin/trunk: 'svn://svn.code.sf.net/p/scaffoldhunter/co=
de' not found in ''
>=20
> I would be very glad if someone has a hint about what is going wrong =
here. Is this a bug in git or is something wrong with the SVN repo?

The layout change (no root) certainly doesn't help. We shouldn't crash,
though.

> used software versions:=20
> - git 2.5.0=20
> - subversion 1.8.14

The conversion goes through for me with (your other options and) your
authors file and specifying a stupid authors prog:

--->8---
#!/bin/sh
grep "$1" /tmp/t/authors | head -n 1 | cut -d'=3D' -f2 | cut -c'2-'
--->8---

and:

git version 2.6.0.rc0.178.g4177fa5
svn, Version 1.8.13 (r1667537)

with our without --authors-file...

(It went also through with a patched git-svn and just the authors file.=
)

I don't think git-svn has changed since git 2.5.0. Maybe you can
downgrade svn for the one-shot conversion? I don't see anything
suspicious in their changelog but don't remember it as being overly
complete.

git svn served us well in making itself mostly obsolete. The downside i=
s
that not many are using it any more. Keeping up with subversion changes
(to keep git svn working) has become more and more difficult.

Michael
