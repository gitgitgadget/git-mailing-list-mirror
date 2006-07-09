From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [Patch] Using 'perl' in *.sh
Date: Sun, 9 Jul 2006 23:20:51 +0200
Message-ID: <20060709212051.GW22573@lug-owl.de>
References: <200607081732.04273.michal.rokos@nextsoft.cz> <20060709095114.GQ22573@lug-owl.de> <7vd5cfnkz4.fsf@assigned-by-dhcp.cox.net> <200607091441.16161.michal.rokos@nextsoft.cz> <7v4pxqfri7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ptMYGWplstB9CqWP"
Cc: Michal Rokos <michal.rokos@nextsoft.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 23:21:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fzgi0-0002c6-NH
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 23:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161161AbWGIVUx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 17:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161165AbWGIVUx
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 17:20:53 -0400
Received: from lug-owl.de ([195.71.106.12]:31408 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1161161AbWGIVUx (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 17:20:53 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id 8EBFEF038B; Sun,  9 Jul 2006 23:20:51 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4pxqfri7.fsf@assigned-by-dhcp.cox.net>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23564>


--ptMYGWplstB9CqWP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-07-09 13:33:04 -0700, Junio C Hamano <junkio@cox.net> wrote:
> Michal Rokos <michal.rokos@nextsoft.cz> writes:
> > On Sunday 09 July 2006 12:14, Junio C Hamano wrote:
> >> Michal, is there a reason you do not want to have the version of
> >> perl you teach git tools via #! lines with PERL_PATH on your $PATH?
> >
> > I have no problem with that. I can set $PATH.
> > But then I'd suggest to change magic #!
> > from #!/usr/bin/perl
> > to #!/usr/bin/env perl
> > for *.perl
> >
> > It that what you meant?
>=20
> No, that is not what I meant.

Though I think you actually should :-)

> Invocation of perl _in_ scripts can be controlled by user's
> PATH, but #! cannot be.  As Merlyn says 'env' is a nice hack,
> but we configure the scripts we install to have #!  pointing at
> the right interpreter as a more cleaner (than using 'env', that
> is) workaround anyway, so #! pointing at PERL_PATH and scripts
> relying on user's $PATH would be the right thing to do.

It's just a question of the target system, so: What is our target? If
we target a fairly recent Unix box, we'd put whatever a user asked for
into the shellbang, and hope that he properly sets $PATH.

If we try to aim at POSIX systems, then first of all, `env' isn't a
hack. It's specified i the POSIX documents, even argument passing is
given. (So if `#!/usr/bin/env perl -w' doesn't work on a HP-UX system,
that's simply broken wrt. POSIX.)

At the maximum, we'd allow the user to supply the location of `env' if
it's not /usr/bin/env, but I guess you'll find a hard time finding a
system where there's no /usr/bin/env...  The final killer would be to
explicitely mention the interpreter and install all scripts a-x to
force that :-)

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

--ptMYGWplstB9CqWP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEsXMzHb1edYOZ4bsRAsbUAKCH9j+fM8yuIocEPgHF4yshTGHwewCgh4nz
PsL1Z43g00rywYzddTNOwkA=
=i+KV
-----END PGP SIGNATURE-----

--ptMYGWplstB9CqWP--
