From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: having to pull twice
Date: Thu, 25 Sep 2008 09:05:02 +0200
Message-ID: <200809250905.09646.trast@student.ethz.ch>
References: <fb6605670809241758r186eef51sc6ed6d334a64495d@mail.gmail.com> <20080925010150.GI3669@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart37043768.MSVfgjv1H9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "Michael P. Soulier" <msoulier@digitaltorque.ca>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Sep 25 09:15:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kil46-00057g-4I
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 09:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbYIYHN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 03:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752364AbYIYHN5
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 03:13:57 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:40804 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752047AbYIYHN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 03:13:56 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 25 Sep 2008 09:13:55 +0200
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 25 Sep 2008 09:13:55 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20080925010150.GI3669@spearce.org>
X-OriginalArrivalTime: 25 Sep 2008 07:13:55.0053 (UTC) FILETIME=[454591D0:01C91EDE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96729>

--nextPart37043768.MSVfgjv1H9
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Shawn O. Pearce wrote:
> "Michael P. Soulier" <msoulier@digitaltorque.ca> wrote:
> > I'm finding this happening from time to time.
> >=20
> > soulierm@espresso:~/work/mitel-msl-tug$ git pull
> ...
> > error: Entry 'mitel-msl-tug.spec' not uptodate. Cannot merge.
[fixed by 'git status's index refresh]
>=20
> Time or dev/ino skew in the index file vs. what we read from stat.
>=20
> Running git-status rematched the index file to the working directory,
> and during that rematch it noticed the file wasn't actually modified.

This keeps coming up every week or so... maybe git-merge should
attempt to refresh the index automatically?  Of course it's an
expensive operation, but if you really want to do the merge you have
to bite that bullet anyway.

Unfortunately I can't see an obvious place to do that---the above
message comes from unpack-trees.c, where changes would also affect
e.g. checkout.

On the other hand, as near as I can tell this is a regression in
builtin-merge.  Miklos, do you know if/how this can be fixed?

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch



--nextPart37043768.MSVfgjv1H9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjbOCUACgkQqUud07tmzP1CeACfes8lBXSTlXAktfFL6PTO4stZ
kcsAnjaTxTQc/EBi5ieDY36zYT4LDsk2
=5g3d
-----END PGP SIGNATURE-----

--nextPart37043768.MSVfgjv1H9--
