From: Jelmer Vernooij <jelmer@samba.org>
Subject: Re: Storing (hidden) per-commit metadata
Date: Mon, 22 Feb 2010 15:57:39 +0100
Message-ID: <1266850659.4575.156.camel@ganieda>
References: <1266599485.29753.54.camel@ganieda>
	 <1266687636-sup-7641@ben-laptop>
	 <32541b131002201057t31fc8a6aydb0942171fe1b8c8@mail.gmail.com>
	 <20100221063433.GA2840@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-fdNZdW4AICh5G4EaRRmM"
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Ben Gamari <bgamari@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 22 15:57:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjZjK-00014E-6h
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 15:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688Ab0BVO5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 09:57:44 -0500
Received: from gwenhwyvar.vernstok.nl ([92.243.4.181]:57416 "EHLO
	gwenhwyvar.vernstok.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534Ab0BVO5m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 09:57:42 -0500
Received: from ganieda (localhost [127.0.0.1])
	by gwenhwyvar.vernstok.nl (Postfix) with ESMTP id 8F4E7265F8;
	Mon, 22 Feb 2010 14:59:09 +0000 (UTC)
Received: by ganieda (Postfix, from userid 1000)
	id 9BFE140728; Mon, 22 Feb 2010 15:57:40 +0100 (CET)
In-Reply-To: <20100221063433.GA2840@coredump.intra.peff.net>
X-Mailer: Evolution 2.28.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140686>


--=-fdNZdW4AICh5G4EaRRmM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2010-02-21 at 01:34 -0500, Jeff King wrote:
> On Sat, Feb 20, 2010 at 01:57:31PM -0500, Avery Pennarun wrote:
> > As for git-notes, they sound like they would be useful for this sort
> > of thing.  I haven't tried them yet, but my understanding is that
> > notes anywhere other than the "default" notes ref are not shown in
> > commit messages, so you can use them for whatever you want.
> I would want to hear more about the actual data being stored. The
> strength of notes is that you can _change_ them after the commit has
> been created. And the price you pay is that they are more annoying to
> move around, because they are in a totally different ref.
>=20
> If this is data that is being generated at the time the commit is
> created and then set in stone, then it probably should be part of the
> commit object.
This data is supposed to be set in stone, since Bazaar revisions are
intended to be immutable, like Git commits are.

For each file we would need to store:

 * the Bazaar revision id
 * any Bazaar revision properties. This is typically a list of URLs of
bugs that were fixed, name of the branch the commit was on, any
additional parents, or anything arbitrary set by plugins (e.g. the
rebase plugin sets 'rebase-of' to the id of the original revision)
 * For each file that was added or moved around in the revision, a path
to fileid mapping
 * Optionally, a list of ghost parent ids and "unusual" revisions for
each file but these should be rare.

This is at least a couple of lines of data and in some cases a lot more.
I would rather avoid confronting git users who don't care about Bazaar
with it.

> If the only problem is that the data is ugly in "git show", then perhaps
> we need a "suppress these pseudo-headers" feature for showing logs. It
> keeps them easily available for inspection or for --grep, but most of
> the time you would not see them.
That seems like a sensible thing to do, and would work well for me.

Cheers,

Jelmer


--=-fdNZdW4AICh5G4EaRRmM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABAgAGBQJLgptiAAoJEACAbyvXKaRXSnEP/2mkyT/RgnTXidsxYoozmNOl
GgFweqfM5sgpg4bC5n1tT6VhDj8a3rVi+QzNN1XLS/zSdJe107zpw7DhA2MAGWMh
Y2MJVRWfHa9pwkBur94RxXnbW/z9jIF2EQBqCo2km7kmBG5R1pjLFBbEHHQHG1Kw
J4l+tdduPtxN8Heynyw/EypPiOBOza2uWaxTuhgXfNOYaBM+usIWUqQif5maf6sC
LeTm1A/olnAjEE789nFdKvFGWP0iLg0hs3uC+oWfUhswX7nd4vaavHMGJtWWthtt
q3OpvWMD0o/BlPuPAEianUFUNmc/GDsQS9kcJYHyXYWrXWjXDirAb8N9WmJcb0kI
bQb/HHNVpC8Tghp7Xe6ClmYA7XErcGyrlJDcwl07hBn0AE3YzDzDNJ128j4h0t6U
N7/V0+sMM9JwOGefaHrLwY5kMbJmRXfukik2qrMaTkRjhjnNvVrAIPRKKLzxNm6d
HBkGGE2SG8q6OD2j21X6g2CI1FNPhSSE2//KA1fnqdaZzu1xXdO8P1ir2z3yUbsT
SfDrhWopTSFsH4g8SsNksPNm0fNPiVTt/fKClh6JSjQnbZVuA3A4VbrPJYAcN38q
omc1L5vUBvo/AIL4QZVGwP6x85bQLgn7SuzwAsAQLYqyHCNnEE/VEz9n+sJwdYBU
sKNTdsyy7ugMmIXgoOHp
=7y8b
-----END PGP SIGNATURE-----

--=-fdNZdW4AICh5G4EaRRmM--
