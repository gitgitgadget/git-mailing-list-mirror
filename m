From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: mark parsing in fast-import
Date: Mon, 21 Apr 2008 10:41:51 +0200
Message-ID: <20080421084151.GA31344@alea.gnuu.de>
References: <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de> <1208169584-15931-1-git-send-email-joerg@alea.gnuu.de> <20080414232958.GE20979@spearce.org> <20080420234438.GC12865@alea.gnuu.de> <20080421002626.GJ29771@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Apr 21 11:51:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnsgS-0004Fa-Be
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 11:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754287AbYDUJut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 05:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754658AbYDUJut
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 05:50:49 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:4908 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754284AbYDUJut (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 05:50:49 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 49E364880A7; Mon, 21 Apr 2008 11:50:46 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jnrax-0001lo-UC; Mon, 21 Apr 2008 10:41:52 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jnrax-00089j-Ks; Mon, 21 Apr 2008 10:41:51 +0200
Content-Disposition: inline
In-Reply-To: <20080421002626.GJ29771@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80017>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

Shawn O. Pearce schrieb am Sun 20. Apr, 20:26 (-0400):
> Jrg Sommer <joerg@alea.gnuu.de> wrote:
> > +static inline int parse_mark(const const char *str, uintmax_t* mark,

Is inline okay?

> > +	char **after_mark)
> > +{
> > +	if (!str || str[0] !=3D ':' || !isdigit(str[1]))
> > +		return 1;
> > +
> > +	char *am;
>=20
> Although we conform to mostly C99 style, variables should be
> declared at the top of the scope and not after a statement.

Changed.

> >  static void cmd_mark(void)
> >  {
> > -	if (!prefixcmp(command_buf.buf, "mark :")) {
> > -		next_mark =3D strtoumax(command_buf.buf + 6, NULL, 10);
> > +	uintmax_t mark =3D 0;
> > +	char *after_mark =3D NULL;
> > +
> > +	if (!prefixcmp(command_buf.buf, "mark ") &&
> > +		parse_mark(&command_buf.buf[5], &mark, &after_mark) &&
>=20
> Hmm.  Shouldn't this be ! parse_mark given that it returns 0
> on success and 1 on failure?

Yes, you're right. I've checked some other functions and found this
behaviour. Can I use a different behabiour, i.e. return 0 on failure and
!0 on success?

Bye, J=C3=B6rg.
--=20
=E2=80=9EWer im Usenet gelesen werden will, sollte leserorientiert schreibe=
n. Wer nur
 f=C3=BCr sich schreiben will, dem ist mit einem Tagebuch vielleicht besser
 geholfen. Gelesen zu werden ist kein Recht, sondern ein Privileg.=E2=80=9C
     Thore Tams in <90tfv8$49b$1@keks.kruemel.dyndns.org>

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIDFNPwe0mZwH1VIARAiNzAJ9MLiWoALeupUi9WiXZY1LSMelZ7QCggeE9
b3RrZJKj30TqioapETE05ao=
=UXq6
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
