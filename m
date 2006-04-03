From: Keith Packard <keithp@keithp.com>
Subject: Re: parsecvs tool now creates git repositories
Date: Mon, 03 Apr 2006 15:19:13 -0700
Message-ID: <1144102753.2303.121.camel@neko.keithp.com>
References: <1143956188.2303.39.camel@neko.keithp.com>
	 <20060402093906.GH1259@lug-owl.de> <20060402193144.GK1259@lug-owl.de>
	 <1144037456.2303.92.camel@neko.keithp.com>
	 <20060403072554.GN1259@lug-owl.de>
	 <1144083282.2303.102.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WeNCKBXvoVfZsKdp7705"
Cc: keithp@keithp.com, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 04 00:19:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQXOg-0002qQ-Bo
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 00:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbWDCWTj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 18:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751811AbWDCWTj
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 18:19:39 -0400
Received: from home.keithp.com ([63.227.221.253]:63502 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1751813AbWDCWTi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 18:19:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 6167E13001F;
	Mon,  3 Apr 2006 15:19:37 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 05026-01-5; Mon, 3 Apr 2006 15:19:37 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 27E4F13001E; Mon,  3 Apr 2006 15:19:37 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 2273A14001;
	Mon,  3 Apr 2006 15:19:37 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id C8837543DB; Mon,  3 Apr 2006 15:19:13 -0700 (PDT)
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
In-Reply-To: <1144083282.2303.102.camel@neko.keithp.com>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18354>


--=-WeNCKBXvoVfZsKdp7705
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-04-03 at 09:54 -0700, Keith Packard wrote:
> On Mon, 2006-04-03 at 09:25 +0200, Jan-Benedict Glaw wrote:
>=20
> > -YFLAGS=3D-d
> > +YFLAGS=3D-d -l
> > +LFLAGS=3D-l
>=20
> Works for me too; thanks for the fix.

Well, -l *kinda* works; it places a limit on the maximum token size.
And, unlike 'lex', 'flex' places all input into the token buffer, even
if handled outside the usual lexer loop. So, my external function that
sucked up file contents was losing.

I switched it over to doing one-at-a-time reads from the input file, now
the external data function can directly use stdio. This eliminates all
calls to 'input' and 'unput' which should make it work for everyone now.

flex -- it's like lex, except less flexible.

--=20
keith.packard@intel.com

--=-WeNCKBXvoVfZsKdp7705
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEMZ9hQp8BWwlsTdMRAregAJ0aiyg5LPDzHnSE4se7oOaGiYP45wCfYxFk
+0jAQrQmMUz1GZHxemaWHX4=
=fp6e
-----END PGP SIGNATURE-----

--=-WeNCKBXvoVfZsKdp7705--
