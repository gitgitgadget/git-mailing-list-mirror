From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: strange temporary pull-errors
Date: Sat, 23 Aug 2008 10:44:45 +0200
Message-ID: <200808231044.50797.trast@student.ethz.ch>
References: <20080822191324.GO10819@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart11409723.B9Khu6vYAA";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
X-From: git-owner@vger.kernel.org Sat Aug 23 10:45:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWokr-0007EB-32
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 10:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbYHWIos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 04:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbYHWIos
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 04:44:48 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:24631 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367AbYHWIoq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 04:44:46 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 23 Aug 2008 10:44:45 +0200
Received: from [192.168.0.8] ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 23 Aug 2008 10:44:44 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20080822191324.GO10819@cs-wsok.swansea.ac.uk>
X-OriginalArrivalTime: 23 Aug 2008 08:44:45.0013 (UTC) FILETIME=[7E11B850:01C904FC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93442>

--nextPart11409723.B9Khu6vYAA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Oliver Kullmann wrote:
>=20
> > git pull
[...]
> error: Entry 'Buildsystem/Configuration/Html/local_html.mak' not uptodate=
=2E Cannot merge.
[...]
> > git status
[...]
> nothing to commit (working directory clean)
> > git pull
[succeeds]
> There is nothing special going out, the simple pull should succeed, but
> I have to try several times; don't know whether the "git status" is
> instrumental here or not --- will try the next time.

Saying 'git status' refreshes the index.  If you have touched (updated
mtime) local_html.mak without making any changes, 'git merge' just
compared the mtime and considered the file changed.  But 'git status'
actually compares the contents and finds it has not been changed.  I
don't know whether 1.6 (most likely builtin-merge) changed behaviour
in this respect, maybe you could try with an older version too.

There are other cases where you need a refresh, for example if you
have made a copy of a git-tracked directory with 'cp -r'.

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch



--nextPart11409723.B9Khu6vYAA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkivzgIACgkQqUud07tmzP1fxQCfQJd52rIFIDZfYhvIgPVZz4qs
9FgAoIesTy4/+yJexTdKturLix2KXRfo
=5JdW
-----END PGP SIGNATURE-----

--nextPart11409723.B9Khu6vYAA--
