From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH v2 11/11] filter-branch: learn how to filter notes
Date: Thu, 18 Feb 2010 00:06:32 +0100
Message-ID: <201002180006.36749.trast@student.ethz.ch>
References: <cover.1266361759.git.trast@student.ethz.ch> <a1bdef42de198dec4ec59c0d2b8b67e8656192d1.1266361759.git.trast@student.ethz.ch> <4B7C4A9E.9030906@kdbg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3267163.MCLVsHf5fj";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Johan Herland <johan@herland.net>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Feb 18 00:07:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhsz8-0006qM-DF
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 00:07:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757711Ab0BQXHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 18:07:04 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:47875 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757426Ab0BQXHA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 18:07:00 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Thu, 18 Feb
 2010 00:06:59 +0100
Received: from thomas.localnet (84.74.100.59) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Thu, 18 Feb
 2010 00:06:36 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <4B7C4A9E.9030906@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140268>

--nextPart3267163.MCLVsHf5fj
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 17 February 2010 20:59:26 Johannes Sixt wrote:
> I think that this form of --notes-filter is not flexible enough.
>=20
> 1. There is no possibility for the filter to decide whether the note=20
> should be attached to the rewritten commit or not.

That's not 100% correct, but it's not your fault for not knowing: if
you add an empty note, that's the same as removing it.

> 2. The implementation is not concerned about different notes namespaces=20
> (IIUC).
>=20
> 3. There is probably more.
>=20
> One use-case that comes to mind is to move notes from one particular=20
> namespace to a different one (and I mean move, not just copy). Don't know=
=20
> if 'git notes' itself has such a feature.
>=20
> I am not a 'git notes' user at this time, nor do I know anything about th=
e=20
> implementation, nor did I follow any discussions about notes, hence, I'm=
=20
> not in the position to judge what --notes-filter could be useful
> for.

I'm currently leaning towards declaring this the realm of
=2D-post-rewrite, not --notes-filter.  I'm not saying that the former is
the perfect / most convenient format in which such a hook could be
specified, but I believe its input should just be pre and post rewrite
sha1.  Using it to move notes, or whatever, should be up to the user.

That's not to say that there shouldn't be some convenient interface to
manage several notes trees, which I'm not yet clear on.

> I know I talked you into implementing it, but that is just because I disl=
ike=20
> that filter-branch calls a post-rewrite hook (that just doesn't sound=20
> right to me, given the one-shot nature of filter-branch), and your=20
> intention obviously was to transfer notes.

No (as I said in the original series leader) my original motivation
was to have a hook that can record the pre-write sha1 in a note on the
rewritten commit.  I noticed that it could also be used to transfer
the notes to the rewritten commit, which was part of the reason why I
implemented it.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart3267163.MCLVsHf5fj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEABECAAYFAkt8dnwACgkQqUud07tmzP1HMQCgl4kJNHEembCjwO1oSsBnVLCv
X0cAnj+22HLnVuEK80uGs/IRyJl+z/ZR
=qqUP
-----END PGP SIGNATURE-----

--nextPart3267163.MCLVsHf5fj--
