From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH v2] hash binary sha1 into patch id
Date: Fri, 10 Sep 2010 10:16:26 +0200
Message-ID: <20100910081626.GA30507@localhost>
References: <20100813094027.GA20906@localhost>
 <20100813200031.GD2003@burratino>
 <20100813212331.GA24127@localhost>
 <20100813213726.GB2516@burratino>
 <20100813215801.GA24534@localhost>
 <20100815072043.GA368@localhost>
 <1284095850.1728.5.camel@n900.home.ru>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Fri Sep 10 10:16:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Otymd-00006S-Nz
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 10:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717Ab0IJIQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 04:16:11 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51614 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522Ab0IJIQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 04:16:09 -0400
Received: by bwz11 with SMTP id 11so1963096bwz.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 01:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=1hmErv4WbdND5croW6gSfdnVZnbDEOMr265qLaDmXus=;
        b=fGVAtwyc3djZsensCpWb1mdcCvzEH6BOU8b/4lL69J3Rh5Erow8ECmZejGN3yICu1y
         tPD7p+y2C/VhBwFLjuUIhGK/gWKDrcxav53dkWffNQqYgl/n+t6/lliP9fmHzo9ylYA4
         q98g3IhBvp8wfp05w0brKULx2j4XB+QaqLkBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=wXKGjjInWwYzLyu1u0nY3fQ0qOKci7Thuin79HWzrt+uSh9qFaJ/MLBNtW26Sm1C0l
         kRi8j+kx0jLjcNdPNVTYbE0OBmnUsav4X/d93ZwpkypLf3zGMePSJM3fiCfixv/ZkMjs
         bToyaqwRsqYtUgkgQ98d8Q5+bUFKvCm8ganqE=
Received: by 10.204.81.148 with SMTP id x20mr283750bkk.138.1284106567429;
        Fri, 10 Sep 2010 01:16:07 -0700 (PDT)
Received: from darc.lan (p549A39F7.dip.t-dialin.net [84.154.57.247])
        by mx.google.com with ESMTPS id f18sm1785178bkf.15.2010.09.10.01.16.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Sep 2010 01:16:06 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OtymY-0007y6-Vi; Fri, 10 Sep 2010 10:16:26 +0200
Content-Disposition: inline
In-Reply-To: <1284095850.1728.5.camel@n900.home.ru>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155922>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 10, 2010 at 09:17:30AM +0400, Marat Radchenko wrote:
>=20
> However, I can't say I'm completely satisfied with git rebase
> speed (I'd like it to be < 1 min). So, are there known
> performance hotspots in 'git rev-list --cherry-pick'/'git
> format-patch --ignore-if-in-upstream' (these are two flags have
> biggest impact on git rebase [-i] speed) or I should run some
> kind of profiles in order to determine what else could be
> improved?

git format-patch is still slow if you have large text files (>10000
lines). This patch only helps for binary files or files marked as
binary in .gitattributes. There is also a patch

 http://mid.gmane.org/645d8a9bf671937c1a6962b49cf1c512e0af0d82.1279008702.g=
it.git@drmicha.warpmail.net

to turn off patch ID computation entirely.

Other than that, I am not aware of performance issues with rebase
that would cause it to take more than a minute. Possibly you can
use 'perf' to profile your use case. I used it to test this patch
in the script below (pass -p to enable). But it's only testing
format-patch right now, so you would have to modify it to profile
rebase as a whole.

Clemens
---

#!/bin/bash

set -e

NLINES=3D50000
NRAND=3D32768
# probability of change in percent
CHG_PROB=3D30
perf=3D
while test $# -gt 0
do
	case $1 in
	-p)
		perf=3Dt
		;;
	-n)
		shift
		NLINES=3D$1
		;;
	*)
		break
		;;
	esac
	shift
done

if test $# -gt 0
then
	export PATH=3D"$1:$PATH"
	shift
fi

if test $# -gt 0
then
	echo "too many arguments" >&2
	exit 1
fi

dir=3D$(mktemp -d)

scramble()
{
	while read x
	do
		if test $RANDOM -lt $((($CHG_PROB * $NRAND)/100))
		then
			echo $RANDOM
		else
			echo "$x"
		fi
	done < "$1" > "$1.new"
	mv -f "$1.new" "$1"
}

run()
{
	echo \$ "$@"
	if test -n "$perf"
	then
		perf record -g -f "$@" >/dev/null
		perf report -g
	else
		time "$@" >/dev/null
	fi
}

cd "$dir"
git init -q

for i in $(seq $NLINES)
do
	echo $i
done > file
git add file
echo "file binary" >.gitattributes
git add .gitattributes
git commit -q -m initial
git branch other

scramble file
git add file
git commit -q -m 'change big file'

git checkout -q other
: >newfile
git add newfile
git commit -q -m 'add small file'

gfp=3D"git format-patch --stdout"

run $gfp master
run $gfp --ignore-if-in-upstream master

git cherry-pick master >/dev/null 2>&1

git checkout -q master
scramble file
git add file
git commit -q -m 'change big file again'

git checkout -q other^{}
run git rebase master
if test -n "$(git rev-list master...HEAD~)"
then
	echo "patch not identified" >&2
	exit 1
fi

git checkout -q -b squashed master
git reset -q --soft HEAD~2
git commit -q -m squashed
git checkout -q other^{}
if git rebase squashed >/dev/null
then
	echo "patch dropped" >&2
	exit 1
fi

cd - >/dev/null
rm -rf "$dir"

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMielaAAoJELKdZexG8uqM8QoIAJH7Peou0c9t2KFobVsHWBrW
KDbvASXDpCHUfKaWi4WIi9p1FmUz6xGxfpvPOH5v/G+bN4MwX9WrvYmGsiuRoRI3
u86coSpTfAai8/1Mv2BtJWrE0/y5cPL2YC+RmhUX9omSEYEve7WdJq9kvcSAkwpB
+dX1qxBb2vG8/BdGDHJad4G2LARWaMwlgv7bIqeUqAZRAgvyTjEQDpLEBkx35S/g
fmZUchuytTtBtioE2kZIMW3ow8O+oFwRhJ8iToAatGXFtZUYVq/E3BXLC9J0gmvX
GN2xB4OIKClnGqEIXWHwMPF8EfSXRdgKVniFjeDCIZWSWTY0dCFT8TPN3URxH04=
=7Sep
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
