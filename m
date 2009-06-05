From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Best way to merge two repos with same content, differenthistory
Date: Fri, 5 Jun 2009 13:02:13 -0700
Message-ID: <robbat2-20090605T194802-473902673Z@orbis-terrarum.net>
References: <63BEA5E623E09F4D92233FB12A9F794303117DBF@emailmn.mqsoftware.com> <286817520906050953n1afed29cn6c85f219a0c9b8b5@mail.gmail.com> <63BEA5E623E09F4D92233FB12A9F794303117DC1@emailmn.mqsoftware.com> <robbat2-20090605T183716-227340397Z@orbis-terrarum.net> <63BEA5E623E09F4D92233FB12A9F794303117DCB@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gMR3gsNFwZpnI/Ts"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 22:02:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCfcl-0007u6-La
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 22:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbZFEUCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 16:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752056AbZFEUCT
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 16:02:19 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:55011 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751018AbZFEUCT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 16:02:19 -0400
Received: (qmail 17439 invoked from network); 5 Jun 2009 20:02:18 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Fri, 05 Jun 2009 20:02:18 +0000
Received: (qmail 19687 invoked by uid 10000); 5 Jun 2009 13:02:13 -0700
Content-Disposition: inline
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F794303117DCB@emailmn.mqsoftware.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120825>


--gMR3gsNFwZpnI/Ts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2009 at 02:06:25PM -0500, Kelly F. Hickel wrote:
> Robin,=20
> 	That's all good news, I have an 8 way box with 32gb of ram
> running a 64 bit Linux, a box with 4 gb of ram panics during the
> conversion.
Thanks for your data.

For comparison, our conversion box is also 8-way, but only 16GiB RAM.

I'm surprised at how long pass1 is for you, especially since you've got
a lot less CVS Files and CVS Revisions than the Gentoo repo (I do deduce
that your individual revisions are larger, averaging at 15KiB vs. our
711 bytes).

I think there's something odd in the total CVS branches/tags count
however, as the counts there imply an average of 67 branches and 173
tags per CVS revision. You might want to dig into that part manually and
see about it (not sure of your Python skills). That would probably cut
down both your pass1 and pass4 times significantly.

Hopefully mhagger will get the external blob stuff committed soon, I was
working on validating it's results.=20

In doing so discovered a testcase where RCSRevisionReader and
CVSRevisionReader gave different output themselves, the latter (which is
documented as more accurate otherwise) missing the contents of an entire
file. It's on the cvs2svn-dev mailing list now. Tracing that first,
thereafter comparing it to the new Git side.

> git repack -a -d -f --depth=3D4000 --window=3D4000 && git pack-refs --all
Did those extreme depth/window values actually help size much? The
Gentoo ones actually didn't improve significantly over depth=3Dwindow=3D50.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--gMR3gsNFwZpnI/Ts
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAkopecUACgkQPpIsIjIzwixvNwCg5gRbBOMnNZGdpI2xz71dpQkk
f18AoI+IgnvdUg9DJSY18FsfvELVvSkI
=Ym/w
-----END PGP SIGNATURE-----

--gMR3gsNFwZpnI/Ts--
