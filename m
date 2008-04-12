From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH/RFC 02/10] Teach rebase interactive the reset command
Date: Sat, 12 Apr 2008 11:37:44 +0200
Message-ID: <20080412093744.GC31356@alea.gnuu.de>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org> <1207785521-27742-1-git-send-email-joerg@alea.gnuu.de> <1207785521-27742-2-git-send-email-joerg@alea.gnuu.de> <1207785521-27742-3-git-send-email-joerg@alea.gnuu.de> <7viqyondyn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 12:21:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkcrG-0003Fp-FZ
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 12:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756960AbYDLKUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 06:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757390AbYDLKUP
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 06:20:15 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:4685 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756457AbYDLKUN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 06:20:13 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id B7CD7488054; Sat, 12 Apr 2008 12:20:10 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JkcB7-0000n2-2a; Sat, 12 Apr 2008 11:37:45 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JkcB6-0008J4-Qv; Sat, 12 Apr 2008 11:37:44 +0200
Content-Disposition: inline
In-Reply-To: <7viqyondyn.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79346>


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Junio,

Junio C Hamano schrieb am Fri 11. Apr, 16:56 (-0700):
> J=F6rg Sommer <joerg@alea.gnuu.de> writes:
>=20
> > ---
> >  git-rebase--interactive.sh    |   20 ++++++++++++++++++++
> >  t/t3404-rebase-interactive.sh |   10 ++++++++++
> >  2 files changed, 30 insertions(+), 0 deletions(-)
> >
> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > index b001ddf..7dac51b 100755
> > --- a/git-rebase--interactive.sh
> > +++ b/git-rebase--interactive.sh

> > +			die "Invalid parent '$sha1' in $command $sha1 $rest"
> > +		output git reset --hard $tmp
>=20
> Could this step fail, and if it does what should happen?

I don't expect it. tmp is a valid sha1 and reset may fail if the working
directory is dirty, but then the previous command should have failed,
too. Do you think different?

> > @@ -569,6 +588,7 @@ do
> >  #  edit =3D use commit, but stop for amending
> >  #  squash =3D use commit, but meld into previous commit
> >  #  mark #NUM =3D mark the current HEAD for later reference
> > +#  reset #NUM|commit =3D reset HEAD to a previous set mark or a commit
>=20
> "to a previously set mark".  But I would say upfront "in the todo insn
> whenever you need to refer to a commit, in addition to
> the usual commit object name, you can use '#num' syntax to refer to a
> commit previously marked with the 'mark' insn."

Does this mean pick, edit and squash should understand marks, too? But
how useful is this? You can only set a mark if you've picked a commit and
using this commit again, e.g. pick it twice, doesn't sound useful.

--=20
$ cat /dev/random
#!/usr/bin/perl -WT
print "hello world\n";

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIAILowe0mZwH1VIARAjCRAJ4gm97DIL+IRjXTxax6WoGefsMTVgCgtLor
JC1KSHH4sCQbycKsJFzYwhw=
=CXGW
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
