From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: User's mailing list? And multiple cherry pick
Date: Wed, 4 Jun 2008 10:00:17 +0200
Message-ID: <20080604080017.GB7752@leksak.fem-net>
References: <18c1e6480806032355q2002fe0ej1f37dbd7dbd4802b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Cc: git@vger.kernel.org
To: David <wizzardx@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 10:01:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3nwE-00074T-8s
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 10:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923AbYFDIAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 04:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752770AbYFDIAV
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 04:00:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:39760 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752566AbYFDIAT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 04:00:19 -0400
Received: (qmail invoked by alias); 04 Jun 2008 08:00:17 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp050) with SMTP; 04 Jun 2008 10:00:17 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18DoqdBZBEDxhRipHZPLQkIO7qpNQ54Y68xcneIgW
	dcAWiXvQNHJr/A
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K3nur-0003Jc-21; Wed, 04 Jun 2008 10:00:17 +0200
Content-Disposition: inline
In-Reply-To: <18c1e6480806032355q2002fe0ej1f37dbd7dbd4802b@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83756>


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> for C in $(git log --reverse <commit1>..<commit2> --pretty=3Dformat:%H);
> do git-cherry-pick $C; done
>=20
> Is there an easier syntax for doing this?

Put this into a script and you've got an easier syntax ;-)
But note that <commit1> does not get cherry-picked then.
Use <commit1>^..<commit2> (or $1^..$2).

Except if there's a conflict.

Well, though it is far from finished, you could fetch git-sequencer.sh[1]
 1. http://tinyurl.com/6xtdvl

chmod +x it and do

for C in $(git log --reverse <commit1>..<commit2> --pretty=3Dformat:%H);
do echo pick $C ; done >temporaryfile
/where/you/put/it/git-sequencer.sh temporaryfile

Hope I could help.

Regards,
  Stephan

--=20
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIRkuRbt3SB/zFBA8RAgJ+AKC0+dkqSpaGbxwnQ/goIsKY3c0exgCfUzuv
BPVQb2xXi+XE5OVoeNeDeAc=
=tOW4
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
