From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [BUG?] git fetch -p -t prunes all non-tag refs
Date: Tue, 27 Sep 2011 01:28:09 +0200
Message-ID: <1317079692.5579.19.camel@centaur.lab.cmartin.tk>
References: <20110926184739.GA11745@erythro.kitwarein.com>
	 <7vehz30wdy.fsf@alter.siamese.dyndns.org>
	 <1317078667.5579.13.camel@centaur.lab.cmartin.tk>
	 <7v1uv228t4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-LKSk7RnQP3bSdattKcLw"
Cc: mathstuf@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 01:28:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8Kav-0004ok-EG
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 01:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752978Ab1IZX2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 19:28:13 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:35754 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752836Ab1IZX2M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 19:28:12 -0400
Received: from [192.168.1.17] (brln-4db9fe34.pool.mediaWays.net [77.185.254.52])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 06A1446180;
	Tue, 27 Sep 2011 01:27:49 +0200 (CEST)
In-Reply-To: <7v1uv228t4.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.0.3- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182190>


--=-LKSk7RnQP3bSdattKcLw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2011-09-26 at 16:16 -0700, Junio C Hamano wrote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> > On Mon, 2011-09-26 at 15:30 -0700, Junio C Hamano wrote:
> >> Ben Boeckel <mathstuf@gmail.com> writes:
> >>=20
> >> > When the --prune and --tags options are given to git fetch together,=
 all
> >> > non-tag refs are pruned because only tags are looked at and when pru=
ning
> >> > it appears as if the branches have disappeared and are therefore del=
eted
> >> > locally.
> >>=20
> >> I would call that a bug, and it is not limited to the use of "--tags".=
 For
> >> example, I suspect that
> >>=20
> >>     $ git fetch --prune origin refs/heads/master:refs/remotes/origin/m=
aster
> >>=20
> >> would prune remote tracking branches for "origin" other than "master".
> >
> > This should fix it (in a way). Let's agree that it's a bad idea and
> > complain to the user.
>=20
> That might be a reasonable short-term safety measure, but in the longer

Sure.

> term I think we should fix it properly. We are already learning "what are
> the refs the remote side currently has" from the transport and the right
> fix ought to be to use that original information, not the version filtere=
d
> for the use of the primary objective of fetch, which is to only fetch wha=
t
> the user asked for.

Do you mean that we should ignore the refspec? Or do you mean that we
should look at the refspec if it exists, and only consider deleting
those that meet the refspec, so that `--prune --tags` would only delete
tags that don't exist in the remote?

Either way, it's a bit more complicated than a two-liner and it's too
late in my timezone for that. I'll try to see if I can do it in the next
few days.

   cmn

--=-LKSk7RnQP3bSdattKcLw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOgQqJAAoJEHKRP1jG7ZzTlucIAI5zkdpsrEuQRbuLA41l5A9R
b6E+4sEa9+/V3bOrM9w9jjBC4hYattevyxR/zl3DC/4+bAk0n0YdF1WH+Ux1jj3x
gJMBn/gFbqNOaW4N4AG0bWRa/v2ZbfgU8C1V1oiNqX/LoBmp3Tr1YO3LAnAos73k
zpv15gylGsRrroqObAMGM/qui5WRMkEzdAdeG7U+v5nd2qwOQzkYgFolf5O35Nyw
wcTKxFKE7vTD+swJPaMp2K650VMWZhJTGGN8fxHTAxoTNHNZPGqFaZ/kaQwLnLwb
+G4W7NFVrWjlvhT/db1q1qYAOeP4/4s3SQEKzuZjpa93k97nKb/g8PahQ551GYA=
=h+Pm
-----END PGP SIGNATURE-----

--=-LKSk7RnQP3bSdattKcLw--
