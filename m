From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [PATCH] Remove more gcc extension usage.
Date: Sun, 9 Jul 2006 09:31:55 +0200
Message-ID: <20060709073155.GP22573@lug-owl.de>
References: <20060708183402.GA17644@spearce.org> <7vy7v4orpt.fsf@assigned-by-dhcp.cox.net> <20060708190327.GA17763@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UFMLoheMaWcIEZAi"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 09:32:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzTm3-0001B6-GA
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 09:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161114AbWGIHb6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 03:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWGIHb6
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 03:31:58 -0400
Received: from lug-owl.de ([195.71.106.12]:56530 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S932375AbWGIHb5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 03:31:57 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id C9BBCF0385; Sun,  9 Jul 2006 09:31:55 +0200 (CEST)
To: Shawn Pearce <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20060708190327.GA17763@spearce.org>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23527>


--UFMLoheMaWcIEZAi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-07-08 15:03:27 -0400, Shawn Pearce <spearce@spearce.org> wrote:
> Junio C Hamano <junkio@cox.net> wrote:
> > Shawn Pearce <spearce@spearce.org> writes:
> >=20
> > > Removing these last remaining extension uses allows GIT to compile
> > > with the Sun C compiler rather then gcc.  This can be handy when
> > > you are trying to compile GIT on a Solaris system that seems to
> > > have a total lack of GNU utilities.
> >=20
> > Two points.
> >=20
> >  - Aren't the constructs you ripped out not GCC extension,
> >    rather proper ISO C99?
>=20
> Hmm.  I'm not sure actually.  I don't do much C hacking these days
> so I haven't kept current with what C99 has and doesn't.  I just
> know that these small changes made the core plumbing build and run
> fine on Solaris with only GNU make being present.  I didn't even
> attempt to use the higher level Poreclainish shell script commands.

Yes, that's valid C99. So Sun ships a compiler conforming to old
standards only, or which is configured to do so.

> Monday I'll look to see if there's an option that can be given to
> the Solaris compiler to make it accept these constructs.  Maybe a
> simple CFLAGS change in my config.mak would resolve what this patch
> was trying to do.

Thanks.

> >  - Our Makefile is pretty GNU already.  I think people have
> >    pointed out and ripped out bashisms from our shell scripts,
> >    but I would not be surprised if the default Sun /bin/sh does
> >    not understand POSIXy features some of them use.
>=20
> I realize that.  Asking someone to compile GNU make in their home
> directory before they build GIT to their home directory isn't a
> big deal (took me all of 30 seconds to download the latest and
> ./configure&&make install it).  Asking someone to download and
> compile binutils and gcc because their local site manager won't
> install them for you is another matter entirely...

AFAIK, relying on the '#!/bin/sh' thing is, from the POSIX point of
view, just plain wrong. IIRC, the '#!' thing even doesn't need to be
implemented! POSIX tells you to call scripts with their interpreters,
for a reason. /bin/sh needn't be POSIX compliant, but the first shell
found in the $PATH has to. So for what it's worth, shell scripts
should be called like `sh foo.sh', and if we narrow to expect the `#!'
to work, we'd better call it like `#!/usr/bin/env sh' to get the $PATH
`sh' and not /bin/sh .

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--UFMLoheMaWcIEZAi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEsLDrHb1edYOZ4bsRAmdTAJ4jffoc6r9UwSARl3lQMPxFmIhq1wCfdNeE
4u0RV1ALrRwHgfGhhHyxGPo=
=TTY/
-----END PGP SIGNATURE-----

--UFMLoheMaWcIEZAi--
