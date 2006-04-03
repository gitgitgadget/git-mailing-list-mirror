From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: parsecvs tool now creates git repositories
Date: Mon, 3 Apr 2006 09:25:54 +0200
Message-ID: <20060403072554.GN1259@lug-owl.de>
References: <1143956188.2303.39.camel@neko.keithp.com> <20060402093906.GH1259@lug-owl.de> <20060402193144.GK1259@lug-owl.de> <1144037456.2303.92.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OQhbRXNHSL5w/5po"
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 03 09:26:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQJS2-0008KR-6W
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 09:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbWDCHZ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 03:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbWDCHZ6
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 03:25:58 -0400
Received: from lug-owl.de ([195.71.106.12]:24969 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751608AbWDCHZ6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 03:25:58 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id DE86EF0037; Mon,  3 Apr 2006 09:25:54 +0200 (CEST)
To: Keith Packard <keithp@keithp.com>
Content-Disposition: inline
In-Reply-To: <1144037456.2303.92.camel@neko.keithp.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18316>


--OQhbRXNHSL5w/5po
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-04-02 21:10:56 -0700, Keith Packard <keithp@keithp.com> wrote:
> On Sun, 2006-04-02 at 21:31 +0200, Jan-Benedict Glaw wrote:
> > lex.l: In function =E2=80=98parse_data=E2=80=99:
> > lex.l:90: error: =E2=80=98yytext_ptr=E2=80=99 undeclared (first use in =
this function)
> > lex.l:90: error: (Each undeclared identifier is reported only once
> > lex.l:90: error: for each function it appears in.)
> > make: *** [lex.o] Error 1
>=20
> I think this is a bug in your version of flex; I'm using standard lex
> conventions here. I don't know how to make it work for you.

It compiles for me with this patch (thanks to Linus for the hint):

diff --git a/Makefile b/Makefile
index 639353a..b8f5014 100644
--- a/Makefile
+++ b/Makefile
@@ -3,7 +3,8 @@ GCC_WARNINGS2=3D-Wmissing-prototypes -Wmis
 GCC_WARNINGS3=3D-Wnested-externs -fno-strict-aliasing
 GCC_WARNINGS=3D$(GCC_WARNINGS1) $(GCC_WARNINGS2) $(GCC_WARNINGS3)
 CFLAGS=3D-O0 -g $(GCC_WARNINGS)
-YFLAGS=3D-d
+YFLAGS=3D-d -l
+LFLAGS=3D-l
=20
 SRCS=3Dgram.y lex.l cvs.h parsecvs.c cvsutil.c revlist.c atom.c revcvs.c g=
it.c
=20

Would you please verify that it doesn't break things for you?

Thanks, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--OQhbRXNHSL5w/5po
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEMM4CHb1edYOZ4bsRAsg+AJ0R8e/i0PnVPwTrSZ0sfgBiB4L3eQCfc7FD
y01aq88oOnCq5MVbdfXNLyY=
=+sAo
-----END PGP SIGNATURE-----

--OQhbRXNHSL5w/5po--
