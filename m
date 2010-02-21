From: Jelmer Vernooij <jelmer@samba.org>
Subject: Re: Storing (hidden) per-commit metadata
Date: Sun, 21 Feb 2010 13:17:26 +0100
Message-ID: <1266754646.12035.23.camel@ganieda>
References: <1266599485.29753.54.camel@ganieda>
	 <1266687636-sup-7641@ben-laptop>
	 <32541b131002201057t31fc8a6aydb0942171fe1b8c8@mail.gmail.com>
	 <20100221063433.GA2840@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Y6VCFR51pFaPkTS7Tmik"
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Ben Gamari <bgamari@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 21 13:39:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjAkn-0000za-VV
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 13:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975Ab0BUMRb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 07:17:31 -0500
Received: from gwenhwyvar.vernstok.nl ([92.243.4.181]:33793 "EHLO
	gwenhwyvar.vernstok.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904Ab0BUMRa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 07:17:30 -0500
Received: from ganieda (localhost [127.0.0.1])
	by gwenhwyvar.vernstok.nl (Postfix) with ESMTP id 5FDA3265F8;
	Sun, 21 Feb 2010 12:18:51 +0000 (UTC)
Received: by ganieda (Postfix, from userid 1000)
	id 80D5314BBFF; Sun, 21 Feb 2010 13:17:27 +0100 (CET)
In-Reply-To: <20100221063433.GA2840@coredump.intra.peff.net>
X-Mailer: Evolution 2.28.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140611>


--=-Y6VCFR51pFaPkTS7Tmik
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

--=-Y6VCFR51pFaPkTS7Tmik
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABAgAGBQJLgSRVAAoJEACAbyvXKaRXR2cP/jkboCooZGSBBCwqbMdRBFD2
AJQUPd8F7xu4NCBGVxFu/Wq1ZXxspkjN9bkQLU14abyn+XJUFD7IDOjL5K/o0c5d
bKL9f1exxEq4MP+hpOA9UX/Lrm4Aoywn4fFeARGcut9t98pzxwKq98NYBKFIf5tC
UqtKDYQQBOtS4V7HDrE3RxHnZiJTHjEF1GitNA9FMD8F02TWhTMF4d/79+HMYHMf
ejYCp2IblDnt+4BMPGiJEZRPJOYVlYlnxKx8dFR16tYFd5eIFgqlNy/45hOhDo04
vYqGbGQyuCIaHcKKYmbkKNdksRkJ5oYo4HI0IeYNvuhEHwvWuMd35xh5pMd67Xc7
v3jw4SwE0rrdM6JoXLdijWVJ6k0t/dT1GEu0ZmmG02xeYHFFS3KE6Wc6SN7+VTLb
3KGQ25aAwASQnqFbeNxepnw20krhbIL0C0h7qn2ohw0e9rx7wwFKdS9s1pIPf4g9
caEHypW2JwLVTtnr4jccb1b8P4j4Lb0lqvhT363XvNg5UUMvadvq2TwEE24+A7os
JWUtnnWN51ZPgUg/Ug3qvtt2czWpWv7EdAUgw0E+4+7yT7w58ggHXgWdYe7cdSrr
sVrI05/VSGd+mCgmUQf4yhtcEWfD1iriAMloUwHED2i1OEbcKKw5RAuHO4zsdO9g
8sHtYgvMYHW7XPNcPUW/
=pJUc
-----END PGP SIGNATURE-----

--=-Y6VCFR51pFaPkTS7Tmik--
