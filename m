From: Joey Hess <joey@kitenet.net>
Subject: Re: hooks that do not consume stdin sometimes crash git with SIGPIPE
Date: Mon, 5 Dec 2011 23:11:28 -0400
Message-ID: <20111206031128.GB25805@gnu.kitenet.net>
References: <20110829203107.GA4946@gnu.kitenet.net>
 <20111205192930.GA32463@gnu.kitenet.net>
 <7vmxb6iim0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Cc: git@vger.kernel.org, Lars Wirzenius <liw@liw.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 04:11:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXlRU-0003n6-5f
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 04:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932859Ab1LFDLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Dec 2011 22:11:35 -0500
Received: from wren.kitenet.net ([80.68.85.49]:46510 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756393Ab1LFDLe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2011 22:11:34 -0500
Received: from gnu.kitenet.net (dialup-4.154.6.232.Dial1.Atlanta1.Level3.net [4.154.6.232])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id EF750132896;
	Mon,  5 Dec 2011 22:11:32 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id B32D343D9A; Mon,  5 Dec 2011 22:11:28 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vmxb6iim0.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186308>


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Why do you have a hook that is expected to read from receive-pack that
> does _not_ read anything from it in the first place? If you do not care
> about the update status given to pre-receive, shouldn't you be using the
> update hook and ignoring the command line parameters instead?

My hook *does* consume the stdin in one case, but in another case it
does no checks and so can immediately exit.=20

Also, I didn't want it to be run once per updated ref as the update hook
is, since the tests it performs are rather expensive -- loading a perl
wiki engine in order to check that the changeset contains only changes to
wiki pages that are allowed based on the wiki's configuration.

--=20
see shy jo

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIUAwUBTt2H4MkQ2SIlEuPHAQi3Tg/4gmQ3KXVvM+MeaH0cSujux/5usUzK+jVF
hNFNFfJHfeBaQhnKq5JNJrKBc0jwgCfhmPJXrcuY6sp1k2Maqzam0epZirbSBAAp
uP2SbZgDXyLcRDkh+dbon8Jgamcp/KKWfESMv8FV8QTBYORC3d8I3790doJmMtOA
Mu7TXTMiSAN4O0LVw0Kw5IITUTjDbMN9Fs5BTw8DhKpm8bJmrmV5088wRqrx9eGQ
fNNiFXxpUZGl2XqsXKWNpSO7PWk6bCiOUYmeAuOF/UpuJ1fB1wrnd82kD3fbgKI/
jXNoN66OfLyKIcIo2qIi1gJtQHJ3akahxIcXO01cMV8n+52u2vngi8k56JXzSs72
X2XKMWfqTqXMfmsmKisorC1Z4dGP6DhSOcibjrB6C5sq9OuWu64wGxVPely44f1N
XzNmPObXYGqgxck3WUO14xsd2VpPj9f/YkVNAsRViPQyNhoMM/22jpQsFIilrZc7
xEJVv/1FXgCPlAlNxrmpEy8Sl8iOh5TOKrLSpNGFrp8t3KBZ5g7amnnXRtKvpMsB
0Ha7EhGaeESgApKqCZhkhL3X2L0JgH/51w0XYlfRgrgQz7CDSC5wxynssaNjKeiH
QLjJhdBjbwgq0wfJkxtbxnTR1hSUKlX1oQTtHTMgMQqOpPGN0Vi9/4Bm8+00sMMt
qrN+5BBLWg==
=pnW7
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
