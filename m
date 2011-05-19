From: Grant Limberg <glimberg@gmail.com>
Subject: [git-p4] Trouble importing all perforce branches into git repository
Date: Thu, 19 May 2011 12:31:54 -0700
Message-ID: <5A927B4F-7242-48AD-BC1C-BCA490A251C4@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-6--1038683625"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 21:32:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN8x6-0003ST-RV
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 21:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934410Ab1ESTcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 15:32:00 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42908 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933808Ab1ESTb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 15:31:59 -0400
Received: by iyb14 with SMTP id 14so2362961iyb.19
        for <git@vger.kernel.org>; Thu, 19 May 2011 12:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:content-type:content-transfer-encoding
         :subject:date:message-id:to:mime-version:x-pgp-agent:x-mailer;
        bh=ZjCr64NMCvpSHNzOePSfAHFF2VBOAHV00zLA0Votd/k=;
        b=lSQhZg3yJ/Pl3xqgtaMdDM1tk2xWvmHomrln5eim7yEZslL5zyAsPrABok6ICX6Vgv
         TCvHnx/rloEqsKaUKFBa1cDnuO4fI6HIYh7JVCmQbGp+uF4uyiQAkXa6k9y15dicoCJV
         o9g6gSDaVzFRvnSUWcbJgyH9lz2oNiYhw+j8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-pgp-agent:x-mailer;
        b=qIII/mT2ahYK36shAB9GdLwN2We9oaZEHekEBEZvGpzCb43th9isIIFix/JOyE85HW
         f7aSK0RZK/nK9Qe5v3shkQUyzSYJWBmNXBuQJLsshhl5B8PVYrFSgMLOrT/rufLHvMKy
         FzfYN6mN4orve6l4nB3VVLSGZJZ1Pq2TRApKI=
Received: by 10.42.141.195 with SMTP id p3mr3833126icu.429.1305833518473;
        Thu, 19 May 2011 12:31:58 -0700 (PDT)
Received: from [192.168.169.51] ([12.186.225.162])
        by mx.google.com with ESMTPS id f28sm1198940ibh.50.2011.05.19.12.31.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 May 2011 12:31:57 -0700 (PDT)
X-Pgp-Agent: GPGMail 1.3.3
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173996>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-6--1038683625
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=us-ascii

I'm trying to import a project from my company's Perforce depot into a =
git repository. I've been successful getting a single branch into a =
single git repo, but what I'd like to do is to pull in the entire =
project plus all branches, but I can't get it working correctly.

I have my .p4settings file:

> P4PORT=3Dperforce-server.local:1666
> P4USER=3Dmy.username
> P4CLIENT=3Dmy.clientspec.name

Clientspec is fairly simple:

> //project/... //my.clientspec.name/project/...
> -//project/External/... //my.clientspec.name/project/External/...

The second line is to exclude the external library binaries from the =
checkout.

I use the following command line to start git-p4 importing:

> git p4 clone --verbose --detect-branches --max-changes=3D100 =
//project/...@all
>=20
This goes through and checks all the branch names, etc, and attempts to =
import starting at the first commit (in this case its changelists 771 =
for this project).

> Importing from //project/...@all into project
> Initialized empty Git repository in =
/Users/grant/Development/git_test/project/.git/
> Reading pipe: git config git-p4.useclientspec
> Reading pipe: git config git-p4.user
> Reading pipe: git config git-p4.password
> Reading pipe: git config git-p4.port
> Reading pipe: git config git-p4.host
> Reading pipe: git config git-p4.client
> p4 -G branches
> Opening pipe: p4 -G branches
> p4 -G branch -o branch-1
> Opening pipe: p4 -G branch -o branch-1
> Reading pipe: git config --bool core.ignorecase
> p4 -G branch -o branch-2
> ...
> Opening pipe: p4 -G branch -o branch-n
> p4-git branches: []
> initial parents: {}

I'm not sure if p4-git branches, and initial parents are supposed to be =
empty here, but they are.

Finally we get to the point where it's about to start importing =
changelists into git and the following happens:

> Getting p4 changes for //project/...
> p4 changes //project/...
> Reading pipe: p4 changes //project/...
> p4 -G describe 771
> Opening pipe: p4 -G describe 771
> Importing revision 771 (1%)branch is MAIN
>=20
>     Importing new branch RCMerge/MAIN
> p4 changes //RCMerge/MAIN/...@1,770
> Reading pipe: p4 changes //RCMerge/MAIN/...@1,770
>=20
>     Resuming with change 771
> parent determined through known branches: Branch-foo
> looking for initial parent for refs/remotes/p4/project/MAIN; current =
parent is refs/remotes/p4/project/Branch-foo
> commit into refs/remotes/p4/project/MAIN
> parent refs/remotes/p4/project/Branch-foo
> p4 -G -x - print
> Opening pipe: p4 -G -x - print
> Glue/source/.empty
> fatal: Invalid ref name or SHA1 expression: =
refs/remotes/p4/project/Branch-foo
> fast-import: dumping crash report to .git/fast_import_crash_26002

Here's the file referenced above:

> fast-import crash report:
>     fast-import process: 26002
>     parent process     : 26000
>     at Thu May 19 11:51:54 2011
>=20
> fatal: Invalid ref name or SHA1 expression: =
refs/remotes/p4/project/Branch-foo
>=20
> Most Recent Commands Before Crash
> ---------------------------------
>   checkpoint
>   commit refs/remotes/p4/project/MAIN
>   committer Some User <some.user@domain.com> 1253574589 -0800
>   data <<EOT
> * from refs/remotes/p4/project/Branch-foo
>=20
> Active Branch LRU
> -----------------
>     active_branches =3D 0 cur, 5 max
>=20
>   pos  clock name
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Inactive Branches
> -----------------
> refs/remotes/p4/project/MAIN:
>   status      : dirty
>   tip commit  : 0000000000000000000000000000000000000000
>   old tree    : 0000000000000000000000000000000000000000
>   cur tree    : 0000000000000000000000000000000000000000
>   commit clock: 0
>   last pack   :=20
>=20
>=20
> Marks
> -----
>=20
> -------------------
> END OF CRASH REPORT

Now, being a perforce novice, I have no idea what this means and have no =
idea how to resolve this issue, or if its even possible. Has anyone run =
into a similar issue before? If so, how did you resolve it?


Grant Limberg
glimberg@gmail.com




--Apple-Mail-6--1038683625
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.17 (Darwin)
Comment: GPGTools - http://gpgtools.org

iQIcBAEBAgAGBQJN1XArAAoJEH+RGVrhASuPqDAP/1oxfyznBgcHeRwap23f/xJa
0/cmOveJ+kOYnCem3f4m2X0kGli1qm7gghboasSkyXZnwZvyvK72olbaJo5RUwJ9
SbRiEtM4Oqurx+k/C6QkLX5PJeMvUkSgLB/OsayY88jnNactke5dWYQmc9qvjIAX
ecVYP9ABErBYqk3+wyl6NHq3xtj7QKUxnlu1CWGgExZx6wdDNUubE89OJhRYShqO
h1vdKLm+YcSNxHIIbLtBi+1RpZ/K3x8TBfdoXU/z4Q2V+it8OoWRTFkOOhjEr1yx
dS7m5GWuQGIM4WVmSgxQWW+YlqAgZGY1/pI1A39m2zNFhLmw3oriMAogU/rxpKPK
gTdu+gEOkO0oidKa2nxAV5Ve4wQhTKZPoj5VGAoezXZAlGV3E/lh5FpG0J2U/JEJ
UtVfrXB56FC1nbQWo05BxGWQMdPA+v/jVgwstddFthZ2hOL67TyZNL5hFkNrXaE/
zVuHSz7BGyLb6rmRsXUQN76ewl+lZlwUZ1Q1sDPjtedBg7p3pCMPL2yOVrDBi72D
7f86p+evT1oKYPynuCcpP+knJV2qW96V4v37zl6GuAveqy2th+aK/mjEUTFOCN0i
BCasgzQjXQI/0269EKKG364ebrks39G7gtphy8fhSNr9jofACwZ7+WddklmyeOL6
tL4lT0RGowPq4IZVkRaD
=LiIb
-----END PGP SIGNATURE-----

--Apple-Mail-6--1038683625--
