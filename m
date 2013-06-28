From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH] pull: require choice between rebase/merge on
 non-fast-forward pull
Date: Fri, 28 Jun 2013 08:28:34 -0400
Message-ID: <20130628122834.GH11985@odin.tremily.us>
References: <20130523164114.GV27005@serenity.lan>
 <7vbo81e7gs.fsf@alter.siamese.dyndns.org>
 <20130523215557.GX27005@serenity.lan>
 <7vli75cpom.fsf@alter.siamese.dyndns.org>
 <CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
 <7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
 <20130627201032.GF9999@odin.tremily.us> <vpq1u7magky.fsf@anie.imag.fr>
 <20130628090917.GG11985@odin.tremily.us> <vpqmwqa8nax.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/Gk0KcsbyUMelFU1"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	John Keeping <john@keeping.me.uk>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 28 15:28:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsYjD-0004lM-UZ
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 15:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819Ab3F1N2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 09:28:39 -0400
Received: from vms173007pub.verizon.net ([206.46.173.7]:42340 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257Ab3F1N2i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 09:28:38 -0400
X-Greylist: delayed 3602 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Jun 2013 09:28:38 EDT
Received: from odin.tremily.us ([unknown] [72.68.100.251])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MP300IBDRZMPN40@vms173007.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 28 Jun 2013 07:28:35 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 41655A71B5D; Fri,
 28 Jun 2013 08:28:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1372422514; bh=tdM1u30ENtObMWWnTeDgp+IdsImAlI3+7ckdFy7YIY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fk5l7/icSGqzPdtqdO6eWq+GJaXPLsZPz7AOLUoUjncV50UyeTr+mU7x/mE4ernzp
 881cBrM+9Zne9FS1biHuTfB69wRYv72PQuz1glri/qJCs/4xRy05gf/tMwsryMyJog
 m3Z+ZJApu9zF4GiNaaGsqe/+2KjW0sriyvypKjkQ=
Content-disposition: inline
In-reply-to: <vpqmwqa8nax.fsf@anie.imag.fr>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229197>


--/Gk0KcsbyUMelFU1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2013 at 01:52:38PM +0200, Matthieu Moy wrote:
> "W. Trevor King" <wking@tremily.us> writes:
> > I want the warning that they had not made the required config choice
> > between rebase/merge needed to handle a non-ff case, not the default
> > merge (or rebase) behavior.  The warning gives them a chance to
> > realize that this was not an appropriate time for a `svn update`
> > analog, and that the project may not to want to have the branches
> > joined at all ;).
>=20
> You're assuming that the config is not made, but this is supposed to
> happen once initially. Then, the user will chose either merge or rebase,
> and whatever is chosen, the result will be bad.

I'm hoping that reading the error message reminds them that these
cross-branch pulls are not recommended (for us), and that they skip
the configuration step (so they'll get the same warning after their
next subconcious pull).  Of course, there are no guarantees.  But if
they do configure their rebase/merge preference and make and push bad
merge, at least I'll have something I can suggest as a finger-breaker.

Of course, they should already be seeing their editor with a merge
commit message that they are ok-ing.  If that's not enough to make
them think twice, a warning that:

  The pull does not fast-forward; =E2=80=A6

may fall on deaf ears (blind eyes?).  However, for folks used to only
having a single branch, this may be enough of a jolt to wake them up.

I'm not making a very strong case, and this whole line of reasoning is
getting off topic for this PR.  Unless we adapt it to:

  pull.non-ff =3D {merge,rebase,never}

which is, I think, even less likely to land ;).

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--/Gk0KcsbyUMelFU1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRzYFwAAoJEKKfehoaNkbtdM8P/10dwupYR3NID/CAvysz5xo3
0xNO7M68DMmT3tHkHSbxp/OqwVgceY8WbR/wyqLxWihAtK98ay7ixwkW00G3mjSk
P1nau54tvlm+nfqwzajkAsUU27oxZ3whwOZxh6Ri0XuF1s7ZwmFYh1/VbR36E1rh
ID8ciAsNhsfH/b/j/nsQsRu/1M8JtpO5wYVBQ9eosn8AfzhkagUqj6N2CPFkTDZ1
pt89p3BTxWvQhl/PsoGDZcfABl596sH3EA8fuFdkiedtBRotCyj7YBtLF+OSbgNV
M4318ew7VkU6JckXdox6jas49ogVuLzTSLT0D4ltnrgwjb9ulZUEMG1zGUTTdDbL
JmkX1TA8i222AU3Lkx00VIYJLFKxX30sZjfCYZil7Z27mQMsE91qikVKJMLt+ni7
ClE/WCF+oOBCcyfXTZ9qzpgZEFZu3wz1Nti1tGWToJm5HdqjHbFOrb1c+In19xMz
FI7qy7B6impTPoOX7GH7REA2uleYtajGoQWSbfHbg1GHXNyJURG4QXRzeNlJnH34
J12qq+3ka9W/QvnZazsnD48/EOEsF61QMH+mAnNFjn2cR0zIENyFuAvjmLVcSpd2
umkHIAb+p3T2WUjv2wRG7wgZcymXI17PyH5bmcJuXwsoZ+jI8eVe8zLWH6yz9A6b
axQmKFUQNFgwIG7TmnbD
=X5a4
-----END PGP SIGNATURE-----

--/Gk0KcsbyUMelFU1--
