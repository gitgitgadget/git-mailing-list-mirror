From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH] Have manpage reference new documentation on reverting merges.
Date: Sat, 20 Dec 2008 23:35:14 -0600
Message-ID: <200812202335.19006.bss@iguanasuicide.net>
References: <200812201832.48992.bss@iguanasuicide.net> <7vtz8ytft0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart23235527.9Rga1i86Rr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 21 06:36:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEGzT-0007Dp-Kw
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 06:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbYLUFfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 00:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbYLUFfF
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 00:35:05 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:54111 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbYLUFfD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 00:35:03 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.123])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LEGxx-0000ed-CJ; Sun, 21 Dec 2008 05:35:01 +0000
User-Agent: KMail/1.9.9
In-Reply-To: <7vtz8ytft0.fsf@gitster.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103687>

--nextPart23235527.9Rga1i86Rr
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 2008 December 20 20:36:43 Junio C Hamano wrote:
> "Boyd Stephen Smith Jr." <bss@iguanasuicide.net> writes:
> > ---
> > An example addition to the manpage for revert that references Nanako
> > Shiraishi's new documentation.
> >
> >  Documentation/git-revert.txt |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> >
> > diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
> > index caa0729..ea36bdf 100644
> > --- a/Documentation/git-revert.txt
> > +++ b/Documentation/git-revert.txt
> > @@ -45,6 +45,10 @@ OPTIONS
> >  	the mainline and allows revert to reverse the change
> >  	relative to the specified parent.
> >
> > +	Reverting a merge commit does not completely "undo" the effect of the
> > +	merge and it may make future merges more difficult.  For more details,
> > +	please read Documentation/howto/revert-a-faulty-merge.txt.
> > +
>
> I think these new lines need to be dedented, and the previous blank line
> should be turned into a line with a single '+'.

Can do.

> I'd also suggest removing "does not ... merge and it" from the above
> sentence to avoid confusing readers, because people who read only the
> above and do not read the howto document may get a wrong impression that
> the resulting tree may have some changes that came from the merge even
> after the revert, which is not the case.  Revert will erase the effect the
> merge had to your tree and that part is complete.

But that is not the whole effect of the merge.  The effect of the merge is=
=20
both the modifications it makes to the tree and the modifications it makes =
to=20
the history.

Going from the dictionary meaning for "revert", one might expect the those=
=20
effects to go away as well.  I think a warning that the revert subcommand=20
does not fully revert the merge is appropriate.

> Linus's "does not completely undo" only refers to the history part of the
> merge, and that only affects future re-merges from the same branch, which
> the reader who is interested in doing a revert of a merge right now (that
> is why s/he is reading this paragraph) may not yet care about.

They may not care about it now, but it doesn't make much sense to warn abou=
t=20
it during the later merge (plus it might be computationally expensive to=20
detect).

> An alternative is to give a complete but brief explanation.  Perhaps like
> this:
>
>     By reverting a merge, you are declaring that you will never want the
>     changes that were brought in by that merge you are reverting in your
>     tree.  If you do merge from the same branch again in the future after
>     it is updated, git remembers your declaration, and only the changes on
>     the branch that were made after the reverted merge will be brought in.
>     This may or may not be what you want.  See 'revert-a-faulty-merge'
>     HOWTO for more details.

I think the wording might need to be changed a little bit, but I do like th=
e=20
longer, more complete and clear explanation and I'll work on a patch that h=
as=20
one.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart23235527.9Rga1i86Rr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklN1ZYACgkQdNbfk+86fC0TRwCcCSz7B/n/70scXVXVk9bghtrP
rCYAnRiJzK3GYzsYGquezEdjk/bgnenx
=WqSp
-----END PGP SIGNATURE-----

--nextPart23235527.9Rga1i86Rr--
