From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: git-svn and mergeinfo
Date: Tue, 06 Sep 2011 14:56:38 +0200
Message-ID: <1315313800.9839.10.camel@bee.lab.cmartin.tk>
References: <20110829132052.0ad7a088@robyn.woti.com>
	 <4E5F4987.5040205@alum.mit.edu> <20110901104327.14d4dba6@robyn.woti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-keyZjQtirP1CovpChyOs"
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Bryan Jacobs <bjacobs@woti.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 14:56:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0vCt-0000CZ-4d
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 14:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754280Ab1IFM4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 08:56:43 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:43317 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754266Ab1IFM4m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 08:56:42 -0400
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 509B746170;
	Tue,  6 Sep 2011 14:56:25 +0200 (CEST)
In-Reply-To: <20110901104327.14d4dba6@robyn.woti.com>
X-Mailer: Evolution 3.0.3- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180798>


--=-keyZjQtirP1CovpChyOs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2011-09-01 at 10:43 -0400, Bryan Jacobs wrote:
> On Thu, 01 Sep 2011 10:59:51 +0200
> Michael Haggerty <mhagger@alum.mit.edu> wrote:
>=20
> > On 08/29/2011 07:20 PM, Bryan Jacobs wrote:
> > > I have been (ab)using git-svn for committing to a central SVN
> > > repository while doing my work locally with git. To this end, I've
> > > written a set of scripts and hooks which perform squash merges
> > > locally and then dcommit them with proper svn:mergeinfo
> > > annotations. The final result is the perfect appearance of having
> > > done a native SVN merge in the central repository, while using only
> > > local git commands and gaining the full benefit of git's conflict
> > > resolution and developer convenience.
> > >=20
> > > However, to make this work with git 1.7.6, I needed to make *one*
> > > change to the git internals: --merge-info does not allow setting
> > > mergeinfo for more than one branch. Because it's a complete
> > > overwrite operation instead of an update, this is a serious issue
> > > preventing its use for nontrivial branches.
> > >=20
> > > Might I suggest adding a block like the following around line 552 of
> > > git-svn?
> > >=20
> > >     if (defined($_merge_info))
> > >     { =20
> > >         $_merge_info =3D~ tr{ }{\n};
> > >     }
> >=20
> > Naive question: why can't you pass a newline (properly quoted, of
> > course) directly within the string argument to the --mergeinfo option?
>=20
> The only way I know of to do that in bash is to assign the
> newline-bearing string to a variable, and then use the variable in a
> command line option. Extremely awkward.

You can also save the mergeinfo to a file, add the line, and use
--mergeinfo=3D$(cat /tmp/some-file) to set it. It is indeed awkward, but
blindly replacing every space with a newline is not always the right
option. If a merged directory contains a space, this change will break
the mergeinfo, even if you're properly quoting your variable or using
the $(cat /some/file) method.

Cheers,
   cmn

--=-keyZjQtirP1CovpChyOs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOZhiGAAoJEHKRP1jG7ZzTjxoH/0e5UGB1ldmmot7RR2W1EiUJ
s2X8ta1/ldeOqSH/rvgAFQfFURuDB3DL52adCnOXfbutT/uT16eOzi2sMX5HN4vQ
UsPJrg6honFI4onqbkmHvV7p4GA6SEItbeg9XFJoqygSUJ9h5hSH0+F+zNeN/tuj
JTAXEbj5IxARUA6vgxCPhIESw7cSx1BmWB972nX/nuteVSLjErfuSC/TIBTppHaw
GatNvnIzs5oA/g5qcZXJ1ot7e4/AZia7hwzIH2QFB9tAbPEfQn3+m5mjz7nmfduF
n1oemlTCPpAxNyScKuLD7RUVUL/6dKP4LCOWvZwbG+EtlrxrvIjmSFZ4Y7kL8RQ=
=buqJ
-----END PGP SIGNATURE-----

--=-keyZjQtirP1CovpChyOs--
