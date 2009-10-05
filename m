From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Can I retrieve changes from deleted stash?
Date: Mon, 5 Oct 2009 14:30:13 +0200
Message-ID: <200910051430.17559.trast@student.ethz.ch>
References: <c18a43e.55008170.4ac9e127.2a972@o2.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5106540.XqTUmJY9KP";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Daniel <mjucde@o2.pl>
X-From: git-owner@vger.kernel.org Mon Oct 05 14:33:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mumkj-0004jq-7d
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 14:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994AbZJEMbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 08:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752730AbZJEMbF
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 08:31:05 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:13002 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752702AbZJEMbE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 08:31:04 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.1.375.2; Mon, 5 Oct
 2009 14:30:32 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Mon, 5 Oct
 2009 14:30:15 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <c18a43e.55008170.4ac9e127.2a972@o2.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129558>

--nextPart5106540.XqTUmJY9KP
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Daniel wrote:
> I did:
>=20
> $ git stash
> $ git pop
>=20
> $ git checkout -- <modified files>
>=20
> Now I don't have changes I stashed. I guess the blobs with stashed
> files should be somewhere?  Is there any way I can get back my changes?
> I tried to use git-reflog, but I'm not sure how can I find the files
> I need.

The problem is that the stash itself is a reflog, so there is no extra
safety layer.

Recent versions of the git-stash(1) manpage[*] document a command that
helps find the stashes: if you do not explicitly name them, the they
will be called "WIP on <subject>" and can thus be found with

  git fsck --unreachable |
  grep commit | cut -d\  -f3 |
  xargs git log --merges --no-walk --grep=3DWIP


[*] you can find a bleeding edge version at

  http://www.kernel.org/pub/software/scm/git/docs/git-stash.html

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart5106540.XqTUmJY9KP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkrJ5tkACgkQqUud07tmzP1pBACfeHa3XD5ghxGfloYiglU5jfg/
buoAnRCl8xGvYEdCd/SVvtSm5dFnBWvX
=uO5W
-----END PGP SIGNATURE-----

--nextPart5106540.XqTUmJY9KP--
